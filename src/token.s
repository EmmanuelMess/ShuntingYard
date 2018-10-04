#struct Token {
#  uint_8 token_code
#  /*24 bits padding*/
#}

create_token:
  move $t0, $a0

  li $a0, 4		#sizeof(Token)
  li $v0, 9
  syscall
  move $t1, $v0

  sb $t0, ($t1)

  jr $ra
