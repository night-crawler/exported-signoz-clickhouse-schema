ATTACH TABLE _ UUID '4639e6f4-1eeb-4494-aa34-acbaf4bbf189'
(
    `env` LowCardinality(String) DEFAULT 'default',
    `temporality` LowCardinality(String) DEFAULT 'Unspecified',
    `metric_name` LowCardinality(String),
    `fingerprint` UInt64 CODEC(Delta(8), ZSTD(1)),
    `unix_milli` Int64 CODEC(DoubleDelta, ZSTD(1)),
    `count` UInt64 CODEC(ZSTD(1)),
    `sum` Float64 CODEC(Gorilla, ZSTD(1)),
    `min` Float64 CODEC(Gorilla, ZSTD(1)),
    `max` Float64 CODEC(Gorilla, ZSTD(1)),
    `sketch` AggregateFunction(quantilesDD(0.01, 0.5, 0.75, 0.9, 0.95, 0.99), UInt64) CODEC(ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_metrics', 'exp_hist', cityHash64(env, temporality, metric_name, fingerprint))
