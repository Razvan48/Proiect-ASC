.data

	;//Variabile pentru ambele cerinte
	
	m1: .space 52900
	m: .space 460
	n: .space 4
	tipCerinta: .space 4
	index: .space 4
	index2: .space 4
	valoare: .space 4
	dimM: .space 4
	intregScanf: .asciz "%ld"
	intregPrintf: .asciz "%ld "
	intregPrintfNoSpace: .asciz "%ld"
	newLinePrintf: .asciz "\n"
	
	;//Variabile pentru cerinta 2
	
	m2: .space 52900
	mres: .space 52900
	lungimeDrum: .space 4
	nodSursa: .space 4
	nodDestinatie: .space 4

.text

initializareMatrice: ;//Initializeaza primele n * n pozitii cu valoarea data

	pushl %ebp
	movl %esp, %ebp
	
	pushl %edi
	movl 8(%ebp), %edi

	movl 12(%ebp), %ecx
	movl %ecx, %eax
	mull %ecx
	movl %eax, %ecx
	
	movl 16(%ebp), %edx
	
	initializareLoop:
	cmp $0, %ecx
	je endInitializareLoop
	
		decl %ecx
		movl %edx, (%edi, %ecx, 4)
	
	jmp initializareLoop
	
	endInitializareLoop:
	
	popl %edi
	
	popl %ebp
	ret

copiereMatrice: ;//Muta primii 4 * n * n bytes din matricea 2 in matricea 1.

	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	
	movl 16(%ebp), %ecx
	movl %ecx, %eax
	mull %ecx
	movl %eax, %ecx
	
	movl 12(%ebp), %esi
	movl 8(%ebp), %edi
	
	copiereLoop:
	cmp $0, %ecx
	je endCopiereLoop
	
		decl %ecx
	
		movl (%esi, %ecx, 4), %eax
		movl %eax, (%edi, %ecx, 4)
	
	jmp copiereLoop
	
	endCopiereLoop:
	
	popl %edi
	popl %esi
	
	popl %ebp
	ret
	
matriceIdentica:

	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	
	subl $8, %esp
	
	movl $0, -8(%ebp)
	movl $0, -12(%ebp)
		
	matriceIdenticaLoop:
	movl -8(%ebp), %ecx
	movl 12(%ebp), %edx
	cmp %ecx, %edx
	je endMatriceIdenticaLoop
		
		movl $0, -12(%ebp)
			
		matriceIdenticaLoop2:
		movl -12(%ebp), %ecx
		movl 12(%ebp), %edx
		cmp %ecx, %edx
		je endMatriceIdenticaLoop2
			
			movl -8(%ebp), %eax
			movl -12(%ebp), %edx
			
			cmp %eax, %edx
			je valoareaUnu
			
			movl 8(%ebp), %esi
			
			movl -8(%ebp), %eax
			movl 12(%ebp), %ecx
			mull %ecx
			addl -12(%ebp), %eax
			movl %eax, %ecx
			
			movl $0, (%esi, %ecx, 4)
			
			jmp endValoareaUnu
			
			valoareaUnu:
			
			movl 8(%ebp), %esi
			
			movl -8(%ebp), %eax
			movl 12(%ebp), %ecx
			mull %ecx
			addl -12(%ebp), %eax
			movl %eax, %ecx
			
			movl $1, (%esi, %ecx, 4)
			
			endValoareaUnu:
			
		addl $1, -12(%ebp)
		jmp matriceIdenticaLoop2
			
		endMatriceIdenticaLoop2:
		
	addl $1, -8(%ebp)
	jmp matriceIdenticaLoop
		
	endMatriceIdenticaLoop:
	
	addl $8, %esp
	
	popl %esi

	popl %ebp
	ret
	
matrix_mult:

	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	pushl %esi
	pushl %edi
	
	subl $24, %esp
	
	movl $0, -16(%ebp)
	movl $0, -20(%ebp)
	movl $0, -24(%ebp)
	
	movl $0, -28(%ebp)
	movl $0, -32(%ebp)
	movl $0, -36(%ebp)
	
	movl 20(%ebp), %ecx
	movl 16(%ebp), %eax
	pushl $0
	pushl %ecx
	pushl %eax
	call initializareMatrice
	popl %eax
	popl %eax
	popl %eax
	
	matrixMullLoop:
	movl -16(%ebp), %ecx
	movl 20(%ebp), %edx
	cmp %ecx, %edx
	je endMatrixMullLoop
	
		movl $0, -20(%ebp)
	
		matrixMullLoop2:
		movl -20(%ebp), %ecx
		movl 20(%ebp), %edx
		cmp %ecx, %edx
		je endMatrixMullLoop2
		
			movl $0, -24(%ebp)
		
			movl 20(%ebp), %eax
			movl -16(%ebp), %ecx
			mull %ecx
			movl %eax, -28(%ebp)
			
			movl -20(%ebp), %eax
			movl %eax, -32(%ebp)
		
			matrixMullLoop3:
			movl -24(%ebp), %ecx
			movl 20(%ebp), %edx
			cmp %ecx, %edx
			je endMatrixMullLoop3
			
				movl 8(%ebp), %esi
				movl -28(%ebp), %ecx
				movl (%esi, %ecx, 4), %eax
				movl 12(%ebp), %esi
				movl -32(%ebp), %ecx
				movl (%esi, %ecx, 4), %ebx
				mull %ebx
				movl 16(%ebp), %edi
				movl -36(%ebp), %ecx
				addl %eax, (%edi, %ecx, 4)
			
			addl $1, -28(%ebp)
			movl 20(%ebp), %eax
			addl %eax, -32(%ebp)
			
			addl $1, -24(%ebp)
			jmp matrixMullLoop3
			
			endMatrixMullLoop3:
		
		addl $1, -36(%ebp)
		
		addl $1, -20(%ebp)
		jmp matrixMullLoop2
		
		endMatrixMullLoop2:
	
	addl $1, -16(%ebp)
	jmp matrixMullLoop
	
	endMatrixMullLoop:
	
	addl $24, %esp
	
	popl %edi
	popl %esi
	popl %ebx

	popl %ebp
	ret
	
	

.globl main
main:

	pushl $tipCerinta
	pushl $intregScanf
	call scanf
	popl %eax
	popl %eax
	
	pushl $n
	pushl $intregScanf
	call scanf
	popl %eax
	popl %eax
	
	pushl $0
	pushl n
	pushl $m1
	call initializareMatrice
	popl %eax
	popl %eax
	popl %eax
	
	movl $0, index
	
	Mloop:
	movl index, %ecx
	cmp %ecx, n
	je endMloop
	
	pushl $valoare
	pushl $intregScanf
	call scanf
	popl %eax
	popl %eax
	
	movl valoare, %edx
	lea m, %edi
	movl index, %ecx
	movl %edx, (%edi, %ecx, 4)
	
	incl index
	jmp Mloop
	
	endMloop:
	
	movl $0, index
	
	matriceLoop: ;//In acest loop vom citi listele de adiacenta
	movl index, %ecx
	cmp %ecx, n
	je endMatriceLoop
	
	lea m, %esi
	movl (%esi, %ecx, 4), %edx
	movl %edx, dimM
	
		movl $0, index2
		
		matriceLoop2: ;//Loop pentru o singura lista de adiacenta
		movl index2, %ebx
		cmp %ebx, dimM
		je endMatriceLoop2
		
		pushl $valoare
		pushl $intregScanf
		call scanf
		popl %eax
		popl %eax
		
		lea m1, %edi
		movl n, %eax
		mull index
		addl valoare, %eax
		addl $1, (%edi, %eax, 4)
		
		incl index2
		jmp matriceLoop2
	
		endMatriceLoop2:
		
	incl index
	jmp matriceLoop
	
	endMatriceLoop:
	
	
	
	movl $1, %eax
	cmp tipCerinta, %eax
	jne endCerinta1
	
		movl $0, index
		
		afisareLoop:
		movl index, %ecx
		cmp %ecx, n
		je endAfisareLoop
		
			movl $0, index2
			
			afisareLoop2:
			movl index2, %ebx
			cmp %ebx, n
			je endAfisareLoop2
			
			lea m1, %esi
			movl n, %eax
			mull index
			addl index2, %eax
			movl (%esi, %eax, 4), %edx
			movl %edx, valoare
			
			pushl valoare
			pushl $intregPrintf
			call printf
			popl %eax
			popl %eax
			
			pushl $0
			call fflush
			popl %eax
			
			incl index2
			jmp afisareLoop2
			
			endAfisareLoop2:
			
		pushl $newLinePrintf
		call printf
		popl %eax
		
		pushl $0
		call fflush
		popl %eax
		
		incl index
		jmp afisareLoop
		
		endAfisareLoop:
	
	endCerinta1:
	
	movl $2, %eax
	cmp tipCerinta, %eax
	jne endCerinta2
		
		pushl $lungimeDrum
		pushl $intregScanf
		call scanf
		popl %eax
		popl %eax
		
		pushl $nodSursa
		pushl $intregScanf
		call scanf
		popl %eax
		popl %eax
		
		pushl $nodDestinatie
		pushl $intregScanf
		call scanf
		popl %eax
		popl %eax    
		
		pushl n
		pushl $m1
		pushl $m2
		call copiereMatrice
		popl %eax
		popl %eax
		popl %eax
		
		pushl n
		pushl $m1
		call matriceIdentica
		popl %eax
		popl %eax
		
		movl $0, index
		
		ridicarePutereLoop:
		movl index, %ecx
		cmp %ecx, lungimeDrum
		je endRidicarePutereLoop
		
			pushl n
			pushl $mres
			pushl $m2
			pushl $m1
			call matrix_mult
			popl %eax
			popl %eax
			popl %eax
			popl %eax
			
			pushl n
			pushl $mres
			pushl $m1
			call copiereMatrice
			popl %eax
			popl %eax
			popl %eax
		
		incl index
		jmp ridicarePutereLoop
		
		endRidicarePutereLoop:
		
		lea m1, %esi
		movl nodSursa, %eax
		mull n
		addl nodDestinatie, %eax
		movl %eax, %ecx
		movl (%esi, %ecx, 4), %edx
		
		pushl %edx
		pushl $intregPrintfNoSpace
		call printf
		popl %eax
		popl %eax
		
		pushl $0
		call fflush
		popl %eax
		
		pushl $newLinePrintf
		call printf
		popl %eax
		
		pushl $0
		call fflush
		popl %eax
	
	endCerinta2:

etExit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	

