#!/usr/bin/env bash

# Function to fetch and return model names from 'ollama list'
function __ollama_models {
    local models
    models=''
    if command -v ollama &> /dev/null; then
        models=$(ollama list 2>/dev/null | awk 'NR>1 {print $1}' | tr '\n' ' ')
    fi
    echo "$models"
}

# Main completion function
function __ollama_complete {
    local curr_arg prev_arg
    local commands="serve create show run pull push list cp rm help"
    
    # Get current and previous words
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    prev_arg=${COMP_WORDS[COMP_CWORD-1]}
    
    # If we're completing the first argument (command name)
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands" -- "$curr_arg"))
        return
    fi
    
    # Get the command (first argument)
    local cmd=${COMP_WORDS[1]}
    
    case "$cmd" in
        serve)
            if [[ "$prev_arg" == "--host" ]]; then
                COMPREPLY=()
            elif [[ "$prev_arg" == "--origins" ]]; then
                COMPREPLY=()
            elif [[ "$prev_arg" == "--models" ]]; then
                COMPREPLY=($(compgen -d -- "$curr_arg"))
            elif [[ "$prev_arg" == "--keep-alive" ]]; then
                COMPREPLY=()
            else
                COMPREPLY=($(compgen -W "--host --origins --models --keep-alive" -- "$curr_arg"))
            fi
            ;;
        create)
            if [[ "$prev_arg" == "-f" ]]; then
                COMPREPLY=($(compgen -f -- "$curr_arg"))
            else
                COMPREPLY=($(compgen -W "-f" -- "$curr_arg"))
            fi
            ;;
        show)
            local models=$(__ollama_models)
            if [[ "$prev_arg" == "--license" ]] || [[ "$prev_arg" == "--modelfile" ]] || \
               [[ "$prev_arg" == "--parameters" ]] || [[ "$prev_arg" == "--system" ]] || \
               [[ "$prev_arg" == "--template" ]]; then
                COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            elif [[ "$curr_arg" == -* ]]; then
                COMPREPLY=($(compgen -W "--license --modelfile --parameters --system --template" -- "$curr_arg"))
            else
                COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            fi
            ;;
        run)
            local models=$(__ollama_models)
            if [[ "$prev_arg" == "--format" ]]; then
                COMPREPLY=()
            elif [[ "$curr_arg" == -* ]]; then
                COMPREPLY=($(compgen -W "--format --insecure --nowordwrap --verbose" -- "$curr_arg"))
            else
                # First non-flag should be a model
                local has_model=false
                local i
                for ((i=2; i<COMP_CWORD; i++)); do
                    if [[ "${COMP_WORDS[i]}" != -* ]]; then
                        has_model=true
                        break
                    fi
                done
                if [[ "$has_model" == false ]]; then
                    COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
                else
                    COMPREPLY=()
                fi
            fi
            ;;
        pull|push)
            local models=$(__ollama_models)
            if [[ "$prev_arg" == "--insecure" ]]; then
                COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            elif [[ "$curr_arg" == -* ]]; then
                COMPREPLY=($(compgen -W "--insecure" -- "$curr_arg"))
            else
                COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            fi
            ;;
        list)
            COMPREPLY=()
            ;;
        cp)
            local models=$(__ollama_models)
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            elif [[ ${COMP_CWORD} -eq 3 ]]; then
                COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            else
                COMPREPLY=()
            fi
            ;;
        rm)
            local models=$(__ollama_models)
            COMPREPLY=($(compgen -W "$models" -- "$curr_arg"))
            ;;
        help)
            COMPREPLY=($(compgen -W "$commands" -- "$curr_arg"))
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F __ollama_complete ollama
