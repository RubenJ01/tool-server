ATTACH TABLE _ UUID '33223780-f1d3-44ad-ba0e-0711e34f1f43'
(
    `site_id` UInt64,
    `date` Date,
    `browser` String,
    `visitors` UInt64,
    `visits` UInt64,
    `visit_duration` UInt64,
    `bounces` UInt32,
    `import_id` UInt64,
    `pageviews` UInt64,
    `browser_version` String
)
ENGINE = MergeTree
ORDER BY (site_id, date, browser)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
