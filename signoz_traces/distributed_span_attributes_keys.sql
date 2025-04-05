ATTACH TABLE _ UUID '9ddba5c6-b00c-436d-ab2c-32520f5ed35c'
(
    `tagKey` LowCardinality(String) CODEC(ZSTD(1)),
    `tagType` Enum8('tag' = 1, 'resource' = 2) CODEC(ZSTD(1)),
    `dataType` Enum8('string' = 1, 'bool' = 2, 'float64' = 3) CODEC(ZSTD(1)),
    `isColumn` Bool CODEC(ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_traces', 'span_attributes_keys', cityHash64(rand()))
