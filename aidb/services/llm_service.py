import json
import logging
import re
import traceback

from agent.common_react_agent import CommonReactAgent
from agent.deepagent.deep_research_agent import DeepAgent
from agent.excel.excel_agent import ExcelAgent
from agent.text2sql.text2_sql_agent import Text2SqlAgent
from common.exception import MyException
from constants.code_enum import DataTypeEnum, IntentEnum, SysCodeEnum
from services.user_service import decode_jwt_token

logger = logging.getLogger(__name__)


common_agent = CommonReactAgent()
sql_agent = Text2SqlAgent()
excel_agent = ExcelAgent()
deep_agent = DeepAgent()


class LLMRequest:
    """
    llm_request 操作服务类
    """

    def __init__(self):
        pass

    async def exec_query(self, res, req_obj=None, token=None):
        """

        :return:
        """
        # common_agent = CommonReactAgent()
        # sql_agent = Text2SqlAgent()
        # excel_agent = ExcelAgent()
        # deep_agent = DeepAgent()
        try:
            if req_obj is None:
                # 获取请求体内容 从res流对象获取request-body
                req_body_content = res.request.body
                # 将字节流解码为字符串
                body_str = req_body_content.decode("utf-8")

                req_obj = json.loads(body_str)

            logging.info(f"query param: {json.dumps(req_obj, ensure_ascii=False)}")

            # str(uuid.uuid4())
            chat_id = req_obj.get("chat_id")
            qa_type = req_obj.get("qa_type")
            # 自定义id
            uuid_str = req_obj.get("uuid")

            # 获取文件列表
            file_list = req_obj.get("file_list")
            datasource_id = req_obj.get("datasource_id")

            #  使用正则表达式移除所有空白字符（包括空格、制表符、换行符等）
            query = req_obj.get("query")
            # 仅对 FILEDATA_QA 和 REPORT_QA 使用清理后的查询，DATABASE_QA 和 COMMON_QA 使用原始查询
            cleaned_query = re.sub(r"\s+", "", query) if query else ""

            # 获取登录用户信息
            if token is None:
                token = res.request.headers.get("Authorization")
                if not token:
                    raise MyException(SysCodeEnum.c_401)
                if token.startswith("Bearer "):
                    token = token.split(" ")[1]

            # 调用智能体
            if qa_type == IntentEnum.COMMON_QA.value[0]:
                await common_agent.run_agent(
                    query, res, chat_id, uuid_str, token, file_list
                )
                return None
            elif qa_type == IntentEnum.DATABASE_QA.value[0]:
                # 权限检查已在接口层完成，这里直接调用 agent
                await sql_agent.run_agent(
                    query, res, chat_id, uuid_str, token, datasource_id
                )
                return None
            elif qa_type == IntentEnum.FILEDATA_QA.value[0]:
                await excel_agent.run_excel_agent(
                    cleaned_query, res, chat_id, uuid_str, token, file_list
                )
                return None
            elif qa_type == IntentEnum.REPORT_QA.value[0]:
                await deep_agent.run_agent(
                    cleaned_query,
                    res,
                    chat_id,
                    uuid_str,
                    token,
                    file_list,
                    datasource_id,
                )
                return None

        except Exception as e:
            logging.error(f"Error during get_answer: {e}")
            traceback.print_exception(e)
            return {"error": str(e)}
        finally:
            await self.res_end(res)

    @staticmethod
    async def res_end(res):
        """
        :param res:
        :return:
        """
        await res.write(
            "data:"
            + json.dumps(
                {
                    "data": "DONE",
                    "dataType": DataTypeEnum.STREAM_END.value[0],
                }
            )
            + "\n\n"
        )


async def stop_chat(request, task_id, qa_type) -> dict:
    """
    停止对话流输出

    :param task_id: 任务id。
    :param qa_type: 问答类型
    :param request
    :return: 返回服务器响应。
    """
    # 获取登录用户信息
    token = request.headers.get("Authorization")
    if not token:
        raise MyException(SysCodeEnum.c_401)
    if token.startswith("Bearer "):
        token = token.split(" ")[1]

    if qa_type == IntentEnum.COMMON_QA.value[0]:
        user_dict = await decode_jwt_token(token)
        task_id = user_dict["id"]
        success = await common_agent.cancel_task(task_id)
        return {
            "success": success,
            "message": "任务已停止" if success else "未找到任务",
        }

    elif qa_type == IntentEnum.DATABASE_QA.value[0]:
        user_dict = await decode_jwt_token(token)
        task_id = user_dict["id"]
        success = await sql_agent.cancel_task(task_id)
        return {
            "success": success,
            "message": "任务已停止" if success else "未找到任务",
        }

    elif qa_type == IntentEnum.FILEDATA_QA.value[0]:
        user_dict = await decode_jwt_token(token)
        task_id = user_dict["id"]
        success = await excel_agent.cancel_task(task_id)
        return {
            "success": success,
            "message": "任务已停止" if success else "未找到任务",
        }

    elif qa_type == IntentEnum.REPORT_QA.value[0]:
        user_dict = await decode_jwt_token(token)
        task_id = user_dict["id"]
        success = await deep_agent.cancel_task(task_id)
        return {
            "success": success,
            "message": "任务已停止" if success else "未找到任务",
        }

    else:
        return {"success": False, "message": f"不支持的问答类型: {qa_type}"}
