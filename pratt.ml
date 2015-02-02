
open Foundation
open Lexicon
open Syntax
open Parser


let rec parse_loop rbp left =
    get >>= fun { symbol } ->
        match (symbol.led, symbol.nud) with
        | (Some led, _) -> if symbol.lbp > rbp
                           then advance >> led left >>= parse_loop rbp
                           else return left
        | (None, Some nud) -> advance >> nud >>= fun a ->
                                parse_loop rbp (append_expr left a)
        | (None, None) -> error (format "Error: No parser for token %s"
                                        (show_token symbol.tok))


let parse_expression rbp =
    get >>= fun { symbol } ->
        symbol.nud => function
        | None -> error (format "No nud for token `%s`." (show_token symbol.tok))
        | Some nud -> advance >> nud >>= parse_loop rbp
