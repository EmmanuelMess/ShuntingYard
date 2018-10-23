create_shunting_yard:
  sub $sp $sp 4
  sw $ra ($sp)

  la $a0, LOADING_TREE
  li $v0, 4
  syscall

  jal create_stack
  move $s0, $v0		#$t0 contains stack

  jal create_queue
  move $s1, $v0		#$t1 contains queue

  la $s2, SAVED_EXPR
  lb $s3, ($s2)

l0_begin:
  beq $s3, $0, l0_end
  
  move $a0, $s3
  jal match
  beq $v0, $0, l0_continue

  move $a0, $v0
  jal save_token

l0_continue:
  addi $s2, $s2, 1 
  lb $s3, ($s2)
  j l0_begin

l0_end:
  lw $ra ($sp)
  jr $ra

match:
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
  jal create_token
  jr $ra
return_token_div:
  la $t0, TOK_DIV
  lb $a0, ($t0)
  jal create_token
  jr $ra
return_token_sum:
  la $t0, TOK_SUM
  lb $a0, ($t0)
  jal create_token
  jr $ra
return_token_sub:
  la $t0, TOK_SUB
  lb $a0, ($t0)
  jal create_token
  jr $ra
return_token_eq:
  la $t0, TOK_EQ
  lb $a0, ($t0)
  jal create_token
  jr $ra
return_token_num:
  sub $a1, $a0, 48	# 48 = '0'

  la $t0, TOK_NUM
  lb $a0, ($t0)

  jal create_token
  jr $ra
return_null:
  li $v0, 0
  jr $ra


save_token:		#a0 stack a1 queue, a2 token
  la $t0, TOK_NUM
  lb $t0, ($t0)

  lb $t1, ($a2)
  beq $t0, $t1, token_is_number

token_is_number:
  move $a0, $a1
  move $a1, $a2
  jal push_queue
