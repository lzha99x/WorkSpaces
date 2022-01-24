#!/usr/bin/env bash


# 获取脚本路经
SHELL_PATH=$(dirname "$0")
SHELL_NAME=$(basename "$0")

# shellcheck disable=SC1091
source "$SHELL_PATH"/hawaii.sh

PS3='Please enter your choice: '
options=(
    "hawaii"
    "aruba"
    "cyprus"
    "fijisc"
    "malta"
    "malta_lite"
    "Quit"
)
echo "$PS3"
select opt in "${options[@]}"; do
    case $opt in
    "hawaii")
        echo "you chose choice hawaii"
        hawaii
        break
        ;;
    "aruba")
        echo "you chose choice $REPLY which is $opt"
        ;;
    "cyprus")
        echo "you chose choice $REPLY which is $opt"
        ;;
    "fijisc")
        echo "you chose choice $REPLY which is $opt"
        ;;
    "malta")
        echo "you chose choice $REPLY which is $opt"
        ;;
    "malta_lite")
        echo "you chose choice $REPLY which is $opt"
        ;;
    "Quit")
        break
        ;;
    *) echo "invalid option $REPLY" ;;
    esac
done
