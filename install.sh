cp .vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#YouCompleteMe install
python ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer --ts-completer