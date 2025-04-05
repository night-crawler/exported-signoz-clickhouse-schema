ATTACH TABLE _ UUID '11bf4fdf-edb0-403e-819e-765a806e559f'
(
    `labels` String CODEC(ZSTD(5)),
    `fingerprint` String CODEC(ZSTD(1)),
    `seen_at_ts_bucket_start` Int64 CODEC(Delta(8), ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_traces', 'traces_v3_resource', cityHash64(labels, fingerprint))
