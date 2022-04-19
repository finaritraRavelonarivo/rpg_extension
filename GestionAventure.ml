open Objet;;
open Monstre;;
open Personnage;;

module type GESTIONAVENTURE_SIG = 
sig
  exception Quitte_le_jeu
  val init_aventure : unit -> Personnage.perso
  val hubAventure : Personnage.perso -> unit
  val fin_partie : string -> unit
  val marchandises : unit -> (Objet.type_obj * int ) list 
  val affiche_marchandise :Personnage.perso ->(Objet.type_obj * int ) list -> Personnage.perso
end;;

module GestionAventure : GESTIONAVENTURE_SIG=
struct

	(**
		exception levée quand le joueur quitte l'aventure
		@auteur 
	*)
  exception Quitte_le_jeu

	(**
		Delimiteur de ligne pour chaque nouveau message de l'aventure
		@auteur 
    @return un string de delimitation
	*)
  let delimiteur : unit -> string = fun () ->"\n+--------------------------------------------------------------------------------+\n"

	(**
		Permet de vérifier que le nom est correcte
		@auteur 
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
		Transforme le choix du joueur de genre en constructeur de genre de personnage
		@auteur 
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
        (print_string "tu dois avoir un genre binaire\n"; read_genre())
    else 
      (if g="F" || g="f" then Personnage.Femme else Personnage.Homme)

  (**
		Transforme le choix du joueur de classe en constructeur de classe de personnage
		@auteur 
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
        (print_string "il faut choisir une classe\n"; read_classe(g))
      else 
        (if c="A" || c="a" then 
          Personnage.Archer 
        else if c="G" || c="g"then 
          Personnage.Guerrier 
        else 
          Personnage.Magicien)

  let rec read_fuite : unit -> string  = fun() ->
    let () = print_string (delimiteur() ^ 
"> Que voulez-vous faire
  O) Offrir éponge 
  C) Courir
Votre choix: ") in
  let c = read_line() in
    if not(c="O" || c="o" || c="C" || c="c") then 
      (print_string "il faut faire un choix\n"; read_fuite())
    else 
      c

  let rec read_action : unit -> string  = fun() ->
    let () = print_string (delimiteur() ^ 
"> Que voulez-vous faire
  A) Attaquer  
  F) Fuir 
  V) Voir l'état de votre perso
Votre choix: ") in
  let c = read_line() in
    if not(c="A" || c="F" || c="V" || c="a" || c="f" || c="v") then 
      (print_string "il faut faire un choix\n"; read_action())
    else 
      c

	(**
		Vérifie la validité du choix du joueur pour le hub d'aventure
		@auteur 
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
        (print_string "il faut faire un choix\n"; read_hubAventure())
      else 
        c

	(**
		initialise le personnage et affiche le message de début d'aventure
		@auteur 
    @return le personnage de debut d'aventure
	*)
  let rec init_aventure : unit -> Personnage.perso = fun ()->
    let() = print_string ("\n\n\n\n" ^
    delimiteur()^
"> Bonjour jeune aventurier, es-tu prêt à mour... gagner. 
Pour ce faire ton but est simple. 
Deviens la personne la plus expérimentée et accumule des 
objets hors du commun.
  
Au fait qui es-tu aventurier?\n") in
    let n = read_nom() in
    let g = read_genre() in
    let c = read_classe g in
    Personnage.init_perso n g c

  (**
		Gestion du combat entre le joueur et un monstre
		@auteur 
    @param pers le personnage qui va combattre
    @param monstre le monstre qui va combattre
    @return le nouvel état du joueur
	*)
  let combattre : Personnage.perso -> Monstre.monstre -> Personnage.perso = fun pers monstre ->
    let rec le_combat :int -> Personnage.perso -> Monstre.monstre -> Personnage.perso = fun attaquant p m -> 
      match attaquant  with 
        |0 -> let frappe=Personnage.frapper p 
              in Personnage.affiche_attaque p frappe ; 
              let pv_monstre= m.pv - frappe  
              in
                if (pv_monstre <=0 ) then 
                  let nouv_xp= p.xp +( Monstre.xp_gagne monstre) in Monstre.monstre_vaincu m ;
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
		permet au joueur de fuire
		@auteur 
    @param pers le personnage principal
	*)
  let fuir : Personnage.perso -> Monstre.monstre -> Personnage.perso = fun perso -> fun monstre ->
    let eponge = Personnage.avoir_objet  perso Objet.Eponge 1 in
    if eponge then
      let c = read_fuite() in
      if (c="o" || c="O") then 
        (print_string(delimiteur() ^ "> Vous jetez une éponge au sol avant de fuire.\n");
        if monstre.creature = Monstre.Golem then print_string("Vous voyez au loin le golem frotter l'éponge contre son corp puant.\n")
        else if monstre.creature = Monstre.Sanglier then print_string("Vous voyez au loins le sanglier sVe rouler sur l'éponge.\n")
        else print_string("Vous voyez au loins la nuée de moustique attaquer l'éponge.\n");
        Personnage.modifier_sac Objet.Eponge (-1) perso)
      else 
        let rand = Random.int 10 in
        if rand < 5 then (print_string(delimiteur() ^ "> Le monstre vous rattrape et vous combat.\n"); combattre perso monstre)
        else (print_string(delimiteur() ^ "> Vous arrivez à fuire et vous cacher du monstre.\n");perso)
    else 
      let rand = Random.int 10 in
      if rand < 5 then (print_string(delimiteur() ^ "> Le monstre vous rattrape et vous combat.\n"); combattre perso monstre)
      else (print_string(delimiteur() ^ "> Vous arrivez à fuire et vous cacher du monstre.\n");perso)


  let choixAventure = fun perso -> fun monstre ->
    let rec aux = fun perso ->
      let choix = read_action() in
      if choix = "A" || choix = "a" then (combattre perso monstre)
      else if choix = "F" || choix = "f" then fuir perso monstre
      else (print_string (delimiteur()); Personnage.afficher_infos_perso perso; aux perso)
    in
    aux perso



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


    let acheter :(Objet.type_obj * int )  -> Personnage.perso -> Personnage.perso = fun marchandise p ->
      if( Personnage.avoir_objet p Objet.Piece (snd marchandise)) then

      Personnage.modifier_sac (fst marchandise) 1 (Personnage.modifier_sac Piece (-(snd marchandise)) p)
      else
        let() = print_string (delimiteur() ^ ">Vous n'avez pas assez de pièces pour cet achat") in p
     


  let rec affiche_marchandise :Personnage.perso ->(Objet.type_obj * int ) list -> Personnage.perso= fun p liste ->
    let debut =
    if liste=[] then ">Le marchand part \n"
   else
      ">Choisissez ce dont vous avez besoin \n
    Le marchand vend :\n" ^
    let rec affiche = fun l i->
      match l with 
        |[] -> ""
        |h :: t ->(string_of_int i ) ^"  ) "^(Objet.affiche_objet (fst h) 1) ^"  : "^ (string_of_int (snd h)) ^ "  "^(Objet.affiche_objet (Objet.Piece) (snd h)) ^"\n" ^ (affiche t (i+1))
    in (affiche liste 1)
  in let () = print_string( delimiteur() ^ debut ^ "Q  ) partir\nVotre choix : ") 
  in let c = read_line() in
  let rec repValable = fun nombre ->
  match nombre with
  |0->[]
  |_ -> (string_of_int nombre) :: repValable (nombre-1)  in
 let les_reponses =  repValable (List.length liste) in
  if c="Q" || c="q" then p
  else 
     
    if(List.exists (fun i -> i=c) les_reponses) then
      let nouv_pers=acheter (List.nth liste ((int_of_string c)-1) ) p  in
    let   nouv_liste:(Objet.type_obj * int ) list -> string -> (Objet.type_obj * int ) list = fun l c -> 
      if c="1" then List.tl l
      else [List.hd l]
    
    in
    affiche_marchandise nouv_pers (nouv_liste liste c)
  else 
    let () = print_string( "il faut faire un choix\n") in
    affiche_marchandise p liste 
  



  (*let choisir_marchandise = fun marchandises -> 
    match marchandises with 
    |(Poulet,prix) -> "P "
  
  let acheter : Objet.type_obj -> Personnage.perso -> (Objet.type_obj * int ) list  -> Personnage.perso =
  fun objet p marchandises ->*)
    
	(**
		Génére une rencontre avec un monstre aléatoirement
		@auteur 
    @param pers le personnage principal
	*)
  let malheureuse_rencontre : Personnage.perso -> Personnage.perso= fun perso->
    let rand = Random.int 100 in
      if rand < 50 then 
        let monstre = Monstre.init_monstre() in
        let () = print_string (delimiteur() ^ Monstre.message_malheureuse_rencontre monstre)
        in (choixAventure perso monstre)
      else 
        perso

	(**
		affiche les hub de l'aventure avec les différents choix
		@auteur 
    @param perso le personnage principal
	*)
  let rec hubAventure : Personnage.perso -> unit = fun perso ->
    let c = read_hubAventure() in
      match c with 
      | _ when c="A" || c="a" -> hubAventure(malheureuse_rencontre(affiche_marchandise perso (marchandises())))
  
      | _ when c ="C" || c="c" -> 
        (print_string (delimiteur() ^ "> Vous continuez votre chemin vers votre prochaine destination.\n"); 
        hubAventure (malheureuse_rencontre perso))
      | _ when c="D" || c="d" -> 
        (print_string (delimiteur() ^ "> Vous installez votre campement et tombez rapidement endormie.\n"); 
        hubAventure (malheureuse_rencontre (Personnage.dormir perso)))
      | _ when c="M" || c="m" -> 
        (let mange = Personnage.manger perso in 
          if (fst mange) then 
            (print_string (delimiteur() ^ "> Vous mangez un peu avant de reprendre votre aventure.\n"); 
            hubAventure (malheureuse_rencontre (snd mange)))
          else 
            (print_string (delimiteur() ^ "> Vous n'avez pas à manger\n"); 
            hubAventure (malheureuse_rencontre (snd mange))))
      | _ when c="V" || c="v" -> 
        (print_string (delimiteur()); 
        Personnage.afficher_infos_perso perso; 
        hubAventure perso)
      |_ -> 
        raise Quitte_le_jeu
      

	(**
		Affiche la raison de la fin de partie
		@auteur 
    @param message le message de fin de partie
	*)
  let fin_partie : string -> unit = fun message ->
    print_string ("\n\n+---------------------------------Fin de partie----------------------------------+ \n" ^
    "> La partie s'est terminé car: \n" ^
    message)

end;;


