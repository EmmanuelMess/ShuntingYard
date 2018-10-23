#struct Queue {
#  uint_32 size
#  Queue *start
#  Queue *end
#}

#struct Node {
#  Queue *next
#  Token *tok
#}

create_queue:
  li $a0, 12		#sizeof(Queue)
  li $v0, 9
  syscall
  move $t0, $v0

  li $t1, 0
  sw $t1, ($t0)
  sw $t1, 4($t0)
  sw $t1, 8($t0)

  move $v0, $t0

  jr $ra

push_queue:		(a0 Queue, a1 token)
  move $t0, $a0
  
  lw $t1, ($t0)
  addi $t1, $t1, 1
  sw $t1, ($a0)

  li $a0, 8
  li $v0, 9
  syscall
  move $t1, $v0

  beq $

  sw $a1, 4($t1)

  lw $t2, 4($t0)

  sw 

  move 
