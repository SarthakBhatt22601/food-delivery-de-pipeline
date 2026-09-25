from datetime import datetime
from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator      # Airflow 3 import

DBT = "/opt/airflow/dbt_venv/bin/dbt"
DBT_PROJECT = "/opt/airflow/dbt/food_dlv_dbt"

with DAG(
    dag_id="food_dlv_batch",
    start_date=datetime(2024, 1, 1),
    schedule="@daily",
    catchup=False,
    tags=["food_dlv", "dbt", "snowflake"],
    doc_md=__doc__,
) as dag:

    dbt_build_core = BashOperator(
        task_id="dbt_build_core",
        bash_command=f"{DBT} build --project-dir {DBT_PROJECT} --profiles-dir {DBT_PROJECT}",
    )

    dbt_build_core