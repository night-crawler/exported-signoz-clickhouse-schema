ATTACH TABLE _ UUID 'a7e2cfd4-0e2b-4cfb-a34b-47a9f24333f7'
(
    `labels` String CODEC(ZSTD(5)),
    `fingerprint` String CODEC(ZSTD(1)),
    `seen_at_ts_bucket_start` Int64 CODEC(Delta(8), ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_logs', 'logs_v2_resource', cityHash64(labels, fingerprint))
