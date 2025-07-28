Return-Path: <linux-kernel+bounces-748476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA2B14190
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4443AB5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C014288CBD;
	Mon, 28 Jul 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vhi8ueIe"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F85285C83
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725241; cv=none; b=qoZlnmaBAE0eWY31QpYbphnYiP8seCvp1r/t+6+3dotB4HI8yVo7/tY8DaOgJBDVORohPQzicwhJrZErh0wAZbLnX+2yg09CAkxyYquBNyN3DamrKrK/wcjsMB2re24A5oZ4og3AsCmr7bHZMPJkC8cCOAWAm9d02uSOeIFiUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725241; c=relaxed/simple;
	bh=dZuFm4aYvdFluJX9FNUAGiiXkF8S/lCBo9ayHFv2W9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C989rjVXt09h5NJzc6gM25ZA9xafwwUu5lc5cNVYoxQRR/FrPjAbb2KM1CuTT1GM0dTGW+Akif2sJLOXybQYtkOVjjhTyYNM3XttZHXSl78AcKLmOhYfvzH4558YWWnZ8iOJDvD3mYEWnMB5NfKYzDZfBkec0Qj1C4MLPws4Mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vhi8ueIe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so22265785e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725236; x=1754330036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4x+9nZ8CfG6VcovabsfC73bcsU1B/P8cpgFWvcyCzc=;
        b=Vhi8ueIexr6wW74InmOseVGlguR29uI3ly94yt4p3vbwrqRRbkugbJ/67Csr5mPl2r
         9kjH6/rg20X97SJILKP1mThMQPk8KzOOify1NGaseV781687wWBbtxbf4JEtdF38HMs4
         RGjtFqgVCy8sWmGArsr6+eODgn7+/bsbakporhSzLw/Ad7HRBegyouWHGP/loBABGE0Z
         JlWVdABnfD8jw/4P4g200bq/Ek9K4gftm80pka451X8vTvrjp9PdCzqbPfqQXG7kf8Rf
         Oa0GUyJ7oHlkpEXg1QNhOZZQWtdLE4Vw8VaAiKF26fUolB/pG63OCLCQab9wkZOdwV2r
         ot8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725236; x=1754330036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4x+9nZ8CfG6VcovabsfC73bcsU1B/P8cpgFWvcyCzc=;
        b=hevyvEn7dbtfPv1AXJj5rzEoRyaG9VqXrWh8Ti3RNnWTrd1PKjLydQs9lBy4JwOYUL
         H2q2c5jTbYTAcVZ+7wtdn7INgEB+RtHyYYGwYgiVc/R0KeMb0fYLSndxRH+PavMpFI0N
         NHTG4XTU5H/jG6NRc/+Os0vy3sUnKYWslKrLfd7UB4vv8xBDu9r8qO6grGjsKE5UAVGd
         Ovy21GKnzGSvbH0AJ8LIk8dU3ZnOAwxAT8jeS0tQpaASk+jY26JYOq+luNiHYEHJrBGE
         d5f9fTalNOXqhTu8DRu81Z6ClJclc8glVUbeINB5Efsjic9OfXGvu2pSYpTCXQPAzDRF
         ZDJA==
X-Gm-Message-State: AOJu0YxQs8pFJzSyIZmXLi8AtcIKnnyAt9YfkXxEBplWLXnISCAE5d49
	MxvkfBmjvyd6t6UfN0RpNd6VBnEs2c1Z2Xi7ohAVL/ZeE0K/bZ1+i703KLfSIg4R0FHo/o8rI1j
	2Y73ExR4goTQC10K9SbawfmSKATUaaTtlvscr2Q0+3w3EN/ntVeANhKWKzYia5LkrWwWnhqvZBU
	qYbJXtTGQbAezqAuWicWPpNqMbD1t6InxYAElJjWyPjbZfA505J8FN/q0=
X-Google-Smtp-Source: AGHT+IEBJ4FZzMDcwCGDKN8xa1GdqdMhp4/1Mi4gQZ55PlpVVoMDB120scDJ9kcLF/kTOLPAggxTyBmxwWLxVQ==
X-Received: from wmbgw7.prod.google.com ([2002:a05:600c:8507:b0:456:293d:55c5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138c:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-458852502eamr42122365e9.33.1753725235777;
 Mon, 28 Jul 2025 10:53:55 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:14 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-28-smostafa@google.com>
Subject: [PATCH v3 27/29] iommu/arm-smmu-v3-kvm: Pass a list of SMMU devices
 to the hypervisor
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

Build a list of devices and donate the page to the hypervisor. At this
point the host is trusted and this would be a good opportunity to
provide more information about the system.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 182 +++++++++++++++++-
 1 file changed, 179 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 73c0150bdc81..2fa56ddfbdab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -13,9 +13,119 @@
 
 extern struct kvm_iommu_ops kvm_nvhe_sym(smmu_ops);
 
+struct host_arm_smmu_device {
+	struct arm_smmu_device		smmu;
+	pkvm_handle_t			id;
+};
+
+#define smmu_to_host(_smmu) \
+	container_of(_smmu, struct host_arm_smmu_device, smmu);
+
+static size_t				kvm_arm_smmu_cur;
+static size_t				kvm_arm_smmu_count;
+static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
+
+static bool kvm_arm_smmu_validate_features(struct arm_smmu_device *smmu)
+{
+	unsigned int required_features =
+		ARM_SMMU_FEAT_TT_LE |
+		ARM_SMMU_FEAT_TRANS_S2;
+	unsigned int forbidden_features =
+		ARM_SMMU_FEAT_STALL_FORCE;
+	unsigned int keep_features =
+		ARM_SMMU_FEAT_2_LVL_STRTAB	|
+		ARM_SMMU_FEAT_2_LVL_CDTAB	|
+		ARM_SMMU_FEAT_TT_LE		|
+		ARM_SMMU_FEAT_SEV		|
+		ARM_SMMU_FEAT_COHERENCY		|
+		ARM_SMMU_FEAT_TRANS_S1		|
+		ARM_SMMU_FEAT_TRANS_S2		|
+		ARM_SMMU_FEAT_VAX		|
+		ARM_SMMU_FEAT_RANGE_INV;
+
+	if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY) {
+		dev_err(smmu->dev, "unsupported layout\n");
+		return false;
+	}
+
+	if ((smmu->features & required_features) != required_features) {
+		dev_err(smmu->dev, "missing features 0x%x\n",
+			required_features & ~smmu->features);
+		return false;
+	}
+
+	if (smmu->features & forbidden_features) {
+		dev_err(smmu->dev, "features 0x%x forbidden\n",
+			smmu->features & forbidden_features);
+		return false;
+	}
+
+	smmu->features &= keep_features;
+
+	return true;
+}
+
 static int kvm_arm_smmu_probe(struct platform_device *pdev)
 {
-	return -ENOSYS;
+	int ret;
+	size_t size;
+	phys_addr_t ioaddr;
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	struct host_arm_smmu_device *host_smmu;
+	struct hyp_arm_smmu_v3_device *hyp_smmu;
+
+	if (kvm_arm_smmu_cur >= kvm_arm_smmu_count)
+		return -ENOSPC;
+
+	hyp_smmu = &kvm_arm_smmu_array[kvm_arm_smmu_cur];
+
+	host_smmu = devm_kzalloc(dev, sizeof(*host_smmu), GFP_KERNEL);
+	if (!host_smmu)
+		return -ENOMEM;
+
+	smmu = &host_smmu->smmu;
+	smmu->dev = dev;
+
+	ret = arm_smmu_fw_probe(pdev, smmu);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	size = resource_size(res);
+	if (size < SZ_128K) {
+		dev_err(dev, "unsupported MMIO region size (%pr)\n", res);
+		return -EINVAL;
+	}
+	ioaddr = res->start;
+	host_smmu->id = kvm_arm_smmu_cur;
+
+	smmu->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(smmu->base))
+		return PTR_ERR(smmu->base);
+
+	ret = arm_smmu_device_hw_probe(smmu);
+	if (ret)
+		return ret;
+
+	if (!kvm_arm_smmu_validate_features(smmu))
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, smmu);
+
+	/* Hypervisor parameters */
+	hyp_smmu->cmdq = smmu->cmdq.q;
+	hyp_smmu->strtab_cfg = smmu->strtab_cfg;
+	hyp_smmu->pgsize_bitmap = smmu->pgsize_bitmap;
+	hyp_smmu->oas = smmu->oas;
+	hyp_smmu->ias = smmu->ias;
+	hyp_smmu->mmio_addr = ioaddr;
+	hyp_smmu->mmio_size = size;
+	hyp_smmu->features = smmu->features;
+	kvm_arm_smmu_cur++;
+
+	return 0;
 }
 
 static void kvm_arm_smmu_remove(struct platform_device *pdev)
@@ -35,9 +145,62 @@ static struct platform_driver kvm_arm_smmu_driver = {
 	.remove = kvm_arm_smmu_remove,
 };
 
+static int kvm_arm_smmu_array_alloc(void)
+{
+	int smmu_order;
+	struct device_node *np;
+
+	kvm_arm_smmu_count = 0;
+	for_each_compatible_node(np, NULL, "arm,smmu-v3")
+		kvm_arm_smmu_count++;
+
+	if (!kvm_arm_smmu_count)
+		return 0;
+
+	/* Allocate the parameter list shared with the hypervisor */
+	smmu_order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
+	kvm_arm_smmu_array = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						      smmu_order);
+	if (!kvm_arm_smmu_array)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void kvm_arm_smmu_array_free(void)
+{
+	int order;
+
+	order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
+	free_pages((unsigned long)kvm_arm_smmu_array, order);
+}
+
 static int kvm_arm_smmu_v3_init_drv(void)
 {
-	return platform_driver_probe(&kvm_arm_smmu_driver, kvm_arm_smmu_probe);
+	int ret;
+
+	ret = platform_driver_probe(&kvm_arm_smmu_driver, kvm_arm_smmu_probe);
+	if (ret)
+		goto err_free;
+
+	if (kvm_arm_smmu_cur != kvm_arm_smmu_count) {
+		/* A device exists but failed to probe */
+		ret = -EUNATCH;
+		goto err_free;
+	}
+
+	/*
+	 * These variables are stored in the nVHE image, and won't be accessible
+	 * after KVM initialization. Ownership of kvm_arm_smmu_array will be
+	 * transferred to the hypervisor as well.
+	 */
+	kvm_hyp_arm_smmu_v3_smmus = kvm_arm_smmu_array;
+	kvm_hyp_arm_smmu_v3_count = kvm_arm_smmu_count;
+	return 0;
+
+err_free:
+	kvm_arm_smmu_array_free();
+	return ret;
 }
 
 static void kvm_arm_smmu_v3_remove_drv(void)
@@ -52,11 +215,24 @@ struct kvm_iommu_driver kvm_smmu_v3_ops = {
 
 static int kvm_arm_smmu_v3_register(void)
 {
+	int ret;
+
 	if (!is_protected_kvm_enabled())
 		return 0;
 
-	return kvm_iommu_register_driver(&kvm_smmu_v3_ops,
+	/*
+	 * Only one KVM IOMMU driver can be registered, so only call the
+	 * register function if any SMMUv3 exists on the platform.
+	 */
+	ret = kvm_arm_smmu_array_alloc();
+	if (ret || !kvm_arm_smmu_count)
+		return ret;
+
+	ret = kvm_iommu_register_driver(&kvm_smmu_v3_ops,
 					kern_hyp_va(lm_alias(&kvm_nvhe_sym(smmu_ops))));
+	if (ret)
+		kvm_arm_smmu_array_free();
+	return ret;
 };
 
 core_initcall(kvm_arm_smmu_v3_register);
-- 
2.50.1.552.g942d659e1b-goog


