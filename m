Return-Path: <linux-kernel+bounces-725292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162FAAFFD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590BF5886FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83D28F50F;
	Thu, 10 Jul 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SMdGDKMe"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6274290092
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137848; cv=none; b=BY2kBbtvtS8CuDy4bNaltILSrDxldWYWLGQXl6mQYMuzKWTL0V4zYXqpg7Yl5wwj3LHq4txsYVxBb5BAy+S/gER22FZrtutsA/JHCp19nGmV2m2LIUo20ZC1jWSrlxVE/c6StwEXJm/176igzY8XN9pTqWlE1GKqe42MoHgWszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137848; c=relaxed/simple;
	bh=2e7cipO2Wjm9I6n98Mbg+M1DHcoWVB2Xyn33ipE5d9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0WSva659WjO24PnMaUaGIlghQl1UPI2covrXSkgmBckLMIBiJy/04tKC9kdQQg9kBHJm2/MWC+FE7NLGGDuaTr3FHLVkjI4GM0F1+ZIQmzvzllZE4G8GqO/9gyu75WpMJOtyP+ubDSsJuL+wFcceWYXwPfUVcjgfgzvJqYYba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SMdGDKMe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so1612894b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137846; x=1752742646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS7oZDoGeD1L8wjMbt7OByfnbNqci5pMCt79WKJZtII=;
        b=SMdGDKMetW2S4VoRWhfwfsQBIFICn5kepaG5HqFMMa75ZMFzj+V63oTjoQS2pN/HNG
         MWg9BcMvPlddDnpOfVOVXngNk/IxMHxmFMfAnMvDHhzhSJW1nf4tuhM/7iupasDewI+K
         +ff6wJpBbuTq1D69NxoiVRGtaaVJ5DzESCI+G6eBNuKt1P04MVtmM+vGvrYAu6o/ynoG
         QOvM1HYgLX/bRVFEONbNaIDl0dPNITyVB+NiK4Ze0EmdL9zTJ9ylfn1JhmxeqQWp+1Km
         O1f4g2R5Q7KUTs75r9ytp/uiKY0fbqU8JN8NId3PeLq9bUltY1fjR5LQ7y3SaB7oQqcO
         HG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137846; x=1752742646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS7oZDoGeD1L8wjMbt7OByfnbNqci5pMCt79WKJZtII=;
        b=DfD5+VJThytAF8VDgGeuzfFneXE4WeqC/U2ubgLUxTYVAeMILPr7pEhvNAhAsueAxT
         jbC66j/9cflIz5rXJn/baVt1eN3zZYZ+EJJCk3WuaBJcOJk+kNBLQkivXITKfDCEMEBI
         tBS95etWlR1rWxugRFo/jtnkDnaxgLaIU5IFvQsai96nnw7fK/42coUzQVoaNHvT5NnI
         r7Ny99WiqQPKcw0VlFIf1ocHXXDR7C57LOnVGC2+8sV8jeDwHEiVrBlL3u74Mc3XvGKM
         TDB+Ov6Suj3WvDic6lvIWFjMAaVpPxcGK64v0HFc5dn3YQdhpGANvEmE33V9EjCK0nNb
         Fa5A==
X-Gm-Message-State: AOJu0Yw+mwV4vQjUeYlP8ijfvumFLUQ5zcVbXvD10QsnHAVk0LoaMz+/
	NBSugGp78cjMCvoZROvx3Kk7UPE20u/J/HAtJEBNEc6UU0Nr39wH/6UYYmFCRDMl/999r5G2pDC
	M41Xn
X-Gm-Gg: ASbGnctjZs2TvyoUNaQL3T5vih9N7+u+44XVl9qq9NbvsfDx6/IpCin6XAPVWEzQnkC
	1Xu7w0eKb33Jdw2xvmWP6glNaGmDBVSATsJwEOkmv+GiZyAHQGK3WWZ1Rz+ajBxSc/e3S5t88oc
	WOHIMTJ4a0aAvMHeZVdFgEJWN+pO7F7a3/SSiU3zY1YjLQgUw494iIGRkstZbQw9j5c8FhR5I2q
	TabmwH2Ahr0BPpQmsh8A9+lcrEDB9X7EJIZ2n7fsAAy2CtjTaPi9mM4hhlhXAcS90q4aHYin+/w
	fVh6Ara8En0WiN0mMToyoCWdzf7V34WEAwgGDZa6xVTf092Z6rPDZL1RiBnHZOtkA/1B8M8sA2V
	fc4zu1+0=
X-Google-Smtp-Source: AGHT+IHUdOd3Xm2iDHKE4tkW13G5yAQLxHKJQpWVcXGjXWDJYkcMmbOblQIeJliUDTeryLpJLtOVqQ==
X-Received: by 2002:a05:6a21:69c:b0:222:c9d0:7aac with SMTP id adf61e73a8af0-22fc4dfafddmr4472974637.15.1752137845826;
        Thu, 10 Jul 2025 01:57:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:25 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 3/3] iommu/riscv: Add ACPI support
Date: Thu, 10 Jul 2025 14:26:57 +0530
Message-ID: <20250710085657.2844330-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
RIMT data.

The changes at high level are,

a) Register the IOMMU with RIMT data structures.
b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
   for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
   the platform IOMMU uses MSIs.

[1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
 drivers/iommu/riscv/iommu.c          | 10 ++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 725e919b97ef..83a28c83f991 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -10,6 +10,8 @@
  *	Tomasz Jeznach <tjeznach@rivosinc.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -46,6 +48,7 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
+	struct irq_domain *msi_domain;
 	struct resource *res = NULL;
 	int vec, ret;
 
@@ -76,8 +79,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	switch (igs) {
 	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
 	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev_fwnode(dev))) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 
 		if (!dev_get_msi_domain(dev)) {
 			dev_warn(dev, "failed to find an MSI domain\n");
@@ -150,6 +158,12 @@ static const struct of_device_id riscv_iommu_of_match[] = {
 	{},
 };
 
+static const struct acpi_device_id riscv_iommu_acpi_match[] = {
+	{ "RSCV0004", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, riscv_iommu_acpi_match);
+
 static struct platform_driver riscv_iommu_platform_driver = {
 	.probe = riscv_iommu_platform_probe,
 	.remove = riscv_iommu_platform_remove,
@@ -158,6 +172,7 @@ static struct platform_driver riscv_iommu_platform_driver = {
 		.name = "riscv,iommu",
 		.of_match_table = riscv_iommu_of_match,
 		.suppress_bind_attrs = true,
+		.acpi_match_table = riscv_iommu_acpi_match,
 	},
 };
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bb57092ca901..45a263c9e0d5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -12,6 +12,8 @@
 
 #define pr_fmt(fmt) "riscv-iommu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -1651,6 +1653,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_iodir_off;
 	}
 
+	if (!acpi_disabled) {
+		rc = rimt_iommu_register(iommu->dev);
+		if (rc) {
+			dev_err_probe(iommu->dev, rc, "cannot register iommu with RIMT\n");
+			goto err_remove_sysfs;
+		}
+	}
+
 	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
 	if (rc) {
 		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
-- 
2.43.0


