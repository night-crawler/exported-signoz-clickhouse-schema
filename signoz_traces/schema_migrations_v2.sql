ATTACH TABLE _ UUID 'cad97a8f-1f2b-4713-ba47-a83ae01a298b'
(
    `migration_id` UInt64,
    `status` String,
    `error` String,
    `created_at` DateTime64(9),
    `updated_at` DateTime64(9)
)
ENGINE = ReplacingMergeTree
PRIMARY KEY migration_id
ORDER BY migration_id
SETTINGS index_granularity = 8192
