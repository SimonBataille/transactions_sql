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


6-Deposit
    Combien j'ai déposé en tout sur Swissborg en euro ? (Dépôts totaux convertis en euro)
        SELECT SUM("Gross amount (EUR)") FROM account_statement_no_header WHERE Type='Deposit';

    Combien d'euros j'ai déposé sur Swissborg ? (Dépôt total euro)
        SELECT SUM("Gross amount") FROM account_statement_no_header WHERE Type='Deposit' AND Currency='EUR';

    Combien de BTC j'ai déposé sur Swissborg ?
        SELECT SUM("Gross amount") FROM account_statement_no_header WHERE Type='Deposit' AND Currency='BTC';

    Combien de BTC j'ai déposé sur Swissborg en euro ?
        SELECT SUM("Gross amount (EUR)") FROM account_statement_no_header WHERE Type='Deposit' AND Currency='BTC';

7-Sell
    Combien d'euros j'ai dépensé en tout sur Swissborg ? (Doit être égal à dépôt total en euros) 
        SELECT SUM("Gross amount (EUR)") FROM account_statement_no_header WHERE Type='Sell' AND Currency='EUR';
        
8-Buy
    Combien d'euros j'ai investi en ETH ?
        SELECT SUM("NET amount (EUR)") FROM account_statement_no_header WHERE Type='Buy' AND Currency='ETH';

9-Payouts
    Combien d'intérêts j'ai gagné sur le ETH ?
        SELECT SUM("NET amount (EUR)") FROM account_statement_no_header WHERE Type='Payouts' AND Currency='ETH';

# LINKS
https://www.smartdraw.com/entity-relationship-diagram/

