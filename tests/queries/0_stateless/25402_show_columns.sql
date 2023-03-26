CREATE OR REPLACE TABLE TAB
(
    `u64` UInt64,
    `i32` Nullable(Int32),
    `s` String,
    INDEX idx s TYPE set(1000)
)
ENGINE = MergeTree
ORDER BY u64;

SHOW COLUMNS FROM TAB;

DROP TABLE TAB;
