# Aix-DB 后端接口完整文档

> 基于本地开发版本 `/Users/jiang/BdProject/Aix-DB`

## 接口基础信息

| 配置项 | 值 |
|--------|-----|
| **基础URL** | `http://localhost:2048/sanic` |
| **认证方式** | JWT Token (Bearer) |
| **响应格式** | JSON / SSE (流式) |
| **API文档** | `http://localhost:2048/docs` |

## 接口总览

| 模块 | 前缀 | 说明 |
|------|------|------|
| **对话服务** | `/chat` | 核心问答接口 |
| **用户服务** | `/user` | 用户管理、登录、聊天记录 |
| **数据源** | `/datasource` | 数据库连接管理 |
| **模型管理** | `/system/aimodel` | AI模型配置 |
| **术语管理** | `/terminology` | 业务术语库 |
| **权限管理** | `/ds_permission` | 数据权限规则 |
| **文件服务** | `/file` | 文件上传解析 |
| **数据训练** | `/system/data-training` | 训练样本管理 |
| **数据迁移** | `/system/embedding-migration` | 向量重新计算 |
| **技能管理** | `/system/skill` | DeepAgent技能 |

---

## 1. 对话服务 (`/chat`)

### 1.1 POST `/chat/get_answer` - 核心问答接口 (SSE流式)

**功能**: 通用入口，根据 `qa_type` 调用不同的Agent

**请求体**:
```json
{
  "chat_id": "string",           // 对话ID
  "qa_type": "COMMON_QA",       // 问答类型
  "uuid": "string",              // 自定义ID
  "query": "string",             // 用户问题
  "file_list": [],               // 附件列表
  "datasource_id": 1             // 数据源ID (DATABASE_QA时)
}
```

**qa_type 类型**:

| 类型 | 对应 Agent | 说明 |
|------|-----------|------|
| `COMMON_QA` | `CommonReactAgent` | 通用问答 |
| `DATABASE_QA` | `Text2SqlAgent` | 数据库问答，支持自然语言转 SQL 查询 |
| `FILEDATA_QA` | `ExcelAgent` | Excel/CSV 文件数据问答与分析 |
| `REPORT_QA` | `DeepAgent` | 深度研究报告生成，支持多轮推理与资料整合 |

**响应**: SSE流式响应 (`text/event-stream`)

```javascript
// 数据消息
data:{"data":{"messageType":"continue","content":"正在分析..."},"dataType":"t02"}

// 结束消息
data:{"data":"DONE","dataType":"[DONE]"}
```

**权限说明**:
- `DATABASE_QA` 类型会在流式响应前检查数据源权限
- 无权限时直接返回 JSON 403 错误，而非流式响应

---

### 1.2 POST `/chat/stop_chat` - 停止聊天

**功能**: 停止正在进行的聊天任务

**请求体**:
```json
{
  "task_id": "string",    // 任务ID
  "qa_type": "COMMON_QA" // 问答类型
}
```

**响应**:
```json
{
  "success": true,
  "message": "任务已停止"
}
```

---

## 2. 用户服务 (`/user`)

### 2.1 POST `/user/login` - 用户登录

**功能**: 用户登录验证，返回JWT Token

**请求体**:
```json
{
  "username": "string",  // 用户名
  "password": "string"  // 密码
}
```

**响应**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

---

### 2.2 POST `/user/query_user_record` - 查询聊天记录

**功能**: 分页查询当前用户的聊天记录

**请求体**:
```json
{
  "page": 1,           // 页码
  "size": 10,         // 每页数量
  "search_text": "",  // 搜索关键词(可选)
  "chat_id": ""       // 对话ID筛选(可选)
}
```

**响应**:
```json
{
  "data": [...],
  "total": 100,
  "page": 1,
  "size": 10
}
```

---

### 2.3 POST `/user/query_user_record_list` - 查询对话历史列表(优化版)

**功能**: 分页查询对话历史列表，只返回必要字段

**请求体**:
```json
{
  "page": 1,
  "size": 10,
  "search_text": ""
}
```

---

### 2.4 POST `/user/delete_user_record` - 删除聊天记录

**功能**: 批量删除聊天记录

**请求体**:
```json
{
  "record_ids": [1, 2, 3]  // 记录ID列表
}
```

---

### 2.5 POST `/user/get_record_sql` - 获取SQL语句

**功能**: 根据记录ID查询SQL语句

**请求体**:
```json
{
  "record_id": 123  // 记录ID
}
```

---

### 2.6 POST `/user/list` - 查询用户列表

**功能**: 分页查询用户列表(仅管理员)

**请求体**:
```json
{
  "page": 1,
  "size": 10,
  "name": ""  // 用户名搜索
}
```

---

### 2.7 POST `/user/add` - 添加用户

**功能**: 添加新用户(仅管理员)

**请求体**:
```json
{
  "userName": "string",
  "password": "string",
  "mobile": "string"
}
```

---

### 2.8 POST `/user/update` - 更新用户

**功能**: 更新用户信息(仅管理员)

**请求体**:
```json
{
  "id": 1,
  "userName": "string",
  "mobile": "string",
  "password": "string"  // 可选
}
```

---

### 2.9 POST `/user/delete` - 删除用户

**功能**: 删除用户(仅管理员)

**请求体**:
```json
{
  "id": 1
}
```

---

## 3. 数据源服务 (`/datasource`)

### 3.1 GET `/datasource/list` - 获取数据源列表

**功能**: 获取当前用户有权访问的数据源列表

**响应**:
```json
[
  {
    "id": 1,
    "name": "生产数据库",
    "description": "...",
    "type": "mysql",
    "type_name": "MySQL",
    "status": 1,
    "num": 5,
    "host": "localhost",
    "database": "mydb",
    "create_time": "2024-01-01T00:00:00"
  }
]
```

---

### 3.2 POST `/datasource/add` - 创建数据源

**功能**: 创建新的数据源(仅管理员)

**请求体**:
```json
{
  "name": "string",
  "type": "mysql",
  "description": "string",
  "configuration": {
    "host": "localhost",
    "port": 3306,
    "database": "mydb",
    "user": "root",
    "password": "xxx"
  }
}
```

---

### 3.3 POST `/datasource/update` - 更新数据源

**功能**: 更新数据源信息(仅管理员)

**请求体**:
```json
{
  "id": 1,
  "name": "string",
  "type": "mysql",
  "description": "string",
  "configuration": {...}
}
```

---

### 3.4 POST `/datasource/syncTables/<ds_id>` - 同步表和字段

**功能**: 同步数据源的表和字段(仅管理员)

**路径参数**: `ds_id` - 数据源ID

**请求体**:
```json
{
  "tables": ["table1", "table2"],
  "is_select_all": false  // 是否全选
}
```

---

### 3.5 POST `/datasource/delete/<ds_id>` - 删除数据源

**功能**: 删除数据源(仅管理员)

**路径参数**: `ds_id` - 数据源ID

---

### 3.6 POST `/datasource/get/<ds_id>` - 获取数据源详情

**功能**: 获取指定数据源的详细信息

**路径参数**: `ds_id` - 数据源ID

**响应**:
```json
{
  "id": 1,
  "name": "...",
  "type": "mysql",
  "configuration": "{...}",  // JSON字符串
  "table_relation": "...",
  "status": 1
}
```

---

### 3.7 POST `/datasource/check` - 测试连接

**功能**: 测试数据源连接是否正常

**请求体**:
```json
{
  "id": 1  // 或直接提供type和configuration
}
```

**响应**:
```json
{
  "connected": true,
  "error_message": null
}
```

---

### 3.8 POST `/datasource/getTablesByConf` - 获取表列表

**功能**: 根据配置获取表列表

**请求体**:
```json
{
  "type": "mysql",
  "configuration": {...}
}
```

---

### 3.9 POST `/datasource/getFieldsByConf` - 获取字段列表

**功能**: 根据配置获取表字段列表

**请求体**:
```json
{
  "type": "mysql",
  "configuration": {...},
  "table_name": "orders"
}
```

---

### 3.10 POST `/datasource/tableList/<ds_id>` - 获取表列表

**功能**: 获取数据源已同步的表列表

**路径参数**: `ds_id` - 数据源ID

---

### 3.11 POST `/datasource/fieldList/<table_id>` - 获取字段列表

**功能**: 获取指定表的字段列表

**路径参数**: `table_id` - 表ID

---

### 3.12 POST `/datasource/saveTable` - 保存表信息

**功能**: 保存表的自定义注释

**请求体**:
```json
{
  "id": 1,
  "custom_comment": "订单表",
  "checked": true
}
```

---

### 3.13 POST `/datasource/saveField` - 保存字段信息

**功能**: 保存字段的自定义注释

**请求体**:
```json
{
  "id": 1,
  "custom_comment": "订单金额",
  "checked": true
}
```

---

### 3.14 POST `/datasource/previewData` - 预览数据

**功能**: 预览表数据(最多100条)

**请求体**:
```json
{
  "ds_id": 1,
  "table": {
    "table_name": "orders",
    "ds_id": 1
  },
  "fields": ["id", "amount"]
}
```

---

### 3.15 POST `/datasource/tableRelation` - 保存表关系

**功能**: 保存数据源的表关系

**请求体**:
```json
{
  "ds_id": 1,
  "relations": [
    {
      "sourceTable": "orders",
      "sourceField": "customer_id",
      "targetTable": "customers",
      "targetField": "id"
    }
  ]
}
```

---

### 3.16 GET `/datasource/getTableRelation/<ds_id>` - 获取表关系

**功能**: 获取数据源的表关系

---

### 3.17 GET `/datasource/getAuthorizedUsers/<datasource_id>` - 获取已授权用户

**功能**: 获取数据源已授权的用户ID列表(仅管理员)

---

### 3.18 POST `/datasource/authorize` - 数据源授权

**功能**: 授权用户使用数据源(仅管理员)

**请求体**:
```json
{
  "datasource_id": 1,
  "user_ids": [1, 2, 3]
}
```

---

## 4. 模型管理 (`/system/aimodel`)

### 4.1 GET `/system/aimodel/` - 查询模型列表

**功能**: 获取模型列表

**查询参数**:
- `keyword`: 搜索关键词
- `model_type`: 模型类型

---

### 4.2 GET `/system/aimodel/<id>` - 获取模型详情

---

### 4.3 POST `/system/aimodel/` - 添加模型

**请求体**:
```json
{
  "name": "string",
  "model_type": 1,
  "api_key": "string",
  "api_domain": "string",
  "supplier": "string"
}
```

---

### 4.4 PUT `/system/aimodel/` - 更新模型

---

### 4.5 DELETE `/system/aimodel/<id>` - 删除模型

---

### 4.6 PUT `/system/aimodel/default/<id>` - 设为默认模型

---

### 4.7 POST `/system/aimodel/status` - 测试模型连接

---

### 4.8 POST `/system/aimodel/models` - 获取基础模型列表

---

## 5. 术语管理 (`/terminology`)

### 5.1 POST `/terminology/list` - 分页查询术语

**请求体**:
```json
{
  "page": 1,
  "size": 10,
  "word": "string",
  "dslist": []  // 数据源ID列表
}
```

---

### 5.2 POST `/terminology/save` - 保存术语

**请求体**:
```json
{
  "id": 1,  // 可选，有则更新
  "word": "string",
  "description": "string",
  "other_words": ["同义词1", "同义词2"],
  "specific_ds": false,
  "datasource_ids": []
}
```

---

### 5.3 POST `/terminology/delete` - 删除术语

**请求体**:
```json
{
  "ids": [1, 2, 3]
}
```

---

### 5.4 GET `/terminology/<id>/enable/<enabled>` - 启用/禁用术语

---

### 5.5 GET `/terminology/<id>` - 获取术语详情

---

### 5.6 POST `/terminology/generate_synonyms` - AI生成同义词

**请求体**:
```json
{
  "word": "销售"
}
```

---

## 6. 权限管理 (`/ds_permission`)

### 6.1 POST `/ds_permission/list` - 获取权限规则列表

**响应**:
```json
[
  {
    "id": 1,
    "rule_name": "数据脱敏",
    "rule_type": "filter",
    "expression": "mask(card_no)",
    "table_name": "users"
  }
]
```

---

### 6.2 POST `/ds_permission/save` - 保存权限规则

**请求体**:
```json
{
  "id": 1,
  "rule_name": "string",
  "rule_type": "filter|column",
  "expression": "string",
  "table_name": "string"
}
```

---

### 6.3 POST `/ds_permission/delete/<rule_id>` - 删除权限规则

---

## 7. 文件服务 (`/file`)

### 7.1 POST `/file/read_file` - 读取文件内容

**查询参数/请求体**:
- `file_qa_str`: MinIO文件key

---

### 7.2 POST `/file/read_file_column` - 读取文件列信息

**功能**: 读取Excel文件的列信息(表头)

---

### 7.3 POST `/file/upload_file` - 上传文件

**功能**: 上传文件到MinIO

**请求**: `multipart/form-data`

---

### 7.4 POST `/file/upload_file_and_parse` - 上传并解析

**功能**: 上传文件并解析内容

---

### 7.5 POST `/file/process_file_llm_out` - 处理LLM输出

**功能**: 处理文件问答中LLM返回的SQL

**查询参数**: `file_key` - 文件key

**请求体**:
```json
{
  "sql": "SELECT * FROM ..."
}
```

---

## 8. 数据训练 (`/system/data-training`)

### 8.1 GET `/system/data-training/page/<page>/<size>` - 分页查询

**查询参数**: `question` - 问题描述搜索

---

### 8.2 PUT `/system/data-training/` - 创建或更新训练数据

**请求体**:
```json
{
  "id": 1,  // 可选
  "question": "string",
  "answer": "string",
  "datasource_id": 1
}
```

---

### 8.3 DELETE `/system/data-training/` - 删除训练数据

**请求体**:
```json
{
  "ids": [1, 2, 3]
}
```

---

### 8.4 GET `/system/data-training/<id>/enable/<enabled>` - 启用/禁用

---

## 9. 数据迁移 (`/system/embedding-migration`)

### 9.1 GET `/system/embedding-migration/model-info` - 获取模型信息

**功能**: 获取当前embedding模型信息

---

### 9.2 POST `/system/embedding-migration/recalculate` - 重新计算embedding (SSE流式)

**功能**: 重新计算向量，支持流式进度输出

**请求体**:
```json
{
  "modules": ["terminology", "training", "table"]  // 可选
}
```

**响应**: SSE流式

```javascript
data:{"type":"start","message":"开始重新计算..."}
data:{"type":"progress","module":"terminology","current":5,"total":100,"percentage":5}
data:{"type":"complete","result":{...}}
```

---

### 9.3 POST `/system/embedding-migration/recalculate-sync` - 重新计算(同步)

**功能**: 同步方式重新计算(不推荐大量数据)

---

## 10. 技能管理 (`/system/skill`)

### 10.1 GET `/system/skill/list` - 获取技能列表

**功能**: 获取深度研究Agent可用技能列表

**响应**:
```json
[
  {
    "name": "web-search",
    "description": "网络搜索技能"
  }
]
```

---

## 错误码说明

| 错误码 | 说明 |
|--------|------|
| `c_401` | 未授权/登录失败 |
| `c_9999` | 系统错误 |
| `PARAM_ERROR` | 参数错误 |
| `DATA_NOT_FOUND` | 数据不存在 |
| `SYSTEM_ERROR` | 系统错误 |

---

## 认证示例

```bash
curl -X POST http://localhost:2048/sanic/chat/get_answer \
  -H "Authorization: Bearer <jwt_token>" \
  -H "Content-Type: application/json" \
  -d '{
    "chat_id": "chat_001",
    "qa_type": "DATABASE_QA",
    "query": "去年销售额是多少？",
    "datasource_id": 1
  }'
```

---

*文档生成时间: 2024-03-27*
