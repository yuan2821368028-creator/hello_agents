from serpapi import SerpApiClient
import os
from dotenv import load_dotenv
load_dotenv()
def search(query: str) -> str:
    """
    一个基于SerpApi的实战网页搜索引擎工具。
    它会智能地解析搜索结果，优先返回直接答案或知识图谱信息。
    """
    print(f"🔍 正在执行 [SerpApi] 网页搜索: {query}")
    try:
        api_key = os.getenv("SERPAPI_API_KEY")
        if not api_key:
            return "错误:SERPAPI_API_KEY 未在 .env 文件中配置。"

        params = {
            "engine": "google",
            "q": query,
            "api_key": api_key,
            "gl": "cn",  # 国家代码
            "hl": "zh-cn",  # 语言代码
        }

        client = SerpApiClient(params)
        # 把 SerpApi 返回的原始响应数据，转换成 Python 能直接读取的「字典（dict）格式」。
        results = client.get_dict()
        # import serpapi

        # client = serpapi.Client(api_key="5b67245ae8b3e68f34a46c2b1bc7e37ae9321b6309f58ae566cd7dd5e257855d")
        # results = client.search({
        #     "engine": "google",
        #     "q": "Coffee",
        #     "location": "Austin, Texas, United States",
        #     "google_domain": "google.com",
        #     "gl": "us",
        #     "hl": "en"
        # })

        # 智能解析:优先寻找最直接的答案
        # 按照「优先级」去读取 SerpApi 返回的不同类型结果，优先给用户最直接的答案
        if "answer_box_list" in results:
            # answer_box_list：Google 直接给出的列表式答案（比如排行榜、步骤列表
            return "\n".join(results["answer_box_list"])
        if "answer_box" in results and "answer" in results["answer_box"]:
            # answer_box：Google 顶部的直接回答框（比如天气、计算、定义）
            return results["answer_box"]["answer"]
        if "knowledge_graph" in results and "description" in results["knowledge_graph"]:
            # knowledge_graph：右侧知识卡片（比如人物、产品百科信息）
            return results["knowledge_graph"]["description"]
        # organic_results：普通网页搜索结果（兜底方案）
        if "organic_results" in results and results["organic_results"]:
            # 如果没有直接答案，则返回前三个有机结果的摘要
            snippets = [
                f"[{i + 1}] {res.get('title', '')}\n{res.get('snippet', '')}"
                for i, res in enumerate(results["organic_results"][:3])
            ]
            return "\n\n".join(snippets)

        return f"对不起，没有找到关于 '{query}' 的信息。"

    except Exception as e:
        return f"搜索时发生了异常{e}"

if __name__ == '__main__':

    print(search("今年苹果手机的最新款是？"))