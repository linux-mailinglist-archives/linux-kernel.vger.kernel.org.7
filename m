Return-Path: <linux-kernel+bounces-690462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72742ADD0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD17AB829
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4642EB5AF;
	Tue, 17 Jun 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8mpSpPX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0382E2662
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172785; cv=none; b=TZV+z+u7d8ZPdsx40w9zfgzXicDDe4Xyuy6t/e5FcdlmOxaRKPifsb67pD9jJFsj7j6Ex/hUgF1yKEkPYfSdT7CeRDdtcZI6B9OCUA4EvYPITIeKBxfopJPnzbUXP2HMYlz2qmwPXUQtjSds7XQ4wf7px8uF81FevppdW8HbrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172785; c=relaxed/simple;
	bh=fH2hdGzwTf4pZxd5L5oHs+dVIY/4d4It2eb8BdPFp3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCxo1qo8NdveDy2ZCkC2O4CPbSy3aQgnQR7ROcTNnUyva4LIYAqq0kG3ccLqAPQvA3IRLRJyQiyl7aV5xUeSxivNfyZ+riy9eSG0fmTO41eIaH/YN482c3i2ae6RRgW77SN/zRYuW3k8vbFR49EYwnQ8xIvY8B0Zh+bP7AYinx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8mpSpPX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750172784; x=1781708784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fH2hdGzwTf4pZxd5L5oHs+dVIY/4d4It2eb8BdPFp3E=;
  b=Y8mpSpPXpu3iwk1oAaQCqwr/LLcLkiXFC4oidNVs5XxHYhSZeTetD+Me
   sEBIIT8H6CRuq9VeVMrLBQq0dFrJUktwcZc3RLp/BgQLgODD68JSUSMtp
   ZHJYTxezi5yX0/EQ2j1EuMwWmUix3hsYrvj8a95rzBSdDKZSioqBJ3QW5
   x7QzjyxIvzE0CPKvGgdi3ZEJT3zO7lTAthA3zSQGa+nG14DvzuhsxTkoF
   7KjCZZXEIoVzsl836O1iduwrICtWhzct9cnlAG5x0SBxpYskM9jdOeuOm
   qjjbLA4kkjCJDGfydLdhX2VNSzFX+bhNBVMWpsoYIA0+zGvw1bhhX8F8p
   w==;
X-CSE-ConnectionGUID: lho62PyeS6SCnvWhPpRkNw==
X-CSE-MsgGUID: YYlW5peMTwG7ODaG9t4oMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63009088"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="63009088"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:06:24 -0700
X-CSE-ConnectionGUID: 7kDG+z/ZRkWrEXaNarPRlA==
X-CSE-MsgGUID: 73MgP5m+R4OaWWFt4moqSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="152672573"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:06:17 -0700
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
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v14 8/8] drm/xe/nvm: add support for non-posted erase
Date: Tue, 17 Jun 2025 17:51:58 +0300
Message-ID: <20250617145159.3803852-9-alexander.usyskin@intel.com>
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

From: Reuven Abliyev <reuven.abliyev@intel.com>

Erase command is slow on discrete graphics storage
and may overshot PCI completion timeout.
BMG introduces the ability to have non-posted erase.
Add driver support for non-posted erase with polling
for erase completion.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Reuven Abliyev <reuven.abliyev@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/xe_nvm.c        | 25 ++++++++++++++++++
 drivers/mtd/devices/mtd_intel_dg.c | 42 ++++++++++++++++++++++++++++--
 include/linux/intel_dg_nvm_aux.h   |  2 ++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 20aa3b5d3637..61b0a1531a53 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -14,7 +14,15 @@
 #include "xe_sriov.h"
 
 #define GEN12_GUNIT_NVM_BASE 0x00102040
+#define GEN12_DEBUG_NVM_BASE 0x00101018
+
+#define GEN12_CNTL_PROTECTED_NVM_REG 0x0010100C
+
 #define GEN12_GUNIT_NVM_SIZE 0x80
+#define GEN12_DEBUG_NVM_SIZE 0x4
+
+#define NVM_NON_POSTED_ERASE_CHICKEN_BIT BIT(13)
+
 #define HECI_FW_STATUS_2_NVM_ACCESS_MODE BIT(3)
 
 static const struct intel_dg_nvm_region regions[INTEL_DG_NVM_REGIONS] = {
@@ -29,6 +37,16 @@ static void xe_nvm_release_dev(struct device *dev)
 {
 }
 
+static bool xe_nvm_non_posted_erase(struct xe_device *xe)
+{
+	struct xe_gt *gt = xe_root_mmio_gt(xe);
+
+	if (xe->info.platform != XE_BATTLEMAGE)
+		return false;
+	return !(xe_mmio_read32(&gt->mmio, XE_REG(GEN12_CNTL_PROTECTED_NVM_REG)) &
+		 NVM_NON_POSTED_ERASE_CHICKEN_BIT);
+}
+
 static bool xe_nvm_writable_override(struct xe_device *xe)
 {
 	struct xe_gt *gt = xe_root_mmio_gt(xe);
@@ -86,6 +104,7 @@ int xe_nvm_init(struct xe_device *xe)
 	nvm = xe->nvm;
 
 	nvm->writable_override = xe_nvm_writable_override(xe);
+	nvm->non_posted_erase = xe_nvm_non_posted_erase(xe);
 	nvm->bar.parent = &pdev->resource[0];
 	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
 	nvm->bar.end = nvm->bar.start + GEN12_GUNIT_NVM_SIZE - 1;
@@ -93,6 +112,12 @@ int xe_nvm_init(struct xe_device *xe)
 	nvm->bar.desc = IORES_DESC_NONE;
 	nvm->regions = regions;
 
+	nvm->bar2.parent = &pdev->resource[0];
+	nvm->bar2.start = GEN12_DEBUG_NVM_BASE + pdev->resource[0].start;
+	nvm->bar2.end = nvm->bar2.start + GEN12_DEBUG_NVM_SIZE - 1;
+	nvm->bar2.flags = IORESOURCE_MEM;
+	nvm->bar2.desc = IORES_DESC_NONE;
+
 	aux_dev = &nvm->aux_dev;
 
 	aux_dev->name = "nvm";
diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index 97e1dc1ada5d..b438ee5aacc3 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -25,6 +25,9 @@ struct intel_dg_nvm {
 	struct mtd_info mtd;
 	struct mutex lock; /* region access lock */
 	void __iomem *base;
+	void __iomem *base2;
+	bool non_posted_erase;
+
 	size_t size;
 	unsigned int nregions;
 	struct {
@@ -41,6 +44,7 @@ struct intel_dg_nvm {
 #define NVM_VALSIG_REG        0x00000010
 #define NVM_ADDRESS_REG       0x00000040
 #define NVM_REGION_ID_REG     0x00000044
+#define NVM_DEBUG_REG         0x00000000
 /*
  * [15:0]-Erase size = 0x0010 4K 0x0080 32K 0x0100 64K
  * [23:16]-Reserved
@@ -72,6 +76,9 @@ struct intel_dg_nvm {
 #define NVM_FREG_ADDR_SHIFT 12
 #define NVM_FREG_MIN_REGION_SIZE 0xFFF
 
+#define NVM_NON_POSTED_ERASE_DONE BIT(23)
+#define NVM_NON_POSTED_ERASE_DONE_ITER 3000
+
 static inline void idg_nvm_set_region_id(struct intel_dg_nvm *nvm, u8 region)
 {
 	iowrite32((u32)region, nvm->base + NVM_REGION_ID_REG);
@@ -373,13 +380,32 @@ static ssize_t idg_read(struct intel_dg_nvm *nvm, u8 region,
 static ssize_t
 idg_erase(struct intel_dg_nvm *nvm, u8 region, loff_t from, u64 len, u64 *fail_addr)
 {
+	void __iomem *base2 = nvm->base2;
 	void __iomem *base = nvm->base;
 	const u32 block = 0x10;
+	u32 iter = 0;
+	u32 reg;
 	u64 i;
 
 	for (i = 0; i < len; i += SZ_4K) {
 		iowrite32(from + i, base + NVM_ADDRESS_REG);
 		iowrite32(region << 24 | block, base + NVM_ERASE_REG);
+		if (nvm->non_posted_erase) {
+			/* Wait for Erase Done */
+			reg = ioread32(base2 + NVM_DEBUG_REG);
+			while (!(reg & NVM_NON_POSTED_ERASE_DONE) &&
+			       ++iter < NVM_NON_POSTED_ERASE_DONE_ITER) {
+				msleep(10);
+				reg = ioread32(base2 + NVM_DEBUG_REG);
+			}
+			if (reg & NVM_NON_POSTED_ERASE_DONE) {
+				/* Clear Erase Done */
+				iowrite32(reg, base2 + NVM_DEBUG_REG);
+			} else {
+				*fail_addr = from + i;
+				return -ETIME;
+			}
+		}
 		/* Since the writes are via sgunit
 		 * we cannot do back to back erases.
 		 */
@@ -388,7 +414,8 @@ idg_erase(struct intel_dg_nvm *nvm, u8 region, loff_t from, u64 len, u64 *fail_a
 	return len;
 }
 
-static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device)
+static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
+			     bool non_posted_erase)
 {
 	u32 access_map = 0;
 	unsigned int i, n;
@@ -448,7 +475,10 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device)
 			n++;
 	}
 
+	nvm->non_posted_erase = non_posted_erase;
+
 	dev_dbg(device, "Registered %d regions\n", n);
+	dev_dbg(device, "Non posted erase %d\n", nvm->non_posted_erase);
 
 	/* Need to add 1 to the amount of memory
 	 * so it is reported as an even block
@@ -729,7 +759,15 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 		goto err;
 	}
 
-	ret = intel_dg_nvm_init(nvm, device);
+	if (invm->non_posted_erase) {
+		nvm->base2 = devm_ioremap_resource(device, &invm->bar2);
+		if (IS_ERR(nvm->base2)) {
+			ret = PTR_ERR(nvm->base2);
+			goto err;
+		}
+	}
+
+	ret = intel_dg_nvm_init(nvm, device, invm->non_posted_erase);
 	if (ret < 0) {
 		dev_err(device, "cannot initialize nvm %d\n", ret);
 		goto err;
diff --git a/include/linux/intel_dg_nvm_aux.h b/include/linux/intel_dg_nvm_aux.h
index 00b6c1301bd8..625d46a6b96e 100644
--- a/include/linux/intel_dg_nvm_aux.h
+++ b/include/linux/intel_dg_nvm_aux.h
@@ -20,7 +20,9 @@ struct intel_dg_nvm_region {
 struct intel_dg_nvm_dev {
 	struct auxiliary_device aux_dev;
 	bool writable_override;
+	bool non_posted_erase;
 	struct resource bar;
+	struct resource bar2;
 	const struct intel_dg_nvm_region *regions;
 };
 
-- 
2.43.0


