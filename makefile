all: temp_dirs remap_keys setup_brew setup_mac_preferences brew_install_essentials set_vars ssh_gpg_keys git_config zsh brew_install_collaboration brew_install_tools brew_install_media remove_temp_dir
temp_dirs:
	mkdir ~/temp_setup || echo "dir temp_setup exists"
remap_keys:
	curl "https://raw.githubusercontent.com/AdamDewberry/mac-setup/main/remap-caps-lock-to-control.xml" > ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
	launchctl load ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
setup_brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > ~/temp_setup/Homebrew_install.sh
	chmod 700 ~/temp_setup/Homebrew_install.sh
	/bin/bash -c ~/temp_setup/Homebrew_install.sh
	sudo chown -R ${USER} /usr/local/*
setup_mac_preferences:
	mkdir ~/Documents/screenshots || echo "dir screenshots exists"
	defaults write com.apple.screencapture location ~/Documents/screenshots
	defaults write com.apple.Finder AppleShowAllFiles true
	defaults write -g com.apple.swipescrolldirection -bool false  
brew_install_essentials:
	brew install z
	brew install git
	brew install gh
	brew install gpg
	brew upgrade gnupg 
	brew install pinentry-mac
	brew install jq
set_vars:
	system_profiler -json > ~/temp_setup/sys_profiler.json
	cat ~/temp_setup/sys_profiler.json | jq ".SPConfigurationProfileDataType[]._items[0].spconfigprofile_organization" | sed 's/ //g' | awk '{print tolower($0)}' | tr -d '"' > ~/temp_setup/orgName.txt
	cat ~/temp_setup/sys_profiler.json | jq ".SPConfigurationProfileDataType[]._items[0].spconfigprofile_organization" | awk '{print $1}' | sed 's/ //g' |  tr -d '"' > ~/temp_setup/shortOrgName.txt
orgName := $(shell cat ~/temp_setup/orgName.txt)
shortOrgName  := $(shell cat ~/temp_setup/shortOrgName.txt)
ssh_gpg_keys:
	echo shortOrgName: ${shortOrgName}
	gpg --full-generate-key # RSA 1, 4096, 0, name, email, shortOrgName GitHub GPG key, O <- capital o
	echo "pinentry-program $(which pinentry-mac)" > ~/.gnupg/gpg-agent.conf
	killall gpg-agent
	echo "test" | gpg --clearsign 
	ssh-keygen -t ed25519 -C "${USER}@${orgNamet}.com"
	ssh-add -K ~/.ssh/id_ed25519
git_config:	
	git config --global core.editor "code --wait"
	git config --global core.user ${USER}  
	git config --global user.email '${USER}@${orgName}.com'
	git config --global gpg.program gpg
	git config --global commit.gpgSign true
	gh auth login
zsh:	
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	cp ./.zshrc > ~/.zshrc
brew_install_collaboration:
	brew install --cask rectangle

	brew install --cask homebrew/cask-drivers/logitech-options

	brew install --cask caffeine

	brew install --cask slack

	brew install --cask microsoft-teams    

	brew install --cask whatsapp

	brew install --cask zoom
brew_install_tools:	
	brew install --cask visual-studio-code

	brew install tree

	brew install the_silver_searcher

	brew install docker

	brew install python@3.9

	brew install poetry

	python3 -m pip install --user --upgrade setuptools

	python3 -m pip install --user --upgrade pip

	brew install warrensbox/tap/tfswitch

	brew install go

	brew install kafka

	brew install --cask beekeeper-studio

	brew install awscli

	brew install --cask snowflake-snowsql

	brew install --cask cyberduck

	brew install --cask keybase
brew_install_media:
	brew install --cask spotify

	brew install --cask discord

	brew install --cask obs

	brew install --cask plex

	brew install --cask vlc

	brew install --cask viber
remove_temp_dir:
	rm -rf mkdir ~/temp_setup
