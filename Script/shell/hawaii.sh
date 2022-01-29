#!/usr/bin/env bash

HAWAII_HOME="/home/zl/work/source/hawaii"
ENVSETUP_FILE="build/envsetup.sh"
LOG_HOME="log"
BUILD_TYPE="userdebug"

function make_compile() {
    echo "/*****make compile******/"
    echo ${HAWAII_HOME}/${LOG_HOME}/"${THIS_BUILD_COMPILE_TARGET}"-"${BUILD_TYPE}"-gms_"$(date +%Y%m%d_%H%M)"

    cp vendor/sprd/release/IDH/"${THIS_BUILD_COMPILE_TARGET}"-"${BUILD_TYPE}"-gms/* . -avf
    time make -j 16 2>&1 | tee -a ${HAWAII_HOME}/${LOG_HOME}/"${THIS_BUILD_COMPILE_TARGET}"-"${BUILD_TYPE}"-gms_"$(date +%Y%m%d_%H%M)".log
}

function make_source() {
    echo "/*****make source******/"

    if [ -e "$HAWAII_HOME/$ENVSETUP_FILE" ]; then
        # shellcheck disable=SC1090
        source "$HAWAII_HOME/$ENVSETUP_FILE"
        # source "${ENVSETUP_FILE}"
        lunch "${THIS_BUILD_COMPILE_TARGET}"-"${BUILD_TYPE}"-gms
    else
        echo "$ENVSETUP_FILE  not found"
    fi
}

function make_mmm() {
    echo "/*****make mmm******/"

    make_source
    mmm "$1"
    # echo "$1"
}

function make_pac() {
    echo "pac"
    time cp_sign 2>&1 | tee -a ${HAWAII_HOME}/log/cp_sign_"$(date +%Y%m%d_%H%M)".log
    time makepac 2>&1 | tee -a ${HAWAII_HOME}/log/makepac_"$(date +%Y%m%d_%H%M)".log
}

function hawaii() {
    echo "/********hawaii********/"

    cd $HAWAII_HOME || {
        echo "cd $HAWAII_HOME Failure"
        exit 1
    }

    if [ ! -d $LOG_HOME ]; then
        mkdir -p $LOG_HOME
    fi

    options=(
        "ums9230_4h10_Natv_nv"
        "ums9230_4h10_Natv_nv and pac"
        "mmm"
        "Quit"
    )
    select opt in "${options[@]}"; do
        case $opt in
        "ums9230_4h10_Natv_nv")
            THIS_BUILD_COMPILE_TARGET=ums9230_4h10_Natv_nv
            make_source
            make_compile
            break
            ;;
        "ums9230_4h10_Natv_nv and pac")
            echo "ums9230_4h10_Natv_nv and pac"
            THIS_BUILD_COMPILE_TARGET=ums9230_4h10_Natv_nv
            make_source
            make_compile
            make_pac
            break
            ;;
        "mmm")
            echo "you chose choice $REPLY which is $opt"
            THIS_BUILD_COMPILE_TARGET=ums9230_4h10_Natv_nv
            make_mmm "$@"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY" ;;
        esac
    done
}

# For test
# hawaii 1
