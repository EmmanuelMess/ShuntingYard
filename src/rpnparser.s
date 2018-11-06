rpn_parser:
  sub $sp $sp 4
  sw $ra ($sp)

  move $s0, $a0

  jal create_deque
  move $s1, $v0

l0_begin_rpn_parser:
  move $a0, $s0
  jal size_deque

  beq $v0, $0, l0_end_rpn_parser
  
  move $a0, $s0
  jal peek_front_deque
  
  la $t0, TOK_NUM
  lb $t0, ($t0)
  lb $t1, ($v0)
  bne $t0, $t1, is_operator
  move $a0, $s1
  move $a1, $v0
  jal push_back_deque

  j l0_continue_rpn_parse
  
is_operator:
  move $s4, $t1

  move $a0, $s1
  jal peek_back_deque
  lb $s2, 1($v0)

  move $a0, $s1
  jal pop_back_deque

  move $a0, $s1
  jal peek_back_deque
  lb $s3, 1($v0)
  
  move $a0, $s1
  jal pop_back_deque

  la $t0, TOK_SUM
  lb $t0, ($t0)
  beq $t0, $s4, op_sum

  la $t0, TOK_SUB
  lb $t0, ($t0)
  beq $t0, $s4, op_sub

  la $t0, TOK_MULT
  lb $t0, ($t0)
  beq $t0, $s4, op_mult

  la $t0, TOK_DIV
  lb $t0, ($t0)
  beq $t0, $s4, op_div

  la $t0, TOK_EQ
  lb $t0, ($t0)
  beq $t0, $s4, op_eq

op_sum:
  add $s2, $s2, $s3
  j op_end

op_sub:
  sub $s2, $s2, $s3
  j op_end

op_mult:
  mult $s2, $s3
  mflo $s2
  j op_end

op_div:
  div $s2, $s3
  mflo $s2
  j op_end

op_eq:
  beq $s2, $s3, eq
neq:
  li $s2, 0
  j op_end
eq:
  li $s2, 1
  j op_end

op_end:
  la $t0, TOK_NUM
  lb $a0, ($t0)
 
  move $a1, $s2
  jal create_token

  move $a0, $s1
  move $a1, $v0
  jal push_back_deque

l0_continue_rpn_parse:
  move $a0, $s0
  jal pop_front_deque

  j l0_begin_rpn_parser

l0_end_rpn_parser:
  move $a0, $s1
  jal peek_back_deque
 
  lb $s2, 1($v0)

  move $a0, $s1
  jal pop_back_deque

  move $v0, $s2

  lw $ra ($sp)
  addi $sp, $sp, 4

  jr $ra
