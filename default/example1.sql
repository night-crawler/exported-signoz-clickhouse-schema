ATTACH TABLE _ UUID '80926524-b4c3-4b8c-a463-54e56ec72b6a'
(
    `event_id` UInt64,
    `props.key` Array(LowCardinality(String)),
    `props.value_str` Array(String),
    `props.value_int` Array(Int32),
    `props.value_float` Array(Float64)
)
ENGINE = MergeTree
ORDER BY event_id
SETTINGS index_granularity = 8192
