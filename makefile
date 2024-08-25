all: setup_mac_preferences install_xcode temp_dirs remap_keys setup_brew brew_install_essentials set_vars ssh_gpg_keys git_config zsh brew_install_collaboration brew_install_tools brew_install_media remove_temp_dir
setup_mac_preferences:
	mkdir ~/Documents/screenshots || echo "dir screenshots exists"
	networksetup -ordernetworkservices  "Bluetooth PAN"  "Thunderbolt Bridge"  "Wi-Fi"
	sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
	defaults -currentHost write com.apple.controlcenter.plist Bluetooth -int 18
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
	defaults write com.apple.dock static-only -bool TRUE
	defaults write com.apple.dock show-recents -bool no
	defaults write com.apple.dock recent-apps -array
	defaults write com.apple.Dock autohide-delay -float 0
	defaults write com.apple.dock autohide -bool "true"
	defaults write com.apple.Finder AppleShowAllFiles true
	defaults write com.apple.finder QuitMenuItem -bool true
	defaults write com.apple.finder EmptyTrashSecurely -bool true
	defaults write com.apple.finder NewWindowTarget -string "PfLo"
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
	defaults write com.apple.LaunchServices LSQuarantine -bool false
	defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
	defaults write com.apple.screencapture location ~/Documents/screenshots
	defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
	defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
	defaults write -g com.apple.swipescrolldirection -bool false
	defaults write com.apple.terminal FocusFollowsMouse -bool true
	defaults write org.x.X11 wm_ffm -bool true
	killall Dock
	killall Finder
	killall Mail
	killall Terminal
install_xcode:
	xcode-select --install
temp_dirs:
	mkdir ~/temp_setup || echo "dir temp_setup exists"
remap_keys:
	curl "https://raw.githubusercontent.com/AdamDewberry/mac-setup/main/remap-keys.xml" | sudo tee -a /Library/LaunchDaemons/local.hidutilKeyMapping.plist
	sudo chmod 700 /Library/LaunchDaemons/local.hidutilKeyMapping.plist
	sudo launchctl load /Library/LaunchDaemons/local.hidutilKeyMapping.plist
setup_brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > ~/temp_setup/Homebrew_install.sh
	chmod 700 ~/temp_setup/Homebrew_install.sh
	/bin/bash -c ~/temp_setup/Homebrew_install.sh
	sudo chown -R ${USER} /usr/local/*
brew_install_essentials:
	brew install --cask google-chrome && open /Applications/Google\ Chrome.app
	
	curl -fsSL https://github.com/dexterleng/KeyboardScroller.docs/releases/download/v1.0.2/Keyboard-Scroller-1.0.2.zip > ~/temp_setup/Keyboard-Scroller-1.0.2.zip
	open ~/temp_setup/Keyboard-Scroller-1.0.2.zip 
	mv ~/temp_setup/Keyboard\ Scroller.app/ /Applications/Keyboard\ Scroller.app/

	curl -fsSL https://appcenter-filemanagement-distrib2ede6f06e.azureedge.net/da794613-a450-43af-810e-148a79207c1f/Homerow-0.18.zip?sv=2019-02-02&sr=c&sig=Aa5VwEUaDT6JTHWrXfGXZfwFKDpOCmLtlwA1VbCP65o%3D&se=2023-02-12T09%3A48%3A34Z&sp=r&download_origin=appcenter > ~/temp_setup/Homerow-0.18.zip
	open ~/temp_setup/Homerow-0.18.zip
	mv ~/temp_setup/Homerow.app/ /Applications/Homerow.app/
	open /Applications/Homerow.app/

	open /Applications/Keyboard\ Scroller.app/
	brew install --cask spotify && open /Applications/Spotify.app
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
email_address ?= "${USER}@${orgName}.com"
ssh_gpg_keys:
	echo shortOrgName: '${shortOrgName}'
	echo email address: ${email_address}
	gpg --full-generate-key # RSA 1, 4096, 0, name, email, shortOrgName GitHub GPG key, O <- capital o
	echo "pinentry-program $(which pinentry-mac)" > ~/.gnupg/gpg-agent.conf
	killall gpg-agent
	pkill -9 gpg-agent
	echo "test" | gpg --clearsign 
	ssh-keygen -t ed25519 -C "${email_address}"
	ssh-add -K ~/.ssh/id_ed25519
git_config:	
	git config --global core.editor "code --wait"
	git config --global core.user ${USER}  
	git config --global user.email "${email_address}"
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

	brew install --cask rectangle && open /Applications/Rectangle.app

	brew install --cask whatsapp && open /Applications/WhatsApp.app

	brew install --cask homebrew/cask-drivers/logitech-options && open /Applications/Logi\ Options.app

	brew install --cask slack && open /Applications/Slack.app

	brew install --cask caffeine

	brew install --cask microsoft-teams

	brew install --cask zoom
brew_install_tools:	
	brew install --cask visual-studio-code && open /Applications/Visual\ Studio\ Code.app

	brew install oath-toolkit

	brew install tree

	brew install python@3.10

	brew install poetry

	python3 -m pip install --user --upgrade setuptools

	python3 -m pip install --user --upgrade pip

	brew install the_silver_searcher

	brew install --cask docker

	brew install warrensbox/tap/tfswitch

	tfswitch

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

	brew install chruby

	brew install chruby ruby-install xz

	brew install node

	brew install joedrago/repo/colorist
	
brew_install_media:
	brew install --cask discord

	brew install --cask obs

	brew install --cask plex

	brew install --cask vlc

	brew install --cask viber

	brew install pandoc

	brew install --cask flux

remove_temp_dir:
	rm -rf mkdir ~/temp_setup
