Return-Path: <linux-kernel+bounces-776544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D46B2CEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E342A7044
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A0350839;
	Tue, 19 Aug 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stT/zhCb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B40342CB5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640351; cv=none; b=Iufd8jPxFgoYF2OnzsG7nz878R38B70t7VvZcrSxG9Ogb/LQtzObRvr7Ahy5tmydKj+uIHqiWAoGKMcbL1tBU74qWVwnlBzYTWVHG98TTS7SD9UzyUUnJ63zoSeLT5bdGR9/QgfXA/+D+jsttXcq3mRSLkbvC4kRGH5msjVVSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640351; c=relaxed/simple;
	bh=f1zhYYpnAEfMBFW4F8zFMkjpoIuuoFRXw/JRH6L83UM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7WNgNsuyUs0jD9xzr5EmX/9f5oAmPMoz7KuW9j2shN2OAQ6IJ/WwyZTLLjOlhpB9B8yJXYvNL5ILtrv17iVgSQElYKNB/1q/slcu0LJ3Eleup1BQLclI8f+jcZ0uyZqusev8EIq7r4ex9yYcC0arj9lFC0Zp/A/OwHCqV7BwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stT/zhCb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso21688695e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640348; x=1756245148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pO2YE+QLHcZDr5ERfg64RTVx9rRsQJCpks4Jpbfd5g=;
        b=stT/zhCbTcJ0hrFpSYT7hJpIAbq5EtC1VXmUkuAa8MG+YxVFVOp6pA3AdtEhYw1bit
         AZoZRd1/N/M/e0ZoZN5oMWoyWpJ8oUk+vs4rIT0bL5pTffR/buTXW7rRymL7wv4rxrW6
         FqhFR/cWpC8UbS6ialJcXM+PugcCAHw91AvZjvt1ybd7UZ2aM+2KsDAZDZ9PgsAarslL
         QGQ5QgCj+eOcDFpowAmae7VLBbg9me5JDTUr0dSko/D70wQ1MFz2LqAbK753fHtp9qvF
         wSqHM2MdauhIql1m/R7OlOKf7tbcmHo4esTwOL7850e6N6Jng2BzPBMC3/LMabusrg4/
         TleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640348; x=1756245148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pO2YE+QLHcZDr5ERfg64RTVx9rRsQJCpks4Jpbfd5g=;
        b=JXB+t9sVP3YoZW9b5ARl1pAKqaQrckgl5sVDdm9gGtJDqKKo3zYB2v/WGcEdvQiUl7
         5xoRcBCxd3/rJ0KAHH3iLvFIZe3TU19ZK96lBuncNmSrQkL9szC+SwFgfgLQIpWY5dgW
         LEj3NJ7wPyq8aERXTF5vN0LT4KUU+Drk8ZbpNF2JmZGP8YzCAzCZs/3uF4mtTEeFTHvJ
         9+DCUx65U0CwpMFAwnx9hIas7wZ0OFVZ5ea7nr34rByN8W9RhONqWGkCpFVKgKymAcMv
         UxN9y9kgEabNLWaEjm3cy91abM5TEfXWWhrJbWSpO63Z9tGLZwNMoizKXVcVovbGnjI9
         mAJw==
X-Gm-Message-State: AOJu0Ywgx2xcA8kAovVUheXSENunDN8GSobsj6Bt59AMcXWp3WzAwCJ5
	s6JiGqB9UAUNHhya2Q1hV813V/+/u8MD9zTVdNJ5mgAHhzYta5cDnqudKJgg4+WPqiId4BvX0As
	cVJOPhZ9j0dosq4wl3d8hFTOt1CChVfBUDpL0UMNQoB59X6l5nCfkY5dKkpAuBNdhnd+jT7B0dU
	T7qdb0tkq4p8T3pNmWBrYDmnJj0erfjxdp3OSRhsgl2cbkLmW5Kr6kNDM=
X-Google-Smtp-Source: AGHT+IGJ3zxP4tZSJCnPpnLfo8kuY9/ChMlhp2Vc3i11mcX5tsN9jlzR3HCoS4DbN8uykW/2HzhGSH0eYEjOYg==
X-Received: from wmbhh7.prod.google.com ([2002:a05:600c:5307:b0:458:bfa7:dd5b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6216:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-45b47b50207mr2162775e9.4.1755640348094;
 Tue, 19 Aug 2025 14:52:28 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:33 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-6-smostafa@google.com>
Subject: [PATCH v4 05/28] iommu/io-pgtable-arm: Factor kernel specific code out
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Some of the currently used APIs are only part of the kernel and not
available in the hypervisor, factor those out of the common file:
- alloc/free memory
- CMOs
- virt/phys conversions

Which is implemented by the kernel in io-pgtable-arm-kernel.c and
similarly for the hypervisor later in this series.

va/pa conversion kept as macros.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm-kernel.c | 89 ++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c        | 99 +++------------------------
 drivers/iommu/io-pgtable-arm.h        | 14 ++++
 3 files changed, 113 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-kernel.c b/drivers/iommu/io-pgtable-arm-kernel.c
index f3b869310964..d3056487b0f6 100644
--- a/drivers/iommu/io-pgtable-arm-kernel.c
+++ b/drivers/iommu/io-pgtable-arm-kernel.c
@@ -9,10 +9,99 @@
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
 #include <linux/device/faux.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
+
+static dma_addr_t __arm_lpae_dma_addr(void *pages)
+{
+	return (dma_addr_t)virt_to_phys(pages);
+}
+
+void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+			     struct io_pgtable_cfg *cfg,
+			     void *cookie)
+{
+	struct device *dev = cfg->iommu_dev;
+	size_t alloc_size;
+	dma_addr_t dma;
+	void *pages;
+
+	/*
+	 * For very small starting-level translation tables the HW requires a
+	 * minimum alignment of at least 64 to cover all cases.
+	 */
+	alloc_size = max(size, 64);
+	if (cfg->alloc)
+		pages = cfg->alloc(cookie, alloc_size, gfp);
+	else
+		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp,
+						  alloc_size);
+
+	if (!pages)
+		return NULL;
+
+	if (!cfg->coherent_walk) {
+		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, dma))
+			goto out_free;
+		/*
+		 * We depend on the IOMMU being able to work with any physical
+		 * address directly, so if the DMA layer suggests otherwise by
+		 * translating or truncating them, that bodes very badly...
+		 */
+		if (dma != virt_to_phys(pages))
+			goto out_unmap;
+	}
+
+	return pages;
+
+out_unmap:
+	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
+	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
+
+out_free:
+	if (cfg->free)
+		cfg->free(cookie, pages, size);
+	else
+		iommu_free_pages(pages);
+
+	return NULL;
+}
+
+void __arm_lpae_free_pages(void *pages, size_t size,
+			   struct io_pgtable_cfg *cfg,
+			   void *cookie)
+{
+	if (!cfg->coherent_walk)
+		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
+				 size, DMA_TO_DEVICE);
+
+	if (cfg->free)
+		cfg->free(cookie, pages, size);
+	else
+		iommu_free_pages(pages);
+}
+
+void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
+			 struct io_pgtable_cfg *cfg)
+{
+	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
+				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
+}
+
+void *__arm_lpae_alloc_data(size_t size, gfp_t gfp)
+{
+	return kmalloc(size, gfp);
+}
+
+void __arm_lpae_free_data(void *p)
+{
+	return kfree(p);
+}
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 791a2c4ecb83..2ca09081c3b0 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -12,12 +12,10 @@
 #include <linux/io-pgtable.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
-#include <linux/dma-mapping.h>
 
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
-#include "iommu-pages.h"
 
 /*
  * Calculate the index at level l used to map virtual address a using the
@@ -118,7 +116,7 @@
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
 /* IOPTE accessors */
-#define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
+#define iopte_deref(pte,d) __arm_lpae_phys_to_virt(iopte_to_paddr(pte, d))
 
 #define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
@@ -208,83 +206,6 @@ static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
 	       (data->start_level == 1) && (oas == 40);
 }
 
-static dma_addr_t __arm_lpae_dma_addr(void *pages)
-{
-	return (dma_addr_t)virt_to_phys(pages);
-}
-
-static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
-				    struct io_pgtable_cfg *cfg,
-				    void *cookie)
-{
-	struct device *dev = cfg->iommu_dev;
-	size_t alloc_size;
-	dma_addr_t dma;
-	void *pages;
-
-	/*
-	 * For very small starting-level translation tables the HW requires a
-	 * minimum alignment of at least 64 to cover all cases.
-	 */
-	alloc_size = max(size, 64);
-	if (cfg->alloc)
-		pages = cfg->alloc(cookie, alloc_size, gfp);
-	else
-		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp,
-						  alloc_size);
-
-	if (!pages)
-		return NULL;
-
-	if (!cfg->coherent_walk) {
-		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, dma))
-			goto out_free;
-		/*
-		 * We depend on the IOMMU being able to work with any physical
-		 * address directly, so if the DMA layer suggests otherwise by
-		 * translating or truncating them, that bodes very badly...
-		 */
-		if (dma != virt_to_phys(pages))
-			goto out_unmap;
-	}
-
-	return pages;
-
-out_unmap:
-	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
-	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
-
-out_free:
-	if (cfg->free)
-		cfg->free(cookie, pages, size);
-	else
-		iommu_free_pages(pages);
-
-	return NULL;
-}
-
-static void __arm_lpae_free_pages(void *pages, size_t size,
-				  struct io_pgtable_cfg *cfg,
-				  void *cookie)
-{
-	if (!cfg->coherent_walk)
-		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
-				 size, DMA_TO_DEVICE);
-
-	if (cfg->free)
-		cfg->free(cookie, pages, size);
-	else
-		iommu_free_pages(pages);
-}
-
-static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-				struct io_pgtable_cfg *cfg)
-{
-	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
-				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
-}
-
 static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
 {
 	for (int i = 0; i < num_entries; i++)
@@ -360,7 +281,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 	arm_lpae_iopte old, new;
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
-	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
+	new = paddr_to_iopte(__arm_lpae_virt_to_phys(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |= ARM_LPAE_PTE_NSTABLE;
 
@@ -581,7 +502,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(iop);
 
 	__arm_lpae_free_pgtable(data, data->start_level, data->pgd);
-	kfree(data);
+	__arm_lpae_free_data(data);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -895,7 +816,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
 		return NULL;
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data = __arm_lpae_alloc_data(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
@@ -1018,11 +939,11 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	wmb();
 
 	/* TTBR */
-	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
+	cfg->arm_lpae_s1_cfg.ttbr = __arm_lpae_virt_to_phys(data->pgd);
 	return &data->iop;
 
 out_free_data:
-	kfree(data);
+	__arm_lpae_free_data(data);
 	return NULL;
 }
 
@@ -1114,11 +1035,11 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	wmb();
 
 	/* VTTBR */
-	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
+	cfg->arm_lpae_s2_cfg.vttbr = __arm_lpae_virt_to_phys(data->pgd);
 	return &data->iop;
 
 out_free_data:
-	kfree(data);
+	__arm_lpae_free_data(data);
 	return NULL;
 }
 
@@ -1188,7 +1109,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	/* Ensure the empty pgd is visible before TRANSTAB can be written */
 	wmb();
 
-	cfg->arm_mali_lpae_cfg.transtab = virt_to_phys(data->pgd) |
+	cfg->arm_mali_lpae_cfg.transtab = __arm_lpae_virt_to_phys(data->pgd) |
 					  ARM_MALI_LPAE_TTBR_READ_INNER |
 					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
 	if (cfg->coherent_walk)
@@ -1197,7 +1118,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return &data->iop;
 
 out_free_data:
-	kfree(data);
+	__arm_lpae_free_data(data);
 	return NULL;
 }
 
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
index a06a23543cff..7d9f0b759275 100644
--- a/drivers/iommu/io-pgtable-arm.h
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -68,4 +68,18 @@ struct arm_lpae_io_pgtable {
 
 typedef u64 arm_lpae_iopte;
 
+void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
+			 struct io_pgtable_cfg *cfg);
+void __arm_lpae_free_pages(void *pages, size_t size,
+			   struct io_pgtable_cfg *cfg,
+			   void *cookie);
+void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+			     struct io_pgtable_cfg *cfg,
+			     void *cookie);
+void *__arm_lpae_alloc_data(size_t size, gfp_t gfp);
+void __arm_lpae_free_data(void *p);
+#ifndef __KVM_NVHE_HYPERVISOR__
+#define __arm_lpae_virt_to_phys	__pa
+#define __arm_lpae_phys_to_virt	__va
+#endif /* !__KVM_NVHE_HYPERVISOR__ */
 #endif /* IO_PGTABLE_ARM_H_ */
-- 
2.51.0.rc1.167.g924127e9c0-goog


