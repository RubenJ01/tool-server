ATTACH TABLE _ UUID 'acf92593-b8c8-4c85-bca9-fc3c2e1e55a1'
(
    `site_id` UInt64,
    `date` Date,
    `exit_page` String,
    `visitors` UInt64,
    `exits` UInt64,
    `import_id` UInt64,
    `pageviews` UInt64,
    `bounces` UInt32,
    `visit_duration` UInt64
)
ENGINE = MergeTree
ORDER BY (site_id, date, exit_page)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
