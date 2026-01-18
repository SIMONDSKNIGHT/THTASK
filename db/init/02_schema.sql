

CREATE TABLE public.points (
    id SERIAL PRIMARY KEY,
    geom_3857 GEOMETRY(Point, 3857), -- Web Mercator
    geom_4326 GEOMETRY(Point, 4326), -- WGS84
    lat DOUBLE PRECISION,
    lon DOUBLE PRECISION,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX points_geom4326_idx ON public.points USING GIST (geom_4326);
CREATE INDEX points_geom3857_idx ON public.points USING GIST (geom_3857);

