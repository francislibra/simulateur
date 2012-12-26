(* 
 * Module qui sépare et renomme les différents indentifieurs
 * en fonction de leur rôle pour faciliter leur intégration dans le graphe.
 * Plus précisément :
 * - Le module gère la correspondance entre les noms de variables et les
 *   identifieurs entiers.
 *
 * - Le module permet de tester si un identifiant est un registre
 *
 * - Chaque variable peut dépendre d'un certain nombre d'autres variables
 *   (de 1 à 4 pour l'opération RAM) : la fonction get_instructions
 *   simplifie ça en ne renvoyant que des couples de dépendances
 *)

open Netlist_ast ;; 

type t

(* Crée le proxy à partir de la netlist *)
val create_from_program : program -> t

(** Fonctions facilitant une traduction vers un graphe **)

(* Nombre d'entrées *)
val nb_inputs : t -> int

(* Nombre de sorties *)
val nb_outputs : t -> int 

(* Nombre de variables intermédiaires 
 * qui figurent dans la netlist, dont
 * les registres *)
val nb_variables : t -> int

(* Nombre de registres *)
val nb_registers : t -> int

(* Nombre total d'identifiants : inputs + outputs + variables *)
val nb_identifiers : t -> int

(* Les identifieurs sont rangés dans l'ordre ci-dessus :
 * input_1 ... input_k output_1 .. output_p variable_1 ... variableq
 * (les variables comprenant les registres) *)

(* Identifieur d'une entrée, sortie, variable ou registre *)
val get_id : t -> string -> int

(* Vrai nom d'une entrée, sortie, variable ou registre *)
val get_name : t -> int -> string 

(* Cette variable est-elle un registre ? *)
val is_register : t -> int -> bool

(* Récupère les instructions *)
(* (a,b) veut dire a dépend de b *)
val get_instructions : t -> (int * int) list