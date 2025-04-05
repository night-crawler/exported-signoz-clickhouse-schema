ATTACH TABLE _ UUID 'a4a85a6b-7283-42e4-a995-c5ca6da99824'
(
    `ts_bucket_start` UInt64 CODEC(DoubleDelta, LZ4),
    `resource_fingerprint` String CODEC(ZSTD(1)),
    `timestamp` UInt64 CODEC(DoubleDelta, LZ4),
    `observed_timestamp` UInt64 CODEC(DoubleDelta, LZ4),
    `id` String CODEC(ZSTD(1)),
    `trace_id` String CODEC(ZSTD(1)),
    `span_id` String CODEC(ZSTD(1)),
    `trace_flags` UInt32,
    `severity_text` LowCardinality(String) CODEC(ZSTD(1)),
    `severity_number` UInt8,
    `body` String CODEC(ZSTD(2)),
    `attributes_string` Map(LowCardinality(String), String) CODEC(ZSTD(1)),
    `attributes_number` Map(LowCardinality(String), Float64) CODEC(ZSTD(1)),
    `attributes_bool` Map(LowCardinality(String), Bool) CODEC(ZSTD(1)),
    `resources_string` Map(LowCardinality(String), String) CODEC(ZSTD(1)),
    `scope_name` String CODEC(ZSTD(1)),
    `scope_version` String CODEC(ZSTD(1)),
    `scope_string` Map(LowCardinality(String), String) CODEC(ZSTD(1)),
    INDEX id_minmax id TYPE minmax GRANULARITY 1,
    INDEX severity_number_idx severity_number TYPE set(25) GRANULARITY 4,
    INDEX severity_text_idx severity_text TYPE set(25) GRANULARITY 4,
    INDEX trace_flags_idx trace_flags TYPE bloom_filter GRANULARITY 4,
    INDEX body_idx lower(body) TYPE ngrambf_v1(4, 60000, 5, 0) GRANULARITY 1,
    INDEX scope_name_idx scope_name TYPE tokenbf_v1(10240, 3, 0) GRANULARITY 4,
    INDEX attributes_string_idx_key mapKeys(attributes_string) TYPE tokenbf_v1(1024, 2, 0) GRANULARITY 1,
    INDEX attributes_string_idx_val mapValues(attributes_string) TYPE ngrambf_v1(4, 5000, 2, 0) GRANULARITY 1,
    INDEX attributes_number_idx_key mapKeys(attributes_number) TYPE tokenbf_v1(1024, 2, 0) GRANULARITY 1,
    INDEX attributes_number_idx_val mapValues(attributes_number) TYPE bloom_filter GRANULARITY 1,
    INDEX attributes_bool_idx_key mapKeys(attributes_bool) TYPE tokenbf_v1(1024, 2, 0) GRANULARITY 1
)
ENGINE = MergeTree
PARTITION BY toDate(timestamp / 1000000000)
ORDER BY (ts_bucket_start, resource_fingerprint, severity_text, timestamp, id)
TTL toDateTime(timestamp / 1000000000) + toIntervalSecond(1296000)
SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1
