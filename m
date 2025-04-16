Return-Path: <linux-kernel+bounces-603969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5006CA88E97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DC189B7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045D20AF67;
	Mon, 14 Apr 2025 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSVsw3VA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24E1FF1C4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667696; cv=none; b=B08XumJwLK4jpUw55Ma/CllOhAJQnh9l+5HgONZGnS3SCKtC4oa0yfpRjFoqP+zzI012sdFoXaLEU31FxAhVHIQ1nC2nB1P4dHU1dxZg3c0EZ58hhEgOoQ3LxmhY2rLFaV5kvUixoNF5GQ9Sxd3prylcOqlczZxW9NB5hyynTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667696; c=relaxed/simple;
	bh=iMtSB9xocvWbwKfSUfynwLjJ1rn1FdgcQTu2ScaEku8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAl6Eqz6S1ayJ3epkuNC7jESWxSxNyUPD0y3TNN/f2ZbskqbeAycJmjRTHoQXzFmPbEI/HU3K5oOp5cuT2vdOmAfl97hNFyn2eHJRA6ww6xlLn21mSu3Nx7JpwzMLkZv6Tlrcy/TKTR6dqXrZn4Jqjq+rzFOVslVcpxWtS4eRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSVsw3VA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744667694; x=1776203694;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iMtSB9xocvWbwKfSUfynwLjJ1rn1FdgcQTu2ScaEku8=;
  b=PSVsw3VAYuqUAGm7sSBBKSPA1B6rq50fYx2z1zhN+kMiRDLKh+b5zTD/
   idRGfYX5eECkDq+evorNRrRzf+6BO7RijfTeCQoazRy2z7aUNrshS5Y93
   sdt6L4eMwh6mZnVJeMMKe1DPvSlxLEPu/f8g67gF9Ceez2HMrnC+FoEGK
   nTiYuecoceGDlBvqa3C1vkJJp3vJf/HSYZ4hAye9riOCJ9cshbYsNNL5C
   Nl1fiy4sITQwBuXVaMKq8uTeD3Ijzn8iFjjzpXYPFq7UYK1oUVrXiGldV
   syAYTcKhPJ0e19uSXY76frk7rjblrdJUSuzmDgL6KlLAEKt/G5jj/WFn7
   g==;
X-CSE-ConnectionGUID: ngFtlmoPTjGO/g/9IbGb6w==
X-CSE-MsgGUID: YH84lXB2RZCUSph6W5yolQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71544385"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="71544385"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:54:54 -0700
X-CSE-ConnectionGUID: 0MqbIKJiTz+nOnkEON1FeA==
X-CSE-MsgGUID: P3XR6nuEQbaFHAtUBtaL5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130474173"
Received: from hasmith-mobl1.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.115.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:54:52 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Mon, 14 Apr 2025 16:54:23 -0500
Subject: [PATCH v4 5/5] virt: tdx-guest: Expose TDX MRs as sysfs attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-tdx-rtmr-v4-5-7edfa8d98716@intel.com>
References: <20250414-tdx-rtmr-v4-0-7edfa8d98716@intel.com>
In-Reply-To: <20250414-tdx-rtmr-v4-0-7edfa8d98716@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Guorui Yu <guorui.yu@linux.alibaba.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Dan Middleton <dan.middleton@linux.intel.com>, 
 Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Cedric Xing <cedric.xing@intel.com>
X-Mailer: b4 0.13.0

Expose the most commonly used TDX MRs (Measurement Registers) as sysfs
attributes. Use the ioctl() interface of /dev/tdx_guest to request a full
TDREPORT for access to other TD measurements.

Directory structure of TDX MRs inside a TDVM is as follows:

/sys/class/misc/tdx_guest
└── mr
    ├── mrconfigid
    ├── mrowner
    ├── mrownerconfig
    ├── mrtd:sha384
    ├── rtmr0:sha384
    ├── rtmr1:sha384
    ├── rtmr2:sha384
    └── rtmr3:sha384

Read the file/attribute to retrieve the current value of an MR. Write to
the file/attribute (if writable) to extend the corresponding RTMR. Refer to
Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest-mr for more
information.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 .../testing/sysfs-devices-virtual-misc-tdx_guest   |  60 +++++
 MAINTAINERS                                        |   1 +
 drivers/virt/coco/tdx-guest/Kconfig                |   1 +
 drivers/virt/coco/tdx-guest/tdx-guest.c            | 291 +++++++++++++--------
 4 files changed, 250 insertions(+), 103 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest b/Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest
new file mode 100644
index 000000000000..fb7b27ae0b74
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest
@@ -0,0 +1,60 @@
+What:		/sys/devices/virtual/misc/tdx_guest/mr/MRNAME[:HASH]
+Date:		April, 2025
+KernelVersion:	v6.16
+Contact:	linux-coco@lists.linux.dev
+Description:
+		Value of a TDX measurement register (MR). MRNAME and HASH above
+		are placeholders. The optional suffix :HASH is used for MRs
+		that have associated hash algorithms. See below for a complete
+		list of TDX MRs exposed via sysfs. Refer to Intel TDX Module
+		ABI Specification for the definition of TDREPORT and the full
+		list of TDX measurements.
+
+		Intel TDX Module ABI Specification can be found at:
+		https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/documentation.html#architecture
+
+What:		/sys/devices/virtual/misc/tdx_guest/mr/mrconfigid
+Date:		April, 2025
+KernelVersion:	v6.16
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) MRCONFIGID - 48-byte immutable storage typically used for
+		software-defined ID for non-owner-defined configuration of the
+		guest TD – e.g., run-time or OS configuration.
+
+What:		/sys/devices/virtual/misc/tdx_guest/mr/mrowner
+Date:		April, 2025
+KernelVersion:	v6.16
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) MROWNER - 48-byte immutable storage typically used for
+		software-defined ID for the guest TD’s owner.
+
+What:		/sys/devices/virtual/misc/tdx_guest/mr/mrownerconfig
+Date:		April, 2025
+KernelVersion:	v6.16
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) MROWNERCONFIG - 48-byte immutable storage typically used
+		for software-defined ID for owner-defined configuration of the
+		guest TD – e.g., specific to the workload rather than the
+		run-time or OS.
+
+What:		/sys/devices/virtual/misc/tdx_guest/mr/mrtd:sha384
+Date:		April, 2025
+KernelVersion:	v6.16
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) MRTD - Measurement of the initial contents of the TD.
+
+What:		/sys/devices/virtual/misc/tdx_guest/mr/rtmr[0123]:sha384
+Date:		April, 2025
+KernelVersion:	v6.16
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) RTMR[0123] - 4 Run-Time extendable Measurement Registers.
+		Read from any of these returns the current value of the
+		corresponding RTMR. Write extends the written buffer to the
+		RTMR. All writes must start at offset 0 and be 48 bytes in
+		size. Partial writes will result in EINVAL returned by the
+		write() syscall.
diff --git a/MAINTAINERS b/MAINTAINERS
index 870b34190de7..1632dfb0051d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26228,6 +26228,7 @@ L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
+F:	Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest-mr
 F:	arch/x86/boot/compressed/tdx*
 F:	arch/x86/coco/tdx/
 F:	arch/x86/include/asm/shared/tdx.h
diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
index 22dd59e19431..dbbdc14383b1 100644
--- a/drivers/virt/coco/tdx-guest/Kconfig
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -2,6 +2,7 @@ config TDX_GUEST_DRIVER
 	tristate "TDX Guest driver"
 	depends on INTEL_TDX_GUEST
 	select TSM_REPORTS
+	select TSM_MEASUREMENTS
 	help
 	  The driver provides userspace interface to communicate with
 	  the TDX module to request the TDX guest details like attestation
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 224e7dde9cde..e76810d89e0b 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2022 Intel Corporation
  */
 
+#define pr_fmt(fmt)			KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -15,8 +17,9 @@
 #include <linux/set_memory.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/sockptr.h>
 #include <linux/tsm.h>
-#include <linux/sizes.h>
+#include <linux/tsm-mr.h>
 
 #include <uapi/linux/tdx-guest.h>
 
@@ -66,39 +69,144 @@ static DEFINE_MUTEX(quote_lock);
  */
 static u32 getquote_timeout = 30;
 
-static long tdx_get_report0(struct tdx_report_req __user *req)
+/* Buffers for TDREPORT and RTMR extension */
+static u8 *tdx_report_buf, *tdx_extend_buf;
+
+/* Lock to serialize TDG.MR.REPORT & TDG.MR.RTMR.EXTEND requests */
+static DEFINE_MUTEX(mr_lock);
+
+/* TDREPORT fields */
+enum {
+	TDREPORT_reportdata = 128,
+	TDREPORT_tee_tcb_info = 256,
+	TDREPORT_tdinfo = TDREPORT_tee_tcb_info + 256,
+	TDREPORT_attributes = TDREPORT_tdinfo,
+	TDREPORT_xfam = TDREPORT_attributes + sizeof(u64),
+	TDREPORT_mrtd = TDREPORT_xfam + sizeof(u64),
+	TDREPORT_mrconfigid = TDREPORT_mrtd + SHA384_DIGEST_SIZE,
+	TDREPORT_mrowner = TDREPORT_mrconfigid + SHA384_DIGEST_SIZE,
+	TDREPORT_mrownerconfig = TDREPORT_mrowner + SHA384_DIGEST_SIZE,
+	TDREPORT_rtmr0 = TDREPORT_mrownerconfig + SHA384_DIGEST_SIZE,
+	TDREPORT_rtmr1 = TDREPORT_rtmr0 + SHA384_DIGEST_SIZE,
+	TDREPORT_rtmr2 = TDREPORT_rtmr1 + SHA384_DIGEST_SIZE,
+	TDREPORT_rtmr3 = TDREPORT_rtmr2 + SHA384_DIGEST_SIZE,
+	TDREPORT_servtd_hash = TDREPORT_rtmr3 + SHA384_DIGEST_SIZE,
+};
+
+static inline int tdx_mr_report_locked(sockptr_t data, sockptr_t tdreport)
 {
-	u8 *reportdata, *tdreport;
-	long ret;
+	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock) {
+		u8 *p = tdx_report_buf + TDREPORT_reportdata;
+		int ret;
 
-	reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
-	if (!reportdata)
-		return -ENOMEM;
+		if (!sockptr_is_null(data) &&
+		    copy_from_sockptr(p, data, TDX_REPORTDATA_LEN))
+			return -EFAULT;
 
-	tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
-	if (!tdreport) {
-		ret = -ENOMEM;
-		goto out;
+		ret = tdx_mcall_get_report0(p, tdx_report_buf);
+		if (WARN(ret, "tdx_mcall_get_report0() failed: %d", ret))
+			return ret;
+
+		if (!sockptr_is_null(tdreport) &&
+		    copy_to_sockptr(tdreport, tdx_report_buf, TDX_REPORT_LEN))
+			return -EFAULT;
 	}
+	return 0;
+}
 
-	if (copy_from_user(reportdata, req->reportdata, TDX_REPORTDATA_LEN)) {
-		ret = -EFAULT;
-		goto out;
+static inline int tdx_mr_extend_locked(ptrdiff_t mr_ind, const u8 *data)
+{
+	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock) {
+		int ret;
+
+		memcpy(tdx_extend_buf, data, SHA384_DIGEST_SIZE);
+
+		ret = tdx_mcall_extend_rtmr(mr_ind, tdx_extend_buf);
+		if (WARN(ret, "tdx_mcall_extend_rtmr(%ld) failed: %d", mr_ind, ret))
+			return ret;
 	}
+	return 0;
+}
+
+#define TDX_MR_(r) .mr_value = (void *)TDREPORT_##r, TSM_MR_(r, SHA384)
+static struct tsm_measurement_register tdx_mrs[] = {
+	{ TDX_MR_(rtmr0) | TSM_MR_F_RTMR },
+	{ TDX_MR_(rtmr1) | TSM_MR_F_RTMR },
+	{ TDX_MR_(rtmr2) | TSM_MR_F_RTMR },
+	{ TDX_MR_(rtmr3) | TSM_MR_F_RTMR },
+	{ TDX_MR_(mrtd) },
+	{ TDX_MR_(mrconfigid) | TSM_MR_F_NOHASH },
+	{ TDX_MR_(mrowner) | TSM_MR_F_NOHASH },
+	{ TDX_MR_(mrownerconfig) | TSM_MR_F_NOHASH },
+};
+#undef TDX_MR_
+
+static int tdx_mr_refresh(const struct tsm_measurements *tm,
+			  const struct tsm_measurement_register *mr)
+{
+	return tdx_mr_report_locked(KERNEL_SOCKPTR(NULL), KERNEL_SOCKPTR(NULL));
+}
 
-	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
-	ret = tdx_mcall_get_report0(reportdata, tdreport);
+static int tdx_mr_extend(const struct tsm_measurements *tm,
+			 const struct tsm_measurement_register *mr,
+			 const u8 *data)
+{
+	return tdx_mr_extend_locked(mr - tm->mrs, data);
+}
+
+static struct tsm_measurements tdx_measurements = {
+	.mrs = tdx_mrs,
+	.nr_mrs = ARRAY_SIZE(tdx_mrs),
+	.refresh = tdx_mr_refresh,
+	.write = tdx_mr_extend,
+};
+
+/* attribute groups of tdx_misc_dev */
+static const struct attribute_group *tdx_attr_groups[] = {
+	NULL,
+	NULL,
+};
+
+static int tdx_mr_init(void)
+{
+	int ret;
+
+	u8 *report_buf __free(kfree) = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
+
+	/* TDG.MR.RTMR.EXTEND requires 64-byte aligned input */
+	u8 *extend_buf __free(kfree) = kmalloc(64, GFP_KERNEL);
+
+	if (!report_buf || !extend_buf)
+		return -ENOMEM;
+
+	tdx_report_buf = report_buf;
+	ret = tdx_mr_refresh(&tdx_measurements, NULL);
 	if (ret)
-		goto out;
+		return ret;
 
-	if (copy_to_user(req->tdreport, tdreport, TDX_REPORT_LEN))
-		ret = -EFAULT;
+	for (size_t i = 0; i < ARRAY_SIZE(tdx_mrs); ++i)
+		*(long *)&tdx_mrs[i].mr_value += (long)report_buf;
 
-out:
-	kfree(reportdata);
-	kfree(tdreport);
+	tdx_attr_groups[0] = tsm_mr_create_attribute_group(&tdx_measurements);
+	if (IS_ERR(tdx_attr_groups[0]))
+		return PTR_ERR(tdx_attr_groups[0]);
 
-	return ret;
+	tdx_report_buf = no_free_ptr(report_buf);
+	tdx_extend_buf = no_free_ptr(extend_buf);
+	return 0;
+}
+
+static void tdx_mr_deinit(void)
+{
+	tsm_mr_free_attribute_group(tdx_attr_groups[0]);
+	kfree(tdx_extend_buf);
+	kfree(tdx_report_buf);
+}
+
+static long tdx_get_report0(struct tdx_report_req __user *req)
+{
+	return tdx_mr_report_locked(USER_SOCKPTR(req->reportdata),
+				    USER_SOCKPTR(req->tdreport));
 }
 
 static void free_quote_buf(void *buf)
@@ -159,91 +267,60 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 
 static int tdx_report_new(struct tsm_report *report, void *data)
 {
-	u8 *buf, *reportdata = NULL, *tdreport = NULL;
+	u8 *buf;
 	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_desc *desc = &report->desc;
 	int ret;
 	u64 err;
 
-	/* TODO: switch to guard(mutex_intr) */
-	if (mutex_lock_interruptible(&quote_lock))
-		return -EINTR;
-
-	/*
-	 * If the previous request is timedout or interrupted, and the
-	 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
-	 * VMM), don't permit any new request.
-	 */
-	if (quote_buf->status == GET_QUOTE_IN_FLIGHT) {
-		ret = -EBUSY;
-		goto done;
-	}
-
-	if (desc->inblob_len != TDX_REPORTDATA_LEN) {
-		ret = -EINVAL;
-		goto done;
-	}
-
-	reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
-	if (!reportdata) {
-		ret = -ENOMEM;
-		goto done;
-	}
-
-	tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
-	if (!tdreport) {
-		ret = -ENOMEM;
-		goto done;
-	}
-
-	memcpy(reportdata, desc->inblob, desc->inblob_len);
-
-	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
-	ret = tdx_mcall_get_report0(reportdata, tdreport);
-	if (ret) {
-		pr_err("GetReport call failed\n");
-		goto done;
+	scoped_cond_guard(mutex_intr, ret = -EINTR, &quote_lock) {
+		/*
+		 * If the previous request is timedout or interrupted, and the
+		 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
+		 * VMM), don't permit any new request.
+		 */
+		if (quote_buf->status == GET_QUOTE_IN_FLIGHT)
+			return -EBUSY;
+
+		if (desc->inblob_len != TDX_REPORTDATA_LEN)
+			return -EINVAL;
+
+		memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+
+		/* Update Quote buffer header */
+		quote_buf->version = GET_QUOTE_CMD_VER;
+		quote_buf->in_len = TDX_REPORT_LEN;
+
+		/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
+		ret = tdx_mr_report_locked(KERNEL_SOCKPTR(desc->inblob),
+					   KERNEL_SOCKPTR(quote_buf->data));
+		if (ret)
+			break;
+
+		err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+		if (err) {
+			pr_err("GetQuote hypercall failed, status:%llx\n", err);
+			return -EIO;
+		}
+
+		ret = wait_for_quote_completion(quote_buf, getquote_timeout);
+		if (ret) {
+			pr_err("GetQuote request timedout\n");
+			break;
+		}
+
+		buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		report->outblob = buf;
+		report->outblob_len = quote_buf->out_len;
+
+		/*
+		 * TODO: parse the PEM-formatted cert chain out of the quote
+		 * buffer when provided
+		 */
 	}
-
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
-
-	/* Update Quote buffer header */
-	quote_buf->version = GET_QUOTE_CMD_VER;
-	quote_buf->in_len = TDX_REPORT_LEN;
-
-	memcpy(quote_buf->data, tdreport, TDX_REPORT_LEN);
-
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
-	if (err) {
-		pr_err("GetQuote hypercall failed, status:%llx\n", err);
-		ret = -EIO;
-		goto done;
-	}
-
-	ret = wait_for_quote_completion(quote_buf, getquote_timeout);
-	if (ret) {
-		pr_err("GetQuote request timedout\n");
-		goto done;
-	}
-
-	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto done;
-	}
-
-	report->outblob = buf;
-	report->outblob_len = quote_buf->out_len;
-
-	/*
-	 * TODO: parse the PEM-formatted cert chain out of the quote buffer when
-	 * provided
-	 */
-done:
-	mutex_unlock(&quote_lock);
-	kfree(reportdata);
-	kfree(tdreport);
-
 	return ret;
 }
 
@@ -289,6 +366,7 @@ static struct miscdevice tdx_misc_dev = {
 	.name = KBUILD_MODNAME,
 	.minor = MISC_DYNAMIC_MINOR,
 	.fops = &tdx_guest_fops,
+	.groups = tdx_attr_groups,
 };
 
 static const struct x86_cpu_id tdx_guest_ids[] = {
@@ -311,10 +389,14 @@ static int __init tdx_guest_init(void)
 	if (!x86_match_cpu(tdx_guest_ids))
 		return -ENODEV;
 
-	ret = misc_register(&tdx_misc_dev);
+	ret = tdx_mr_init();
 	if (ret)
 		return ret;
 
+	ret = misc_register(&tdx_misc_dev);
+	if (ret)
+		goto free_tsm_mr;
+
 	quote_data = alloc_quote_buf();
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
@@ -332,6 +414,8 @@ static int __init tdx_guest_init(void)
 	free_quote_buf(quote_data);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
+free_tsm_mr:
+	tdx_mr_deinit();
 
 	return ret;
 }
@@ -342,6 +426,7 @@ static void __exit tdx_guest_exit(void)
 	tsm_unregister(&tdx_tsm_ops);
 	free_quote_buf(quote_data);
 	misc_deregister(&tdx_misc_dev);
+	tdx_mr_deinit();
 }
 module_exit(tdx_guest_exit);
 

-- 
2.43.0


