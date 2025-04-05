ATTACH TABLE _ UUID '153e3935-e71d-41e1-838e-6b4e32cff2b9'
(
    `env` LowCardinality(String) DEFAULT 'default',
    `temporality` LowCardinality(String) DEFAULT 'Unspecified',
    `metric_name` LowCardinality(String),
    `fingerprint` UInt64 CODEC(ZSTD(1)),
    `unix_milli` Int64 CODEC(Delta(8), ZSTD(1)),
    `last` SimpleAggregateFunction(anyLast, Float64) CODEC(ZSTD(1)),
    `min` SimpleAggregateFunction(min, Float64) CODEC(ZSTD(1)),
    `max` SimpleAggregateFunction(max, Float64) CODEC(ZSTD(1)),
    `sum` SimpleAggregateFunction(sum, Float64) CODEC(ZSTD(1)),
    `count` SimpleAggregateFunction(sum, UInt64) CODEC(ZSTD(1))
)
ENGINE = AggregatingMergeTree
PARTITION BY toDate(unix_milli / 1000)
ORDER BY (env, temporality, metric_name, fingerprint, unix_milli)
TTL toDateTime(unix_milli / 1000) + toIntervalSecond(2592000)
SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1
