from flask import Flask, render_template, redirect

# Import our pymongo library, which lets us connect our Flask app to our Mongo database.
from flask_pymongo import PyMongo
import pymongo

# Create an instance of our Flask app.
app = Flask(__name__)

# Set route
@app.route('/')
def index():
    # Store the entire team collection in a list
    teams = list(db.team.find())
    print(teams)

    # Return the template with the teams list passed in
    return render_template('index.html', teams=teams)


if __name__ == "__main__":
    app.run(debug=True)
 




