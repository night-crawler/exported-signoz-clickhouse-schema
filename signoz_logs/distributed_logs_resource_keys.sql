ATTACH TABLE _ UUID '5d6a968c-f89a-4b45-9da6-ed432939c979'
(
    `name` String,
    `datatype` String
)
ENGINE = Distributed('cluster', 'signoz_logs', 'logs_resource_keys', cityHash64(datatype))
