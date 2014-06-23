# To use:

1. First we need to build the latest vim with python enabled

 ```
 # If you don't have mercurial
 $ brew install hg

 # Create the directories you need
 $ sudo mkdir -p /opt/local/bin

 # Download, compile, and install the latest Vim
 $ cd ~
 $ hg clone https://code.google.com/p/vim/
 $ cd vim
 $ ./configure --prefix=/opt/local --enable-pythoninterp --with-python-config-dir=/path/to/python/config
 $ make
 $ sudo make install

 # Add the binary to your path, ahead of /usr/bin
 $ echo 'PATH=/opt/local/bin:$PATH' >> ~/.zshrc

 # Reload zsh so the changes take effect in this window
 $ source ~/.zshrc

 # Check that vim is updated and using new path
 $ which vim
 $ vim --version | head -n 2
 $ vim --version | grep python
 ```

2. Install The Silver Searcher

 ```
 $ brew install the_silver_searcher
 ```

3. Make sure you don't have a `~/.vim` directory or a `~/.vimrc` file.

  ```
  # If you want to backup
  $ mv ~/.vim ~/.vim.bak
  $ mv ~/.vimrc ~/.vimrc.bak

  # Otherwise just remove
  $ rm -rf ~/.vim
  $ rm ~/.vimrc
  ```

4. Setup vimming.

  ```
  $ git clone https://github.com/hinshun/vimming.git ~/.vim
  $ cd ~/.vim
  $ rake
  ```

5. Open `vim` and enjoy.

# Things to note

- The leader key is the spacebar.
- tabstop/shiftwidth/softtabstop is 2
- You can use `<C-c>` for Esc.
- When you split a window, it will appear below or to the right (for a vertical split).

## Searching

- CtrlP is using the_silver_searcher for building the index and ctrlp-py-matcher
  for matching
- `K` (shift + k) while on a word, will grep for the word in the code base.
  - `foo_bar` will also find `foo_bar_something`
- `KK` (shift + kk) while on a word, will grep for the tag (just the word) in the code base.
  - `foo_bar` will not find `foo_bar_something`
- `<Leader>/` will unhighlight the search terms.

## Git (Fugitive)

- `<Leader>gs` will display a window buffer with the git status.
 - If you place your cursor over a file and press Enter, it will open in the
   buffer above.
 - If you place your cursor over a file and press `D`, the diff of that file
   will be displayed.
 - If you place your cursor over a file and press `-`, the file will be placed
   in staging (`git add`), or removed from staging if it was already there (`git
   reset`).
- `<Leader>gc` will open a window buffer where you can enter your commit message.
  Saving the message will commit the file.
- You have access to git commands via `:Git`
  - `<Leader>gp`, for instance will push to master.
- `<Leader>gd` on a file with changes will open a diff buffer.
  - In order to revert changes, select the part of the code and use `:diffget`,
    this will get the changes from the diff buffer.
  - If you're in the diff buffer and want the send the changes to your file,
    `:diffput`.
- `<Leader>gb` will open a buffer indicating who commited that line.

## Buffers (bufexplorer)

- To see the buffer window: `<Leader>be` (this will replace the current buffer)
- To see the buffer window in a split: `<Leader>bs` or `<Leader>bv`
- You can navigate the buffer, press Enter on a file to open it.

## Copy Paste History (YankRing)

- `<Leader>y` will copy things to your normal clipboard (you can paste on other
  programs).
- `<Leader>yr` will open a copy history for things you've yanked or deleted.
  - Press Enter on one to paste it.

## Tagbar

- Use `<Leader>b` to open a split buffer window of all the tags in this file.
  - Press Enter on any of the tags to go to them.

## Commenting

- Highlight some lines and press `gc` to comment (and uncomment).
- `gc` on a line without highlight to comment/uncomment.

## Rails [Plugin](https://github.com/tpope/vim-rails)

- `gf` over a class, partial, will take you to the file. (this will even work on
  symbols: with `has_many :users`, `gf` on the `:users` symbol will take you to
  the user model.
- `:Rmodel <model_name>` will take you to the model.
  - Similar things will happen for `:Rcontroller`, `:Rview`
  - Try tab completion with the model names, it will show you possible options. Always search in lowercase.
  - `:RVmodel` will open the model in a vertical split. `:RSmodel` in a
    horizontal split. `:RVcontroller`, `:RVview` also work.
- While in a controller method `:R` will take you to the view of that method.
  `:R` from the view will bring you back to the method. `:RV`, `:RS` will open
  in splits.
- While in a model `:A` will take you to the tests.
- In general `:A` will take you to an alternate file. `:R` will take you to a
  related file. Play around with these in different files.
