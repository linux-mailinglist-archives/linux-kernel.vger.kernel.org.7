Return-Path: <linux-kernel+bounces-882868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC9C2BB5B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CA13BBB9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733730F54B;
	Mon,  3 Nov 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPLzMrwi"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255630E0DC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173249; cv=none; b=ilSRVkfVrQmRM5Z8TL1BVRmuR1ytZPbFF1JvR8RldjqxOw/UckZycbQnbGnZIvRdkTaVnTV5nT6ZIANdJQaFiFYVviktQOvDQHquJRN7QRsvHS+nQHdMDfmOCkEOg+NB/J5yAKdva/saxnSRL6PwMdKlGF8qh1kBqO3sSzV7Hm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173249; c=relaxed/simple;
	bh=ZZnDkxRVyIENEbgmqjm/2mUdcyU2VYJAQU+6uU6pKTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTc6pCe2P5IkLQMHFYs28SJk3YNz97SThvZkIaTr4xELqevsb3EEKdq24QiRNpOWlH/5zxKhDNf2lSEWy7G0YTjyWy5+35Rn2gfVbj8FLmZHNCtiP9EiDVTMjgpMqqkCABLe6o8qtjGh65B6uTKm1L1xajxiSufeeRbwdqsiNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPLzMrwi; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-427015f63faso2306702f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173245; x=1762778045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LKEOMyqjqgBvPHQx5V7MbLjfxSu8M1O7xqqETG0HSs=;
        b=iPLzMrwiMKI5ZUPTBMSoB8vgCS/Y/ojLYHHSVnJMn+MYBxGEh/zoRrAedyu+1v+Zfc
         9dD9QXfOgFFqKTp3GkIgOPvY1ZPj/kuDl2Rln4MOkMsM/2/+cvKiYSmDu22q2Afc7Aiy
         7hUsziZbo/RhORGsTYyDUqTEnd9mXQ9g1xR76XP75iyGnGjF4bddbkI/w6MzXVtiKUEc
         2CPqGqqX++Cg00qOz+Egr3kONDcOzfJyGF2CKQMDPVx5/jY3z6RsGwFvVmx7nXJdgRJj
         jrBTa+jDIVZNpZi8miXKVYjyCGynsuIUhdVVdMo5ji7DhIkq18AAGOPHnntDdGAKXSUU
         F/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173245; x=1762778045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LKEOMyqjqgBvPHQx5V7MbLjfxSu8M1O7xqqETG0HSs=;
        b=N91b4Biq1R50dRTTlVI/6iQPtrYr3tR+tLMaOREmG6WkAypgw2cZI83utHLe3Orh1l
         Ji8TUdTBUzlerIVHr38nN9pQlffPETlNpR8DOU8LRBMGeJDChQzV29F04fITKRRC5dLu
         oYKzW2Hr/35DDNbOOajyagwHlUeU7BUOpsy85aikxdwTLt71WGR1GIOpQRB5lILrOW1v
         MEPM0tsYnBzyGiVN/oEdQp4l/OxZ2ykO/uLHRi4XQwPdnICmYLvUWB/kFctszZlnTDf+
         vmwfwz7fgZ7adw+jqXlnFELHC0Rqd9REqk7yWJzONIva+w9uOb1o5w14M5PpX6zPzPXV
         XUxA==
X-Forwarded-Encrypted: i=1; AJvYcCXYP4L1b5AZZwFyi+hMyRMARnF11Sl7r2cxNhFTePwOsB5Z7QRbO4NaMf28P6IlubkPTCKqiu+n5RFlfzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwcesOpCGHTmCxRK8wOdyaMsyBS4AFsThNMs+A4BN51+bp4LH
	3fbKQpwiCd/4ATlkweBt1OgcfGvyZiJ/3bulyLNp/g244FWV+e93BXpl11lvvm6Nk40fvl+9C8A
	OYHfHtGY2gHfxVw==
X-Google-Smtp-Source: AGHT+IEeYIjFUdrZpu4l4ib2e0zrBNK41Il+QS1uUdlEcvl9aDJoHa5mpKNWO9cQe02uAQGChLkaUrNjED4NBw==
X-Received: from wrad11.prod.google.com ([2002:adf:a40b:0:b0:429:d0c9:ed74])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4b0f:b0:429:c965:afa with SMTP id ffacd0b85a97d-429c9650c2emr5684998f8f.36.1762173245204;
 Mon, 03 Nov 2025 04:34:05 -0800 (PST)
Date: Mon,  3 Nov 2025 12:33:52 +0000
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103123355.1769093-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103123355.1769093-5-smostafa@google.com>
Subject: [PATCH v6 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Integrate the selftests as part of kunit.

Now instead of the test only being run at boot, it can run:

- With CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST=y
  It will automatically run at boot as before.

- Otherwise with CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST=m:
  1) on module load:
     Once the module load the self test will run
     # modprobe io-pgtable-arm-selftests

  2) debugfs
     With CONFIG_KUNIT_DEBUGFS=y You can run the test with
     # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run

  3) Using kunit.py
     You can also use the helper script which uses Qemu in the background

     # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 \
       --make_options LLVM=1 --kunitconfig ./kunit/kunitconfig
      [18:01:09] ============= io-pgtable-arm-test (1 subtest) ==============
      [18:01:09] [PASSED] arm_lpae_do_selftests
      [18:01:09] =============== [PASSED] io-pgtable-arm-test ===============
      [18:01:09] ============================================================

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Kconfig                    | 11 ++--
 drivers/iommu/Makefile                   |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 81 +++++++++++++-----------
 3 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 553522ef3ca9..d50685433347 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -40,12 +40,13 @@ config IOMMU_IO_PGTABLE_LPAE
 	  sizes at both stage-1 and stage-2, as well as address spaces
 	  up to 48-bits in size.
 
-config IOMMU_IO_PGTABLE_LPAE_SELFTEST
-	tristate "LPAE selftests"
-	depends on IOMMU_IO_PGTABLE_LPAE
+config IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST
+	tristate "KUnit tests for LPAE"
+	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT
+	default KUNIT_ALL_TESTS
 	help
-	  Enable self-tests for LPAE page table allocator. This performs
-	  a series of page-table consistency checks during boot.
+	  Enable kunit tests for LPAE page table allocator. This performs
+	  a series of page-table consistency checks.
 
 	  If unsure, say N here.
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5250a2eea13f..ac3851570303 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
-obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST) += io-pgtable-arm-selftests.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 8361d01b49c5..334e70350924 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -9,7 +9,8 @@
 
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
-#include <linux/device/faux.h>
+#include <kunit/device.h>
+#include <kunit/test.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
 
@@ -42,12 +43,12 @@ static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-#define __FAIL(i) ({							\
-		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		-EFAULT;						\
+#define __FAIL(test, i) ({							\
+		KUNIT_FAIL(test, "test failed for fmt idx %d\n", (i));		\
+		-EFAULT;							\
 })
 
-static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 {
 	static const enum io_pgtable_fmt fmts[] = {
 		ARM_64_LPAE_S1,
@@ -63,7 +64,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		cfg_cookie = cfg;
 		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
 		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
+			kunit_err(test, "failed to allocate io pgtable ops\n");
 			return -ENOMEM;
 		}
 
@@ -72,13 +73,13 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		 * Empty page tables shouldn't provide any translations.
 		 */
 		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(i);
+			return __FAIL(test, i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(i);
+			return __FAIL(test, i);
 
 		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(i);
+			return __FAIL(test, i);
 
 		/*
 		 * Distinct mappings of different granule sizes.
@@ -91,16 +92,16 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 					   IOMMU_READ | IOMMU_WRITE |
 					   IOMMU_NOEXEC | IOMMU_CACHE,
 					   GFP_KERNEL, &mapped))
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			/* Overlapping mappings */
 			if (!ops->map_pages(ops, iova, iova + size, size, 1,
 					    IOMMU_READ | IOMMU_NOEXEC,
 					    GFP_KERNEL, &mapped))
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			iova += SZ_1G;
 		}
@@ -111,18 +112,18 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			size = 1UL << j;
 
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			/* Remap full block */
 			if (ops->map_pages(ops, iova, iova, size, 1,
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(i);
+				return __FAIL(test, i);
 
 			iova += SZ_1G;
 		}
@@ -138,11 +139,11 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				   IOMMU_READ | IOMMU_WRITE |
 				   IOMMU_NOEXEC | IOMMU_CACHE,
 				   GFP_KERNEL, &mapped))
-			return __FAIL(i);
+			return __FAIL(test, i);
 		if (mapped != size)
-			return __FAIL(i);
+			return __FAIL(test, i);
 		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(i);
+			return __FAIL(test, i);
 
 		free_io_pgtable_ops(ops);
 	}
@@ -150,7 +151,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int arm_lpae_do_selftests(void)
+static void arm_lpae_do_selftests(struct kunit *test)
 {
 	static const unsigned long pgsize[] = {
 		SZ_4K | SZ_2M | SZ_1G,
@@ -163,18 +164,19 @@ static int arm_lpae_do_selftests(void)
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
@@ -183,9 +185,9 @@ static int arm_lpae_do_selftests(void)
 				cfg.pgsize_bitmap = pgsize[i];
 				cfg.ias = address_size[k];
 				cfg.oas = address_size[j];
-				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
-					pgsize[i], cfg.ias, cfg.oas);
-				if (arm_lpae_run_tests(&cfg))
+				kunit_info(test, "pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					   pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(test, &cfg))
 					fail++;
 				else
 					pass++;
@@ -193,17 +195,20 @@ static int arm_lpae_do_selftests(void)
 		}
 	}
 
-	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
-	faux_device_destroy(dev);
-
-	return fail ? -EFAULT : 0;
+	kunit_info(test, "completed with %d PASS %d FAIL\n", pass, fail);
 }
 
-static void arm_lpae_exit_selftests(void)
-{
-}
+static struct kunit_case io_pgtable_arm_test_cases[] = {
+	KUNIT_CASE(arm_lpae_do_selftests),
+	{},
+};
+
+static struct kunit_suite io_pgtable_arm_test = {
+	.name = "io-pgtable-arm-test",
+	.test_cases = io_pgtable_arm_test_cases,
+};
+
+kunit_test_suite(io_pgtable_arm_test);
 
-subsys_initcall(arm_lpae_do_selftests);
-module_exit(arm_lpae_exit_selftests);
-MODULE_DESCRIPTION("io-pgtable-arm library selftest");
+MODULE_DESCRIPTION("io-pgtable-arm library kunit tests");
 MODULE_LICENSE("GPL");
-- 
2.51.1.930.gacf6e81ea2-goog


