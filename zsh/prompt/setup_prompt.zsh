# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)


prompt_git_branch() {
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    zstyle ':vcs_info:git:*' formats '%b'
}

prompt_git_info() {
    [ ! -z "$vcs_info_msg_0_" ] && echo "$ZSH_THEME_GIT_PROMPT_PREFIX%F{red}$vcs_info_msg_0_%f$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


prompt_alex_setup() {
	# prevent percentage showing up
	# if output doesn't end with a newline
	export PROMPT_EOL_MARK=''

	prompt_opts=(cr subst percent)

	autoload -Uz vcs_info

	# show username@host if logged in through SSH
	[[ "$SSH_CONNECTION" != '' ]] && prompt_purity_username='%n@%m '

    ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}git:(%f"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue})%f "

    prompt_git_branch
	# prompt turns red if the previous command didn't exit with 0
	PROMPT='%B%F{cyan}%c $(prompt_git_info)%b%(?.%F{yellow}%B.%F{red})✗%f%(?.%b.) '
	RPROMPT='%F{red}%(?..⏎)%f'
}

prompt_alex_setup
