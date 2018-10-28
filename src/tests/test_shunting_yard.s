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

end:
  li $v0, 10
  syscall
