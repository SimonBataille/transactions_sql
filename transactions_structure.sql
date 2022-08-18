CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE swb(
      swbID INTEGER PRIMARY KEY AUTOINCREMENT,
      "Local time" TEXT,
      "Time in UTC" TEXT,
      "Type" TEXT,
      "Currency" TEXT,
      "Gross amount" REAL,
      "Gross amount (EUR)" REAL,
      "Fee" REAL,
      "Fee (EUR)" REAL,
      "Net amount" REAL,
      "Net amount (EUR)" REAL,
      "Note" TEXT,
      mtpID INTEGER,
      FOREIGN KEY (mtpID)
           REFERENCES mtp (mtpID)
);
CREATE TABLE tmp_swb(
      "Local time" TEXT,
      "Time in UTC" TEXT,
      "Type" TEXT,
      "Currency" TEXT,
      "Gross amount" REAL,
      "Gross amount (EUR)" REAL,
      "Fee" REAL,
      "Fee (EUR)" REAL,
      "Net amount" REAL,
      "Net amount (EUR)" REAL,
      "Note" TEXT
);
CREATE TABLE nex(
      nexID INTEGER PRIMARY KEY AUTOINCREMENT,
      "Transaction" TEXT,
      "Type" TEXT,
      "Input Currency" TEXT,
      "Input Amount" REAL,
      "Output Currency" TEXT,
      "Output Amount" REAL,
      "USD Equivalent" REAL,
      "Details" TEXT,
      "Outstanding Loan" TEXT,
      "Date / Time" TEXT,
      mtpID INTEGER,
      FOREIGN KEY (mtpID)
           REFERENCES mtp (mtpID)
);
CREATE TABLE tmp_nex(
      "Transaction" TEXT,
      "Type" TEXT,
      "Input Currency" TEXT,
      "Input Amount" REAL,
      "Output Currency" TEXT,
      "Output Amount" REAL,
      "USD Equivalent" REAL,
      "Details" TEXT,
      "Outstanding Loan" TEXT,
      "Date / Time" TEXT
);
CREATE TABLE mtp(
      mtpID INTEGER PRIMARY KEY AUTOINCREMENT,
      "Date" TEXT,
      "Origin" TEXT,
      "Currency In" TEXT,
      "In" REAL,
      "Destination" TEXT,
      "Currency Out" TEXT,
      "Out" REAL
, appID INTEGER REFERENCES app(appID));
CREATE TABLE tmp_mtp(
      "Date" TEXT,
      "Origin" TEXT,
      "Currency In" TEXT,
      "In" REAL,
      "Destination" TEXT,
      "Currency Out" TEXT,
      "Out" REAL
);
CREATE TABLE app(
appID INTEGER PRIMARY KEY AUTOINCREMENT,
"Name" TEXT);
