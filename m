Return-Path: <linux-kernel+bounces-772876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B5B298B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A83BEC32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCA271449;
	Mon, 18 Aug 2025 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ju2/2KRS"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A2270EC1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493112; cv=none; b=qJw6UHQIQFx0ECsP5/TBTzMk2bdhzkN4LvsI+J///RPNmhDllZWQBSXQgbob/5q2qiguDlh5kAgW5O3pO+G4U0XOr7UUqsRXlmr5I+WHdv/Y3uhz3l7FTZiWAjIXw+avs36qw70x3xIiqWbu4RorUYwt88b4Db1ZhanebqeelsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493112; c=relaxed/simple;
	bh=wOw6JV14X14ffQE6SMj0By+YxAglNmvsry080ZEuXl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zljhn91+UtnIBuIuJPIxs9YaDIvkaScrdn07/xnmrdC/7nwqA56e1H7seYPtsUKuiWIrdpt4R9r16AonhOv9/i1+SjngnaC9b5Z8uBP/qFCElIfa8jrcOcjJKTtNnM5uCflWTR9h/aYsgJuMfzqx6FZ+OvBx1rtFPFLq8kThlMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ju2/2KRS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so2714601b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493110; x=1756097910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTa6xqW99KKtlVHpIkJtLfUt2l8dIJi8RFcjVe+ZZ0s=;
        b=Ju2/2KRSAnlsMQsTEpOG97jDqzQc6JWLd1kPDt14HHF+hoT/d8tkfqD7dl2p4wYus5
         ObmgXq6ZImKnHvrl4ou9DWqQjb9s5tgeQ9aJZRfPEbMJ26HLMJmcTXbmpq78xnheHhAH
         wAVXcmXAW+6pLjDmsfmsQZqWAl/S9zSrtfKI146LVJt9S5zkb/ZU2zrd3kOXhDCW1y0Z
         pce/oeE24sV64ehI8zmDP2q/K6kgI1SYCirXlFBVn8fmxPyaK7gYd1gexocT43F9PZbc
         LYMLsvLC38rqBFal9+DPOhA68U98iNtGRIXb8RnfOS/tyrlRs9NfU7JQFtpJbMQIRVDE
         CxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493110; x=1756097910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTa6xqW99KKtlVHpIkJtLfUt2l8dIJi8RFcjVe+ZZ0s=;
        b=uthOcM3lm6mp/EctGIu6QMfIU+D3+4z+hRosS7waZ0BaCGjsGXRuUk303QOc1ciqmh
         DUva38mgU1XfUNmQR0VuB83EhCluvfN9sXClY4m2PxqFFb+tGGjk/DRdh/03tiyFmYGO
         BDLBFu9ZitUpIZxT3sZiApiYtjjawQjh3xhg+w7+zmWLYhbHf4NLHUeN5EZHRebDH/lh
         sShrQF5cNZkmehs+Jw3w3vhcfRMM/I5rj2Iir4JGsa5S61gR4vDTP6Qb/HCK2ImWanon
         G75TzGyOL8mhicPL0VimYVa4BezyBx1zcNSVTp+ps9coqVLHqrO+mX1oe3snsf/gBojL
         2m9w==
X-Gm-Message-State: AOJu0YxT94/sppUOUvvjoiliqrxBz17VYgP8lTSW3qW/+mOL1nSxcsg/
	ZvQe/V+FUSdYIAChikS6W785QXC7Qfr3egajuKn3IIbyN8roBeB0Tvt0hNHITPGQoe2iJxz61h3
	dbGLxw/8=
X-Gm-Gg: ASbGncsElE58681aPu8ijCp7UxffMEXAH6KvTPdGma11RVxXYCAW2OXxMowne2OlcMV
	19+VeBtsswo3Fr8IQI5HHIXFUKN9fpdZNEZIp7AAjd1N6lND5iux2Hqx6njYSuQmqlniAJqXv5Z
	qLFA1P4LiTRaz9hJMB6WZ8dGTt5NeFWekSKWoOq1G2XElGRijBvw10sPeF2DFIfO//Dc0yzRmIW
	P91+VDQ8QDEnNWVafO3r//S94sYD6rYmjzKQ2Co5wQW6UaIxJPG6rJZLFFR+HkH5pAvM8+IXLPM
	RikbJm86WNv4/rXWB+ZcRKngF50uFqbWgt4zDrDSzU3/5smZg5mtMDfCTjZc6NeOa/QLQMmDK57
	Jcol4K/eQ6DT373pV6YfCJAnVGswF77Rjlbj8FYyo
X-Google-Smtp-Source: AGHT+IGBQAQ9QouKj4M7l+2CqoGFg6HgZE82/OKBnQvuZfjFIYQJQta7bAXmxzrYRho/3qFml+C5sQ==
X-Received: by 2002:a05:6a20:3ca1:b0:240:265f:4eb0 with SMTP id adf61e73a8af0-240d300688bmr17338262637.4.1755493109991;
        Sun, 17 Aug 2025 21:58:29 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:29 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 3/3] iommu/riscv: Add ACPI support
Date: Mon, 18 Aug 2025 10:28:07 +0530
Message-ID: <20250818045807.763922-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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
index 2d0d31ba2886..7d9370aa58f0 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -12,6 +12,8 @@
 
 #define pr_fmt(fmt) "riscv-iommu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -1650,6 +1652,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
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


