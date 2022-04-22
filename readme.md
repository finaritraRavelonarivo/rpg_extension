![Markdown Logo](header.png)

# The lonely adventurer

Bienvenue dans le jeu the lonely adventurer. Votre but sera de devenir un aventurier hors pair.
Pour ce faire vous vous déplacerez de hub en hub afin d'acquérir fortune et renommée.  
Êtes-vous prêt à relever le défie ou périrez vous comme vos prédécesseurs?   

---   
# Sommaire
* Jeu de base
  * Comment jouer
  * Les classes  
* Extension
  * Marchand
  * Fuir
  * Tableau de score
  * Coffre
  * Nouvelle fiche de personnage
* Exécution
  * Jeu de base
  * Extension
* Rapport
  * Conception
  * Développement jeu de base
  * Développement extensions

---
# Jeu de base
Dans cette version de base du jeu, vous retrouverez tous les éléments classiques d'un rpg envoutant et palpitant.   
Du monstre qui règne dans les bois au loot et xp à gogo. Prenez place dans une aventure simple, mais efficace
depuis le confort de votre canapé.

## Comment jouer 
Lors du lancement du jeu, vous pourrez choisir un nom, puis choisirez votre genre, enfin vous choisirez votre classe parmi un choix de 3 classes exceptionnel.  
Vous voilà fin prêt à partir à l'aventure avec votre personnage fraichement créé.    

Votre but final est d'atteindre le niveau 10 ou périr, pour ce faire vous arriverez à un hub central. Ce hub vous permet de choisir parmi plusieurs actions.  
Vous pourrez:   
-continuer votre chemin vers le prochain hub  
\-dormir pour regagner des points de vie  
\-manger si vous avez du poulet  
\-visualiser l'état de votre personnage  
\-quitter l'aventure  

**Continuer votre chemin** vous permet d'aller vers le hub suivant. Vous pourrez rencontrer des monstres et ainsi gagner en niveau et looter des items utiles à votre aventure.  
**Dormir** est indispensable pour survivre, mais surtout vous récupérerez de la vie lors de votre sommeil. Mais attention aux mauvaises rencontres.  
**Manger** il vous faudra de quoi manger pour pouvoir profitez de cette action qui vous revigorera.    
**Visualiser l'état du personnage** vous permet de planifier votre prochaine action et peut-être déjouer un peu plus longtemps les plans de la mort.  
**Quitter** parce que finalement chaque aventuriez mérite une retraite pour éviter la mort et profiter de ses richesses.


## Les classes

### Le guerrier:
En armure et très fort, le guerrier est une classe qui joue beaucoup sur la chance.  
Les guerriers tapent très fort, mais leur armure bloque leur mouvement. Ils utilisent leur force pour compenser leur manque de mobilité.    
_C'est une classe parfaite si vous avez beaucoup de chance et aimez les gros dégâts._
 
### l'archer:
Vivant dans la forêt la plupart de son temps, l'archer connait la nature et sait survivre comme personne une fois dehors. Très agile, et très précis l'archer et un super combattant à distance.  
_Cette classe est faite pour vous si vous aimez toucher votre cible à chaque attaque._

### Le magicien:
Intelligent et studieux, le magicien aime étudier et apprendre davantage sur le monde qui l'entour.
Le magicien n'est pas le plus à l'aise dans la nature, mais ces années d'étude lui permette de compensé en adaptant leur environnement.
_Une très bonne classe pour les gens voulant une classe équilibrée_   


---
# Extensions  

Une fois que vous vous serez familiarisé avec le jeu de base. Vous pourrez jouer avec quelques extensions qui rajouteront du contenu au jeu.

## Marchand 
Le marchand redonne un vrai intérêt aux pièces. vous pourrez maintenant dépenser vos pièces contre des objets utiles à votre aventure.  
Vous trouverez le marchand au niveau de chaque hub. Ils vous proposeront des items avec des prix variable à chaque hub, donc n'hésitez pas trop à acheter un objet utile et pas cher si vous tombez sur une super affaire.

## Fuir
Fini de mourir face à un golem alors que vous êtes level 1. Dans cette extension vous pourrez fuir à chaque combat.   
Deux options s'offrent à vous: fuir en courant au risque de vous faire rattraper par le monstre qui vous chasse et devoir combattre ou lui offrir une éponge pour pouvoir fuir à coup sûr.   
_pensez donc à garder vos éponges pour les pires situations_

## Tableau des scores
Vous pourrez enfin montrer vos talents à vos amis grâce au tableau des scores.   
Pour marquer des points et voir votre score dans le tableau des scores, il vous faudra soit atteindre le level 10, soit quitter le jeu depuis le hub.  
Un personnage mort ne donne pas de score, donc choisissez quand quitter pour maximiser votre score.   
_Le score sera calculé en fonction de vos pv, nombre d'objets dans votre inventaire, mais surtout votre niveau_   

## Coffre
Pour vous offrir plus de chance de réussir dans votre aventure et vous donner envie de continuer votre aventure, nous avons eu l'idée d'ajouter un coffre à chaque hub que vous visiterez.
Profitez d'un coffre unique à chaque hub et profitez-en pour battre votre score.

## Nouvelle fiche de personnage   
Cette fiche de personnage amélioré vous indiquera beaucoup plus d'information et vous permettra de mieux planifier votre aventure. Parmi les nouveautés, vous trouverez: le nombre de points d'expérience avant votre montée de level, votre chance de toucher, ainsi que les dégâts de votre personnage.

---
# Exécution

Pour lancer le jeu il vous faudra un IDE (de préférence vscode) avec ocamlc installé sur votre ordinateur. Il vous suffira alors d'éxécuter les deux commandes suivantes dans l'ordre:

## Jeu de base
```bash 
ocamlc Objet.ml Monstre.ml Personnage.ml GestionAventure.ml Main.ml -o rpg.exe
```
```bash
ocamlrun rpg.exe
```   
## Extension
```bash 
ocamlc Objet.ml Monstre.ml Personnage.ml Score.ml GestionAventure.ml Main.ml -o rpg.exe
```
```bash
ocamlrun rpg.exe
``` 

---
# Rapport     
   
## Conception    
Avant de commencer le développement, nous avons décidé de mettre à plat le projet pour produire un diagramme de classe. Cette étape nous a été très utile lors de la phase de développement, car elle nous a permis de nous coordonner dès le début, mais surtout avoir une idée générale du projet.  
Nous avons déjà essayé de programmer sans conception lors de précédents projets et le résultat été très loin d'être concluant (fonction en double, mauvaise répartition du travail...).   
Ce projet nous a permis de voir qu'une bonne conception, nous permettait d'avoir un projet plus propre et plus rapide à produire. 

## Développement jeu de base
-Bernier guillaume a commencé par produire le module __Objet.ml__. Il y a définie le type __type\_obj__. Il a également créé la fonction __init\_objet__ pour choisir des objets aléatoirement et __affiche\_objet__ pour retourner le mot correspondant à un objet.
-Bernier guillaume a également créé les types dans Personnage.ml. Il a également créé les fonctions __string\_of\_pv__ et __string\_of\_element__ qui permettent de transformer les pv en string. nb_degats est une fonction 
