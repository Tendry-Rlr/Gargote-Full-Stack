-- Active: 1773080411410@@127.0.0.1@5432@gargote

-- MOdification de la table plat
ALTER TABLE plat add COLUMN description varchar(255);
ALTER TABLE plat add column disponible BOOLEAN not null default true;
ALTER TABLE plat add constraint ck_plat_prix check (prix > 0);
ALTER TABLE plat add constraint ck_plat_nom unique (nom);

--Creation de la table plat_du_jour

create TABLE plat_du_jour(
    id_plat_du_jour SERIAL PRIMARY KEY,
    id_plat int not null REFERENCES plat(id),
    date_jour DATE UNIQUE
);



