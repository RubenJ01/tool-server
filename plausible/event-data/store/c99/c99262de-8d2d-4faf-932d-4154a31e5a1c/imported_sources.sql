ATTACH TABLE _ UUID 'b393b4d6-83cf-436a-bd3c-543bf639f4c7'
(
    `site_id` UInt64,
    `date` Date,
    `source` String,
    `utm_medium` String,
    `utm_campaign` String,
    `utm_content` String,
    `utm_term` String,
    `visitors` UInt64,
    `visits` UInt64,
    `visit_duration` UInt64,
    `bounces` UInt32,
    `import_id` UInt64,
    `pageviews` UInt64,
    `referrer` String,
    `utm_source` String,
    `channel` LowCardinality(String)
)
ENGINE = MergeTree
ORDER BY (site_id, date, source)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
