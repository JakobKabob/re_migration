from pymongo import MongoClient 
import psycopg2
from dotenv import load_dotenv
from os import environ
from pprint import pprint

load_dotenv()

# mongo db
client = MongoClient('127.0.0.1:27017')
db = client.admin

# postgres db
conn = psycopg2.connect(
        host="localhost",
        database="huwebshop",
        user="postgres",
        password=environ['pgpassw']
       )

print('recreate tables')
# drop and create new tables
with open('sql/recommendationengine_create.sql', 'r') as file:
    creation_sql = file.read()
with open('sql/recommendationengine_drop.sql', 'r') as file:
    dropping_sql = file.read()

curr = conn.cursor()
curr.execute(dropping_sql)
curr.execute(creation_sql)
conn.commit()

# migrate
def migrate(migration):
    cursor = db.products.find()
    while True:
        try: 
            _this = cursor.next()
            migration(_this)
        except StopIteration:
            conn.commit()
            print('successfull migration') 
            break

def format_str(string: str):
    string = string.replace("'","''")
    return "'"+string+"'"
def migrate_products(row):
    # useless without either
    if 'deeplink' not in row or 'name' not in row:
        return

    sql = '''
        INSERT INTO products(
            _id,
            deeplink,
            name,
            recommendable
        ) VALUES (%s, %s, %s, %s)
        '''

    curr.execute(sql % (
            format_str(row['_id']),
            format_str(row['deeplink']), 
            format_str(row['name']), 
            row['recommendable'] if 'recommendable' in row else 'NULL'
        )
    ) 

print('migrate_products')
migrate(migrate_products)

