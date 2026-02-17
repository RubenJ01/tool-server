ATTACH TABLE _ UUID '62cb1266-d196-4e37-ac47-a45ac9c259be'
(
    `timestamp` DateTime CODEC(Delta(4), LZ4),
    `name` LowCardinality(String),
    `site_id` UInt64,
    `user_id` UInt64,
    `session_id` UInt64,
    `hostname` String CODEC(ZSTD(3)),
    `pathname` String CODEC(ZSTD(3)),
    `referrer` String CODEC(ZSTD(3)),
    `referrer_source` String CODEC(ZSTD(3)),
    `country_code` FixedString(2),
    `screen_size` LowCardinality(String),
    `operating_system` LowCardinality(String),
    `browser` LowCardinality(String),
    `utm_medium` String CODEC(ZSTD(3)),
    `utm_source` String CODEC(ZSTD(3)),
    `utm_campaign` String CODEC(ZSTD(3)),
    `meta.key` Array(String) CODEC(ZSTD(3)),
    `meta.value` Array(String) CODEC(ZSTD(3)),
    `browser_version` LowCardinality(String),
    `operating_system_version` LowCardinality(String),
    `subdivision1_code` LowCardinality(String),
    `subdivision2_code` LowCardinality(String),
    `city_geoname_id` UInt32,
    `utm_content` String CODEC(ZSTD(3)),
    `utm_term` String CODEC(ZSTD(3)),
    `revenue_reporting_amount` Nullable(Decimal(18, 3)),
    `revenue_reporting_currency` FixedString(3),
    `revenue_source_amount` Nullable(Decimal(18, 3)),
    `revenue_source_currency` FixedString(3),
    `city` UInt32 ALIAS city_geoname_id,
    `country` LowCardinality(FixedString(2)) ALIAS country_code,
    `device` LowCardinality(String) ALIAS screen_size,
    `os` LowCardinality(String) ALIAS operating_system,
    `os_version` LowCardinality(String) ALIAS operating_system_version,
    `region` LowCardinality(String) ALIAS subdivision1_code,
    `screen` LowCardinality(String) ALIAS screen_size,
    `source` String ALIAS referrer_source,
    `country_name` String ALIAS dictGet('plausible_events_db.location_data_dict', 'name', ('country', country_code)),
    `region_name` String ALIAS dictGet('plausible_events_db.location_data_dict', 'name', ('subdivision', subdivision1_code)),
    `city_name` String ALIAS dictGet('plausible_events_db.location_data_dict', 'name', ('city', city_geoname_id)),
    `channel` LowCardinality(String),
    `click_id_param` LowCardinality(String),
    `scroll_depth` UInt8,
    `acquisition_channel` LowCardinality(String) MATERIALIZED multiIf(position(lower(utm_campaign), 'cross-network') > 0, 'Cross-network', lower(utm_medium) IN ('display', 'banner', 'expandable', 'interstitial', 'cpm'), 'Display', match(lower(utm_medium), '^(.*cp.*|ppc|retargeting|paid.*)$') AND ((dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_SHOPPING') OR match(lower(utm_campaign), '^(.*(([^a-df-z]|^)shop|shopping).*)$')), 'Paid Shopping', ((dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_SEARCH') AND (match(lower(utm_medium), '^(.*cp.*|ppc|retargeting|paid.*)$') OR dictHas('plausible_events_db.acquisition_channel_paid_sources_dict', lower(utm_source)))) OR ((lower(referrer_source) = 'google') AND (click_id_param = 'gclid')) OR ((lower(referrer_source) = 'bing') AND (click_id_param = 'msclkid')), 'Paid Search', (dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_SOCIAL') AND (match(lower(utm_medium), '^(.*cp.*|ppc|retargeting|paid.*)$') OR dictHas('plausible_events_db.acquisition_channel_paid_sources_dict', lower(utm_source))), 'Paid Social', (dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_VIDEO') AND (match(lower(utm_medium), '^(.*cp.*|ppc|retargeting|paid.*)$') OR dictHas('plausible_events_db.acquisition_channel_paid_sources_dict', lower(utm_source))), 'Paid Video', match(lower(utm_medium), '^(.*cp.*|ppc|retargeting|paid.*)$'), 'Paid Other', (dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_SHOPPING') OR match(lower(utm_campaign), '^(.*(([^a-df-z]|^)shop|shopping).*)$'), 'Organic Shopping', (dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_SOCIAL') OR (lower(utm_medium) IN ('social', 'social-network', 'social-media', 'sm', 'social network', 'social media')), 'Organic Social', (dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_VIDEO') OR (position(lower(utm_medium), 'video') > 0), 'Organic Video', dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_SEARCH', 'Organic Search', (dictGet('plausible_events_db.acquisition_channel_source_category_dict', 'category', lower(referrer_source)) = 'SOURCE_CATEGORY_EMAIL') OR match(lower(utm_source), 'e[-_ ]?mail|newsletter') OR match(lower(utm_medium), 'e[-_ ]?mail|newsletter'), 'Email', lower(utm_medium) = 'affiliate', 'Affiliates', lower(utm_medium) = 'audio', 'Audio', lower(utm_source) = 'sms', 'SMS', lower(utm_medium) = 'sms', 'SMS', endsWith(lower(utm_medium), 'push') OR multiSearchAny(lower(utm_medium), ['mobile', 'notification']) OR (lower(referrer_source) = 'firebase'), 'Mobile Push Notifications', (lower(utm_medium) IN ('referral', 'app', 'link')) OR (NOT empty(lower(referrer_source))), 'Referral', 'Direct'),
    `engagement_time` UInt32
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
PRIMARY KEY (site_id, toDate(timestamp), name, user_id)
ORDER BY (site_id, toDate(timestamp), name, user_id, timestamp)
SAMPLE BY user_id
SETTINGS index_granularity = 8192
