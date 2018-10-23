.text
main:
  jal create_deque
  move $t0, $v0

  li 
 
  jal create_token
  move $t1, $v0


  move $a0, $t0
  move $a1, $t1
  jal push_back_deque

  

end:
  li $v0, 10
  syscall
