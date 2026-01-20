// backtrace_util.c
/* #if defined (MSWIN) */
#include <stdio.h>
#include <windows.h>
#include <backtrace.h>
#include <backtrace-supported.h>
#include "backtrace_util.h"

static struct backtrace_state *g_state = NULL;
// 回调函数：每帧调用一次
int print_frame(void *data, uintptr_t pc, const char *filename, int lineno, const char *function) {
    if (function) {
        /* printf("%s(%d): %s\n", filename ? filename : "??", lineno, function); */
        fprintf(stderr, "[BT] %s(%d): %s\n", filename? filename: "??", lineno, function);
        fflush(stderr);
    }
    else {
        fprintf(stderr, "PC=0x%lx, function=%s\n", (unsigned long)pc, function ? function : "NULL");
        /* printf("0x%lx\n", (unsigned long)pc); */
    }

    return 0;
}

// 出错回调
void error_callback(void *data, const char *msg, int errnum) {
    /* fprintf(stderr, "Backtrace error: %s\n", msg); */
    fprintf(stderr, "[BT error] %s\n", msg);
    fflush(stderr);
}

void dump_backtrace(void) {
    /*
    */
    // 获取当前 DLL 路径
    HMODULE hMod = NULL;
    GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
                       (LPCSTR)&dump_backtrace, &hMod);
    uintptr_t runtime_base = (uintptr_t)hMod;
    fprintf(stderr, "[DEBUG] Runtime base: 0x%llx\n", (unsigned long long)runtime_base);
    char dll_path[MAX_PATH];
    GetModuleFileNameA(hMod, dll_path, MAX_PATH);

    // 用 DLL 路径创建 backtrace state
    /* fprintf(stderr, "[BT error] %s\n", dll_path); */
    /* fflush(stderr); */
    if (!g_state)
        g_state = backtrace_create_state(dll_path, 0, error_callback, NULL);
    /* if (state) { */
    backtrace_full(g_state, 0, print_frame, error_callback, NULL);
    /* } */
}
/* #endif */
