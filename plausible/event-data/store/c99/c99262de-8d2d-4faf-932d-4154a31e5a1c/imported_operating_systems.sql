ATTACH TABLE _ UUID '8d19e7b7-4164-4b63-96db-3ef50c6847d2'
(
    `site_id` UInt64,
    `date` Date,
    `operating_system` String,
    `visitors` UInt64,
    `visits` UInt64,
    `visit_duration` UInt64,
    `bounces` UInt32,
    `import_id` UInt64,
    `pageviews` UInt64,
    `operating_system_version` String
)
ENGINE = MergeTree
ORDER BY (site_id, date, operating_system)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
