#struct Token {
#  uint_8 token_code
#  uint_8 token_value
#  /*16 bits padding*/
#}

create_token:
  move $t0, $a0
  move $t1, $a1

  li $a0, 4		#sizeof(Token)
  li $v0, 9
  syscall
  move $t2, $v0

  sb $t0, ($t2)
  sb $t1, 1($t2)

  jr $ra
