SELECT
    ts,
    histogramQuantile(arrayMap(x -> toFloat64(x), groupArray(le)), groupArray(value), 0.9) AS value
FROM
(
    SELECT
        le,
        ts,
        sum(per_series_value) AS value
    FROM
    (
        SELECT
            le,
            ts,
            If((per_series_value - lagInFrame(per_series_value, 1, 0) OVER rate_window) < 0, nan, If((ts - lagInFrame(ts, 1, toDate('1970-01-01')) OVER rate_window) >= 86400, nan, (per_series_value - lagInFrame(per_series_value, 1, 0) OVER rate_window) / (ts - lagInFrame(ts, 1, toDate('1970-01-01')) OVER rate_window))) AS per_series_value
        FROM
        (
            SELECT
                fingerprint,
                any(le) AS le,
                toStartOfInterval(toDateTime(intDiv(unix_milli, 1000)), toIntervalSecond(60)) AS ts,
                max(value) AS per_series_value
            FROM signoz_metrics.distributed_samples_v4
            INNER JOIN
            (
                SELECT DISTINCT
                    JSONExtractString(labels, 'le') AS le,
                    fingerprint
                FROM signoz_metrics.time_series_v4
                WHERE (metric_name IN ['exporter_prepare_metrics_duration_bucket']) AND (temporality = 'Cumulative') AND (__normalized = true) AND (unix_milli >= 1744740000000) AND (unix_milli < 1744746900000)
            ) AS filtered_time_series USING (fingerprint)
            WHERE (metric_name IN ['exporter_prepare_metrics_duration_bucket']) AND (unix_milli >= 1744743300000) AND (unix_milli < 1744746900000)
            GROUP BY
                fingerprint,
                ts
            ORDER BY
                fingerprint ASC,
                ts ASC
        )
        WINDOW rate_window AS (PARTITION BY fingerprint ORDER BY fingerprint ASC, ts ASC)
    )
    WHERE isNaN(per_series_value) = 0
    GROUP BY
        le,
        ts
    ORDER BY
        le ASC,
        ts ASC
)
GROUP BY ts
ORDER BY ts ASC

Query id: 6398bb9a-270a-483e-adb7-f5de0c9a2ff4

┌──────────────────ts─┬─────────────value─┐
│ 2025-04-15 18:56:00 │ 4.416666666666667 │
│ 2025-04-15 18:57:00 │ 4.416666666666667 │
│ 2025-04-15 18:58:00 │               4.5 │
│ 2025-04-15 18:59:00 │ 4.416666666666667 │
│ 2025-04-15 19:00:00 │               4.5 │
│ 2025-04-15 19:01:00 │ 4.300000000000001 │
│ 2025-04-15 19:02:00 │               4.5 │
│ 2025-04-15 19:03:00 │               4.5 │
│ 2025-04-15 19:04:00 │               4.5 │
│ 2025-04-15 19:05:00 │ 4.416666666666667 │
│ 2025-04-15 19:06:00 │               4.5 │
│ 2025-04-15 19:07:00 │               4.5 │
│ 2025-04-15 19:08:00 │               4.5 │
│ 2025-04-15 19:09:00 │               4.5 │
│ 2025-04-15 19:10:00 │ 4.300000000000001 │
│ 2025-04-15 19:11:00 │               4.5 │
│ 2025-04-15 19:12:00 │               4.5 │
│ 2025-04-15 19:13:00 │               4.5 │
│ 2025-04-15 19:14:00 │ 6.500000000000002 │
│ 2025-04-15 19:15:00 │               4.5 │
│ 2025-04-15 19:16:00 │               4.5 │
│ 2025-04-15 19:17:00 │               4.5 │
│ 2025-04-15 19:18:00 │ 4.416666666666667 │
│ 2025-04-15 19:19:00 │               4.5 │
│ 2025-04-15 19:20:00 │ 4.416666666666667 │
│ 2025-04-15 19:21:00 │               4.5 │
│ 2025-04-15 19:22:00 │               4.5 │
│ 2025-04-15 19:23:00 │               4.5 │
│ 2025-04-15 19:24:00 │               4.5 │
│ 2025-04-15 19:25:00 │               4.5 │
│ 2025-04-15 19:26:00 │ 4.416666666666667 │
│ 2025-04-15 19:27:00 │ 4.416666666666667 │
│ 2025-04-15 19:28:00 │               4.5 │
│ 2025-04-15 19:29:00 │               4.5 │
│ 2025-04-15 19:30:00 │               4.5 │
│ 2025-04-15 19:31:00 │ 4.416666666666667 │
│ 2025-04-15 19:32:00 │               4.5 │
│ 2025-04-15 19:33:00 │               4.5 │
│ 2025-04-15 19:34:00 │ 4.416666666666667 │
│ 2025-04-15 19:35:00 │               4.5 │
│ 2025-04-15 19:36:00 │               4.5 │
│ 2025-04-15 19:37:00 │ 4.416666666666667 │
│ 2025-04-15 19:38:00 │               4.5 │
│ 2025-04-15 19:39:00 │ 4.416666666666667 │
│ 2025-04-15 19:40:00 │               4.5 │
│ 2025-04-15 19:41:00 │ 4.416666666666667 │
│ 2025-04-15 19:42:00 │ 4.416666666666667 │
│ 2025-04-15 19:43:00 │ 4.416666666666667 │
│ 2025-04-15 19:44:00 │               4.5 │
│ 2025-04-15 19:45:00 │               4.5 │
│ 2025-04-15 19:46:00 │               4.5 │
│ 2025-04-15 19:47:00 │               4.5 │
│ 2025-04-15 19:48:00 │               4.5 │
│ 2025-04-15 19:49:00 │ 4.300000000000001 │
│ 2025-04-15 19:50:00 │               4.5 │
│ 2025-04-15 19:51:00 │               4.5 │
│ 2025-04-15 19:52:00 │               4.5 │
│ 2025-04-15 19:53:00 │ 4.416666666666667 │
│ 2025-04-15 19:54:00 │               4.5 │
└─────────────────────┴───────────────────┘

59 rows in set. Elapsed: 0.025 sec. Processed 35.53 thousand rows, 1.94 MB (1.40 million rows/s., 76.79 MB/s.)
Peak memory usage: 8.30 MiB.

