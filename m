Return-Path: <linux-kernel+bounces-776549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD55B2CEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7FE1C285F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC235A299;
	Tue, 19 Aug 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vktyHfN0"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E43570A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640357; cv=none; b=s3c35bGXq7mdw0Xi0JucMh783l4IFdZaPNOZYfyOuHyuFWTRn2WsdcHuWMwE/CAEtWHNRMEWu7IZZw7XzG379dbSOQbcHWOUd1T0xtlj5YUQK2dJMQuYv3T1B/vyQAdhKQmfX0hRethLvWfW945Hk5wtMGNoXHKVStgSvZ66X5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640357; c=relaxed/simple;
	bh=HSd950jJ2t4GJC22m7W741IHNilb7Crd6j1IkBxAl2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QCunWkMaqQgN7kKMb7yvqtf77z+mMrvI/l+OqUCB+SYPAYiqFtzFiXUQSOphIMl2jsYZq+ITQy8+joq43My0vOT+zX0232nwpYgBXcmkY/qTpu/F0yu2F0VBeQFYhc61p/T4xuIkZEAiuju3Njv9tVibnuL/aEhTBufOWJMxQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vktyHfN0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0d0feaso34565205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640353; x=1756245153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTW2UGpkj+rMJnUPmb+I3Uc3pZGMzoyVmbU3iR5h6JE=;
        b=vktyHfN0KRINQj90AcXKe7Lsha2rmZ8EL3eXvAh+CD/Y+2rq1cH2dUUB9RpXeQbVeQ
         dp1Z5BC2x02dX0C3UeBLoajIGa+00sSZwUgOM9rmuBRCST3sj779d2pIWxbSTL+L8ol5
         Oo1TIxnePGrUwd62NOUzBhn38Ap7umfuLBFvSHWzKoVb+pvp1532+u0yWZNrc8Brzkfa
         G94I8PD69a2xnNpFEx2rhTJxIsAYy59kLwY086tY1mUlpRj556f8TpscpypbGyqMHTp/
         MU0zTyLuCidUdr19cesvkzoYU6k+1PSloGloDr7pKCX11eS7HQI0jo/+TywhaTKWN/yH
         Ztqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640353; x=1756245153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTW2UGpkj+rMJnUPmb+I3Uc3pZGMzoyVmbU3iR5h6JE=;
        b=TZ+vj7Ywu48HhJPWJrw+pqYhGuqSOnXaP5Ob/7jnfdPwitDbMAP/EQsYG2PpYNBnQK
         LV3kwMLYsoPD+1jBWOcxXUJZUNRLbIYD13mUwEvtl+L55hdHFJ2jMdXH9elGwdv49ql3
         ses3Ekj4j+duCGvyqEp3M2gcfPfq3PQMVsWHx/KS5EvcG5YMGkxDC+WIk1RT30604lA/
         ETC1+s56CCQiEkXLeg3swXI1fhEQ64GFvPgt9HVgIRBlGadvLzu5M3sn4iypbuOxSjwc
         fi6jxqTG8Th7e9KeMkXFk/UckUp+14BMedPbh4DdhMTaeSC0AF9W5xGK1l2adCHcXsDZ
         iHTw==
X-Gm-Message-State: AOJu0YytB+adgNXIZ9dYwvxdzYiHNdi34ZzPnKVsaDnQ6QOWYVcmHjE3
	iCAp/oHJcV55y7E9afitfqO5s5wuO7AZ7F8P0/4/jjHgf7s5zU/xj2oM7zowRZblJyXuzQhsHR9
	AgtL2hTU+jEwrnKIex46yC/zlRjV/2wOlGtpaZTR75xgM+89WdNsuZKYt+bJO1ZiDwCoWRvIhbr
	J56WKXqxHsYM8JCd5S8STZNh2+D3YhynkAttfD11TDVNKW1olKl4BrA4E=
X-Google-Smtp-Source: AGHT+IFC4f9TFYtJcHeYguMFJJzghlWK9KU6mi0KIys1MVGWduWRRdB37rOMzmuqxanQUm8EohCMZm6hqx7hmQ==
X-Received: from wmpz12.prod.google.com ([2002:a05:600c:a0c:b0:459:de2a:4d58])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154b:b0:459:dc35:dc05 with SMTP id 5b1f17b1804b1-45b479a393dmr3326805e9.9.1755640353566;
 Tue, 19 Aug 2025 14:52:33 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:38 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-11-smostafa@google.com>
Subject: [PATCH v4 10/28] KVM: arm64: iommu: Shadow host stage-2 page table
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Create a shadow page table for the IOMMU that shadows the
host CPU stage-2 into the IOMMUs to establish DMA isolation.

An initial snapshot is created after the driver init, then
on every permission change a callback would be called for
the IOMMU driver to update the page table.

For some cases, an SMMUv3 may be able to share the same page
table used with the host CPU stage-2 directly.
However, this is too strict and requires changes to the core hypervisor
page table code, plus it would require the hypervisor to handle IOMMU
page faults. This can be added later as an optimization for SMMUV3.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  4 ++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 83 ++++++++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c   |  5 ++
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 1ac70cc28a9e..219363045b1c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -3,11 +3,15 @@
 #define __ARM64_KVM_NVHE_IOMMU_H__
 
 #include <asm/kvm_host.h>
+#include <asm/kvm_pgtable.h>
 
 struct kvm_iommu_ops {
 	int (*init)(void);
+	void (*host_stage2_idmap)(phys_addr_t start, phys_addr_t end, int prot);
 };
 
 int kvm_iommu_init(void);
 
+void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
+				 enum kvm_pgtable_prot prot);
 #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index a01c036c55be..f7d1c8feb358 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -4,15 +4,94 @@
  *
  * Copyright (C) 2022 Linaro Ltd.
  */
+#include <linux/iommu.h>
+
 #include <nvhe/iommu.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/spinlock.h>
 
 /* Only one set of ops supported */
 struct kvm_iommu_ops *kvm_iommu_ops;
 
+/* Protected by host_mmu.lock */
+static bool kvm_idmap_initialized;
+
+static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
+{
+	int iommu_prot = 0;
+
+	if (prot & KVM_PGTABLE_PROT_R)
+		iommu_prot |= IOMMU_READ;
+	if (prot & KVM_PGTABLE_PROT_W)
+		iommu_prot |= IOMMU_WRITE;
+	if (prot == PKVM_HOST_MMIO_PROT)
+		iommu_prot |= IOMMU_MMIO;
+
+	/* We don't understand that, might be dangerous. */
+	WARN_ON(prot & ~PKVM_HOST_MEM_PROT);
+	return iommu_prot;
+}
+
+static int __snapshot_host_stage2(const struct kvm_pgtable_visit_ctx *ctx,
+				  enum kvm_pgtable_walk_flags visit)
+{
+	u64 start = ctx->addr;
+	kvm_pte_t pte = *ctx->ptep;
+	u32 level = ctx->level;
+	u64 end = start + kvm_granule_size(level);
+	int prot =  IOMMU_READ | IOMMU_WRITE;
+
+	/* Keep unmapped. */
+	if (pte && !kvm_pte_valid(pte))
+		return 0;
+
+	if (kvm_pte_valid(pte))
+		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
+	else if (!addr_is_memory(start))
+		prot |= IOMMU_MMIO;
+
+	kvm_iommu_ops->host_stage2_idmap(start, end, prot);
+	return 0;
+}
+
+static int kvm_iommu_snapshot_host_stage2(void)
+{
+	int ret;
+	struct kvm_pgtable_walker walker = {
+		.cb	= __snapshot_host_stage2,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+	struct kvm_pgtable *pgt = &host_mmu.pgt;
+
+	hyp_spin_lock(&host_mmu.lock);
+	ret = kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker);
+	/* Start receiving calls to host_stage2_idmap. */
+	kvm_idmap_initialized = !!ret;
+	hyp_spin_unlock(&host_mmu.lock);
+
+	return ret;
+}
+
 int kvm_iommu_init(void)
 {
-	if (!kvm_iommu_ops || !kvm_iommu_ops->init)
+	int ret;
+
+	if (!kvm_iommu_ops || !kvm_iommu_ops->init ||
+	    !kvm_iommu_ops->host_stage2_idmap)
 		return -ENODEV;
 
-	return kvm_iommu_ops->init();
+	ret = kvm_iommu_ops->init();
+	if (ret)
+		return ret;
+	return kvm_iommu_snapshot_host_stage2();
+}
+
+void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
+				 enum kvm_pgtable_prot prot)
+{
+	hyp_assert_lock_held(&host_mmu.lock);
+
+	if (!kvm_idmap_initialized)
+		return;
+	kvm_iommu_ops->host_stage2_idmap(start, end, pkvm_to_iommu_prot(prot));
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index c9a15ef6b18d..bce6690f29c0 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -15,6 +15,7 @@
 #include <hyp/fault.h>
 
 #include <nvhe/gfp.h>
+#include <nvhe/iommu.h>
 #include <nvhe/memory.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -529,6 +530,7 @@ static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
 {
 	int ret;
+	enum kvm_pgtable_prot prot;
 
 	if (!range_is_memory(addr, addr + size))
 		return -EPERM;
@@ -538,6 +540,9 @@ int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
 	if (ret)
 		return ret;
 
+	prot = owner_id == PKVM_ID_HOST ? PKVM_HOST_MEM_PROT : 0;
+	kvm_iommu_host_stage2_idmap(addr, addr + size, prot);
+
 	/* Don't forget to update the vmemmap tracking for the host */
 	if (owner_id == PKVM_ID_HOST)
 		__host_update_page_state(addr, size, PKVM_PAGE_OWNED);
-- 
2.51.0.rc1.167.g924127e9c0-goog


