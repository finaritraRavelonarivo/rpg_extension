module Score =
struct
  let validite_ligne = fun ic ->
    try Some (input_line ic, input_line ic)
    with End_of_file -> None
  
  let lire_ligne  = fun ic ->
    let rec aux = fun score ->
      match validite_ligne ic with
      | Some ligne -> aux (score@[ligne])
      | None -> score
    in aux []
  
  let rec lire_fichier = fun () ->
    let ic = 
    try open_in "score.txt"
    with Sys_error _ -> (let oc = open_out "score.txt" in close_out oc;  open_in "score.txt" )
    in
    let ligne = lire_ligne ic in
    (close_in ic; ligne)

  let afficher_score = fun () ->
    let scores = (lire_fichier ()) in
    (let rec aux = fun l -> fun n ->
      match l with 
      | (score, nom)::tl when n >= 10 -> print_string ((string_of_int n) ^ ": - " ^ nom ^ " - " ^ score ^ " -\n")
      | (score, nom)::tl -> print_string ((string_of_int n) ^ ":  - " ^ nom ^ " - " ^ score ^ " -\n"); aux tl (n+1)
      | _ -> ()
    in
    aux (scores) 1)

  let ecrire_fichier = fun l -> fun oc ->
    let rec aux = fun l -> fun oc -> fun n ->
      match l with 
      | _ when n > 10 -> close_out oc
      | (score, nom)::tl -> (Printf.fprintf oc "%s\n" nom; Printf.fprintf oc "%s\n" score; aux tl oc (n+1)) 
      | _ -> close_out oc
    in aux l oc 1

  let compare_score = fun (score, nom) ->
    let scores = lire_fichier () in   
    let new_scores = (score, nom)::scores in
    let compare = fun (score1,_) -> fun (score2,_) -> (int_of_string score2) - (int_of_string score1) in
    let org_scores = List.sort compare new_scores in 
    let oc = open_out "score.txt" in 
    ecrire_fichier org_scores oc; 

end;;