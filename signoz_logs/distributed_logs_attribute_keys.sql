ATTACH TABLE _ UUID '3c41233f-a8cb-40c3-9c97-0d6c24408946'
(
    `name` String,
    `datatype` String
)
ENGINE = Distributed('cluster', 'signoz_logs', 'logs_attribute_keys', cityHash64(datatype))
