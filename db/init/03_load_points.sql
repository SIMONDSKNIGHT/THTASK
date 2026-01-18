
CREATE TEMP TABLE points_raw (
    lat DOUBLE PRECISION,
    lon DOUBLE PRECISION
);
COPY points_raw(lat, lon)
FROM '/data/points_100k.csv' /*I swear I'll figure out a cleaner solution*/
WITH (FORMAT csv, HEADER true);

INSERT INTO public.points (lat, lon, geom_4326,geom_3857)
SELECT
    lat,
    lon,
    ST_SetSRID(ST_MakePoint(lon, lat), 4326),
    ST_Transform(ST_SetSRID(ST_MakePoint(lon, lat), 4326), 3857)
FROM points_raw;



-- Verification query

SELECT
    COUNT(*) AS total,
    COUNT(geom_4326) AS with_geom_4326,
    COUNT(geom_3857) AS with_geom_3857,
    ST_SRID(geom_4326) AS srid_4326,
    ST_SRID(geom_3857) AS srid_3857
FROM public.points
GROUP BY srid_4326, srid_3857;

