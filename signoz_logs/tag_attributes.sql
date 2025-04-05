ATTACH TABLE _ UUID 'fe6b61b6-253b-4bb8-baec-daa4c7e20e80'
(
    `timestamp` DateTime CODEC(ZSTD(1)),
    `tagKey` LowCardinality(String) CODEC(ZSTD(1)),
    `tagType` Enum8('tag' = 1, 'resource' = 2, 'scope' = 3) CODEC(ZSTD(1)),
    `tagDataType` Enum8('string' = 1, 'bool' = 2, 'int64' = 3, 'float64' = 4) CODEC(ZSTD(1)),
    `stringTagValue` String CODEC(ZSTD(1)),
    `int64TagValue` Nullable(Int64) CODEC(ZSTD(1)),
    `float64TagValue` Nullable(Float64) CODEC(ZSTD(1))
)
ENGINE = ReplacingMergeTree
ORDER BY (tagKey, tagType, tagDataType, stringTagValue, int64TagValue, float64TagValue)
TTL toDateTime(timestamp) + toIntervalSecond(172800)
SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1, allow_nullable_key = 1
