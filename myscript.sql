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
CREATE TABLE mtp(
      mtpID INTEGER PRIMARY KEY AUTOINCREMENT,
      "Date" TEXT,
      "Origin" TEXT,
      "Currency In" TEXT,
      "In" REAL,
      "Destination" TEXT,
      "Currency Out" TEXT,
      "Out" REAL
);
CREATE TABLE tmp_mtp(
      "Date" TEXT,
      "Origin" TEXT,
      "Currency In" TEXT,
      "In" REAL,
      "Destination" TEXT,
      "Currency Out" TEXT,
      "Out" REAL
);
