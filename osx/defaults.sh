# Require password immediately after sleep or screen saver.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool true


# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4


# Set a really fast keyboard repeat rate.
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
