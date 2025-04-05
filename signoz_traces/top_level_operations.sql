ATTACH TABLE _ UUID 'dcec64d3-fd5d-4c33-a4bb-f12c9e65d2ea'
(
    `name` LowCardinality(String) CODEC(ZSTD(1)),
    `serviceName` LowCardinality(String) CODEC(ZSTD(1)),
    `time` DateTime DEFAULT now() CODEC(ZSTD(1))
)
ENGINE = ReplacingMergeTree
ORDER BY (serviceName, name)
TTL time + toIntervalMonth(1)
SETTINGS index_granularity = 8192
