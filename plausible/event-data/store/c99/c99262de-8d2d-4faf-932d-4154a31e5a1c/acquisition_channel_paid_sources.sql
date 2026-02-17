ATTACH TABLE _ UUID '78799b30-e46a-4f7e-94c3-1fec785a1453'
(
    `referrer_source` String
)
ENGINE = MergeTree
ORDER BY referrer_source
SETTINGS index_granularity = 8192
