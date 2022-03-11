from pymongo import MongoClient 
import psycopg2
from dotenv import load_dotenv
from os import environ
from pprint import pprint

load_dotenv()

# drop and create new tables
def drop_tables(conn):
    print('drop_tables')
    with open('sql/recommendationengine_drop.sql', 'r') as file:
        sql = file.read()
    curr = conn.cursor()
    curr.execute(sql)
    conn.commit()

def create_tables(conn):
    print('create tables')
    with open('sql/recommendationengine_create.sql', 'r') as file:
        sql = file.read()
    curr = conn.cursor()
    curr.execute(sql)
    conn.commit()

# migrate
def migrate(migration, pg_conn, mongo_cursor):
    print(migration.__name__)

    while True:
        try: 
            _this = mongo_cursor.next()
            migration(_this, pg_conn.cursor())
        except StopIteration:
            pg_conn.commit()
            print('successfull migration of', migration.__name__) 
            break

def format_str(string: str):
    try: 
        string = string.replace("'","''")
    except Exception as err:

        print(string)
        raise err
    return "'"+string+"'"

def product(row, curr):
    # useless without either
    if 'deeplink' not in row or 'name' not in row:
        print('skipped incomplete item: ', row['_id'], '>no name or deeplink')
        return
    elif 'mrsp' not in row['price']:
        print('skipped incomplete item: ', row['_id'], '>price tags missing')
        return


    # product table (main)
    sql = '''
        INSERT INTO product(
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
            row['recommendable'] if 'recommendable' in row else 'NULL',
        )
    ) 

    # price table
    sql = '''
        INSERT INTO price(
            product_id,
            mrsp,
            selling_price
        ) VALUES (%s, %s, %s)
        '''

    curr.execute(sql % (
            format_str(row['_id']),
            row['price']['mrsp'],
            row['price']['selling_price']
        )
    )

def visitor(row, curr):
    # useless without either
    if False:
        print('skipped incomplete item: ', row['_id'], '>no name or deeplink')
        return


    # visitor table
    sql = '''
        INSERT INTO visitor(
            _id,
            origin,
            order_count
        ) VALUES (%s, %s, %s)
        '''
    try:
        curr.execute(sql % (
                format_str(str(row['_id'])),
                format_str(row['origin'][0]) if 'origin' in row and len(row['origin']) > 0 else 'NULL',
                row['order']['count'] if 'order' in row and 'count' in row['order'] else 'NULL'
                ))

    except Exception as err:
        pprint(row)
        raise err
        exit()

    sql = '''
        INSERT INTO previously_recommended(
            visitor_id,
            product_id
        ) VALUES (%s, %s)
        '''
    if 'previously_recommended' in row:
        for p_id in row['previously_recommended']:
            try:
                curr.execute(sql % (
                        format_str(str(row['_id'])),
                        format_str(p_id)
                        ))
            except Exception as err:
                pprint(row)
                print(err)
                raise err
                exit()

    #buids 
    sql = '''
        INSERT INTO buid(
            visitor_id,
            buid
        ) VALUES (%s, %s)
        '''
    if 'buid' in row:
        for buid in row['buids']:
            try:
                curr.execute(sql % (
                        format_str(str(row['_id'])),
                        format_str(buid)
                        ))
            except Exception as err:
                pprint(row)
                print(err)
                raise err
                exit()


def session(row, curr):
    # useless without either
    if False:
        print('skipped incomplete item: ', row['_id'], '>no name or deeplink')
        return


    # session table
    sql = '''
        INSERT INTO session(
            _id,
            session_start,
            session_end,
            has_sale,
            buid 
        ) VALUES (%s, '%s', '%s', %s, %s)
        '''
    try:
        curr.execute(sql % (
                format_str(row['_id']),
                row['session_start'], 
                row['session_end'], 
                row['has_sale'], 
                format_str(row['buid'][0])
                ))
    except Exception as err:
        pprint(row)
        print(err)
        raise Exception('aaa')
        exit()

    sql = '''
        INSERT INTO bought_product(
            session_id,
            product_id,
             
        ) VALUES (%s, %s)
        '''
    if 'order' in row and row['order']:
        for prod in row['order']['products']:
            try:
                curr.execute(sql % (
                        format_str(row['_id']),
                        format_str(prod['id'])
                        ))
            except Exception as err:
                pprint(row)
                print(err)
                raise Exception('bbb')
                exit()


if __name__ == '__main__':
    # mongo db
    client = MongoClient('127.0.0.1:27017')
    mg_conn = client.admin

    # postgres db
    pg_conn = psycopg2.connect(
            host="localhost",
            database="huwebshop",
            user="postgres",
            password=environ['pgpassw']
           )

    drop_tables(pg_conn)
    create_tables(pg_conn)
    #migrate(product, pg_conn, mg_conn.products.find())
    migrate(visitor, pg_conn, mg_conn.visitors.find())
    #migrate(session, pg_conn, mg_conn.sessions.find())

