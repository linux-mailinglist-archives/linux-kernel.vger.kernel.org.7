Return-Path: <linux-kernel+bounces-776552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19419B2CEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B51188562E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB931DD8B;
	Tue, 19 Aug 2025 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a94wrXlR"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCBE35A2B9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640360; cv=none; b=pHXDmZotDXJxLkKzcpK9gxSa/nkOkafnKLFR+FcUmP+ax/S4Sxn7F/F78DHPlBAY2fbrFtinlxDOaF5vo9NE4cARZjS2NXSMNXfeWKl2ZC72mGqNByMEOrC7OEBmTAGxqe4pCYM6zQXSg9Dln7MViTuret6ziydlnEFQHJRCmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640360; c=relaxed/simple;
	bh=ZStA5L9CRyv7ZGIOd1ez63lJfoDR2LVWfDOZLq7FmHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NnemI8XZcGkcT98Nvsr6ZFepx7QZJFvzCaQJPf9FbVmCgAKXd+Z9Q/K7be761vSzEMO373e5EInlvrFGa85DNCfwhQFyMwxYy1SpZLURlvMFg0OzdFI90x12D32Mom0CShl9M4n2nt/TknEwpUZRsAfmhK3AnzyO9O9w/Fp2ejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a94wrXlR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e4157303so4677820f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640355; x=1756245155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBsLyy3u3rOhplnfl3DMV6GQeOwFjCQ0fFDaMLqFvas=;
        b=a94wrXlRoiGB8lzHiXUE11dWoxIl7mK1MXL5fIXLyYnSAdSlAQIkf48vvqU6WYVT0J
         fOcrFGA7KaKvztxR1CQvrIN50dPD2zUX3gfaqpfuS7cASWzLiBX6awuwD70KjfDaKOKx
         EsOeG686+4oMNURr8fiRGPKUiUZylFxOO/6I2iQiTEVV4xojiMjUZCR4OILQtqBhUtBR
         ZluNn2qhAwMg79UQ177ZSn5gu0sc8NnE5YXBqmX4czcyrH3diKROFUA5wdbz6EB4vlTn
         o9x0iWr80s4sTdEH/1bVpYs9x19K0swSdvNgtrXAO/Pj3yys6XlgeKRMAP5DZ2K3tYRm
         hffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640355; x=1756245155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBsLyy3u3rOhplnfl3DMV6GQeOwFjCQ0fFDaMLqFvas=;
        b=OWGw9Gyq88ZGeBs4rQG9welOzPDWQuy3eoaS/+7aU09kL81D8e+vSAgsACj2L7uMxW
         ELetW7OUv2BlnsouSeVNhjeNuLh38uqKksEn/4Nu74Zq4Vx4NejI3XNepyaHZqCl5CCX
         17yFsdwhU/LhFopksqsaMwbGVlX4Yd2IRuzB2WvE7lrCte3LxiDQaakeS5NmaKAnf2Li
         f9Hqa0lqBVR0q2kgQXrREQAlgNfdZG0ifmY8DJa1y5GFyyy4NELzvuFKkGXRT/ecUE9P
         GqI1jsirPzEwf49sYRLj6ycmdLsFdJA9jL8yK6NlzjpKvNOp2tppU+h+rGq6VGM7vIS5
         8/2g==
X-Gm-Message-State: AOJu0YzOxriIJBV1hqUGv25K9x4LOpyU603SKun8Jq4CCTNYLRPGvoJB
	zy9RjpGLLnPVQwrWWY09KPWqwRnVFUbE+2ZEd6jFyIzlQ7Cqj1GW/JEfKPa/HjV7n4kjMpgRnk3
	pZ4qst4ZfV3WO5o6QMWO9sqSgJrX4uC2isHOueiJxtKsGSY2vLB+fdtopND43IpkfOkaO4Xb8zC
	5tHsnYU4l5dBYlccp6/buW7ZsJhQE4r9YoOciC//9Q5A9EcWgRyKhkA9E=
X-Google-Smtp-Source: AGHT+IGi+MrTYS9vOAkhE2MwbT5in2zuzEYUdbygOz38UpjYqK2AvcuVjizybf9/jK1Tu7dGcGgyI44X4YgECw==
X-Received: from wmsr19.prod.google.com ([2002:a05:600c:8b13:b0:459:8c48:6c34])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:22c4:b0:3a4:eb92:39b6 with SMTP id ffacd0b85a97d-3c32eeb8077mr359066f8f.54.1755640355498;
 Tue, 19 Aug 2025 14:52:35 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:40 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-13-smostafa@google.com>
Subject: [PATCH v4 12/28] KVM: arm64: iommu: Support DABT for IOMMU
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

SMMUv3 driver need to trap and emulate access to the MMIO space as
part of the nested implementation.

Add a handler for DABTs for IOMMU drivers to be able to do so, in
case the host fault in page, check if it's part of IOMMU emulation
first.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_arm.h        |  2 ++
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  3 ++-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 15 +++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c   | 10 ++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 1da290aeedce..8d63308ccd5c 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -331,6 +331,8 @@
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
 #define HPFAR_MASK	(~UL(0xf))
+
+#define FAR_MASK GENMASK_ULL(11, 0)
 /*
  * We have
  *	PAR	[PA_Shift - 1	: 12] = PA	[PA_Shift - 1 : 12]
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 9f4906c6dcc9..10fe4fbf7424 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -8,6 +8,7 @@
 struct kvm_iommu_ops {
 	int (*init)(void);
 	void (*host_stage2_idmap)(phys_addr_t start, phys_addr_t end, int prot);
+	bool (*dabt_handler)(struct user_pt_regs *regs, u64 esr, u64 addr);
 };
 
 int kvm_iommu_init(void *pool_base, size_t nr_pages);
@@ -16,5 +17,5 @@ void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
 				 enum kvm_pgtable_prot prot);
 void *kvm_iommu_donate_pages(u8 order);
 void kvm_iommu_reclaim_pages(void *ptr);
-
+bool kvm_iommu_host_dabt_handler(struct user_pt_regs *regs, u64 esr, u64 addr);
 #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index 1673165c7330..376b30f557a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2022 Linaro Ltd.
  */
+#include <asm/kvm_hyp.h>
+
+#include <hyp/adjust_pc.h>
+
 #include <linux/iommu.h>
 
 #include <nvhe/iommu.h>
@@ -113,3 +117,14 @@ void kvm_iommu_reclaim_pages(void *ptr)
 {
 	hyp_put_page(&iommu_pages_pool, ptr);
 }
+
+bool kvm_iommu_host_dabt_handler(struct user_pt_regs *regs, u64 esr, u64 addr)
+{
+	if (kvm_iommu_ops && kvm_iommu_ops->dabt_handler &&
+	    kvm_iommu_ops->dabt_handler(regs, esr, addr)) {
+		/* DABT handled by the driver, skip to next instruction. */
+		kvm_skip_host_instr();
+		return true;
+	}
+	return false;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index bce6690f29c0..7371b2183e1e 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -595,6 +595,11 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
+static bool is_dabt(u64 esr)
+{
+	return ESR_ELx_EC(esr) == ESR_ELx_EC_DABT_LOW;
+}
+
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
@@ -617,6 +622,11 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 	 */
 	BUG_ON(!(fault.hpfar_el2 & HPFAR_EL2_NS));
 	addr = FIELD_GET(HPFAR_EL2_FIPA, fault.hpfar_el2) << 12;
+	addr |= fault.far_el2 & FAR_MASK;
+
+	if (is_dabt(esr) && !addr_is_memory(addr) &&
+	    kvm_iommu_host_dabt_handler(&host_ctxt->regs, esr, addr))
+		return;
 
 	ret = host_stage2_idmap(addr);
 	BUG_ON(ret && ret != -EAGAIN);
-- 
2.51.0.rc1.167.g924127e9c0-goog


