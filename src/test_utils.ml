
open Fold.Foundation
open Fold.Lexer
open Fold.Syntax
open Fold.Pratt
open Fold.Lang

(* -- Mini Testing Engine -- *)

let parse_string s =
    init ~lexer: (create_lexer_with_string "Fold.Lang.Tests" s)
         ~grammar: core_lang ()

let (~>) s =
  try
    print ((bright_blue "-> ") ^ s);
    print (" = " ^ show_expr (parse_string s))
  with Failure msg ->
    print_endline (bright_red " * " ^ bright_white "Error" ^ ": " ^ msg);
    flush stdout

let (~~) s = ()

let (==) s e =
  try
    print_endline (format "%s %s" (bright_blue "->") (white s));
    let r = parse_string s in
    let y = r = e in
    let i = if y then (bright_green "✓ ") else (bright_red "✗ ") in
    print_endline (format "%s %s %s %s" i (show_expr r) "::" (red "Expr"));
    if not y then
        (print_endline (format "\n  Expected: %s" (show_expr e));
       print_endline (format "    Actual: %s\n" (show_expr r)))
    else ()
  with Failure msg ->
    print_endline (bright_red " * " ^ bright_white "Error" ^ ": " ^ msg);
    flush stdout

let (!!) s =
  try
    print_endline (format "%s %s" (bright_blue "->") (white s));
    let r = parse_string s in
    let m = bright_red "✗ " in
    print_endline (format "%s %s %s %s" m (show_expr r) "::" (red "Expr"));
    print_endline (bright_red " * " ^ bright_white "Error: expression expected to fail.");
  with Failure msg ->
    let m = (bright_green "✓ ") in
    print_endline (format "%s %s" m (bright_white ("Expected failure" ^ ": " ^ msg)));
    flush stdout

