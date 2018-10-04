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
