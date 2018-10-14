#struct Token {
#  uint_8 token_code
#  uint_8 token_value
#  /*16 bits padding*/
#}

create_token:
  li $a0, 4		#sizeof(Token)
  li $v0, 9
  syscall
  move $t0, $v0

  sb $a0, ($t0)
  sb $a1, 1($t0)

  jr $ra
