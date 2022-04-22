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
* Conclusion

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
### Badet maxime:
* GestionAventure.ml
  * exception __Quitte\_le\_jeu__ permet de savoir quand le joueur quitte le jeu
  * fonction __delimiteur__ affiche un délimiteur visuel entre chaque action dans le terminal
  * fonction __read\_nom__ vérifie la validité d'un nom de personnage
  * fonction __read\_genre__ retourne un genre en fonction de la saisie de l'utilisateur
  * fonction __read\_classe__ renvoie la classe désirée lors de la saisie
  * fonction __read\_hubAventure__ permet la sélection d'action dans le hub
  * fonction __init\_aventure__ initialisation de l'aventure
  * fonction __malheureuse\_rencontre__ gère les malheureuse_rencontre entre le personnage et les monstres
  * fonction __hubAventure__ gestion des divers choix du joueur pour progresser dans l'aventure
  * fonction __fin\_partie__ gestion de l'affichage de fin de partie
* Main.ml
  * mise en place totale du Main.ml
* Monstre.ml
  * fonction __message\_malheureuse\_rencontre__ affiche les messages liés aux malheureuses rencontres
* Personnage.ml
  * exception __Personnage\_mort__ permet de savoir si le personnage est mort
  * exception __LevelMax__ permet de savoir si le personnage est level 10
  * fonction __init\_perso__ initialise le personnage
  * fonction __etat\_sac__ permet d'afficher le contenu du sac du joueur
  * fonction __mis\_a\_jour\_pv__ gère le changement de point de vie du joueur et vérifie s'il est mort
  * fonction __avoir\_objet__ vérifie si le joueur possède un objet passé en paramètre
  * fonction __modifier\_sac__ gestion de la modification du contenu du sac du joueur
  * fonction __manger__ gère l'action de manger du personnage
  * fonction __changement\_niveau__ gestion de la monté de niveau du personnage et lève une exception au level 10
* Divers
  * ajout des signatures sur chaque modules
  * mise en place de l'ocamldoc
  * création du markdown

### Bernier guillaume:
* Objet.ml
  * définition de tous les types
  * fonction __init\_objet__ qui permet de choisir un objet aléatoirement
  * fonction __affiche\_objet__ qui retourne un string de l'objet passé en paramètre
* Personnage.ml
  * définition de tous les types
  * fonction __classe\_genre__ qui renvoie un string d'une classe de personnage en fonction de son genre
  * fonction __string\_of\_pv__ retourne un string du nombre de pv du personnage
  * fonction __string\_of\_element__ renvoie un string d'un int en ajoutant un 0 devant les chiffres de 0 à 9
  * fonction __nb\_degats__ retourne le nombre de dégâts en fonction de la classe
  * fonction __frapper__ renvoie les dégats que le personnage va infligé au monstre
  * fonction __message\_attaque__ permet d'afficher les messages d'attaque du personnage

### Ravelonarivo Finaritra:
* GestionAventure.ml
  * fonction __combattre__ gestion du combat entre un monstre et un personnage
* Monstre.ml
  * définition de tous les types
  * fonction __d__ renvoie une somme de valeurs aléatoires
  * fonction __init\_monstre__ qui initialise un monstre aléatoirement
  * fonction __monstre\_frapper__ retourne les dégâts que le monstre inflige 
  * fonction __xp\_gagne__ renvoie le nombre de points d'expérience que le joueur va gagner
  * fonction __nom\_monstre__ retourne un string du nom du monstre
  * fonction __message\_combat__ affichage des messages de combat du monstre
  * fonction __nom\_monstre\_tueur\_nuit__ retourne un string du nom du monstre qui tue le joueur dans la nuit
  * fonction __monstre\_vaincu__ affiche un message quand le monstre est mort
* Personnage.ml
  * exception __Tue\_En\_Dormant__ permet de savoir si le joueur et mort en dormant
  * fonction __nb\_string__ pour connaitre le nombre de caractères d'un string
  * fonction __etat\_perso__ gestion de la fiche de personnage
  * fonction __afficher\_infos\_perso__ affiche la fiche du personnage
  * fonction __afficher\_sac\_perso__ affiche le sac du joueur
  * fonction __mis\_a\_jour\_pv__ gère le changement de point de vie du joueur et vérifie s'il est mort
  * fonction __chance\_toucher__ recalcule les chances de toucher d'un personnage en fonction de son level
  * fonction __avoir\_objet__ vérifie si le joueur possède un objet passé en paramètre
  * fonction __accord\_masculin\_feminin__ permet de choisir le bon accord de genre
  * fonction __dormir__ gestion de l'option dormir du personnage
  * fonction __changement\_niveau__ gestion de la montée de niveau du personnage et lève une exception au level 10
* Divers
  * mise en place de l'ocamldoc

## Développement extensions
### Badet maxime:
* GestionAventure.ml
  * fonction __read\_fuite__ vérfie la saisie du joueur et affiche les choix
  * fonction __fuir__ gestion de la fuite du joueur
  * fonction __choixAventure__ propose de fuir ou combattre et gère l'action
  * fonction __tableau\_score__ gestion et affichage du tableau des scores
* Personnage.ml
  * fonction __nb\_objet__ calcul le nombre d'objets dans le sac du jouer avec la quantité  
  * fonction __score__ gestion du calcul du score du joueur
* Score.ml
  * fonction __validite\_ligne__ retourne un type somme pour chaque ligne du fichier de score
  * fonction __lire\_ligne__ ajoute chaque ligne, deux par deux dans une liste de tuple de string
  * fonction __lire\_fichier__ ouvre ou créer le fichier de score
  * fonction __afficher\_score__ affiche les 10 meilleurs scores
  * fonction __ecrire\_fichier__ écrit le nouveau score dans le fichier

### Ravelonarivo Finaritra:
* GestionAventure.ml
  * fonction __marchandises__ génération de l'inventaire du marchand
  * fonction __acheter__ gestion de la transaction entre le marchand et le personnage
  * fonction __affiche\_marchandise__ affichage du menu du marchand
  * fonction __coffre\_hub__ permet d'offrir un nouvel objet à chaque retour au hub
* Personnage.ml
  * fonction __etat\_perso__ ajout de fonctionnalité supplémentaire à l'affichage de la fiche du personnage

---
# Conclusion
Le projet nous aura pris beaucoup de temps, mais aura été très formateur. Nous avons acquis de plus grandes connaissances en ocaml, mais surtout en programmation fonctionnelle grâce à ce projet. Nous avons également découvert markdown, qui est très utile pour documenter un projet.   
Nos débuts dans le projet n'ont pas été simples, mais nous avons su surmonter les problèmes et arriver à un résultat dont nous sommes fières.

