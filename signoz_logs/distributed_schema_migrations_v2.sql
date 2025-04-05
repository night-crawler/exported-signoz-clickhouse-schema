ATTACH TABLE _ UUID 'd1c325ee-bbc8-47e5-9e11-11cc991607b4'
(
    `migration_id` UInt64,
    `status` String,
    `error` String,
    `created_at` DateTime64(9),
    `updated_at` DateTime64(9)
)
ENGINE = Distributed('cluster', 'signoz_logs', 'schema_migrations_v2', rand())
