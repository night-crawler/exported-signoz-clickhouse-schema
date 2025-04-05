ATTACH TABLE _ UUID '8b3840a7-66c5-477d-8cbe-e25f3712bff6'
(
    `timestamp` DateTime64(9) CODEC(DoubleDelta, LZ4),
    `traceID` FixedString(32) CODEC(ZSTD(1)),
    `model` String CODEC(ZSTD(9))
)
ENGINE = Distributed('cluster', 'signoz_traces', 'signoz_spans', cityHash64(traceID))
