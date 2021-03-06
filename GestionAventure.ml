open Objet;;
open Monstre;;
open Personnage;;
open Score;;

module type GESTIONAVENTURE_SIG = 
sig
  exception Quitte_le_jeu of Personnage.perso
  val init_aventure : unit -> Personnage.perso
  val hubAventure : Personnage.perso -> unit
  val fin_partie : string -> unit
  val tableau_score : string*string -> bool -> unit
  val marchandises : unit -> (Objet.type_obj * int ) list 
  val affiche_marchandise :Personnage.perso ->(Objet.type_obj * int ) list -> Personnage.perso
end;;

module GestionAventure : GESTIONAVENTURE_SIG=
struct

	(**
		exception levée quand le joueur quitte l'aventure
		@auteur Badet Maxime
	*)
  exception Quitte_le_jeu of Personnage.perso;;


	(**
		Delimiteur de ligne pour chaque nouveau message de l'aventure
		@auteur Badet Maxime
    @return un string de delimitation
	*)
  let delimiteur : unit -> string = fun () ->"\n+--------------------------------------------------------------------------------+\n"


	(**
		Permet de vérifier que le nom est correcte
		@auteur Badet Maxime
    @return le nom valide du joueur
	*)
  let rec read_nom  : unit -> string= fun () ->
    let () = print_string (delimiteur() ^ ">Ton nom: ") in
    let n = read_line() in
      if n="" then 
        (print_string "Il faut choisir un nom de personnage.\n"; read_nom())
      else 
        if (String.length n) > 40 then
          (print_string "Le nom est trop long.\n"; read_nom())
        else 
          n


  (**
		Transforme le choix en genre du joueur en constructeur de genre de personnage
		@auteur Badet Maxime
    @return le genre du personnage
	*)
  let rec read_genre : unit -> Personnage.genre= fun () ->  
    let () = print_string (delimiteur() ^ 
"> Ton genre: 
  F) Femme
  H) Homme
Votre choix: ") 
    in let g=read_line() in
    if not(g="F" || g="H" || g="f" || g="h") then 
        (print_string "tu dois avoir un genre binaire.\n"; read_genre())
    else 
      (if g="F" || g="f" then Personnage.Femme else Personnage.Homme)


  (**
		Transforme la classe choisie par le joueur en constructeur de classe de personnage
		@auteur Badet Maxime
    @param g permet d'afficher un message adapté au genre du personnage
    @return la classe du joueur
	*)
  let rec read_classe : Personnage.genre -> Personnage.classe  = fun g ->
    let () = 
    if g = Personnage.Homme then 
      print_string (delimiteur() ^ 
"> Ta classe: 
  A) Archer
  G) Guerrier
  M) Magicien
Votre choix: ") 
    else
      print_string (delimiteur() ^ 
"> Ta classe: 
  A) Archère
  G) Guerrière
  M) Magicienne
Votre choix: ")
    in let c =read_line() in
      if not(c="A" || c="G" || c="M" || c="a" || c="g" || c="m") then 
        (print_string "il faut choisir une classe.\n"; read_classe(g))
      else 
        (if c="A" || c="a" then 
          Personnage.Archer 
        else if c="G" || c="g"then 
          Personnage.Guerrier 
        else 
          Personnage.Magicien)


  (**
    Vérifie le choix du joueur quand il veut fuir
    soit offrir une éponge
    soit courir
    @auteur Badet Maxime
    @return un choix valide 
  *)
  let rec read_fuite : unit -> string  = fun() ->
    let () = print_string (delimiteur() ^ 
"> Que voulez-vous faire
  O) Offrir éponge 
  C) Courir
Votre choix: ") in
  let c = read_line() in
    if not(c="O" || c="o" || c="C" || c="c") then 
      (print_string "il faut faire un choix.\n"; read_fuite())
    else 
      c


  (**
    Verifie le choix du joueur quand il est face à un monstre
    soit il essaie de combattre
    soit il fuit
    @auteur Badet Maxime
    @return un choix valide
  *)
  let rec read_action : unit -> string  = fun() ->
    let () = print_string (delimiteur() ^ 
"> Que voulez-vous faire
  A) Attaquer  
  F) Fuir 
  V) Voir l'état de votre perso
Votre choix: ") in
  let c = read_line() in
    if not(c="A" || c="F" || c="V" || c="a" || c="f" || c="v") then 
      (print_string "il faut faire un choix.\n"; read_action())
    else 
      c


	(**
		Vérifie la validité du choix du joueur pour le hub d'aventure
		@auteur Badet Maxime
    @return un choix valide 
	*)
  let rec read_hubAventure : unit -> string= fun () ->
    let () = print_string (delimiteur() ^
"> Que voulez-vous faire?
 A) Acheter chez le marchand
 C) Continuer votre chemin
 D) Dormir
 M) Manger
 V) Visualiser l'état du personnage
 Q) Quitter l'aventure
Votre choix:") 
    in let c = read_line() in
      if not(c="A" || c="C" || c="D" || c="M" || c="V" || c="Q" || c="a" || c="c" || c="d" || c="m" || c="v" || c="q" ) then
        (print_string "il faut faire un choix.\n"; read_hubAventure())
      else 
        c


	(**
		Initialise le personnage et affiche le message de début d'aventure
		@auteur Badet Maxime
    @return le personnage de debut d'aventure
	*)
  let rec init_aventure : unit -> Personnage.perso = fun ()->
    let() = print_string ("\n\n\n\n" ^
    delimiteur()^
"> Bonjour jeune aventurier(ère), es-tu prêt à mour... gagner. 
Pour ce faire ton but est simple. 
Deviens la personne la plus expérimentée et accumule des 
objets hors du commun.
  
Au fait qui es-tu aventurier(ère)?\n") in
    let n = read_nom() in
    let g = read_genre() in
    let c = read_classe g in
    Personnage.init_perso n g c


  (**
		Gestion du combat entre le joueur et un monstre où le premier qui attaque est pris aléatoirement
		@auteur Ravelonarivo Finaritra
    @param pers le personnage qui va combattre
    @param monstre le monstre qui va combattre
    @return le nouvel état du joueur
	*)
  let combattre : Personnage.perso -> Monstre.monstre -> Personnage.perso = fun pers monstre ->
    let rec le_combat :int -> Personnage.perso -> Monstre.monstre -> Personnage.perso = fun attaquant p m -> 
      match attaquant  with 
        |0 -> let frappe=Personnage.frapper p 
              in (print_string (Personnage.message_attaque p frappe)) ; 
              let pv_monstre= m.pv - frappe  
              in
                if (pv_monstre <=0 ) then 
                  let nouv_xp= p.xp +( Monstre.xp_gagne monstre) 
                  in (print_string(Monstre.monstre_vaincu m)) ;
                  Personnage.modifier_sac monstre.loot 1 (Personnage.changement_niveau p nouv_xp) 
                else 
                  let nouv_monstre : Monstre.monstre = {creature = monstre.creature; loot = monstre.loot; pv = pv_monstre}
                  in le_combat 1 p nouv_monstre
        |_->  let degat = (Monstre.monstre_frapper m) 
              in (print_string (Monstre.message_combat m degat)) ; 
              let nouv_pers=(Personnage.mis_a_jour_pv (-. degat ) p) 
              in le_combat 0 nouv_pers m
    in le_combat (Random.int 2) pers monstre
      

  (**
		Propose de fuir contre une éponge ou de courir et résout la fuite
		@auteur Badet Maxime
    @param pers le personnage qui va combattre
    @param monstre le monstre qui va combattre
    @return le personnage après fuite ou combat
	*)
  let fuir : Personnage.perso -> Monstre.monstre -> Personnage.perso = fun perso -> fun monstre ->
    let eponge = Personnage.avoir_objet  perso Objet.Eponge 1 in
    if eponge then
      let c = read_fuite() in
      if (c="o" || c="O") then 
        (print_string(delimiteur() ^ "> Vous jetez une éponge au sol avant de fuire.\n");
        if monstre.creature = Monstre.Golem then 
          print_string("Vous voyez au loin le golem frotter l'éponge contre son corps puant.\n")
        else if monstre.creature = Monstre.Sanglier then 
          print_string("Vous voyez au loin le sanglier rouler sur l'éponge.\n")
        else 
          print_string("Vous voyez au loin la nuée de moustiques attaquer l'éponge.\n");
        Personnage.modifier_sac Objet.Eponge (-1) perso)
      else 
        let rand = Random.int 10 in
        if rand < 5 then 
          (print_string(delimiteur() ^ "> Le monstre vous rattrape et vous combat.\n"); 
          combattre perso monstre)
        else 
          (print_string(delimiteur() ^ "> Vous arrivez à fuire et vous cacher du monstre.\n");
          perso)
    else 
      let rand = Random.int 10 in
      if rand < 5 then 
        (print_string(delimiteur() ^ "> Le monstre vous rattrape et vous combat.\n"); 
        combattre perso monstre)
      else 
        (print_string(delimiteur() ^ "> Vous arrivez à fuir et vous cacher du monstre.\n");
        perso)


  (**
		Propose au joueur de combattre un monstre ou de fuir
		@auteur Badet Maxime
    @param pers le personnage qui va combattre
    @param monstre le monstre qui va combattre
    @return le nouvel état du joueur
	*)
  let choixAventure : Personnage.perso -> Monstre.monstre -> Personnage.perso = fun perso -> fun monstre ->
    let rec aux = fun perso ->
      let choix = read_action() in
      if choix = "A" || choix = "a" then 
        (combattre perso monstre)
      else if choix = "F" || choix = "f" then 
        fuir perso monstre
      else 
        (print_string (delimiteur()); Personnage.afficher_infos_perso perso; aux perso)
    in
    aux perso


  (**
		La liste des marchandises que vend un marchand
    il peut ne rien vendre aussi
    il vend des objets aléatoires un ou deux types d'objets avec des prix aléatoires mais abordables
		@auteur Ravelonarivo Finaritra
    @return une liste des objets que le marchand vend
	*)
  let marchandises : unit -> (Objet.type_obj * int ) list = fun () ->
    let nb_objet = Random.int 3 in
    let les_objet = fun hasard->
      match hasard with
      |0 -> Objet.Poulet
      |_ -> Objet.Eponge
    in
    let rec prix_chaque_objet = fun existant obj  ->
      match obj with
        |0 -> []
        |1 when existant =(-1)->let existant =Random.int 2 in ((les_objet existant),(Random.int 2)+1) :: (prix_chaque_objet existant(obj-1))
        |1 when existant =0->((les_objet 1),(Random.int 2)+1) :: (prix_chaque_objet 1 (obj-1))
        |1 ->((les_objet 0),(Random.int 2)+1) :: (prix_chaque_objet 0 (obj-1))
        |_ ->let existant =Random.int 2 in ((les_objet existant),(Random.int 2)+1) :: (prix_chaque_objet existant(obj-1))
    in (prix_chaque_objet (-1) nb_objet)


  (**
		Gestion de la transaction entre le personnage et le marchand
		@auteur Ravelonarivo Finaritra
    @param marchandise la liste des marchandises avec leur prix
    @param p le personnage du joueur
    @return le personnage du joueur après transaction
	*)
  let acheter :(Objet.type_obj * int )  -> Personnage.perso -> Personnage.perso = fun marchandise p ->
    if( Personnage.avoir_objet p Objet.Piece (snd marchandise)) then
      Personnage.modifier_sac (fst marchandise) 1 (Personnage.modifier_sac Piece (-(snd marchandise)) p)
    else
      let() = print_string (delimiteur() ^ "> Vous n'avez pas assez de pièces pour cet achat.") 
      in p   


  (**
		Affichage du shop du marchand
		@auteur Ravelonarivo Finaritra
    @param pers le personnage du joueur
    @param liste une liste des marchandises et leur prix
    @return le nouvel état du joueur
	*)
  let rec affiche_marchandise :Personnage.perso ->(Objet.type_obj * int ) list -> Personnage.perso= fun p liste ->
    let debut =
      if liste=[] then 
        "> Il n'y a plus rien à vendre, circulez!\n"
      else
        "> Choisissez ce dont vous avez besoin :\n" ^
    let rec affiche = fun l i->
      match l with 
        |[] -> ""
        |h :: t ->" "^(string_of_int i ) ^" ) "^(Objet.affiche_objet (fst h) 1) ^"  : "^ (string_of_int (snd h)) ^ "  "^(Objet.affiche_objet (Objet.Piece) (snd h)) ^"\n" ^ (affiche t (i+1))
    in (affiche liste 1)
    in let () = print_string( delimiteur() ^ debut ^ " P ) partir\nVotre choix : ") 
    in let c = read_line() in
    let rec repValable = fun nombre ->
      match nombre with
        |0->[]
        |_ -> (string_of_int nombre) :: repValable (nombre-1)  
    in let les_reponses =  repValable (List.length liste) in
      if c="P" || c="p" then 
        p
      else 
        if(List.exists (fun i -> i=c) les_reponses) then
          let nouv_pers=acheter (List.nth liste ((int_of_string c)-1) ) p  in
          let nouv_liste:(Objet.type_obj * int ) list -> string -> (Objet.type_obj * int ) list = fun l c -> 
            if c="1" then 
              List.tl l
            else 
              [List.hd l]
          in affiche_marchandise nouv_pers (nouv_liste liste c)
        else 
          let () = print_string( "il faut faire un choix.\n") 
          in affiche_marchandise p liste 
      

	(**
		Génère une rencontre avec un monstre aléatoirement
		@auteur Badet Maxime
    @param pers le personnage principal
	*)
  let malheureuse_rencontre : Personnage.perso -> Personnage.perso= fun perso->
    let rand = Random.int 100 in
      if rand < 50 then 
        let monstre = Monstre.init_monstre() in
        let () = print_string (delimiteur() ^ Monstre.message_malheureuse_rencontre monstre)
        in (combattre perso monstre)
      else 
        perso

  
  (**
		Offre une récompense au joueur après chaque retour au hub 
		@auteur Ravelonarivo Finaritra
    @param pers le personnage qui va combattre
    @return le personnage avec son nouvel inventaire
	*)
  let coffre_hub : Personnage.perso -> Personnage.perso = fun perso ->
    let objet= match Random.int 3 with
      |0 -> Objet.Poulet
      |1 ->Objet.Piece  
      | _ ->  Objet.Eponge 
    in
    let () =
      let article_objet = fun obj ->match obj with
        |Objet.Poulet -> "un " 
        | _ -> "une " 
      in
      print_string(delimiteur() ^ ">Félicitations, en ouvrant le coffre vous avez obtenu "^(article_objet objet) ^(Objet.affiche_objet objet 1) ^".\n")
    in
    (Personnage.modifier_sac  objet 1 perso)


	(**
		Affiche les hub de l'aventure avec les différents choix
		@auteur Badet Maxime
    @param perso le personnage principal
	*)
  let rec hubAventure : Personnage.perso -> unit = fun perso ->
    let c = read_hubAventure() in
      match c with 
        | _ when c="A" || c="a" -> 
              hubAventure(malheureuse_rencontre(affiche_marchandise perso (marchandises())))
        | _ when c ="C" || c="c" -> 
              (print_string (delimiteur() ^ "> Vous continuez votre chemin vers votre prochaine destination.\n")); 
              let p_apres_malheurese_rencontre = malheureuse_rencontre perso 
              in hubAventure(coffre_hub p_apres_malheurese_rencontre)
        | _ when c="D" || c="d" -> 
              (print_string (delimiteur() ^ "> Vous installez votre campement et tombez rapidement " ^ 
              (Personnage.accord_masculin_feminin perso "endormi.\n" "endormie.\n")); 
              hubAventure (malheureuse_rencontre (Personnage.dormir perso)))
        | _ when c="M" || c="m" -> 
              (let mange = Personnage.manger perso in 
                if (fst mange) then 
                  (print_string (delimiteur() ^ "> Vous mangez un peu avant de reprendre votre aventure.\n"); 
                  hubAventure (malheureuse_rencontre (snd mange)))
                else 
                  (print_string (delimiteur() ^ "> Vous n'avez pas à manger.\n"); 
                  hubAventure (malheureuse_rencontre (snd mange))))
        | _ when c="V" || c="v" -> 
              (print_string (delimiteur()); 
              Personnage.afficher_infos_perso perso; 
              hubAventure perso)
        |_ -> 
              raise (Quitte_le_jeu perso)


	(**
		Affiche la raison de la fin de partie
		@auteur Badet Maxime
    @param message le message de fin de partie
	*)
  let fin_partie : string -> unit = fun message ->
    print_string ("\n\n+---------------------------------Fin de partie----------------------------------+ \n" ^
    "> La partie s'est terminée car: \n" ^
    message)


  (**
		Modifie si nécessaire le tableau des scores et l'affiche
		@auteur Badet Maxime
    @param score un tuple de score et nom
    @param ajout qui vérifie si on doit ajouter le nouveau score
	*)
  let tableau_score : string*string -> bool -> unit = fun score -> fun ajout ->
    print_string ("+-------------------------------------Score--------------------------------------+ \n");
    if ajout then 
      Score.compare_score score 
    else 
      ();
      Score.afficher_score ()


end;;



