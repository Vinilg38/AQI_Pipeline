from airflow.sdk import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime, timezone


DBT_PROJECT_DIR = '/Users/vinilg7/PycharmProjects/AQI/AQI'


local_tz = timezone("Asia/Kolkata")
with DAG(
    dag_id='aqi_medallion_pipeline',
    start_date=datetime(2025, 1, 1, tz=local_tz),
    schedule=None,
    catchup=False,
    tags=['dbt', 'data-pipeline']
) as dag:

    dbt_seed_task = BashOperator(
        task_id='dbt_seed',
        bash_command=f'dbt seed',
        cwd=DBT_PROJECT_DIR
    )

    dbt_run_task = BashOperator(
        task_id='dbt_run',
        bash_command=f'dbt run',
        cwd=DBT_PROJECT_DIR
    )

    dbt_test_task = BashOperator(
        task_id='dbt_test',
        bash_command=f'dbt test',
        cwd=DBT_PROJECT_DIR
    )

    dbt_seed_task >> dbt_run_task >> dbt_test_task
