CREATE DICTIONARY _ UUID 'd7b5776f-c962-4f9e-a931-8f60d650739a'
(
    `referrer_source` String
)
PRIMARY KEY referrer_source
SOURCE(CLICKHOUSE(TABLE acquisition_channel_paid_sources DB 'plausible_events_db'))
LIFETIME(MIN 0 MAX 0)
LAYOUT(COMPLEX_KEY_HASHED())
