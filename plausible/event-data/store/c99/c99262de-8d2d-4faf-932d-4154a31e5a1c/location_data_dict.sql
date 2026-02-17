CREATE DICTIONARY _ UUID 'ccd62ba8-d105-4d27-97bb-550e91d19874'
(
    `type` String,
    `id` String,
    `name` String
)
PRIMARY KEY type, id
SOURCE(CLICKHOUSE(TABLE location_data DB 'plausible_events_db'))
LIFETIME(MIN 0 MAX 0)
LAYOUT(COMPLEX_KEY_CACHE(SIZE_IN_CELLS 500000))
