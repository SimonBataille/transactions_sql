import sqlite3
from sqlite3 import Error


def create_connection(db_file):
    """ create a database connection to the SQLite database
        specified by the db_file
    :param db_file: database file
    :return: Connection object or None
    """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
    except Error as e:
        print(e)

    return conn


def select_all_transactions(conn):
    """
    Query all rows in the account_statement_no_header table
    :param conn: the Connection object
    :return:
    """
    cur = conn.cursor()
    cur.execute("SELECT * FROM account_statement_no_header")

    rows = cur.fetchall()

    for row in rows:
        print(row)


def select_transactions_by_type(conn, transaction_type):
    """
    Query transactions by type
    :param conn: the Connection object
    :param type:
    :return:
    """
    cur = conn.cursor()
    cur.execute("SELECT * FROM account_statement_no_header WHERE Type=?", (transaction_type,))
    rows = cur.fetchall()

    for row in rows:
        print(row)


def compute_total_by_currency_and_type(conn, currency, transaction_type):
    """
    Query total money by currency and type
    :param conn: the Connection object
    :param type:
    :param currency
    :return: total money
    """
    cur = conn.cursor()
    cur.execute("SELECT SUM(\"Gross amount\") FROM account_statement_no_header WHERE Type=? AND Currency=?", (currency, transaction_type,))
    rows = cur.fetchall()

    for row in rows:
        print(row)


def main():
    database = r"database.db"

    # create a database connection
    conn = create_connection(database)
    with conn:
        print("1. Query transactions by Type:")
        select_transactions_by_type(conn, 'Buy')

        print("2. Query all transactions")
        select_all_transactions(conn)

        print("3. Query total by currency and type")
        compute_total_by_currency_and_type(conn, 'Deposit', 'EUR')

if __name__ == '__main__':
    main()
