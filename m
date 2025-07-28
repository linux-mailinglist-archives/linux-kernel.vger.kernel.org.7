Return-Path: <linux-kernel+bounces-748468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B2B1418A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147394E0C26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D840287264;
	Mon, 28 Jul 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6LlI4dJ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358D28467D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725234; cv=none; b=sd5RRAhmd4YYDujCla+8nD40IQxBKAlFIC1KQ+F7z2AIKeGxQ0ClkD6Z52UcMqio5mPKcuSBwOaggYmL69oYibxTragJ15DKUzgue6tlbgxcTQrE0uj0tg7joDuiObnjQn3Pd3FX/cnIbrQvRC5fMfZetu3N4K7XEVotn75fLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725234; c=relaxed/simple;
	bh=iUAPvh90F7xw1smx2NYZbBpxRCpRJZPB/00pjmytjgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KlTmvRpQlgzjp/+Apf9MNvOeBkdeMMY6hLJ5abhtFD7RVdDG+qyeYt4vzvFMBeBca2vWoJjLKj6oqgjsOBCI9Dv1/rLhwO9rIysZWUpnvnEjQZh/6AyQ7P9cmfTFewpniMANhobDAg5aKi/aA+K54KWIX0ujbh2l4B38b/3AqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6LlI4dJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45526e19f43so14072215e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725229; x=1754330029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMj7CyXERBbRhhok3Kl0AYfjJc+Eliaw2DG7Dg7hsI4=;
        b=j6LlI4dJ3rwkFH8eb7BSkkmru8MgSJ+KsdmaUitVCxkT5SGjcCoqpM5uxIDd6SdNLR
         lruC3LvRQNiaxzlFW0wzqSsMXS76lgDdoeOmUe2xdeaSz/e+Vff8rI0/FCF52op6vnI0
         fdPzAoOzs26WG712zPPpjVHRx1yAoHZJC6ayaz9C6sg5FKwzmjptNiVDJtSpHUJaenIr
         sPGDp9mOGntipmwM+El3eoT5HA7IxjKeNqQX3L5m5XZBMTp0O8nojhAM3qN7HgOCNwf+
         sK07oukHnqkTpzIUYZ7u1FfuDmFJPS0WjyGGndzt5ysZqtGQCE/QcxUndqz51SFhjb6B
         ciaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725229; x=1754330029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMj7CyXERBbRhhok3Kl0AYfjJc+Eliaw2DG7Dg7hsI4=;
        b=FCPwULZDNJPlg++nEzZHOToS907HPmrBNm2UmHZ845Vd3yzjo1ZmHjdCs37g/FbMpz
         RDGgjAnTZa5K4SzSiIMHjaeiWZBavMtIv4k9Xgt8cJ/sCDY/oKcF0z/iaQqPMQhzGMMD
         jPGl5vrtgAVm+Bc/R817nkqi8PBxf2sYXk/tETHe6PpbKIEiL89+qZSm64Cl5HyBsm3X
         QX5tlLetCtiOP2lOc833L2m1nXQJZ11JTXHHju7UnAvI4UqIcIIPgWtH16aqV0rtLc8t
         +T1Cwg6cBpB/D0XbDvCq7vrqPh4oDGAwHmwRnl3p9eCFWITFPpgQmZyVFybYp71UrOtA
         LwQg==
X-Gm-Message-State: AOJu0YyQqVoFdHlkoOGCXgxv1+iT6k0XZLBsBTw7Y8xzueZEUsAusRKK
	QH9sFp8AkUtEI2l4r7SI0b9SR0a49aQ6NvwNzT5ffgJ363LYdVDAAr7z0n539jpF4KUGRfevFvG
	f2ET8fL78WDstwUhuznJ7StEYONfBDBBKG95wo6CUePMoXIrMMz5AgHTHu7+LvqOyRo4CL9Th8O
	U3dYwrJXiKW3nf9DcGdwt+x0zIHJ0EsQd2Nek5uvrVAmIs5w/rKN0cnNc=
X-Google-Smtp-Source: AGHT+IHGBEMNWMKylKuu/FAAD8mciBjhdEaRLqrqR0Cf/8KRjBl1KjBNnc9kjb20/qxDpGrYsboTcaiSOpQbJA==
X-Received: from wmbdv17.prod.google.com ([2002:a05:600c:6211:b0:442:ea0c:c453])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1992:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-45876554f82mr88636195e9.23.1753725229065;
 Mon, 28 Jul 2025 10:53:49 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:06 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-20-smostafa@google.com>
Subject: [PATCH v3 19/29] iommu/arm-smmu-v3-kvm: Initialize registers
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Ensure all writable registers are properly initialized. We do not touch
registers that will not be read by the SMMU due to disabled features.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 149 +++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |  12 ++
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 2f43804e08e0..e9bc35e019b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -7,15 +7,162 @@
 #include <asm/kvm_hyp.h>
 
 #include <nvhe/iommu.h>
+#include <nvhe/mem_protect.h>
 
 #include "arm_smmu_v3.h"
 
+#define ARM_SMMU_POLL_TIMEOUT_US	100000 /* 100ms arbitrary timeout */
+
 size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
 struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 
+#define for_each_smmu(smmu) \
+	for ((smmu) = kvm_hyp_arm_smmu_v3_smmus; \
+	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
+	     (smmu)++)
+
+/*
+ * Wait until @cond is true.
+ * Return 0 on success, or -ETIMEDOUT
+ */
+#define smmu_wait(_cond)					\
+({								\
+	int __ret = 0;						\
+	u64 delay = pkvm_time_get() + ARM_SMMU_POLL_TIMEOUT_US;	\
+								\
+	while (!(_cond)) {					\
+		if (pkvm_time_get() >= delay) {			\
+			__ret = -ETIMEDOUT;			\
+			break;					\
+		}						\
+	}							\
+	__ret;							\
+})
+
+static int smmu_write_cr0(struct hyp_arm_smmu_v3_device *smmu, u32 val)
+{
+	writel_relaxed(val, smmu->base + ARM_SMMU_CR0);
+	return smmu_wait(readl_relaxed(smmu->base + ARM_SMMU_CR0ACK) == val);
+}
+
+/* Transfer ownership of structures from host to hyp */
+static int smmu_take_pages(u64 phys, size_t size)
+{
+	WARN_ON(!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size));
+	return __pkvm_host_donate_hyp(phys >> PAGE_SHIFT, size >> PAGE_SHIFT);
+}
+
+static void smmu_reclaim_pages(u64 phys, size_t size)
+{
+	WARN_ON(!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size));
+	WARN_ON(__pkvm_hyp_donate_host(phys >> PAGE_SHIFT, size >> PAGE_SHIFT));
+}
+
+static int smmu_init_registers(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u64 val, old;
+	int ret;
+
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_GBPA) & GBPA_ABORT))
+		return -EINVAL;
+
+	/* Initialize all RW registers that will be read by the SMMU */
+	ret = smmu_write_cr0(smmu, 0);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
+	      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
+	      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
+	      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
+	      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
+	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
+	writel_relaxed(val, smmu->base + ARM_SMMU_CR1);
+	writel_relaxed(CR2_PTM, smmu->base + ARM_SMMU_CR2);
+	writel_relaxed(0, smmu->base + ARM_SMMU_IRQ_CTRL);
+
+	val = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	old = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	/* Service Failure Mode is fatal */
+	if ((val ^ old) & GERROR_SFM_ERR)
+		return -EIO;
+	/* Clear pending errors */
+	writel_relaxed(val, smmu->base + ARM_SMMU_GERRORN);
+
+	return 0;
+}
+
+/* Put the device in a state that can be probed by the host driver. */
+static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int i;
+	size_t nr_pages = smmu->mmio_size >> PAGE_SHIFT;
+
+	for (i = 0 ; i < nr_pages ; ++i) {
+		u64 pfn = (smmu->mmio_addr >> PAGE_SHIFT) + i;
+
+		WARN_ON(__pkvm_hyp_donate_host_mmio(pfn));
+	}
+}
+
+static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int i;
+	size_t nr_pages;
+	int ret;
+
+	if (!PAGE_ALIGNED(smmu->mmio_addr | smmu->mmio_size))
+		return -EINVAL;
+
+	nr_pages = smmu->mmio_size >> PAGE_SHIFT;
+	for (i = 0 ; i < nr_pages ; ++i) {
+		u64 pfn = (smmu->mmio_addr >> PAGE_SHIFT) + i;
+
+		/*
+		 * This should never happen, so it's fine to be strict to avoid
+		 * complicated error handling.
+		 */
+		WARN_ON(__pkvm_host_donate_hyp_mmio(pfn));
+	}
+	smmu->base = hyp_phys_to_virt(smmu->mmio_addr);
+
+	ret = smmu_init_registers(smmu);
+	if (ret)
+		goto out_err;
+	return ret;
+
+out_err:
+	smmu_deinit_device(smmu);
+	return ret;
+}
+
 static int smmu_init(void)
 {
-	return -ENOSYS;
+	int ret;
+	struct hyp_arm_smmu_v3_device *smmu;
+	size_t smmu_arr_size = PAGE_ALIGN(sizeof(*kvm_hyp_arm_smmu_v3_smmus) *
+					  kvm_hyp_arm_smmu_v3_count);
+	phys_addr_t smmu_arr_phys;
+
+	kvm_hyp_arm_smmu_v3_smmus = kern_hyp_va(kvm_hyp_arm_smmu_v3_smmus);
+	smmu_arr_phys = hyp_virt_to_phys(kvm_hyp_arm_smmu_v3_smmus);
+
+	ret = smmu_take_pages(smmu_arr_phys, smmu_arr_size);
+	if (ret)
+		return ret;
+
+	for_each_smmu(smmu) {
+		ret = smmu_init_device(smmu);
+		if (ret)
+			goto out_reclaim_smmu;
+	}
+
+	return 0;
+out_reclaim_smmu:
+	while (smmu != kvm_hyp_arm_smmu_v3_smmus)
+		smmu_deinit_device(--smmu);
+	smmu_reclaim_pages(smmu_arr_phys, smmu_arr_size);
+	return ret;
 }
 
 /* Shared with the kernel driver in EL1 */
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index f6ad91d3fb85..9b1d021ada63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -4,7 +4,19 @@
 
 #include <asm/kvm_asm.h>
 
+#include "../arm-smmu-v3-common.h"
+
+/*
+ * Parameters from the trusted host:
+ * @mmio_addr		base address of the SMMU registers
+ * @mmio_size		size of the registers resource
+ * @base		Virtual address of SMMU registers
+ * Other members are filled and used at runtime by the SMMU driver.
+ */
 struct hyp_arm_smmu_v3_device {
+	phys_addr_t		mmio_addr;
+	size_t			mmio_size;
+	void __iomem		*base;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.50.1.552.g942d659e1b-goog


