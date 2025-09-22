Return-Path: <linux-kernel+bounces-826931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B04B8FAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A861893770
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB862877FE;
	Mon, 22 Sep 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5+lHPAH"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583E286893
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531611; cv=none; b=A1Z+lTAVgvD+StduTfnFcmaxy4LvJTgZeIoHdug+nQNYnrdG+nCXELNgy56ymmiYRXLxlBZvSdxTOQvLlLC1O2RoyBdqdwu8YoqmuIfJlcYiT95vJpnBC+rTd0fVmaSMQJLFWMggImk6VZLhJn1L3w4QNWbgYsojOW3S2hELD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531611; c=relaxed/simple;
	bh=EcV5Ud4O7dddqV6D+cceP3QOprSQAHvyeSV8revOdpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQBlHx4cLucTcVpytDfPolS4tCzWw6QdCXrljEXz5vXWpBlSTVxm/h7EOuM6OMwB7ILBav/wBP+xwaPAbaMaty/j8JltVhMtYeW/vKfYKfw/9v3PfQSms8MJbyfqUFX1UykhuzidBH4B72iZiq7kDP4ayDOy+q0Pzbw8QAJTULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5+lHPAH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46b15e6f227so5218645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531608; x=1759136408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxsHa5a/TnumwuS8wGt++Dj39uNGV0RG0Oz4S0LjiTY=;
        b=e5+lHPAHWwzQUcvPJUTVszNIPXnz1WzdlCrN9ONVepReVEdD3qbwfpfaFFzOU1SH2e
         zVCgKDXY6R4jtK8IObfkNM00hmAaMjS8i3itKEG7eTfETCGcVoM8hUxxFvBPvD+7srYL
         XnaW/uQNQ/GODkPYHxOUqEsXYVKXyyR7fK/YD6wM8bB/F/RjxGM9//aUscWSihBq0MQj
         Mm8BvNJ7vJZ8/56l5O9o73re9l5CgOSp9DwYtaJITEJaSyXrWrOWsK6vG5uiL/oGZAsE
         izGOTUxRGJpYYLsnQyXyvzTyAwihnp6QQVh6fk7qvpF+fniesLd4DpFaU9nQfCr+Ez+Z
         SDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531608; x=1759136408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxsHa5a/TnumwuS8wGt++Dj39uNGV0RG0Oz4S0LjiTY=;
        b=ra1fqGotkwmnpoBmBjZIIAjMZxuLY/8CDyjnyo9NY1AJ5vE7aAvEk29hAeE4W5Qjw5
         jnl/xnuObQppPAouWRFaIhj7ecwztcQsCv6SGVyLW+nwh8ok5DbdK5X9EsA9UHn5jGeX
         4xR4vdkXUJBT4cGifoxxufKs8wrCqxEogfKFdF1exLbSeDRnhehtrdHvMcduaxiGfiOS
         wlgLS7bA+4mmJZP8bd97WUw6H1Dxy5I3DYwvbGzCKOQcfa1dnasEprrWnF6xsAMIcr11
         bkQ1OYgvlVi/xgrq9B3tp4ofOa/qOkFo33HKPDpuFlsrW33uZXuxJK5aUHQYdi5PKW1W
         K73A==
X-Forwarded-Encrypted: i=1; AJvYcCX/khMGnb8cdZNilOnaKn0Cw/ThNsEc+9D+4YF0AVIW3Nl7bac7/suZ7brEQnNaM1fTqzjsIRQF5sSdSl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7hwepfnxKxNpaQkAZceb9Af+17+/jXOWhPZr52EGAxoq3UDU
	n1bf5zD1D9/CDIIkxO0rJxpyO7rKMokIturNMcQgj8sMsj+IDusl9virZcCaN90qeo8RcGnMPV6
	AsQw5Z5/PeIbyJg==
X-Google-Smtp-Source: AGHT+IHget1O4BPqdwANeAahSQkK78lrpcEF2/nHFiBWfVpUCmbTfdZneqa7756vBxWSeKVk9F/QEVfsPjcQ4A==
X-Received: from wmcn18-n1.prod.google.com ([2002:a05:600c:c0d2:10b0:45b:7262:8426])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5491:b0:45d:d5df:ab39 with SMTP id 5b1f17b1804b1-467f2cc83afmr101921075e9.26.1758531608493;
 Mon, 22 Sep 2025 02:00:08 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:27 +0000
In-Reply-To: <20250922090003.686704-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922090003.686704-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-4-smostafa@google.com>
Subject: [PATCH v4 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
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
index 17f48216647c..50350e88d9b4 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -13,34 +13,34 @@
 
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
 
@@ -54,9 +54,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
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
@@ -157,15 +157,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
 
@@ -205,4 +205,12 @@ static int __init arm_lpae_do_selftests(void)
 
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
2.51.0.534.gc79095c0ca-goog


