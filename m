Return-Path: <linux-kernel+bounces-603965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17CA88E95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4544C189B726
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CE20125F;
	Mon, 14 Apr 2025 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ittsr6Wd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C91E1DE9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667691; cv=none; b=HWqAj9d27goiU3PyhfDi29FtTtf5W9atjTC46/arsR7ScbrGE12EFbi7SNjLb12d3I1gj/ecMc88ODQRlIgV+iuJiTuhfrp+KUn+9GgEwBJdc17ki99pE4BVQi5+QIf9o3VeptXCoPuzEM8JA9VzFgFznsrUDWLkKF7B2JCfIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667691; c=relaxed/simple;
	bh=NluaHN8vbYIuMdi0zkqQlt2XTjZ3T+6WKKvBru1qg9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXPclSZ57b5DTnda/3Lf4cpZPSqCKQ8gxlzDToHeaQLxP2UvwipVCkb9rns74Gcqd129nVwAEunFMn9Af2+AVFHtsWryTd0RyJBtF8UUIIDaWL2u1/J8almOA+HmBK5+TdW8A8fIwDIJ//Hjj5pvgYfsKUNXxzZHyFxRQyuRECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ittsr6Wd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744667689; x=1776203689;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NluaHN8vbYIuMdi0zkqQlt2XTjZ3T+6WKKvBru1qg9Y=;
  b=ittsr6Wd1oQj3/Bb2WJ+ZbC6udt9JlZqa19WIu5Jczq+hHybPPjMdXj3
   YfqRLw2lAEojV55Q9ldTdqRaSb7s1MVGqYnvvKPmkrvMrKC2UDlAXUePb
   DwZiCuxp4tcl/7Jn/qJPIkuAId6a5uGdkYHai6mwy0ep0grs2EQ+lRRRb
   P90NpgF3tYbq2TQZ/v47mHRgvzkm+048BGFdhu8igfBNj+Ya72aSJK1Jb
   dvrwZ1BCs9WX80JOfNw3FyZuPw00XkF6FRc10pOb1TxlE4jNrAS1oz5Y6
   Wubwp7U5aGHzt9aNyrotM/AkJN5GdcgIvrIh//cQEWCbzKRdHpm1Dhuec
   w==;
X-CSE-ConnectionGUID: wjizbXDVSsGxloULwo79CQ==
X-CSE-MsgGUID: 4G8PZTVQSkimn0sk76wO9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71544345"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="71544345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:54:48 -0700
X-CSE-ConnectionGUID: Kg6vwTFMTXOypzSpSNKfPg==
X-CSE-MsgGUID: 0KvxxVEKTRyXpSk6ZxNM7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130474154"
Received: from hasmith-mobl1.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.115.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:54:47 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Mon, 14 Apr 2025 16:54:19 -0500
Subject: [PATCH v4 1/5] tsm-mr: Add TVM Measurement Register support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-tdx-rtmr-v4-1-7edfa8d98716@intel.com>
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

Introduce new TSM Measurement helper library (tsm-mr) for TVM guest drivers
to expose MRs (Measurement Registers) as sysfs attributes, with Crypto
Agility support.

Add the following new APIs (see include/linux/tsm-mr.h for details):

- tsm_mr_create_attribute_group(): Take on input a `struct
  tsm_measurements` instance, which includes one `struct
  tsm_measurement_register` per MR with properties like `TSM_MR_F_READABLE`
  and `TSM_MR_F_WRITABLE`, to determine the supported operations and create
  the sysfs attributes accordingly. On success, return a `struct
  attribute_group` instance that will typically be included by the guest
  driver into `miscdevice.groups` before calling misc_register().

- tsm_mr_free_attribute_group(): Free the memory allocated to the attrubute
  group returned by tsm_mr_create_attribute_group().

tsm_mr_create_attribute_group() creates one attribute for each MR, with
names following this pattern:

        MRNAME[:HASH]

- MRNAME - Placeholder for the MR name, as specified by
  `tsm_measurement_register.mr_name`.
- :HASH - Optional suffix indicating the hash algorithm associated with
  this MR, as specified by `tsm_measurement_register.mr_hash`.

Support Crypto Agility by allowing multiple definitions of the same MR
(i.e., with the same `mr_name`) with distinct HASH algorithms.

NOTE: Crypto Agility, introduced in TPM 2.0, allows new hash algorithms to
be introduced without breaking compatibility with applications using older
algorithms. CC architectures may face the same challenge in the future,
needing new hashes for security while retaining compatibility with older
hashes, hence the need for Crypto Agility.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 Documentation/driver-api/coco/index.rst            |  12 +
 .../driver-api/coco/measurement-registers.rst      |  12 +
 Documentation/driver-api/index.rst                 |   1 +
 MAINTAINERS                                        |   4 +-
 drivers/virt/coco/Kconfig                          |   5 +
 drivers/virt/coco/Makefile                         |   1 +
 drivers/virt/coco/tsm-mr.c                         | 247 +++++++++++++++++++++
 include/linux/tsm-mr.h                             |  94 ++++++++
 include/trace/events/tsm_mr.h                      |  80 +++++++
 9 files changed, 454 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/coco/index.rst b/Documentation/driver-api/coco/index.rst
new file mode 100644
index 000000000000..af9f08ca0cfd
--- /dev/null
+++ b/Documentation/driver-api/coco/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Confidential Computing
+======================
+
+.. toctree::
+   :maxdepth: 1
+
+   measurement-registers
+
+.. only::  subproject and html
diff --git a/Documentation/driver-api/coco/measurement-registers.rst b/Documentation/driver-api/coco/measurement-registers.rst
new file mode 100644
index 000000000000..cef85945a9a7
--- /dev/null
+++ b/Documentation/driver-api/coco/measurement-registers.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=====================
+Measurement Registers
+=====================
+
+.. kernel-doc:: include/linux/tsm-mr.h
+   :internal:
+
+.. kernel-doc:: drivers/virt/coco/tsm-mr.c
+   :export:
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 16e2c4ec3c01..3e2a270bd828 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -81,6 +81,7 @@ Subsystem-specific APIs
    acpi/index
    backlight/lp855x-driver.rst
    clk
+   coco/index
    console
    crypto/index
    dmaengine/index
diff --git a/MAINTAINERS b/MAINTAINERS
index c59316109e3f..bc4033efe2fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24560,8 +24560,8 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
-F:	drivers/virt/coco/tsm.c
-F:	include/linux/tsm.h
+F:	drivers/virt/coco/tsm*.c
+F:	include/linux/tsm*.h
 
 TRUSTED SERVICES TEE DRIVER
 M:	Balint Dobszay <balint.dobszay@arm.com>
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index ff869d883d95..737106d5dcbc 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -7,6 +7,11 @@ config TSM_REPORTS
 	select CONFIGFS_FS
 	tristate
 
+config TSM_MEASUREMENTS
+	select CRYPTO_HASH_INFO
+	select CRYPTO
+	bool
+
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/pkvm-guest/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index c3d07cfc087e..eb6ec5c1d2e1 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -3,6 +3,7 @@
 # Confidential computing related collateral
 #
 obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
+obj-$(CONFIG_TSM_MEASUREMENTS)	+= tsm-mr.o
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
new file mode 100644
index 000000000000..adc32328018e
--- /dev/null
+++ b/drivers/virt/coco/tsm-mr.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/tsm_mr.h>
+
+/*
+ * struct tm_context - contains everything necessary to implement sysfs
+ * attributes for MRs.
+ * @rwsem: protects the MR cache from concurrent access.
+ * @agrp: contains all MR attributes created by tsm_mr_create_attribute_group().
+ * @tm: input to tsm_mr_create_attribute_group() containing MR definitions/ops.
+ * @in_sync: %true if MR cache is up-to-date.
+ * @mrs: array of &struct bin_attribute, one for each MR.
+ *
+ * This internal structure contains everything needed to implement
+ * tm_digest_read() and tm_digest_write().
+ *
+ * Given tm->refresh() is potentially expensive, tm_digest_read() caches MR
+ * values and calls tm->refresh() only when necessary. Only live MRs (i.e., with
+ * %TSM_MR_F_LIVE set) can trigger tm->refresh(), while others are assumed to
+ * retain their values from the last tm->write(). @in_sync tracks if there have
+ * been tm->write() calls since the last tm->refresh(). That is, tm->refresh()
+ * will be called only when a live MR is being read and the cache is stale
+ * (@in_sync is %false).
+ *
+ * tm_digest_write() sets @in_sync to %false and calls tm->write(), whose
+ * semantics is arch and MR specific. Most (if not all) writable MRs support the
+ * extension semantics (i.e., tm->write() extends the input buffer into the MR).
+ */
+struct tm_context {
+	struct rw_semaphore rwsem;
+	struct attribute_group agrp;
+	const struct tsm_measurements *tm;
+	bool in_sync;
+	struct bin_attribute mrs[];
+};
+
+static ssize_t tm_digest_read(struct file *filp, struct kobject *kobj,
+			      const struct bin_attribute *attr, char *buffer,
+			      loff_t off, size_t count)
+{
+	struct tm_context *ctx;
+	const struct tsm_measurement_register *mr;
+	int rc;
+
+	ctx = attr->private;
+	rc = down_read_interruptible(&ctx->rwsem);
+	if (rc)
+		return rc;
+
+	mr = &ctx->tm->mrs[attr - ctx->mrs];
+
+	/*
+	 * @ctx->in_sync indicates if the MR cache is stale. It is a global
+	 * instead of a per-MR flag for simplicity, as most (if not all) archs
+	 * allow reading all MRs in oneshot.
+	 *
+	 * ctx->refresh() is necessary only for LIVE MRs, while others retain
+	 * their values from their respective last ctx->write().
+	 */
+	if ((mr->mr_flags & TSM_MR_F_LIVE) && !ctx->in_sync) {
+		up_read(&ctx->rwsem);
+
+		rc = down_write_killable(&ctx->rwsem);
+		if (rc)
+			return rc;
+
+		if (!ctx->in_sync) {
+			rc = ctx->tm->refresh(ctx->tm, mr);
+			ctx->in_sync = !rc;
+			trace_tsm_mr_refresh(mr, rc);
+		}
+
+		downgrade_write(&ctx->rwsem);
+	}
+
+	memcpy(buffer, mr->mr_value + off, count);
+	trace_tsm_mr_read(mr);
+
+	up_read(&ctx->rwsem);
+	return rc ?: count;
+}
+
+static ssize_t tm_digest_write(struct file *filp, struct kobject *kobj,
+			       const struct bin_attribute *attr, char *buffer,
+			       loff_t off, size_t count)
+{
+	struct tm_context *ctx;
+	const struct tsm_measurement_register *mr;
+	ssize_t rc;
+
+	/* partial writes are not supported */
+	if (off != 0 || count != attr->size)
+		return -EINVAL;
+
+	ctx = attr->private;
+	mr = &ctx->tm->mrs[attr - ctx->mrs];
+	trace_tsm_mr_write(mr, buffer);
+
+	rc = down_write_killable(&ctx->rwsem);
+	if (rc)
+		return rc;
+
+	rc = ctx->tm->write(ctx->tm, mr, buffer);
+
+	/* mark MR cache stale */
+	if (!rc)
+		ctx->in_sync = false;
+
+	up_write(&ctx->rwsem);
+	return rc ?: count;
+}
+
+/**
+ * tsm_mr_create_attribute_group() - creates an attribute group for measurement
+ * registers (MRs)
+ * @tm: pointer to &struct tsm_measurements containing the MR definitions.
+ *
+ * This function creates attributes corresponding to the MR definitions
+ * provided by @tm->mrs.
+ *
+ * The created attributes will reference @tm and its members. The caller must
+ * not free @tm until after tsm_mr_free_attribute_group() is called.
+ *
+ * Context: Process context. May sleep due to memory allocation.
+ *
+ * Return:
+ * * On success, the pointer to a an attribute group is returned; otherwise
+ * * %-EINVAL - Invalid MR definitions.
+ * * %-ENOMEM - Out of memory.
+ */
+const struct attribute_group *
+tsm_mr_create_attribute_group(const struct tsm_measurements *tm)
+{
+	size_t nlen;
+
+	if (!tm || !tm->mrs)
+		return ERR_PTR(-EINVAL);
+
+	/* aggregated length of all MR names */
+	nlen = 0;
+	for (size_t i = 0; i < tm->nr_mrs; ++i) {
+		if ((tm->mrs[i].mr_flags & TSM_MR_F_LIVE) && !tm->refresh)
+			return ERR_PTR(-EINVAL);
+
+		if ((tm->mrs[i].mr_flags & TSM_MR_F_WRITABLE) && !tm->write)
+			return ERR_PTR(-EINVAL);
+
+		if (!tm->mrs[i].mr_name)
+			return ERR_PTR(-EINVAL);
+
+		if (tm->mrs[i].mr_flags & TSM_MR_F_NOHASH)
+			continue;
+
+		if (tm->mrs[i].mr_hash >= HASH_ALGO__LAST)
+			return ERR_PTR(-EINVAL);
+
+		/* MR sysfs attribute names have the form of MRNAME:HASH */
+		nlen += strlen(tm->mrs[i].mr_name) + 1 +
+			strlen(hash_algo_name[tm->mrs[i].mr_hash]) + 1;
+	}
+
+	/*
+	 * @bas and the MR name strings are combined into a single allocation
+	 * so that we don't have to free MR names one-by-one in
+	 * tsm_mr_free_attribute_group()
+	 */
+	struct bin_attribute **bas __free(kfree) =
+		kzalloc(sizeof(*bas) * (tm->nr_mrs + 1) + nlen, GFP_KERNEL);
+	struct tm_context *ctx __free(kfree) =
+		kzalloc(struct_size(ctx, mrs, tm->nr_mrs), GFP_KERNEL);
+	char *name, *end;
+
+	if (!ctx || !bas)
+		return ERR_PTR(-ENOMEM);
+
+	/* @bas is followed immediately by MR name strings */
+	name = (char *)&bas[tm->nr_mrs + 1];
+	end = name + nlen;
+
+	for (size_t i = 0; i < tm->nr_mrs; ++i) {
+		bas[i] = &ctx->mrs[i];
+		sysfs_bin_attr_init(bas[i]);
+
+		if (tm->mrs[i].mr_flags & TSM_MR_F_NOHASH)
+			bas[i]->attr.name = tm->mrs[i].mr_name;
+		else if (name < end) {
+			bas[i]->attr.name = name;
+			name += snprintf(name, end - name, "%s:%s",
+					 tm->mrs[i].mr_name,
+					 hash_algo_name[tm->mrs[i].mr_hash]);
+			++name;
+		} else
+			return ERR_PTR(-EINVAL);
+
+		/* check for duplicated MR definitions */
+		for (size_t j = 0; j < i; ++j)
+			if (!strcmp(bas[i]->attr.name, bas[j]->attr.name))
+				return ERR_PTR(-EINVAL);
+
+		if (tm->mrs[i].mr_flags & TSM_MR_F_READABLE) {
+			bas[i]->attr.mode |= 0444;
+			bas[i]->read_new = tm_digest_read;
+		}
+
+		if (tm->mrs[i].mr_flags & TSM_MR_F_WRITABLE) {
+			bas[i]->attr.mode |= 0200;
+			bas[i]->write_new = tm_digest_write;
+		}
+
+		bas[i]->size = tm->mrs[i].mr_size;
+		bas[i]->private = ctx;
+	}
+
+	if (name != end)
+		return ERR_PTR(-EINVAL);
+
+	init_rwsem(&ctx->rwsem);
+	ctx->agrp.name = "mr";
+	ctx->agrp.bin_attrs = no_free_ptr(bas);
+	ctx->tm = tm;
+	return &no_free_ptr(ctx)->agrp;
+}
+EXPORT_SYMBOL_GPL(tsm_mr_create_attribute_group);
+
+/**
+ * tsm_mr_free_attribute_group() - frees the attribute group returned by
+ * tsm_mr_create_attribute_group()
+ * @attr_grp: attribute group returned by tsm_mr_create_attribute_group()
+ *
+ * Context: Process context.
+ */
+void tsm_mr_free_attribute_group(const struct attribute_group *attr_grp)
+{
+	if (!IS_ERR_OR_NULL(attr_grp)) {
+		kfree(attr_grp->bin_attrs);
+		kfree(container_of(attr_grp, struct tm_context, agrp));
+	}
+}
+EXPORT_SYMBOL_GPL(tsm_mr_free_attribute_group);
diff --git a/include/linux/tsm-mr.h b/include/linux/tsm-mr.h
new file mode 100644
index 000000000000..3d4576849885
--- /dev/null
+++ b/include/linux/tsm-mr.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __TSM_MR_H
+#define __TSM_MR_H
+
+#include <crypto/hash_info.h>
+
+/**
+ * struct tsm_measurement_register - describes an architectural measurement
+ * register (MR)
+ * @mr_name: name of the MR
+ * @mr_value: buffer containing the current value of the MR
+ * @mr_size: size of the MR - typically the digest size of @mr_hash
+ * @mr_flags: bitwise OR of one or more flags, detailed below
+ * @mr_hash: optional hash identifier defined in include/uapi/linux/hash_info.h.
+ *
+ * A CC guest driver encloses an array of this structure in struct
+ * tsm_measurements to detail the measurement facility supported by the
+ * underlying CC hardware.
+ *
+ * @mr_name and @mr_value must stay valid until this structure is no longer in
+ * use.
+ *
+ * @mr_flags is the bitwise-OR of zero or more of the flags below.
+ *
+ * * %TSM_MR_F_READABLE - the sysfs attribute corresponding to this MR is readable.
+ * * %TSM_MR_F_WRITABLE - the sysfs attribute corresponding to this MR is writable.
+ *   The semantics is typically to extend the MR but could vary depending on the
+ *   architecture and the MR.
+ * * %TSM_MR_F_LIVE - this MR's value may differ from the last value written, so
+ *   must be read back from the underlying CC hardware/firmware.
+ * * %TSM_MR_F_RTMR - bitwise-OR of %TSM_MR_F_LIVE and %TSM_MR_F_WRITABLE.
+ * * %TSM_MR_F_NOHASH - this MR does NOT have an associated hash algorithm.
+ *   @mr_hash will be ignored when this flag is set.
+ */
+struct tsm_measurement_register {
+	const char *mr_name;
+	void *mr_value;
+	u32 mr_size;
+	u32 mr_flags;
+	enum hash_algo mr_hash;
+};
+
+#define TSM_MR_F_NOHASH 1
+#define TSM_MR_F_WRITABLE 2
+#define TSM_MR_F_READABLE 4
+#define TSM_MR_F_LIVE 8
+#define TSM_MR_F_RTMR (TSM_MR_F_LIVE | TSM_MR_F_WRITABLE)
+
+#define TSM_MR_(mr, hash)                              \
+	.mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, \
+	.mr_hash = HASH_ALGO_##hash, .mr_flags = TSM_MR_F_READABLE
+
+/**
+ * struct tsm_measurements - defines the CC architecture specific measurement
+ * facility and methods for updating measurement registers (MRs)
+ * @mrs: Array of MR definitions.
+ * @nr_mrs: Number of elements in @mrs.
+ * @refresh: Callback function to load/sync all MRs from TVM hardware/firmware
+ *           into the kernel cache.
+ * @write: Callback function to write to the MR specified by the parameter @mr.
+ *         Typically, writing to an MR extends the input buffer to that MR.
+ *
+ * @refresh takes two parameters:
+ *
+ * * @tm - points back to this structure.
+ * * @mr - points to the MR (an element of @mrs) being read (hence triggered
+ *   this callback).
+ *
+ * Note that @refresh is invoked only when an MR with %TSM_MR_F_LIVE set is
+ * being read and the cache is stale. However, @refresh must reload not only
+ * the MR being read (@mr) but also all MRs with %TSM_MR_F_LIVE set.
+ *
+ * @write takes an additional parameter besides @tm and @mr:
+ *
+ * * @data - contains the bytes to write and whose size is @mr->mr_size.
+ *
+ * Both @refresh and @write should return 0 on success and an appropriate error
+ * code on failure.
+ */
+struct tsm_measurements {
+	const struct tsm_measurement_register *mrs;
+	size_t nr_mrs;
+	int (*refresh)(const struct tsm_measurements *tm,
+		       const struct tsm_measurement_register *mr);
+	int (*write)(const struct tsm_measurements *tm,
+		     const struct tsm_measurement_register *mr, const u8 *data);
+};
+
+const struct attribute_group *
+tsm_mr_create_attribute_group(const struct tsm_measurements *tm);
+void tsm_mr_free_attribute_group(const struct attribute_group *attr_grp);
+
+#endif
diff --git a/include/trace/events/tsm_mr.h b/include/trace/events/tsm_mr.h
new file mode 100644
index 000000000000..f40de4ad3e2d
--- /dev/null
+++ b/include/trace/events/tsm_mr.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM tsm_mr
+
+#if !defined(_TRACE_TSM_MR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TSM_MR_H
+
+#include <linux/tracepoint.h>
+#include <linux/tsm-mr.h>
+
+TRACE_EVENT(tsm_mr_read,
+
+	TP_PROTO(const struct tsm_measurement_register *mr),
+
+	TP_ARGS(mr),
+
+	TP_STRUCT__entry(
+		__string(mr, mr->mr_name)
+		__string(hash, mr->mr_flags & TSM_MR_F_NOHASH ?
+			 "data" : hash_algo_name[mr->mr_hash])
+		__dynamic_array(u8, d, mr->mr_size)
+	),
+
+	TP_fast_assign(
+		__assign_str(mr);
+		__assign_str(hash);
+		memcpy(__get_dynamic_array(d), mr->mr_value, __get_dynamic_array_len(d));
+	),
+
+	TP_printk("[%s] %s:%s", __get_str(mr), __get_str(hash),
+		  __print_hex_str(__get_dynamic_array(d), __get_dynamic_array_len(d)))
+);
+
+TRACE_EVENT(tsm_mr_refresh,
+
+	TP_PROTO(const struct tsm_measurement_register *mr, int rc),
+
+	TP_ARGS(mr, rc),
+
+	TP_STRUCT__entry(
+		__string(mr, mr->mr_name)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		__assign_str(mr);
+		__entry->rc = rc;
+	),
+
+	TP_printk("[%s] %s:%d", __get_str(mr),
+		  __entry->rc ? "failed" : "succeeded", __entry->rc)
+);
+
+TRACE_EVENT(tsm_mr_write,
+
+	TP_PROTO(const struct tsm_measurement_register *mr, const u8 *data),
+
+	TP_ARGS(mr, data),
+
+	TP_STRUCT__entry(
+		__string(mr, mr->mr_name)
+		__string(hash, mr->mr_flags & TSM_MR_F_NOHASH ?
+			 "data" : hash_algo_name[mr->mr_hash])
+		__dynamic_array(u8, d, mr->mr_size)
+	),
+
+	TP_fast_assign(
+		__assign_str(mr);
+		__assign_str(hash);
+		memcpy(__get_dynamic_array(d), data, __get_dynamic_array_len(d));
+	),
+
+	TP_printk("[%s] %s:%s", __get_str(mr), __get_str(hash),
+		  __print_hex_str(__get_dynamic_array(d), __get_dynamic_array_len(d)))
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.43.0


