Return-Path: <linux-kernel+bounces-838370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B2BAF098
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165954C0A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CD2877F1;
	Wed,  1 Oct 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7rX2L9H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251727F183
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287315; cv=none; b=STUg/FBIS5ik5/24Bccime2ryUlJ5xkHBRu9LnICMvr5BY7rVxettoOLYsUs32s5X+D79oR5Iga9w4tbdgpTB2GLmEzLmg4SoUQgB5KK29meDSMTeNcAkcAY5+8FHd17G9VV+JFC05so6FXyINib8sEyte65v9T1V06jdGba5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287315; c=relaxed/simple;
	bh=C8Zuhysgp3LMzCPVS3MjoTNecQgW/tlNF212z84aDsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+wquqLZu8eHg3PXNOJ929ylob4DzAMGgjdxMLU9WNcNtzaSadrz/Fwt4vhH1HipSyZxxjRncxJrNIrsiWe5MNtQ8T7vPm4IYzp5ltgZYEvM7H5QXiE3R+HOkz2+7HMMA1kIAzhBJXnCZsct4EaedD+ibn49vDkf3LZC9sBb/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7rX2L9H; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287313; x=1790823313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8Zuhysgp3LMzCPVS3MjoTNecQgW/tlNF212z84aDsw=;
  b=d7rX2L9HRbBlWhYxsm37sZOf3AUnTuKQUIi2UN0MIxwjbP9ucCnV35mm
   K14FvVM8emeW0seghhonzT9xXnM4SNoFU/Dtc79Le3mpmY4LBkARvI5Yn
   87JquGF0aD5VH7cGxcqrHCBM+OME/kD6cWlJCiRnms0Uv+y6aSCb4SKzS
   IEKVHOyoLeieCtF/PtVV5SETfReVf83lwRKWApVyDq5dmSi9JrEDkRWO4
   4TtsD+LESZ6e0TQUxKYdunYLhOTOs8ooDtRuOS1zXSgs4JT4d4T2MJIPy
   OEuXFmwrSbITulO7x4Byy5ToJIRFkXX+iqwrX8V25PtJfa1Tn+trAEomp
   g==;
X-CSE-ConnectionGUID: zqCF9BuDQDGWeyEc7BHSnQ==
X-CSE-MsgGUID: pZzpNP85RuKgdhejtiujvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662289"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662289"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:12 -0700
X-CSE-ConnectionGUID: 8MrapPLxTNW0+DzpxEVUzg==
X-CSE-MsgGUID: TE3tkZLZTXORWVTZ8nHGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629159"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:11 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>
Subject: [PATCH v2 08/21] coco/tdx-host: Implement FW_UPLOAD sysfs ABI for TDX Module updates
Date: Tue, 30 Sep 2025 19:52:52 -0700
Message-ID: <20251001025442.427697-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware upload framework provides a standard mechanism for firmware
updates by allowing device drivers to expose sysfs interfaces for
user-initiated updates.

Register with this framework to expose sysfs interfaces for TDX Module
updates and implement operations to process data blobs supplied by
userspace.

Note that:
1. P-SEAMLDR processes the entire update at once rather than
   chunk-by-chunk, so .write() is called only once per update; so the
   offset should be always 0.
2. TDX Module Updates complete synchronously within .write(), meaning
   .poll_complete() is only called after successful updates and therefore
   always returns success

Why fw_upload instead of request_firmware()?
============================================
The explicit file selection capabilities of fw_upload is preferred over
the implicit file selection of request_firmware() for the following
reasons:

a. Intel distributes all versions of the TDX Module, allowing admins to
load any version rather than always defaulting to the latest. This
flexibility is necessary because future extensions may require reverting to
a previous version to clear fatal errors.

b. Some module version series are platform-specific. For example, the 1.5.x
series is for certain platform generations, while the 2.0.x series is
intended for others.

c. The update policy for TDX Module updates is non-linear at times. The
latest TDX Module may not be compatible. For example, TDX Module 1.5.x
may be updated to 1.5.y but not to 1.5.y+1. This policy is documented
separately in a file released along with each TDX Module release.

So, the default policy of "request_firmware()" of "always load latest", is
not suitable for TDX. Userspace needs to deploy a more sophisticated policy
check (e.g., latest may not be compatible), and there is potential
operator choice to consider.

Just have userspace pick rather than add kernel mechanism to change the
default policy of request_firmware().

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/Kconfig                      |   2 +
 arch/x86/include/asm/seamldr.h        |   2 +
 arch/x86/include/asm/tdx.h            |   5 ++
 arch/x86/virt/vmx/tdx/seamldr.c       |   7 ++
 drivers/virt/coco/tdx-host/tdx-host.c | 122 +++++++++++++++++++++++++-
 5 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6b47383d2958..2bf4bb3dfe71 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1908,6 +1908,8 @@ config INTEL_TDX_HOST
 config INTEL_TDX_MODULE_UPDATE
 	bool "Intel TDX module runtime update"
 	depends on TDX_HOST_SERVICES
+	select FW_LOADER
+	select FW_UPLOAD
 	help
 	  This enables the kernel to support TDX module runtime update. This
 	  allows the admin to update the TDX module to the same or any newer
diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
index d1e9f6e16e8d..692bde5e9bb4 100644
--- a/arch/x86/include/asm/seamldr.h
+++ b/arch/x86/include/asm/seamldr.h
@@ -20,8 +20,10 @@ struct seamldr_info {
 
 #ifdef CONFIG_INTEL_TDX_MODULE_UPDATE
 const struct seamldr_info *seamldr_get_info(void);
+int seamldr_install_module(const u8 *data, u32 size);
 #else
 static inline const struct seamldr_info *seamldr_get_info(void) { return NULL; }
+static inline int seamldr_install_module(const u8 *data, u32 size) { return -EOPNOTSUPP; }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 7ad026618a23..2422904079a3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -107,6 +107,11 @@ int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
+static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
+{
+	return false; /* To be enabled when kernel is ready */
+}
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 08c2e3fe6071..69c059194c61 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -69,3 +69,10 @@ const struct seamldr_info *seamldr_get_info(void)
 	return seamldr_call(P_SEAMLDR_INFO, &args) ? NULL : &seamldr_info;
 }
 EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_get_info, "tdx-host");
+
+int seamldr_install_module(const u8 *data, u32 size)
+{
+	/* TODO: Update TDX Module here */
+	return 0;
+}
+EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_install_module, "tdx-host");
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 42570c5b221b..418e90797689 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/sysfs.h>
 #include <linux/device/faux.h>
+#include <linux/firmware.h>
 #include <asm/cpu_device_id.h>
 #include <asm/seamldr.h>
 #include <asm/tdx.h>
@@ -21,6 +22,13 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+struct tdx_fw_upload_status {
+	bool cancel_request;
+};
+
+struct fw_upload *tdx_fwl;
+static struct tdx_fw_upload_status tdx_fw_upload_status;
+
 static struct faux_device *fdev;
 
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
@@ -106,6 +114,118 @@ static const struct attribute_group *tdx_host_groups[] = {
 	NULL,
 };
 
+static enum fw_upload_err tdx_fw_prepare(struct fw_upload *fwl,
+					 const u8 *data, u32 size)
+{
+	struct tdx_fw_upload_status *status = fwl->dd_handle;
+
+	if (status->cancel_request) {
+		status->cancel_request = false;
+		return FW_UPLOAD_ERR_CANCELED;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
+				       u32 offset, u32 size, u32 *written)
+{
+	struct tdx_fw_upload_status *status = fwl->dd_handle;
+
+	if (status->cancel_request) {
+		status->cancel_request = false;
+		return FW_UPLOAD_ERR_CANCELED;
+	}
+
+	/*
+	 * tdx_fw_write() always processes all data on the first call with
+	 * offset == 0. Since it never returns partial success (it either
+	 * succeeds completely or fails), there is no subsequent call with
+	 * non-zero offsets.
+	 */
+	WARN_ON_ONCE(offset);
+	if (seamldr_install_module(data, size))
+		return FW_UPLOAD_ERR_FW_INVALID;
+
+	*written = size;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err tdx_fw_poll_complete(struct fw_upload *fwl)
+{
+	/*
+	 * TDX Module updates are completed in the previous phase
+	 * (tdx_fw_write()). If any error occurred, the previous phase
+	 * would return an error code to abort the update process. In
+	 * other words, reaching this point means the update succeeded.
+	 */
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void tdx_fw_cancel(struct fw_upload *fwl)
+{
+	struct tdx_fw_upload_status *status = fwl->dd_handle;
+
+	status->cancel_request = true;
+}
+
+static const struct fw_upload_ops tdx_fw_ops = {
+	.prepare = tdx_fw_prepare,
+	.write = tdx_fw_write,
+	.poll_complete = tdx_fw_poll_complete,
+	.cancel = tdx_fw_cancel,
+};
+
+static int seamldr_init(struct device *dev)
+{
+	const struct seamldr_info *seamldr_info = seamldr_get_info();
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+	int ret;
+
+	if (!tdx_sysinfo || !seamldr_info)
+		return -ENXIO;
+
+	if (!tdx_supports_runtime_update(tdx_sysinfo)) {
+		pr_info("Current TDX Module cannot be updated. Consider BIOS updates\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!seamldr_info->num_remaining_updates) {
+		pr_info("P-SEAMLDR doesn't support TDX Module updates\n");
+		return -EOPNOTSUPP;
+	}
+
+	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "seamldr_upload",
+					   &tdx_fw_ops, &tdx_fw_upload_status);
+	ret = PTR_ERR_OR_ZERO(tdx_fwl);
+	if (ret)
+		pr_err("failed to register module uploader %d\n", ret);
+
+	return ret;
+}
+
+static void seamldr_deinit(void)
+{
+	if (tdx_fwl)
+		firmware_upload_unregister(tdx_fwl);
+}
+
+static int tdx_host_probe(struct faux_device *fdev)
+{
+	/* Only support TDX Module updates now. More TDX features could be added here. */
+	return seamldr_init(&fdev->dev);
+}
+
+static void tdx_host_remove(struct faux_device *fdev)
+{
+	seamldr_deinit();
+}
+
+static struct faux_device_ops tdx_host_ops = {
+	.probe		= tdx_host_probe,
+	.remove		= tdx_host_remove,
+};
+
 static int __init tdx_host_init(void)
 {
 	int r;
@@ -118,7 +238,7 @@ static int __init tdx_host_init(void)
 	if (r)
 		return r;
 
-	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, NULL, tdx_host_groups);
+	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, &tdx_host_ops, tdx_host_groups);
 	if (!fdev)
 		return -ENODEV;
 
-- 
2.47.3


