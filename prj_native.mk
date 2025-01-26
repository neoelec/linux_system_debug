# SPDX-License-Identifier: GPL-2.0+
# Copyright (c) 2024 YOUNGJIN JOO (neoelec@gmail.com)

PRJ_NATIVE_MK_FILE	:= $(realpath $(lastword $(MAKEFILE_LIST)))
PRJ_NATIVE_MK_DIR	:= $(shell dirname $(PRJ_NATIVE_MK_FILE))

EHDD00_MK_RACCOON_DIR	:= $(HOME)/eHDD00/08.PROJECT/mk-raccoon
IHDD00_MK_RACCOON_DIR	:= $(HOME)/iHDD00/08.PROJECT/mk-raccoon
LOCAL_MK_RACCOON_DIR	:= $(PRJ_NATIVE_MK_DIR)/mk-raccoon

MK_RACCOON_DIR		:= $(shell \
if [ -d $(LOCAL_MK_RACCOON_DIR) ]; then \
    echo "$(LOCAL_MK_RACCOON_DIR)"; \
elif [ -d $(IHDD00_MK_RACCOON_DIR) ]; then \
    echo "$(IHDD00_MK_RACCOON_DIR)"; \
else \
    echo "$(EHDD00_MK_RACCOON_DIR)"; \
fi)

OPT			:= 0
AS_MK			:= $(MK_RACCOON_DIR)/mk/as_nasm.mk

include $(MK_RACCOON_DIR)/gcc_native.mk
