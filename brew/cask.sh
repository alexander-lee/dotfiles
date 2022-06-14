#!/bin/bash

apps=(
    alfred
    discord
    dropbox
    docker
    figma
    flux
    google-chrome
    google-drive
    insomnia
    iterm2
    ngrok
    slack
    spectacle
    spotify
    steam
    visual-studio-code
    zoom
)

brew install --cask "${apps[@]}"

