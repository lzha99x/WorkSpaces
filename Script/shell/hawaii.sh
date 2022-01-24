#!/usr/bin/env bash

HAWAII_HOME="/home/zl/work/source/hawaii"
function hawaii() {
    echo "/********hawaii********/"
    cd $HAWAII_HOME || {
        echo "cd $HAWAII_HOME Failure"
        exit 1
    }

    options=("ums9230_4h10_Natv_nv")
    select opt in "${options[@]}"; do
        case $opt in
        "ums9230_4h10_Natv_nv")
            THIS_BUILD_COMPILE_TARGET=ums9230_4h10_Natv_nv
            break
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY" ;;
        esac
    done

    echo $THIS_BUILD_COMPILE_TARGET
    # shellcheck disable=SC1091
    source build/envsetup.sh
    lunch ${THIS_BUILD_COMPILE_TARGET}-userdebug-gms
    cp vendor/sprd/release/IDH/${THIS_BUILD_COMPILE_TARGET}-userdebug-gms/* . -avf
    time make -j 16 2>&1 | tee -a ${HAWAII_HOME}/log/${THIS_BUILD_COMPILE_TARGET}-userdebug-gms_"$(date +%Y%m%d_%H%M)".log
}
