# Vimming

Vimming quickly setups up a customized vim to your terminal featuring solarized-light 
theme, a customized status line, and uses great plugins like CtrlP, 
Airline, BufExplorer, and more. (For all the plugins, take a look at the 
Rakefile)

Just install, clone, rake, and `vim`.

# Installation

Before you can clone the repository, we need a newer version of vim. So go ahead
and install vim via homebrew

  ```
  $ brew install vim
  ```

We also need The Silver Searcher for faster searching with CtrlP, so install
that too.

  ```
  $ brew install the_silver_searcher
  ```

Make sure you don't have a `~/.vim` directory or a `~/.vimrc` file.

  ```
  # If you want to backup
  $ mv ~/.vim ~/.vim.bak
  $ mv ~/.vimrc ~/.vimrc.bak

  # Otherwise just remove
  $ rm -rf ~/.vim
  $ rm ~/.vimrc
  ```

Finally, we can setup vimming. Clone and rake.

  ```
  $ git clone https://github.com/hinshun/vimming.git ~/.vim
  $ cd ~/.vim
  $ rake
  ```

Open `vim` and enjoy.

# Usage

The .vimrc file is well documented with the customized key mappings of this
setup. However, if you just want to get started straight away, here are a few
basic mappings.

  ```
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
  ```

