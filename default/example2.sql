ATTACH TABLE _ UUID '9d77ff1b-c679-4499-82ae-2ada41a5c7ea'
(
    `event_id` UInt64,
    `props` Map(LowCardinality(String), Nested(value_str String, value_int Int32, value_float Float64))
)
ENGINE = MergeTree
ORDER BY event_id
SETTINGS index_granularity = 8192
