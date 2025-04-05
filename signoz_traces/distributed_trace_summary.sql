ATTACH TABLE _ UUID 'fb962b51-b011-4474-8e7c-795ac5c0f30c'
(
    `trace_id` String CODEC(ZSTD(1)),
    `start` SimpleAggregateFunction(min, DateTime64(9)) CODEC(ZSTD(1)),
    `end` SimpleAggregateFunction(max, DateTime64(9)) CODEC(ZSTD(1)),
    `num_spans` SimpleAggregateFunction(sum, UInt64) CODEC(ZSTD(1))
)
ENGINE = Distributed('cluster', 'signoz_traces', 'trace_summary', cityHash64(trace_id))
