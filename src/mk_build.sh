#!/bin/env bash

usage="Usage: \
    \n\tbash $0 [options]\
    \nOptions: \
    \n\t-d Debug: on\
    \n\t-c make clean \
    \n\t-l make log and generatee compiledb \
    \n\t-h help: \
    \nExample: \
    \n\t bash $0 -d
    "
usage() {
    echo -e "$usage" >&2
    exit 1
}

flag=no
log=''
compiledb=''
cl=''

while getopts cdhl opt
do
    case "$opt" in
        h)
            usage
            ;;
        d)
            flag=yes
            ;;
        c)
            # mingw32-make clean
            cl='yes'
            ;;
        l)
            log='| tee make_output.txt'
            compiledb='compiledb --parse make_output.txt'
            ;;
        \?)
            usage
            ;;
    esac
done

# mk="mingw32-make -f Make_ming.mak GUI=yes OLE=yes DIRECTX=yes VIMDLL=yes FEATURES=HUGE IME=yes ICONV=yes DEBUG=$flag SODIUM=yes POSTSCRIPT=yes TERMINAL=yes TERMGUICOLORS=yes VTP=yes STATIC_STDCPLUS=yes BALLOON_EVAL_TERM=yes PYTHON3=/ucrt64 PYTHON3_HOME=/ucrt64 PYTHON3INC=-I/ucrt64/include/python3.12 DYNAMIC_PYTHON3=yes PYTHON3_VER=312 DYNAMIC_PYTHON3_DLL=libpython3.12.dll LUA=/ucrt64 DYNAMIC_LUA=yes LUA_VER=54 RUBY=/ucrt64 DYNAMIC_RUBY=yes RUBY_VER=34 RUBY_API_VER_LONG=3.4.0 WINVER=0x601 PERL=/ucrt64 DYNAMIC_PERL=yes PERL_VER=538 VIMRUNTIMEDIR=/ucrt64/share/vim/vim91 VIMRCLOC=/ucrt64/share/vim TCL=/ucrt64 DYNAMIC_TCL=yes TCL_VER=86 TCL_VER_LONG=8.6.13 $log"
mk="mingw32-make -f Make_ming.mak GUI=yes OLE=yes DIRECTX=yes VIMDLL=yes FEATURES=HUGE IME=yes ICONV=yes DEBUG=$flag SODIUM=yes POSTSCRIPT=yes TERMINAL=yes TERMGUICOLORS=yes VTP=yes STATIC_STDCPLUS=yes BALLOON_EVAL_TERM=yes PYTHON3=/ucrt64 PYTHON3_HOME=/ucrt64 PYTHON3INC=-I/ucrt64/include/python3.14 DYNAMIC_PYTHON3=yes PYTHON3_VER=314 DYNAMIC_PYTHON3_DLL=libpython3.14.dll LUA=/ucrt64 DYNAMIC_LUA=yes LUA_VER=54 WINVER=0x601 PERL=C:/msys64/ucrt64 DYNAMIC_PERL=yes PERL_VER=538 VIMRUNTIMEDIR=/ucrt64/share/vim/vim91 VIMRCLOC=/ucrt64/share/vim TCL=/ucrt64 DYNAMIC_TCL=yes TCL_VER=86 TCL_VER_LONG=8.6.13 \
RUBY=/ucrt64 DYNAMIC_RUBY=yes RUBY_VER=40 RUBY_API_VER_LONG=4.0.0 WINVER=0x601 "
# MZSCHEME="/c/Users/Administrator/scoop/apps/racket-bc/current" DYNAMIC_MZSCHEME=yes MZSCHEME_VER=3m_dif58g"

if [ -n "$cl" ]; then
    clm="${mk} clean"
    eval "$clm"
fi
mkc="${mk} $log"
eval "$mkc"
if [ -n "$compiledb" ]; then
    eval "$compiledb"
fi
# [ "$#" -ne 1 ] && echo "参数数量需要1个！" && exit 1
# if [ "$flag" == "yes" ]; then
# mingw32-make -f Make_ming.mak VERBOSE="$verbose" GUI=yes OLE=yes DIRECTX=yes VIMDLL=yes FEATURES=HUGE IME=yes ICONV=yes DEBUG="$flag" SODIUM=yes POSTSCRIPT=yes TERMINAL=yes TERMGUICOLORS=yes VTP=yes STATIC_STDCPLUS=yes BALLOON_EVAL_TERM=yes PYTHON3=/ucrt64 PYTHON3_HOME=/ucrt64 PYTHON3INC=-I/ucrt64/include/python3.12 DYNAMIC_PYTHON3=yes PYTHON3_VER=312 DYNAMIC_PYTHON3_DLL=libpython3.12.dll LUA=/ucrt64 DYNAMIC_LUA=yes LUA_VER=54 RUBY=/ucrt64 DYNAMIC_RUBY=yes RUBY_VER=34 RUBY_API_VER_LONG=3.4.0 WINVER=0x601 PERL=/ucrt64 DYNAMIC_PERL=yes PERL_VER=538 VIMRUNTIMEDIR=/ucrt64/share/vim/vim91 VIMRCLOC=/ucrt64/share/vim TCL=/ucrt64 DYNAMIC_TCL=yes TCL_VER=86 TCL_VER_LONG=8.6.13
# elif [[ "$flag" == "no" ]]; then
# mingw32-make -f Make_ming.mak GUI=yes OLE=yes DIRECTX=yes VIMDLL=yes FEATURES=HUGE IME=yes ICONV=yes DEBUG="$flag" SODIUM=yes POSTSCRIPT=yes TERMINAL=yes TERMGUICOLORS=yes VTP=yes STATIC_STDCPLUS=yes BALLOON_EVAL_TERM=yes PYTHON3=/ucrt64 PYTHON3_HOME=/ucrt64 PYTHON3INC=-I/ucrt64/include/python3.12 DYNAMIC_PYTHON3=yes PYTHON3_VER=312 DYNAMIC_PYTHON3_DLL=libpython3.12.dll LUA=/ucrt64 DYNAMIC_LUA=yes LUA_VER=54 RUBY=/ucrt64 DYNAMIC_RUBY=yes RUBY_VER=34 RUBY_API_VER_LONG=3.4.0 WINVER=0x601 PERL=/ucrt64 DYNAMIC_PERL=yes PERL_VER=538 VIMRUNTIMEDIR=/ucrt64/share/vim/vim91 VIMRCLOC=/ucrt64/share/vim TCL=/ucrt64 DYNAMIC_TCL=yes TCL_VER=86 TCL_VER_LONG=8.6.13
# fi
#mingw32-make -f Make_ming.mak GUI=yes OLE=yes DIRECTX=yes VIMDLL=yes FEATURES=HUGE IME=yes ICONV=yes DEBUG=yes SODIUM=yes POSTSCRIPT=yes TERMINAL=yes TERMGUICOLORS=yes VTP=yes STATIC_STDCPLUS=yes BALLOON_EVAL_TERM=yes PYTHON3=/ucrt64 PYTHON3_HOME=/ucrt64 PYTHON3INC=-I/ucrt64/include/python3.12 DYNAMIC_PYTHON3=yes PYTHON3_VER=312 DYNAMIC_PYTHON3_DLL=libpython3.12.dll LUA=/ucrt64 DYNAMIC_LUA=yes LUA_VER=54 RUBY=/ucrt64 DYNAMIC_RUBY=yes RUBY_VER=34 RUBY_API_VER_LONG=3.4.0 WINVER=0x601 PERL=/ucrt64 DYNAMIC_PERL=yes PERL_VER=538 VIMRUNTIMEDIR=/ucrt64/share/vim/vim91 VIMRCLOC=/ucrt64/share/vim MZSCHEME=/c/Users/Administrator/scoop/apps/racket-bc/current DYNAMIC_MZSCHEME=yes MZSCHEME_VER=3m_dh8a0w TCL=/ucrt64 DYNAMIC_TCL=yes TCL_VER=86 TCL_VER_LONG=8.6.13
