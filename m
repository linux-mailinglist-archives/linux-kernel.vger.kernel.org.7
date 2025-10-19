Return-Path: <linux-kernel+bounces-859775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FABEE8AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A19189BDAC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C62EB5A9;
	Sun, 19 Oct 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko5oTOLT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E981E0DD9
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760887229; cv=none; b=O1FINRhYHpq/XRN8IbIy8AGEOhAjAVNsJEBQaSjNduRdSbu52LaSHYgnpj5lJra42xc9I8XzSn9Vo3NL1SyGqxYlNcDUT3VtOL67Hh/fLkNaBvZo2mPqYhlBRyRr1yDjX7pbMzjzpqXo7WuGRoYMdwOSOSRw5AjbaodTHVVFLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760887229; c=relaxed/simple;
	bh=cNjpz4hZNJmVrvl9B2SFuN3WAlWTG+z2D8+nRo9WN5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpGvIwbtZzNLeRYn1F8X6pX10K77IHddL6iKT6LrWgY3KpkPsxx+X5UmbVF110G/J+FJAmLF52HlC7SeXA9YDus83/QFP0cxUAgr+2g8F8G+Ay7mAo0xsNI9SPovIoIGa2BNCYmPBrspJweo/FUuoyKZyvtF1k9t8faJHdkDQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko5oTOLT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760887228; x=1792423228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cNjpz4hZNJmVrvl9B2SFuN3WAlWTG+z2D8+nRo9WN5M=;
  b=Ko5oTOLTF6+C4HQuwXNw8O3cEVT/3MH4UctOZp25sOp0licntOjFhlYY
   sXGjbN6IXXTa6n9Y1efxr+IUuqYuM5RFwIrnqaPrPqxM+Q7EzLekuuWkI
   0x5La1nVpEpMv/2FTsTAd2bTeKyuL0z4ZyUaJA47dbNH3uIgU9zvmWv48
   q2gKMp+3e5nqc6YYxoXlLobihoMFFtjCfCO0iLElOhC+AnHbQp0RJ6tme
   P7z9e090IFFqEZ9mzid/J3YXjHrkctoQhF332LvjZQ2NBsgvAMZGoAhdp
   HHJXwqVg41JTsrxjHMXvGos6p5p97UW0UPJSyt80GCHOGv/mKemPZwa4H
   w==;
X-CSE-ConnectionGUID: rxBqCyujSL+yQ9A7do6+9A==
X-CSE-MsgGUID: MNmMosdRTM2GZfXoYb9H8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62938152"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="62938152"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 08:20:28 -0700
X-CSE-ConnectionGUID: kxbWKDMLTxWete2e2BopsA==
X-CSE-MsgGUID: gBvwE/G4TQy1J3O2OA9rOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="188442116"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 08:20:25 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] mtd: intel-dg: wake card on operations
Date: Sun, 19 Oct 2025 18:01:45 +0300
Message-ID: <20251019150145.3228079-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable runtime PM in mtd driver to notify parent graphics driver
that whole card should be kept awake while nvm operations are
performed through this driver.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 72 +++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index b438ee5aacc3..9c8d1405219c 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -15,14 +15,18 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pm_runtime.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
+#define INTEL_DG_NVM_RPM_TIMEOUT_MS 500
+
 struct intel_dg_nvm {
 	struct kref refcnt;
 	struct mtd_info mtd;
+	struct device *dev;
 	struct mutex lock; /* region access lock */
 	void __iomem *base;
 	void __iomem *base2;
@@ -421,6 +425,8 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
 	unsigned int i, n;
 	int ret;
 
+	nvm->dev = device;
+
 	/* clean error register, previous errors are ignored */
 	idg_nvm_error(nvm);
 
@@ -494,6 +500,7 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 	size_t total_len;
 	unsigned int idx;
 	ssize_t bytes;
+	int ret = 0;
 	loff_t from;
 	size_t len;
 	u8 region;
@@ -512,20 +519,28 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 	total_len = info->len;
 	addr = info->addr;
 
+	ret = pm_runtime_resume_and_get(nvm->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %d\n", ret);
+		return ret;
+	}
+
 	guard(mutex)(&nvm->lock);
 
 	while (total_len > 0) {
 		if (!IS_ALIGNED(addr, SZ_4K) || !IS_ALIGNED(total_len, SZ_4K)) {
 			dev_err(&mtd->dev, "unaligned erase %llx %zx\n", addr, total_len);
 			info->fail_addr = addr;
-			return -ERANGE;
+			ret = -ERANGE;
+			break;
 		}
 
 		idx = idg_nvm_get_region(nvm, addr);
 		if (idx >= nvm->nregions) {
 			dev_err(&mtd->dev, "out of range");
 			info->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
-			return -ERANGE;
+			ret = -ERANGE;
+			break;
 		}
 
 		from = addr - nvm->regions[idx].offset;
@@ -541,14 +556,17 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 		if (bytes < 0) {
 			dev_dbg(&mtd->dev, "erase failed with %zd\n", bytes);
 			info->fail_addr += nvm->regions[idx].offset;
-			return bytes;
+			ret = bytes;
+			break;
 		}
 
 		addr += len;
 		total_len -= len;
 	}
 
-	return 0;
+	pm_runtime_mark_last_busy(nvm->dev);
+	pm_runtime_put_autosuspend(nvm->dev);
+	return ret;
 }
 
 static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
@@ -577,17 +595,25 @@ static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (len > nvm->regions[idx].size - from)
 		len = nvm->regions[idx].size - from;
 
+	ret = pm_runtime_resume_and_get(nvm->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	guard(mutex)(&nvm->lock);
 
 	ret = idg_read(nvm, region, from, len, buf);
 	if (ret < 0) {
 		dev_dbg(&mtd->dev, "read failed with %zd\n", ret);
-		return ret;
+	} else {
+		*retlen = ret;
+		ret = 0;
 	}
 
-	*retlen = ret;
-
-	return 0;
+	pm_runtime_mark_last_busy(nvm->dev);
+	pm_runtime_put_autosuspend(nvm->dev);
+	return ret;
 }
 
 static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
@@ -616,17 +642,25 @@ static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (len > nvm->regions[idx].size - to)
 		len = nvm->regions[idx].size - to;
 
+	ret = pm_runtime_resume_and_get(nvm->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	guard(mutex)(&nvm->lock);
 
 	ret = idg_write(nvm, region, to, len, buf);
 	if (ret < 0) {
 		dev_dbg(&mtd->dev, "write failed with %zd\n", ret);
-		return ret;
+	} else {
+		*retlen = ret;
+		ret = 0;
 	}
 
-	*retlen = ret;
-
-	return 0;
+	pm_runtime_mark_last_busy(nvm->dev);
+	pm_runtime_put_autosuspend(nvm->dev);
+	return ret;
 }
 
 static void intel_dg_nvm_release(struct kref *kref)
@@ -753,6 +787,17 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	}
 	nvm->nregions = n; /* in case where kasprintf fail */
 
+	devm_pm_runtime_enable(device);
+
+	pm_runtime_set_autosuspend_delay(device, INTEL_DG_NVM_RPM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(device);
+
+	ret = pm_runtime_resume_and_get(device);
+	if (ret < 0) {
+		dev_err(device, "rpm: get failed %d\n", ret);
+		goto err_norpm;
+	}
+
 	nvm->base = devm_ioremap_resource(device, &invm->bar);
 	if (IS_ERR(nvm->base)) {
 		ret = PTR_ERR(nvm->base);
@@ -781,9 +826,12 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(&aux_dev->dev, nvm);
 
+	pm_runtime_put(device);
 	return 0;
 
 err:
+	pm_runtime_put(device);
+err_norpm:
 	kref_put(&nvm->refcnt, intel_dg_nvm_release);
 	return ret;
 }
-- 
2.43.0


