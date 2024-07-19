import re
from flask import Flask, jsonify, request
from utils import extract_select_columns, select_many, sql_chain, get_schema_without_samples,db
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


@app.route("/query", methods=["POST"])
def submit():
    data = request.json
    
    if not data or 'question' not in data:
        return jsonify({"error": "Question is missing from the request"}), 400
    
    question = data['question']
    try:
        query = sql_chain.invoke({"schema": get_schema_without_samples(db) ,"question": question})
        query = query.strip()

        if query == 'CANT' :
            return jsonify({
                "error" : "Query is irrelevant to your database schema"
                }) , 400

        if not re.match(r'^SELECT', query, re.IGNORECASE):
            return jsonify({"error": "Query must start with SELECT"}), 400

        parameters = extract_select_columns(query)
        ans = select_many(query)        

        return jsonify({
            "answer" : ans ,
            "parameters" : parameters,
            "sql_query" : query
        }) , 200
    except Exception as e:
        return jsonify({
            "error": f"Something went wrong. {str(e)}"
        }) , 400
    

if __name__ == '__main__':
    app.run(debug=True)

