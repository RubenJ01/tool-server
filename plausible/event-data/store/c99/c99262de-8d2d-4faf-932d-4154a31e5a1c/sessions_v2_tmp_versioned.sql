ATTACH TABLE _ UUID 'e28e4b2d-979e-4dbf-9707-621007548733'
(
    `session_id` UInt64,
    `sign` Int8,
    `site_id` UInt64,
    `user_id` UInt64,
    `hostname` String CODEC(ZSTD(3)),
    `timestamp` DateTime CODEC(Delta(4), LZ4),
    `start` DateTime CODEC(Delta(4), LZ4),
    `is_bounce` UInt8,
    `entry_page` String CODEC(ZSTD(3)),
    `exit_page` String CODEC(ZSTD(3)),
    `pageviews` Int32,
    `events` Int32,
    `duration` UInt32,
    `referrer` String CODEC(ZSTD(3)),
    `referrer_source` String CODEC(ZSTD(3)),
    `country_code` LowCardinality(FixedString(2)),
    `screen_size` LowCardinality(String),
    `operating_system` LowCardinality(String),
    `browser` LowCardinality(String),
    `utm_medium` String CODEC(ZSTD(3)),
    `utm_source` String CODEC(ZSTD(3)),
    `utm_campaign` String CODEC(ZSTD(3)),
    `browser_version` LowCardinality(String),
    `operating_system_version` LowCardinality(String),
    `subdivision1_code` LowCardinality(String),
    `subdivision2_code` LowCardinality(String),
    `city_geoname_id` UInt32,
    `utm_content` String CODEC(ZSTD(3)),
    `utm_term` String CODEC(ZSTD(3)),
    `transferred_from` String,
    `entry_meta.key` Array(String) CODEC(ZSTD(3)),
    `entry_meta.value` Array(String) CODEC(ZSTD(3)),
    INDEX minmax_timestamp timestamp TYPE minmax GRANULARITY 1
)
ENGINE = CollapsingMergeTree(sign)
PARTITION BY toYYYYMM(start)
PRIMARY KEY (site_id, toDate(start), user_id, session_id)
ORDER BY (site_id, toDate(start), user_id, session_id)
SAMPLE BY user_id
SETTINGS index_granularity = 8192
