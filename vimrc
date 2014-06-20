" Inject bundles
execute pathogen#infect()

" Disable vi-compatibility
set nocompatible

" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

filetype plugin indent on
syntax enable

"===============================================================================
" General Settings
"===============================================================================

" Theme
set background=light
colorscheme solarized

" Turn on line number
set number

" Always splits to the right and below
set splitbelow
set splitright

" Turn off sound
set vb
set t_vb=

" Explicitly set encoding to utf-8
set encoding=utf-8

" Lower the delay of escaping out of other modes
set timeout timeoutlen=200 ttimeoutlen=1

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Set to auto write file
set autowriteall

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" Min width of the number column to the left
set numberwidth=1

" Open all folds initially
set foldmethod=indent   	        " fold by indent level
set nofoldenable        	        " dont fold by default

" Set level of folding
set foldlevel=1        	          " start folding for level

" Allow changing buffer without saving it first
set hidden

" Set backspace config
set backspace=eol,start,indent

" Case insensitive search
set ignorecase
set smartcase

" Incremental search
set incsearch

" Highlight search
set hlsearch

" Make regex a little easier to type
set magic

" Tab settings
set tabstop=2                     " width of tab
set shiftwidth=2                  " shifting >>, <<, ==
set softtabstop=2                 " tab key <TAB>, <BS>
set expandtab	                    " always use softtabstop for <TAB>

" Text display settings
set autoindent
set linebreak
set textwidth=80

" Auto complete setting
set completeopt=longest,menuone

" Wild menu settings
set wildmode=list:longest,full
set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

"===============================================================================
" Leader Key Mappings
"===============================================================================

" Map leader to space
let mapleader = " "
let g:mapleader = " "
let maplocalleader = " "
let g:maplocalleader = " "

" <Leader>t: Toggle tagbar
nnoremap <silent> <Leader>t :TagbarToggle<cr>

" <Leader>nt: Toggle NERDTree
nnoremap <silent> <Leader>nt :NERDTreeToggle<cr>

"===============================================================================
" Normal Mode Key Mappings
"===============================================================================

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"===============================================================================
" Autocommand
"===============================================================================

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup MyAutoCmd
  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
augroup END

" mapping
nmap <c-p> :CtrlP<CR>
imap <c-c> <esc>
map <leader>y "*y

" tabbing

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "<C-R><C-W>"<CR>:cw<CR>
nnoremap KK :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" run ctags to take advantage of this: ctags -R .
nnoremap <leader>. :CtrlPTag<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" from thoughtbot
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'


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

let g:ctrlp_map = '<c-p>'

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


" alignment helpers from vimcasts
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>at :Tabularize /\|<CR>
vmap <Leader>at :Tabularize /\|<CR>

" yankring shortcut
nnoremap <Leader>ys :YRShow<CR>

" replace old style ruby hash syntax with new one
map <Leader>> :s@:\([^: =]\+\)\s*=>\s*@\1: @g<CR>
map <Leader>s, :s@,@,\r@g<CR>
map <Leader>s} :s@}@\r}@g<CR>
map <Leader>s{ :s@{@{\r@g<CR>
map <Leader>s( :s@(@(\r@g<CR>

map <Leader>> :s@:\([^: =({})]\+\)\s*=>\s*@\1: @g<CR>

" setup powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" ensure that ctrl-p links to ctrlp's file finder, and not YankRing's paste.
let g:yankring_replace_n_pkey = '<C-t>'

" vim session shortcuts
let g:session_directory = '~/.vim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1
nnoremap <Leader>so :OpenSession
nnoremap <Leader>sc :CloseSession
nnoremap <Leader>ss :SaveSession
nnoremap <Leader>sd :DeleteSession
