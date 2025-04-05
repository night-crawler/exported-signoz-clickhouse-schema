ATTACH TABLE _ UUID 'fde05974-0b9e-4b4f-b232-37a698282caf'
(
    `_retention_days` UInt32 DEFAULT 180,
    `rule_id` LowCardinality(String),
    `rule_name` LowCardinality(String),
    `overall_state` LowCardinality(String),
    `overall_state_changed` Bool,
    `state` LowCardinality(String),
    `state_changed` Bool,
    `unix_milli` Int64 CODEC(Delta(8), ZSTD(1)),
    `fingerprint` UInt64 CODEC(ZSTD(1)),
    `value` Float64 CODEC(Gorilla, ZSTD(1)),
    `labels` String CODEC(ZSTD(5))
)
ENGINE = MergeTree
PARTITION BY toDate(unix_milli / 1000)
ORDER BY (rule_id, unix_milli)
TTL toDateTime(unix_milli / 1000) + toIntervalDay(_retention_days)
SETTINGS ttl_only_drop_parts = 1, index_granularity = 8192
