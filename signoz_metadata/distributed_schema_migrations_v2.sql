ATTACH TABLE _ UUID '177207e3-fb51-48f1-9cb9-02ec2c4f032a'
(
    `migration_id` UInt64,
    `status` String,
    `error` String,
    `created_at` DateTime64(9),
    `updated_at` DateTime64(9)
)
ENGINE = Distributed('cluster', 'signoz_metadata', 'schema_migrations_v2', rand())
