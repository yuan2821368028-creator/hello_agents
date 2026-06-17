-- 长期记忆存储表 t_agent_memory
-- 用于 langmem 跨会话语义记忆 / SQL 模式记忆
-- 依赖 pgvector 扩展（需先安装 vector 扩展）

CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS t_agent_memory (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL,
    namespace   VARCHAR(200) NOT NULL,   -- e.g. 'user:123:semantic'
    key         VARCHAR(200) NOT NULL,
    content     TEXT NOT NULL,
    embedding   VECTOR(1536),            -- pgvector 向量，语义检索用
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 向量相似度检索索引（余弦距离）
CREATE INDEX IF NOT EXISTS idx_agent_memory_embedding
    ON t_agent_memory USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

-- 按用户+命名空间过滤索引
CREATE INDEX IF NOT EXISTS idx_agent_memory_user_ns
    ON t_agent_memory (user_id, namespace);
