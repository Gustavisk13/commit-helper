#!/bin/bash

#some extra steps if script runs in windows
#first its nedded to create an ~./bashrc file
#then its needeed to export the script to the bashrc and give it an alias

#further implementations
#option if user wants to add specific file or add it all
#option if user wants to push the commit

#alias creation if user uses zsh:
#sed -i '/Example aliases/a\ alias teste=\"echo teste\"' /home/gustavo/.zshrc && source ~/.zshrc

current_user=$(whoami)
current_shell=$(grep'/bin' $SHELL | sed 's/^.*: //')
alias_value=$(cat /home/$current_user/.zshrc | grep "gch=")

create_alias_zsh() {
    sed -i "/Example aliases/a\ alias gch=\"$1\"" /home/$current_user/.zshrc
}

check_alias() {
    echo $current_shell
    if [[ -z "$alias_value" ]]; then
        echo "Alias não encontrado, execute o arquivo com o comando --install e dê source no seu shell!"
        exit 1
    fi
}

validate_flag() {
    local arr_var=($@)

    #first value of array
    local var_value=(${arr_var[0]})

    #removes first value from array
    arr_var=(${arr_var[@]:1})

    for i in ${arr_var[@]}; do

        if [ "$var_value" = "$i" ]; then
            local var_flag=$i
            break
        else
            continue
        fi
    done

    if [[ -n $var_flag ]]; then
        echo "$var_flag"
    else
        exit 1
    fi
}

exports() {
    local_path="$(pwd)/commitHelper.sh"

    if [[ -z "$alias_value" ]]; then
        create_alias_zsh $local_path
        if [ $? -eq 0 ]; then
            echo 'Execute o comando source para finalizar a instalação!!!'
        else
            echo 'Erro no Alias'
        fi
    else
        echo "Alias já existe, pulando instalação..."
    fi
}

help_options(){
    sed -n '/^# Available Commands$/,/^# License$/p' README.md | head -n -1
    exit 0
}

#validates if it haves args
if [ ! "$#" -gt 0 ]; then
    echo "Nao Possui"
    exit 1
fi

if [ "$1" = "--install" ]; then
    exports
elif [ "$1" = "--help" ]; then
    help_options
fi

check_alias

while true; do
    case $1 in
    access)
        option=$1
        emoji=":wheelchair:"
        break
        ;;
    test)
        option=$1
        flag=$(validate_flag $2 -a -t)
        if [ $? -eq 0 ]; then
            if [ "$flag" = "-a" ]; then
                emoji=":white_check_mark:"
            else
                emoji=":test_tube:"
            fi
            break
        else
            echo "Invalid option $2"
            exit 1
        fi

        ;;

    build)
        option=$1
        emoji=":heavy_plus_sign:"
        break
        ;;
    style)
        option=$1
        emoji=":ok_hand:"
        break
        ;;
    anim)
        option=$1
        emoji=":dizzy:"
        break
        ;;
    fix)
        option=$1
        emoji=":bug:"
        break
        ;;
    docs)
        option=$1
        emoji=":bulb:"
        break
        ;;
    init)
        option=$1
        emoji=":tada:"
        break
        ;;
    config)
        option=$1
        emoji=":wrench:"
        break
        ;;
    deploy)
        option=$1
        emoji=":rocket:"
        break
        ;;
    docs)
        option=$1
        emoji=":books:"
        break
        ;;
    progress)
        option=$1
        emoji=":construction:"
        break
        ;;
    ui)
        option=$1
        emoji=":lipstick:"
        break
        ;;
    ci)
        option=$1
        emoji=":bricks:"
        break
        ;;
    todo)
        option=$1
        emoji=":soon:"
        break
        ;;
    move)
        option=$1
        emoji=":truck:"
        break
        ;;
    feat)
        option=$1
        emoji=":sparkles:"
        break
        ;;
    package)
        option=$1
        emoji=":package:"
        break
        ;;
    perf)
        option=$1
        emoji=":zap:"
        break
        ;;
    refactor)
        option=$1
        emoji=":recycle:"
        break
        ;;
    remove)
        option=$1
        flag=$(validate_flag $2 -f -d)
        if [ $? -eq 0 ]; then
            if [ "$flag" = "-f" ]; then
                emoji=":fire:"
            else
                emoji=":heavy_minus_sign:"
            fi
            break
        else
            echo "Invalid option $2"
            exit 1
        fi
        ;;

    resp)
        option=$1
        emoji=":iphone:"
        break
        ;;
    revert)
        option=$1
        emoji=":boom:"
        break
        ;;
    sec)
        option=$1
        emoji=":lock:"
        break
        ;;
    seo)
        option=$1
        emoji=":mag:"
        break
        ;;
    tag)
        option=$1
        emoji=":bookmark:"
        break
        ;;
    approve)
        option=$1
        emoji=":heavy_check_mark:"
        break
        ;;
    text)
        option=$1
        emoji=":pencil:"
        break
        ;;
    type)
        option=$1
        emoji=":label:"
        break
        ;;
    error)
        option=$1
        emoji=":goal_net:"
        break
        ;;
    *)
        echo "Unknown commmand type gc help for more info!"
        exit 1
        ;;

    esac
done

if [ -z "$flag" ]; then
    if [ -z "$2" ]; then
        echo "You must inform an message"
        exit 1
    fi

    if [[ "$2" =~ ^(-[a-zA-Z0-9]*)+$ ]]; then
        echo "Mensagem Inválida: $2"
        exit 1
    fi

    message=$2
    echo "Chosen option: $emoji $option"
    git commit -a -m "$emoji $option: $message"

else
    if [ -z "$3" ]; then
        echo "You must inform an message"
        exit 1
    fi
    message=$3
    echo "Chosen option: $emoji $option $flag"
    git commit -a -m "$emoji $option: $message"
fi
