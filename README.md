# Vimming

Vimming brings a customized vim to your terminal featuring great plugins like CtrlP, Airline,
BufExplorer, and more. (For all the plugins, take a look at the Rakefile)

# Installation

1. Install vim via homebrew

  $ brew install vim

2. Install The Silver Searcher

  $ brew install the_silver_searcher

3. Make sure you don't have a `~/.vim` directory or a `~/.vimrc` file.

  # If you want to backup
  $ mv ~/.vim ~/.vim.bak
  $ mv ~/.vimrc ~/.vimrc.bak

  # Otherwise just remove
  $ rm -rf ~/.vim
  $ rm ~/.vimrc

4. Setup vimming.

  $ git clone https://github.com/hinshun/vimming.git ~/.vim
  $ cd ~/.vim
  $ rake

5. Open `vim` and enjoy.

# Usage

The .vimrc file is well documented with the customized key mappings of this
setup. However, if you just want to get started straight away, here are a few
basic mappings.

  <C-c> = <ESC>
  <C-p> = Open CtrlP
  <C-t> = Open Tabularize
  <Leader> = ' '
  <Leader>/ = Clear highlighted searches
  <Leader>bs = Open BufExplorer
  <Leader>nt = Toggle NerdTREE
  <Leader>tb = Toggle Tagbar
  <Leader>ut = Open Gundo
  <Leader>y = Copy to system clipboard
  <Leader>yr = Toggle YankRing
  gc = Comment motion

