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

check_os() {
    if [[ "$OSTYPE" == "msys" ]]; then
        touch C:\\Users\\$current_user\\.bashrc
        alias_value=$(cat C:\\Users\\$current_user\\.bashrc | grep "gch=")
    else
        alias_value=$(cat /home/$current_user/.zshrc | grep "gch=")
        shell=$(grep "^$USER" /etc/passwd | grep -o zsh)
    fi
}

create_alias() {
    if [[ "$OSTYPE" == "msys" ]]; then

        echo "alias gch=\"$1\"" >>C:\\Users\\$current_user\\.bashrc

    else
        if [[ "$shell" = "zsh" ]]; then
            sed -i "/Example aliases/a\ alias gch=\"$1\"" /home/$current_user/.zshrc
        elif [[ "$shell" = "bash" ]]; then
            sed -i "/bash-doc package/a\ alias gch=\"$1\"" /home/$current_user/.bashrc
        fi
    fi
}

check_alias() {
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
        create_alias $local_path
        if [ $? -eq 0 ]; then
            if [[ "$shell" = "zsh" ]]; then
                echo 'Execute o comando source ~./zshrc para finalizar a instalação!!!'
            else
                echo 'Execute o comando source ~./bashrc para finalizar a instalação!!!'
            fi

        else
            echo 'Erro no Alias'
        fi
    else
        echo "Alias já existe, pulando instalação..."
    fi
}

help_options() {
    sed -n '/^# Available Commands$/,/^# License$/p' README.md | head -n -1
    exit 0
}

#validates if it haves args
if [ ! "$#" -gt 0 ]; then
    echo "Comando não encontrado, execute o comando --help para mais informações."
    exit 1
fi

check_os

if [ "$1" = "--install" ]; then
    exports
    exit 0
elif [ "$1" = "--help" ]; then
    help_options
    exit 0
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
        echo "Comando não encontrado, execute o comando --help para mais informações."
        exit 1
        ;;

    esac
done

if [ -z "$flag" ]; then
    if [ -z "$2" ]; then
        echo "É necessário informar uma mensagem!"
        exit 1
    fi

    if [[ "$2" =~ ^(-[a-zA-Z0-9]*)+$ ]]; then
        echo "Mensagem Inválida: $2"
        exit 1
    fi

    message=$2
    git commit -a -m "$emoji $option: $message"

else
    if [ -z "$3" ]; then
        echo "É necessário informar uma mensagem!"
        exit 1
    fi
    message=$3
    git commit -a -m "$emoji $option: $message"
fi
