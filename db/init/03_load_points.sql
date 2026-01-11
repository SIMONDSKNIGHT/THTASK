
CREATE TEMP TABLE points_raw (
    lat DOUBLE PRECISION,
    lon DOUBLE PRECISION
);
COPY points_raw(lat, lon)
FROM '/data/points_100k.csv' /*I swear I'll figure out a cleaner solution*/
WITH (FORMAT csv, HEADER true);

INSERT INTO public.points (lat, lon, geom)
SELECT
    lat,
    lon,
    ST_SetSRID(ST_MakePoint(lon, lat), 4326)
FROM points_raw;



SELECT
    COUNT(*) AS total,
    COUNT(geom) AS with_geom,
    ST_SRID(geom) AS srid
FROM public.points
GROUP BY srid;
