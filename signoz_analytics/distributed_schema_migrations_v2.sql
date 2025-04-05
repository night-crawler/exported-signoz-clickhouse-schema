ATTACH TABLE _ UUID '9a7ca72b-eb92-4215-87b6-278d5e3e29bb'
(
    `migration_id` UInt64,
    `status` String,
    `error` String,
    `created_at` DateTime64(9),
    `updated_at` DateTime64(9)
)
ENGINE = Distributed('cluster', 'signoz_analytics', 'schema_migrations_v2', rand())
