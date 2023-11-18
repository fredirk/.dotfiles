" vimrc intro :help vimrc-intro
" :help <cmd> to view reference manual, e.g. :help autocmd

source $VIMRUNTIME/defaults.vim

" curl https://raw.githubusercontent.com/AlessandroYorba/Alduin/master/colors/alduin.vim -o $HOME/.vim/colors
colorscheme alduin

call plug#begin()
call plug#end()

" netrw
call netrw_gitignore#Hide()
let g:netrw_liststyle = 3

" sets
"" lines
set number
set relativenumber
set scrolloff=5
"" searching
set hlsearch
set incsearch

" filetype detection
filetype on
filetype plugin on
filetype indent on
autocmd FileType c,cpp,java,cs set formatoptions+=ro
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Keymap
"" General
nnoremap <silent> <C-l> :nohlsearch<CR>
vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap <silent> J :m '>+1<CR>gv=gv
"" Explorer
nnoremap <silent> <Leader>ee :Explore<CR>
nnoremap <silent> <Leader>e<Tab> :Texplore<CR>
"" Tabs
nnoremap <silent> <Tab><Tab> :tabnew<CR>
nnoremap <silent> <Tab>e :Texplore<CR>
nnoremap <silent> <Tab>q :q<CR>
nnoremap <silent> <Tab>0 :tabonly<CR>
nnoremap <silent> <Tab>h gT
nnoremap <silent> <Tab>l gt
nnoremap <silent> <Tab>j :tabfirst<CR>
nnoremap <silent> <Tab>k :tablast<CR>
nnoremap <silent> <Tab>s :tab split<CR>
nnoremap <Tab>/ :tabfind<space>
"" Git
nnoremap <Leader>g :call RunTigAndRedraw()<CR>

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

