ATTACH TABLE _ UUID 'b4d040ad-57c7-49d3-b90b-e4f98bfca5c1'
(
    `hostname` LowCardinality(String),
    `event_date` Date,
    `event_time` DateTime,
    `event_time_microseconds` DateTime64(6),
    `view_duration_ms` UInt64,
    `initial_query_id` String,
    `view_name` String,
    `view_uuid` UUID,
    `view_type` Enum8('Default' = 1, 'Materialized' = 2, 'Live' = 3, 'Window' = 4),
    `view_query` String,
    `view_target` String,
    `read_rows` UInt64,
    `read_bytes` UInt64,
    `written_rows` UInt64,
    `written_bytes` UInt64,
    `peak_memory_usage` Int64,
    `ProfileEvents` Map(String, UInt64),
    `status` Enum8('QueryStart' = 1, 'QueryFinish' = 2, 'ExceptionBeforeStart' = 3, 'ExceptionWhileProcessing' = 4),
    `exception_code` Int32,
    `exception` String,
    `stack_trace` String,
    `ProfileEvents.Names` Array(String) ALIAS mapKeys(ProfileEvents),
    `ProfileEvents.Values` Array(UInt64) ALIAS mapValues(ProfileEvents)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_date)
ORDER BY (event_date, event_time)
SETTINGS index_granularity = 8192
COMMENT 'Contains information about the dependent views executed when running a query, for example, the view type or the execution time.'
