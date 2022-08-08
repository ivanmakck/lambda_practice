import pandas as pd
import sqlalchemy as db
import toml
import subprocess
import os
from dotenv import load_dotenv

load_dotenv()
app_config = toml.load("config.toml")

user = os.environ["user"]
password = os.environ["password"]
host = app_config["db"]["host"]
port = app_config["db"]["port"]
dbname = app_config["db"]["dbname"]

engine = db.create_engine(f"mysql+mysqlconnector://{user}:{password}@{host}:{port}/{dbname}")

sql = """
select CustomerID, sum(Sales) TotalSales
from orders
group by 1
order by 2 desc
limit 10;
"""

df = pd.read_sql(sql, con = engine)
df.to_json("top10_cust.json")

bucket = app_config["aws"]["bucket"]
folder = app_config["aws"]["folder"]

subprocess.run(["aws", "s3", "cp", "top10_cust.json", f"{bucket}/{folder}/top10_cust.json"])