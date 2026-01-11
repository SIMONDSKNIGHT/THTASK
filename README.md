# TakeHomeGDV
Take home task for demonstration of technical skills.

notes for me for further work: Mac architecture means that I needed to find alternative solution for postgis
I am currently going with emulation, in the hope that Svet is using a non arm64 architecture CPU.

# notes for self

docker compose up -d db for db
docker compose down -v for testing,
docker compose logs db/backend etc 
# when something doesn't work


docker compose exec db bash for entering docker
db name is mydatabase
user name is psql
we're looking for 
psql -U psql -d mydatabase

# more notes
on mac you're having to use private/tmp instead of just being able to access files.
the line you need is docker cp ./tmp/points_100k.csv $(docker compose ps -q db):/tmp/points_100k.csv

you need to copy the csv into the docker container.

#readme section 1 how to connect to db commands

# even more notes on backend thistime
man, you're ST_Intersects(ST_Transform(points.geom, 3857)) is slowing it down completely.
also epsg 4326 is in lat and long, but epsg 3857 is in metres on a flat surface.

