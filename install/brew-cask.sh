#!/bin/bash

# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages
apps=(
    dropbox
    spectacle
    flux
    iterm2
    atom
    firefox
    google-chrome
    google-chrome-canary
    malwarebytes-anti-malware
    screenflow
    spotify
    skype
    slack
    transmit
    ngrok
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
