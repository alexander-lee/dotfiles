#!/bin/bash

apps=(
    alfred
    anaconda
    discord
    docker
    docker-desktop
    figma
    flux
    flux-app
    google-chrome
    google-drive
    insomnia
    iterm2
    ngrok
    slack
    spotify
    steam
    visual-studio-code
    zoom
)

brew install --cask "${apps[@]}"
