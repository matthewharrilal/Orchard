from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient
from bson.objectid import ObjectId
import bcrypt
import json
from CustomClass import JSONEncoder
from flask import jsonify
import pdb
from bson import BSON
from bson import json_util
from basicauth import decode
from bson.json_util import dumps

app = Flask(__name__)
client = MongoClient('mongodb://localhost:27017/')
app.db = client.orchard
database = app.db
rounds = app.bcrypt_rounds = 5
api = Api(app)
orchard_collection = database.orchard_collection


def authenticated_request(func):
    def wrapper(*args, **kwargs):
        auth = request.authorization

        auth_code = request.headers['authorization']
        email, password = decode(auth_code)
        if email is not None and password is not None:
            user_collection = database.posts
            user = user_collection.find_one({'email': email})
            if user is not None:
                encoded_password = password.encode('utf-8')
                if bcrypt.checkpw(encoded_password, user['password']):
                    return func(*args, **kwargs)
                else:
                    return ({'error': 'email or password is not correct'}, 401, None)
            else:
                return ({'error': 'could not find user in the database'}, 400, None)
        else:
            return ({'error': 'enter both email and password'}, 400, None)

    return wrapper

class User(Resource):
    # This class is to represent the users
    def post(self):
        # This function this is going to represent how we post the users
        requested_json = request.json

        # So we specfically have to get the password so we can essentially hash it in our server
        requested_password = request.json.get('password')

        # Once we have the users password we can now be able to encode the users password in plain text and then it can be hashed
        encoded_password = requested_password.encode('utf-8')
        hashed = bcrypt.hashpw(encoded_password, bcrypt.gensalt(rounds))
        requested_json['password'] = hashed

        if 'email' in requested_json and 'password' in requested_json:
            orchard_collection.insert_one(requested_json)
            requested_json.pop('password')
            print('The user has succesfully been implemented to the database')
            return(requested_json, 200, None)
        else:
            print("An error has occured trying to implement this document")
            return(None, 404, None)

    # def get(self):
    #     # This is essentially the function that we are going to be using to fetch the users
    #
    #     # Since we are fetching users we have to take whatever the user
    #
    #     pass




api.add_resource(User, '/orchard_users')

@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp
# Encodes our resouces for us


if __name__ == '__main__':
    # Turn this on in debug mode to get detailled information about request related exceptions: http://flask.pocoo.org/docs/0.10/config/
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)
