# To use:

1. Fork the repo to your own account.

2. On the command line:

  ```
  $ git clone git@github.com:[YOUR_USERNAME]/vimming.git ~/.vim
  $ ln -s ~/.vim/vimrc ~/.vimrc
  $ cd ~/.vim
  $ git submodule init
  $ git submodule update
  ```

3. Open `vim` and enjoy.

# Things to note

- The leader key is the spacebar.
- tabstop/shiftwidth/softtabstop is 2

## Searching

- Search is using the_silver_searcher instead of grep.
- `K` (shift + k) while on a word, will grep for the word in the code base.
- `KK` (shift + kk) while on a word, will grep for the tag (just the word) in the code base.
- `<Leader>/` will unhighlight the search terms.
