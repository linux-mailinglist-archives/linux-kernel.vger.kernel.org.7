Return-Path: <linux-kernel+bounces-803282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9ACB45CF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC13A3BE95E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37837C112;
	Fri,  5 Sep 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YerbpIhY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492C37C10E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087133; cv=none; b=b9E4jO6eE0E7xZRB3mUbFRoYi0vqtIIx8EwmUSMDDA/oO8+H4VKRDIs2sD4Ttcw/wCODCJNEAeT4KQGvVDC8HvMlmq2WHmoYAmaz5S9sOqmXZGjWC2GzMJHyqCrBepXhHVtDvBqRqWv6i88Whko3tHvgKLLa8cvwFdF/xv8J1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087133; c=relaxed/simple;
	bh=dEZ30yEpyTXH9cELTysffe2RAECFFVHHy5JLR3OknLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UibZb+ksUC7BDFypUnkBL0UC0TD/pgzALbNXiOnH3rMCHdf+jm5uso0tuhR2nP/851KUOdc21MjPq/GDI64xg01tffZ9aMkyIJlg3U1AKSRVJ5C1Rx50cV8L5o4uRZ+eIBmcw3al8KblmVxj+66JLgm5xA/35RjD37zMHMpbtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YerbpIhY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757087131; x=1788623131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dEZ30yEpyTXH9cELTysffe2RAECFFVHHy5JLR3OknLc=;
  b=YerbpIhYT7XAUZsl5vd9XCOxInvBUREUfiezHg55DEj3YMsurDTgMQ3e
   9xpLgHTVtU+W59BkMucHVqPWeeYVf+x6sfG232TV95VYmkdYG9IwtFeQO
   UHMbTISbyxHRariiNakUTccq5i3VVzbv6zXAHtqhEQkPX4n7FjmEdfomh
   GoCxSxp0jnA2u6+qu53hkODcceC9aZWadKBbytQHhkuCR1Fwyd8qh19L6
   wHmG6tH8JJEEnlC9yAiNjH7xeV2tSaPM7bbd6FF7/L3rIOV8kKiJ5DxmP
   azuS745Gkwy4aAYQwn7NjjTlqfmLmuZhcobjOpkyhCoZqyG9Q0chaz3Uz
   w==;
X-CSE-ConnectionGUID: XBtPfieIQI28grfuILJF9g==
X-CSE-MsgGUID: YBjtlIgrSOSzAdYyQ1Dz2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70144643"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70144643"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:31 -0700
X-CSE-ConnectionGUID: D4woVm4yTjiFCgPDtXkH9Q==
X-CSE-MsgGUID: HJ2dLsmQSnSXwP3WfqURhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172071760"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:27 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com,
	mika.westerberg@linux.intel.com,
	lucas.demarchi@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v9 4/9] drm/xe/xe_late_bind_fw: Initialize late binding firmware
Date: Fri,  5 Sep 2025 21:19:48 +0530
Message-Id: <20250905154953.3974335-5-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905154953.3974335-1-badal.nilawar@intel.com>
References: <20250905154953.3974335-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Search for late binding firmware binaries and populate the meta data of
firmware structures.

v2 (Daniele):
 - drm_err if firmware size is more than max pay load size
 - s/request_firmware/firmware_request_nowarn/ as firmware will
   not be available for all possible cards
v3 (Daniele):
 - init firmware from within xe_late_bind_init, propagate error
 - switch late_bind_fw to array to handle multiple firmware types
v4 (Daniele):
 - Alloc payload dynamically, fix nits
v6 (Daniele)
 - %s/MAX_PAYLOAD_SIZE/XE_LB_MAX_PAYLOAD_SIZE/

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_late_bind_fw.c       | 100 ++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |  30 +++++++
 2 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 5f386f860728..2a9255e73747 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -5,6 +5,7 @@
 
 #include <linux/component.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 
 #include <drm/drm_managed.h>
 #include <drm/intel/i915_component.h>
@@ -13,6 +14,16 @@
 
 #include "xe_device.h"
 #include "xe_late_bind_fw.h"
+#include "xe_pcode.h"
+#include "xe_pcode_api.h"
+
+static const u32 fw_id_to_type[] = {
+		[XE_LB_FW_FAN_CONTROL] = INTEL_LB_TYPE_FAN_CONTROL,
+	};
+
+static const char * const fw_id_to_name[] = {
+		[XE_LB_FW_FAN_CONTROL] = "fan_control",
+	};
 
 static struct xe_device *
 late_bind_to_xe(struct xe_late_bind *late_bind)
@@ -20,6 +31,89 @@ late_bind_to_xe(struct xe_late_bind *late_bind)
 	return container_of(late_bind, struct xe_device, late_bind);
 }
 
+static int xe_late_bind_fw_num_fans(struct xe_late_bind *late_bind)
+{
+	struct xe_device *xe = late_bind_to_xe(late_bind);
+	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
+	u32 uval;
+
+	if (!xe_pcode_read(root_tile,
+			   PCODE_MBOX(FAN_SPEED_CONTROL, FSC_READ_NUM_FANS, 0), &uval, NULL))
+		return uval;
+	else
+		return 0;
+}
+
+static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
+{
+	struct xe_device *xe = late_bind_to_xe(late_bind);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct xe_late_bind_fw *lb_fw;
+	const struct firmware *fw;
+	u32 num_fans;
+	int ret;
+
+	if (fw_id >= XE_LB_FW_MAX_ID)
+		return -EINVAL;
+
+	lb_fw = &late_bind->late_bind_fw[fw_id];
+
+	lb_fw->id = fw_id;
+	lb_fw->type = fw_id_to_type[lb_fw->id];
+	lb_fw->flags &= ~INTEL_LB_FLAG_IS_PERSISTENT;
+
+	if (lb_fw->type == INTEL_LB_TYPE_FAN_CONTROL) {
+		num_fans = xe_late_bind_fw_num_fans(late_bind);
+		drm_dbg(&xe->drm, "Number of Fans: %d\n", num_fans);
+		if (!num_fans)
+			return 0;
+	}
+
+	snprintf(lb_fw->blob_path, sizeof(lb_fw->blob_path), "xe/%s_8086_%04x_%04x_%04x.bin",
+		 fw_id_to_name[lb_fw->id], pdev->device,
+		 pdev->subsystem_vendor, pdev->subsystem_device);
+
+	drm_dbg(&xe->drm, "Request late binding firmware %s\n", lb_fw->blob_path);
+	ret = firmware_request_nowarn(&fw, lb_fw->blob_path, xe->drm.dev);
+	if (ret) {
+		drm_dbg(&xe->drm, "%s late binding fw not available for current device",
+			fw_id_to_name[lb_fw->id]);
+		return 0;
+	}
+
+	if (fw->size > XE_LB_MAX_PAYLOAD_SIZE) {
+		drm_err(&xe->drm, "Firmware %s size %zu is larger than max pay load size %u\n",
+			lb_fw->blob_path, fw->size, XE_LB_MAX_PAYLOAD_SIZE);
+		release_firmware(fw);
+		return -ENODATA;
+	}
+
+	lb_fw->payload_size = fw->size;
+	lb_fw->payload = drmm_kzalloc(&xe->drm, lb_fw->payload_size, GFP_KERNEL);
+	if (!lb_fw->payload) {
+		release_firmware(fw);
+		return -ENOMEM;
+	}
+
+	memcpy((void *)lb_fw->payload, fw->data, lb_fw->payload_size);
+	release_firmware(fw);
+
+	return 0;
+}
+
+static int xe_late_bind_fw_init(struct xe_late_bind *late_bind)
+{
+	int ret;
+	int fw_id;
+
+	for (fw_id = 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
+		ret = __xe_late_bind_fw_init(late_bind, fw_id);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int xe_late_bind_component_bind(struct device *xe_kdev,
 				       struct device *mei_kdev, void *data)
 {
@@ -80,5 +174,9 @@ int xe_late_bind_init(struct xe_late_bind *late_bind)
 		return err;
 	}
 
-	return devm_add_action_or_reset(xe->drm.dev, xe_late_bind_remove, late_bind);
+	err = devm_add_action_or_reset(xe->drm.dev, xe_late_bind_remove, late_bind);
+	if (err)
+		return err;
+
+	return xe_late_bind_fw_init(late_bind);
 }
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
index f79e5aefed94..c4a8042f2600 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
@@ -10,6 +10,34 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#define XE_LB_MAX_PAYLOAD_SIZE SZ_4K
+
+/**
+ * xe_late_bind_fw_id - enum to determine late binding fw index
+ */
+enum xe_late_bind_fw_id {
+	XE_LB_FW_FAN_CONTROL = 0,
+	XE_LB_FW_MAX_ID
+};
+
+/**
+ * struct xe_late_bind_fw
+ */
+struct xe_late_bind_fw {
+	/** @id: firmware index */
+	u32 id;
+	/** @blob_path: firmware binary path */
+	char blob_path[PATH_MAX];
+	/** @type: firmware type */
+	u32  type;
+	/** @flags: firmware flags */
+	u32  flags;
+	/** @payload: to store the late binding blob */
+	const u8  *payload;
+	/** @payload_size: late binding blob payload_size */
+	size_t payload_size;
+};
+
 /**
  * struct xe_late_bind_component - Late Binding services component
  * @mei_dev: device that provide Late Binding service.
@@ -28,6 +56,8 @@ struct xe_late_bind_component {
 struct xe_late_bind {
 	/** @component: struct for communication with mei component */
 	struct xe_late_bind_component component;
+	/** @late_bind_fw: late binding firmware array */
+	struct xe_late_bind_fw late_bind_fw[XE_LB_FW_MAX_ID];
 };
 
 #endif
-- 
2.34.1


