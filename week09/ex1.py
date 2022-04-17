import psycopg2
password = str(input('insert password for postgres:\n>'))
con = psycopg2.connect(database="dvdrental", user="postgres", password = password, host="127.0.0.1", port="5432")
print("Database is opened successfully")
cur = con.cursor()
cur.callproc('ex1', ('%11%', 400, 600))
row = cur.fetchone()
while row is not None:
    print(row)
    row = cur.fetchone()
cur.close()
