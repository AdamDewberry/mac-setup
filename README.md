# Mac Setup

This repo is a quickstart to supercharge your development environment on a Macbook.

It will configure your machine and install many essential tools for collaboration and engineering.

## Fresh installs

If your machine image is new and you don't have any tools like git installed yet, you can either export a zip of this repository to obtain the makefile or run the following commands to copy the makefile to your machine to run via the terminal, which makes calls back to the raw github pages to grab any other components required during the setup process.

    curl https://raw.githubusercontent.com/AdamDewberry/mac-setup/main/makefile >> ~/makefile    
    
### Developer Tools
Mac developer tools is required to run _make_, along with many other operations and tools that you will use day to day. When running make, it will automatically prompt you to install the tool set.

## Productivity apps
The makefile should download, install and open [homerow](https://www.homerow.app/) & [KeyboardScroller](https://github.com/dexterleng/KeyboardScroller.docs); [here's](https://dewberry.dev/engineering/workflow-productivity.html#intermediate) a brief run down on how to use them.

## Remapping keys
Be aware that it will also remap:
- Caps Lock to Left Control
- *§* (x064) to F11 (x044) (which we'll configure to left mouse click)
- Fn (0xFF00000003) to F12 (x045) (which we'll configure to right mouse click)
 
If you do not want this, remove or comment out the section `remap_keys`.

Set the pointer control actions here:

    System Preferences -> Accessibility -> Pointer Control -> Enable alternative pointer actions -> check F11 is set for left mouse click

For reference, [here](https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-KEY_TABLE_USAGES) are the keyboard remapping IDs and this [utility](https://hidutil-generator.netlify.app/) is great at writing the remappings for you.

## zsh
The setup includes writing (or overwriting) the zsh profile found in `~/.zshrc`; this will configure your shell, add a bunch of useful path env vars and aliases. This is optional, remove the line in the makefile if you wish to start afresh.

## Run Mac Setup
To run, navigate to your home directory:

```bash
cd ~
./make -i
```

The flag `-i` will skip on error and continue.

## git preferences
For signing commits, you will need to add the ID of the GPG key generated: this will be on the _pub_ line from:

```bash
gpg --list-keys
```

to configure that key:

```bash
git config --global user.signingkey <your-key>
```

You may need to log into the GitHub CLI again to configure that key against your GitHub account; alternatively do it in the console.


