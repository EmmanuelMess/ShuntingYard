create_shunting_yard:
  sub $sp $sp 4
  sw $ra ($sp)

  la $a0, LOADING_TREE
  li $v0, 4
  syscall

  jal create_stack
  move $t0, $v0		#$t0 contains stack

  jal create_queue
  move $t1, $v0		#$t1 contains queue

  lw $ra ($sp)

  jr $ra

create_node:
  li $a0, 8
  li $v0, 9
  syscall

  
