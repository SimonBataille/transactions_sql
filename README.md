# transactions_sql

# MISCELLANEOUS SQLITE
ALTER TABLE account_statement_no_header RENAME TO swb;
DROP TABLE IF EXISTS "swb";
sqlite> .read droptables.sql
UPDATE employees SET lastname = 'Smith' WHERE employeeid = 3;
UPDATE swb SET mtpID = 12 WHERE swbID = 205;
UPDATE swb SET mtpID = 10 WHERE swbID = 219;

# HEADER 

1 Create database
    sqlite3 test.db

2 Import csv
    .mode csv
    .import account_statement.csv account_statement
    .import mtpl.csv mtpl

3 Make SQL requests
    .schema account_statement
    SELECT * FROM account_statement WHERE NOT Type='Payouts';
    SELECT SUM("Gross amount (EUR)") FROM account_statement WHERE Type='Buy';


# NO HEADER

1-Files
    swb.csv
    mtp.csv
    myscript.sql

2-Create database and tables
    sqlite3 transactions.db < myscript.sql
    sqlite3 transactions.db
    or
    sqlite3 
    sqlite3> .read myscript.sql

3-Check
    sqlite3 transactions.db
    sqlite> .tables
    sqlite> .schema swb
    sqlite> .schema mtp

4-Import data and add primary key
    sqlite> .mode csv

    sqlite> .import swb.csv tmp_swb
    sqlite> INSERT INTO swb SELECT NULL,*, FROM tmp_swb;

    sqlite> .import mtp.csv tmp_mtp
    sqlite> INSERT INTO mtp SELECT NULL,* FROM tmp_mtp;



# MTP
    vim commands to refactor : 
        :%s/EUR/EUR,/g
        :%s/BTC/BTC,/g
        :%s/USDC/USDC,/g
        :%s/XDAI/XDAI,/g

# SWB

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

