Return-Path: <linux-kernel+bounces-733370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160EB073BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B27B9052
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FEE2F0059;
	Wed, 16 Jul 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nQbrva2j"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1C2F3C3D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662489; cv=none; b=d+xa/UQzlXhHw4nrpYzKO8fHqE2A+lnBSuakKt7QyKeabhn86MbIlPkdltZewKOFxOsuznhwLTY44fOmXmoEBwYHddQnwyRYq2czC3SoLRv7Ww29P/Wf1L9BTH5xlBAWxzzEoAiv1hFQm/LBT/HIH0M0XonAF9WZFVU8JEzw3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662489; c=relaxed/simple;
	bh=TiMCJ1JIsrrw0j8yUw5lr7+dQqDn3hFgscmUJMRLbPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL63NPACYig+yJIggAm8KrN1Dt3iF3l4SpeKel5zUGqQXtfeTZUZtpfigArD9BwN4Xm1vAqWX0Qk3tR405lW7XtcMi1RljUI4lce/kkd7ozVzgbE77f+vYTciuADXDYqLqkTFozbWx8cIb/KzE+eWKgw1NrxqHjPc3Eq1KabDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nQbrva2j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so747551b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662487; x=1753267287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZUWpBwM0eiM3bQczAhHsGr1w4CoIgRijBa2HvAnStE=;
        b=nQbrva2jVKMH0EVWBryyuW8RkZH9yy+RrrLkEXAXb42ZapRnbM2HxvPFWCZH+RDUmW
         AR/p/QdPqzEDxFz+zzT5fN1WS+D0K9ZXVZrVaewWy+8zVmzCXGbgTlvvGL4rf/I8Nx/O
         WvY+z6bIgeuSujSARbtUFEP+moe5ZETbUUNcFjJS9OItXUO4vk2+lD+7Zzz1eIy7LhLy
         2GldHUJHXiJ47oH0UGpza3Jkuwn0n1TkcqNOGI+JjgTHBJzqhlGcP9AFEf+3Hv5VpED4
         lw6/BrJ68IrGDMBODQu3VWgyIAq7ZpfBFPAoiPHm9Wr1DEJxpa877Q8ydDPzPkaafZp2
         y5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662487; x=1753267287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZUWpBwM0eiM3bQczAhHsGr1w4CoIgRijBa2HvAnStE=;
        b=snKsyqZjAbFJzNMA2YpvK58+NYPrYkQX7sx/SCLQomgy8gX+7Usg8nvSPCbGNghHOJ
         Qtt3ETcJOVj8R6qsFNyhwSZezGtRImchkxhqkOY005xoBfYZO2KhhvhfBc2xDE3+3yf5
         fgJubEKMgeHbMostIFMPu1Q345+YLY1litQ+TUi2MjMf8YMbTHSJJb8YS5slFPveDmg9
         N5GXJPwE/ZvrWK/bHGUGQijTHSqDxVVcZQJJ5tOWhyKP7uTVpVzqWha0jTgVcORoIrhr
         fn0Kl1k6WcRuU2iOS3m6GCrWU98Qfizm7GrxggrjBy3cDLx2oGERhN+VfwIbLanG6lIh
         I7Ww==
X-Gm-Message-State: AOJu0YxVe2GZoHKq42hniCdCLt1Zayw4jmWVlrHsp9O4iIUDALegK8eS
	lGJZoMHTbotNBFlax5eNuzrnUUSHc+A1MdFNvCzb4s6va8mT9S5bO4huZue07uMkE0TB/e99uaB
	Oob7Wyg0=
X-Gm-Gg: ASbGnctkpoPdwCLuX1auWO+/MWhpCdKFOxmcoNlh/R9W7JAY/VSQWwawgAY/LbO8mML
	uy3BqnVewHLYBoivSd1fOci5Q35h5bXvmEphUk76H0muaNv5asbXEkwCv/k8GsG333qWknHi0b0
	M935vcbAIsf8CNSIHi2BKFNcDjpr1qTTdPfHEmYgw0aEemI+qbXM4ChbaoJsZoOETS0rj+Qw1v6
	dLHiTYwSMdxaAFyhuimt4IZOQ+Yngxr1IwC0RVvMd/mTJRxt54FK1O7TvSx9tjZH9WqK2Fx2aX3
	Zg6ohrouuMw74SOy7MVtXtiLFbB3FgzL0nyJoJnNtfFVdcY8lWBxCQnQ5W6ESst+qIGOEVm4qdF
	XLoZU2E+tvjyK7vchZiTY5KryHJu0XNOZ
X-Google-Smtp-Source: AGHT+IH/Lk91h2N/FwA9EAOD0yJlQtTfyDy3TLsMiePhmK16NWxXzdzTp0ubA0n3RaF6EsVZf8LtAg==
X-Received: by 2002:a05:6a00:ad0:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-75584eb932emr9392926b3a.10.1752662487002;
        Wed, 16 Jul 2025 03:41:27 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:26 -0700 (PDT)
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
Subject: [PATCH v5 3/3] iommu/riscv: Add ACPI support
Date: Wed, 16 Jul 2025 16:10:59 +0530
Message-ID: <20250716104059.3539482-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
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
Acked-by: Will Deacon <will@kernel.org>
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


