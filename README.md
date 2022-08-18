# transactions_sql


# MISCELLANEOUS SQLITE
ALTER TABLE account_statement_no_header RENAME TO swb;
DROP TABLE IF EXISTS "swb";
sqlite> .read drop_tables.sql
UPDATE employees SET lastname = 'Smith' WHERE employeeid = 3;
UPDATE swb SET mtpID = 3 WHERE swbID = 205;
UPDATE swb SET mtpID = 5 WHERE swbID = 219;
UPDATE nex SET mtpID = 11 WHERE nexID = 45;
UPDATE nex SET mtpID = 13 WHERE nexID = 52;

sqlite> SELECT * FROM mtp JOIN nex ON mtp.mtpID=nex.mtpID;


.output transactions_structure.sql
.schema




# HEADER 

1 Create database
    sqlite3 test.db

2 Import csv
    .mode csv
    .import account_statement.csv account_statement
    .import nex.csv nex
    .import mtpl.csv mtpl

3 Make SQL requests
    .schema account_statement
    SELECT * FROM account_statement WHERE NOT Type='Payouts';
    SELECT SUM("Gross amount (EUR)") FROM account_statement WHERE Type='Buy';


# NO HEADER

1-Files
    mtp.csv_brut //brut no header
    swb.csv_brut //brut no header
    nex.csv_brut //brut no header
    tmp_swb.csv
    tmp_mtp.csv
    tmp_nex.csv
    create_tables.sql
    drop_tables.sql

2-Create database and tables
    sqlite3 transactions.db < create_tables.sql
    sqlite3 transactions.db
    or
    sqlite3 transactions.db
    sqlite3> .read create_tables.sql

3-Check
    sqlite3 transactions.db
    sqlite> .tables
    sqlite> .schema swb
    sqlite> .schema mtp
    sqlite> .schema nex
    sqlite> .schema tmp_swb
    sqlite> .schema tmp_mtp
    sqlite> .schema tmp_nex

4-Import data and add primary key
    sqlite> .mode csv

    sqlite> .import tmp_swb.csv tmp_swb
    sqlite> INSERT INTO swb SELECT NULL,*,NULL FROM tmp_swb;

    sqlite> .import tmp_mtp.csv tmp_mtp
    sqlite> INSERT INTO mtp SELECT NULL,* FROM tmp_mtp;

    sqlite> .import tmp_nex.csv tmp_nex
    sqlite> INSERT INTO nex SELECT NULL,*,NULL FROM tmp_nex;


# MTP
    tac mtp.csv_brut > tmp_mtp.csv
    vim commands to refactor tmp_mtp.csv: 
        :%s/EUR/EUR,/g
        :%s/BTC/BTC,/g
        :%s/USDC/USDC,/g
        :%s/XDAI/XDAI,/g

    sqlite> SELECT * FROM mtp WHERE "Currency Out"='USDC';

    ALTER TABLE mtp ADD appID INTEGER REFERENCES app(appID); //fk on app id

    UPDATE mtp SET appID=5 WHERE mtpID=6 AND mtpID=7 AND mtpID=8 AND mtpID=9 AND mtpID=10;

    SELECT * FROM mtp JOIN app ON mtp.appID=app.appID;

# NEX
    tac nex.csv_brut > tmp_nex.csv
    vim commands to refactor tmp_nex.csv: 
        :%s/\$//g

    sqlite> SELECT Type,"Input Currency","Input Amount","Output Currency","Output Amount","USD Equivalent","Date / Time" FROM nex WHERE NOT Type='Interest'AND NOT Type='LockingTermDeposit';

    SELECT nexID,Type,"Input Currency","Input Amount","Output Currency","Output Amount","USD Equivalent","Date / Time" FROM nex WHERE Type='Deposit';


# SWB
    cp swb.csv_brut tmp_swb.csv

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
    Combien d'euros j'ai investi en CHSB ?
        SELECT SUM("NET amount (EUR)") FROM account_statement_no_header WHERE Type='Buy' AND Currency='CHSB';

9-Payouts
    Combien d'intérêts j'ai gagné sur le CHSB ?
        SELECT SUM("NET amount (EUR)") FROM account_statement_no_header WHERE Type='Payouts' AND Currency='CHSB';


# APP
sqlite> CREATE TABLE app(
   ...> appID INTEGER PRIMARY KEY AUTOINCREMENT,
   ...> "Name" TEXT);

INSERT INTO app("Name") VALUES('swb');
INSERT INTO app("Name") VALUES('nex');
INSERT INTO app("Name") VALUES('btc');
INSERT INTO app("Name") VALUES('met');
INSERT INTO app("Name") VALUES('bri');

# LINKS
https://www.smartdraw.com/entity-relationship-diagram/

