# Mac Setup

This repo is a quickstart to supercharge your development environment on a Macbook.

It will configure your machine and install many essential tools for collaboration and engineering.

Be aware that it will also remap Caps Lock to Control; if you do not want this, remove or comment out the section `remap_keys`.

It will also remap *§* (x064) to F11 (x044), which can then be set to a left mouse click via:

    System Preferences -> Accessibility -> Pointer Control -> Enable alternative pointer actions -> check F11 is set for left mouse click

The setup includes writing (or overwriting) the zsh profile found in `~/.zshrc`; this will configure your shell, add a bunch of useful path env vars and aliases. This is optional, remove the line in the makefile if you wish to start afresh.

To run:

```bash
./make -i
```

The flag `-i` will skip on error and continue.

For signing commits, you will need to add the ID of the GPG key generated: this will be on the _pub_ line from:

```bash
gpg --list-keys
```

to configure that key:

```bash
git config --global user.signingkey <your-key>
```

You may need to log into the GitHub CLI again to configure that key against your GitHub account; alternatively do it in the console.

## Productivity apps
The makefile should download, install and open [homerow](https://www.homerow.app/) & [KeyboardScroller](https://github.com/dexterleng/KeyboardScroller.docs); [here's](https://dewberry.dev/engineering/workflow-productivity.html#intermediate) a brief run down on how to use them.

