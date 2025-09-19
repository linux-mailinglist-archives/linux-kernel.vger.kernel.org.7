Return-Path: <linux-kernel+bounces-824623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC545B89B03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E21C8505D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE16311C05;
	Fri, 19 Sep 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5KNY1ph"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF652ECE95
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288805; cv=none; b=V8R/6nHAt3DMVRzve/ZUosTTWo1HcWqr2O3Tf+6pRCBGW45FtbcIM6a7jxBDsKKIq/mw+A6vkm+uHcwtwKwN4OL5/2JITtebTUB/TCt57znBBd/8QGFMZLeeN89rADf723NkEhI2RLxDIzr2VmLb+dmwDhYiANWjZ4BLHJ1VqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288805; c=relaxed/simple;
	bh=vYUS3dI9XgT7DB9opuiZ1Byrj34GtobBqgcS9r1zFWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SO6a8yEjO5LolRPZp7lAoaI4HxiIYkbx8/h8mmNYmDmvJeKR+SxCqadhiXYQ/Mu2DZxzcqU5wO610xqTCFH0oyPAEjHswppGrgQxw4TAI6oukNX2sAg2lpV+KGLGjZ09db7099ld5GNsEGwBSD/qcEoAIqyIVg/0rLCNnWO6vNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5KNY1ph; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ee888281c3so817697f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758288801; x=1758893601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDG1lzvpcDhJhbEFYfIq80tGXsnz1MaPskEEqdr6vp0=;
        b=I5KNY1phNt3USg2DyRCWgqrIjuvFAVFajYQ9dwOm5aNOtPTS2YABN6RH08uBmbgc50
         Tfp6L3m4CwscgDGSdiH0SptyyELlJEg8ksbJbht+sQNIL5+6YQ6BGwALiG0Dx3mN8lin
         q+MqFpUQbr7PfxEALnIf151Zd7aYgxEH7nKIB5FW3h/2popDFb+dCFN9w9+tM4EkjPeY
         ywXJSt/Ct1/+v27/P3mEUU5B3oxxpFBA9lWAte2tokgCHgFusOVarJ8ehvH0Tp1//TGU
         sAV80Cyh7G6ydEkxGm5DoWHRrBvzkH+4nPyPSAGjsp71GO0Ho2kTL5CPgOPJGTnqNsLZ
         YYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288801; x=1758893601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDG1lzvpcDhJhbEFYfIq80tGXsnz1MaPskEEqdr6vp0=;
        b=QcDFBYiejvayO3nL/KDkHP6m/hzzdRPCy+ASp0c5fX0Myw2TGDjENmBg1NVtTrlwD7
         /NgPdJvWcovDEOAFS5tzw+Eybawdbl4F/uPBMK0rRJUbMw/DrFQtWiqH3DcvC6efoI9m
         WqqfHU3vU53K9HDJ5N/kqFcJmBOG511zkpbGUTMadbtYngP9yXGGzOBBO9y8eozwUt4M
         BhMXFmrAfeY1EMba/gt1d6ABVXVRmtjRzKuqCJmzis2/5nN7EeWx7/G1s+sXDR15SQA4
         pAnvGWLPY+qa9EvLBuFnvfNYiQhJ/oqYKc7SZ+yRdScUeYqr4H1D0m6XX9EDFNV02S2c
         BaLA==
X-Forwarded-Encrypted: i=1; AJvYcCWJe+/ehnlVUItcXMBeP222QC9olYzo0PQzCBui3JAy6LDPgaTh0txubgNHBqhXt+d7WVhGJSoENqK+DqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTw20g1kHkuJC6e699fMa62XOf2VYDORGU69ukGO9CtpPbjnC
	q6sAm62cSRvqb19bkxHT2awCyChj78WOn+/ltTdubZ1q2zp7ir/EIJIqW9rvKjsw7vw+eLfw802
	pbo6kLDaHlD8Nig==
X-Google-Smtp-Source: AGHT+IEA3wbXjckbVprhquwu1f9p3GkdjRSMj1EJRcToZghtt4tIZs82OMfdDy4Mq9NH3Zl2PvgmzaeZXLAooQ==
X-Received: from wmbhc7.prod.google.com ([2002:a05:600c:8707:b0:45b:6199:5f39])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:178a:b0:3c7:36f3:c352 with SMTP id ffacd0b85a97d-3ee86d6cd65mr2686938f8f.59.1758288801693;
 Fri, 19 Sep 2025 06:33:21 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:33:11 +0000
In-Reply-To: <20250919133316.2741279-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919133316.2741279-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919133316.2741279-3-smostafa@google.com>
Subject: [PATCH v3 2/4] iommu/io-pgtable-arm: Move selftests to a separate file
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Clean up the io-pgtable-arm library by moving the selftests out.
Next the tests will be registered with kunit.

This is useful also to factor out kernel specific code out, so
it can compiled as part of the hypervisor object.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 208 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 200 ----------------------
 3 files changed, 209 insertions(+), 200 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033..5250a2eea13f 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
new file mode 100644
index 000000000000..17f48216647c
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU-agnostic ARM page table allocator.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+#include <linux/device/faux.h>
+#include <linux/io-pgtable.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "io-pgtable-arm.h"
+
+static struct io_pgtable_cfg *cfg_cookie __initdata;
+
+static void __init dummy_tlb_flush_all(void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static void __init dummy_tlb_flush(unsigned long iova, size_t size,
+				   size_t granule, void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
+}
+
+static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+				      unsigned long iova, size_t granule,
+				      void *cookie)
+{
+	dummy_tlb_flush(iova, granule, granule, cookie);
+}
+
+static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
+	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_flush_walk	= dummy_tlb_flush,
+	.tlb_add_page	= dummy_tlb_add_page,
+};
+
+static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+{
+	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
+
+	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
+		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
+}
+
+#define __FAIL(ops, i)	({						\
+		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
+		arm_lpae_dump_ops(ops);					\
+		-EFAULT;						\
+})
+
+static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+{
+	static const enum io_pgtable_fmt fmts[] __initconst = {
+		ARM_64_LPAE_S1,
+		ARM_64_LPAE_S2,
+	};
+
+	int i, j;
+	unsigned long iova;
+	size_t size, mapped;
+	struct io_pgtable_ops *ops;
+
+	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
+		cfg_cookie = cfg;
+		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
+		if (!ops) {
+			pr_err("selftest: failed to allocate io pgtable ops\n");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Initial sanity checks.
+		 * Empty page tables shouldn't provide any translations.
+		 */
+		if (ops->iova_to_phys(ops, 42))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_1G + 42))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_2G + 42))
+			return __FAIL(ops, i);
+
+		/*
+		 * Distinct mappings of different granule sizes.
+		 */
+		iova = 0;
+		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
+			size = 1UL << j;
+
+			if (ops->map_pages(ops, iova, iova, size, 1,
+					   IOMMU_READ | IOMMU_WRITE |
+					   IOMMU_NOEXEC | IOMMU_CACHE,
+					   GFP_KERNEL, &mapped))
+				return __FAIL(ops, i);
+
+			/* Overlapping mappings */
+			if (!ops->map_pages(ops, iova, iova + size, size, 1,
+					    IOMMU_READ | IOMMU_NOEXEC,
+					    GFP_KERNEL, &mapped))
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+				return __FAIL(ops, i);
+
+			iova += SZ_1G;
+		}
+
+		/* Full unmap */
+		iova = 0;
+		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
+			size = 1UL << j;
+
+			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42))
+				return __FAIL(ops, i);
+
+			/* Remap full block */
+			if (ops->map_pages(ops, iova, iova, size, 1,
+					   IOMMU_WRITE, GFP_KERNEL, &mapped))
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+				return __FAIL(ops, i);
+
+			iova += SZ_1G;
+		}
+
+		/*
+		 * Map/unmap the last largest supported page of the IAS, this can
+		 * trigger corner cases in the concatednated page tables.
+		 */
+		mapped = 0;
+		size = 1UL << __fls(cfg->pgsize_bitmap);
+		iova = (1UL << cfg->ias) - size;
+		if (ops->map_pages(ops, iova, iova, size, 1,
+				   IOMMU_READ | IOMMU_WRITE |
+				   IOMMU_NOEXEC | IOMMU_CACHE,
+				   GFP_KERNEL, &mapped))
+			return __FAIL(ops, i);
+		if (mapped != size)
+			return __FAIL(ops, i);
+		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
+			return __FAIL(ops, i);
+
+		free_io_pgtable_ops(ops);
+	}
+
+	return 0;
+}
+
+static int __init arm_lpae_do_selftests(void)
+{
+	static const unsigned long pgsize[] __initconst = {
+		SZ_4K | SZ_2M | SZ_1G,
+		SZ_16K | SZ_32M,
+		SZ_64K | SZ_512M,
+	};
+
+	static const unsigned int address_size[] __initconst = {
+		32, 36, 40, 42, 44, 48,
+	};
+
+	int i, j, k, pass = 0, fail = 0;
+	struct faux_device *dev;
+	struct io_pgtable_cfg cfg = {
+		.tlb = &dummy_tlb_ops,
+		.coherent_walk = true,
+		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
+	};
+
+	dev = faux_device_create("io-pgtable-test", NULL, 0);
+	if (!dev)
+		return -ENOMEM;
+
+	cfg.iommu_dev = &dev->dev;
+
+	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
+		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
+			/* Don't use ias > oas as it is not valid for stage-2. */
+			for (k = 0; k <= j; ++k) {
+				cfg.pgsize_bitmap = pgsize[i];
+				cfg.ias = address_size[k];
+				cfg.oas = address_size[j];
+				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(&cfg))
+					fail++;
+				else
+					pass++;
+			}
+		}
+	}
+
+	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
+	faux_device_destroy(dev);
+
+	return fail ? -EFAULT : 0;
+}
+subsys_initcall(arm_lpae_do_selftests);
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 00218af5d5f7..aed18b3d277f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -12,10 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-#include <linux/device/faux.h>
 #include <linux/sizes.h>
-#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 
@@ -1267,200 +1264,3 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.alloc	= arm_mali_lpae_alloc_pgtable,
 	.free	= arm_lpae_free_pgtable,
 };
-
-#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
-
-static struct io_pgtable_cfg *cfg_cookie __initdata;
-
-static void __init dummy_tlb_flush_all(void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-}
-
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
-}
-
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
-{
-	dummy_tlb_flush(iova, granule, granule, cookie);
-}
-
-static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
-	.tlb_flush_all	= dummy_tlb_flush_all,
-	.tlb_flush_walk	= dummy_tlb_flush,
-	.tlb_add_page	= dummy_tlb_add_page,
-};
-
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
-{
-	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
-
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
-}
-
-#define __FAIL(ops, i)	({						\
-		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
-		-EFAULT;						\
-})
-
-static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
-{
-	static const enum io_pgtable_fmt fmts[] __initconst = {
-		ARM_64_LPAE_S1,
-		ARM_64_LPAE_S2,
-	};
-
-	int i, j;
-	unsigned long iova;
-	size_t size, mapped;
-	struct io_pgtable_ops *ops;
-
-	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
-		cfg_cookie = cfg;
-		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
-		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
-			return -ENOMEM;
-		}
-
-		/*
-		 * Initial sanity checks.
-		 * Empty page tables shouldn't provide any translations.
-		 */
-		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(ops, i);
-
-		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(ops, i);
-
-		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(ops, i);
-
-		/*
-		 * Distinct mappings of different granule sizes.
-		 */
-		iova = 0;
-		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
-			size = 1UL << j;
-
-			if (ops->map_pages(ops, iova, iova, size, 1,
-					   IOMMU_READ | IOMMU_WRITE |
-					   IOMMU_NOEXEC | IOMMU_CACHE,
-					   GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
-
-			/* Overlapping mappings */
-			if (!ops->map_pages(ops, iova, iova + size, size, 1,
-					    IOMMU_READ | IOMMU_NOEXEC,
-					    GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
-
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
-
-			iova += SZ_1G;
-		}
-
-		/* Full unmap */
-		iova = 0;
-		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
-			size = 1UL << j;
-
-			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(ops, i);
-
-			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(ops, i);
-
-			/* Remap full block */
-			if (ops->map_pages(ops, iova, iova, size, 1,
-					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
-
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
-
-			iova += SZ_1G;
-		}
-
-		/*
-		 * Map/unmap the last largest supported page of the IAS, this can
-		 * trigger corner cases in the concatednated page tables.
-		 */
-		mapped = 0;
-		size = 1UL << __fls(cfg->pgsize_bitmap);
-		iova = (1UL << cfg->ias) - size;
-		if (ops->map_pages(ops, iova, iova, size, 1,
-				   IOMMU_READ | IOMMU_WRITE |
-				   IOMMU_NOEXEC | IOMMU_CACHE,
-				   GFP_KERNEL, &mapped))
-			return __FAIL(ops, i);
-		if (mapped != size)
-			return __FAIL(ops, i);
-		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(ops, i);
-
-		free_io_pgtable_ops(ops);
-	}
-
-	return 0;
-}
-
-static int __init arm_lpae_do_selftests(void)
-{
-	static const unsigned long pgsize[] __initconst = {
-		SZ_4K | SZ_2M | SZ_1G,
-		SZ_16K | SZ_32M,
-		SZ_64K | SZ_512M,
-	};
-
-	static const unsigned int address_size[] __initconst = {
-		32, 36, 40, 42, 44, 48,
-	};
-
-	int i, j, k, pass = 0, fail = 0;
-	struct faux_device *dev;
-	struct io_pgtable_cfg cfg = {
-		.tlb = &dummy_tlb_ops,
-		.coherent_walk = true,
-		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
-	};
-
-	dev = faux_device_create("io-pgtable-test", NULL, 0);
-	if (!dev)
-		return -ENOMEM;
-
-	cfg.iommu_dev = &dev->dev;
-
-	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
-		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
-			/* Don't use ias > oas as it is not valid for stage-2. */
-			for (k = 0; k <= j; ++k) {
-				cfg.pgsize_bitmap = pgsize[i];
-				cfg.ias = address_size[k];
-				cfg.oas = address_size[j];
-				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
-					pgsize[i], cfg.ias, cfg.oas);
-				if (arm_lpae_run_tests(&cfg))
-					fail++;
-				else
-					pass++;
-			}
-		}
-	}
-
-	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
-	faux_device_destroy(dev);
-
-	return fail ? -EFAULT : 0;
-}
-subsys_initcall(arm_lpae_do_selftests);
-#endif
-- 
2.51.0.534.gc79095c0ca-goog


