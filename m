Return-Path: <linux-kernel+bounces-776551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D4B2CEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EC22A6448
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81B31DD82;
	Tue, 19 Aug 2025 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqyuAjDM"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0C35A2A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640360; cv=none; b=HLJ12LPGBrJCgFltx0+PLaiyAAq6HPWJg3+2iUo9OiHNogbLyQLHFNcmzpeG4HJC0uCd6wxO0UYG+qZjbgXZStUQpOqmYNfVJK0l/bEq24suh0+RaYszS+DvVh30I1s0SP8L+BlfL/Od1u2s0gn8ZqcfTYsh4DSkUo46JOKLK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640360; c=relaxed/simple;
	bh=/Unve+csthHtV/Kg7izjSh135002Cudi01KNNjtlOpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8CLZlMhMVFejdwO8EM4scGcMl4dfr0o5AkopsvGcTXq+hf8mJCOOm7KNwiPvFCH3TexxFwJLC+WJWAPwmO8mbL7wlrvmwdrY5EiRYDGmx/T2AGZRfumAN0cGzsVg0ikGD9N8W6JmtRjVRZZ/4q83V7GtHd/zAbaFMSXmX2eBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqyuAjDM; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb733834bso548513766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640356; x=1756245156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e98f0DNE5CRlyU4NM0kgE4ri91mOXmN3Zo8dZtJNlTc=;
        b=LqyuAjDMmj+gt7Tw5dRZsRNwW06FWcMtv9WVHoXl5IIAbbhJUK90mSQqrV59kVWBWN
         SzzISb7oSwDPsVHhSBhIYwEcbtUl203RqN9mRuA4IBEH66TylvcGtrDS/Zw9COAyW6qu
         la57u47v3YX0lRVUmhMPiAHH4EdPyHNtpp5D229zEi8tGCTOMLhmaqKhyub9WcbcqphP
         qJV45yz1GsRWtLg9hUIaeLSosAQcoSxhyBSIVN9wokIirgkydLtyvSLjFocieBzJzmBE
         JNn1bGMNls7KbxJDAhiVYHgW3b/EBll1yYmssEZrnNvalCGJpFM4ccVpD05adJjSVqQo
         bi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640356; x=1756245156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e98f0DNE5CRlyU4NM0kgE4ri91mOXmN3Zo8dZtJNlTc=;
        b=tX8e3LpLUwXy/4AaE5rxkOKr3X/whJfZ2ZLqFRG3uCq4xMOCElNLm5ngbXKlzHTZga
         8fe3hmG5bmqsaycEQINHGwbiVA3SaHmPSaKv4EPXr4plvtKWQ5BggZKfyKb6mlM9scnr
         5CQXavwulO1koiFkktl+topIS8JQoL+zdK0OjHmxOyLsFfNhOll5XRLWwVOT7XbXVGyN
         lp3EXq+Zh5bYGl0oX2NCLSrtxWnfj98PVSROmP0+1hwSXf6572wVi9UYU7+/XMefs6Ei
         b0O/qHz/rIdG8qy4jDMg3Jcc5HjfRG9na6JmxuQSVHEsEf4OsAlkbGWT9jeGaKnTa9Wc
         UDyw==
X-Gm-Message-State: AOJu0YzYNc76S1+LCwzP7aW+q2XsGggH09xfOYEH0MefiSgVhH9F0z/m
	0XaePKfe7GLimgu4HQ8jlkjEMQX0tI0six7j/XbIozHaFMJTNxz8n5ocQYoHIqR5FzIWKDVgca1
	KBfw5iqjwy1CrmlsUxXzA4c9kP0LWiSfz4TkSAUWU45XLxy0KxF3w6pZ9sA7qvf0aPd2/v5Sfxw
	zE4H2BxCWIYtVFWmb+1fL2r535MKjb6HT0fdCfSgZvYCiqhtgFi3WwBLE=
X-Google-Smtp-Source: AGHT+IHCyvZOecVyOHzeGqtTcsp9WMNtt0BHBZO+OkO4882nr2LShFVO1rZjvNy7Rv+QSkccbtheqDZoV50swQ==
X-Received: from edbek21.prod.google.com ([2002:a05:6402:3715:b0:61a:1a2c:d08e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7f8e:b0:af9:1122:6af0 with SMTP id a640c23a62f3a-afdf01cfa9dmr47797666b.30.1755640356474;
 Tue, 19 Aug 2025 14:52:36 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:41 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-14-smostafa@google.com>
Subject: [PATCH v4 13/28] iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
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

Add the skeleton for an Arm SMMUv3 driver at EL2.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile              |  5 ++++
 drivers/iommu/arm/Kconfig                     |  9 ++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 29 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  | 16 ++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 393ff143f0be..c71c96262378 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -31,6 +31,11 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-y += $(lib-objs)
 
+HYP_SMMU_V3_DRV_PATH = ../../../../../drivers/iommu/arm/arm-smmu-v3
+
+hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += $(HYP_SMMU_V3_DRV_PATH)/pkvm/arm-smmu-v3.o \
+	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-hyp.o
+
 ##
 ## Build rules for compiling nVHE hyp code
 ## Output of this folder is `kvm_nvhe.o`, a partially linked object
diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index ef42bbe07dbe..7eeb94d2499d 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -142,3 +142,12 @@ config QCOM_IOMMU
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
+
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64 && ARM_SMMU_V3=y
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
new file mode 100644
index 000000000000..fa8b71152560
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM hyp driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_hyp.h>
+
+#include <nvhe/iommu.h>
+
+#include "arm_smmu_v3.h"
+
+size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
+struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
+
+static int smmu_init(void)
+{
+	return -ENOSYS;
+}
+
+static void smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
+{
+}
+
+/* Shared with the kernel driver in EL1 */
+struct kvm_iommu_ops smmu_ops = {
+	.init				= smmu_init,
+	.host_stage2_idmap		= smmu_host_stage2_idmap,
+};
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
new file mode 100644
index 000000000000..f6ad91d3fb85
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_ARM_SMMU_V3_H
+#define __KVM_ARM_SMMU_V3_H
+
+#include <asm/kvm_asm.h>
+
+struct hyp_arm_smmu_v3_device {
+};
+
+extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
+#define kvm_hyp_arm_smmu_v3_count kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count)
+
+extern struct hyp_arm_smmu_v3_device *kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus);
+#define kvm_hyp_arm_smmu_v3_smmus kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus)
+
+#endif /* __KVM_ARM_SMMU_V3_H */
-- 
2.51.0.rc1.167.g924127e9c0-goog


