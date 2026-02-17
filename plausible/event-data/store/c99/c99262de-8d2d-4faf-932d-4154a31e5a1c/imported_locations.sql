ATTACH TABLE _ UUID '706f41d5-4a93-4e00-a414-dd3052cd8e72'
(
    `site_id` UInt64,
    `date` Date,
    `country` String,
    `region` String,
    `city` UInt64,
    `visitors` UInt64,
    `visits` UInt64,
    `visit_duration` UInt64,
    `bounces` UInt32,
    `import_id` UInt64,
    `pageviews` UInt64,
    `country_name` String ALIAS dictGet('plausible_events_db.location_data_dict', 'name', ('country', country)),
    `region_name` String ALIAS dictGet('plausible_events_db.location_data_dict', 'name', ('subdivision', region)),
    `city_name` String ALIAS dictGet('plausible_events_db.location_data_dict', 'name', ('city', city))
)
ENGINE = MergeTree
ORDER BY (site_id, date, country, region, city)
SETTINGS index_granularity = 8192, replicated_deduplication_window = 0
