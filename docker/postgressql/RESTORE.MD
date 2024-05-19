# Restore DVD Rental Database

All the instructions are in the documentatin provided by 
[Postgres SQL Tutorial](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/)

# Steps

## Files from outside the bind mount to it

Move from a folder to tempfiles (LOCATED IN ROOT DATABASES):
```
Copy-Item relational\databases\POSTGRESSQL\dvdrental.tar -Destination .\.\docker\postgressql\tempfiles
```

## Get into the bash in docker

```
docker exec -it [CONTAINER NAME] bash
```

## Onche in docker bash go into postgress

```
psql -U postgres postgres
```

## Operate in the database: Create database DVD RENTAL

```
CREATE DATABASE dvdrental;
\l
exit
```

## Restore the database outside the Postgres Console

```
pg_restore -U postgres -d dvdrental /tempfiles/dvdrental.tar
```