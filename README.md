# deel
Project of Deel home task for Analytics Engineer position.

Within the [models](/models/) folder, we have three zones classified as staging, intermediate, and marts.

The marts are divided into schemas that concentrate specific information.

Within each knowledge silo, there are two folders:
  
  - [config](/models/staging/config/) ->  Where the YML configuration files for each table are located. 
 
  - [sql](/models/staging/sql/) -> Where the SQL files for querying and building each table are located.

Linage graph:
![alt text](deel_dbt_project/dbt-dag.png)