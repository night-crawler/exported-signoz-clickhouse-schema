ATTACH TABLE _ UUID '713ade0f-0ded-4519-8305-3086e90654ac'
(
    `metric_name` LowCardinality(String),
    `fingerprint` UInt64 CODEC(ZSTD(1)),
    `timestamp_ms` Int64 CODEC(DoubleDelta, LZ4),
    `value` Float64 CODEC(Gorilla, LZ4)
)
ENGINE = Distributed('cluster', 'signoz_metrics', 'samples_v2', cityHash64(metric_name, fingerprint))
