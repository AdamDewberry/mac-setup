all: temp_dirs remap_keys setup_brew setup_mac_preferences brew_install_essentials set_vars ssh_gpg_keys git_config zsh brew_install_collaboration brew_install_tools brew_install_media remove_temp_dir
temp_dirs:
	mkdir ~/temp_setup || echo "dir temp_setup exists"
remap_keys:
	mkdir ${$HOME}/Library/LaunchAgents/
	curl "https://raw.githubusercontent.com/AdamDewberry/mac-setup/main/remap-keys.xml" > ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
	chmod 700 ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
	sudo launchctl bootstrap gui/501 ~/Library/LaunchAgents/local.hidutilKeyMapping.plist
setup_brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > ~/temp_setup/Homebrew_install.sh
	chmod 700 ~/temp_setup/Homebrew_install.sh
	/bin/bash -c ~/temp_setup/Homebrew_install.sh
	sudo chown -R ${USER} /usr/local/*
setup_mac_preferences:
	mkdir ~/Documents/screenshots || echo "dir screenshots exists"
	defaults write com.apple.screencapture location ~/Documents/screenshots
	defaults write com.apple.Finder AppleShowAllFiles true
	defaults write com.apple.finder QuitMenuItem -bool true
	defaults write -g com.apple.swipescrolldirection -bool false
	defaults write com.apple.dock static-only -bool TRUE
	defaults write com.apple.dock show-recents -bool no
	defaults write com.apple.dock recent-apps -array
	defaults write com.apple.Dock autohide-delay -float 0
	defaults write com.apple.dock autohide -bool "true"
	defaults write com.apple.finder QuitMenuItem -bool true
	sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
	defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
	killall Dock
	killall Finder
	killall screencapture
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
	gh gpg-key add ${$HOME}/.gnupg/pubring.kbx
zsh:	
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	curl "https://raw.githubusercontent.com/AdamDewberry/mac-setup/main/.zshrc" > ~/.zshrc
brew_install_collaboration:
	curl -fsSL https://github.com/dexterleng/KeyboardScroller.docs/releases/download/v1.0.1/Keyboard-Scroller-1.0.1.zip > ~/temp_setup/Keyboard-Scroller.zip
	open ~/temp_setup/Keyboard-Scroller.zip && mv ~/temp_setup/Keyboard\ Scroller.app /Applications/Keyboard\ Scroller.app  && open /Applications/Keyboard\ Scroller.app

	curl -fsSl https://appcenter-filemanagement-distrib5ede6f06e.azureedge.net/f02d07f6-f27e-4b8d-8c40-a13f6e9f9940/Homerow-0.11.zip\?sv\=2019-02-02\&sr\=c\&sig\=E6dCRDBcZE7qAwoYQbhhU6Y0bCONtszcKoNJ0z9oiuQ%3D\&se\=2022-12-13T13%3A59%3A25Z\&sp\=r\&download_origin\=appcenter > ~/temp_setup/Homerow-0.11.zip
	open ~/temp_setup/Homerow-0.11.zip && mv ~/temp_setup/Homerow.app /Applications/Homerow.app && open /Applications/Homerow.app
	
	brew install --cask google-chrome
	
	brew install --cask rectangle

	brew install --cask homebrew/cask-drivers/logitech-options

	brew install --cask caffeine

	brew install --cask slack

	brew install --cask microsoft-teams    

	brew install --cask whatsapp

	brew install --cask zoom
brew_install_tools:	
	brew install --cask visual-studio-code

	brew install oath-toolkit

	brew install tree

	brew install python@3.10

	brew install poetry

	python3 -m pip install --user --upgrade setuptools

	python3 -m pip install --user --upgrade pip

	brew install the_silver_searcher

	brew install --cask docker

	brew install warrensbox/tap/tfswitch

	brew install terraform-docs

	brew install go

	brew install golangci/tap/golangci-lint

	go install -v github.com/ramya-rao-a/go-outline@latest

	go get golang.org/x/tools/cmd/godoc

	brew install kafka

	brew install --cask beekeeper-studio

	brew install awscli

	brew install --cask snowflake-snowsql

	brew install --cask cyberduck

	brew install --cask keybase

	brew install --cask 1password-cli
	
	brew install csvkit

	brew install ruby  

	brew install node
brew_install_media:
	brew install --cask spotify

	brew install --cask discord

	brew install --cask obs

	brew install --cask plex

	brew install --cask vlc

	brew install --cask viber

	brew install pandoc

remove_temp_dir:
	rm -rf mkdir ~/temp_setup
