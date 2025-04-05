ATTACH TABLE _ UUID '4012e43d-8f89-4d27-a4a5-8d4341efd4d6'
(
    `name` String,
    `datatype` String,
    `timestamp` DateTime DEFAULT toDateTime(now())
)
ENGINE = ReplacingMergeTree
ORDER BY (name, datatype)
TTL timestamp + toIntervalDay(15)
SETTINGS index_granularity = 8192
