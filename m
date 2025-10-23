Return-Path: <linux-kernel+bounces-866954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A91FC012C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 340A64E49DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109731197F;
	Thu, 23 Oct 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ/VenAy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE752D7809
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223176; cv=none; b=UWgdSuRATWbk1E2boi6zCrA2ObiGLTWo+3gHVkvE6Pme+nqqZMNm6Q2ZIYXhOR6R2YXNM2QmGowlPxJo2DeMIXw8K+4DirmLmvPs2YtxnNjegHAgLz7864NDaVZRN2vMsTcU8hKD5L3dFsdASFQE4GaF7rVlSQ6XtNZDvOvYkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223176; c=relaxed/simple;
	bh=KmRvcoYcjlvhPgav741lytDtILQGNZ30w3cEtKl4LH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqC/8x2+Cb6I5TkPstjZff2Ayv9iMZcNPmtX8UoDiaF+vbeU5vCb0CDA0V8BkEowp5T4h1AQwE9vVmJk9se4JhBSDHN7g3fPZsiOziPoCBTkI/5lZQw+3yy/K2SOwpzcxUfekL44uVhaQbLIyK0ZwiKtDcLxIEppXsYBjTxkJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ/VenAy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761223174; x=1792759174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KmRvcoYcjlvhPgav741lytDtILQGNZ30w3cEtKl4LH8=;
  b=ZZ/VenAyR85OXpri8alh/9MxqCNlDHJg0184XB6Gop21IzJJqdlzp/UO
   JiJU1WcImn25Tpa7HUB0MfCzIUUU+etVOhUd/IpX9CVg6vnEja/W822kq
   Xx00uJEjo8/n8+b9NM6VPNjy7551cIyvxkWDd9yeCnOqHsKEEUPbCqhgU
   ssOOWLcS45sGGAnn9u1m7any6xJmBjSD70SRVhP3Vh2k9WEGCRBKf3In8
   fvAmYR3pk5TzTRYJnNY4uSUq7ldyK6y60/4MeTFo/li5pL5P5z4l/uDZG
   4WvZiAnKfrUIBScZehZHjqvRemoKdxjDto9/VLO+We+qEZUaoGoBaKpPv
   g==;
X-CSE-ConnectionGUID: rP21F4O+RTWcbx1yd7AEdw==
X-CSE-MsgGUID: 2sAaCWCCQ1G9JBZtjzWjiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73993806"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="73993806"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:39:33 -0700
X-CSE-ConnectionGUID: tfwWjXmmRp2AVurpNjXy3g==
X-CSE-MsgGUID: /OSlYZQCRKe0CRCHdZ7+Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="189278920"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:39:30 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v3] mtd: intel-dg: wake card on operations
Date: Thu, 23 Oct 2025 15:21:03 +0300
Message-ID: <20251023122103.3922113-1-alexander.usyskin@intel.com>
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

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

V3: Check return value of devm_pm_runtime_enable

V2: Address review comments (Andy)

 drivers/mtd/devices/mtd_intel_dg.c | 74 +++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index b438ee5aacc3..2bab30dcd35f 100644
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
@@ -753,6 +785,21 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	}
 	nvm->nregions = n; /* in case where kasprintf fail */
 
+	ret = devm_pm_runtime_enable(device);
+	if (ret < 0) {
+		dev_err(device, "rpm: enable failed %d\n", ret);
+		goto err_norpm;
+	}
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
@@ -781,9 +828,12 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
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


