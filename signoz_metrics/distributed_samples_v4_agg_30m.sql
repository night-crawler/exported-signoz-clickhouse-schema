ATTACH TABLE _ UUID 'dbaf1af8-106f-43ef-8efd-bfb8bc218881'
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
ENGINE = Distributed('cluster', 'signoz_metrics', 'samples_v4_agg_30m', cityHash64(env, temporality, metric_name, fingerprint))
