create_shunting_yard:
  la $a0, LOADING_TREE
  li $v0, 4
  syscall

  jr $ra
