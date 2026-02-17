ATTACH TABLE _ UUID '73322fc5-e395-4b50-a65f-68cee1fc9da1'
(
    `event_timebucket` DateTime,
    `domain` LowCardinality(String),
    `site_id` Nullable(UInt64),
    `metric` LowCardinality(String),
    `value` UInt64,
    `tracker_script_version` UInt16,
    PROJECTION ingest_counters_site_traffic_projection
    (
        SELECT 
            site_id,
            toDate(event_timebucket),
            sumIf(value, metric = 'buffered')
        GROUP BY 
            site_id,
            toDate(event_timebucket)
    )
)
ENGINE = SummingMergeTree(value)
PRIMARY KEY (domain, toDate(event_timebucket), metric, toStartOfMinute(event_timebucket))
ORDER BY (domain, toDate(event_timebucket), metric, toStartOfMinute(event_timebucket), tracker_script_version)
SETTINGS index_granularity = 8192
