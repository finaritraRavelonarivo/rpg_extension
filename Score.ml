module type SCORE_SIG = 
sig
  val afficher_score : unit -> unit
  val compare_score : (string*string) -> unit
end;;


module Score : SCORE_SIG =
struct

  (**
    Vérifie si on est arrivé à la fin du fichier
    @auteur 
    @param ic les données du fichier à traiter
    @return un type some d'un tuple de string
  *)
  let validite_ligne : in_channel -> 'a option = fun ic ->
    try 
      Some (input_line ic, input_line ic)
    with 
      End_of_file -> None
  

  (**
    Regarde chaque ligne pour l'ajouter à une liste
    @auteur 
    @param ic les données du fichier à traiter 
    @return une liste avec les noms et score des personnages contenu dans le fichier
  *)
  let lire_ligne : in_channel -> (string*string) list = fun ic ->
    let rec aux = fun score ->
      match validite_ligne ic with
        | Some ligne -> aux (score@[ligne])
        | None -> score
    in aux []
  

  (**
    Regarde si le fichier existe ou le crée, puis l'ouvre
    @auteur 
    @return une liste de tuple de string avec le score et le nom des personnage dans le fichier score.txt
  *)
  let rec lire_fichier : unit -> (string*string) list  = fun () ->
    let ic = 
    try 
      open_in "score.txt"
    with 
      Sys_error _ -> (let oc = open_out "score.txt" in close_out oc;  open_in "score.txt" )
    in
    let ligne = lire_ligne ic in
    (close_in ic; ligne)


  (**
    Affiche le tableau des scores dans le terminal
    @auteur 
  *)
  let afficher_score : unit -> unit = fun () ->
    let scores = (lire_fichier ()) in
      (let rec aux = fun l -> fun n ->
        match l with 
          | (score, nom)::tl when n >= 10 -> print_string ((string_of_int n) ^ ": - " ^ nom ^ " - " ^ score ^ " -\n")
          | (score, nom)::tl -> print_string ((string_of_int n) ^ ":  - " ^ nom ^ " - " ^ score ^ " -\n"); aux tl (n+1)
          | _ -> ()
        in
      aux (scores) 1)
  

  (**
    Ecrit dans le fichier le nouveau tableau des scores
    @auteur 
    @param l une liste des nom et score
    @param oc l'output du fichier pour écrire dedans
  *)  
  let ecrire_fichier : (string*string) list -> out_channel -> unit = fun l -> fun oc ->
    let rec aux = fun l -> fun oc -> fun n ->
      match l with 
        | _ when n > 10 -> close_out oc
        | (score, nom)::tl -> (Printf.fprintf oc "%s\n" nom; Printf.fprintf oc "%s\n" score; aux tl oc (n+1)) 
        | _ -> close_out oc
    in aux l oc 1


  (**
    Ouvre le fichier score pour récupérer les scores déjà présents puis ajouter ou non le nouveau score du joueur
    @auteur 
    @param score le score du joueur
    @param nom le nom du personnage
  *)
  let compare_score : (string*string) -> unit = fun (score, nom) ->
    let scores = lire_fichier () in   
    let new_scores = (score, nom)::scores in
    let compare = fun (score1,_) -> fun (score2,_) -> 
      (int_of_string score2) - (int_of_string score1) in
    let org_scores = List.sort compare new_scores in 
    let oc = open_out "score.txt" in 
    ecrire_fichier org_scores oc; 

end;;