ATTACH TABLE _ UUID '2ebb4b4f-ce2e-498c-b5cf-52cc49ecbecf'
(
    `name` String,
    `datatype` String,
    `timestamp` DateTime DEFAULT toDateTime(now())
)
ENGINE = ReplacingMergeTree
ORDER BY (name, datatype)
TTL timestamp + toIntervalDay(15)
SETTINGS index_granularity = 8192
