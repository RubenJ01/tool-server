ATTACH TABLE _ UUID '5b5eeaa8-2a77-4bac-bec7-8dea1b34cb36'
(
    `type` LowCardinality(String),
    `id` String,
    `name` String
)
ENGINE = MergeTree
ORDER BY (type, id)
SETTINGS index_granularity = 128
COMMENT '2024-07-09'
