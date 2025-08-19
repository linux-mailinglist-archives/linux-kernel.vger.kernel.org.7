Return-Path: <linux-kernel+bounces-776555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7708FB2CEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E801C41244
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539DC3277AB;
	Tue, 19 Aug 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvIzT4R4"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7B31DD83
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640363; cv=none; b=VBxeJgnsQ28UwPBntRaFbcNPAzhqrcUo7V/WBmswu1eBa+7ZWCh362XzOZFHyjYmZHh9d6lfhU8FBHZzlzmzq+vQL0JL/fLPpEoZJ77WhPLohiEZIPOLzEvQKJlo2m1hoWfxrO3QiO/LeqbD6Figsc6LF82YClGeEVVrE1hKBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640363; c=relaxed/simple;
	bh=XwAPL7cCuKQZyzoDsXxWaKOvvw7cbqN7O6Uc5m8Oi5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCsF9J8uh/dISgiLb0gGyixvAP6w/yM7QZe6Qqjel0+rAfZUfUTTPUknwZkcPzXwecmbasIfVt868qLvqVuOoqX8dvxjVx1OCoMU3anqIU0ngMsmtzRB1lPsCSjBqOq7rufJ3YvW0OgmWIUbObj57tflB9pK/QclJEAZkHnUzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvIzT4R4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so35806835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640359; x=1756245159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwu1qRO+eOJjyAwUn9pi1Q+O90cBvLjGAkOSG+zhKow=;
        b=tvIzT4R4DHc3wEsnYQWfzs7N7FeZ7NaTtsRz0QqGv86AgGXzbvHdlKs3u2H6dK4VrL
         JN393EN3m7bGEC4+embf12eYEMt4Z5g0xuNL02WT5dCxYUibk2908RLT/4O7izs5hqJ3
         TjAo+xsMiGdXP7AzcMRHWn266edS6la2SLoFXlwKVi9gINgeOMTgSvhCzZcwtMp2i4kQ
         PTkrU/aUNSosozh5ue7fJWRZFvFCJRVoO+CDgdPLa+SCeu4IEoW8840ICOzDtrBEorkJ
         sHwq+1+dCUEQt8WS7YSJ4y62Nq4IqxcGtdmn8qZ136a/8noeuelfjTFtmbRROqv8DqHm
         O/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640359; x=1756245159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwu1qRO+eOJjyAwUn9pi1Q+O90cBvLjGAkOSG+zhKow=;
        b=P9N60kmmxARTPRcVQzzr7LZlh5EPV0jcPplIbZggsK5soo7MUuxYUGS9OzGJoDn9av
         0Owy1gS9T1mf691YLZ0A30osIGhGnLYNIGyNeNUdk9i4pyg96et7YBsM2SPsUpDLipwY
         uaawQN0JeXatOEBa3gOkSbE0g3rRmuJgAQeSU9Ak+k65D5JkM8Wd3XU80uDCfPfMbwFD
         x3phjOqipe0snKb8pEGFgwg5MxJgB7jsoSwl13jqX3B260pamlYMFDZZWSHHgfJUeXNr
         ZW5jx19xV8n4ea7Yc9RAEcurUZOgkAglyNTQz+XjtlctrN0Dlkxz5UbO/YMPGZDf9NwG
         m8Xw==
X-Gm-Message-State: AOJu0YwUb+XqnQwQwcxuExH4sL/zB+BbN1elBH/NVbQEAhuC43E2+R9U
	a7RKReqine0Pm2ExgpAobWTs16cM8O6EwElecL4skMgzsHB1GGZ2iP0eGtHfGNmQHunx0BEAfh8
	lSCtVrdFTM6iwkACh4B4KSk7uMchK1DrFcvRJ2+43sJaaXVa5p+VMXckrJU2+gvEJaWcIHVcl7B
	Zr/ZhB09MHABgUL1IONSK0xKYzNeiDu67POQdxOTpTJhsiA3mcLX2Bz0o=
X-Google-Smtp-Source: AGHT+IEhkGtNHGU6UMmeB0BAIZ4sLir5Qlb/i2T9JqWqyDJv4XQTeVZhQ/vtD+ljWCO9zlGmXGV9Ovms10Lr6A==
X-Received: from wmbhc5.prod.google.com ([2002:a05:600c:8705:b0:458:6799:d779])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b05:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-45b479ea5a9mr2802145e9.19.1755640359305;
 Tue, 19 Aug 2025 14:52:39 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:44 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-17-smostafa@google.com>
Subject: [PATCH v4 16/28] iommu/arm-smmu-v3-kvm: Create array for hyp SMMUv3
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

As the hypervisor has no access to firmware tables, the device discovery
is done from the kernel, where it parses firmware tables and populates a
list of devices to the hypervisor, which later takes over.

At the moment only the device tree is supported.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 93 ++++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  | 13 +++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index ac4eac6d567f..27ea39c0fb1f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -7,6 +7,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_pkvm.h>
 
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 
 #include "arm-smmu-v3.h"
@@ -14,6 +15,75 @@
 
 extern struct kvm_iommu_ops kvm_nvhe_sym(smmu_ops);
 
+static size_t				kvm_arm_smmu_count;
+static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
+
+static void kvm_arm_smmu_array_free(void)
+{
+	int order;
+
+	order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
+	free_pages((unsigned long)kvm_arm_smmu_array, order);
+}
+
+/*
+ * The hypervisor have to know the basic information about the SMMUs
+ * from the firmware.
+ * This has to be done before the SMMUv3 probes and does anything meaningful
+ * with the hardware, otherwise it becomes harder to reason about the SMMU
+ * state and we'd require to hand-off the state to the hypervisor at certain point
+ * while devices are live, which is complicated and dangerous.
+ * Instead, the hypervisor is interested in a very small part of the probe path,
+ * so just add a separate logic for it.
+ */
+static int kvm_arm_smmu_array_alloc(void)
+{
+	int smmu_order;
+	struct device_node *np;
+	int ret;
+	int i = 0;
+
+	kvm_arm_smmu_count = 0;
+	for_each_compatible_node(np, NULL, "arm,smmu-v3")
+		kvm_arm_smmu_count++;
+
+	if (!kvm_arm_smmu_count)
+		return -ENODEV;
+
+	smmu_order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
+	kvm_arm_smmu_array = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, smmu_order);
+	if (!kvm_arm_smmu_array)
+		return -ENOMEM;
+
+	/* Basic device tree parsing. */
+	for_each_compatible_node(np, NULL, "arm,smmu-v3") {
+		struct resource res;
+
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			goto out_err;
+		kvm_arm_smmu_array[i].mmio_addr = res.start;
+		kvm_arm_smmu_array[i].mmio_size = resource_size(&res);
+		if (kvm_arm_smmu_array[i].mmio_size < SZ_128K) {
+			pr_err("SMMUv3(%s) has unsupported size(0x%lx)\n", np->name,
+			       kvm_arm_smmu_array[i].mmio_size);
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		if (of_dma_is_coherent(np))
+			kvm_arm_smmu_array[i].features |= ARM_SMMU_FEAT_COHERENCY;
+
+		i++;
+	}
+
+	return 0;
+
+out_err:
+	kvm_arm_smmu_array_free();
+	return ret;
+}
+
 size_t smmu_hyp_pgt_pages(void)
 {
 	/*
@@ -27,10 +97,31 @@ size_t smmu_hyp_pgt_pages(void)
 
 static int kvm_arm_smmu_v3_register(void)
 {
+	int ret;
+
 	if (!is_protected_kvm_enabled())
 		return 0;
 
-	return kvm_iommu_register_driver(kern_hyp_va(lm_alias(&kvm_nvhe_sym(smmu_ops))));
+	ret = kvm_arm_smmu_array_alloc();
+	if (ret)
+		return ret;
+
+	ret = kvm_iommu_register_driver(kern_hyp_va(lm_alias(&kvm_nvhe_sym(smmu_ops))));
+	if (ret)
+		goto out_err;
+
+	/*
+	 * These variables are stored in the nVHE image, and won't be accessible
+	 * after KVM initialization. Ownership of kvm_arm_smmu_array will be
+	 * transferred to the hypervisor as well.
+	 */
+	kvm_hyp_arm_smmu_v3_smmus = kvm_arm_smmu_array;
+	kvm_hyp_arm_smmu_v3_count = kvm_arm_smmu_count;
+	return ret;
+
+out_err:
+	kvm_arm_smmu_array_free();
+	return ret;
 };
 
 core_initcall(kvm_arm_smmu_v3_register);
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index f6ad91d3fb85..744ee2b7f0b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -4,7 +4,20 @@
 
 #include <asm/kvm_asm.h>
 
+/*
+ * Parameters from the trusted host:
+ * @mmio_addr		base address of the SMMU registers
+ * @mmio_size		size of the registers resource
+ * @features		Features of SMMUv3, subset of the main driver
+ *
+ * Other members are filled and used at runtime by the SMMU driver.
+ * @base		Virtual address of SMMU registers
+ */
 struct hyp_arm_smmu_v3_device {
+	phys_addr_t		mmio_addr;
+	size_t			mmio_size;
+	void __iomem		*base;
+	u32			features;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.51.0.rc1.167.g924127e9c0-goog


