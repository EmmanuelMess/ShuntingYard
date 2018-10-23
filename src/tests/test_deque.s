.data

.text
main:
  jal create_deque
  move $t0, $v0
 
  li $v0, 10
  syscall
