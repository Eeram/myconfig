# Install advanced VIM config (basic version)
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh
echo "VIM runtime installed"
echo "\" Mouse support\nset mouse=a" >> ~/.vimrc

# Set up git
cp git/.gitconfig ~/.gitconfig



