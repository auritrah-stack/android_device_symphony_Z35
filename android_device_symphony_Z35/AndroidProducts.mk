#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_Z35.mk \
    $(LOCAL_DIR)/omni_Z35.mk

COMMON_LUNCH_CHOICES := \
    twrp_Z35-eng \
    twrp_Z35-userdebug \
    omni_Z35-eng \
    omni_Z35-userdebug
