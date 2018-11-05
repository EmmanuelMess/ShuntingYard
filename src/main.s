.text
main:
  la $a0, INITIAL
  li $v0, 4
  syscall

  la $a0, SAVED_EXPR
  li $a1, 79
  li $v0, 8
  syscall

  la $a0, CHOOSE
  li $v0, 4
  syscall

  li $v0, 5
  syscall

select_correct_option:
  li $t0, 0
  beq $v0, $t0, print_tree

  li $t0, 1
  beq $v0, $t0, print_result

  li $t0, 2
  beq $v0, $t0, print_infix

  li $t0, 3
  beq $v0, $t0, print_prefix

  j failed_to_choose

print_tree:
  jal create_shunting_yard 
  j end

print_result:
  jal create_shunting_yard
  move $a0, $v0
  jal rpn_parser
  move $a0, $v0
  
  li $v0, 1
  syscall

  j end

print_infix:
  li $v0, 4
  la $a0, SAVED_EXPR
  syscall
  j end

print_prefix:
  jal create_shunting_yard
  move $s0, $v0

l0_begin_print_prefix:
  move $a0, $s0
  jal size_deque

  beq $v0, $0, l0_end_print_prefix
  
  move $a0, $s0
  jal peek_front_deque

  la $t0, TOK_NUM
  lb $t0, ($t0)
  lb $t1, ($v0)
  bne $t0, $t1, is_op
  lb $a0, 1($v0)
  addi $a0, $a0, 48		#48 = '0'
  j l0_continue_print_prefix

is_op:
  la $t0, TOK_SUM
  lb $t0, ($t0)
  beq $t0, $t1, ope_sum

  la $t0, TOK_SUB
  lb $t0, ($t0)
  beq $t0, $t1, ope_sub

  la $t0, TOK_MULT
  lb $t0, ($t0)
  beq $t0, $t1, ope_mult

  la $t0, TOK_DIV
  lb $t0, ($t0)
  beq $t0, $t1, ope_div

  la $t0, TOK_EQ
  lb $t0, ($t0)
  beq $t0, $t1, ope_eq

ope_sum:
  li $a0, 43		# 43 = '+'
  j l0_continue_print_prefix

ope_sub:
  li $a0, 45		# 45 = '-'
  j l0_continue_print_prefix

ope_mult:
  li $a0, 42		# 42 = '*'
  j l0_continue_print_prefix

ope_div:
  li $a0, 47		# 47 = '/'
  j l0_continue_print_prefix

ope_eq:
  li $a0, 61		# 61 = '='
  j l0_continue_print_prefix

l0_continue_print_prefix:
  li $v0, 11
  syscall
  
  move $a0, $s0
  jal pop_front_deque

  j l0_begin_print_prefix
l0_end_print_prefix:
  li $v0, 11
  li $a0, 0
  syscall

  j end

failed_to_choose:
  la $a0, FAILED_TO_CHOOSE
  li $v0, 4
  syscall
  j end

failed_to_parse:
  la $a0, FAILED_TO_PARSE
  li $v0, 4
  syscall
  j end

end:
  li $v0, 10
  syscall
