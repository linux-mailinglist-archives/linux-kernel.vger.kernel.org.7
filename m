Return-Path: <linux-kernel+bounces-748459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B353B1417E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83498170318
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A933277C9E;
	Mon, 28 Jul 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqHePCVw"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CF25C711
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725224; cv=none; b=rk9eENComSYSuZObqzV5JrhrxTadXhhcOxHrOswUaqEb6lo9vte5wLkJKLQcyn3GgsRf5CsDt0QuEktlgvqyhE9kQZYltGrGDQ6gtxiWYW9Z9EyTf5zMOdvo6I4YyssxZzzRCCVLDH/pDIZKdWDs5ikFDjvGOnILodefU1kjBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725224; c=relaxed/simple;
	bh=HcP5KW/rl1/2RncLpvkh812pk4RGa50v0OaTu1mTwOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FkCk1qzLBXOR2B2XtJ9VsaDbwkxdyYydDsZvSwGhQUAr5V8rNUFppxEeWi/F+GrRTO4fhF5gk8fAX3R3QEBOzpUb25A4FiCnZnBcCUaBBbcDgoIAuY6xjSX4OqvbVxjkN263hofms2BmNLkWHUSzdLAqp6rauO7U8iWeLuT/DUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BqHePCVw; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so777460f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725220; x=1754330020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vujkvhJSsWBmwddZ5ZvjZfc/b3IwDMz5JLn5GQ9I5KQ=;
        b=BqHePCVwHGGg65Ve6qdqEpl08N+WxH4I2pbJSaiNa5qXz4EqIHljDJGMDAiN2nGQKR
         qm6E8xrFml1Laaduovk+qgcvzyNRXqSAZzSbCDY4CzVJNmb7XIgWrjMRU/IeDI6Nvoqs
         bRZjEvDMjWBpzbFS2uJLzrXG02nR4q3ks7AHX1QVCQN9ra50TKNz0TnSoQAvHn2I2Aue
         La7QanxeD9L9Ib/fx3GxgxjBpPIwplZmUTciPLRfL80SgMEtYe6jSiyW6alQDUBeBGmX
         NJ0P2cdvdMuU32vEfZlgFuOQgWySqZO49UGz1VdCyHpGRZKOzmwS9xOYbmT/H0YLp8ki
         2/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725220; x=1754330020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vujkvhJSsWBmwddZ5ZvjZfc/b3IwDMz5JLn5GQ9I5KQ=;
        b=XCoSYJZSRZ+7jqt7vF4QNmXP86ZrSuf2CLPJ4uEuZK2ppQnT27Kkn1/Re36YWOJLm6
         D++YcamAMONjfxcN7XH4GtJLYagPoCfebWK3RKWYgzJtxxw7BFFaKRXhoGv8Dy6kpOjZ
         lSOBN1twSOa19JDWuahSX6EH139V6cxoIQV1k18/i0ZDUMUdH/Xps2mvo+N484DeDCFy
         KvXVN5cYGWfn22Qu7n01ijtMYSZe/m3MLmLXjWvepyH2OUj6erGMwtYG2bUnQdE2QS1Y
         GvKP6Oxz5q0+lf66W5Ad9X72NjdvZe6W6wfeqd/90tY1eSYia+z4go9WLDdCIeIlhrfP
         kI1g==
X-Gm-Message-State: AOJu0YwsSfQT+Khqqc+Z9zouDE9wojhyUJjMkOuZdfVlyr3hgeqlUJi3
	XjMnBzEXfnbeKrCfkhC4Uw9Zw1FL0TLeBSsWEOf2TXme1j/2eAX9YIP37y0z/KXEqDBQDpF3D38
	PDn8ubHy912cvfiRLfNMDr6AgQshwvKJAuTfqp89NGNiL0rOT9J60zWIVVzT94fYZGrNW5ojGV/
	XGzgTOQNCM84FXPCFDE/qtfoJ7ucXJoZwLjCQcgH4YinpJ/6nB3RlQl/s=
X-Google-Smtp-Source: AGHT+IGNOLfTiSfMRn+M4tw62En1bzCedWhazV44Vqap8ApoFH0f09yhQKfwE6kwSUKyFgXsPHn8Kkhbtx6mfg==
X-Received: from wmsr9.prod.google.com ([2002:a05:600c:8b09:b0:458:6a87:d662])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40da:b0:3b5:f7a3:3960 with SMTP id ffacd0b85a97d-3b7767765aemr9195924f8f.33.1753725220377;
 Mon, 28 Jul 2025 10:53:40 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:57 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-11-smostafa@google.com>
Subject: [PATCH v3 10/29] iommu/arm-smmu-v3: Move firmware probe to arm-smmu-v3-common
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

Move the FW probe functions to the common source.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 146 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 143 +----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 150 insertions(+), 142 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
index 6cd5187d62a1..835eeae3bf5e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
@@ -1,7 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/string_choices.h>
 #include <kunit/visibility.h>
 
@@ -12,6 +17,11 @@
 #define IIDR_PRODUCTID_ARM_MMU_600	0x483
 #define IIDR_PRODUCTID_ARM_MMU_700	0x487
 
+struct arm_smmu_option_prop {
+	u32 opt;
+	const char *prop;
+};
+
 static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -525,3 +535,139 @@ void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 		       smmu->base + ARM_SMMU_STRTAB_BASE);
 	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
+
+static struct arm_smmu_option_prop arm_smmu_options[] = {
+	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
+	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ 0, NULL},
+};
+
+static void parse_driver_options(struct arm_smmu_device *smmu)
+{
+	int i = 0;
+
+	do {
+		if (of_property_read_bool(smmu->dev->of_node,
+					  arm_smmu_options[i].prop)) {
+			smmu->options |= arm_smmu_options[i].opt;
+			dev_notice(smmu->dev, "option %s\n",
+				   arm_smmu_options[i].prop);
+		}
+	} while (arm_smmu_options[++i].opt);
+}
+
+#ifdef CONFIG_ACPI
+#ifdef CONFIG_TEGRA241_CMDQV
+static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
+						struct arm_smmu_device *smmu)
+{
+	const char *uid = kasprintf(GFP_KERNEL, "%u", node->identifier);
+	struct acpi_device *adev;
+
+	/* Look for an NVDA200C node whose _UID matches the SMMU node ID */
+	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
+	if (adev) {
+		/* Tegra241 CMDQV driver is responsible for put_device() */
+		smmu->impl_dev = &adev->dev;
+		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
+		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
+			 dev_name(smmu->impl_dev));
+	}
+	kfree(uid);
+}
+#else
+static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
+						struct arm_smmu_device *smmu)
+{
+}
+#endif
+
+static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
+				      struct arm_smmu_device *smmu)
+{
+	struct acpi_iort_smmu_v3 *iort_smmu =
+		(struct acpi_iort_smmu_v3 *)node->node_data;
+
+	switch (iort_smmu->model) {
+	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
+		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
+		break;
+	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
+		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		break;
+	case ACPI_IORT_SMMU_V3_GENERIC:
+		/*
+		 * Tegra241 implementation stores its SMMU options and impl_dev
+		 * in DSDT. Thus, go through the ACPI tables unconditionally.
+		 */
+		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
+		break;
+	}
+
+	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
+	return 0;
+}
+
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct acpi_iort_smmu_v3 *iort_smmu;
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node;
+
+	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
+
+	/* Retrieve SMMUv3 specific data */
+	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		smmu->features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		smmu->features |= ARM_SMMU_FEAT_HA;
+	}
+
+	return acpi_smmu_iort_probe_model(node, smmu);
+}
+#else
+static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+					     struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
+static int arm_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu)
+{
+	struct device *dev = &pdev->dev;
+	u32 cells;
+	int ret = -EINVAL;
+
+	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
+		dev_err(dev, "missing #iommu-cells property\n");
+	else if (cells != 1)
+		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
+	else
+		ret = 0;
+
+	parse_driver_options(smmu);
+
+	if (of_dma_is_coherent(dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	return ret;
+}
+
+int arm_smmu_fw_probe(struct platform_device *pdev,
+		      struct arm_smmu_device *smmu)
+{
+	if (smmu->dev->of_node)
+		return arm_smmu_device_dt_probe(pdev, smmu);
+	else
+		return arm_smmu_device_acpi_probe(pdev, smmu);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6e6ac64a5399..4cd0a115fc0e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -9,7 +9,6 @@
  * This driver is powered by bad coffee and bombay mix.
  */
 
-#include <linux/acpi.h>
 #include <linux/acpi_iort.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
@@ -19,12 +18,8 @@
 #include <linux/io-pgtable.h>
 #include <linux/module.h>
 #include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
-#include <linux/platform_device.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
@@ -67,20 +62,9 @@ static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
 	},
 };
 
-struct arm_smmu_option_prop {
-	u32 opt;
-	const char *prop;
-};
-
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
-static struct arm_smmu_option_prop arm_smmu_options[] = {
-	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
-	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
-	{ 0, NULL},
-};
-
 static const char * const event_str[] = {
 	[EVT_ID_BAD_STREAMID_CONFIG] = "C_BAD_STREAMID",
 	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
@@ -105,20 +89,6 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
-static void parse_driver_options(struct arm_smmu_device *smmu)
-{
-	int i = 0;
-
-	do {
-		if (of_property_read_bool(smmu->dev->of_node,
-						arm_smmu_options[i].prop)) {
-			smmu->options |= arm_smmu_options[i].opt;
-			dev_notice(smmu->dev, "option %s\n",
-				arm_smmu_options[i].prop);
-		}
-	} while (arm_smmu_options[++i].opt);
-}
-
 /* Low-level queue manipulation functions */
 static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 {
@@ -3987,113 +3957,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-#ifdef CONFIG_TEGRA241_CMDQV
-static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
-						struct arm_smmu_device *smmu)
-{
-	const char *uid = kasprintf(GFP_KERNEL, "%u", node->identifier);
-	struct acpi_device *adev;
-
-	/* Look for an NVDA200C node whose _UID matches the SMMU node ID */
-	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
-	if (adev) {
-		/* Tegra241 CMDQV driver is responsible for put_device() */
-		smmu->impl_dev = &adev->dev;
-		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
-		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
-			 dev_name(smmu->impl_dev));
-	}
-	kfree(uid);
-}
-#else
-static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
-						struct arm_smmu_device *smmu)
-{
-}
-#endif
-
-static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
-				      struct arm_smmu_device *smmu)
-{
-	struct acpi_iort_smmu_v3 *iort_smmu =
-		(struct acpi_iort_smmu_v3 *)node->node_data;
-
-	switch (iort_smmu->model) {
-	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
-		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
-		break;
-	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
-		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
-		break;
-	case ACPI_IORT_SMMU_V3_GENERIC:
-		/*
-		 * Tegra241 implementation stores its SMMU options and impl_dev
-		 * in DSDT. Thus, go through the ACPI tables unconditionally.
-		 */
-		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
-		break;
-	}
-
-	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
-	return 0;
-}
-
-static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-				      struct arm_smmu_device *smmu)
-{
-	struct acpi_iort_smmu_v3 *iort_smmu;
-	struct device *dev = smmu->dev;
-	struct acpi_iort_node *node;
-
-	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
-
-	/* Retrieve SMMUv3 specific data */
-	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
-
-	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
-		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
-
-	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
-	case IDR0_HTTU_ACCESS_DIRTY:
-		smmu->features |= ARM_SMMU_FEAT_HD;
-		fallthrough;
-	case IDR0_HTTU_ACCESS:
-		smmu->features |= ARM_SMMU_FEAT_HA;
-	}
-
-	return acpi_smmu_iort_probe_model(node, smmu);
-}
-#else
-static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-					     struct arm_smmu_device *smmu)
-{
-	return -ENODEV;
-}
-#endif
-
-static int arm_smmu_device_dt_probe(struct platform_device *pdev,
-				    struct arm_smmu_device *smmu)
-{
-	struct device *dev = &pdev->dev;
-	u32 cells;
-	int ret = -EINVAL;
-
-	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
-		dev_err(dev, "missing #iommu-cells property\n");
-	else if (cells != 1)
-		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
-	else
-		ret = 0;
-
-	parse_driver_options(smmu);
-
-	if (of_dma_is_coherent(dev->of_node))
-		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
-
-	return ret;
-}
-
 static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
 {
 	if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
@@ -4189,11 +4052,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	smmu->dev = dev;
 
-	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-	}
+	ret = arm_smmu_fw_probe(pdev, smmu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 09c1cf85cccc..787296a2f0c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -12,6 +12,7 @@
 #include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
@@ -561,6 +562,8 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
 			    size_t dwords, const char *name);
+int arm_smmu_fw_probe(struct platform_device *pdev,
+		      struct arm_smmu_device *smmu);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1.552.g942d659e1b-goog


