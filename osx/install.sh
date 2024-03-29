#!/bin/bash

current_dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# install xcode - can also trigger with `git`
xcode-select --install

# install fonts
cp "${current_dir}/../fonts/*" /Library/Fonts

## brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# install latest bash and add to shell
brew install bash
sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"  # or /private/etc/shells ?
# might default to bash in shell, but next steps overwrite


# install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended

# install Powerlevel10K theme - will prompt to customise on next run
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# comment out current theme, by default bobbyrussel, add powerlevel10k theme
# echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc
sed -i -e "s|robbyrussell|powerlevel10k/powerlevel10k|g" ~/.zshrc

# good resource for vscode setup https://gist.github.com/480/3b41f449686a089f34edb45d00672f28

# alias tips
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM1:-$ZSH/custom}/plugins/alias-tips

# oh my matrix
git clone https://github.com/amstrad/oh-my-matrix ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/oh-my-matrix

# auto suggestions - https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# add 'zsh-autosuggestions' to plugins in ~/.zshrc
# plugins=( 
#     # other plugins...
#     zsh-autosuggestions
# )

# https://github.com/zsh-users/zsh-history-substring-search#usage:
# "If you want to use zsh-syntax-highlighting along with this script, 
# then make sure that you load it before you load this script"
# source zsh-syntax-highlighting.zsh
# source zsh-history-substring-search.zsh

# faster syntax highlighting, successor to zsh syntax highlighting
# https://github.com/zdharma-continuum/fast-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
# add 'zsh-history-substring-search' to plugins in ~/.zshrc
# plugins=( 
#     # other plugins...
#     zsh-history-substring-search
# )

# configure python with pyenv: https://opensource.com/article/19/5/python-3-default-mac
#brew install pyenv # handled in brewfile
pyenv install 3.11.1
pyenv global 3.11.1

# add lines to .zshrc file, in echo below
cp "${current_dir}/.zshrc" ~/.zshrc

# flat icon theme colours: https://github.com/QuentinWatt/dark-flat-iterm-colors/blob/master/flat-colors.itermcolors
curl https://raw.githubusercontent.com/QuentinWatt/dark-flat-iterm-colors/master/flat-colors.itermcolors -o ~/Downloads/flat-colors.itermcolors


# fix home and end keys
# https://coderwall.com/p/ikyhag/fixing-home-and-end-keys-and-more-on-macos
#mkdir -p $HOME/Library/KeyBindings
#echo '{
#/* Remap Home / End keys to be correct */
#"\UF729" = "moveToBeginningOfLine:"; /* Home */
#"\UF72B" = "moveToEndOfLine:"; /* End */
#"$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
#"$\UF72B" = "moveToEndOfLineAndModifySelection:"; /* Shift + End */
#"^\UF729" = "moveToBeginningOfDocument:"; /* Ctrl + Home */
#"^\UF72B" = "moveToEndOfDocument:"; /* Ctrl + End */
#"$^\UF729" = "moveToBeginningOfDocumentAndModifySelection:"; /* Shift + Ctrl + Home */
#"$^\UF72B" = "moveToEndOfDocumentAndModifySelection:"; /* Shift + Ctrl + End */
#}' > $HOME/Library/KeyBindings/DefaultKeyBinding.dict


## show hidden folder and files
# defaults write com.apple.Finder AppleShowAllFiles true

## hide hidden folder and files
# defaults write com.apple.Finder AppleShowAllFiles false

######### Packages
brew bundle install --file "${current_dir}/Brewfile"

# old
# ## git
# brew tap microsoft/git
# brew install --cask git-credential-manager-core

# ## ansible
# brew install ansible
# brew install ansible-lint

# ## docker
# brew install --cask docker

# ## aws
# brew install awscli

# ## azure
# brew install azure-cli

# ## gcp
# brew install --cask google-cloud-sdk

# ## terraform/grunt
# # pre-commit: https://github.com/antonbabenko/pre-commit-terraform
# brew install terraform-docs
# # brew install liamg/tfsec/tfsec
# brew install tflint
# brew install warrensbox/tap/tfswitch
# brew install warrensbox/tap/tgswitch
# brew install graphwiz # for visualising terraform

# ## vault
# brew tap hashicorp/tap
# brew install hashicorp/tap/vault

# ## vs code
# brew install --cask visual-studio-code

# ## virtualbox
# brew install --cask virtualbox
# brew install --cask virtualbox-extension-pack

# ## kubernetes
# brew install kubectl
# brew install --cask lens   # k8s IDE

# ## helm
# brew install helm
# # https://github.com/jkroepke/helm-secrets/wiki/Installation
# helm plugin install https://github.com/jkroepke/helm-secrets --version v3.12.0

# ## minikube
# brew install minikube

# ## packer
# brew install packer

# ## powershell
# brew install --cask powershell

# ## auth
# brew install --cask authy
# brew install --cask bitwarden

# ## comms
# #brew install --cask slack
# #brew install --cask microsoft-teams
# brew install --cask signal
# brew install --cask whatsapp

# ## other
# brew install --cask brave-browser
# brew install caffeine
# brew install --cask gimp
# brew install jq
# brew install --cask microsoft-remote-desktop
# brew install --cask scroll-reverser
# brew install shellcheck    # then install https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck in vs-code
# brew install sops
# brew install --cask spectacle
# brew install --cask spotify
# brew install tree
# brew install watch
# brew install yamllint

# gcloud gke plugin - gcloud should be installed in brewfile
gcloud components install gke-gcloud-auth-plugin

#### git
git config --global core.excludesFile '~/.gitignore'
echo "chris.sh" >> ~/.gitignore

###### SYSTEM
# password prompt on screensaver and sleep
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# show dotfiles, file extensions, /Library
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder

# say no to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# disable crash reporter
defaults write com.apple.CrashReporter DialogType none

# don't advertise on bluetooth - can this have an adverse effect on functionality?
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES


## change hostname
# sudo scutil --set HostName mbp.fqdn.tld
# sudo scutil --set ComputerName mbp

## clear dns cache
# dscacheutil -flushcache

## reboot
# sudo reboot now
