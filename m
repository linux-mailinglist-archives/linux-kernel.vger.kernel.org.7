Return-Path: <linux-kernel+bounces-720427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92178AFBB90
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8854C420FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DE26AAAB;
	Mon,  7 Jul 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEDYgc5h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAE26A0FF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915320; cv=none; b=IGLUsY2zDuspnIN9Vtg2fczVFxVL+C5uH5ue0k4tEoT+QpCUChM7SrNgsTg08ovLUB9dNEXw/H+l8yPDCR/U6xfSp9skD3CdFGBoYbGuHl0KI9mnuF1SR/0ENwv8x2ZqbAoT9MeL5wZO4N3jYdcEQ+V+muytqmmnkVRGkkM3o/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915320; c=relaxed/simple;
	bh=1R19Idxj3kDius8mWLm6qMihg2h0FoKBMPBhn7+/M6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EE19IMWSQwAc6Fk/mCh8DnQdnPUE3ljaCZSfWpdl/u+KPzJq+ioSDJcQWfG7COtjgqOpb3J0yoSVVmivPYFBdfNJmovLelTsbmJYCV2R2MyS756WAKunc6wBFqcxlP7Ei+iMNY+V9VxWzcZCckopClFfSNSoOoE3OfRS/VrKyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEDYgc5h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751915319; x=1783451319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1R19Idxj3kDius8mWLm6qMihg2h0FoKBMPBhn7+/M6A=;
  b=LEDYgc5hsl4FhO7ASFhwA7wJ3T5cpu2zjFm7fx8Y0A8TZUtUYTvPA8m/
   FmkvpN9z1b/cU6Uf/38h1dWOL0N2ieRTLauGPQX/dSJeAgcEZ5o8kv03o
   yGUKY4IysALZPWbYx/GN6IHAceqFvdEb9kZ3O6EseiKTPnpUyLbvLueIf
   Vk33vYILseDcj6pGjlJKm+UZgRoJRcxrTseM0HjCcu1US1Reyaojxx4Dd
   poSCnyxy6rktYOx2NXBLYjiMgJVcXu+L3sAATx1dNGvEfz1RHG0d4kpHR
   26GgUUokHUwxe4yKlpi7ZIb0ckf5CgV1Ts+kRJ5iJZeXJlgZez6r5Ql7W
   g==;
X-CSE-ConnectionGUID: FZBMKssHQW+e0yQ5nLMI+Q==
X-CSE-MsgGUID: 82ryRRlcQCa9JIFUJUDc7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57945698"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57945698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:39 -0700
X-CSE-ConnectionGUID: Gm4HpT2WTKWDF1Y15+x29w==
X-CSE-MsgGUID: IEjKVDETSDW+E4xe94nAUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154707538"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:36 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v7 8/9] drm/xe/xe_late_bind_fw: Introduce debug fs node to disable late binding
Date: Tue,  8 Jul 2025 00:42:36 +0530
Message-Id: <20250707191237.1782824-9-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707191237.1782824-1-badal.nilawar@intel.com>
References: <20250707191237.1782824-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a debug filesystem node to disable late binding fw reload
during the system or runtime resume. This is intended for situations
where the late binding fw needs to be loaded from user mode,
perticularly for validation purpose.
Note that xe kmd doesn't participate in late binding flow from user
space. Binary loaded from the userspace will be lost upon entering to
D3 cold hence user space app need to handle this situation.

v2:
  - s/(uval == 1) ? true : false/!!uval/ (Daniele)
v3:
  - Refine the commit message (Daniele)

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c            | 41 ++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_late_bind_fw.c       |  3 ++
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index d83cd6ed3fa8..d1f6f556efa2 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -226,6 +226,44 @@ static const struct file_operations atomic_svm_timeslice_ms_fops = {
 	.write = atomic_svm_timeslice_ms_set,
 };
 
+static ssize_t disable_late_binding_show(struct file *f, char __user *ubuf,
+					 size_t size, loff_t *pos)
+{
+	struct xe_device *xe = file_inode(f)->i_private;
+	struct xe_late_bind *late_bind = &xe->late_bind;
+	char buf[32];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "%d\n", late_bind->disable);
+
+	return simple_read_from_buffer(ubuf, size, pos, buf, len);
+}
+
+static ssize_t disable_late_binding_set(struct file *f, const char __user *ubuf,
+					size_t size, loff_t *pos)
+{
+	struct xe_device *xe = file_inode(f)->i_private;
+	struct xe_late_bind *late_bind = &xe->late_bind;
+	u32 uval;
+	ssize_t ret;
+
+	ret = kstrtouint_from_user(ubuf, size, sizeof(uval), &uval);
+	if (ret)
+		return ret;
+
+	if (uval > 1)
+		return -EINVAL;
+
+	late_bind->disable = !!uval;
+	return size;
+}
+
+static const struct file_operations disable_late_binding_fops = {
+	.owner = THIS_MODULE,
+	.read = disable_late_binding_show,
+	.write = disable_late_binding_set,
+};
+
 void xe_debugfs_register(struct xe_device *xe)
 {
 	struct ttm_device *bdev = &xe->ttm;
@@ -249,6 +287,9 @@ void xe_debugfs_register(struct xe_device *xe)
 	debugfs_create_file("atomic_svm_timeslice_ms", 0600, root, xe,
 			    &atomic_svm_timeslice_ms_fops);
 
+	debugfs_create_file("disable_late_binding", 0600, root, xe,
+			    &disable_late_binding_fops);
+
 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		man = ttm_manager_type(bdev, mem_type);
 
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 54ba0b57185b..3228864716b5 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -165,6 +165,9 @@ int xe_late_bind_fw_load(struct xe_late_bind *late_bind)
 	if (!late_bind->component_added)
 		return -ENODEV;
 
+	if (late_bind->disable)
+		return 0;
+
 	for (fw_id = 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
 		lbfw = &late_bind->late_bind_fw[fw_id];
 		if (lbfw->payload) {
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
index 3cc5fc0593b3..9399d425d80b 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
@@ -65,6 +65,8 @@ struct xe_late_bind {
 	struct workqueue_struct *wq;
 	/** @component_added: whether the component has been added */
 	bool component_added;
+	/** @disable: to block late binding reload during pm resume flow*/
+	bool disable;
 };
 
 #endif
-- 
2.34.1


