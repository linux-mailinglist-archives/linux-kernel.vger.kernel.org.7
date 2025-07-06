Return-Path: <linux-kernel+bounces-716054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0BAF8153
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 21:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D2F1BC8766
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6388C239099;
	Thu,  3 Jul 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdPhuv7z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5A2F5C37
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570828; cv=none; b=pTGeR5n/ZBskhj4+D30KtsSZvQJmEMonOkXxzKHjCriJcX5F1zccfEntEM95zIr2XMAHSoNVvtjikML4XIqMZUJ34zwVgmBs1Dxe4OjpkPNIUg6S0WUHbmf/dDgRxCfP3BpRRi8KZ7pJcSCXhBx4T2DDaMm882/F+OZWTd/Cl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570828; c=relaxed/simple;
	bh=B0Up9GxzSR+dpcxWENQchyxXl64r8NkxnN3qnjZ0JGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZfvlVqnikRw6lWWd9yIyLInrhlSwPjScDvTz3yVUonbOeHZ7lERkn1t1qpbRtj5vkLFSaVIR7Wl52ZZ8vU2+7eDHxMHjhi0yJxiD2DFUX6+ngPJGzmcJUTE+YVTacT5epmbkIdg5obSl32kBvfEEKpVm32nj2B9P0zVZ0NVXn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdPhuv7z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751570827; x=1783106827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0Up9GxzSR+dpcxWENQchyxXl64r8NkxnN3qnjZ0JGg=;
  b=OdPhuv7zt5o/T7E65HF6t7Yodx5R4M78euYEoehAPs85FR4kc6pvOjdZ
   y2+rnP43IuQnnK7V0s4yyQvJoY01O+E+8IJG83gOLWpyOq8e1qQxvQvpH
   UrUvKAbnIgFV2QL4jQWo8NUPVvGzqJiGymHsUaMfyYhfYCjQUU/QmWTsa
   DacJK9QJFbHhC2+5aFbe8exbrRBNwfovD1MjMea379/0kiq3W+CFEXCyi
   BjHU3PbgCX8Di7sNkszW/LH2KY4J4zwj1VA4Fvm5wdQ/EEkhwqszj6ssO
   ZfbrxV576PHiHLK12NPLXC4jAcdj81exaz7mbC52xXZlUSzmd9J2rKrJu
   w==;
X-CSE-ConnectionGUID: qPY8bAYET/mPzoOxtkXitA==
X-CSE-MsgGUID: QAXHUebaSJufM98NFvx0Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65362019"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="65362019"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:27:06 -0700
X-CSE-ConnectionGUID: ufoJljJJQIavj8bcbZ+sCw==
X-CSE-MsgGUID: CtFynOdwT2eNqE6na/0zwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="191624674"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:27:05 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v6 08/10] drm/xe/xe_late_bind_fw: Introduce debug fs node to disable late binding
Date: Fri,  4 Jul 2025 01:01:04 +0530
Message-Id: <20250703193106.954536-9-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703193106.954536-1-badal.nilawar@intel.com>
References: <20250703193106.954536-1-badal.nilawar@intel.com>
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
index 1361271beaa6..663cf8fe9b14 100644
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
index f650cb8641b3..2ff9bab4e7d9 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
@@ -67,6 +67,8 @@ struct xe_late_bind {
 	struct workqueue_struct *wq;
 	/** @late_bind.component_added: whether the component has been added */
 	bool component_added;
+	/** @late_bind.disable to block late binding reload during pm resume flow*/
+	bool disable;
 };
 
 #endif
-- 
2.34.1


