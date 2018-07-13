(** Thin wrapper around Menhir-generated parser, providing a saner interface. *)

(** Registers a pretty printer for lex and parse exceptions. This results in
    colorful error messages including the source location when errrors occur. *)
let pp_exceptions () : unit =
  Printexc.register_printer (fun exn ->
      Base.Option.try_with (fun () ->
          Location.report_exception Format.str_formatter exn ;
          Format.flush_str_formatter () ) )

open Base

let ast_of_string ?pos (s : string) = 
  LexLox.parse_string ?pos s MenhirParser.ast_eof

let ast_of_file (file : string) = 
  LexLox.parse_file ~file MenhirParser.ast_eof

