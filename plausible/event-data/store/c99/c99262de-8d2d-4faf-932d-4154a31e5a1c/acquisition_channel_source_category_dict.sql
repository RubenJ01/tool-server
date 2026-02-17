CREATE DICTIONARY _ UUID '40ecad6f-6b4c-49da-b863-0d07e88e0e49'
(
    `referrer_source` String,
    `category` String
)
PRIMARY KEY referrer_source
SOURCE(CLICKHOUSE(TABLE acquisition_channel_source_category DB 'plausible_events_db'))
LIFETIME(MIN 0 MAX 0)
LAYOUT(COMPLEX_KEY_HASHED())
