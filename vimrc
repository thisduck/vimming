execute pathogen#infect()

set nocompatible

let g:solarized_termtrans = 1
colorscheme solarized

let mapleader = " "

syntax on
set hidden
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
filetype plugin indent on

set nobackup
set noswapfile
set number

" from: http://robots.thoughtbot.com/faster-grepping-in-vim/
  " The Silver Searcher
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ tmp\ --ignore\ log

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  endif

  " bind K to grep word under cursor
  nnoremap K :grep! "<C-R><C-W>"<CR>:cw<CR>
  nnoremap KK :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" run ctags to take advantage of this: ctags -R .
nnoremap <leader>. :CtrlPTag<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" smart case insensitive searching
set ignorecase
set smartcase
set hlsearch
nmap <silent> <Leader>/ :nohlsearch<CR>

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

  augroup vimrcEx
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Cucumber navigation commands
    autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
    autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile Appraisals set filetype=ruby
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " Enable spellchecking for Markdown
    autocmd FileType markdown setlocal spell

    " Automatically wrap at 80 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  augroup END

  " Tab completion
  " will insert tab at beginning of line,
  " will use completion if not at beginning
  set wildmode=list:longest,list:full
  set complete=.,w,t
  function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
          return "\<tab>"
      else
          return "\<c-p>"
      endif
  endfunction
  inoremap <Tab> <c-r>=InsertTabWrapper()<cr>



set shell=/bin/sh

" automatically open quickfix after grep
autocmd QuickFixCmdPost *grep* cwindow
set cursorline
set showcmd

" from gary b
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " RENAME CURRENT FILE
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! RenameFile()
      let old_name = expand('%')
      let new_name = input('New file name: ', expand('%'), 'file')
      if new_name != '' && new_name != old_name
          exec ':saveas ' . new_name
          exec ':silent !rm ' . old_name
          redraw!
      endif
  endfunction
  map <leader>n :call RenameFile()<cr>

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " PROMOTE VARIABLE TO RSPEC LET
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! PromoteToLet()
    :normal! dd
    " :exec '?^\s*it\>'
    :normal! P
    :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
    :normal ==
  endfunction
  :command! PromoteToLet :call PromoteToLet()
  :map <leader>p :PromoteToLet<cr>

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " FindConditionals COMMAND
  " Start a search for conditional branches, both implicit and explicit
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  command! FindConditionals :normal /\<if\>\|\<unless\>\|\<and\>\|\<or\>\|||\|&&<cr>

  " copy to clipboard
  map <leader>y "*y

  " ctrl-c as escape
  imap <c-c> <esc>

" alignment helpers from vimcasts
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>

" yankring shortcut
nnoremap <Leader>ys :YRShow<CR>

" setup powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
