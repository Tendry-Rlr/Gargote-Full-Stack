1. Schema relationnel

- categorie (<u>id</u>, libelle)
- plat (<u>id</u>, nom, prix, id_categorie)
- commande (<u>id</u>, date_commande, numero_table)
- commande_ligne (<u>id</u>, id_commande, id_plat, quantite,prix_unitaire)

2. commande_ligne contient une colonne prix_unitaire pour connaitre le prix courant pour la commande, pour une solution de performance \
   Exemple :

3. Quand on supprime une commande, les lignes commandes concernees sont aussi supprimees en utilisant l'instruction CASCADE

4. Trois donnees absurdes :

- prix negatif
- quantite negatif dans la base
- numero de table negatif

5. Pour la requete b, le code obtenu est 201 car on renvoie une ressource qui vient d'etre creee

6. Pour la requete d, PostgreSQL bloque la suppression, dans l'api : \

```php
 try {
            $this->plats->delete($id);
        } catch (\Throwable $e) {
            // Le plat apparaît dans des commandes : la clé étrangère bloque la suppression.
            return $this->erreur('Ce plat figure déjà dans des commandes, il ne peut pas être supprimé.', 409);

    }
```

7. Commande curl pour table 6 :
 
```bash
curl -X POST http://localhost:8080/api/commandes -H "Content-Type: application/json" -d '{ "numero_table":6, "lignes" : [ {"id_plat":4, "quantite" :2}, {"id_plat:10", "quantite":1} ] }'
```

| # | Étape | Fichier | Fonction / ligne |
|---|---|---|---|
| 1 | Le formulaire est soumis | `components/PlatForm.vue` |  `enregistrer()`|
| 2 | La requête HTTP est construite | `src/api.js` | `requete()` |
| 3 | Vite transmet `/api/...` au port 8080 | `src/vite.config.js` | `proxy` |
| 4 | CodeIgniter choisit le contrôleur |`config/Routes.php` | `$routes->group`|
| 5 | Le contrôleur lit le JSON | `ApiController.php`| `donneesJson()`|
| 6 | Les règles de validation sont vérifiées | `PlatModel.php`| `$validationRules`|
| 7 | La ligne est insérée | | |
| 8 | Le formulaire prévient l’écran parent | `components/PlatList.vue`| `emit(…)`|
| 9 | L’écran recharge la liste | `views/CarteView.vue` | `charger()`|


8. Le code metier de creation de commande est dans CommandeService au lieu d'etre dans Commandes car ce n'est pas pratique

9. Panier.vue ne modifie jamais la quantite lui-meme car elle est dans CommandeView et c'est le parent qui modifie le template mere 

10. Dans PlatForm.vue, watch() sert a stocker une valeur temporairement

11. 