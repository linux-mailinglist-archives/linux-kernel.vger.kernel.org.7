Return-Path: <linux-kernel+bounces-776558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76CB2CECD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C211C40CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5333436C;
	Tue, 19 Aug 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxY+NeyN"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C543277AA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640366; cv=none; b=qRqf4uhkgrOjxoHibcwvSncw7og9CJfI6OuESz77ymJgcdpTLFrHMLzjVil9LMmDNCSi6bDg7LNgiIuwo4WPAlk78u9xxERkCRGozj40x0cmPK+FPtNgS/IO8TDqOwdyasrdcD560wPEDOqbEFE/ppyVTykgHNqMPtAFaxKU1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640366; c=relaxed/simple;
	bh=XhZYr4PdM87HvMy3LEorV9A6JwTdgzf6sEBGmHDWIMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pawz7Vn/r2QeunSqm+aoBmv4d211kE7zbsaF4hz9i2EQ6MxYqvfKakTW0xC8TVbDCffn11qx6MMlf1Pi5jp10oBFY5naIKPwfW7fym5akHvtzoCd4dd7kGfmp+naQkrAt5eIwME5sTzAjD6iL1Jp097Ti6ZFcW6hfIuJ21Ijec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxY+NeyN; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb7a2ba1dso474665766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640363; x=1756245163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqV10pLXwwjj2OAipIDyVAMMO+u2/mFHIv6eR2zAaWM=;
        b=yxY+NeyN1pOd8voLfL1Kb1okCIgfeJnv4dLti386yzuBWwF63vkF+n5nqb6jX71Zoe
         dK/4uE2x6P03EA/mbGe8GbSkky7i9Mkktt4oT5AgOlPuXIuHcV82MAK2vwqEWO2i0C0w
         K9bHBuhz33KCU0Cmo3prELXJTRoSJe6p1P/9Kspw4gRaaMkJt63RyvWaoyj96VXyqsAu
         jVJ8OIvXlIvnUufbzZkwneO07uw0JASoTI/VYR77378QwHdowwgt8T2D7HouhMpeUvBh
         Gukfg7CuN7fwXwyVgH3DQe8xQd5cmXKWh4KheCgBvOj1SwJi1d3b2RYGQ2kuAnq2PYdy
         hKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640363; x=1756245163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqV10pLXwwjj2OAipIDyVAMMO+u2/mFHIv6eR2zAaWM=;
        b=lkcdRsn8NSw9M2ARMYiAiLjAEXoNU/mSYUDYool91NkBdeMsIOjCnAree2USG6nz/p
         dTN/qWVMl7KIqcKRYQl+ppW9WGN9BcNDXMsgZlgFAoKjptkeOY/jel6aMDBNy7Qc2R/4
         ug0xK+gnbxT1EJuPJjzHKHNDbvP5mbVZZNu+jK3XT4YpW5WJJ6Ph3OgfbDLY795sKPAn
         VUowVkeo9nUVjYOrLVh88p+J2kZNZZsDo01w5jU0+h7yZ0HGo4stofmEnop7u7SJy3GJ
         5B+/8+nWEIOFbRtYBG9XRcQEIFuOjRTU0U0DvfKP3JkwnRRTiK3pG5Nmnp/TQ5Qwk6It
         d9Hw==
X-Gm-Message-State: AOJu0Yz5DEQSClycYUTynko4SnfYq+pqf0PErBOJqBjU4B3dB5ansHmO
	RXkCJkNgm6OsM3fWUKUR9ExaGuLhhpNJUCR7IWHF6DavJ2hhHZ8QV7pfNTKdGEfWbEBYYI3+ADk
	SqYfsEsYudPzgG/r5TKjHXv3OjycJXJExLVJuxbfo3/iEvxg82L7E+urfUp4GslMY9eQHCvIemx
	Geqq9Gb3DHRvV3ViBj+X5CUQfNzQXRT/LQC97nu+68PCz3tI1bY+xtQHM=
X-Google-Smtp-Source: AGHT+IGtl/M2mX2DFxMKjU0G/SGsKcUwRPA08PYakKSf6zJpbc9gAmUuIUtlYOT263WzT4l5+3VnMXOmobBQ9w==
X-Received: from ejctl25.prod.google.com ([2002:a17:907:c319:b0:ae3:6f1c:e0e1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d23:b0:ae6:e25b:2413 with SMTP id a640c23a62f3a-afdf0201e20mr32340066b.44.1755640362537;
 Tue, 19 Aug 2025 14:52:42 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:47 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-20-smostafa@google.com>
Subject: [PATCH v4 19/28] iommu/arm-smmu-v3-kvm: Add MMIO emulation
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment most registers are just passthrough, then in the next
patches CMDQ/STE emulation will be added which inserts logic to some
register access.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 125 ++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |  10 ++
 2 files changed, 135 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index e45b4e50b1e4..32f199aeec9e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -8,6 +8,7 @@
 
 #include <nvhe/iommu.h>
 #include <nvhe/mem_protect.h>
+#include <nvhe/trap_handler.h>
 
 #include "arm_smmu_v3.h"
 #include "../arm-smmu-v3.h"
@@ -140,6 +141,8 @@ static int smmu_init(void)
 			goto out_reclaim_smmu;
 	}
 
+	BUILD_BUG_ON(sizeof(hyp_spinlock_t) != sizeof(u32));
+
 	return 0;
 
 out_reclaim_smmu:
@@ -150,6 +153,127 @@ static int smmu_init(void)
 	return ret;
 }
 
+static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
+			     struct user_pt_regs *regs,
+			     u64 esr, u32 off)
+{
+	bool is_write = esr & ESR_ELx_WNR;
+	unsigned int len = BIT((esr & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
+	int rd = (esr & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
+	const u64 read_write = -1ULL;
+	const u64 no_access = 0;
+	u64 mask = no_access;
+	const u64 read_only = is_write ? no_access : read_write;
+	u64 val = regs->regs[rd];
+
+	switch (off) {
+	case ARM_SMMU_IDR0:
+		/* Clear stage-2 support, hide MSI to avoid write back to cmdq */
+		mask = read_only & ~(IDR0_S2P | IDR0_VMID16 | IDR0_MSI | IDR0_HYP);
+		WARN_ON(len != sizeof(u32));
+		break;
+	/* Passthrough the register access for bisectiblity, handled later */
+	case ARM_SMMU_CMDQ_BASE:
+	case ARM_SMMU_CMDQ_PROD:
+	case ARM_SMMU_CMDQ_CONS:
+	case ARM_SMMU_STRTAB_BASE:
+	case ARM_SMMU_STRTAB_BASE_CFG:
+	case ARM_SMMU_GBPA:
+		mask = read_write;
+		break;
+	case ARM_SMMU_CR0:
+		mask = read_write;
+		WARN_ON(len != sizeof(u32));
+		break;
+	case ARM_SMMU_CR1: {
+		/* Based on Linux implementation */
+		u64 cr2_template = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
+				FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
+				FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
+				FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
+				FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
+				FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
+		/* Don't mess with shareability/cacheability. */
+		if (is_write)
+			WARN_ON(val != cr2_template);
+		mask = read_write;
+		WARN_ON(len != sizeof(u32));
+		break;
+	}
+	/*
+	 * These should be safe, just enforce RO or RW and size according to architecture.
+	 * There are some other registers that are not used by Linux as IDR2, IDR4
+	 * that won't be allowed.
+	 */
+	case ARM_SMMU_EVTQ_PROD + SZ_64K:
+	case ARM_SMMU_EVTQ_CONS + SZ_64K:
+	case ARM_SMMU_EVTQ_IRQ_CFG1:
+	case ARM_SMMU_EVTQ_IRQ_CFG2:
+	case ARM_SMMU_PRIQ_PROD + SZ_64K:
+	case ARM_SMMU_PRIQ_CONS + SZ_64K:
+	case ARM_SMMU_PRIQ_IRQ_CFG1:
+	case ARM_SMMU_PRIQ_IRQ_CFG2:
+	case ARM_SMMU_GERRORN:
+	case ARM_SMMU_GERROR_IRQ_CFG1:
+	case ARM_SMMU_GERROR_IRQ_CFG2:
+	case ARM_SMMU_IRQ_CTRLACK:
+	case ARM_SMMU_IRQ_CTRL:
+	case ARM_SMMU_CR0ACK:
+	case ARM_SMMU_CR2:
+		/* These are 32 bit registers. */
+		WARN_ON(len != sizeof(u32));
+		fallthrough;
+	case ARM_SMMU_EVTQ_BASE:
+	case ARM_SMMU_EVTQ_IRQ_CFG0:
+	case ARM_SMMU_PRIQ_BASE:
+	case ARM_SMMU_PRIQ_IRQ_CFG0:
+	case ARM_SMMU_GERROR_IRQ_CFG0:
+		mask = read_write;
+		break;
+	case ARM_SMMU_IIDR:
+	case ARM_SMMU_IDR5:
+	case ARM_SMMU_IDR3:
+	case ARM_SMMU_IDR1:
+	case ARM_SMMU_GERROR:
+		WARN_ON(len != sizeof(u32));
+		mask = read_only;
+	};
+
+	if (WARN_ON(!mask))
+		goto out_ret;
+
+	if (is_write) {
+		if (len == sizeof(u64))
+			writeq_relaxed(regs->regs[rd] & mask, smmu->base + off);
+		else
+			writel_relaxed(regs->regs[rd] & mask, smmu->base + off);
+	} else {
+		if (len == sizeof(u64))
+			regs->regs[rd] = readq_relaxed(smmu->base + off) & mask;
+		else
+			regs->regs[rd] = readl_relaxed(smmu->base + off) & mask;
+	}
+
+out_ret:
+	return true;
+}
+
+static bool smmu_dabt_handler(struct user_pt_regs *regs, u64 esr, u64 addr)
+{
+	struct hyp_arm_smmu_v3_device *smmu;
+	bool ret;
+
+	for_each_smmu(smmu) {
+		if (addr < smmu->mmio_addr || addr >= smmu->mmio_addr + smmu->mmio_size)
+			continue;
+		hyp_spin_lock(&smmu->lock);
+		ret = smmu_dabt_device(smmu, regs, esr, addr - smmu->mmio_addr);
+		hyp_spin_unlock(&smmu->lock);
+		return ret;
+	}
+	return false;
+}
+
 static void smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
 {
 }
@@ -158,4 +282,5 @@ static void smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
 	.host_stage2_idmap		= smmu_host_stage2_idmap,
+	.dabt_handler			= smmu_dabt_handler,
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index 3550fa695539..dfeaed728982 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -4,6 +4,10 @@
 
 #include <asm/kvm_asm.h>
 
+#ifdef __KVM_NVHE_HYPERVISOR__
+#include <nvhe/spinlock.h>
+#endif
+
 /*
  * Parameters from the trusted host:
  * @mmio_addr		base address of the SMMU registers
@@ -16,6 +20,7 @@
  * @oas			PA size
  * @pgsize_bitmap	Supported page sizes
  * @sid_bits		Max number of SID bits supported
+ * @lock		Lock to protect SMMU
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
@@ -26,6 +31,11 @@ struct hyp_arm_smmu_v3_device {
 	unsigned long		oas;
 	unsigned long		pgsize_bitmap;
 	unsigned int		sid_bits;
+#ifdef __KVM_NVHE_HYPERVISOR__
+	hyp_spinlock_t		lock;
+#else
+	u32			lock;
+#endif
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.51.0.rc1.167.g924127e9c0-goog


