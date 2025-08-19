Return-Path: <linux-kernel+bounces-776559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB35B2CECB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C489A2A7F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44B341660;
	Tue, 19 Aug 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgBuaSPW"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E48334369
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640367; cv=none; b=Zh9YPn55UzAIWmKzB13F5PC+HpuczwNQ0rAasO6lZl8mDobBbQpWOCTBDHCPpDRq+soxuNUkJUxRmzpVopzZ5qaT751gZ7hfHraHFacCQUD0AfoGQskVTBfoYg0bAQtkygN/PbPAmBr8zBWczCKAKksE3SWtiqLtZNRuOyj9WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640367; c=relaxed/simple;
	bh=IDQoEPFCey8Q5YZAxs3yoAHr98Lqnt32fDIqn3IVCCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liaCt7KegIdJVVDVNaPLTYCrkw60kxuR22EqgKCGQITMVNYLRYvO7MeCE8NjTf9ZxGbZYzSVRnz0ZkKeXptDZTrcelRYTm6vntLR+k8XrGcE2r9bLjyNxDZNyte5vrpp3tF77AToS9ynDt0MzYw7kzUW8vjRGZjIrurkBgz+fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgBuaSPW; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9edf41d07so3952815f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640363; x=1756245163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/fU42/CqOBV85U7agBN+amVl2Ghkx92fsFwG9kBi+E=;
        b=OgBuaSPWeCdAQbskQwcdb4ua2l9NnFxAZEN25o9AlqlYofR01AZiTTVJYY4GvvmhM2
         9qRkakJjqglD97qPaj6I+uof7QRvSxkTpjceV0cCZzKM7jzxCgUAwCLhnbMUgtldMha9
         LdRDwsRAv8HPPi05OzQvo1b8W8hCLR6BB7p535v+2SRToAkYAYTcbYzmm/1xtJvtdHD+
         c9KTpNbNxs+31pfQnbgopwC6cka78cgO1gqYeqTynaHJJKJRa+NCsckZna42uHRrqR+M
         yu6yu1f2e/5v5EpUQXNWMoROkVdED2e4/jKaYag7SYZ6h8kjFFhWX1o4TMeZvR7NuH3U
         P1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640363; x=1756245163;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4/fU42/CqOBV85U7agBN+amVl2Ghkx92fsFwG9kBi+E=;
        b=WpC0qC1vJQH4uBhoR50Zdu8dwoyza6/Vy14cLvA9lgZFlzyN4BG2ls0gJFl4FDuPUy
         BdpePCd9qf9VLri880/o8SO/EmzpW5Csne7lCmWwSctfK0TsPCEHKRFqlHzbL0ek/P6J
         ykvSJZP7FA3DsEiB5qF5QLEj0pcDPjPXtkAWuLRru8UJt/1EMW0kOfkCnNhtDreiKLMX
         WCpDn19pOrh7hF//xhEJ2N0sLfgf6Bw68MUm7ALMQdnr4wvlhKUu5m4WMNhVN03tQiCU
         qWxft80dYsG8SfIZCi6IwDqXOeGeGg4nZhki93Mx76yf8TiBWGpjxFnRkMRfun/0T2uB
         5Qgw==
X-Gm-Message-State: AOJu0Yw1m2MbhHlaYdS/30f1m0XyoFaassbwOaCFQ0/EF3CNrjwZe6pV
	coKfVKuer6tiNOezwoh1VZNmC/UXEeMTErnSQFjULoMNJzVsOJy/0PVyML5U0pHAHxw1XPRm759
	yRO789zMSnPwkElOh7P6Bw24Ix49VJ9PQCb1TULIsPYi366BPrEO72eR1kJYUzs7eSIccFDrH3/
	rYnDGxQBH5o0dRN+33znX0BAFVsDDIms5HOmawVGJJstFBAAJe/+IM+zg=
X-Google-Smtp-Source: AGHT+IHPR2TOMegxsTQof55IYyVi+Xg9i8ImL2L9AnGlc4nKnoOPBojWzhoAgagvHESAt69mQX/N31I7JbKjMQ==
X-Received: from wmbeb11.prod.google.com ([2002:a05:600c:678b:b0:459:e068:b510])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64e7:0:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3c32eeb80e4mr358475f8f.59.1755640363546;
 Tue, 19 Aug 2025 14:52:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:48 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-21-smostafa@google.com>
Subject: [PATCH v4 20/28] iommu/arm-smmu-v3-kvm: Shadow the command queue
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

At boot allocate a command queue per SMMU which is used as a shadow
by the hypervisor.

The command queue size is 64K which is more than enough, as the
hypervisor would consume all the entries per a command queue prod
write, which means it can handle up to 4096 at a time.

Then, the host command queue needs to be pinned in a shared state, so
it can't be donated to VMs, and avoid tricking the hypervisor into
accessing them. This is done each time the command queue is enabled,
and undone each time the command queue is disabled.
The hypervisor won=E2=80=99t access the host command queue when it is disab=
led
from the host.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   |  20 ++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 108 +++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |   8 ++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 27ea39c0fb1f..86e6c68aad4e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -13,6 +13,8 @@
 #include "arm-smmu-v3.h"
 #include "pkvm/arm_smmu_v3.h"
=20
+#define SMMU_KVM_CMDQ_ORDER				4
+
 extern struct kvm_iommu_ops kvm_nvhe_sym(smmu_ops);
=20
 static size_t				kvm_arm_smmu_count;
@@ -58,6 +60,7 @@ static int kvm_arm_smmu_array_alloc(void)
 	/* Basic device tree parsing. */
 	for_each_compatible_node(np, NULL, "arm,smmu-v3") {
 		struct resource res;
+		void *cmdq_base;
=20
 		ret =3D of_address_to_resource(np, 0, &res);
 		if (ret)
@@ -74,6 +77,23 @@ static int kvm_arm_smmu_array_alloc(void)
 		if (of_dma_is_coherent(np))
 			kvm_arm_smmu_array[i].features |=3D ARM_SMMU_FEAT_COHERENCY;
=20
+		/*
+		 * Allocate shadow for the command queue, it doesn't have to be the same
+		 * size as the host.
+		 * Only populate base_dma and llq.max_n_shift, the hypervisor will init
+		 * the rest.
+		 * We don't what size the host will choose at this point, the shadow cop=
y
+		 * will 64K which is a reasonable size.
+		 */
+		cmdq_base =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, SMMU_KVM=
_CMDQ_ORDER);
+		if (!cmdq_base) {
+			ret =3D -ENOMEM;
+			goto out_err;
+		}
+
+		kvm_arm_smmu_array[i].cmdq.base_dma =3D virt_to_phys(cmdq_base);
+		kvm_arm_smmu_array[i].cmdq.llq.max_n_shift =3D SMMU_KVM_CMDQ_ORDER + PAG=
E_SHIFT -
+							     CMDQ_ENT_SZ_SHIFT;
 		i++;
 	}
=20
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 32f199aeec9e..d3ab4b814be4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -11,7 +11,6 @@
 #include <nvhe/trap_handler.h>
=20
 #include "arm_smmu_v3.h"
-#include "../arm-smmu-v3.h"
=20
 size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
 struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
@@ -34,6 +33,35 @@ static void smmu_reclaim_pages(u64 phys, size_t size)
 	WARN_ON(__pkvm_hyp_donate_host(phys >> PAGE_SHIFT, size >> PAGE_SHIFT));
 }
=20
+/*
+ * CMDQ, STE host copies are accessed by the hypervisor, we share them to
+ * - Prevent the host from passing protected VM memory.
+ * - Having them mapped in the hyp page table.
+ */
+static int smmu_share_pages(phys_addr_t addr, size_t size)
+{
+	int i;
+	size_t nr_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	for (i =3D 0 ; i < nr_pages ; ++i)
+		WARN_ON(__pkvm_host_share_hyp((addr + i * PAGE_SIZE) >> PAGE_SHIFT));
+
+	return hyp_pin_shared_mem(hyp_phys_to_virt(addr), hyp_phys_to_virt(addr +=
 size));
+}
+
+static int smmu_unshare_pages(phys_addr_t addr, size_t size)
+{
+	int i;
+	size_t nr_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	hyp_unpin_shared_mem(hyp_phys_to_virt(addr), hyp_phys_to_virt(addr + size=
));
+
+	for (i =3D 0 ; i < nr_pages ; ++i)
+		WARN_ON(__pkvm_host_unshare_hyp((addr + i * PAGE_SIZE) >> PAGE_SHIFT));
+
+	return 0;
+}
+
 /* Put the device in a state that can be probed by the host driver. */
 static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
 {
@@ -94,6 +122,41 @@ static int smmu_probe(struct hyp_arm_smmu_v3_device *sm=
mu)
 	return 0;
 }
=20
+/*
+ * The kernel part of the driver will allocate the shadow cmdq,
+ * which is different from the one used by the driver.
+ * This function only donates it.
+ */
+static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
+{
+	size_t cmdq_size;
+	int ret;
+	enum kvm_pgtable_prot prot =3D PAGE_HYP;
+
+	cmdq_size =3D (1 << (smmu->cmdq.llq.max_n_shift)) *
+		     CMDQ_ENT_DWORDS * 8;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		prot |=3D KVM_PGTABLE_PROT_NORMAL_NC;
+
+	ret =3D ___pkvm_host_donate_hyp(smmu->cmdq.base_dma >> PAGE_SHIFT,
+				      PAGE_ALIGN(cmdq_size) >> PAGE_SHIFT, prot);
+	if (ret)
+		return ret;
+
+	smmu->cmdq.base =3D hyp_phys_to_virt(smmu->cmdq.base_dma);
+	smmu->cmdq.prod_reg =3D smmu->base + ARM_SMMU_CMDQ_PROD;
+	smmu->cmdq.cons_reg =3D smmu->base + ARM_SMMU_CMDQ_CONS;
+	smmu->cmdq.q_base =3D smmu->cmdq.base_dma |
+			    FIELD_PREP(Q_BASE_LOG2SIZE, smmu->cmdq.llq.max_n_shift);
+	smmu->cmdq.ent_dwords =3D CMDQ_ENT_DWORDS;
+	memset(smmu->cmdq.base, 0, cmdq_size);
+	writel_relaxed(0, smmu->cmdq.prod_reg);
+	writel_relaxed(0, smmu->cmdq.cons_reg);
+	writeq_relaxed(smmu->cmdq.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
+	return 0;
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int i, ret;
@@ -116,7 +179,13 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_dev=
ice *smmu)
 	ret =3D smmu_probe(smmu);
 	if (ret)
 		goto out_ret;
+
+	ret =3D smmu_init_cmdq(smmu);
+	if (ret)
+		goto out_ret;
+
 	return 0;
+
 out_ret:
 	smmu_deinit_device(smmu);
 	return ret;
@@ -153,6 +222,27 @@ static int smmu_init(void)
 	return ret;
 }
=20
+static bool is_cmdq_enabled(struct hyp_arm_smmu_v3_device *smmu)
+{
+	return FIELD_GET(CR0_CMDQEN, smmu->cr0);
+}
+
+static void smmu_emulate_cmdq_enable(struct hyp_arm_smmu_v3_device *smmu)
+{
+	size_t cmdq_size;
+
+	smmu->cmdq_host.llq.max_n_shift =3D smmu->cmdq_host.q_base & Q_BASE_LOG2S=
IZE;
+	cmdq_size =3D (1 << smmu->cmdq_host.llq.max_n_shift) * CMDQ_ENT_DWORDS * =
8;
+	WARN_ON(smmu_share_pages(smmu->cmdq_host.q_base & Q_BASE_ADDR_MASK, cmdq_=
size));
+}
+
+static void smmu_emulate_cmdq_disable(struct hyp_arm_smmu_v3_device *smmu)
+{
+	size_t cmdq_size =3D cmdq_size =3D (1 << smmu->cmdq_host.llq.max_n_shift)=
 * CMDQ_ENT_DWORDS * 8;
+
+	WARN_ON(smmu_unshare_pages(smmu->cmdq_host.q_base & Q_BASE_ADDR_MASK, cmd=
q_size));
+}
+
 static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 			     struct user_pt_regs *regs,
 			     u64 esr, u32 off)
@@ -174,6 +264,13 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_de=
vice *smmu,
 		break;
 	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_CMDQ_BASE:
+
+		/* Not allowed by the architecture */
+		WARN_ON(is_cmdq_enabled(smmu));
+		if (is_write)
+			smmu->cmdq_host.q_base =3D val;
+		mask =3D read_write;
+		break;
 	case ARM_SMMU_CMDQ_PROD:
 	case ARM_SMMU_CMDQ_CONS:
 	case ARM_SMMU_STRTAB_BASE:
@@ -182,6 +279,15 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_de=
vice *smmu,
 		mask =3D read_write;
 		break;
 	case ARM_SMMU_CR0:
+		if (is_write) {
+			bool last_cmdq_en =3D is_cmdq_enabled(smmu);
+
+			smmu->cr0 =3D val;
+			if (!last_cmdq_en && is_cmdq_enabled(smmu))
+				smmu_emulate_cmdq_enable(smmu);
+			else if (last_cmdq_en && !is_cmdq_enabled(smmu))
+				smmu_emulate_cmdq_disable(smmu);
+		}
 		mask =3D read_write;
 		WARN_ON(len !=3D sizeof(u32));
 		break;
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index dfeaed728982..330da53f80d0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -8,6 +8,8 @@
 #include <nvhe/spinlock.h>
 #endif
=20
+#include "../arm-smmu-v3.h"
+
 /*
  * Parameters from the trusted host:
  * @mmio_addr		base address of the SMMU registers
@@ -21,6 +23,9 @@
  * @pgsize_bitmap	Supported page sizes
  * @sid_bits		Max number of SID bits supported
  * @lock		Lock to protect SMMU
+ * @cmdq		CMDQ as observed by HW
+ * @cmdq_host		Host view of the command queue
+ * @cr0			Last value of CR0
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
@@ -36,6 +41,9 @@ struct hyp_arm_smmu_v3_device {
 #else
 	u32			lock;
 #endif
+	struct arm_smmu_queue	cmdq;
+	struct arm_smmu_queue	cmdq_host;
+	u32			cr0;
 };
=20
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
--=20
2.51.0.rc1.167.g924127e9c0-goog


