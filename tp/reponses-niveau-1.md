1. Ecriture de la table table_du_jour :

```sql
create TABLE plat_du_jour(
    id_plat_du_jour SERIAL PRIMARY KEY,
    id_plat int not null REFERENCES plat(id),
    date_jour DATE UNIQUE
);
```

- L'**id_plat_du_jour** est la cle primare et en mettant date_jour comme unique pour garantir qu'il y a un seul plat du jour chaque jour

2. Deux informations que l'on perdrait avec la solution d'ajout de boolean :

- perte de l'historique du plat par jour
- possibilite de doublon en cas d'oublie de changement de base

3. Erreur 
-   insertion de plat a 0 ar :
```bash
ERROR:  new row for relation "plat" violates check constraint "ck_plat_prix"
DETAIL:  Failing row contains (16, Soupe silamangany, 0, 2, Soupe a base de boeuf, t).
```

-   insertion de plat dont le nom existe deja 
```bash
ERROR:  duplicate key value violates unique constraint "ck_plat_nom"
DETAIL:  Key (nom)=(Soupe chinoise) already exists
```

4. R2 renvoie 409 et pas 422 car c'est une probleme d'etat mais pas de donnee valides

5. Si Bao marque comme epuise plat qui est deja plat du jour, on ne peut pas faire de commande et on le supprime parmis les plats du jours

6. 

7. 