import os
from urllib import response
import pandas as pd 
import numpy as np 
import flask
import pickle
from flask import Flask, render_template, request,redirect
app=Flask(__name__)
zip_crime_school={'school_rating': {85003: 94.44,
  85004: 94.44,
  85006: 94.44,
  85007: 94.44,
  85008: 81.79,
  85009: 65.7,
  85012: 72.93,
  85013: 72.93,
  85014: 97.13000000000001,
  85015: 100.04000000000002,
  85016: 97.13,
  85017: 100.04,
  85018: 75.8,
  85019: 100.04,
  85020: 97.13,
  85021: 91.9,
  85022: 99.97,
  85023: 91.9,
  85028: 99.97,
  85029: 91.9,
  85031: 100.04,
  85032: 99.97,
  85033: 95.89,
  85034: 68.34,
  85035: 95.89,
  85037: 85.28,
  85040: 76.54,
  85041: 76.54,
  85042: 76.54,
  85043: 76.86,
  85051: 91.9,
  85053: 91.9,
  85250: 101.35,
  85251: 101.35,
  85254: 99.97,
  85257: 101.34999999999998,
  85258: 101.34999999999998,
  85281: 94.49,
  85282: 94.49,
  85301: 100.04,
  85302: 91.9,
  85303: 95.89,
  85304: 91.9,
  85305: 85.28,
  85306: 91.9,
  85339: 94.47,
  85345: 85.28},
 'crime_rate': {85003: 1.1,
  85004: 1.2,
  85006: 1.9,
  85007: 1.6,
  85008: 4.5,
  85009: 4.0,
  85012: 0.6,
  85013: 2.0,
  85014: 1.9,
  85015: 5.5,
  85016: 3.2,
  85017: 4.1,
  85018: 2.2,
  85019: 2.5,
  85020: 2.1,
  85021: 2.8,
  85022: 2.6,
  85023: 3.4,
  85028: 0.6,
  85029: 3.3,
  85031: 2.4,
  85032: 3.1999999999999997,
  85033: 3.0,
  85034: 1.8999999999999997,
  85035: 3.3,
  85037: 1.9,
  85040: 2.8,
  85041: 4.5,
  85042: 2.9,
  85043: 3.2,
  85051: 4.3,
  85053: 1.5,
  85250: 2.5,
  85251: 0.0,
  85254: 1.1,
  85257: 2.5,
  85258: 0.0,
  85281: 0.0,
  85282: 0.0,
  85301: 0.0,
  85302: 0.0,
  85303: 0.0,
  85304: 0.2,
  85305: 2.5,
  85306: 0.3,
  85339: 2.0,
  85345: 0.0}}
@app.route('/')
def index():
    return render_template('index.html')
@app.route('/predict',methods = ['POST'])
def ValuePredictor():
    if request.method=='POST':
        sqft=request.form["SQFT"]
        sqft=float(sqft)
        Bedrooms=int(request.form["Bedrooms"])
        Bathrooms=request.form["Bathrooms"]
        Bathrooms=float(Bathrooms)
        Year_Built=int(request.form["Year_Built"])
        Zipcode=int(request.form["zip"])
        School=float(zip_crime_school['school_rating'][Zipcode])
        Crime=float(zip_crime_school['crime_rate'][Zipcode])
        x=[[Zipcode,Year_Built,Bedrooms,Bathrooms,sqft,Crime,School]]
        loaded_model = pickle.load(open('housepricepredictions.h5','rb'))
        result = loaded_model.predict(x)
        return render_template('index.html',result=f"${round(result[0],2)}")

# def result():
#      if request.method == 'POST':
#         to_predict_list = request.form.to_dict()
#         to_predict_list=list(to_predict_list.values())
#         to_predict_list = list(map(float, to_predict_list))
#         result = ValuePredictor(to_predict_list)
#         prediction = str(result)
#     return render_template(“predict.html”,prediction=prediction)
if __name__ == '__main__':
 app.run(debug=True)
 