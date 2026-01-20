#include <ctrace/ctrace.h>
#include <assert.h>
#include <limits.h>
#include <stdio.h>

void dump_stack_to_stderr(void) {
    ctrace_raw_trace raw_trace = ctrace_generate_raw_trace(1, INT_MAX);
    ctrace_object_trace obj_trace = ctrace_resolve_raw_trace_to_object_trace(&raw_trace);
    ctrace_stacktrace trace = ctrace_resolve_object_trace(&obj_trace);
    ctrace_print_stacktrace(&trace, stderr, 1);
    ctrace_free_stacktrace(&trace);
    ctrace_free_object_trace(&obj_trace);
    ctrace_free_raw_trace(&raw_trace);
    assert(raw_trace.frames == NULL && obj_trace.count == 0);
}
