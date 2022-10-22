	.file	"my-program.c"	# Имя файла, который компилировался.
	.intel_syntax noprefix	# Использование синтаксиса Intel.
	.text	# Начало секции.
	.globl	fillOutputArray	# Объявляем и делаем символ глобальным.
	.type	fillOutputArray, @function # Описываем тип объекта - функция.
fillOutputArray:	# Метка для функции заполнения выходного массива.
	endbr64 # Защита от атак на программу, за счет указывания, что сюда происходит переход из другой ветки.
	push	rbp	# Сохранили предыдущий rbp на стек.
	mov	rbp, rsp	# Вместо rbp записываем  rsp.
	mov	r11, rdi # r11 := rdi - это первый аргумент `input[]` записывается в стек с выделением 8 байт памяти.
	mov	r12, rsi # r12 := rsi - это второй аргумент `output[]` записывается в стек с выделением 8 байт памяти.
	mov	r13d, edx	# r13d := edx - это третий аргумент `length` записывается в стек с выделением 4 байт памяти.
	mov	r14d, 0 	# r14d := 0 - это локальная переменная `result` записывается в стек с выделением 4 байт памяти.
	mov	r15d, 0	# r15d := 0 - это локальная переменная `i` записывается в стек с выделением 4 байт памяти.
	jmp	.L2	 # Переход к метке .L2.
.L5:
	mov	eax, r13d	# eax := r13d, записываем в eax значение `length`.
        sub     eax, 1  # Вычитаем из eax единицу.
	cmp	r15d, eax	# Сравнить r15d и eax, то есть `i` и eax.
	jge	.L3	# Если r15d больше или равен eax, то переходим к метке .L3.
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	lea	rdx, 0[0+rax*4] # rdx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	edx, DWORD PTR [r11 + rdx]	# edx := input[r11 + rdx], записываем в edx элемент массива `input[]` по адресу r11 + rdx.
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	add	rax, 1	# Прибавляем к rax единицу.
	lea	rcx, 0[0+rax*4]	# rcx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	eax, DWORD PTR [r11 + rcx]	# eax := input[r11 + rcx], записываем в eax элемент массива `input[]` по адресу r11 + rcx.
	cmp	edx, eax	# Сравнить edx и eax.
	jg	.L3	# Если edx больше eax, то переходим к метке .L3.
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	lea	rdx, 0[0+rax*4]	#rdx, 0[0+rax*4] # rdx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	rax, r11	# rax := r11, записываем в rax указатель на начало массива.
	add	rax, rdx	# Прибавляем к началу массива вычисленный адрес в rdx.
	mov	edx, r14d	# edx := r14d, записываем в edx значение `result`.
	movsx	rdx, edx 	# rdx := edx, перемещаем edx в rdx со знаковым расширением.
	lea	rcx, 0[0+rdx*4]	# rcx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	rdx, r12	# rdx = r12, записываем в rdx указатель на начало массива.
	add	rdx, rcx	# Прибавляем к началу массива вычисленный адрес в rcx.
	mov	eax, DWORD PTR [rax]	# eax := input[rax], записываем в eax элемент массива `input[]` по адресу rax.
	mov	DWORD PTR [rdx], eax	# output[rdx] := eax, записываем eax в массив `output[]` по адресу rdx.
	add	r14d, 1	# Прибавляем к r14d, то есть к `result`, единицу.
	jmp	.L4	# Переход к метке .L4.
.L3:
	cmp	r15d, 0	# Сравнить r15d, то есть `i`, с нулем.
	jle	.L4 	# Если r15d меньше или равно 0, то переходим к метке .L4.
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	sal	rax, 2	# Левый сдвиг в rax.
	lea	rdx, -4[rax] 	# rdx := rax[-4].
	mov	edx, DWORD PTR [r11 + rdx]	# edx := input[r11 + rdx], записываем в edx элемент массива `input[]` по адресу r11 + rdx.
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	lea	rcx, 0[0+rax*4]	# rcx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	eax, DWORD PTR [r11 + rcx]	# eax := input[r11 + rcx], записываем в eax элемент массива `input[]` по адресу r11 + rcx.
	cmp	edx, eax	# Сравнить edx и eax.
	jg	.L4	# Если edx больше eax, то переходим к метке .L4.
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	lea	rdx, 0[0+rax*4]	# rdx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	rax, r11	# rax := r11, записываем в rax указатель на начало массива.
	add	rax, rdx	# Прибавляем к началу массива вычисленный адрес в rdx.
	mov	edx, r14d	# eax := r14d, записываем в eax значение `result`.
	movsx	rdx, edx	# rdx := edx, перемещаем edx в rdx со знаковым расширением.
	lea	rcx, 0[0+rdx*4]	# rcx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	rdx, r12	# rdx = r12, записываем в rdx указатель на начало массива.
	add	rdx, rcx	# Прибавляем к началу массива вычисленный адрес в rcx.
	mov	eax, DWORD PTR [rax]	# eax := input[rax], записываем в eax элемент массива `input[]` по адресу rax.
	mov	DWORD PTR [rdx], eax	# output[rdx] := eax, записываем eax в массив `output[]` по адресу rdx.
	add	r14d, 1	# Прибавляем к r14d, то есть к `result`, единицу.
.L4:
	add	r15d, 1	# Прибавляем к r15d, то есть к `i`, единицу.
.L2:
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cmp	eax, r13d # Сравнить eax и r13d, то есть eax и `length`.
	jl	.L5	# Если eax меньше r13d, то переходим к метке .L5.
	mov	eax, r14d	# eax := r14d, записываем в eax значение `result`.
	pop	rbp # Перевод rbp перед выходом из функции.
	ret	# Возврат из функции.
	.size	fillOutputArray, .-fillOutputArray	# Размер для данного символа.
	.section	.rodata 	# Секция ReadOnly полей.
.LC0:
	.string	"array[%d] = %d\n"	# Строка
	.text	# Начало секции 
	.globl	printArray	# Объявляем и делаем символ глобальным.
	.type	printArray, @function	# Описываем тип объекта - функция.
printArray:	# Метка для функции вывода выходного массива.
	endbr64	# Защита от атак на программу, за счет указывания, что сюда происходит переход из другой ветки.
	push	rbp	# Сохранили предыдущий rbp на стек.
	mov	rbp, rsp	# Вместо rbp записываем  rsp.
	sub	rsp, 32	# Выделение дополнительного места в стеке.
	mov	r13, rdi	# r13 := rdi - это первый аргумент `output[]` записывается в стек с выделением 8 байт памяти.
	mov	r14d, esi # r14d := esi - это второй аргумент `counter` записывается в стек с выделением 4 байт памяти.
	mov	r15d, 0	# r15d := 0 - это локальная переменная `i` записывается в стек с выделением 4 байт памяти.
	jmp	.L8	# Переходим к метке .L8.
.L9:
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	lea	rdx, 0[0+rax*4]	#rdx, 0[0+rax*4] # rdx:= rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	mov	edx, DWORD PTR [r13 + rdx]	# edx := output[r13 + rdx], записываем в edx элемент массива `output[]` по адресу r13 + rdx.
	mov	esi, r15d	# esi := r15d.
	lea	rax, .LC0[rip]	# rax := rip[.LC0] - наша строчка "%d".
	mov	rdi, rax	# rdi := rax.
	mov	eax, 0	# eax := 0.
	call	printf@PLT	# вызов printf.
	add	r15d, 1	# Прибавляем к r15d, то есть к `i`, единицу.
.L8:
	mov	eax, r15d	# eax := r15d, записываем в eax значение `i`.
	cmp	eax, r14d	# Сравнить eax и r14d, то есть `counter`.
	jl	.L9	# Если eax меньше r14d, то переходим к метке .L9.
	nop	# Без операций
	nop	# Без операций
	leave # Подготовка стека к возврату из функции.
	ret	# Возврат из функции.
	.size	printArray, .-printArray	# Размер для данного символа.
	.section	.rodata # Секция ReadOnly полей.
	.align 8	#  Гарантируем место в памяти.
.LC1:
	.string	"Input length (0 < length <= %d): "	# Строка для ввода длины.
.LC2:
	.string	"%d"	# Строка форматирования.
.LC3:
	.string	"Incorrect length = %d\n"	# Строка неверного ввода.
.LC4:
	.string	"array[%d]? "	# Строка обозначения элемента массива.
	.text	# Начало секции.
	.globl	main	# Объявляем и делаем символ глобальным.
	.type	main, @function	# Описываем тип объекта - функция.
main:	# Метка для главной функции программы.
	endbr64 # Защита от атак на программу, за счет указывания, что сюда происходит переход из другой ветки.
	push	rbp	# Сохранили предыдущий rbp на стек.
	mov	rbp, rsp	# Вместо rbp записываем  rsp.
	lea	r11, -77824[rsp]	# r11 := rsp[-77824].
.LPSRL0:
	sub	rsp, 4096	# Вычитаем из rsp 4096.
	or	DWORD PTR [rsp], 0 # Результат должен быть 0.
	cmp	rsp, r11	# Сравнить rsp и r11.
	jne	.LPSRL0	# Если встречается условие, перейти по метке.
	sub	rsp, 2208	# Вычитаем из rsp 2208.
	mov	esi, 10000	# esi := 10000.
	lea	rax, .LC1[rip]	# rax := rip[.LC1] - наша строчка "%d".
	mov	rdi, rax	# rdi := rax.
	mov	eax, 0	# eax := 0.
	call	printf@PLT	# Вызов printf.
	lea	rax, -80020[rbp] # rax := rbp[-80020], то есть в rax кладется значение `length`.
	mov	rsi, rax	# rsi := rax.
	lea	rax, .LC2[rip]	# rax := rip[.LC2] - наша строчка "%d".
	mov	rdi, rax	# rdi := rax.
	mov	eax, 0	# eax := 0.
	call	__isoc99_scanf@PLT	# Вызов scanf.
	mov	eax, DWORD PTR -80020[rbp]	# eax := rbp[-80020], то есть в eax кладется значение `length`.
	test	eax, eax	# Сравнить eax с 0.
	jle	.L11	# Если eax меньше или равен, то переходим к метке .L11.
	mov	eax, DWORD PTR -80020[rbp]	# eax := rbp[-80020], то есть в eax кладется значение `length`.
	cmp	eax, 10000	# Сравнить eax с 10000.
	jle	.L12	# Если eax меньше или равен 10000, то переходим к метке .L12.
.L11:
	mov	eax, DWORD PTR -80020[rbp]	# eax := rbp[-80020], то есть в eax кладется значение `length`.
	mov	esi, eax	# esi := eax.
	lea	rax, .LC3[rip]	# rax := rip[.LC3] - наша строчка "%d".
	mov	rdi, rax	# rdi := rax.
	mov	eax, 0	# eax := 0.
	call	printf@PLT	# Вызов printf.
	mov	eax, 1 # eax := 1.
	jmp	.L16	# Переходим к метке .L16.
.L12:
	mov	DWORD PTR -4[rbp], 0	# rbp[-4] := 0.
	jmp	.L14	# Переходим к метке .L14.
.L15:
	mov	esi, DWORD PTR -4[rbp]	# esi := eax.
	lea	rax, .LC4[rip]	# rax := rip[.LC4] - наша строчка "%d".
	mov	rdi, rax	# rdi := rax.
	mov	eax, 0	# eax := 0.
	call	printf@PLT	# Вызов printf.
	mov	eax, DWORD PTR -4[rbp]	# eax := rbp[-4], записываем в eax значение `i`.
	cdqe	# Конвертация DoubleWord в Qwadword, из eax получили rax, совершается для добавление знаковых битов.
	lea	rdx, 0[0+rax*4]	# rdx := rax*4. Вычисляет адрес (rax*4)[0], который равен rax*4.
	lea	rax, -40016[rbp]	# rax := rbp[-40016], записываем в rax указатель на начало массива `input[]`.
	add	rax, rdx # Прибавляем к rax адрес вычисленный в rdx.
	mov	rsi, rax	# rsi := rax.
	lea	rax, .LC2[rip]	# rax := rip[.LC2] - наша строчка "%d".
	mov	rdi, rax	# rdi := rax.
	mov	eax, 0	# eax := 0.
	call	__isoc99_scanf@PLT	# Вызов scanf.
	add	DWORD PTR -4[rbp], 1 # Прибавляем к rbp[-4], то есть к `i`, единицу.
.L14:
	mov	eax, DWORD PTR -80020[rbp]	# eax := rbp[-80020], то есть в eax кладется значение `length`.
	cmp	DWORD PTR -4[rbp], eax # Сравнить rbp[-4] и eax.
	jl	.L15	# Если rbp[-4] меньше eax, то переходим к метке .L15.
	mov	edx, DWORD PTR -80020[rbp]	# edx := rbp[-80020], то есть в edx кладется значение `length`.
	lea	rcx, -80016[rbp]	# rcx := rbp[-80016], записываем в rcx указатель на начало массива `output[]`.
	lea	rax, -40016[rbp]	# rax := rbp[-40016], записываем в rax указатель на начало массива `input[]`.
	mov	rsi, rcx	# rsi := rcx.
	mov	rdi, rax	# rdi := rax.
	call	fillOutputArray	# Вызов функции заполнения выходного массива.
	mov	DWORD PTR -80020[rbp], eax	# rbp[-80020] := eax, то есть в `length` кладется значение eax.
	mov	edx, DWORD PTR -80020[rbp]	# edx := rbp[-80020], то есть в edx кладется значение `length`.
	lea	rax, -80016[rbp]	# rax := rbp[-80016], записываем в rax указатель на начало массива `output[]`.
	mov	esi, edx	# esi := edx.
	mov	rdi, rax	# rdi := rax.
	call	printArray	# Вызов функции печати массива.
	mov	eax, 0	# eax := 0.
.L16:
	leave	# Подготовка стека к возврату из функции.
	ret	# Возврат из функции.
