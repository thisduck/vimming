" Inject bundles
execute pathogen#infect()

" Disable vi-compatibility
set nocompatible

" Set augroup
augroup auglobal
  autocmd!
augroup END

" Turn on automatic indentation
filetype plugin indent on

" Enable syntax
syntax enable

"===============================================================================
" General Settings
"===============================================================================

" Set default shell
set shell=/bin/sh

" Disable splash screen
set shortmess+=I

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

" Highlight current line cursor is on
set cursorline

" Show the current command being inputted
set showcmd

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

" Set grep to use The Silver Searcher
set grepprg=ag\ --nogroup\ --nocolor

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

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

" <Leader>tb: Toggle tagbar
nnoremap <Leader>tb :TagbarToggle<cr>

" <Leader>nt: Toggle NERDTree
nnoremap <Leader>nt :NERDTreeToggle<cr>

" <Leader>gs: Open Fugitive git status
nnoremap <Leader>gs :Gstatus<cr>

" <Leader>ga: Open Fugitive git add
nnoremap <Leader>ga :Gwrite<cr>

" <Leader>gc: Open Fugitive git commit
nnoremap <Leader>gc :Gcommit<cr>

" <Leader>gp: Open Fugitive git push
nnoremap <Leader>gp :Git push<cr>

" <Leader>gb: Open Fugitive git blame
nnoremap <Leader>gb :Gblame<cr>

" <Leader>gd: Open Fugitive git diff
nnoremap <Leader>gd :Gdiff<cr>

" <Leader>ct: Open CtrlP Ctags
nnoremap <leader>ct :CtrlPTag<cr>

" <Leader>so: Open Session
nnoremap <Leader>so :OpenSession

" <Leader>sc: Close Session
nnoremap <Leader>sc :CloseSession

" <Leader>ss: Save Session
nnoremap <Leader>ss :SaveSession

" <Leader>sd: Delete Session
nnoremap <Leader>sd :DeleteSession

" <Leader>yr: Open Yankring
nnoremap <Leader>yr :YRShow<cr>

" <Leader>ut: Toggle Gundo
nnoremap <Leader>ut :GundoToggle<cr>

" <Leader>bs: Open BufExplorer horizontal split

" <Leader>bv: Open BufExplorer vertical split

"===============================================================================
" Mode Key Mappings
"===============================================================================

" <C-p>: Opens CtrlP
nmap <C-p> :CtrlP<cr>
let g:ctrlp_map = '<C-p>'

" <C-c>: <ESC>
imap <C-c> <esc>

" <Leader>ta: Tabularize
nnoremap <C-t> :Tabularize
vmap <C-t> :Tabularize

" gc: Comment toggle

"===============================================================================
" Autocommands
"===============================================================================

augroup auglobal
  " Wrap lines in QuickFix buffer so that characters will not get lost
  autocmd bufenter * if &buftype == 'quickfix' | setlocal wrap | endif
  autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal wrap | endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Automatically open quickfix window after grepping
  autocmd QuickFixCmdPost *grep* cwindow

  " Close vim if the only window open is NERDTree
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell
augroup END

"===============================================================================
" Plugin Settings
"===============================================================================

" NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

" CtrlP
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g "" -p --path-to-agignore "~/.agignore"'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_use_caching = 0

" Session
let g:session_directory = '~/.vim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

" Rails
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Syntastic
let g:syntastic_check_on_open=1

" YankRing
let g:yankring_replace_n_pkey = ''

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
hi link EasyMotionShade  Comment
