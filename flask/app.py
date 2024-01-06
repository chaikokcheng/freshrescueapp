# from flask import Flask
# from pymongo import MongoClient
# from pymongo.server_api import ServerApi

# app = Flask(__name__)

# uri = "mongodb+srv://kokcheng666:031015130185@cosmos.do9zn44.mongodb.net/?retryWrites=true&w=majority"
# client = MongoClient(uri, server_api=ServerApi('1'))

# try:
#     client.admin.command('ping')
#     print("Pinged your deployment. You successfully connected to MongoDB!")
# except Exception as e:
#     print(f"An error occurred: {e}")


# @app.route('/')
# def hello_world():
#     return 'Connected to MongoDB Atlas!'

# if __name__ == '__main__':
#     app.run(debug=True)



from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
uri = "mongodb+srv://kokcheng666:chaikokcheng@cosmos.do9zn44.mongodb.net/?retryWrites=true&w=majority"
# Create a new client and connect to the server
client = MongoClient(uri, server_api=ServerApi('1'))
# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)

