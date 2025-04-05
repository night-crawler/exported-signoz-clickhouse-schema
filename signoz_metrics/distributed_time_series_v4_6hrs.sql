ATTACH TABLE _ UUID 'a3df8b74-370a-47cd-bc79-7a5934ef7606'
(
    `env` LowCardinality(String) DEFAULT 'default',
    `temporality` LowCardinality(String) DEFAULT 'Unspecified',
    `metric_name` LowCardinality(String),
    `description` LowCardinality(String) DEFAULT '' CODEC(ZSTD(1)),
    `unit` LowCardinality(String) DEFAULT '' CODEC(ZSTD(1)),
    `type` LowCardinality(String) DEFAULT '' CODEC(ZSTD(1)),
    `is_monotonic` Bool DEFAULT false CODEC(ZSTD(1)),
    `fingerprint` UInt64 CODEC(Delta(8), ZSTD(1)),
    `unix_milli` Int64 CODEC(Delta(8), ZSTD(1)),
    `labels` String CODEC(ZSTD(5)),
    `attrs` Map(LowCardinality(String), String) DEFAULT map() CODEC(ZSTD(1)),
    `scope_attrs` Map(LowCardinality(String), String) DEFAULT map() CODEC(ZSTD(1)),
    `resource_attrs` Map(LowCardinality(String), String) DEFAULT map() CODEC(ZSTD(1)),
    `__normalized` Bool DEFAULT true CODEC(ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_metrics', 'time_series_v4_6hrs', cityHash64(env, temporality, metric_name, fingerprint))
