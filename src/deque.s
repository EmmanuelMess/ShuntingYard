#struct Deque {
#  uint_32 size
#  Deque *front
#  Deque *back
#}

#struct Node {
#  Node *last
#  Node *next
#  Token *tok
#}

create_deque:
  li $a0, 12		#sizeof(Deque)
  li $v0, 9
  syscall
  move $t0, $v0

  li $t1, 0
  sw $t1, ($t0)
  sw $t1, 4($t0)
  sw $t1, 8($t0)

  move $v0, $t0

  jr $ra

push_back_deque:
  move $t0, $a0
  
  lw $t1, ($t0)
  addiu $t1, $t1, 1
  sw $t1, ($a0)
  
  li $a0, 8
  li $v0, 9
  syscall
  move $t1, $v0

  

