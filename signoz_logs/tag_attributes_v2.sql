ATTACH TABLE _ UUID 'b11dc91f-5fef-4239-93c6-125e69887b13'
(
    `unix_milli` Int64 CODEC(Delta(8), ZSTD(1)),
    `tag_key` String CODEC(ZSTD(1)),
    `tag_type` LowCardinality(String) CODEC(ZSTD(1)),
    `tag_data_type` LowCardinality(String) CODEC(ZSTD(1)),
    `string_value` String CODEC(ZSTD(1)),
    `number_value` Nullable(Float64) CODEC(ZSTD(1)),
    INDEX string_value_index string_value TYPE ngrambf_v1(4, 1024, 3, 0) GRANULARITY 1,
    INDEX number_value_index number_value TYPE minmax GRANULARITY 1
)
ENGINE = ReplacingMergeTree
PARTITION BY toDate(unix_milli / 1000)
ORDER BY (tag_key, tag_type, tag_data_type, string_value, number_value)
TTL toDateTime(unix_milli / 1000) + toIntervalSecond(1296000)
SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1, allow_nullable_key = 1
