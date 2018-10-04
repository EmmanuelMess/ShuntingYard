#struct Stack {
#  uint_32 size
#  Node *last
#}

#struct Node {
#  Node *last
#  Token *tok
#}

create_stack:
  li $a0, 8		#sizeof(Stack)
  li $v0, 9
  syscall
  move $t0, $v0

  li $t1, 0
  sw $t1, ($t0)
  sw $t1, 4($t0)
  
  move $v0, $t0

  jr $ra
