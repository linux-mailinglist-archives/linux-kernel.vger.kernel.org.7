Return-Path: <linux-kernel+bounces-776550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB8B2CEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B563E2A6424
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1176343D9E;
	Tue, 19 Aug 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+E170kc"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A935A281
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640359; cv=none; b=UlPKyEVxTaaqQShq8uFMgcjR/tTH9AqsX/BfSlz67KCC0h/JYUTLqMCjTd04REILOhQoH3qd4q8r0FZT0UYJ5cxhIJKLUcHgA0zh3ZazmcW9X3lFkKVs7bPePYht3wvTjD3BOb3joPapMjv+G1Nm9ZEDSoa+7dBYkUv7JF52ktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640359; c=relaxed/simple;
	bh=vXwQDqElLwmdFXH6atI73BgGkGDD39YTucq302WuvLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YorD5kIaABeJn632BqeHS648kNq1yfvh9Pj0iDZXw0Y4+hfLQ67+VyCfp+ujjF1fXm2y2AvbVrC5kd3noHZqHcnuhQRxHsWyBbn8WVTNAMrXHtFIwbQ46vj4TjYmkHSwji4wxGl/be9FdCR8XF9/VoXRzUuO1TddiaFCRuNk4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+E170kc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso2609393f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640355; x=1756245155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHyXp0c9r8a6Z3kqM6MYogJzQkCF/sRbjU6o05FpAFo=;
        b=a+E170kcRHESTgF8KYS2+YedhptexBklgcrhhWSp1WX7kEw3ckG0EGARBuPWGIeyAs
         n6/j1+VMqpZlJgkgnF8cXTjQy2zY38DK02re6qRCB20Hx9HqRs1zDDaV7wHBzwSXVrrC
         /vND0T2kA1fi5QgxTDo3MXG64TRlAmE2e+hfMQQVgj2E89B3DzC+ISU33nTNQfJjyxRR
         vAVYI59KlLL8RZVSv0O255VpW5uQSyxMkMCutSTgs8aH5Sf1N/+qU8JUsW863l9AsVv5
         qlFqj5QQySHp7T70+KemVNaVkiBd2Oe93G8feba0+PDRHF4hIi9asUMvRTxLxvnwV59e
         FbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640355; x=1756245155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHyXp0c9r8a6Z3kqM6MYogJzQkCF/sRbjU6o05FpAFo=;
        b=SI5Avcfh4PQAWkprnSPG6VZPuVBryfThkxkwAJHHzG3RGIY9YWK5QE2vPLlcI8aj2C
         5mD5Wa3aCkqBz1XKZ8wVJ6W0FMAUDCkjz/AihivI54UZvCSiK6o7mlMYfiyYlmxfjqt3
         vMZuZbnSQcKh+cHz7hrf1SvkpQt7Mdpfce6fqd6k1Qh0jQ4ox+OsGzVd4qgCHVB+qllj
         UNNTo86W54rN7sryVHP25Lg/jkTnxeAN9x2FsPhk0LQ/4j2MzAXv/Wfah5d3/jf9hLk9
         NDEGShQ9N4Z70o1WYwNiXu4uc0cPo1riv1hUU/wbLwZSFxDV5Rn6G9RbDGr/gZFQbReP
         Zunw==
X-Gm-Message-State: AOJu0Yx/R+/GoBMRBpM8+7SiU4KKMfRiyr8kXLPJ447ZSe+I/rpQpKfr
	qLe8QvpXIJ/MchRLcgqIvJZzg5Cns3QMLCACK9rMDixx5f+IAvfvTXhJiqYdV6pQ3uNlYIaNGBX
	TjXboDxHHrdAZlXhFoEjvQIJbx8zknFY7kOMFCvV2Z6atWumbCGm113zrKzaL/8tT48N9ct9kL2
	JgT6tIQMbYy2+CUvChhaE7gbIl8v3ae4EPeRzPQKHlntzkUoujAryDrkY=
X-Google-Smtp-Source: AGHT+IF09z/zChrY/XKW2p3rPVo1I7WRsoRzioqDNTUyJHzYESu4rlz8VOrrsAe/v0WNmek1lpwYcIduC6GS/A==
X-Received: from wmth10.prod.google.com ([2002:a05:600c:8b6a:b0:459:e347:8a6e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4284:b0:3a6:d145:e2cc with SMTP id ffacd0b85a97d-3c32e03e447mr337072f8f.15.1755640354609;
 Tue, 19 Aug 2025 14:52:34 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:39 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-12-smostafa@google.com>
Subject: [PATCH v4 11/28] KVM: arm64: iommu: Add memory pool
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
 arch/arm64/include/asm/kvm_host.h       |  1 +
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 20 +++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c         | 10 +++++++++-
 arch/arm64/kvm/iommu.c                  | 11 +++++++++++
 arch/arm64/kvm/pkvm.c                   |  1 +
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1a08066eaf7e..fcb4b26072f7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1676,5 +1676,6 @@ void check_feature_map(void);
 
 struct kvm_iommu_ops;
 int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
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
index 926a1a94698f..5460b1bd44a6 100644
--- a/arch/arm64/kvm/iommu.c
+++ b/arch/arm64/kvm/iommu.c
@@ -7,9 +7,20 @@
 #include <linux/kvm_host.h>
 
 extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
+extern size_t kvm_nvhe_sym(hyp_kvm_iommu_pages);
 
 int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
 {
 	kvm_nvhe_sym(kvm_iommu_ops) = hyp_ops;
 	return 0;
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
2.51.0.rc1.167.g924127e9c0-goog


