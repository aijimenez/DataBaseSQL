# Database "sql_airbnb"

## Description

The database "sql_airbnb" contains information about users who wish to offer and rent an accommodation, as well as data about the accommodations offered, their reservations and payments.

## Table of contents
* [Prerequisites](#Prerequisites)
* [Installation](#Installation)
* [Testing](#Testing)
* [Metadata](#Metadata)

## Prerequisites
* MySQL 8.0.33
* A database management system that supports SQL

## Installation

**Step 1: Install MySQL**  

The database was developed in MySQL version 8.0.33. In order to use it, it is necessary to [install MySQL](https://www.mysql.com/de/downloads/) or an equivalent database management system.

**Step 2: Download SQL-Files**

Create a folder with the desired name, download and save the following [raw SQL-Files](https://github.com/aijimenez/DataBaseSQL/tree/main/SQLFiles) found on ``github``:

* CreateDB.sql
* DataDB.sql
* TestDB.sql
* MetadataDB.sql

**Step 4: Import SQL-File**  

1. Open MySQL Workbench
2. Open the downloaded SQL Scripts in MySQL Workbench:

* CreateDB.sql
* DataDB.sql
* TestDB.sql
* MetadataDB.sql

3. Execute the downloaded SQL Scripts in the following order:

* ``CreateDB.sql``: By executing this script the database is created.
* ``DataDB.sql``: The database is populated

The database is ready to be used.

## Testing

**Optional Step: Use of the TestDB-file**

In order to test the proper functioning of the database, some queries were executed. If desired, these queries are available to be executed individually in the script named ``TestDB.sql``

## Metadata

**Optional Step: Use of the MetadataDB-file**

The queries found in the ``MetadataDB`` script provide information about the size of the database, the number of tables that comprise the database and allow to display a table with detailed descriptions of each table.
