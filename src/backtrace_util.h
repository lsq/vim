// backtrace_util.h
#ifndef BACKTRACE_UTIL_H
#define BACKTRACE_UTIL_H

// #ifdef DEBUG
int print_frame(void *data, uintptr_t pc, const char *filename, int lineno, const char *function);
void dump_backtrace(void);
// #endif

#endif
