ATTACH TABLE _ UUID '8ae76028-00af-45e4-93d2-fc0f3e28b1a4'
(
    `referrer_source` String,
    `category` LowCardinality(String)
)
ENGINE = MergeTree
ORDER BY referrer_source
SETTINGS index_granularity = 8192
