Return-Path: <linux-kernel+bounces-690458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12191ADD0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 17:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFB77AB787
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB92E9728;
	Tue, 17 Jun 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2dL9G9h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A22E92CB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172760; cv=none; b=N2lk4stUD/Dk3vv46ZtdpYT3hVspOoHoXwH3y1l442fdeE7guW6DvQVJYcU27zoQrVeidoEszgh4cL5PqnSWl2pcpLfbrMqO3ya3Af2T6+7S4J0XOFAsn2/P5LLP1MwDqfvHAxiY1HbDn353cH4gqoQSLbP6ocxhfU/DegTXm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172760; c=relaxed/simple;
	bh=1rWZu6zk+/8Dn/O0RQ+wvJF7YY6eB0G1xr7Z4PhkCPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlBJbUOtOyifmsobJqfJmAyXGfx8sVkzsnhMJVayV4gqzDyaFgfDuYW7IVvjhF57LWXv9P0L855icpDEoT4O7z5E40JtMhjrWBQUl+Oe09QqxJfw9VwDUH5UyP712Mg6ORp8su8rm9tgTEInnDb9tr46zSLJXtUXyd0TidFU6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2dL9G9h; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750172759; x=1781708759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1rWZu6zk+/8Dn/O0RQ+wvJF7YY6eB0G1xr7Z4PhkCPE=;
  b=K2dL9G9hQqGULHQUNv1Uuk91SJHjQkpyqwyjMTTOWu/yFZXQbxWlGWLY
   VxeyWfhNAiWc5LFs9DOVXw8atVy9ZXCvB8dWQYcPvLFstKMXoneDnL4BQ
   xv47zSkCM8ZILxASWolQXcAAggAdgxQGp6JnOz3+FTM2oCJkqQtulLIvs
   XmPXeJc7wuw1tzIVHQNU5Pv8bIW+kVYYhlQMK5tU+xEjvIDcyUybw9Xss
   3xMUrBm0UiekW0ecqPlt5K1ojQR4ZggB2ED3XGp4zNCjx2YthkvHxjmEb
   xzUpbk9RitdSwhyKPBpo9QIeqS8E+MLhZaZrqFUqy61S2cd6pjg8PddGB
   w==;
X-CSE-ConnectionGUID: droClPp4SNaCL5gCvQD20Q==
X-CSE-MsgGUID: MBOpuSqiQH6QDHR46aDUZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63008842"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="63008842"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:05:58 -0700
X-CSE-ConnectionGUID: PLN/m13ET12KKwAq0tV9yg==
X-CSE-MsgGUID: 7nHd4GGnRy2RaaouO0/3vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="152672357"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:05:49 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Karthik Poosa <karthik.poosa@intel.com>,
	Raag Jadav <raag.jadav@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	linux-mtd@lists.infradead.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	Vitaly Lubart <lubvital@gmail.com>
Subject: [PATCH v14 4/8] mtd: intel-dg: register with mtd
Date: Tue, 17 Jun 2025 17:51:54 +0300
Message-ID: <20250617145159.3803852-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617145159.3803852-1-alexander.usyskin@intel.com>
References: <20250617145159.3803852-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the on-die nvm device with the mtd subsystem.
Refcount nvm object on _get and _put mtd callbacks.
For erase operation address and size should be 4K aligned.
For write operation address and size has to be 4bytes aligned.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Co-developed-by: Vitaly Lubart <lubvital@gmail.com>
Signed-off-by: Vitaly Lubart <lubvital@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 228 ++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index 4d6e2c009b45..6d971fb77938 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/intel_dg_nvm_aux.h>
@@ -12,6 +13,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
@@ -19,6 +22,8 @@
 
 struct intel_dg_nvm {
 	struct kref refcnt;
+	struct mtd_info mtd;
+	struct mutex lock; /* region access lock */
 	void __iomem *base;
 	size_t size;
 	unsigned int nregions;
@@ -185,7 +190,6 @@ static int idg_nvm_is_valid(struct intel_dg_nvm *nvm)
 	return 0;
 }
 
-__maybe_unused
 static unsigned int idg_nvm_get_region(const struct intel_dg_nvm *nvm, loff_t from)
 {
 	unsigned int i;
@@ -217,7 +221,6 @@ static ssize_t idg_nvm_rewrite_partial(struct intel_dg_nvm *nvm, loff_t to,
 	return len;
 }
 
-__maybe_unused
 static ssize_t idg_write(struct intel_dg_nvm *nvm, u8 region,
 			 loff_t to, size_t len, const unsigned char *buf)
 {
@@ -274,7 +277,6 @@ static ssize_t idg_write(struct intel_dg_nvm *nvm, u8 region,
 	return len;
 }
 
-__maybe_unused
 static ssize_t idg_read(struct intel_dg_nvm *nvm, u8 region,
 			loff_t from, size_t len, unsigned char *buf)
 {
@@ -333,7 +335,6 @@ static ssize_t idg_read(struct intel_dg_nvm *nvm, u8 region,
 	return len;
 }
 
-__maybe_unused
 static ssize_t
 idg_erase(struct intel_dg_nvm *nvm, u8 region, loff_t from, u64 len, u64 *fail_addr)
 {
@@ -422,6 +423,147 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device)
 	return n;
 }
 
+static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
+{
+	struct intel_dg_nvm *nvm = mtd->priv;
+	size_t total_len;
+	unsigned int idx;
+	ssize_t bytes;
+	loff_t from;
+	size_t len;
+	u8 region;
+	u64 addr;
+
+	if (WARN_ON(!nvm))
+		return -EINVAL;
+
+	if (!IS_ALIGNED(info->addr, SZ_4K) || !IS_ALIGNED(info->len, SZ_4K)) {
+		dev_err(&mtd->dev, "unaligned erase %llx %llx\n",
+			info->addr, info->len);
+		info->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
+		return -EINVAL;
+	}
+
+	total_len = info->len;
+	addr = info->addr;
+
+	guard(mutex)(&nvm->lock);
+
+	while (total_len > 0) {
+		if (!IS_ALIGNED(addr, SZ_4K) || !IS_ALIGNED(total_len, SZ_4K)) {
+			dev_err(&mtd->dev, "unaligned erase %llx %zx\n", addr, total_len);
+			info->fail_addr = addr;
+			return -ERANGE;
+		}
+
+		idx = idg_nvm_get_region(nvm, addr);
+		if (idx >= nvm->nregions) {
+			dev_err(&mtd->dev, "out of range");
+			info->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
+			return -ERANGE;
+		}
+
+		from = addr - nvm->regions[idx].offset;
+		region = nvm->regions[idx].id;
+		len = total_len;
+		if (len > nvm->regions[idx].size - from)
+			len = nvm->regions[idx].size - from;
+
+		dev_dbg(&mtd->dev, "erasing region[%d] %s from %llx len %zx\n",
+			region, nvm->regions[idx].name, from, len);
+
+		bytes = idg_erase(nvm, region, from, len, &info->fail_addr);
+		if (bytes < 0) {
+			dev_dbg(&mtd->dev, "erase failed with %zd\n", bytes);
+			info->fail_addr += nvm->regions[idx].offset;
+			return bytes;
+		}
+
+		addr += len;
+		total_len -= len;
+	}
+
+	return 0;
+}
+
+static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
+			     size_t *retlen, u_char *buf)
+{
+	struct intel_dg_nvm *nvm = mtd->priv;
+	unsigned int idx;
+	ssize_t ret;
+	u8 region;
+
+	if (WARN_ON(!nvm))
+		return -EINVAL;
+
+	idx = idg_nvm_get_region(nvm, from);
+
+	dev_dbg(&mtd->dev, "reading region[%d] %s from %lld len %zd\n",
+		nvm->regions[idx].id, nvm->regions[idx].name, from, len);
+
+	if (idx >= nvm->nregions) {
+		dev_err(&mtd->dev, "out of range");
+		return -ERANGE;
+	}
+
+	from -= nvm->regions[idx].offset;
+	region = nvm->regions[idx].id;
+	if (len > nvm->regions[idx].size - from)
+		len = nvm->regions[idx].size - from;
+
+	guard(mutex)(&nvm->lock);
+
+	ret = idg_read(nvm, region, from, len, buf);
+	if (ret < 0) {
+		dev_dbg(&mtd->dev, "read failed with %zd\n", ret);
+		return ret;
+	}
+
+	*retlen = ret;
+
+	return 0;
+}
+
+static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
+			      size_t *retlen, const u_char *buf)
+{
+	struct intel_dg_nvm *nvm = mtd->priv;
+	unsigned int idx;
+	ssize_t ret;
+	u8 region;
+
+	if (WARN_ON(!nvm))
+		return -EINVAL;
+
+	idx = idg_nvm_get_region(nvm, to);
+
+	dev_dbg(&mtd->dev, "writing region[%d] %s to %lld len %zd\n",
+		nvm->regions[idx].id, nvm->regions[idx].name, to, len);
+
+	if (idx >= nvm->nregions) {
+		dev_err(&mtd->dev, "out of range");
+		return -ERANGE;
+	}
+
+	to -= nvm->regions[idx].offset;
+	region = nvm->regions[idx].id;
+	if (len > nvm->regions[idx].size - to)
+		len = nvm->regions[idx].size - to;
+
+	guard(mutex)(&nvm->lock);
+
+	ret = idg_write(nvm, region, to, len, buf);
+	if (ret < 0) {
+		dev_dbg(&mtd->dev, "write failed with %zd\n", ret);
+		return ret;
+	}
+
+	*retlen = ret;
+
+	return 0;
+}
+
 static void intel_dg_nvm_release(struct kref *kref)
 {
 	struct intel_dg_nvm *nvm = container_of(kref, struct intel_dg_nvm, refcnt);
@@ -430,9 +572,78 @@ static void intel_dg_nvm_release(struct kref *kref)
 	pr_debug("freeing intel_dg nvm\n");
 	for (i = 0; i < nvm->nregions; i++)
 		kfree(nvm->regions[i].name);
+	mutex_destroy(&nvm->lock);
 	kfree(nvm);
 }
 
+static int intel_dg_mtd_get_device(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+	struct intel_dg_nvm *nvm = master->priv;
+
+	if (WARN_ON(!nvm))
+		return -EINVAL;
+	pr_debug("get mtd %s %d\n", mtd->name, kref_read(&nvm->refcnt));
+	kref_get(&nvm->refcnt);
+
+	return 0;
+}
+
+static void intel_dg_mtd_put_device(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+	struct intel_dg_nvm *nvm = master->priv;
+
+	if (WARN_ON(!nvm))
+		return;
+	pr_debug("put mtd %s %d\n", mtd->name, kref_read(&nvm->refcnt));
+	kref_put(&nvm->refcnt, intel_dg_nvm_release);
+}
+
+static int intel_dg_nvm_init_mtd(struct intel_dg_nvm *nvm, struct device *device,
+				 unsigned int nparts, bool writable_override)
+{
+	struct mtd_partition *parts = NULL;
+	unsigned int i, n;
+	int ret;
+
+	dev_dbg(device, "registering with mtd\n");
+
+	nvm->mtd.owner = THIS_MODULE;
+	nvm->mtd.dev.parent = device;
+	nvm->mtd.flags = MTD_CAP_NORFLASH;
+	nvm->mtd.type = MTD_DATAFLASH;
+	nvm->mtd.priv = nvm;
+	nvm->mtd._write = intel_dg_mtd_write;
+	nvm->mtd._read = intel_dg_mtd_read;
+	nvm->mtd._erase = intel_dg_mtd_erase;
+	nvm->mtd._get_device = intel_dg_mtd_get_device;
+	nvm->mtd._put_device = intel_dg_mtd_put_device;
+	nvm->mtd.writesize = SZ_1; /* 1 byte granularity */
+	nvm->mtd.erasesize = SZ_4K; /* 4K bytes granularity */
+	nvm->mtd.size = nvm->size;
+
+	parts = kcalloc(nvm->nregions, sizeof(*parts), GFP_KERNEL);
+	if (!parts)
+		return -ENOMEM;
+
+	for (i = 0, n = 0; i < nvm->nregions && n < nparts; i++) {
+		if (!nvm->regions[i].is_readable)
+			continue;
+		parts[n].name = nvm->regions[i].name;
+		parts[n].offset  = nvm->regions[i].offset;
+		parts[n].size = nvm->regions[i].size;
+		if (!nvm->regions[i].is_writable && !writable_override)
+			parts[n].mask_flags = MTD_WRITEABLE;
+		n++;
+	}
+
+	ret = mtd_device_register(&nvm->mtd, parts, n);
+
+	kfree(parts);
+	return ret;
+}
+
 static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 			      const struct auxiliary_device_id *aux_dev_id)
 {
@@ -461,6 +672,7 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 		return -ENOMEM;
 
 	kref_init(&nvm->refcnt);
+	mutex_init(&nvm->lock);
 
 	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
 		if (!invm->regions[i].name)
@@ -488,6 +700,12 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 		goto err;
 	}
 
+	ret = intel_dg_nvm_init_mtd(nvm, device, ret, invm->writable_override);
+	if (ret) {
+		dev_err(device, "failed init mtd %d\n", ret);
+		goto err;
+	}
+
 	dev_set_drvdata(&aux_dev->dev, nvm);
 
 	return 0;
@@ -504,6 +722,8 @@ static void intel_dg_mtd_remove(struct auxiliary_device *aux_dev)
 	if (!nvm)
 		return;
 
+	mtd_device_unregister(&nvm->mtd);
+
 	dev_set_drvdata(&aux_dev->dev, NULL);
 
 	kref_put(&nvm->refcnt, intel_dg_nvm_release);
-- 
2.43.0


