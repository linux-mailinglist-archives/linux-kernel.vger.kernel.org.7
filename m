Return-Path: <linux-kernel+bounces-862930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94FBF68E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615754251A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814CE17BB35;
	Tue, 21 Oct 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8Ikbf72"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7533343C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051089; cv=none; b=seW8mvq0sUmYCeAXP7RSTkYG5OxGHQ6/Df7xozVQigUUpBJaxifYDxOjcPq1eDghDa6RSmdfCoXI533qlsa0oQthqznNEXdeNY/y/xAIk3DS47DZL++oKlOoqUw9peAwK/KVn2evEhL4vWv0GEoT9wTtwgFvySNI8fENFI8rUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051089; c=relaxed/simple;
	bh=jcnd0yDPXv2FFZ0tUi7p+G4qgcA41pgSy7DuPQOxb9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lan6aYBvaLW7APtQOEUHmw0XjGhv8CCW+YNXLfxfEfF/D69iIcqZyjyNTppoHACZ74qctkzvvbAY0UPyfLv/uk6hfWCp+qBQ1TOywK+3fSmdvbw+Te+5GgGYfYCpCJg60BTc2r6VRbeSxO7xfNG4hoO6Sr/6J08bPTyA7BjxsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8Ikbf72; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761051087; x=1792587087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jcnd0yDPXv2FFZ0tUi7p+G4qgcA41pgSy7DuPQOxb9c=;
  b=F8Ikbf72IqECbxrE9EWN4Ji1E/ZgnWECZ75SE0gumfV4sd0xHtO5MCO7
   ZXoxNhrPM0sDB1jzd43V3R6L4qo00PhnTzpe4lD5pd0D5mTbDXsmw2rtm
   6fIXlZK8jdbgONkrhCX53I9GC294ampK4eE+zTd73z+A8OSlQBr30RL9/
   SdgZYfl4Q5iQ9YLTdK4/UeipmtB0jnNkcWz5yDIwxLKNv4Wkvd+vLpYaY
   Do9O7ybLTbDL3Hlyo/g81T0cxIp1C1uGolKPgHOGPcjzvg3xJ4IREpPuw
   9WmuF/goP/nUsp+HUeP5KPsQyFoH3WXOuFOgK7z1EgQcTdMAZbK0745Mr
   Q==;
X-CSE-ConnectionGUID: kxU97QXfQCiKcqoNWCLu1A==
X-CSE-MsgGUID: bzyB7sxsSW6JGUg8TrpziA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74294550"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="74294550"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:51:27 -0700
X-CSE-ConnectionGUID: /bFMHN06SAeVDS7Jvez1xA==
X-CSE-MsgGUID: o08R1Yq0S4qNQ4KK+ydQgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="214539998"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:51:24 -0700
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
Subject: [PATCH v2] mtd: intel-dg: wake card on operations
Date: Tue, 21 Oct 2025 15:32:46 +0300
Message-ID: <20251021123246.3629282-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel DG cards do not have separate power control for
persistent memory.
The memory is available when the whole card is awake.

Enable runtime PM in mtd driver to notify parent graphics driver
that whole card should be kept awake while nvm operations are
performed through this driver.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

V2: Address review comments (Andrey S)

 drivers/mtd/devices/mtd_intel_dg.c | 70 +++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index b438ee5aacc3..d1916ec5e087 100644
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
 
@@ -498,6 +504,7 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 	size_t len;
 	u8 region;
 	u64 addr;
+	int ret;
 
 	if (WARN_ON(!nvm))
 		return -EINVAL;
@@ -512,20 +519,29 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 	total_len = info->len;
 	addr = info->addr;
 
+	ret = pm_runtime_resume_and_get(nvm->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %d\n", ret);
+		return ret;
+	}
+
+	ret = 0;
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
@@ -541,14 +557,16 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
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
+	pm_runtime_put_autosuspend(nvm->dev);
+	return ret;
 }
 
 static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
@@ -577,17 +595,24 @@ static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
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
+	pm_runtime_put_autosuspend(nvm->dev);
+	return ret;
 }
 
 static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
@@ -616,17 +641,24 @@ static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
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
+	pm_runtime_put_autosuspend(nvm->dev);
+	return ret;
 }
 
 static void intel_dg_nvm_release(struct kref *kref)
@@ -753,6 +785,17 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
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
@@ -781,9 +824,12 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
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


