ATTACH TABLE _ UUID '827e050e-5226-4fd6-8b0d-cca539123822'
(
    `site_id` UInt64,
    `date` Date,
    `visitors` UInt64,
    `pageviews` UInt64,
    `bounces` UInt64,
    `visits` UInt64,
    `visit_duration` UInt64,
    `import_id` UInt64
)
ENGINE = MergeTree
ORDER BY (site_id, date)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
