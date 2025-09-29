Return-Path: <linux-kernel+bounces-836496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71409BA9DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FD11C4B87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1430CB23;
	Mon, 29 Sep 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxyLzlVS"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57900307AC6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161014; cv=none; b=KAKaH9NWuxy2VooGjhzx0Df8qaO2SoU+LJurHNF2O0Z1p/QAyvGIsZsvj2vbn7A6xI7QOWJObtXgI5t/qyA5lMzAMZ7qjcaAE9ZdJjEXUKlDU/nLUmJQ4gi0oit+JHxcSn78ZPcHjtU9oIA5cgxCZVcGHLHrvgAauon3kRdYJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161014; c=relaxed/simple;
	bh=TL4oPh6meYp0II69UhIyt5mu/R9VyyO3WgVP9oaFG1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mm/vcJXDF3dgAF22BHa99cinw34C/1+Qv1eIW+PrBq2ZXnbdw12fcv2BXLc75fLBbjtmXbpsADDjdCG4OUY3oIq/139MyWZ1GoWsJwMfLiup6I1ihudXweLqjqALz+a9LrxCY8Yzi5t6ghY8SwQbbpNozwWbHte3C7qO48I7n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxyLzlVS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e303235e8so35087155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161011; x=1759765811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJHC5+QTP14fX//LZe/mxMEbJxRo0xwg0ar5poMq1uA=;
        b=HxyLzlVSl1hd6UD8BRhtgZtmJ8MN3cih4/bp4dlfOiAofgjMXvfbTI4IIBCSiqGxQ9
         Bbtjj7oI8oRw9bCxnle4xLuuiBp5VQvsXf7j/s2R6Cjx0Mzd/vztaiBofz8p06rkhiDh
         9hPveJ/mUk+NOXGw9h5wFIktJxpszQ4jppqi315pW/fD336j8bB4ujWYmI/0vUDWBAdj
         w3X6Oo0swO8DilUft7eouxKd5MY/1zRvw3dJqOKxNqsyS/00p9NS1fiurncTj3R9sN1S
         Oad7Q8vRJl5hDsWzbSPUUNHWbi7A/crEMcpHeRLgF51iJggfWVgoYXQoQeJBEnPNPexF
         GkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161011; x=1759765811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJHC5+QTP14fX//LZe/mxMEbJxRo0xwg0ar5poMq1uA=;
        b=W5WHuhAMQ4Tiyy/nTavzNJ0xeSFetrMxXsYjw+ryNBJnka/x9PUmONhlp7FFFD0+NI
         vyVssum3bkMdwbeGadoR3PLQ1ipvR9shLHC7H8eduszf6LqP/uF1wwqaE5E51zyxKKt6
         ImmsgijEw+HXYBuJ/cZr81mqkGK+cuFrPc9kqxYlw/449w02mcoBULYC0J+1PUx6umGp
         vEzD12wDhcNR52wQj/1Vi/HFfxNO4QQ7fvXWltHSsnAQ0IsHZ/RR4O4MhrgobBFWC2RG
         yPjEyjD97VDrG2xwvdNmRRZRhQZAhHuhlfMPG17tfkL077srTVdjwKs7VoTMjhOo8Tzs
         yqdA==
X-Forwarded-Encrypted: i=1; AJvYcCUvH+eQXdJNlZpXgwKW6sr1AheCrPZBrKwADx5nDU2AsNk9X214XCxG1KlZqcDhfKJ6vDiBNu5JDDl3DLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF862neL9U33Bb3AY/QrImpa6sfDJnNBdsZM9SljeOzTGpcquJ
	TAcG+g/MCar6sDMolG4vkw68quu47m93MI33T0wX6g4lD8PUwaYVbLfSpsS1ANI1g7g8+nk+OUn
	S0oFgtKTarKcj6g==
X-Google-Smtp-Source: AGHT+IGJdB4UkTz6NAZVLYJ2/soJK1B0n31V38CHkgl+oXUofMABzkVMr26Gvt6jH1taH1deIPwoc1q3Va7b8Q==
X-Received: from wmv18.prod.google.com ([2002:a05:600c:26d2:b0:46e:37a7:48c1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444d:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46e3299a5b5mr158005385e9.3.1759161010656;
 Mon, 29 Sep 2025 08:50:10 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:58 +0000
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-4-smostafa@google.com>
Subject: [PATCH v5 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Remove the __init constraint, as the test will be converted to KUnit,
it can run on-demand after later.

Also, as KUnit can be a module, make this test modular.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Kconfig                    |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 36 +++++++++++++++---------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..553522ef3ca9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -41,7 +41,7 @@ config IOMMU_IO_PGTABLE_LPAE
 	  up to 48-bits in size.
 
 config IOMMU_IO_PGTABLE_LPAE_SELFTEST
-	bool "LPAE selftests"
+	tristate "LPAE selftests"
 	depends on IOMMU_IO_PGTABLE_LPAE
 	help
 	  Enable self-tests for LPAE page table allocator. This performs
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 6ee5329c06c2..32c6a5c7af53 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -12,34 +12,34 @@
 
 #include "io-pgtable-arm.h"
 
-static struct io_pgtable_cfg *cfg_cookie __initdata;
+static struct io_pgtable_cfg *cfg_cookie;
 
-static void __init dummy_tlb_flush_all(void *cookie)
+static void dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
+static void dummy_tlb_flush(unsigned long iova, size_t size,
+			    size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t granule,
+			       void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
-static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
+static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+static void arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 {
 	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
 
@@ -53,9 +53,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 		-EFAULT;						\
 })
 
-static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 {
-	static const enum io_pgtable_fmt fmts[] __initconst = {
+	static const enum io_pgtable_fmt fmts[] = {
 		ARM_64_LPAE_S1,
 		ARM_64_LPAE_S2,
 	};
@@ -156,15 +156,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int __init arm_lpae_do_selftests(void)
+static int arm_lpae_do_selftests(void)
 {
-	static const unsigned long pgsize[] __initconst = {
+	static const unsigned long pgsize[] = {
 		SZ_4K | SZ_2M | SZ_1G,
 		SZ_16K | SZ_32M,
 		SZ_64K | SZ_512M,
 	};
 
-	static const unsigned int address_size[] __initconst = {
+	static const unsigned int address_size[] = {
 		32, 36, 40, 42, 44, 48,
 	};
 
@@ -204,4 +204,12 @@ static int __init arm_lpae_do_selftests(void)
 
 	return fail ? -EFAULT : 0;
 }
+
+static void arm_lpae_exit_selftests(void)
+{
+}
+
 subsys_initcall(arm_lpae_do_selftests);
+module_exit(arm_lpae_exit_selftests);
+MODULE_DESCRIPTION("io-pgtable-arm library selftest");
+MODULE_LICENSE("GPL");
-- 
2.51.0.536.g15c5d4f767-goog


