ATTACH TABLE _ UUID '7060bec0-a21e-4532-b2ba-97f38979b6a4'
(
    `unix_milli` Int64 CODEC(Delta(8), ZSTD(1)),
    `tag_key` String CODEC(ZSTD(1)),
    `tag_type` LowCardinality(String) CODEC(ZSTD(1)),
    `tag_data_type` LowCardinality(String) CODEC(ZSTD(1)),
    `string_value` String CODEC(ZSTD(1)),
    `number_value` Nullable(Float64) CODEC(ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_logs', 'tag_attributes_v2', cityHash64(rand()))
