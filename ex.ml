Sys.command (Printf.sprintf "./asm < %s.asm > %s.obj && ./simu < %s.obj" Sys.argv.(1) Sys.argv.(1) Sys.argv.(1));;
