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

function! UpdateTmuxWindowTitle()
  let l:filename = expand('%:t')
  if l:filename != ''
    let l:tmux_cmd = 'tmux rename-window ' . shellescape(l:filename)
    call system(l:tmux_cmd)
  endif
endfunction

function! ResetTmuxWindowTitle()
  let l:tmux_cmd = 'tmux setw -q automatic-rename on'
  call system(l:tmux_cmd)
endfunction

augroup TmuxWindowName
  autocmd!
  autocmd BufReadPost * call UpdateTmuxWindowTitle()
  autocmd VimLeave * call ResetTmuxWindowTitle()
augroup END

function! RunTigAndRedraw()
    silent !tig
    redraw!
endfunction

nnoremap <Space>g :call RunTigAndRedraw()<CR>
