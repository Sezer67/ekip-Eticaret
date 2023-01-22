docker exec -it database bash
psql -U postgres
DROP DATABASE "ekip";
CREATE DATABASE "ekip";
\q
cd docker-entrypoint-initdb.d/
psql -U postgres ekip < dump.sql
exit