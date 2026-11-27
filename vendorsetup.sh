#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

add_lunch_combo omni_Z35-eng
add_lunch_combo omni_Z35-userdebug

# ---------------------------------------------------------------------------
# OrangeFox build options for Symphony Z35
# ---------------------------------------------------------------------------
FDEVICE="Z35"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true

    # Screen is 720x1640
    export OF_SCREEN_H=1640

    # Partition paths (system/vendor are logical, inside super)
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"
    export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/bootdevice/by-name/recovery"
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

    # Recovery features
    export FOX_VERSION="R11.1"
    export FOX_VARIANT=Symphony
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export OF_USE_TWRP_SAR_DETECT=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export FOX_ENABLE_APP_MANAGER=1
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_NANO_EDITOR=1

    # Work around MTP glitches after formatting /data
    export OF_RUN_POST_FORMAT_PROCESS=1

    # Do not patch a still-encrypted device
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1

    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi
