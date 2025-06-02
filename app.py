from flask import Flask, render_template, request
import joblib
import numpy as np

app = Flask(__name__)

# Load trained model
model = joblib.load('random_forest_model.pkl')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Collect form data
        gender = 1 if request.form['Gender'] == 'Female' else 0
        favc = 1 if request.form['FAVC'] == 'yes' else 0
        family_history = 1 if request.form['FamilyHistory'] == 'yes' else 0

        age = float(request.form['Age'])
        height = float(request.form['Height'])
        weight = float(request.form['Weight'])
        fcvc = float(request.form['FCVC'])
        ncp = float(request.form['NCP'])
        ch2o = float(request.form['CH2O'])
        faf = float(request.form['FAF'])
        tue = float(request.form['TUE'])

        # Transport type encoded as number (example mapping, customize if needed)
        mtrans = float(request.form['MTRANS'])  # 0 = Walking, 1 = Bike, etc.

        # Eating between meals
        caec = float(request.form['CAEC'])  # 0 = never, 1 = sometimes, etc.

        # Alcohol consumption
        calc = float(request.form['CALC'])  # 0 = no, 1 = sometimes, etc.

        # Match feature order used in model training
        input_features = np.array([[family_history, favc, gender, age, weight,
                                    mtrans, caec, calc, fcvc, ch2o, faf, tue]])

        prediction = model.predict(input_features)[0]

        return render_template('index.html', prediction=prediction)

    except Exception as e:
        return render_template('index.html', prediction=f"Error: {e}")

if __name__ == '__main__':
    app.run(debug=True)
