# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$HOME/.local/bin:$PATH"

# Set nvim as default editor

export EDITOR="nvim"
export VISUAL="nvim"

# Pacman aliases

p() {
    pacman "$@"
}

sp() {
    sudo pacman "$@"
}

# "You shall not pass" Kitty wrapper
sudo() {
    local REAL_SUDO="/usr/bin/sudo"
    local GIF="$HOME/.memes/gandalf.gif"
    local show_gif=false

    "$REAL_SUDO" "$@"
    local status=$?

    if [ $status -ne 0 ]; then
        if command -v kitty >/dev/null 2>&1 \
           && [ -n "$KITTY_WINDOW_ID" ] \
           && kitty +kitten icat --help >/dev/null 2>&1; then
            show_gif=true
        fi

        if $show_gif; then
            kitty +kitten icat --align center "$GIF" 2>/dev/null || true
        else
            echo "Gandalf disapproves! ($GIF)"
        fi
    fi

    return $status
}

# Yazi "y" auto-cd/alias

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# make khard stop displaying Python errors

alias khard='PYTHONWARNINGS=ignore khard'

# open email with correct accounts.conf path

alias mail='aerc -A ~/.email'

# open rss reader with correct urls path

alias news='newsboat -u ~/.rss'

# message for tty first login

welcome_message() {
    local text="Greetings."
    local delay=0.05

    printf "\n"

    for (( i=0; i<${#text}; i++ )); do
        printf "%s" "${text:$i:1}"
        sleep "$delay"
    done

    printf "\n\n"
}

shopt -q login_shell && welcome_message

# starship

if [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
    export STARSHIP_CONFIG="$HOME/.config/starship.toml"
else
    export STARSHIP_CONFIG="$HOME/.config/starship-tty.toml"
fi

eval "$(starship init bash)"

# pywal

(cat ~/.cache/wal/sequences &)
