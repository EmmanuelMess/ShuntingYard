#struct Deque {
#  uint_32 size
#  Node *front
#  Node *back
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

push_back_deque:		#(a0 Deque, a1 Token)
  move $t0, $a0

  lw $t1, ($t0)
  addiu $t1, $t1, 1
  sw $t1, ($t0)
  
  li $a0, 12
  li $v0, 9
  syscall
  move $t1, $v0

  lw $t2, 8($t0)
  sw $t2, ($t1)
  sw $0, 4($t1)
  sw $a1, 8($t1)

  beq $0, $t2, push_back_deque_c0
  sw $t1, 4($t2)
push_back_deque_c0:
  lw $t2, 4($t0)
  
  bne $0, $t2, push_back_deque_c1
  sw $t1, 4($t0)
push_back_deque_c1:
  sw $t1, 8($t0)

  jr $ra

push_front_deque:                #(a0 Deque, a1 Token)
  move $t0, $a0

  lw $t1, ($t0)
  addiu $t1, $t1, 1
  sw $t1, ($t0)

  li $a0, 12
  li $v0, 9
  syscall
  move $t1, $v0

  lw $t2, 4($t0)
  sw $t2, 4($t1)
  sw $a1, 8($t1)
  sw $0, ($t1)

  beq $0, $t2, push_front_deque_c0
  sw $t1, ($t2)
push_front_deque_c0:
  lw $t2, 8($t0)

  bne $0, $t2, push_front_deque_c1
  sw $t1, 8($t0)
push_front_deque_c1:
  sw $t1, 4($t0)

  jr $ra

peek_back_deque:
  lw $t0, 8($a0)
  lw $v0, 8($t0)

  jr $ra
