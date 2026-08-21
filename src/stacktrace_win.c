#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <dbghelp.h>
#include <stdio.h>
/*
// 避免重复初始化
static BOOL g_symbols_initialized = FALSE;

void dump_stack_to_stderr(void) {
    HANDLE process = GetCurrentProcess();
    HANDLE thread = GetCurrentThread();

    if (!g_symbols_initialized) {
        SymSetOptions(SYMOPT_DEFERRED_LOADS | SYMOPT_UNDNAME);
        SymInitialize(process, NULL, TRUE);
        g_symbols_initialized = TRUE;
    }

    CONTEXT context;
    RtlCaptureContext(&context);

    STACKFRAME64 frame = {0};
    frame.AddrPC.Mode = AddrModeFlat;
    frame.AddrFrame.Mode = AddrModeFlat;
    frame.AddrStack.Mode = AddrModeFlat;

#ifdef _M_X64
    frame.AddrPC.Offset = context.Rip;
    frame.AddrFrame.Offset = context.Rbp;
    frame.AddrStack.Offset = context.Rsp;
#else
    frame.AddrPC.Offset = context.Eip;
    frame.AddrFrame.Offset = context.Ebp;
    frame.AddrStack.Offset = context.Esp;
#endif

    fprintf(stderr, "=== Stack Trace ===\n");
    for (int i = 0; i < 50; i++) {
        if (!StackWalk64(
            IMAGE_FILE_MACHINE_AMD64,
            process, thread,
            &frame, &context, NULL,
            SymFunctionTableAccess64,
            SymGetModuleBase64,
            NULL
        )) break;

        DWORD64 addr = frame.AddrPC.Offset;
        char buffer[sizeof(SYMBOL_INFO) + MAX_SYM_NAME * sizeof(TCHAR)];
        PSYMBOL_INFO symbol = (PSYMBOL_INFO)buffer;
        symbol->SizeOfStruct = sizeof(SYMBOL_INFO);
        symbol->MaxNameLen = MAX_SYM_NAME;

        if (SymFromAddr(process, addr, NULL, symbol)) {
            fprintf(stderr, "%s\n", symbol->Name);
        } else {
            fprintf(stderr, "0x%llx\n", addr);
        }
    }
    fprintf(stderr, "====================\n");
}
*/

void dump_stack_to_stderr(void) {
    HANDLE process = GetCurrentProcess();
    SymInitialize(process, NULL, TRUE);

    void *stack[64];
    USHORT frames = CaptureStackBackTrace(0, 64, stack, NULL);

    fprintf(stderr, "=== Stack Trace ===\n");
    for (USHORT i = 0; i < frames; i++) {
        DWORD64 addr = (DWORD64)(ULONG_PTR)stack[i];
        char buffer[sizeof(SYMBOL_INFO) + MAX_SYM_NAME * sizeof(TCHAR)] = {0};
        PSYMBOL_INFO symbol = (PSYMBOL_INFO)buffer;
        symbol->SizeOfStruct = sizeof(SYMBOL_INFO);
        symbol->MaxNameLen = MAX_SYM_NAME;

        if (SymFromAddr(process, addr, NULL, symbol)) {
            fprintf(stderr, "%s\n", symbol->Name);
        } else {
            fprintf(stderr, "0x%llx\n", addr);
        }
    }
    fprintf(stderr, "====================\n");

    SymCleanup(process);
}
