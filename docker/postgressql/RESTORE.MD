# Restore DVD Rental Database

https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/

# Move from a folder to tempfiles (LOCATED IN ROOT DATABASES):
    # Copy-Item relational\databases\POSTGRESSQL\dvdrental.tar -Destination .\.\docker\postgressql\tempfiles
# Into bash docker -> docker exec -it postgressql-docker_localhost-1 bash
# Into database -> psql -U postgres postgres
    # CREATE DATABASE dvdrental;
    # \l
    # exit
# Restore database -> pg_restore -U postgres -d dvdrental /tempfiles/dvdrental.tar