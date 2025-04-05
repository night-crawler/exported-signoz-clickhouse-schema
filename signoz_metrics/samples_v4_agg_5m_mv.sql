ATTACH MATERIALIZED VIEW _ UUID '652f610f-cc98-4f42-af03-9e6ad8a37c8d' TO signoz_metrics.samples_v4_agg_5m
(
    `env` LowCardinality(String),
    `temporality` LowCardinality(String),
    `metric_name` LowCardinality(String),
    `fingerprint` UInt64,
    `unix_milli` Int64,
    `last` Float64,
    `min` Float64,
    `max` Float64,
    `sum` Float64,
    `count` UInt64
) AS
SELECT
    env,
    temporality,
    metric_name,
    fingerprint,
    intDiv(unix_milli, 300000) * 300000 AS unix_milli,
    anyLast(value) AS last,
    min(value) AS min,
    max(value) AS max,
    sum(value) AS sum,
    count(*) AS count
FROM signoz_metrics.samples_v4
GROUP BY
    env,
    temporality,
    metric_name,
    fingerprint,
    unix_milli
