create extension if not exists postgis;

create table oras 
(
	fid serial primary key,
	nume varchar(100) not null,
	geom GEOMETRY (Polygon, 4326) not null 
	
);

CREATE TABLE cartiere 
(
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(50) NOT NULL,
    geom GEOMETRY (Polygon, 4326) NOT NULL,
    suprafata FLOAT,
    fid_oras int not null references oras(fid)
);

CREATE TABLE spatiu_verde 
(
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(100) NOT NULL,
    geom GEOMETRY (Polygon, 4326) NOT NULL,
    suprafata FLOAT
);

CREATE TABLE cartiere_spatiuverde 
(
    id INTEGER PRIMARY KEY,
    fid_cartiere int not null references cartiere(fid),
    fid_spatiu_verde int not null references spatiu_verde(fid)
);

CREATE TABLE alee 
(
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(50),
    fid_spatiu_verde int not null references spatiu_verde(fid)
);

CREATE TABLE mobilier_urban 
(
    fid SERIAL PRIMARY KEY,
    tip VARCHAR(100),
    material VARCHAR(100),
    fid_spatiu_verde int not null references spatiu_verde(fid)
);

CREATE TABLE stare_mobilier_urban 
(
    id SERIAL PRIMARY KEY,
    descriere VARCHAR(300),
    fid_mobilier_urban INT NOT NULL REFERENCES mobilier_urban(fid)
);

CREATE TABLE copaci
(
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(50) NOT NULL,
    inaltime CHAR(3),
    fid_spatiu_verde INT NOT NULL REFERENCES spatiu_verde(fid)
);

CREATE TABLE apa_linie 
(
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(100) NOT NULL,
    geom GEOMETRY(LINESTRING, 4326) NOT NULL
);

CREATE TABLE apa_polygon 
(
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(100) NOT NULL,
    geom GEOMETRY(POLYGON, 4326) NOT NULL
);

CREATE TABLE apa 
(
    id SERIAL PRIMARY KEY,
    fid_apa_linie INT NOT NULL REFERENCES apa_linie(fid),
    fid_apa_polygon INT NOT NULL REFERENCES apa_polygon(fid),
    fid_spatiu_verde INT NOT NULL REFERENCES spatiu_verde(fid)
);