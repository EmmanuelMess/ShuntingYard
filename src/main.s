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

  j end

print_infix:

  j end

print_prefix:

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
