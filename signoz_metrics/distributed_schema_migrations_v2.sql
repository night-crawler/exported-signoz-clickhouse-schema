ATTACH TABLE _ UUID '7f4cd07a-6846-491e-8354-61d65e09cbbb'
(
    `migration_id` UInt64,
    `status` String,
    `error` String,
    `created_at` DateTime64(9),
    `updated_at` DateTime64(9)
)
ENGINE = Distributed('cluster', 'signoz_metrics', 'schema_migrations_v2', rand())
