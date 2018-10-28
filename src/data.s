.data
  INITIAL:              .asciiz "Ingrese operacion: "
                        .align  2
  CHOOSE:               .asciiz "\n0) Imprimir arbol\n1) Imprimir resultado\n2) Como notacion infija\n3) Como notacion prefija\nChoose option number: "
                        .align  2
  FAILED_TO_CHOOSE:     .asciiz "Deberia haber elejido una opcion del 0 al 3\n"
                        .align 2
  FAILED_TO_PARSE:      .asciiz "Error parseando"
                        .align 2
  LOADING_TREE:         .asciiz "Loading tree...\n"
                        .align  2

  SAVED_EXPR:           .space  80

  TOK_MULT:             .byte   4
  TOK_DIV:              .byte   4
  TOK_SUM:              .byte   3
  TOK_SUB:              .byte   3
  TOK_EQ:               .byte   0
  TOK_NUM:              .byte   14
                        .align  2

