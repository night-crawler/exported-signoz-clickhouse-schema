ATTACH TABLE _ UUID '13ae4e76-6d02-4f11-98cc-299cfd22220e'
(
    `timestamp` DateTime64(9) CODEC(DoubleDelta, LZ4),
    `traceID` FixedString(32) CODEC(ZSTD(1)),
    `spanID` String CODEC(ZSTD(1)),
    `parentSpanID` String CODEC(ZSTD(1)),
    `serviceName` LowCardinality(String) CODEC(ZSTD(1)),
    `name` LowCardinality(String) CODEC(ZSTD(1)),
    `kind` Int8 CODEC(T64, ZSTD(1)),
    `durationNano` UInt64 CODEC(T64, ZSTD(1)),
    `statusCode` Int16 CODEC(T64, ZSTD(1)),
    `httpMethod` LowCardinality(String) CODEC(ZSTD(1)),
    `httpUrl` LowCardinality(String) CODEC(ZSTD(1)),
    `httpRoute` LowCardinality(String) CODEC(ZSTD(1)),
    `httpHost` LowCardinality(String) CODEC(ZSTD(1)),
    `hasError` Bool CODEC(T64, ZSTD(1)),
    `rpcSystem` LowCardinality(String) CODEC(ZSTD(1)),
    `rpcService` LowCardinality(String) CODEC(ZSTD(1)),
    `rpcMethod` LowCardinality(String) CODEC(ZSTD(1)),
    `responseStatusCode` LowCardinality(String) CODEC(ZSTD(1)),
    `stringTagMap` Map(String, String) CODEC(ZSTD(1)),
    `numberTagMap` Map(String, Float64) CODEC(ZSTD(1)),
    `boolTagMap` Map(String, Bool) CODEC(ZSTD(1)),
    `isRemote` LowCardinality(String) CODEC(ZSTD(1)),
    `statusMessage` String CODEC(ZSTD(1)),
    `statusCodeString` String CODEC(ZSTD(1)),
    `spanKind` String CODEC(ZSTD(1)),
    INDEX idx_service serviceName TYPE bloom_filter GRANULARITY 4,
    INDEX idx_name name TYPE bloom_filter GRANULARITY 4,
    INDEX idx_kind kind TYPE minmax GRANULARITY 4,
    INDEX idx_duration durationNano TYPE minmax GRANULARITY 1,
    INDEX idx_hasError hasError TYPE set(2) GRANULARITY 1,
    INDEX idx_httpRoute httpRoute TYPE bloom_filter GRANULARITY 4,
    INDEX idx_httpUrl httpUrl TYPE bloom_filter GRANULARITY 4,
    INDEX idx_httpHost httpHost TYPE bloom_filter GRANULARITY 4,
    INDEX idx_httpMethod httpMethod TYPE bloom_filter GRANULARITY 4,
    INDEX idx_timestamp timestamp TYPE minmax GRANULARITY 1,
    INDEX idx_rpcMethod rpcMethod TYPE bloom_filter GRANULARITY 4,
    INDEX idx_responseStatusCode responseStatusCode TYPE set(0) GRANULARITY 1
)
ENGINE = MergeTree
PARTITION BY toDate(timestamp)
ORDER BY (durationNano, timestamp)
TTL toDateTime(timestamp) + toIntervalSecond(1296000)
SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1
