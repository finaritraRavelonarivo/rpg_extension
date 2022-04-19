module Score =
struct
  let validite_ligne = fun ic ->
    try Some (int_of_string (input_line ic), input_line ic)
    with End_of_file -> None
  
  let lire_ligne  = fun ic ->
    let rec aux = fun score ->
      match validite_ligne ic with
      | Some ligne -> aux (score@[ligne])
      | None -> score
    in
    aux []
  
  let lire_fichier = fun () ->
    let ic = open_in "score.txt" in
    let ligne = lire_ligne ic in
    (close_in ic; ligne)

  let afficher_score = fun () ->
    let rec aux = fun l ->
      match l with 
      | (score, nom)::tl -> nom ^ " " ^ (string_of_int score) ^ "\n" ^ aux tl
      | _ -> ""
    in
    aux (lire_fichier ())

  let rec ecrire_fichier = fun l ->
    let oc = open_out "score.txt" in 
    match l with 
    | (score, nom)::tl -> (Printf.fprintf oc "%s\n" nom; Printf.fprintf oc "%s\n" (string_of_int score); ecrire_fichier tl) 
    | _ -> close_out oc

  let compare_score = fun (nom, score) ->
    let scores = lire_fichier () in   
    let new_scores = (nom, score)::scores in
    let compare = fun (score,_) -> fun (score2,_) -> score - score2 in
    let org_scores = List.sort compare new_scores in
    if List.length (org_scores) > 10 then 
      ecrire_fichier (List.rev (List.tl (List.rev org_scores)))
    else 
      ecrire_fichier org_scores
    ;afficher_score

end;;