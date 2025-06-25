Return-Path: <linux-kernel+bounces-703061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E6AE8B02
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1044A3A2725
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D92E2EF7;
	Wed, 25 Jun 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A04Bd6qa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3A2E4277
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870616; cv=none; b=oHHI2pVZlFG3Sm6r9rUqSHall6c93URI/XF1RI1t5c+3Qoaga9oLJuq+ht3VcfkxsdtYzE1Kcni4ZTmUkOE6rfRA2ndUT3HoWUSLrNq7DDb9CU79hpaagZJUPsObgyZjIV/LS19hExU/8iTx72uNoqgo2Gu8dOtZ4/UqQlJbc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870616; c=relaxed/simple;
	bh=AiSI8AVc1MXjINywV8uTfK1b5aynNgH+KC95fVu8pdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTKHacct+X8PifAuNLeY1TOElSR1pwq5qvgGXx54CltI7HTKT9tSa3Qs2CgXBMjFxEHM7e9V/mrPgdVRyvgmRrwusBcQC9lFtsuhwl60nMsLOuUwC4LEIipUasMRqiKBxrHwYW8EbSExM10uYnCTktoolYio0eJxXAv4neghzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A04Bd6qa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750870614; x=1782406614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiSI8AVc1MXjINywV8uTfK1b5aynNgH+KC95fVu8pdM=;
  b=A04Bd6qahlYFXtFDLRQjSecvba0q3iiu3Ymv8MU6ExpBQrG8IfTGDiEe
   C0nvVlWhEbCjpAMb1vkOnE8IWgTPKSoZ0wnuS0vsoISbwsatfdcEXWCC0
   PRqKf2ASStCFwfhVBeGwBaP0XWj5Fx1RIEUjhc8UZWA59TEuIvwsEsSIR
   gnp1Jtwh4idn0LFhEilHSbw4wzGS5bGcsg56fOsPYn7tFSd3T/NoDPLi0
   fLKEQOa8HfnILc7piVCxfh8NpOu1rEh1zOtQaihFspj60PReJXRUokEmb
   5R6lvE/0YJr8RI+GZapR9LejPlC1OeEwWJVKPB0FsikE4hzEljEJKTKJ7
   w==;
X-CSE-ConnectionGUID: p/4//AqxRSukgfabYxZ8rw==
X-CSE-MsgGUID: INFdYdLJTl6N4ybls9lJrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53214446"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53214446"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:56:54 -0700
X-CSE-ConnectionGUID: sCIa9UlHRCugN+fuxQzlXQ==
X-CSE-MsgGUID: rAowFTfHREeEulha8LroDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="151696680"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:56:51 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v4 05/10] drm/xe/xe_late_bind_fw: Load late binding firmware
Date: Wed, 25 Jun 2025 22:30:10 +0530
Message-Id: <20250625170015.33912-6-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625170015.33912-1-badal.nilawar@intel.com>
References: <20250625170015.33912-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Load late binding firmware

v2:
 - s/EAGAIN/EBUSY/
 - Flush worker in suspend and driver unload (Daniele)
v3:
 - Use retry interval of 6s, in steps of 200ms, to allow
   other OS components release MEI CL handle (Sasha)
v4:
 - return -ENODEV if component not added (Daniele)
 - parse and print status returned by csc
 - Use xe_pm_get_if_in_active (Daniele)

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/xe_late_bind_fw.c       | 149 ++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_late_bind_fw.h       |   1 +
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |   7 +
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 32d1436e7191..52243063d98a 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -16,6 +16,20 @@
 #include "xe_late_bind_fw.h"
 #include "xe_pcode.h"
 #include "xe_pcode_api.h"
+#include "xe_pm.h"
+
+/*
+ * The component should load quite quickly in most cases, but it could take
+ * a bit. Using a very big timeout just to cover the worst case scenario
+ */
+#define LB_INIT_TIMEOUT_MS 20000
+
+/*
+ * Retry interval set to 6 seconds, in steps of 200 ms, to allow time for
+ * other OS components to release the MEI CL handle
+ */
+#define LB_FW_LOAD_RETRY_MAXCOUNT 30
+#define LB_FW_LOAD_RETRY_PAUSE_MS 200
 
 static const u32 fw_id_to_type[] = {
 		[XE_LB_FW_FAN_CONTROL] = CSC_LATE_BINDING_TYPE_FAN_CONTROL,
@@ -31,6 +45,30 @@ late_bind_to_xe(struct xe_late_bind *late_bind)
 	return container_of(late_bind, struct xe_device, late_bind);
 }
 
+static const char *xe_late_bind_parse_status(uint32_t status)
+{
+	switch (status) {
+	case CSC_LATE_BINDING_STATUS_SUCCESS:
+		return "success";
+	case CSC_LATE_BINDING_STATUS_4ID_MISMATCH:
+		return "4Id Mismatch";
+	case CSC_LATE_BINDING_STATUS_ARB_FAILURE:
+		return "ARB Failure";
+	case CSC_LATE_BINDING_STATUS_GENERAL_ERROR:
+		return "General Error";
+	case CSC_LATE_BINDING_STATUS_INVALID_PARAMS:
+		return "Invalid Params";
+	case CSC_LATE_BINDING_STATUS_INVALID_SIGNATURE:
+		return "Invalid Signature";
+	case CSC_LATE_BINDING_STATUS_INVALID_PAYLOAD:
+		return "Invalid Payload";
+	case CSC_LATE_BINDING_STATUS_TIMEOUT:
+		return "Timeout";
+	default:
+		return "Unknown error";
+	}
+}
+
 static int xe_late_bind_fw_num_fans(struct xe_late_bind *late_bind)
 {
 	struct xe_device *xe = late_bind_to_xe(late_bind);
@@ -44,6 +82,93 @@ static int xe_late_bind_fw_num_fans(struct xe_late_bind *late_bind)
 		return 0;
 }
 
+static void xe_late_bind_wait_for_worker_completion(struct xe_late_bind *late_bind)
+{
+	struct xe_device *xe = late_bind_to_xe(late_bind);
+	struct xe_late_bind_fw *lbfw;
+	int fw_id;
+
+	for (fw_id = 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
+		lbfw = &late_bind->late_bind_fw[fw_id];
+		if (lbfw->valid && late_bind->wq) {
+			drm_dbg(&xe->drm, "Flush work: load %s firmware\n",
+				fw_id_to_name[lbfw->id]);
+			flush_work(&lbfw->work);
+		}
+	}
+}
+
+static void xe_late_bind_work(struct work_struct *work)
+{
+	struct xe_late_bind_fw *lbfw = container_of(work, struct xe_late_bind_fw, work);
+	struct xe_late_bind *late_bind = container_of(lbfw, struct xe_late_bind,
+						      late_bind_fw[lbfw->id]);
+	struct xe_device *xe = late_bind_to_xe(late_bind);
+	int retry = LB_FW_LOAD_RETRY_MAXCOUNT;
+	int ret;
+	int slept;
+
+	/* we can queue this before the component is bound */
+	for (slept = 0; slept < LB_INIT_TIMEOUT_MS; slept += 100) {
+		if (late_bind->component.ops)
+			break;
+		msleep(100);
+	}
+
+	if (!xe_pm_runtime_get_if_active(xe))
+		return;
+
+	mutex_lock(&late_bind->mutex);
+
+	if (!late_bind->component.ops) {
+		drm_err(&xe->drm, "Late bind component not bound\n");
+		goto out;
+	}
+
+	drm_dbg(&xe->drm, "Load %s firmware\n", fw_id_to_name[lbfw->id]);
+
+	do {
+		ret = late_bind->component.ops->push_config(late_bind->component.mei_dev,
+							    lbfw->type, lbfw->flags,
+							    lbfw->payload, lbfw->payload_size);
+		if (!ret)
+			break;
+		msleep(LB_FW_LOAD_RETRY_PAUSE_MS);
+	} while (--retry && ret == -EBUSY);
+
+	if (!ret) {
+		drm_dbg(&xe->drm, "Load %s firmware successful\n",
+			fw_id_to_name[lbfw->id]);
+		goto out;
+	}
+
+	if (ret > 0)
+		drm_err(&xe->drm, "Load %s firmware failed with err %d, %s\n",
+			fw_id_to_name[lbfw->id], ret, xe_late_bind_parse_status(ret));
+	else
+		drm_err(&xe->drm, "Load %s firmware failed with err %d",
+			fw_id_to_name[lbfw->id], ret);
+out:
+	mutex_unlock(&late_bind->mutex);
+	xe_pm_runtime_put(xe);
+}
+
+int xe_late_bind_fw_load(struct xe_late_bind *late_bind)
+{
+	struct xe_late_bind_fw *lbfw;
+	int fw_id;
+
+	if (!late_bind->component_added)
+		return -ENODEV;
+
+	for (fw_id = 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
+		lbfw = &late_bind->late_bind_fw[fw_id];
+		if (lbfw->valid)
+			queue_work(late_bind->wq, &lbfw->work);
+	}
+	return 0;
+}
+
 static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
 {
 	struct xe_device *xe = late_bind_to_xe(late_bind);
@@ -99,6 +224,7 @@ static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
 
 	memcpy(lb_fw->payload, fw->data, lb_fw->payload_size);
 	release_firmware(fw);
+	INIT_WORK(&lb_fw->work, xe_late_bind_work);
 	lb_fw->valid = true;
 
 	return 0;
@@ -109,11 +235,16 @@ static int xe_late_bind_fw_init(struct xe_late_bind *late_bind)
 	int ret;
 	int fw_id;
 
+	late_bind->wq = alloc_ordered_workqueue("late-bind-ordered-wq", 0);
+	if (!late_bind->wq)
+		return -ENOMEM;
+
 	for (fw_id = 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
 		ret = __xe_late_bind_fw_init(late_bind, fw_id);
 		if (ret)
 			return ret;
 	}
+
 	return 0;
 }
 
@@ -137,6 +268,8 @@ static void xe_late_bind_component_unbind(struct device *xe_kdev,
 	struct xe_device *xe = kdev_to_xe_device(xe_kdev);
 	struct xe_late_bind *late_bind = &xe->late_bind;
 
+	xe_late_bind_wait_for_worker_completion(late_bind);
+
 	mutex_lock(&late_bind->mutex);
 	late_bind->component.ops = NULL;
 	mutex_unlock(&late_bind->mutex);
@@ -152,7 +285,15 @@ static void xe_late_bind_remove(void *arg)
 	struct xe_late_bind *late_bind = arg;
 	struct xe_device *xe = late_bind_to_xe(late_bind);
 
+	xe_late_bind_wait_for_worker_completion(late_bind);
+
+	late_bind->component_added = false;
+
 	component_del(xe->drm.dev, &xe_late_bind_component_ops);
+	if (late_bind->wq) {
+		destroy_workqueue(late_bind->wq);
+		late_bind->wq = NULL;
+	}
 	mutex_destroy(&late_bind->mutex);
 }
 
@@ -183,9 +324,15 @@ int xe_late_bind_init(struct xe_late_bind *late_bind)
 		return err;
 	}
 
+	late_bind->component_added = true;
+
 	err = devm_add_action_or_reset(xe->drm.dev, xe_late_bind_remove, late_bind);
 	if (err)
 		return err;
 
-	return xe_late_bind_fw_init(late_bind);
+	err = xe_late_bind_fw_init(late_bind);
+	if (err)
+		return err;
+
+	return xe_late_bind_fw_load(late_bind);
 }
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.h b/drivers/gpu/drm/xe/xe_late_bind_fw.h
index 4c73571c3e62..28d56ed2bfdc 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.h
@@ -11,5 +11,6 @@
 struct xe_late_bind;
 
 int xe_late_bind_init(struct xe_late_bind *late_bind);
+int xe_late_bind_fw_load(struct xe_late_bind *late_bind);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
index 93abf4c51789..f119a75f4c9c 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
@@ -9,6 +9,7 @@
 #include <linux/iosys-map.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #define MAX_PAYLOAD_SIZE SZ_4K
 
@@ -38,6 +39,8 @@ struct xe_late_bind_fw {
 	u8  *payload;
 	/** @late_bind_fw.payload_size: late binding blob payload_size */
 	size_t payload_size;
+	/** @late_bind_fw.work: worker to upload latebind blob */
+	struct work_struct work;
 };
 
 /**
@@ -64,6 +67,10 @@ struct xe_late_bind {
 	struct mutex mutex;
 	/** @late_bind.late_bind_fw: late binding firmware array */
 	struct xe_late_bind_fw late_bind_fw[XE_LB_FW_MAX_ID];
+	/** @late_bind.wq: workqueue to submit request to download late bind blob */
+	struct workqueue_struct *wq;
+	/** @late_bind.component_added: whether the component has been added */
+	bool component_added;
 };
 
 #endif
-- 
2.34.1


