.data
arg:            .word 9, 8, 6, 5, 3, 2, 1, 0, -1, -3
arg_size:       .word 10
str:            .string "Before sort:"
new_line:       .string "\n"
comma:          .string ","

.text
main:
        # print str
        la      a0, str
        li      a7, 4
        ecall
        la      a0, new_line
        li      a7, 4
        ecall

        # show array
        la      a0, arg
        lw      a1, arg_size
	
	## caller register
	addi    sp, sp, -64  # 32 bits alignment
        sw      a0, 60(sp)
        sw      a1, 56(sp)
        sw      a2, 52(sp)
        sw      a3, 48(sp)
        sw      a4, 44(sp)
        sw      a5, 40(sp)
        sw      a6, 36(sp)
        sw      a7, 32(sp)
        sw      t0, 28(sp)
        sw      t1, 24(sp)
        sw      t2, 20(sp)
        sw      t3, 16(sp)
        sw      t4, 12(sp)
        sw      t5, 8(sp)
        sw      t6, 4(sp)
        
	jal     ra, show_array

	## caller register
	addi    sp, sp, 64  # 32 bits alignment
        lw      a0, -4(sp)
        lw      a1, -8(sp)
        lw      a2, -12(sp)
        lw      a3, -16(sp)
        lw      a4, -20(sp)
        lw      a5, -24(sp)
        lw      a6, -28(sp)
        lw      a7, -32(sp)
        lw      t0, -36(sp)
        lw      t1, -40(sp)
        lw      t2, -44(sp)
        lw      t3, -48(sp)
        lw      t4, -52(sp)
        lw      t5, -56(sp)
        lw      t6, -60(sp)


	#merge_sort(arg, 0, len - 1);
        la      a0, arg
        mv	a1, x0
        lw      t0, arg_size
	addi	t1, t0, -1
	mv	a2, t1
	## caller register
	addi    sp, sp, -64  # 32 bits alignment
        sw      a0, 60(sp)
        sw      a1, 56(sp)
        sw      a2, 52(sp)
        sw      a3, 48(sp)
        sw      a4, 44(sp)
        sw      a5, 40(sp)
        sw      a6, 36(sp)
        sw      a7, 32(sp)
        sw      t0, 28(sp)
        sw      t1, 24(sp)
        sw      t2, 20(sp)
        sw      t3, 16(sp)
        sw      t4, 12(sp)
        sw      t5, 8(sp)
        sw      t6, 4(sp)
        
	jal     ra, merge_sort 

	## caller register
	addi    sp, sp, 64  # 32 bits alignment
        lw      a0, -4(sp)
        lw      a1, -8(sp)
        lw      a2, -12(sp)
        lw      a3, -16(sp)
        lw      a4, -20(sp)
        lw      a5, -24(sp)
        lw      a6, -28(sp)
        lw      a7, -32(sp)
        lw      t0, -36(sp)
        lw      t1, -40(sp)
        lw      t2, -44(sp)
        lw      t3, -48(sp)
        lw      t4, -52(sp)
        lw      t5, -56(sp)
        lw      t6, -60(sp)


	# exit program
	li	a7, 10
	ecall

# a0: char *arg
# a1: int len
show_array:
	# entry func
	addi    sp, sp, -64  # 32 bits alignment
        sw      ra, 60(sp)
        sw      s0, 56(sp)
        sw      s1, 52(sp)
        sw      s2, 48(sp)
        sw      s3, 44(sp)
        sw      s4, 40(sp)
        sw      s5, 36(sp)
        sw      s6, 32(sp)
        sw      s7, 28(sp)
        sw      s8, 24(sp)
        sw      s9, 20(sp)
        sw      s10, 16(sp)
        sw      s11, 12(sp)
	addi	s0, sp, 64

        mv      t0, a0
        mv      t1, a1
        li      t2, 0
loop_start:
        add     t3, t2, t2
        add     t3, t3, t3
        add     t3, t3, t0
        lw      a0, 0(t3)
        li      a7, 1
        ecall
        addi    t2, t2, 1
        bge     t2, t1, loop_end
        la      a0, comma
        li      a7, 4
        ecall
	jal	x0, loop_start
loop_end:
	# exit func
	mv	sp, s0 
	lw	ra, -4(sp)
	lw	s0, -8(sp)
	lw	s1, -12(sp)
	lw	s2, -16(sp)
	lw	s3, -20(sp)
	lw	s4, -24(sp)
	lw	s5, -28(sp)
	lw	s6, -32(sp)
	lw	s7, -36(sp)
	lw	s8, -40(sp)
	lw	s9, -44(sp)
	lw	s10, -48(sp)
	lw	s11, -52(sp)
	jalr	x0, ra, 0

# a0: char *arg
# a1: int start
# a2: int end
merge_sort:
	# entry func
	addi    sp, sp, -64  # 32 bits alignment
        sw      ra, 60(sp)
        sw      s0, 56(sp)
        sw      s1, 52(sp)
        sw      s2, 48(sp)
        sw      s3, 44(sp)
        sw      s4, 40(sp)
        sw      s5, 36(sp)
        sw      s6, 32(sp)
        sw      s7, 28(sp)
        sw      s8, 24(sp)
        sw      s9, 20(sp)
        sw      s10, 16(sp)
        sw      s11, 12(sp)
	addi	s0, sp, 64

	# start
	mv	s1, a0
	mv	s2, a1
	mv	s3, a2

	bgeu	a1, a2, merge_sort_out
	add	t0, a1, a2
	srai	t1, t0. 1

	# merge_sort(arg, start, mid);
	mv	a2, t1
	## caller register
	addi    sp, sp, -64  # 32 bits alignment
        sw      a0, 60(sp)
        sw      a1, 56(sp)
        sw      a2, 52(sp)
        sw      a3, 48(sp)
        sw      a4, 44(sp)
        sw      a5, 40(sp)
        sw      a6, 36(sp)
        sw      a7, 32(sp)
        sw      t0, 28(sp)
        sw      t1, 24(sp)
        sw      t2, 20(sp)
        sw      t3, 16(sp)
        sw      t4, 12(sp)
        sw      t5, 8(sp)
        sw      t6, 4(sp)
        
	jal     ra, merge_sort 

	## caller register
	addi    sp, sp, 64  # 32 bits alignment
        lw      a0, -4(sp)
        lw      a1, -8(sp)
        lw      a2, -12(sp)
        lw      a3, -16(sp)
        lw      a4, -20(sp)
        lw      a5, -24(sp)
        lw      a6, -28(sp)
        lw      a7, -32(sp)
        lw      t0, -36(sp)
        lw      t1, -40(sp)
        lw      t2, -44(sp)
        lw      t3, -48(sp)
        lw      t4, -52(sp)
        lw      t5, -56(sp)
        lw      t6, -60(sp)


	# merge_sort(arg, mid + 1, end);
	mv	a1, t1
	addi	a1, a1, 1
	mv	a2, s3 	
	## caller register
	addi    sp, sp, -64  # 32 bits alignment
        sw      a0, 60(sp)
        sw      a1, 56(sp)
        sw      a2, 52(sp)
        sw      a3, 48(sp)
        sw      a4, 44(sp)
        sw      a5, 40(sp)
        sw      a6, 36(sp)
        sw      a7, 32(sp)
        sw      t0, 28(sp)
        sw      t1, 24(sp)
        sw      t2, 20(sp)
        sw      t3, 16(sp)
        sw      t4, 12(sp)
        sw      t5, 8(sp)
        sw      t6, 4(sp)
        
	jal     ra, merge_sort 

	## caller register
	addi    sp, sp, 64  # 32 bits alignment
        lw      a0, -4(sp)
        lw      a1, -8(sp)
        lw      a2, -12(sp)
        lw      a3, -16(sp)
        lw      a4, -20(sp)
        lw      a5, -24(sp)
        lw      a6, -28(sp)
        lw      a7, -32(sp)
        lw      t0, -36(sp)
        lw      t1, -40(sp)
        lw      t2, -44(sp)
        lw      t3, -48(sp)
        lw      t4, -52(sp)
        lw      t5, -56(sp)
        lw      t6, -60(sp)


	# merge(arg, start, mid, end);
	mv	a1, s2
	mv	a2, t1
	mv	a3, s3 	
	## caller register
	addi    sp, sp, -64  # 32 bits alignment
        sw      a0, 60(sp)
        sw      a1, 56(sp)
        sw      a2, 52(sp)
        sw      a3, 48(sp)
        sw      a4, 44(sp)
        sw      a5, 40(sp)
        sw      a6, 36(sp)
        sw      a7, 32(sp)
        sw      t0, 28(sp)
        sw      t1, 24(sp)
        sw      t2, 20(sp)
        sw      t3, 16(sp)
        sw      t4, 12(sp)
        sw      t5, 8(sp)
        sw      t6, 4(sp)
        
	jal     ra, merge

	## caller register
	addi    sp, sp, 64  # 32 bits alignment
        lw      a0, -4(sp)
        lw      a1, -8(sp)
        lw      a2, -12(sp)
        lw      a3, -16(sp)
        lw      a4, -20(sp)
        lw      a5, -24(sp)
        lw      a6, -28(sp)
        lw      a7, -32(sp)
        lw      t0, -36(sp)
        lw      t1, -40(sp)
        lw      t2, -44(sp)
        lw      t3, -48(sp)
        lw      t4, -52(sp)
        lw      t5, -56(sp)
        lw      t6, -60(sp)

merge_sort_out:
	# exit func
	mv	sp, s0 
	lw	ra, -4(sp)
	lw	s0, -8(sp)
	lw	s1, -12(sp)
	lw	s2, -16(sp)
	lw	s3, -20(sp)
	lw	s4, -24(sp)
	lw	s5, -28(sp)
	lw	s6, -32(sp)
	lw	s7, -36(sp)
	lw	s8, -40(sp)
	lw	s9, -44(sp)
	lw	s10, -48(sp)
	lw	s11, -52(sp)
	jalr	x0, ra, 0

# a0: char *arg
# a1: int start
# a2: int mid
# a3: int end
merge:
	# entry func
	addi    sp, sp, -64  # 32 bits alignment
        sw      ra, 60(sp)
        sw      s0, 56(sp)
        sw      s1, 52(sp)
        sw      s2, 48(sp)
        sw      s3, 44(sp)
        sw      s4, 40(sp)
        sw      s5, 36(sp)
        sw      s6, 32(sp)
        sw      s7, 28(sp)
        sw      s8, 24(sp)
        sw      s9, 20(sp)
        sw      s10, 16(sp)
        sw      s11, 12(sp)
	addi	s0, sp, 64

merge_out:
	# exit func
	mv	sp, s0 
	lw	ra, -4(sp)
	lw	s0, -8(sp)
	lw	s1, -12(sp)
	lw	s2, -16(sp)
	lw	s3, -20(sp)
	lw	s4, -24(sp)
	lw	s5, -28(sp)
	lw	s6, -32(sp)
	lw	s7, -36(sp)
	lw	s8, -40(sp)
	lw	s9, -44(sp)
	lw	s10, -48(sp)
	lw	s11, -52(sp)
	jalr	x0, ra, 0
