ATTACH MATERIALIZED VIEW _ UUID 'b4fcc9a6-d2f7-412c-8554-dfe1db065323' TO signoz_metrics.time_series_v4_6hrs
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
    floor(unix_milli / 21600000) * 21600000 AS unix_milli,
    labels,
    __normalized
FROM signoz_metrics.time_series_v4
