Return-Path: <linux-kernel+bounces-748465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C65B14187
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116AB3AA433
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD54285C86;
	Mon, 28 Jul 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fb0bf7k1"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAD27FB03
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725230; cv=none; b=J82AWdR1Poo8vdzeEKE8Dms98hryiarE1gGhQ6RUtfeX/4eOmVvmmtKDrjXAWKC0qWd0lFEVdXC6Xhbh0nY3cCt7HaGsisIbNdy5AGN6N1YLRRWbgMXTBTJtzzSZCNyHhHpJ5O6VgcgPjNx7F93VvpG4pgTLJbPVjxhkaDs5YSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725230; c=relaxed/simple;
	bh=k23bfvplNAwitDDrR+QqOLk2PWGMR1CFi2mAbN802lI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnSLr9IxxVtwBbvl10D3YTDJrI7x64V4UkeBuZb+Oc4MSTdG2ldeNFkK53Z7Wzend1dNyogVNqxd9sdJ64ENsl1fJ7nLSpNj3Zk9E4OzUv0JULK4SUzutCl30wcmlnb/pl/p/acT7L7p3dl5JTS7tJqy2vw+HLZvjR8g5ybLnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fb0bf7k1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so22265285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725226; x=1754330026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAiqVxZ7mCYV4OWmhh9mR5NXqluabCZXrZLF2m+GiJw=;
        b=Fb0bf7k1SmhhunxvBFj1kVYkAwUO3z2+H1oUmpTjtwC85Ze3D3pPyfmeKRFayZcn/B
         mLZESnlot7AZXi+cU6YMOiPtgqzHvCCjyWO8Yn6FfmUl6+lbau3JYHUqwUZ1u8lTjddD
         hIgNZXaixE/yYpIJosaNx0z8pNwXZ0GGkz39G1OIdGyrWdMrjWrivcXePsZ2Y5yYe45H
         CJ8oxi0usWHZqEjer3OBHudLn/JtGKVWZ40MWXOIWnWtnbxgpgRzh6fhqHgbtnWyIzn0
         6UvmQt6C2b8BoWdWlXxxfCoAAy+vzR6VOhqlojK3UAsz6lSpiYYZPrCfRfa8jO6+l0HB
         DPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725226; x=1754330026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAiqVxZ7mCYV4OWmhh9mR5NXqluabCZXrZLF2m+GiJw=;
        b=LpXmwpa11iIAcs6JBPotdiafttVcjrLtxVlbMgpy3EEd3UBrXqT2jwzcbciQmpWS00
         G35JzyfMwUdC+nH3U6eNfGC/eldxsOwl0hKB2zMrfI02uESaNntLHaggtdxgF5KRxvn5
         SZaaRjxNdj5OZ1ULuKbgGbgnkOFIChzyQPj5FteoSvNmVfyIlBik2iwb9tyZcSfr078R
         6opidnFy3Sp/0uo4rEsY7odQFAwbVKI4UdXOrCKCrfJKroS3ZWMIY17biMWNnKQc2NlP
         q13IyOL6xNu/S5yV1RGLDELrQ0BsnsbuGMQn7TuBCPNlF1g2dpGYqk0n9JwycEjFB5u1
         ZOeQ==
X-Gm-Message-State: AOJu0YzqrXTxYJn1YZ2BXSd7Yc2i0KCBj74GHIirGtIt6DiN4EqZcoI9
	wwWCsSZMXeT/6qE7N6SKaoUE3LMxTXM9Uq96jQnfGoyaDyhVijMfoGCekqRz5S8YfKAxx4fj0Ly
	Mx/ss9DiQwXvwicb8zblb/jrRxbbm/nmL9x3jliTQcJVyL8IoTpbDNcnoQG40eAvm1STsk9Voh5
	C5f+qBod0MGwcSfBfx0anX6DZ2ecC2RQfbRQXZhXzq8g/yuqOPgpDMHIs=
X-Google-Smtp-Source: AGHT+IGxhcTiKxONEChgJsqLDp77mJTIBJlAgPlupgVaUnKzyizUILcxAuGgCSiYGQ4pyLn0idb1VM879Ws0RA==
X-Received: from wmbje21.prod.google.com ([2002:a05:600c:1f95:b0:456:506:259c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5292:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-4587d64e83dmr72530965e9.12.1753725226335;
 Mon, 28 Jul 2025 10:53:46 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:03 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-17-smostafa@google.com>
Subject: [PATCH v3 16/29] KVM: arm64: iommu: Add a memory pool
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

IOMMU drivers would require to allocate memory for the shadow page
table. Similar to the host stage-2 CPU page table, the IOMMU pool
is allocated early from the carveout and it's memory is added in
a pool which the IOMMU driver can allocate from and reclaim at
run time.

At this point the nr_pages is 0 as there are no driver, in the next
patches when the SMMUv3 driver is added, it will add it's own function
to return the number of pages needed in kvm/iommu.c.
Unfortunately, this part has 2 leak into kvm/iommu as this happens too
early before drivers can have any init calls.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_host.h       |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 20 +++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c         | 10 +++++++++-
 arch/arm64/kvm/iommu.c                  | 11 +++++++++++
 arch/arm64/kvm/pkvm.c                   |  1 +
 6 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 43f5a64bbd1d..b42e32ff2a84 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1683,5 +1683,5 @@ struct kvm_iommu_ops;
 int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops, struct kvm_iommu_ops *hyp_ops);
 int kvm_iommu_init_driver(void);
 void kvm_iommu_remove_driver(void);
-
+size_t kvm_iommu_pages(void);
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 219363045b1c..9f4906c6dcc9 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -10,8 +10,11 @@ struct kvm_iommu_ops {
 	void (*host_stage2_idmap)(phys_addr_t start, phys_addr_t end, int prot);
 };
 
-int kvm_iommu_init(void);
+int kvm_iommu_init(void *pool_base, size_t nr_pages);
 
 void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
 				 enum kvm_pgtable_prot prot);
+void *kvm_iommu_donate_pages(u8 order);
+void kvm_iommu_reclaim_pages(void *ptr);
+
 #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index f7d1c8feb358..1673165c7330 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -15,6 +15,7 @@ struct kvm_iommu_ops *kvm_iommu_ops;
 
 /* Protected by host_mmu.lock */
 static bool kvm_idmap_initialized;
+static struct hyp_pool iommu_pages_pool;
 
 static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
 {
@@ -72,7 +73,7 @@ static int kvm_iommu_snapshot_host_stage2(void)
 	return ret;
 }
 
-int kvm_iommu_init(void)
+int kvm_iommu_init(void *pool_base, size_t nr_pages)
 {
 	int ret;
 
@@ -80,6 +81,13 @@ int kvm_iommu_init(void)
 	    !kvm_iommu_ops->host_stage2_idmap)
 		return -ENODEV;
 
+	if (nr_pages) {
+		ret = hyp_pool_init(&iommu_pages_pool, hyp_virt_to_pfn(pool_base),
+				    nr_pages, 0);
+		if (ret)
+			return ret;
+	}
+
 	ret = kvm_iommu_ops->init();
 	if (ret)
 		return ret;
@@ -95,3 +103,13 @@ void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
 		return;
 	kvm_iommu_ops->host_stage2_idmap(start, end, pkvm_to_iommu_prot(prot));
 }
+
+void *kvm_iommu_donate_pages(u8 order)
+{
+	return hyp_alloc_pages(&iommu_pages_pool, order);
+}
+
+void kvm_iommu_reclaim_pages(void *ptr)
+{
+	hyp_put_page(&iommu_pages_pool, ptr);
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index bdbc77395e03..09ecee2cd864 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -21,6 +21,7 @@
 #include <nvhe/trap_handler.h>
 
 unsigned long hyp_nr_cpus;
+size_t hyp_kvm_iommu_pages;
 
 #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
 			 (unsigned long)__per_cpu_start)
@@ -33,6 +34,7 @@ static void *selftest_base;
 static void *ffa_proxy_pages;
 static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
 static struct hyp_pool hpool;
+static void *iommu_base;
 
 static int divide_memory_pool(void *virt, unsigned long size)
 {
@@ -70,6 +72,12 @@ static int divide_memory_pool(void *virt, unsigned long size)
 	if (!ffa_proxy_pages)
 		return -ENOMEM;
 
+	if (hyp_kvm_iommu_pages) {
+		iommu_base = hyp_early_alloc_contig(hyp_kvm_iommu_pages);
+		if (!iommu_base)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -321,7 +329,7 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = kvm_iommu_init();
+	ret = kvm_iommu_init(iommu_base, hyp_kvm_iommu_pages);
 	if (ret)
 		goto out;
 
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
index 39465101074a..0e52cc0e18de 100644
--- a/arch/arm64/kvm/iommu.c
+++ b/arch/arm64/kvm/iommu.c
@@ -9,6 +9,7 @@
 
 struct kvm_iommu_driver *iommu_driver;
 extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
+extern size_t kvm_nvhe_sym(hyp_kvm_iommu_pages);
 
 int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops, struct kvm_iommu_ops *el2_ops)
 {
@@ -47,3 +48,13 @@ void kvm_iommu_remove_driver(void)
 	if (smp_load_acquire(&iommu_driver))
 		iommu_driver->remove_driver();
 }
+
+size_t kvm_iommu_pages(void)
+{
+	/*
+	 * This is called very early during setup_arch() where no initcalls,
+	 * so this has to call specific functions per each KVM driver.
+	 */
+	kvm_nvhe_sym(hyp_kvm_iommu_pages) = 0;
+	return 0;
+}
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index fcd70bfe44fb..6098beda36fa 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -63,6 +63,7 @@ void __init kvm_hyp_reserve(void)
 	hyp_mem_pages += hyp_vmemmap_pages(STRUCT_HYP_PAGE_SIZE);
 	hyp_mem_pages += pkvm_selftest_pages();
 	hyp_mem_pages += hyp_ffa_proxy_pages();
+	hyp_mem_pages += kvm_iommu_pages();
 
 	/*
 	 * Try to allocate a PMD-aligned region to reduce TLB pressure once
-- 
2.50.1.552.g942d659e1b-goog


