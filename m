Return-Path: <linux-kernel+bounces-748467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57446B14188
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5425716770C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC7286D40;
	Mon, 28 Jul 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lY/Qvljp"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56182820A5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725233; cv=none; b=eZgYNdC+hrkFjWd6W/1nFBVU5T8AwZ6KdmCHMyd/KVldqR2XxkUU7PwJp1OYAigigDIxdvSFInG4eBsGhb5MWQMlJdxCCoAXqrmBbKxMoVVRa5nB2iOL8KqiXb482R1ssi+QfnqAhltbbMy2fzaJ4dIDGZ4aIA++DexB/6hgj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725233; c=relaxed/simple;
	bh=95chHff3zz7czkSoAmCuKp67OLtQgVr9l5n9sMY6pcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=udOzE+sncDVjQPnwAaVDr8xxSpB9XVrqOMOWVajwAzfkRf8A4KI4HqTp3SOjO2P//kXr9Z0MN8EGDXaynSxbazgGpbX3beBQZPK1UK2ePtG2yCyOguQnxT5r2BbVGQDzh1z1L4Ai9yDR3uGh8ypCZObQauum3+nx4I4ZpMtEmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lY/Qvljp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b782c29be3so1499413f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725228; x=1754330028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9jYddvCz41uASA7Sa8Gd38u2bIDrZAA55dbZYiHYK0=;
        b=lY/QvljpUO3Van+bMdHpvQb+Zt6M7OgICIoB19Tig4Jp/9FaigfhdxlTJnFxt/l1du
         zTxJxELsWmQNSLAzQdhSixPq+vLpo6U95jnV4SkYmvbWV/gcJTkuB+W6Fm6wlpHBXi/O
         zktatF+1dUwupHwj/0DoqOcj71y6WvChvlenZ+IkmmopdfS8CiZ10NUK9IHg/r7982dY
         DG71v6KBIB+nwJvuugfHMk5i0rK2MmChqcPwZCVvXs1FSHu1yFsff62GhxnXahCzvOV+
         OY1pqLeqksXAzPCWPMBoTzONQyw/jUzQBgHrH0X/g06G6fhvgFEYXb7CNQvFu+R/hGuI
         kU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725228; x=1754330028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9jYddvCz41uASA7Sa8Gd38u2bIDrZAA55dbZYiHYK0=;
        b=B+5zPcJhc9wR9nwIgw0QVG3e433Zh9EXT/1FMMTzJzrsOH7KCQA+3Sh/4yAi16xVFf
         PF+/dWaXSYHAX1ZGNcKO5+CTD10KkmiyBdyS6oS21A6NQ3Xi2eUyw3mVGxdZ6SLYdwto
         Ey84lzelPQW1lFSqQKgbVFmZefoAWANC+/Q2pN2TMGj5WDbiYGxJhqS603oEh21EXtxq
         bzHHEWQpa/t6XohbyOE4u5+gMN/F18VKxg1EOtpFVF+M1M0N9jaL422qikb7xXfQhvJ4
         ZWu3ZAoImt2kqS24U++xLSj/6/F3UgZB4qbeZR2w+ZHdmq3efAMIVfketf8hTfPjBV51
         mblg==
X-Gm-Message-State: AOJu0YyCyh1XRsxDxnaQ051WV77ot2gPRv3qwUQuA/1GstNwIzqU2iK5
	7+9Usy6EYdrjVzCAXeVZzavmoxaaIciYD7stWhWHc5epG4jUH4BQ0b1PU2fuNcgq3J7Y0xueQhp
	fQotppSQ86uV3smTdu9iXduiMpa38EGqJlFD6smufx8BHQ8KPzC9bVFDaQl73P+bPVAml5xSHu4
	LMzc6x5lFtzjritumfUKefr7YF+c8XgXn1g55lmLrJjlgAjNRhFi+YUFU=
X-Google-Smtp-Source: AGHT+IEIq4MuTZmAyjvY5ywUEpjJvcVv09tn1ZoK52Hz7k9v+do6OvW02sN+sKfvQsmRTrBRzkW0d1TsmWpcEQ==
X-Received: from wmbhh14.prod.google.com ([2002:a05:600c:530e:b0:455:76a8:b3a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:a3d0:0:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3b7899ceb31mr1880112f8f.59.1753725228115;
 Mon, 28 Jul 2025 10:53:48 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:05 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-19-smostafa@google.com>
Subject: [PATCH v3 18/29] iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
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
 drivers/iommu/arm/Kconfig                     |  9 +++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 24 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  | 16 +++++++++++++
 4 files changed, 54 insertions(+)
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
index ef42bbe07dbe..bcf4001521ad 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -142,3 +142,12 @@ config QCOM_IOMMU
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
+
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
new file mode 100644
index 000000000000..2f43804e08e0
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -0,0 +1,24 @@
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
+/* Shared with the kernel driver in EL1 */
+struct kvm_iommu_ops smmu_ops = {
+	.init				= smmu_init,
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
2.50.1.552.g942d659e1b-goog


