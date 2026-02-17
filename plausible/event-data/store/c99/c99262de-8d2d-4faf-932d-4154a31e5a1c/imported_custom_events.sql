ATTACH TABLE _ UUID '9a8d1ae4-6f3b-435d-b173-ca718df52909'
(
    `site_id` UInt64,
    `import_id` UInt64,
    `date` Date,
    `name` String CODEC(ZSTD(3)),
    `link_url` String CODEC(ZSTD(3)),
    `path` String CODEC(ZSTD(3)),
    `visitors` UInt64,
    `events` UInt64
)
ENGINE = MergeTree
ORDER BY (site_id, import_id, date, name)
SETTINGS replicated_deduplication_window = 0, index_granularity = 8192
