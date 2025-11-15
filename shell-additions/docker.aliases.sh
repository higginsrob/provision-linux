#!/usr/bin/env bash

alias d="docker"

alias db="docker build"

alias de="docker exec -it"

alias di="docker images"
alias drmi="docker rmi"
alias drmia='docker rmi $(docker images -q)'
alias dip='docker images prune'

alias dm="docker model"
alias dml="docker model list"
alias dmp="docker model pull"
alias dmr="docker model run"
alias dms="docker model serve"

alias dn="docker network"
alias dns="docker network ls"

alias dsp="docker system prune -f"

alias ds='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias dsa='docker ps -a --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

alias dv="docker volume"
alias dvs="docker volume ls"
alias dvp="docker volume prune"

alias dc="docker compose"
alias dcb="docker compose build"
alias dcd="docker compose down"
alias dcdv="docker compose down --volumes"
alias dce="docker compose exec"
alias dcl="docker compose logs"
alias dcu="docker compose up -d"
alias dcw="docker compose watch"
