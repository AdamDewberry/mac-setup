# Mac Setup

This repo is a quickstart to supercharge your development environment on a Macbook.

It will config your machine and install many of the essential tools you need to collaborate and engineer.

Be aware that it will also remap Caps Lock to Control; if you do not want this, remove or comment out the section `remap_keys`.

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