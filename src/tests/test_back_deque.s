.text
main:
  jal create_deque
  move $s0, $v0

  la $t0, TOK_NUM 
  lb $a0, ($t0)

  li $a1, 10 

  jal create_token
  move $s1, $v0


  move $a0, $s0
  move $a1, $s1
  jal push_back_deque

  la $t0, TOK_MULT
  lb $a0, ($t0) 
  
  li $a1, 0

  jal create_token
  move $s2, $v0

  move $a0, $s0
  move $a1, $s2
  jal push_back_deque
 
  move $a0, $s0
  jal size_deque
 
  move $a0, $v0
  li $v0, 1
  syscall
 
  move $a0, $s0
  jal peek_back_deque
 
  move $a0, $v0
  li $v0, 1 
  #syscall

  move $a0, $s0
  jal pop_back_deque
  
  move $a0, $s0
  jal size_deque
  
  move $a0, $v0
  li $v0, 1
  syscall
 
end:
  li $v0, 10
  syscall
