# Load vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats '%b'
zstyle ':vcs_info:git*' actionformats '%b|%a'

# Function to get git status color and symbol
function git_prompt_info() {
    local branch
    local git_status
    local status_color
    local status_symbol
    
    if ! command -v git &> /dev/null; then
        return
    fi
    
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -z "$branch" ]]; then
        return
    fi
    
    git_status=$(git status --porcelain 2>/dev/null)
    
    # Check if there are uncommitted changes
    if [[ -n "$git_status" ]]; then
        status_color='%F{red}'
        status_symbol=' ✗'
    else
        # Check if branch is ahead or behind
        local ahead_behind=$(git rev-list --left-right --count origin/${branch}...HEAD 2>/dev/null)
        local ahead=$(echo $ahead_behind | cut -d$'\t' -f2)
        local behind=$(echo $ahead_behind | cut -d$'\t' -f1)
        
        if [[ -n "$ahead_behind" ]] && ([[ "$ahead" != "0" ]] || [[ "$behind" != "0" ]]); then
            status_color='%F{yellow}'
            status_symbol=''
        else
            status_color='%F{green}'
            status_symbol=''
        fi
    fi
    
    echo "%F{blue}git:(%f${status_color}${branch}%f%F{blue})%f${status_symbol}"
}

# Function to set prompt
function precmd_prompt() {
    vcs_info
    local git_info=$(git_prompt_info)
    local dir_name=$(basename "$(pwd)")
    
    if [[ -n "$git_info" ]]; then
        PROMPT="%B%F{cyan}${dir_name}%f ${git_info} %F{magenta}➜%f%b  "
    else
        PROMPT="%B%F{cyan}${dir_name}%f %F{magenta}➜%f%b  "
    fi
}

# Add the function to precmd_functions
precmd_functions+=(precmd_prompt)