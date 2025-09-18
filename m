Return-Path: <linux-kernel+bounces-776565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C641EB2CED2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC041C40DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861334F46C;
	Tue, 19 Aug 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXzjiuqm"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D031DDAD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640372; cv=none; b=Z+8PFwlRS1XhHKGkGHn1DT9NWCTPVUPhxX4QIRUi6isLmtonDxb5DOceUg1u1vN702WyVhV/w88TCQvHudc4K+enQq9Tw1uOaxeE0u1jNGMOdZBUBnzPNxm4RjKq2CZx8uqRHM76pws+HXZB+zEGny11tat40dzZjD9bsmji7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640372; c=relaxed/simple;
	bh=5TTl062DHH7yHuyRacgTvFvIS4u56vNnv9ZfS0wBre8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M0tljLFrZQ8QQQFeENgfrivj3hH6EU2E1fIg3i+TamWG888Ws809Ji8cUq3rQo5OyJD4BHYhIyKJ6pdqYXOKAr5H9FoDFu64W6k2P3/mEZNVfhjQBJ8rwsRmB8iquww8PnYRsK0K7JP8TRk1SKuqBkpZwNeFi1/XNZ9m3m5d/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXzjiuqm; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b467f5173so4286085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640369; x=1756245169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQKSjbAOLoARkZeCpW60ga+O1M1bwmJjgvA8RqrWhDQ=;
        b=xXzjiuqm8zQiMeM2j9o5+ReV6d9s/k+602rQusVBbkStvT81j4CnJZdXEnbcaRL1Dz
         ycHesIU256QDRu0ASIeJbjQ36DvMCxK+/BxwGfmkLZKFFPVft5Q899Rid4X5MsBbhYZu
         DQz/ZiPsz9kyXfvz9ERIouzyZqvkfCiSQG9HqgF7WEpxmc46YM0zyo+MLXqGihEeHBbp
         cjYzI/u4ojsXXYu3JmAKECrL7y1XD1wfzmBoCwz6Flghaq0eLQSvFbqCfVmoCpuZ9vYH
         a2CQ9jxV311aLhquO9oAI9QcnxqVGXz2O5gCijjg3+SHpkGCT7ipAWAVWyB6CEiEOvla
         EAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640369; x=1756245169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQKSjbAOLoARkZeCpW60ga+O1M1bwmJjgvA8RqrWhDQ=;
        b=LgxYxyUUeufpG42xiHBshWsuEfmCVwRbXdEi7GsUhh3wn0WtWbm/P4mWSrV9iVJTY2
         IAWxNpnbDseixNTE2vGADCZcK17wQxGuIo4rYww1/XBELa229mqBkHI3hVrjVOBAc5e+
         tFtOz/mjtwqLa9cHAAEwX3Erny5uiad6yo0v7ygbThOriI2NWZn1ubA/xHV20/kgAV8+
         K2wzQG8mle+0zukiNW3qg/5pJIOH/5NEjg4uHG7ApE9xLhBsA6+mxKciefK2maR1PFhd
         0/AV1E3uWJALzC3IJeYJzSH1I6g1TdO+0ujt2DHsdKFh9TCsav3zFTiQedvsXoaxxASD
         rtfw==
X-Gm-Message-State: AOJu0YxHRE9nSn7Kd7hr0zJ0TMlysLwE/8Wk7ZZVgNhCEu40Kx2422ib
	H3O5096zWFlkj+eD4MoQF6S0HDneGahJBXSVZhp3IxdRzmsJl1sx/Z7BiN+BvdlF2rjpGtHn9+P
	19l24Fj2oJI4Zc8PzNFBWnXZNdSD10w5o5q7ac0h4w66qGCmH4SlH93OWU379TVqJpm/TvDTr9h
	0MD0ltvBxPLrdoPRS4gFh6v+4KhHw3rpdVWbMRcSWqv+lUzIiRCnzykM0=
X-Google-Smtp-Source: AGHT+IEeSFl8aQhXA74KHxoebV5C+2+fcJhttjMY5RrNdpsd+ZTDbX53WFbbWrnver3BkDgaNxReEk7xnsBkcQ==
X-Received: from wmsr18.prod.google.com ([2002:a05:600c:8b12:b0:459:dcaa:ec9e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5250:b0:459:10de:551e with SMTP id 5b1f17b1804b1-45b479fd300mr2516095e9.27.1755640368689;
 Tue, 19 Aug 2025 14:52:48 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:54 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-27-smostafa@google.com>
Subject: [PATCH v4 26/28] iommu/arm-smmu-v3-kvm: Support io-pgtable
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add hooks needed to support io-pgtable-arm, mostly about
memory allocation.

Also add a function to allocate s2 64 bit page table.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile              |  4 +-
 .../arm/arm-smmu-v3/pkvm/io-pgtable-arm-hyp.c | 64 +++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                |  2 +-
 drivers/iommu/io-pgtable-arm.h                | 11 ++++
 4 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm-hyp.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c71c96262378..10090be6b067 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -34,7 +34,9 @@ hyp-obj-y += $(lib-objs)
 HYP_SMMU_V3_DRV_PATH = ../../../../../drivers/iommu/arm/arm-smmu-v3
 
 hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += $(HYP_SMMU_V3_DRV_PATH)/pkvm/arm-smmu-v3.o \
-	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-hyp.o
+	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-hyp.o \
+	$(HYP_SMMU_V3_DRV_PATH)/pkvm/io-pgtable-arm-hyp.o \
+	$(HYP_SMMU_V3_DRV_PATH)/../../io-pgtable-arm.o
 
 ##
 ## Build rules for compiling nVHE hyp code
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm-hyp.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm-hyp.c
new file mode 100644
index 000000000000..6cf9e5bb76e7
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/io-pgtable-arm-hyp.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Arm Ltd.
+ */
+#include <nvhe/iommu.h>
+
+#include "../../../io-pgtable-arm.h"
+
+struct io_pgtable_ops *kvm_alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
+						struct io_pgtable_cfg *cfg,
+						void *cookie)
+{
+	struct io_pgtable *iop;
+
+	if (fmt != ARM_64_LPAE_S2)
+		return NULL;
+
+	iop = arm_64_lpae_alloc_pgtable_s2(cfg, cookie);
+	iop->fmt	= fmt;
+	iop->cookie	= cookie;
+	iop->cfg	= *cfg;
+
+	return &iop->ops;
+}
+
+void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+			     struct io_pgtable_cfg *cfg, void *cookie)
+{
+	void *addr;
+
+	addr = kvm_iommu_donate_pages(get_order(size));
+
+	if (addr && !cfg->coherent_walk)
+		kvm_flush_dcache_to_poc(addr, size);
+
+	return addr;
+}
+
+void __arm_lpae_free_pages(void *addr, size_t size, struct io_pgtable_cfg *cfg,
+			   void *cookie)
+{
+	if (!cfg->coherent_walk)
+		kvm_flush_dcache_to_poc(addr, size);
+
+	kvm_iommu_reclaim_pages(addr);
+}
+
+void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
+			 struct io_pgtable_cfg *cfg)
+{
+	if (!cfg->coherent_walk)
+		kvm_flush_dcache_to_poc(ptep, sizeof(*ptep) * num_entries);
+}
+
+/* At the moment this is only used once, so rounding up to a page is not really a problem. */
+void *__arm_lpae_alloc_data(size_t size, gfp_t gfp)
+{
+	return kvm_iommu_donate_pages(get_order(size));
+}
+
+void __arm_lpae_free_data(void *p)
+{
+	return kvm_iommu_reclaim_pages(p);
+}
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 2ca09081c3b0..211f6d54b902 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -947,7 +947,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
-static struct io_pgtable *
+struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	u64 sl;
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
index 7d9f0b759275..194c3e975288 100644
--- a/drivers/iommu/io-pgtable-arm.h
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -78,8 +78,19 @@ void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 			     void *cookie);
 void *__arm_lpae_alloc_data(size_t size, gfp_t gfp);
 void __arm_lpae_free_data(void *p);
+struct io_pgtable *
+arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie);
 #ifndef __KVM_NVHE_HYPERVISOR__
 #define __arm_lpae_virt_to_phys	__pa
 #define __arm_lpae_phys_to_virt	__va
+#else
+#include <nvhe/memory.h>
+#define __arm_lpae_virt_to_phys	hyp_virt_to_phys
+#define __arm_lpae_phys_to_virt	hyp_phys_to_virt
+#undef WARN_ONCE
+#define WARN_ONCE(condition, format...)	WARN_ON(1)
+struct io_pgtable_ops *kvm_alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
+						struct io_pgtable_cfg *cfg,
+						void *cookie);
 #endif /* !__KVM_NVHE_HYPERVISOR__ */
 #endif /* IO_PGTABLE_ARM_H_ */
-- 
2.51.0.rc1.167.g924127e9c0-goog


