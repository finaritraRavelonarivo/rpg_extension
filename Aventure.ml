open GestionAventure;;
(*open Score;;*)
open Personnage;;
open Monstre;;
open Objet;;


let personnage = GestionAventure.init_aventure();;
let raison_fin = ref "";;    

(*let pp : Personnage.perso  = {nom = "aa"; sexe = Personnage.Homme; role = Personnage.Magicien; pv = 20.; xp = 0; niveau =1; sac =Personnage.init_sac  };;
let p =Personnage.modifier_sac (Objet.Piece) 5 pp;;
let m= GestionAventure.marchandises();;
let p=GestionAventure.affiche_marchandise pp m;;

try
 Personnage.afficher_infos_perso p
  (*Personnage.mis_a_jour_pv (-20.) p*)
with 

| Personnage.Personnage_mort -> raison_fin := "Vous êtes mort. Vous pouvez rejouer pour espérer faire mieux. \n\n"
| Personnage.Objet_insuffisant a -> raison_fin := "Vous avez pas assez de "^ (Objet.affiche_objet a 1) ^"\n\n"
;;
GestionAventure.fin_partie (!raison_fin);;
*)

(**
	vérifie pourquoi le joueur quitte et attribut un message à raison_fin
	@auteur
  @catch la raison de fin de partie
*)
try 
  GestionAventure.hubAventure personnage

with 
  | Personnage.Personnage_mort -> raison_fin := "Vous êtes mort. Vous pouvez rejouer pour espérer faire mieux. \n\n"
  | Personnage.Tue_En_Dormant a -> raison_fin := Monstre.nom_monstre_tueur_nuit a^" vous a tué dans la nuit.\nC'est pour cette raison que personne ne part seul à l'aventure\n\n"
  | Personnage.LevelMax -> raison_fin := "Votre aventure est terminée, vous êtes la personne la plus expérimentée au monde. \n(même les développeurs on dû tricher pour voir ce message)\n\n"
 
  | GestionAventure.Quitte_le_jeu -> raison_fin := "Votre personnage part à la retraite.\nVous ne mourrez pas aujourd'hui, du moins cette fois-ci\n\n"
;;

GestionAventure.fin_partie !raison_fin;;
(*Score.afficher_score();;*)


