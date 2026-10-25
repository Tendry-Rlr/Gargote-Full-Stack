insert into plat(id_categorie, description, nom, prix, disponible) VALUES
(4, 'Plat malagasy', 'Mofo gasy', 500, true),
(4, 'Plat malagasy', 'Mokary', 600, true),
(4, 'Plat malagasy', 'Koba', 1500, true),
(4, 'Plat malagasy', 'Godrogodro', 300, false),
(4, 'Plat malagasy', 'Menakely', 200, false);

-- Mise a jour pour ajouter les descriptions 
update plat set description = 'specialite Malagasy' where nom= 'Ravitoto sy henakisoa'; 
update plat set description = 'une simple soupe' where nom= 'Soupe chinoise'; 
update plat set description = 'patte bien assaisonnee' where nom= 'Mi sao'; 
update plat set description = 'Bien concentree' where nom= 'Jus de fruit'; 
update plat set description = 'poulet avec du riz' where nom= 'Akoho sy voanio'; 

insert into plat_du_jour(id_plat, date_jour)
select id, current_date from plat where nom = 'Mofo gasy';

insert into plat_du_jour(id_plat, date_jour)
select id, current_date-1 from plat where nom = 'Mokary';
insert into plat_du_jour(id_plat, date_jour)
select id, current_date-2 from plat where nom = 'Koba';

insert into plat_du_jour(id_plat, date_jour)
select id, current_date-3 from plat where nom = 'Godrogodro';

insert into plat_du_jour(id_plat, date_jour)
select id, current_date-4 from plat where nom = 'Akoho sy voanio';
insert into plat_du_jour(id_plat, date_jour)
select id, current_date-5 from plat where nom = 'Menakely';

insert into plat_du_jour(id_plat, date_jour)
select id, current_date-6 from plat where nom = 'Romazava';

insert into plat_du_jour(id_plat, date_jour)
select id, current_date-7 from plat where nom = 'Mi sao';


(2, current_date),
(3, current_date),
(4, current_date),
(5, current_date),
(6, current_date),
(7, current_date),

select current_date as date;

-- ajout de plat a 0 ar 

insert into plat(id_categorie, description, nom, prix, disponible) VALUES
(2, 'Soupe a base de boeuf', 'Soupe silamangany', 0, true);

-- ajotu de plat ou le nom existe deja 

insert into plat(id_categorie, description, nom, prix, disponible) VALUES
(2, 'Soupe a base de boeuf', 'Soupe chinoise', 1000, true);
