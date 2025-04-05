ATTACH MATERIALIZED VIEW _ UUID '643cbc78-b59a-47b6-94a9-d8e30ec4865b' TO signoz_metrics.time_series_v4_1day
(
    `env` LowCardinality(String),
    `temporality` LowCardinality(String),
    `metric_name` LowCardinality(String),
    `description` LowCardinality(String),
    `unit` LowCardinality(String),
    `type` LowCardinality(String),
    `is_monotonic` Bool,
    `fingerprint` UInt64,
    `unix_milli` Float64,
    `labels` String,
    `attrs` Map(LowCardinality(String), String),
    `scope_attrs` Map(LowCardinality(String), String),
    `resource_attrs` Map(LowCardinality(String), String),
    `__normalized` Bool
) AS
SELECT
    env,
    temporality,
    metric_name,
    description,
    unit,
    type,
    is_monotonic,
    fingerprint,
    floor(unix_milli / 86400000) * 86400000 AS unix_milli,
    labels,
    attrs,
    scope_attrs,
    resource_attrs,
    __normalized
FROM signoz_metrics.time_series_v4_6hrs
