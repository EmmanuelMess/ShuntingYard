.text
main:
  la $t0, SAVED_EXPR
  
  li $t1, '3'
  sb $t1, ($t0)

  li $t1, '+'
  sb $t1, 1($t0)

  li $t1, '1'
  sb $t1, 2($t0)

  jal create_shunting_yard
  move $s0, $v0


  move $a0, $s0
  jal peek_back_deque

  lb $a0, ($v0)
  li $v0, 1
  syscall

  move $a0, $s0
  jal pop_back_deque

 
  move $a0, $s0
  jal peek_back_deque

  lb $a0, ($v0)
  li $v0, 1
  syscall

  move $a0, $s0
  jal pop_back_deque

 
  move $a0, $s0
  jal peek_back_deque

  lb $a0, ($v0)
  li $v0, 1
  syscall

  move $a0, $s0
  jal pop_back_deque
end:
  li $v0, 10
  syscall
