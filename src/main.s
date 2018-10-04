.data
  INITIAL:		.asciiz	"Ingrese operacion: "
			.align	2
  CHOOSE:		.asciiz	"\n0) Imprimir arbol\n1) Imprimir resultado\n2) Como notacion infija\n3) Como notacion prefija\nChoose option number: "
			.align	2
  FAILED_TO_CHOOSE:	.asciiz "Deberia haber elejido una opcion del 0 al 3\n"
			.align 2
  LOADING_TREE:		.asciiz "Loading tree...\n"
			.align	2

  SAVED_EXPR		.space	80

  TOK_MULT:		.word	0
  TOK_DIV:		.word   1
  TOK_SUM:		.word   2
  TOK_SUB:		.word   3
  TOK_EQ:		.word   4
			.align	2
.text
main:
  la $a0, INITIAL
  li $v0, 4
  syscall

  la $a0, SAVED_EXPR
  li $a1, 79
  li $v0, 8
  syscall

  la $a0, CHOOSE
  syscall

  li $v0, 5
  syscall

select_correct_option:
  li $t0, 0
  beq $v0, $t0, print_tree

  li $t0, 1
  beq $v0, $t0, print_result

  li $t0, 2
  beq $v0, $t0, print_infix

  li $t0, 3
  beq $v0, $t0, print_prefix

  j failed_to_choose

print_tree:
  jal create_shunting_yard 
  j end

print_result:

  j end

print_infix:

  j end

print_prefix:

  j end

failed_to_choose:
  la $a0, FAILED_TO_CHOOSE
  li $v0, 4
  syscall

end:
  li $v0, 10
  syscall
