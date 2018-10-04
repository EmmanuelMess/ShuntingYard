.data
  INITIAL:	.asciiz	"Ingrese operacion: "
  CHOOSE:	.asciiz	"\n0) Imprimir arbol\n1) Imprimir resultado\n2) Como notacion infija\n3) Como notacion prefija\nChoose option number:"
.text
main:
  la $a0, INITIAL
  li $v0, 4
  syscall

  la $a0, CHOOSE
  syscall

  li $v0, 10
  syscall
