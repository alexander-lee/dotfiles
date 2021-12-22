#!/bin/bash

apps=(
    iterm2
    dropbox
    slack
    google-chrome
    visual-studio-code
    spectacle
    alfred
    spotify
    discord
    steam
    insomnia
    zoom
    ngrok
)

brew install --cask "${apps[@]}"

