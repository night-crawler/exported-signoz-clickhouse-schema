ATTACH TABLE _ UUID '67cc244a-5590-4e29-a328-ba08fdb78df0'
(
    `tenant` String CODEC(ZSTD(1)),
    `collector_id` String CODEC(ZSTD(1)),
    `exporter_id` String CODEC(ZSTD(1)),
    `timestamp` DateTime CODEC(ZSTD(1)),
    `data` String CODEC(ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_traces', 'usage', cityHash64(rand()))
