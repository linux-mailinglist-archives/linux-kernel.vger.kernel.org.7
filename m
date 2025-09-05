Return-Path: <linux-kernel+bounces-803287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C915B45CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885001CC008F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D39302152;
	Fri,  5 Sep 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibpx/eOX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095E309F04
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087149; cv=none; b=XpUP2V+wG0kmxRPAsbr//BknboeqxzTLc5p/tFUjZ0E3UAJv6Ekbe2rHN3J7TW+lG8+QQDZb4pLPHkiG4JRgtRWYnB/Kn9T/zhHcxd6mRGCO/3+AYac0Cbib6qy+1OV0a9aLh09iE5yfdfHu/UgVi59OFmniP+2ME6BMwGVylNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087149; c=relaxed/simple;
	bh=uSmeCO6fUEbmld+mTxJpQ2sHBRKnUyUpzut74qprZBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4DioX1av3oRFKF0WYcADG2AelCMA9eG2MzvgHDPGfDyuizggfcqzj3+BiJqqCvA9qkzWQiYxwMKa7yH5C832hWGu+Lws/LtJj74yOzu1zIVQxkdqd8zblFE2WaL+DICJc0bfPihUQTh+4sG4RrGQd58DR4ML3iTQStIYGcjLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibpx/eOX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757087148; x=1788623148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSmeCO6fUEbmld+mTxJpQ2sHBRKnUyUpzut74qprZBI=;
  b=ibpx/eOXkgEJJfuvoSunz2cHRepKEon6+u2EKBG44nDIrmNHDvuXWm5Y
   1db4h382roAH1C7ZtpR3nIIxh1BV+S5M0+D0+98kcrevCYZkZ7Xy2ufph
   TVFfJNqQsjGaLQt7nD6OqPAgCZ9dM9KgNSeCJ5hEWSL+pZXOM+KLG20PU
   pmWYdKGqBotnPXKy0uOI/mVPRkYWiWbXI6npblPQsA3Bl1ntbqg1cfxfv
   Ch9ZVCtwlRxo1YOCez2em5G0f2PIUm9z2LJ1Kek0+w8UyTIMLgx43wbtD
   pbzmPFjNjKemFxTy+fYlADSjLvErlczgocAxBp7FOj6qmKb17welChe3Y
   w==;
X-CSE-ConnectionGUID: 83xq8IF1TC2OtZslDE32WQ==
X-CSE-MsgGUID: S47+Bk4gSjGyGz2nsh0/dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70144688"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70144688"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:47 -0700
X-CSE-ConnectionGUID: shEHzgIYRM6sVHs3EOiPiw==
X-CSE-MsgGUID: vaSNGSLBTTWWlNOdiquLAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172071967"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:44 -0700
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
Subject: [PATCH v9 9/9] drm/xe/xe_late_bind_fw: Extract and print version info
Date: Fri,  5 Sep 2025 21:19:53 +0530
Message-Id: <20250905154953.3974335-10-badal.nilawar@intel.com>
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

Extract and print version info of the late binding binary.

v2: Some refinements (Daniele)

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_late_bind_fw.c       | 124 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |   3 +
 drivers/gpu/drm/xe/xe_uc_fw_abi.h          |  66 +++++++++++
 3 files changed, 193 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 0f062008ca83..38f3feb2aecd 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -45,6 +45,121 @@ late_bind_to_xe(struct xe_late_bind *late_bind)
 	return container_of(late_bind, struct xe_device, late_bind);
 }
 
+static struct xe_device *
+late_bind_fw_to_xe(struct xe_late_bind_fw *lb_fw)
+{
+	return container_of(lb_fw, struct xe_device, late_bind.late_bind_fw[lb_fw->id]);
+}
+
+/* Refer to the "Late Bind based Firmware Layout" documentation entry for details */
+static int parse_cpd_header(struct xe_late_bind_fw *lb_fw,
+			    const void *data, size_t size, const char *manifest_entry)
+{
+	struct xe_device *xe = late_bind_fw_to_xe(lb_fw);
+	const struct gsc_cpd_header_v2 *header = data;
+	const struct gsc_manifest_header *manifest;
+	const struct gsc_cpd_entry *entry;
+	size_t min_size = sizeof(*header);
+	u32 offset;
+	int i;
+
+	/* manifest_entry is mandatory */
+	xe_assert(xe, manifest_entry);
+
+	if (size < min_size || header->header_marker != GSC_CPD_HEADER_MARKER)
+		return -ENOENT;
+
+	if (header->header_length < sizeof(struct gsc_cpd_header_v2)) {
+		drm_err(&xe->drm, "%s late binding fw: Invalid CPD header length %u!\n",
+			fw_id_to_name[lb_fw->id], header->header_length);
+		return -EINVAL;
+	}
+
+	min_size = header->header_length + sizeof(struct gsc_cpd_entry) * header->num_of_entries;
+	if (size < min_size) {
+		drm_err(&xe->drm, "%s late binding fw: too small! %zu < %zu\n",
+			fw_id_to_name[lb_fw->id], size, min_size);
+		return -ENODATA;
+	}
+
+	/* Look for the manifest first */
+	entry = (void *)header + header->header_length;
+	for (i = 0; i < header->num_of_entries; i++, entry++)
+		if (strcmp(entry->name, manifest_entry) == 0)
+			offset = entry->offset & GSC_CPD_ENTRY_OFFSET_MASK;
+
+	if (!offset) {
+		drm_err(&xe->drm, "%s late binding fw: Failed to find manifest_entry\n",
+			fw_id_to_name[lb_fw->id]);
+		return -ENODATA;
+	}
+
+	min_size = offset + sizeof(struct gsc_manifest_header);
+	if (size < min_size) {
+		drm_err(&xe->drm, "%s late binding fw: too small! %zu < %zu\n",
+			fw_id_to_name[lb_fw->id], size, min_size);
+		return -ENODATA;
+	}
+
+	manifest = data + offset;
+
+	lb_fw->version = manifest->fw_version;
+
+	return 0;
+}
+
+/* Refer to the "Late Bind based Firmware Layout" documentation entry for details */
+static int parse_lb_layout(struct xe_late_bind_fw *lb_fw,
+			   const void *data, size_t size, const char *fpt_entry)
+{
+	struct xe_device *xe = late_bind_fw_to_xe(lb_fw);
+	const struct csc_fpt_header *header = data;
+	const struct csc_fpt_entry *entry;
+	size_t min_size = sizeof(*header);
+	u32 offset;
+	int i;
+
+	/* fpt_entry is mandatory */
+	xe_assert(xe, fpt_entry);
+
+	if (size < min_size || header->header_marker != CSC_FPT_HEADER_MARKER)
+		return -ENOENT;
+
+	if (header->header_length < sizeof(struct csc_fpt_header)) {
+		drm_err(&xe->drm, "%s late binding fw: Invalid FPT header length %u!\n",
+			fw_id_to_name[lb_fw->id], header->header_length);
+		return -EINVAL;
+	}
+
+	min_size = header->header_length + sizeof(struct csc_fpt_entry) * header->num_of_entries;
+	if (size < min_size) {
+		drm_err(&xe->drm, "%s late binding fw: too small! %zu < %zu\n",
+			fw_id_to_name[lb_fw->id], size, min_size);
+		return -ENODATA;
+	}
+
+	/* Look for the cpd header first */
+	entry = (void *)header + header->header_length;
+	for (i = 0; i < header->num_of_entries; i++, entry++)
+		if (strcmp(entry->name, fpt_entry) == 0)
+			offset = entry->offset;
+
+	if (!offset) {
+		drm_err(&xe->drm, "%s late binding fw: Failed to find fpt_entry\n",
+			fw_id_to_name[lb_fw->id]);
+		return -ENODATA;
+	}
+
+	min_size = offset + sizeof(struct gsc_cpd_header_v2);
+	if (size < min_size) {
+		drm_err(&xe->drm, "%s late binding fw: too small! %zu < %zu\n",
+			fw_id_to_name[lb_fw->id], size, min_size);
+		return -ENODATA;
+	}
+
+	return parse_cpd_header(lb_fw, data + offset, size - offset, "LTES.man");
+}
+
 static const char *xe_late_bind_parse_status(uint32_t status)
 {
 	switch (status) {
@@ -224,6 +339,10 @@ static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
 		return -ENODATA;
 	}
 
+	ret = parse_lb_layout(lb_fw, fw->data, fw->size, "LTES");
+	if (ret)
+		return ret;
+
 	lb_fw->payload_size = fw->size;
 	lb_fw->payload = drmm_kzalloc(&xe->drm, lb_fw->payload_size, GFP_KERNEL);
 	if (!lb_fw->payload) {
@@ -231,6 +350,11 @@ static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
 		return -ENOMEM;
 	}
 
+	drm_info(&xe->drm, "Using %s firmware from %s version %u.%u.%u.%u\n",
+		 fw_id_to_name[lb_fw->id], lb_fw->blob_path,
+		 lb_fw->version.major, lb_fw->version.minor,
+		 lb_fw->version.hotfix, lb_fw->version.build);
+
 	memcpy((void *)lb_fw->payload, fw->data, lb_fw->payload_size);
 	release_firmware(fw);
 	INIT_WORK(&lb_fw->work, xe_late_bind_work);
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
index 158dc1abe072..0f5da89ce98b 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include "xe_uc_fw_abi.h"
 
 #define XE_LB_MAX_PAYLOAD_SIZE SZ_4K
 
@@ -39,6 +40,8 @@ struct xe_late_bind_fw {
 	size_t payload_size;
 	/** @work: worker to upload latebind blob */
 	struct work_struct work;
+	/** @version: late binding blob manifest version */
+	struct gsc_version version;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_uc_fw_abi.h b/drivers/gpu/drm/xe/xe_uc_fw_abi.h
index 87ade41209d0..78782d105fa9 100644
--- a/drivers/gpu/drm/xe/xe_uc_fw_abi.h
+++ b/drivers/gpu/drm/xe/xe_uc_fw_abi.h
@@ -318,4 +318,70 @@ struct gsc_manifest_header {
 	u32 exponent_size; /* in dwords */
 } __packed;
 
+/**
+ * DOC: Late binding Firmware Layout
+ *
+ * The Late binding binary starts with FPT header, which contains locations
+ * of various partitions of the binary. Here we're interested in finding out
+ * manifest version. To the manifest version, we need to locate CPD header
+ * one of the entry in CPD header points to manifest header. Manifest header
+ * contains the version.
+ *
+ *      +================================================+
+ *      |  FPT Header                                    |
+ *      +================================================+
+ *      |  FPT entries[]                                 |
+ *      |      entry1                                    |
+ *      |      ...                                       |
+ *      |      entryX                                    |
+ *      |          "LTES"                                |
+ *      |          ...                                   |
+ *      |          offset  >-----------------------------|------o
+ *      +================================================+      |
+ *                                                              |
+ *      +================================================+      |
+ *      |  CPD Header                                    |<-----o
+ *      +================================================+
+ *      |  CPD entries[]                                 |
+ *      |      entry1                                    |
+ *      |      ...                                       |
+ *      |      entryX                                    |
+ *      |          "LTES.man"                            |
+ *      |           ...                                  |
+ *      |           offset  >----------------------------|------o
+ *      +================================================+      |
+ *                                                              |
+ *      +================================================+      |
+ *      |  Manifest Header                               |<-----o
+ *      |      ...                                       |
+ *      |      FW version                                |
+ *      |      ...                                       |
+ *      +================================================+
+ */
+
+/* FPT Headers */
+struct csc_fpt_header {
+	u32 header_marker;
+#define CSC_FPT_HEADER_MARKER 0x54504624
+	u32 num_of_entries;
+	u8 header_version;
+	u8 entry_version;
+	u8 header_length; /* in bytes */
+	u8 flags;
+	u16 ticks_to_add;
+	u16 tokens_to_add;
+	u32 uma_size;
+	u32 crc32;
+	struct gsc_version fitc_version;
+} __packed;
+
+struct csc_fpt_entry {
+	u8 name[4]; /* partition name */
+	u32 reserved1;
+	u32 offset; /* offset from beginning of CSE region */
+	u32 length; /* partition length in bytes */
+	u32 reserved2[3];
+	u32 partition_flags;
+} __packed;
+
 #endif
-- 
2.34.1


