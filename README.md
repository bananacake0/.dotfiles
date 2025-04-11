# .dotfiles

My .dotfiles

```bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

sudo apt-get install zsh neovim nmap python3-full python3-pip -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

nano ~/.zshrc
# plugins=( zsh-autosuggestions zsh-syntax-highlighting)
```

## Installing vim config

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Installing nvim config

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
cp ~/.init.vim ~/.config/nvim/init.vim
nvim +PlugInstall +qall
```

## Installing nano config

```bash
git clone https://github.com/scopatz/nanorc.git .nano
git clone https://github.com/bananacake0/.dotfiles ~/.dotfiles
cp ~/.dotfiles/.* ~
```

## Installing nodejs

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

### in lieu of restarting the shell

\. "$HOME/.nvm/nvm.sh"

### Download and install Node.js

nvm install 22
```

## Installing golang

```bash
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_aliases
echo "export GOPATH=$HOME/go" >> ~/.bash_aliases
echo "export GOROOT=/usr/local/go" >> ~/.bash_aliases
echo "export PATH=$PATH:$GOPATH/bin" >> ~/.bash_aliases
\. "HOME/.zshrc"
```
