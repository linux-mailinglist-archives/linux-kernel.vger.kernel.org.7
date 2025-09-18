Return-Path: <linux-kernel+bounces-748457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B328B1417D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79367AED0D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFB927C17E;
	Mon, 28 Jul 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GORkTaXv"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB927780E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725224; cv=none; b=sFlfpO3t9UN7zim1w5Onk/5t31Xnhm1LvGbUBaQvPCttP1dg6zMrrGubOK5HSmRwEaGqiEgL8unB7cpBdGp1xGXboGEP1hoC6vhZIM0krwZMV+l0jqpYesD4H/iCGmt1ALN/gNgW+iQPIaMzbvCjG0FKTm5hWc9JWfQ2P0LpcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725224; c=relaxed/simple;
	bh=hdFdVnXWmHHAnCtmElmK1omGOKbz9U/9DiC1wMK96bE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6dJFQrN9bkPBexdmOXM17/qpWFQyrQcShCLNN8y599nZXThw0YLfTAkNbZLPaxEQ8Fk+V5KAiAfqxUBT+doUkeQdxiiw51qNGzGmolDdl4rg2K6X5FhXyMFIR4+bH3aE8RFthZQHrGBqte/rsjh8lVU3iCEJTHLDbCnAjPiR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GORkTaXv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b604541741so3108163f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725219; x=1754330019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkzslG+EoAj657pVViZ0KqcF9Wef8uH7jIrIUPDZB0Q=;
        b=GORkTaXvbbMu6egA0yPZl5I+5NYinA1pTrld7gGwfcPTr93oTaJ5QuigoQiJodZz0W
         2UcGcbGtwsiYG/9H3sTiovCkb0eHMOMAaGhpjQG1zkdNCBNym4tqmhVvaB/cD+8N50ku
         0r1OA+SkfWeoZLb/XEIM61zFOeKRWVdMrjdx5Hc0nxO89NtxyiU8LDaQxTjfE8TKQjhl
         ajkb4fDwHkNk4gZiGSIZ9TfQJeGK83Beq8xJajJv8Nc61Q8WRBmDRssp3Hwp3YQ4oLFX
         lDrCXPp2JdN0K293lmHg+CvIUv8ZEKPkAqxuWZGdU2vuHinXkNS6kg6dHRP11Ds0I6aK
         4CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725219; x=1754330019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkzslG+EoAj657pVViZ0KqcF9Wef8uH7jIrIUPDZB0Q=;
        b=kQowwBdOAeDI0S06prgkRIsi0RnCrKG+sBIcsf9CEvhwtBpIzy+MFvW/rrjk4kPn4f
         lpqYDWDoVhDOlhV1HZjmVoBYRteKkNpgfEy+VRhF6eIZsyYttvnJxb+H9aTmKbYmYWTc
         Ds17HQf0IP4ypk0Q/toLPb67GboAGGr3v1msCV27dyiBm8QR2315WNpWjyai8bcEEv3A
         ml8U+MNM8lC3GlgT97AFkw/QZVvr67tMOrm14AXIRP1l/tdL1rx0lfO6cmrvgGLcj8Pv
         XOqUxjFex/3GomVOI3sOULYBo3YYPH2Oc77KjMdz9WdmWT/ZuxLHAwDSyMGhI3/roVvN
         /2Fg==
X-Gm-Message-State: AOJu0YzlJ91vnO77ppl2DYbJVksD+Dr2dY9WZGX+PwDYlO48MubnNl1j
	HL3AcC/9Ak3DXicXGAKmt0w9Qn66GBbkZUBbjuWo+mgP2Rdjac0WXlmLI0V40pF+EONePK7wgQd
	KVcB/+dJz7LHMrzVpZ9CJD5PCV/hIHVv+EDSvjKiA7FOKiGJDL4/Ry8UHtBtqP1v8v/2U1YolKj
	nogVI32ab1T4WwvTvZxmma3BIhZOK/8O3AbhHz//FFjJ2T94aYexHfNgM=
X-Google-Smtp-Source: AGHT+IE5NASS7Rnx/u2nUpf4AaA6N49oHp8BNhnh/LYQOEbhaNPMrBAnWkAEqxZtU+ZBr9B4KuzrThxEPyukwQ==
X-Received: from wrvi14.prod.google.com ([2002:a5d:558e:0:b0:3b7:86b6:8da6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d89:0:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3b776667125mr8438950f8f.36.1753725218563;
 Mon, 28 Jul 2025 10:53:38 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:55 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-9-smostafa@google.com>
Subject: [PATCH v3 08/29] iommu/arm-smmu-v3: Move some functions to arm-smmu-v3-common.c
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

Move functions that can be shared between normal and KVM drivers to
arm-smmu-v3-common.c

Only straightforward moves here. More subtle factoring will be done in
then next patches.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 367 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 366 -----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   8 +
 4 files changed, 376 insertions(+), 366 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66b..0bc0c116b851 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
+arm_smmu_v3-y += arm-smmu-v3-common.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
new file mode 100644
index 000000000000..c2b14b0c9f53
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/pci.h>
+#include <linux/string_choices.h>
+
+#include "arm-smmu-v3.h"
+#include "../../dma-iommu.h"
+
+#define IIDR_IMPLEMENTER_ARM		0x43b
+#define IIDR_PRODUCTID_ARM_MMU_600	0x483
+#define IIDR_PRODUCTID_ARM_MMU_700	0x487
+
+static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	unsigned int implementer, productid, variant, revision;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
+	productid = FIELD_GET(IIDR_PRODUCTID, reg);
+	variant = FIELD_GET(IIDR_VARIANT, reg);
+	revision = FIELD_GET(IIDR_REVISION, reg);
+
+	switch (implementer) {
+	case IIDR_IMPLEMENTER_ARM:
+		switch (productid) {
+		case IIDR_PRODUCTID_ARM_MMU_600:
+			/* Arm erratum 1076982 */
+			if (variant == 0 && revision <= 2)
+				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			/* Arm erratum 1209401 */
+			if (variant < 2)
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			break;
+		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* Arm erratum 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			/* Arm errata 2268618, 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			break;
+		}
+		break;
+	}
+}
+
+static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
+{
+	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
+	u32 hw_features = 0;
+
+	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		hw_features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		hw_features |= ARM_SMMU_FEAT_HA;
+	}
+
+	if (smmu->dev->of_node)
+		smmu->features |= hw_features;
+	else if (hw_features != fw_features)
+		/* ACPI IORT sets the HTTU bits */
+		dev_warn(smmu->dev,
+			 "IDR0.HTTU features(0x%x) overridden by FW configuration (0x%x)\n",
+			  hw_features, fw_features);
+}
+
+int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+
+	/* IDR0 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
+
+	/* 2-level structures */
+	if (FIELD_GET(IDR0_ST_LVL, reg) == IDR0_ST_LVL_2LVL)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+
+	if (reg & IDR0_CD2L)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_CDTAB;
+
+	/*
+	 * Translation table endianness.
+	 * We currently require the same endianness as the CPU, but this
+	 * could be changed later by adding a new IO_PGTABLE_QUIRK.
+	 */
+	switch (FIELD_GET(IDR0_TTENDIAN, reg)) {
+	case IDR0_TTENDIAN_MIXED:
+		smmu->features |= ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE;
+		break;
+#ifdef __BIG_ENDIAN
+	case IDR0_TTENDIAN_BE:
+		smmu->features |= ARM_SMMU_FEAT_TT_BE;
+		break;
+#else
+	case IDR0_TTENDIAN_LE:
+		smmu->features |= ARM_SMMU_FEAT_TT_LE;
+		break;
+#endif
+	default:
+		dev_err(smmu->dev, "unknown/unsupported TT endianness!\n");
+		return -ENXIO;
+	}
+
+	/* Boolean feature flags */
+	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
+		smmu->features |= ARM_SMMU_FEAT_PRI;
+
+	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
+		smmu->features |= ARM_SMMU_FEAT_ATS;
+
+	if (reg & IDR0_SEV)
+		smmu->features |= ARM_SMMU_FEAT_SEV;
+
+	if (reg & IDR0_MSI) {
+		smmu->features |= ARM_SMMU_FEAT_MSI;
+		if (coherent)
+			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
+	}
+
+	if (reg & IDR0_HYP) {
+		smmu->features |= ARM_SMMU_FEAT_HYP;
+		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+			smmu->features |= ARM_SMMU_FEAT_E2H;
+	}
+
+	arm_smmu_get_httu(smmu, reg);
+
+	/*
+	 * The coherency feature as set by FW is used in preference to the ID
+	 * register, but warn on mismatch.
+	 */
+	if (!!(reg & IDR0_COHACC) != coherent)
+		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
+			 str_true_false(coherent));
+
+	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
+	case IDR0_STALL_MODEL_FORCE:
+		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
+		fallthrough;
+	case IDR0_STALL_MODEL_STALL:
+		smmu->features |= ARM_SMMU_FEAT_STALLS;
+	}
+
+	if (reg & IDR0_S1P)
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
+
+	if (reg & IDR0_S2P)
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
+
+	if (!(reg & (IDR0_S1P | IDR0_S2P))) {
+		dev_err(smmu->dev, "no translation support!\n");
+		return -ENXIO;
+	}
+
+	/* We only support the AArch64 table format at present */
+	switch (FIELD_GET(IDR0_TTF, reg)) {
+	case IDR0_TTF_AARCH32_64:
+		smmu->ias = 40;
+		fallthrough;
+	case IDR0_TTF_AARCH64:
+		break;
+	default:
+		dev_err(smmu->dev, "AArch64 table format not supported!\n");
+		return -ENXIO;
+	}
+
+	/* ASID/VMID sizes */
+	smmu->asid_bits = reg & IDR0_ASID16 ? 16 : 8;
+	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
+
+	/* IDR1 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
+	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL)) {
+		dev_err(smmu->dev, "embedded implementation not supported\n");
+		return -ENXIO;
+	}
+
+	if (reg & IDR1_ATTR_TYPES_OVR)
+		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
+
+	/* Queue sizes, capped to ensure natural alignment */
+	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_CMDQS, reg));
+	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
+		/*
+		 * We don't support splitting up batches, so one batch of
+		 * commands plus an extra sync needs to fit inside the command
+		 * queue. There's also no way we can handle the weird alignment
+		 * restrictions on the base pointer for a unit-length queue.
+		 */
+		dev_err(smmu->dev, "command queue size <= %d entries not supported\n",
+			CMDQ_BATCH_ENTRIES);
+		return -ENXIO;
+	}
+
+	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_EVTQS, reg));
+	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_PRIQS, reg));
+
+	/* SID/SSID sizes */
+	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
+	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
+
+	/*
+	 * If the SMMU supports fewer bits than would fill a single L2 stream
+	 * table, use a linear table instead.
+	 */
+	if (smmu->sid_bits <= STRTAB_SPLIT)
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+
+	/* IDR3 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
+	if (FIELD_GET(IDR3_RIL, reg))
+		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
+	if (FIELD_GET(IDR3_FWB, reg))
+		smmu->features |= ARM_SMMU_FEAT_S2FWB;
+
+	/* IDR5 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
+
+	/* Maximum number of outstanding stalls */
+	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
+
+	/* Page sizes */
+	if (reg & IDR5_GRAN64K)
+		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
+	if (reg & IDR5_GRAN16K)
+		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
+	if (reg & IDR5_GRAN4K)
+		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
+
+	/* Input address size */
+	if (FIELD_GET(IDR5_VAX, reg) == IDR5_VAX_52_BIT)
+		smmu->features |= ARM_SMMU_FEAT_VAX;
+
+	/* Output address size */
+	switch (FIELD_GET(IDR5_OAS, reg)) {
+	case IDR5_OAS_32_BIT:
+		smmu->oas = 32;
+		break;
+	case IDR5_OAS_36_BIT:
+		smmu->oas = 36;
+		break;
+	case IDR5_OAS_40_BIT:
+		smmu->oas = 40;
+		break;
+	case IDR5_OAS_42_BIT:
+		smmu->oas = 42;
+		break;
+	case IDR5_OAS_44_BIT:
+		smmu->oas = 44;
+		break;
+	case IDR5_OAS_52_BIT:
+		smmu->oas = 52;
+		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
+		break;
+	default:
+		dev_info(smmu->dev,
+			 "unknown output address size. Truncating to 48-bit\n");
+		fallthrough;
+	case IDR5_OAS_48_BIT:
+		smmu->oas = 48;
+	}
+
+	/* Set the DMA mask for our table walker */
+	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
+		dev_warn(smmu->dev,
+			 "failed to set DMA mask for table walker\n");
+
+	smmu->ias = max(smmu->ias, smmu->oas);
+
+	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		smmu->features |= ARM_SMMU_FEAT_NESTING;
+
+	arm_smmu_device_iidr_probe(smmu);
+
+	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
+		 smmu->ias, smmu->oas, smmu->features);
+	return 0;
+}
+
+int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
+			    unsigned int reg_off, unsigned int ack_off)
+{
+	u32 reg;
+
+	writel_relaxed(val, smmu->base + reg_off);
+	return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg == val,
+					  1, ARM_SMMU_POLL_TIMEOUT_US);
+}
+
+/* GBPA is "special" */
+int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
+{
+	int ret;
+	u32 reg, __iomem *gbpa = smmu->base + ARM_SMMU_GBPA;
+
+	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	reg &= ~clr;
+	reg |= set;
+	writel_relaxed(reg | GBPA_UPDATE, gbpa);
+	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+
+	if (ret)
+		dev_err(smmu->dev, "GBPA not responding to update\n");
+	return ret;
+}
+
+int arm_smmu_device_disable(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret)
+		dev_err(smmu->dev, "failed to clear cr0\n");
+
+	return ret;
+}
+
+struct iommu_group *arm_smmu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+
+	/*
+	 * We don't support devices sharing stream IDs other than PCI RID
+	 * aliases, since the necessary ID-to-device lookup becomes rather
+	 * impractical given a potential sparse 32-bit stream ID space.
+	 */
+	if (dev_is_pci(dev))
+		group = pci_device_group(dev);
+	else
+		group = generic_device_group(dev);
+
+	return group;
+}
+
+int arm_smmu_of_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+void arm_smmu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *region;
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, head);
+
+	iommu_dma_get_resv_regions(dev, head);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 801b792dda36..fc4bf270c365 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
-#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -26,12 +25,10 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
-#include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
 #include "arm-smmu-v3.h"
-#include "../../dma-iommu.h"
 
 static bool disable_msipolling;
 module_param(disable_msipolling, bool, 0444);
@@ -2030,8 +2027,6 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
-
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	u32 gerror, gerrorn, active;
@@ -3615,45 +3610,6 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static struct iommu_group *arm_smmu_device_group(struct device *dev)
-{
-	struct iommu_group *group;
-
-	/*
-	 * We don't support devices sharing stream IDs other than PCI RID
-	 * aliases, since the necessary ID-to-device lookup becomes rather
-	 * impractical given a potential sparse 32-bit stream ID space.
-	 */
-	if (dev_is_pci(dev))
-		group = pci_device_group(dev);
-	else
-		group = generic_device_group(dev);
-
-	return group;
-}
-
-static int arm_smmu_of_xlate(struct device *dev,
-			     const struct of_phandle_args *args)
-{
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
-static void arm_smmu_get_resv_regions(struct device *dev,
-				      struct list_head *head)
-{
-	struct iommu_resv_region *region;
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
-	if (!region)
-		return;
-
-	list_add_tail(&region->list, head);
-
-	iommu_dma_get_resv_regions(dev, head);
-}
-
 /*
  * HiSilicon PCIe tune and trace device can be used to trace TLP headers on the
  * PCIe link and save the data to memory by DMA. The hardware is restricted to
@@ -3897,38 +3853,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
-				   unsigned int reg_off, unsigned int ack_off)
-{
-	u32 reg;
-
-	writel_relaxed(val, smmu->base + reg_off);
-	return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg == val,
-					  1, ARM_SMMU_POLL_TIMEOUT_US);
-}
-
-/* GBPA is "special" */
-static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
-{
-	int ret;
-	u32 reg, __iomem *gbpa = smmu->base + ARM_SMMU_GBPA;
-
-	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					 1, ARM_SMMU_POLL_TIMEOUT_US);
-	if (ret)
-		return ret;
-
-	reg &= ~clr;
-	reg |= set;
-	writel_relaxed(reg | GBPA_UPDATE, gbpa);
-	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					 1, ARM_SMMU_POLL_TIMEOUT_US);
-
-	if (ret)
-		dev_err(smmu->dev, "GBPA not responding to update\n");
-	return ret;
-}
-
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev = data;
@@ -4075,17 +3999,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
-{
-	int ret;
-
-	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
-	if (ret)
-		dev_err(smmu->dev, "failed to clear cr0\n");
-
-	return ret;
-}
-
 static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -4243,285 +4156,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-#define IIDR_IMPLEMENTER_ARM		0x43b
-#define IIDR_PRODUCTID_ARM_MMU_600	0x483
-#define IIDR_PRODUCTID_ARM_MMU_700	0x487
-
-static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
-{
-	u32 reg;
-	unsigned int implementer, productid, variant, revision;
-
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
-	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
-	productid = FIELD_GET(IIDR_PRODUCTID, reg);
-	variant = FIELD_GET(IIDR_VARIANT, reg);
-	revision = FIELD_GET(IIDR_REVISION, reg);
-
-	switch (implementer) {
-	case IIDR_IMPLEMENTER_ARM:
-		switch (productid) {
-		case IIDR_PRODUCTID_ARM_MMU_600:
-			/* Arm erratum 1076982 */
-			if (variant == 0 && revision <= 2)
-				smmu->features &= ~ARM_SMMU_FEAT_SEV;
-			/* Arm erratum 1209401 */
-			if (variant < 2)
-				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
-			break;
-		case IIDR_PRODUCTID_ARM_MMU_700:
-			/* Arm erratum 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_BTM;
-			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
-			/* Arm errata 2268618, 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
-			break;
-		}
-		break;
-	}
-}
-
-static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
-{
-	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
-	u32 hw_features = 0;
-
-	switch (FIELD_GET(IDR0_HTTU, reg)) {
-	case IDR0_HTTU_ACCESS_DIRTY:
-		hw_features |= ARM_SMMU_FEAT_HD;
-		fallthrough;
-	case IDR0_HTTU_ACCESS:
-		hw_features |= ARM_SMMU_FEAT_HA;
-	}
-
-	if (smmu->dev->of_node)
-		smmu->features |= hw_features;
-	else if (hw_features != fw_features)
-		/* ACPI IORT sets the HTTU bits */
-		dev_warn(smmu->dev,
-			 "IDR0.HTTU features(0x%x) overridden by FW configuration (0x%x)\n",
-			  hw_features, fw_features);
-}
-
-static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
-{
-	u32 reg;
-	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
-
-	/* IDR0 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
-
-	/* 2-level structures */
-	if (FIELD_GET(IDR0_ST_LVL, reg) == IDR0_ST_LVL_2LVL)
-		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
-
-	if (reg & IDR0_CD2L)
-		smmu->features |= ARM_SMMU_FEAT_2_LVL_CDTAB;
-
-	/*
-	 * Translation table endianness.
-	 * We currently require the same endianness as the CPU, but this
-	 * could be changed later by adding a new IO_PGTABLE_QUIRK.
-	 */
-	switch (FIELD_GET(IDR0_TTENDIAN, reg)) {
-	case IDR0_TTENDIAN_MIXED:
-		smmu->features |= ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE;
-		break;
-#ifdef __BIG_ENDIAN
-	case IDR0_TTENDIAN_BE:
-		smmu->features |= ARM_SMMU_FEAT_TT_BE;
-		break;
-#else
-	case IDR0_TTENDIAN_LE:
-		smmu->features |= ARM_SMMU_FEAT_TT_LE;
-		break;
-#endif
-	default:
-		dev_err(smmu->dev, "unknown/unsupported TT endianness!\n");
-		return -ENXIO;
-	}
-
-	/* Boolean feature flags */
-	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
-		smmu->features |= ARM_SMMU_FEAT_PRI;
-
-	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
-		smmu->features |= ARM_SMMU_FEAT_ATS;
-
-	if (reg & IDR0_SEV)
-		smmu->features |= ARM_SMMU_FEAT_SEV;
-
-	if (reg & IDR0_MSI) {
-		smmu->features |= ARM_SMMU_FEAT_MSI;
-		if (coherent)
-			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
-	}
-
-	if (reg & IDR0_HYP) {
-		smmu->features |= ARM_SMMU_FEAT_HYP;
-		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
-			smmu->features |= ARM_SMMU_FEAT_E2H;
-	}
-
-	arm_smmu_get_httu(smmu, reg);
-
-	/*
-	 * The coherency feature as set by FW is used in preference to the ID
-	 * register, but warn on mismatch.
-	 */
-	if (!!(reg & IDR0_COHACC) != coherent)
-		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
-			 str_true_false(coherent));
-
-	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
-	case IDR0_STALL_MODEL_FORCE:
-		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
-		fallthrough;
-	case IDR0_STALL_MODEL_STALL:
-		smmu->features |= ARM_SMMU_FEAT_STALLS;
-	}
-
-	if (reg & IDR0_S1P)
-		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
-
-	if (reg & IDR0_S2P)
-		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
-
-	if (!(reg & (IDR0_S1P | IDR0_S2P))) {
-		dev_err(smmu->dev, "no translation support!\n");
-		return -ENXIO;
-	}
-
-	/* We only support the AArch64 table format at present */
-	switch (FIELD_GET(IDR0_TTF, reg)) {
-	case IDR0_TTF_AARCH32_64:
-		smmu->ias = 40;
-		fallthrough;
-	case IDR0_TTF_AARCH64:
-		break;
-	default:
-		dev_err(smmu->dev, "AArch64 table format not supported!\n");
-		return -ENXIO;
-	}
-
-	/* ASID/VMID sizes */
-	smmu->asid_bits = reg & IDR0_ASID16 ? 16 : 8;
-	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
-
-	/* IDR1 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
-	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL)) {
-		dev_err(smmu->dev, "embedded implementation not supported\n");
-		return -ENXIO;
-	}
-
-	if (reg & IDR1_ATTR_TYPES_OVR)
-		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
-
-	/* Queue sizes, capped to ensure natural alignment */
-	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_CMDQS, reg));
-	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
-		/*
-		 * We don't support splitting up batches, so one batch of
-		 * commands plus an extra sync needs to fit inside the command
-		 * queue. There's also no way we can handle the weird alignment
-		 * restrictions on the base pointer for a unit-length queue.
-		 */
-		dev_err(smmu->dev, "command queue size <= %d entries not supported\n",
-			CMDQ_BATCH_ENTRIES);
-		return -ENXIO;
-	}
-
-	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_EVTQS, reg));
-	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_PRIQS, reg));
-
-	/* SID/SSID sizes */
-	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
-	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
-	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
-
-	/*
-	 * If the SMMU supports fewer bits than would fill a single L2 stream
-	 * table, use a linear table instead.
-	 */
-	if (smmu->sid_bits <= STRTAB_SPLIT)
-		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
-
-	/* IDR3 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
-	if (FIELD_GET(IDR3_RIL, reg))
-		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
-	if (FIELD_GET(IDR3_FWB, reg))
-		smmu->features |= ARM_SMMU_FEAT_S2FWB;
-
-	/* IDR5 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
-
-	/* Maximum number of outstanding stalls */
-	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
-
-	/* Page sizes */
-	if (reg & IDR5_GRAN64K)
-		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
-	if (reg & IDR5_GRAN16K)
-		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
-	if (reg & IDR5_GRAN4K)
-		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
-
-	/* Input address size */
-	if (FIELD_GET(IDR5_VAX, reg) == IDR5_VAX_52_BIT)
-		smmu->features |= ARM_SMMU_FEAT_VAX;
-
-	/* Output address size */
-	switch (FIELD_GET(IDR5_OAS, reg)) {
-	case IDR5_OAS_32_BIT:
-		smmu->oas = 32;
-		break;
-	case IDR5_OAS_36_BIT:
-		smmu->oas = 36;
-		break;
-	case IDR5_OAS_40_BIT:
-		smmu->oas = 40;
-		break;
-	case IDR5_OAS_42_BIT:
-		smmu->oas = 42;
-		break;
-	case IDR5_OAS_44_BIT:
-		smmu->oas = 44;
-		break;
-	case IDR5_OAS_52_BIT:
-		smmu->oas = 52;
-		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
-		break;
-	default:
-		dev_info(smmu->dev,
-			"unknown output address size. Truncating to 48-bit\n");
-		fallthrough;
-	case IDR5_OAS_48_BIT:
-		smmu->oas = 48;
-	}
-
-	/* Set the DMA mask for our table walker */
-	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
-		dev_warn(smmu->dev,
-			 "failed to set DMA mask for table walker\n");
-
-	smmu->ias = max(smmu->ias, smmu->oas);
-
-	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
-	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
-		smmu->features |= ARM_SMMU_FEAT_NESTING;
-
-	arm_smmu_device_iidr_probe(smmu);
-
-	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
-		 smmu->ias, smmu->oas, smmu->features);
-	return 0;
-}
-
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_TEGRA241_CMDQV
 static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3b88f19fcefc..367529538eb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -545,6 +545,14 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
+int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu);
+int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
+			    unsigned int reg_off, unsigned int ack_off);
+int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr);
+int arm_smmu_device_disable(struct arm_smmu_device *smmu);
+struct iommu_group *arm_smmu_device_group(struct device *dev);
+int arm_smmu_of_xlate(struct device *dev, const struct of_phandle_args *args);
+void arm_smmu_get_resv_regions(struct device *dev, struct list_head *head);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1.552.g942d659e1b-goog


