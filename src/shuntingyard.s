create_shunting_yard:
  sub $sp $sp 4
  sw $ra ($sp)

  la $a0, LOADING_TREE
  li $v0, 4
  syscall

  jal create_deque
  move $s0, $v0		#s0 contains stack

  jal create_deque
  move $s1, $v0		#s1 contains queue

  la $s2, SAVED_EXPR
  lb $s3, ($s2)

l0_begin:
  beq $s3, $0, l0_end
  
  move $a0, $s3
  jal match
  beq $v0, $0, l0_continue

  move $a0, $s0
  move $a1, $s1
  move $a2, $v0
  jal save_token

l0_continue:
  addi $s2, $s2, 1 
  lb $s3, ($s2)
  j l0_begin

l0_end:
l1_start_shunting_yard:
  move $a0, $s0
  jal size_deque
  
  beq $v0, $0, l1_end_shunting_yard
  
  move $a0, $s0
  jal peek_back_deque
  move $s2, $v0

  move $a0, $s0
  jal pop_back_deque
  
  move $a0, $s1
  move $a1, $s2
  jal push_back_deque

  j l1_start_shunting_yard

l1_end_shunting_yard:
  lw $ra ($sp)
  addi $sp, $sp, 4

  move $v0, $s1

  jr $ra

match:
  sub $sp $sp 4
  sw $ra ($sp)

  li $t0, 10		# 10 = '\n' 
  beq $a0, $t0, return_null

  li $t0, 32		# 32 = ' '
  beq $a0, $t0, return_null

  li $t0, 42		# 42 = '*'
  beq $a0, $t0, return_token_mult

  li $t0, 47		# 47 = '/'
  beq $a0, $t0, return_token_div

  li $t0, 43		# 43 = '+'
  beq $a0, $t0, return_token_sum

  li $t0, 45		# 45 = '-'
  beq $a0, $t0, return_token_sub

  li $t0, 61		# 61 = '='
  beq $a0, $t0, return_token_eq

  li $t0, 48		# 48 = '0'
  blt $a0, $t0, match_fail
  li $t0, 57		# 57 = '9'
  bgt $a0, $t0, match_fail

  j return_token_num

match_fail:
  j failed_to_parse

return_token_mult:
  la $t0, TOK_MULT
  lb $a0, ($t0)
  li $a1, 0
  jal create_token
  j end_match
return_token_div:
  la $t0, TOK_DIV
  lb $a0, ($t0)
  li $a1, 0
  jal create_token
  j end_match
return_token_sum:
  la $t0, TOK_SUM
  lb $a0, ($t0)
  li $a1, 0
  jal create_token
  j end_match
return_token_sub:
  la $t0, TOK_SUB
  lb $a0, ($t0)
  li $a1, 0
  jal create_token
  j end_match
return_token_eq:
  la $t0, TOK_EQ
  lb $a0, ($t0)
  li $a1, 0
  jal create_token
  j end_match
return_token_num:
  sub $a1, $a0, 48	# 48 = '0'

  la $t0, TOK_NUM
  lb $a0, ($t0)

  jal create_token
  j end_match
return_null:
  li $v0, 0
  j end_match
end_match:
  lw $ra ($sp)
  addi $sp, $sp, 4
  jr $ra


save_token:		#a0 stack, a1 queue, a2 token
  sub $sp $sp 20
  sw $ra ($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)

  move $s0, $a0
  move $s1, $a1
  move $s2, $a2

  la $t0, TOK_NUM
  lb $t0, ($t0)

  lb $t1, ($s2)
  beq $t0, $t1, token_is_number

token_is_operator:
  move $a0, $s0
  jal size_deque
  beq $v0, $0, l0_end_save_token

  move $a0, $s0
  jal peek_back_deque
  move $s3, $v0
  
  lb $t0, ($s3)

  lb $t1, ($s2)

  bge $t0, $t1, l0_end_save_token
  
  move $a0, $s0
  jal pop_back_deque
  
  move $a0, $s1
  move $a1, $s3
  jal push_back_deque

  j token_is_operator

l0_end_save_token:
  move $a0, $s0
  move $a1, $s2
  jal push_back_deque

  j end_save_token

token_is_number:
  move $a0, $s1
  move $a1, $s2
  jal push_back_deque

  j end_save_token

end_save_token:
  lw $ra ($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  lw $s2, 12($sp)
  lw $s3, 16($sp)

  addi $sp, $sp, 20

  jr $ra
