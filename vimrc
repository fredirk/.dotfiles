" vimrc intro :help vimrc-intro
" :help <cmd> to view reference manual, e.g. :help autocmd

source $VIMRUNTIME/defaults.vim

" https://github.com/AlessandroYorba/Alduin/
colorscheme alduin

" plugin
" https://github.com/junegunn/vim-plug
call plug#begin()
"" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
call plug#end()

" netrw
call netrw_gitignore#Hide()
let g:netrw_liststyle = 3

" sets
"" General
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
"" lines
set number
set relativenumber
set scrolloff=5
"" searching
set hlsearch
set incsearch
"" statusline
set laststatus=2
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" filetype detection
filetype on
filetype plugin on
filetype indent on

" autocmd
"" file type
autocmd FileType c,cpp,java,cs set formatoptions+=ro
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm
autocmd FileType yaml,yml set fdm=indent
"" tmux
augroup TmuxWindowName
  autocmd!
  autocmd BufReadPost * call UpdateTmuxWindowTitle()
  autocmd TabEnter * call UpdateTmuxWindowTitle()
  autocmd VimLeave * call ResetTmuxWindowTitle()
augroup END

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
nnoremap <Tab>f :tabnew<CR>:Files<CR>
"" Git
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Git diff<CR>
nnoremap <Leader>gt :call RunTigAndRedraw()<CR>
"" Shell
nnoremap <Leader>$p :call PutShell()<CR>
"" Fuzzy
nnoremap <Leader>/ :Lines<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>fgs :GFiles?<CR>

" Functions
"" Shell
function PutShell()
    let l:sys = split(system(input("$: ")), "\n")
    call append(line('.'), l:sys)
endfunction
"" Tmux
function UpdateTmuxWindowTitle()
  let l:filename = expand('%:t')
  if l:filename != ''
    let l:tmux_cmd = 'tmux rename-window ' . shellescape(l:filename)
    call system(l:tmux_cmd)
  endif
endfunction
function ResetTmuxWindowTitle()
  let l:tmux_cmd = 'tmux setw -q automatic-rename on'
  call system(l:tmux_cmd)
endfunction
"" Tig
function RunTigAndRedraw()
    silent !tig
    redraw!
endfunction
