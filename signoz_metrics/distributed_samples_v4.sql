ATTACH TABLE _ UUID '27cb9301-fc9a-4f54-af32-a8a366762e4a'
(
    `env` LowCardinality(String) DEFAULT 'default',
    `temporality` LowCardinality(String) DEFAULT 'Unspecified',
    `metric_name` LowCardinality(String),
    `fingerprint` UInt64 CODEC(Delta(8), ZSTD(1)),
    `unix_milli` Int64 CODEC(DoubleDelta, ZSTD(1)),
    `value` Float64 CODEC(Gorilla, ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_metrics', 'samples_v4', cityHash64(env, temporality, metric_name, fingerprint))
