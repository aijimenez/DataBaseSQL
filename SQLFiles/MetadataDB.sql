-- Provides the size of the database
SELECT
SUM(ROUND(((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024), 2)) AS "SizeInMB"
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = "sql_airbnb";

-- Provides the number of tables in the DB
SELECT COUNT(*) AS NumberTables
FROM information_schema.tables
WHERE table_schema = 'sql_airbnb';

-- Provides information about the database tables.
SELECT
    TABLE_NAME, ENGINE, VERSION, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH,
    DATA_LENGTH, INDEX_LENGTH, AUTO_INCREMENT,
    CREATE_TIME, UPDATE_TIME, TABLE_COLLATION
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_schema = 'sql_airbnb';
