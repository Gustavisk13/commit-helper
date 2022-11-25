#!/bin/bash

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

#validates if it haves args
if [ "$#" -gt 0 ]; then
    echo "Possui"
else
    #implement default stdout message
    echo "Nao Possui"
    exit 1
fi

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
            break
        else
            echo "Invalid option $2"
            exit 1
        fi

        if [ "$flag" = "-a" ]; then
            emoji=":white_check_mark:"
        else
            emoji=":test_tube:"
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
            break
        else
            echo "Invalid option $2"
            exit 1
        fi

        if [ "$flag" = "-f" ]; then
            emoji=":fire:"
        else
            emoji=":heavy_minus_sign:"
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
    echo "Chosen option: $emoji $option"
else
    echo "Chosen option: $emoji $option $flag"
fi
