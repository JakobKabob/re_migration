from pymongo import MongoClient 
import psycopg2
from dotenv import load_dotenv
from os import environ

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

with open('sql/recommendationengine.sql', 'r') as file:
    creation_sql = file.read()

curr = conn.cursor()

curr.execute(creation_sql)

conn.commit()
