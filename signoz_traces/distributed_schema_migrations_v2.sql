ATTACH TABLE _ UUID '7656df5d-bd2e-4367-b37a-21623f996f7f'
(
    `migration_id` UInt64,
    `status` String,
    `error` String,
    `created_at` DateTime64(9),
    `updated_at` DateTime64(9)
)
ENGINE = Distributed('cluster', 'signoz_traces', 'schema_migrations_v2', rand())
