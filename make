all:  setup_brew setup zsh brew_install_essentials brew_install_software git_config remap_keys

setup_brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > ~/Downloads/Homebrew_install.sh
	chmod 700 ~/Downloads/Homebrew_install.sh
	/bin/bash -c ~/Downloads/Homebrew_install.sh
	sudo chown -R ${USER} /usr/local/*
setup:
	mkdir ~/Documents/screenshots || echo "dir screenshots exists"
	defaults write com.apple.screencapture location ~/Documents/screenshots
	defaults write com.apple.Finder AppleShowAllFiles true
brew_install_essentials:
	brew install z
	brew install git
git_config:
	git config --global core.editor "code --wait"
	git config --global core.user ${USER}  
zsh:	
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
brew_install_software:
	brew install tree

	brew install --cask rectangle

	brew install --cask slack

	brew install --cask zoom

	brew install jq

	brew install --cask whatsapp

	brew install --cask atom

	brew install --cask visual-studio-code

	brew install docker

	brew install python@3.9

	python3 -m pip install --user --upgrade setuptools

	python3 -m pip install --user --upgrade pip

	brew install --cask snowflake-snowsql

	brew install --cask cyberduck

	brew install --cask spotify

	brew install --cask discord

	brew install --cask obs

	brew install --cask plex

	brew install --cask viber

	brew install --cask vlc

	brew install awscli

	brew install gh
remap_keys:
	curl "https://raw.githubusercontent.com/AdamDewberry/remap-mac-keys/main/remap-caps-lock-to-control.sh" > ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
	launchctl load ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
	echo live share, Remote containers


