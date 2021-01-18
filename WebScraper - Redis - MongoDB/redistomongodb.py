from pymongo import MongoClient
import urllib.parse
import pandas
import time
import redis
import json

username = urllib.parse.quote_plus('admin')
password = urllib.parse.quote_plus('admin')
client = MongoClient('mongodb://%s:%s@127.0.0.1' % (username, password))

Blockchain_database = client["Blockchain_database"]
Col_TopTransactions = Blockchain_database["col_TopTransactions"]

r=redis.Redis(
    host='localhost',
    port=6379,
    password='password'
)

while True:

    Data = pandas.read_json(r.get('tx'))
    
    top_tx = Data.sort_values(by=["Current (USD)"], ascending=False).head(1).iloc[0]

    Col_TopTransactions.insert_one(top_tx.to_dict())
    print("Successfully added to the database")

    time.sleep(60)
