" vimrc intro :help vimrc-intro
" :help <cmd> to view reference manual, e.g. :help autocmd

source $VIMRUNTIME/defaults.vim

set number

" searching
set hlsearch
set incsearch

" filetype detection
filetype on
filetype plugin on
filetype indent on

" new line in comment, insert lead character
autocmd FileType c,cpp,java,cs set formatoptions+=ro
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

