# transactions_sql

# HEADER 

1 Create database
    sqlite3 test.db

2 Import csv
    .mode csv
    .import account_statement.csv account_statement

3 Make SQL requests
    .schema account_statement
    SELECT * FROM account_statement WHERE NOT Type='Payouts';
    SELECT SUM("Gross amount (EUR)") FROM account_statement WHERE Type='Buy';


# NO HEADER

1-Files
    acccount_statement_no_header.csv
    myscript.sql

2-Create database and tables
    sqlite3 transactions.db < myscript.sql
    sqlite3 transactions.db

3-Check
    sqlite3 transactions.db
    sqlite> .tables
    sqlite> .schema account_statement_no_header

4-Import data
    sqlite> .mode csv
    sqlite> .import account_statement_no_header.csv account_statement_no_header

5-SQL requests
    sqlite> SELECT * FROM account_statement_no_header WHERE Type='Buy';
    sqlite> SELECT DISTINCT Type FROM ;
    sqlite> SELECT SUM("Gross amount") FROM account_statement_no_header WHERE Type='Deposit' AND Currency='EUR';
    sqlite> DROP TABLE IF EXISTS account_statement_no_header;

# LINKS
https://www.smartdraw.com/entity-relationship-diagram/

