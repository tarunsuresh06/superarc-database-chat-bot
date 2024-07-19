import re
import mysql.connector
from dotenv import load_dotenv
from langchain_core.prompts import ChatPromptTemplate
from langchain_community.llms import Ollama
from sqlalchemy import inspect
from langchain_community.utilities import SQLDatabase
import os

load_dotenv()

mysql_uri = os.getenv('DATABASE_URL')

db = SQLDatabase.from_uri(mysql_uri)

def extract_select_columns(query):
    pattern = r'SELECT\s+(.*?)\s+FROM'
    match = re.search(pattern, query, re.IGNORECASE | re.DOTALL)
    if match:
        return match.group(1).strip()
    else:
        return None

def get_schema_without_samples(db):
    inspector = inspect(db._engine)
    schema_info = []
    for table_name in inspector.get_table_names():
        columns = []
        for column in inspector.get_columns(table_name):
            column_type = str(column['type'])
            columns.append(f"{column['name']} ({column_type})")
        schema_info.append(f"Table: {table_name}\nColumns: {', '.join(columns)}\n")
    return "\n".join(schema_info)

template = """Based on the table schema below, write a SQL query that would answer the user's question. strictly follow the rules provided to you:
Schema:{schema}

Question: {question}

Rules:
1. Only return the sql query
2. Dont add any new line characters '\n'
3. Dont add any escape sequence characters
4. If the question is unrelated to the schema given just say 'CANT' and nothing else.
5. If the question is related try to provide much columns as possible.
"""

prompt = ChatPromptTemplate.from_template(template)

llm = Ollama(
        model = "mistral"
        )

sql_chain = (
    prompt
    | llm
)


db_config = {
    'host': 'localhost',
    'user': 'tarun',
    'password': 'tarun2000',
    'database': 'test'
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

def select_many(query):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    
    cursor.execute(query)
    
    results = cursor.fetchall()
    
    cursor.close()
    connection.close()
    
    return results
