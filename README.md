# Introduction

This is a simple utility to setup OhMyZsh terminal with fonts and plugins like the following:

- Git
- Zsh-AutoSuggestions
- Docker & Docker-Compose
- Percol
- Web-Search
- Dirhistory

It will also install the font `MesloLGS NF Regular` and other nerd fonts which is required by the terminal.
Make sure after using this script to edit your Terminal font to use it, otherwise things would look a bit funny.

## Running this utility

Simply do the following (make sure to follow any prompts):

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/shy2net/setup-my-terminals/master/linux.sh)"
```

## Pre-requisites

This utility requires the following tools installed:

- Git
- Zsh
- Python 2.x with Pip installed (required for Percol, Python 3 should work as well)


### Installation commands for debian based Linux

```bash
# Run these under root
sudo apt install git zsh python2
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
python2 get-pip.py
```