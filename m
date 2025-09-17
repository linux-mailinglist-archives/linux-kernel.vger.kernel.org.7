Return-Path: <linux-kernel+bounces-820965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B5B7FE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B85546578
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3232BC17;
	Wed, 17 Sep 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ511JAd"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901532898E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117756; cv=none; b=FMmonh0IOHGK/HEM+ABipJ+dvo2XV2YmgkKMLukyx9Jb2BmHzR8BymjuxnV/gyLA24dIVHXhN6vKcGWIoBMZv2s3XIoEL5E2cVxD7OOGBBCth3ZQqUNHP+NBW2gDhWcWkE8/Zc0w8wLOwFwFXX61u+EvoDuL8OyKwFaEcaQStgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117756; c=relaxed/simple;
	bh=mOW2tsFUm15DmZmv5idmWrqtHcDQ5+Yigq54v02aKPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KaA/aQ+m4O+JTw35M069LKRw3zBYUIv5i5QZ4/8uxuefbqFnYCpPRbmOOgeorO9MthCDXJykvOi/ajX1wh9ub7YIgAF51VXc+vtfn/guauSu6dY/RNA2Je85GtAC9C4vZGVYb+CGy6Ra2cazRHqliuGjB8IiEubB2v/A4krHxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ511JAd; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aff0df4c4abso834124866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117753; x=1758722553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbS5VM8JWBvxciJaUjLtcORna4KntSfvz669tBLnIuo=;
        b=wZ511JAdT/FI9sF5kFNl3Nt9HD3kdlA2F1j9LOlET56evywnTSMIkTz7Us5soSb/L2
         9It8WgBLYFl5CGdgi4rrHlHMSKkm9hmKrRjuzXijO9axnac1hqW+eIGKmrQlO3PSBfF6
         V6SLSD/tS+qS8sNl1jo0Y1teuu6lXgzznRmMuiGB2SBkk0OYljBjS8u0wIJKBpltgaYD
         b98rd4g/FdWJXF/bHQSAbz48rQ0C+iJY8M9V5dAL/UjSXRpoyGJpa4qXT1zfkY6zbbSg
         SOmLjqeDn+pq3lCyFZt6owR94tU0F38DBK8wM+IEfY6zqReSG3CnK6FYlfDxhSFEpWa/
         0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117753; x=1758722553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbS5VM8JWBvxciJaUjLtcORna4KntSfvz669tBLnIuo=;
        b=AwRB+OMZ7z8usnBF39XpO8ysPPik02MFRMp4W04PiBItqpBRdSvTlL6y44XxkAp7xe
         vFk5/FNUS461cAmvvMsS4ZMN5qXZ+xj+EM1IjHqvpdf6mNL9wGI9oFHNN9mw5P4kihTb
         /Fh8/r88rwUQ9XXpfhL/ClXKezLNdDJTrH/KJpXiLQZeQtFZ2BO1UAwXJYsTn0vNzzjN
         /TubCOEbWn6acQzPthYb5GjnAXfyaayYky6tOkFvbDQ6Eg+r0V+KLwI1SIRHlcdU12fX
         36MGFDl+IHXiDVk2mDI3QHfLxc35ExCHdtNIm8MuDqGOJGEugGLJQB3bdUB1jTD8+9OO
         QkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCURIC1eSNNwceLRL3WZZCB2VJeVYKXrsfi4uSiziBqY56wpJ4qHVw3RTXTTCbhhEgT4m5xvYbQZoTup25c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0+s7/X+1GZE74l+omV0W9b9LZeWLeebOUY3Jl6Ny4uLlPwkW
	sDp0TB210S/4bVmsErHl28l44oYE20SwI/JZP0/xI6/QAKOYCkHaEhD9OIVI2yH1fN2jF0scAFp
	hNlHQWy2+xyncAQ==
X-Google-Smtp-Source: AGHT+IE3jLGXIoEmh8JZSWjISt/98EKsWlH7hx945hGGOLLiBVFnNJMHLIN27ohSmsi4BE4MwPLjrgToCtD6zg==
X-Received: from edben16.prod.google.com ([2002:a05:6402:5290:b0:62f:464a:b98b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f0a:b0:b0c:6cae:51e3 with SMTP id a640c23a62f3a-b1bb8ca5382mr283095066b.35.1758117752675;
 Wed, 17 Sep 2025 07:02:32 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:02:03 +0000
In-Reply-To: <20250917140216.2199055-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917140216.2199055-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917140216.2199055-3-smostafa@google.com>
Subject: [PATCH 2/2] iommu/io-pgtable-arm-selftest: Use KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Integrate the selftests as part of kunit, this makes the results of
the test available through debugfs later.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Kconfig                    |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 90 ++++++++++++++----------
 2 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..52c2fcb0e77f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE
 
 config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 	bool "LPAE selftests"
-	depends on IOMMU_IO_PGTABLE_LPAE
+	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT=y
 	help
 	  Enable self-tests for LPAE page table allocator. This performs
 	  a series of page-table consistency checks during boot.
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index f7746ff2c7a0..3775936d07c7 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -6,6 +6,8 @@
  *
  * Author: Will Deacon <will.deacon@arm.com>
  */
+#include <kunit/device.h>
+#include <kunit/test.h>
 #include <linux/device/faux.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -39,25 +41,26 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+static void __init arm_lpae_dump_ops(struct kunit *test, struct io_pgtable_ops *ops)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
+	kunit_err(test, "cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
+		  cfg->pgsize_bitmap, cfg->ias);
+	kunit_err(test, "data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
+		  ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
+		  ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
 }
 
-#define __FAIL(ops, i)	({						\
-		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
-		-EFAULT;						\
+#define __FAIL(test, ops, i)	({						\
+		KUNIT_FAIL(test, "");						\
+		kunit_err(test, "selftest: test failed for fmt idx %d\n", (i));	\
+		arm_lpae_dump_ops(test, ops);					\
+		-EFAULT;							\
 })
 
-static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+static int __init arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 {
 	static const enum io_pgtable_fmt fmts[] __initconst = {
 		ARM_64_LPAE_S1,
@@ -73,7 +76,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		cfg_cookie = cfg;
 		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
 		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
+			kunit_err(test, "selftest: failed to allocate io pgtable ops\n");
 			return -ENOMEM;
 		}
 
@@ -82,13 +85,13 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		 * Empty page tables shouldn't provide any translations.
 		 */
 		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		/*
 		 * Distinct mappings of different granule sizes.
@@ -101,16 +104,16 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 					   IOMMU_READ | IOMMU_WRITE |
 					   IOMMU_NOEXEC | IOMMU_CACHE,
 					   GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			/* Overlapping mappings */
 			if (!ops->map_pages(ops, iova, iova + size, size, 1,
 					    IOMMU_READ | IOMMU_NOEXEC,
 					    GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			iova += SZ_1G;
 		}
@@ -121,18 +124,18 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			size = 1UL << j;
 
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			/* Remap full block */
 			if (ops->map_pages(ops, iova, iova, size, 1,
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			iova += SZ_1G;
 		}
@@ -148,11 +151,11 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				   IOMMU_READ | IOMMU_WRITE |
 				   IOMMU_NOEXEC | IOMMU_CACHE,
 				   GFP_KERNEL, &mapped))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 		if (mapped != size)
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		free_io_pgtable_ops(ops);
 	}
@@ -160,7 +163,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int __init arm_lpae_do_selftests(void)
+static void __init io_pgtable_arm_test_run(struct kunit *test)
 {
 	static const unsigned long pgsize[] __initconst = {
 		SZ_4K | SZ_2M | SZ_1G,
@@ -173,18 +176,19 @@ static int __init arm_lpae_do_selftests(void)
 	};
 
 	int i, j, k, pass = 0, fail = 0;
-	struct faux_device *dev;
+	struct device *dev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
 		.coherent_walk = true,
 		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
 	};
 
-	dev = faux_device_create("io-pgtable-test", NULL, 0);
-	if (!dev)
-		return -ENOMEM;
+	dev = kunit_device_register(test, "io-pgtable-test");
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+	if (IS_ERR_OR_NULL(dev))
+		return;
 
-	cfg.iommu_dev = &dev->dev;
+	cfg.iommu_dev = dev;
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
 		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
@@ -193,9 +197,9 @@ static int __init arm_lpae_do_selftests(void)
 				cfg.pgsize_bitmap = pgsize[i];
 				cfg.ias = address_size[k];
 				cfg.oas = address_size[j];
-				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
-					pgsize[i], cfg.ias, cfg.oas);
-				if (arm_lpae_run_tests(&cfg))
+				kunit_info(test, "selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					   pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(test, &cfg))
 					fail++;
 				else
 					pass++;
@@ -203,9 +207,17 @@ static int __init arm_lpae_do_selftests(void)
 		}
 	}
 
-	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
-	faux_device_destroy(dev);
-
-	return fail ? -EFAULT : 0;
+	kunit_info(test, "selftest: completed with %d PASS %d FAIL\n", pass, fail);
 }
-subsys_initcall(arm_lpae_do_selftests);
+
+static struct kunit_case io_pgtable_arm_test_cases[] __refdata = {
+	KUNIT_CASE(io_pgtable_arm_test_run),
+	{},
+};
+
+static struct kunit_suite io_pgtable_arm_test = {
+	.name = "io-pgtable-arm-test",
+	.test_cases = io_pgtable_arm_test_cases,
+};
+
+kunit_test_init_section_suite(io_pgtable_arm_test);
-- 
2.51.0.384.g4c02a37b29-goog


