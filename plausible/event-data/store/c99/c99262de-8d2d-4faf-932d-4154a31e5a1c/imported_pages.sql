ATTACH TABLE _ UUID '82dff69b-bbbd-4fd2-a99a-b9efd9e5e2d5'
(
    `site_id` UInt64,
    `date` Date,
    `hostname` String,
    `page` String,
    `visitors` UInt64,
    `pageviews` UInt64,
    `exits` UInt64,
    `import_id` UInt64,
    `visits` UInt64,
    `total_scroll_depth` UInt64,
    `total_scroll_depth_visits` UInt64,
    `total_time_on_page` UInt64,
    `total_time_on_page_visits` UInt64
)
ENGINE = MergeTree
ORDER BY (site_id, date, hostname, page)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
