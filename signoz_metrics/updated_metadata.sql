ATTACH TABLE _ UUID '6b58b644-e624-4535-91e1-fb03e4058920'
(
    `metric_name` LowCardinality(String) CODEC(ZSTD(1)),
    `temporality` LowCardinality(String) CODEC(ZSTD(1)),
    `is_monotonic` Bool CODEC(ZSTD(1)),
    `type` LowCardinality(String) CODEC(ZSTD(1)),
    `description` LowCardinality(String) CODEC(ZSTD(1)),
    `unit` LowCardinality(String) CODEC(ZSTD(1)),
    `created_at` Int64 CODEC(ZSTD(1))
)
ENGINE = MergeTree
ORDER BY metric_name
SETTINGS index_granularity = 8192
