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
    in
    aux []
  
  let lire_fichier : unit -> (string * string) list  = fun () ->
    let ic = open_in "score.txt" in
    let ligne = lire_ligne ic in
    (close_in ic; ligne)

  let afficher_score = fun () ->
    let ligne = lire_fichier in
    print
    (*let rec aux = fun l ->
      match l with 
      | (nom, score)::tl -> nom ^ " " ^ score ^ "\n" ^ aux tl
      | _ -> ""
    in
    aux lire_fichier() *)
end;;