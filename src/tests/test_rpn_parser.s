.text
main:
  la $t0, SAVED_EXPR
  
  li $t1, '3'
  sb $t1, ($t0)

  li $t1, '+'
  sb $t1, 1($t0)

  li $t1, '1'
  sb $t1, 2($t0)

  jal create_shunting_yard
  move $a0, $v0
  jal rpn_parser

  move $a0, $v0
  li $v0, 1
  syscall
end:
  li $v0, 10
  syscall
