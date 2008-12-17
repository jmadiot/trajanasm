Sys.command (Printf.sprintf "./asm < %s.asm > %s.obj && ./jmsimu < %s.obj" Sys.argv.(1) Sys.argv.(1) Sys.argv.(1));;
