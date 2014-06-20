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

" Set default shell
set shell=/bin/sh

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

" <Leader>t: Toggle tagbar
nnoremap <Leader>t :TagbarToggle<cr>

" <Leader>nt: Toggle NERDTree
nnoremap <Leader>nt :NERDTreeToggle<cr>

" <Leader>gs: Open Fugitive git status
nnoremap <Leader>gs :Gstatus<cr>

" <Leader>gc: Open Fugitive git commit
nnoremap <Leader>gc :Gcommit<cr>

" <Leader>gp: Open Fugitive git push
nnoremap <Leader>gp :Git push<cr>

" <Leader>gb: Open Fugitive git blame
nnoremap <Leader>gb :Gblame<cr>

" <Leader>gd: Open Fugitive git diff
nnoremap <Leader>gd :Gdiff<cr>

" <Leader>gr: Open Fugitive git rm
nnoremap <Leader>gr :Gremove<cr>

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
nnoremap <Leader>yr :YRShow<CR>

"===============================================================================
" Normal Mode Key Mappings
"===============================================================================

" <C-p>: Opens CtrlP
nmap <C-p> :CtrlP<CR>
let g:ctrlp_map = '<C-p>'

" <C-c>: <ESC>
imap <C-c> <esc>

" <C-j>: Move to lower window
nnoremap <C-j> <C-w>j

" <C-k>: Move to upper window
nnoremap <C-k> <C-w>k

" <C-h>: Move to left window
nnoremap <C-h> <C-w>h

" <C-l>: Move to right window
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

augroup MyAutoCmd
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

" Automatically open quickfix window after grepping
autocmd QuickFixCmdPost *grep* cwindow

"===============================================================================
" Plugin Settings
"===============================================================================

" NERDTree Settings
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" Close vim if the only window open is NERDTree
autocmd MyAutoCmd BufEnter * 
  \ if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP Settings
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

" Session Settings
let g:session_directory = '~/.vim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

" Rails Settings
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Syntastic Settings
let g:syntastic_check_on_open=1
