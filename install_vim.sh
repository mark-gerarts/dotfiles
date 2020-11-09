#!/bin/sh

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install extensions
cd ~/.vim/bundle
git clone git@github.com:rakr/vim-one.git
git clone https://github.com/preservim/nerdtree.git
git clone git@github.com:vim-airline/vim-airline.git
git clone https://gitlab.science.ru.nl/cstaps/vim-clean.git

# Haskell support
git clone git@github.com:neovimhaskell/haskell-vim.git
