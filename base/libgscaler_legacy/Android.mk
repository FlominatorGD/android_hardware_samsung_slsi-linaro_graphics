# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false
LOCAL_SHARED_LIBRARIES := liblog libutils libcutils libexynosscaler libexynosutils libexynosv4l2
LOCAL_HEADER_LIBRARIES := libcutils_headers libsystem_headers libhardware_headers libexynos_headers

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include

LOCAL_EXPORT_SHARED_LIBRARY_HEADERS += libexynosscaler

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include \
                 $(TOP)/hardware/samsung_slsi-linaro/exynos5/include \
	         $(TOP)/hardware/samsung_slsi-linaro/exynos/libexynosutils \
	         $(TOP)/hardware/samsung_slsi-linaro/graphics/base/libmpp

ifeq ($(filter 3.10, $(TARGET_LINUX_KERNEL_VERSION)), 3.10)
LOCAL_C_INCLUDES += $(TOP)/hardware/samsung_slsi-linaro/exynos/kernel-3.10-headers
else
ifeq ($(filter 3.18, $(TARGET_LINUX_KERNEL_VERSION)), 3.18)
LOCAL_C_INCLUDES += $(TOP)/hardware/samsung_slsi-linaro/exynos/kernel-3.18-headers
else
ifeq ($(filter 4.4, $(TARGET_LINUX_KERNEL_VERSION)), 4.4)
LOCAL_C_INCLUDES += $(TOP)/hardware/samsung_slsi-linaro/exynos/kernel-4.4-headers
else
LOCAL_C_INCLUDES += $(TOP)/hardware/samsung_slsi-linaro/exynos/kernel-3.4-headers
endif
endif
endif

LOCAL_SRC_FILES := \
	libgscaler_obj.cpp \
	libgscaler.cpp \
	exynos_subdev.c

LOCAL_CFLAGS += -Wno-unused-function

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libexynosgscaler

ifeq ($(BOARD_USES_VENDORIMAGE), true)
    LOCAL_PROPRIETARY_MODULE := true
endif

include $(BUILD_SHARED_LIBRARY)
