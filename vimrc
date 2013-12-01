execute pathogen#infect()

set nocompatible
set shell=/bin/sh

let g:solarized_termtrans = 1
colorscheme solarized

let mapleader = " "

syntax on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
filetype plugin indent on

set number

" from: http://robots.thoughtbot.com/faster-grepping-in-vim/
  " The Silver Searcher
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  endif

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" run ctags to take advantage of this: ctags -R .
nnoremap <leader>. :CtrlPTag<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" smart case insensitive searching
set ignorecase
set smartcase
set hlsearch

" from thoughtbot
  " Treat <li> and <p> tags like the block tags they are
  let g:html_indent_tags = 'li\|p'

  " Open new split panes to right and bottom, which feels more natural
  set splitbelow
  set splitright

  " Quicker window movement
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l

  " configure syntastic syntax checking to check on open as well as save
  let g:syntastic_check_on_open=1

  " Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
  let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

  " Index ctags from any project, including those outside Rails
  map <Leader>ct :!ctags -R .<CR>

  " Switch between the last two files
  nnoremap <leader><leader> <c-^>
