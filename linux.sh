#!/bin/sh

# Check if oh-my-zsh is installed
if [ ! -d ~/.oh-my-zsh ]; then
    echo "oh-my-zsh not installed, downloading and installing now..."

    # Clone ohmyzsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

else
    echo "oh-my-zsh was found, skipping installation!"
fi

echo "Installing nerd fonts..."

# Install powerline nerd fonts
git clone https://github.com/powerline/fonts
sh -c fonts/install.sh
rm -rf fonts

# Install Meslo Regular fonts
# TODO: This might not actually working, need to check it out
curl -o "/usr/share/fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# Install zsh-auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Check if percol is installed
percol_installed=$(cat ~/.zshrc | grep percol)

# TODO: It seems like percol is still not working, need to check why
if [ $percol_installed -eq "" ]; then
    echo "Percol not found, installing..."
    pip install percol || echo "Failed to install percol, check that python and pip are installed!"
fi

echo "Updating the plugins list for oh-my-zsh..."
sed -i -r 's/plugins\=.+/plugins=(git docker docker-compose jsontools copyfile web-search dirhistory zsh-autosuggestions percol)/' ~/.zshrc

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Replacing theme to powerlevel10k..."
sed -i -r 's/ZSH_THEME\=.+/ZSH_THEME=powerlevel10k\/powerlevel10k/' ~/.zshrc

echo "Setup was finished! Please run 'source ~/.zshrc' or reload terminal to view the changes"
