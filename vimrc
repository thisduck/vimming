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

" Set grep to use The Silver Searcher
set grepprg=ag\ --nogroup\ --nocolor

" Set default shell
set shell=/bin/sh

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

" run ctags to take advantage of this: ctags -R .
nnoremap <leader>ct :CtrlPTag<cr>

" <Leader>so: Open Session
nnoremap <Leader>so :OpenSession

" <Leader>sc: Close Session
nnoremap <Leader>sc :CloseSession

" <Leader>ss: Save Session
nnoremap <Leader>ss :SaveSession

" <Leader>sd: Delete Session
nnoremap <Leader>sd :DeleteSession

"===============================================================================
" Normal Mode Key Mappings
"===============================================================================

" Ctrl-P: Opens CtrlP
nmap <c-p> :CtrlP<CR>
let g:ctrlp_map = '<c-p>'

" Ctrl-C: <ESC>
imap <c-c> <esc>

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

" mapping
map <leader>y "*y


" bind K to grep word under cursor
nnoremap K :grep! "<C-R><C-W>"<CR>:cw<CR>
nnoremap KK :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"


" automatically open quickfix after grep
autocmd QuickFixCmdPost *grep* cwindow
set cursorline
set showcmd

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

