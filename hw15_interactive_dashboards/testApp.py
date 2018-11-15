import os

import pandas as pd
import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine

from flask import Flask, jsonify, render_template
from flask_sqlalchemy import SQLAlchemy

testApp = Flask(__name__)
testApp.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///db/bellybutton.sqlite"
db = SQLAlchemy(testApp)
# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(db.engine, reflect=True)

# Save references to each table
Samples_Metadata = Base.classes.sample_metadata
Samples = Base.classes.samples
    

@testApp.route('/')
def index():   
    my_list = db.session.query(Samples_Metadata.sample).limit(10).all()
    cleanList = []
    for i in my_list:
        cleanList.append(str(i).replace(',)','').replace('(',''))        
    return render_template('index.html', options = cleanList)


@testApp.route('/names/<id>')
def names(id):
    stmt = db.session.query(Samples).statement
    df = pd.read_sql_query(stmt, db.session.bind)
    df = (df.loc[df['otu_id'] == int(id)])

    trace = {
        bubble : {
            x: [],
            y: [],
            mode: 'markers',
            marker: {
                size: []
                    }
                 }
        pie : {
            values: [],
            labels: [],
            type: 'pie'
              }
            }
    return jsonify(trace)
 


if __name__ == "__main__":
    testApp.run()
































