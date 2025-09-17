Return-Path: <linux-kernel+bounces-821512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54127B81738
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E061C282A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89D30C0ED;
	Wed, 17 Sep 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fofED73X"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A282C11CA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136318; cv=none; b=b2OoNnJRJwYMoLIr2an8izNyJ+6Xob4j67QwAiYUJXhpiQXwJjtNDZ0/ZaKKohyVHuqpZs2PsxLOUV7KGYpReRI+XtXCQGQkHIhQU6q8VKtLIXbXurHR+dkTMromzAtaj9EhVE7B1QFjsUmCtl55scTYqAqHHvjEv8YfMmIkSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136318; c=relaxed/simple;
	bh=OXNC2NhJUIJ9sBeSJ2n+PhGJZrxOs7RFB/5bSZ9yPWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+sQIut9NwAVBrxOnEA31w6XuuwkyFP7rNYXSPaGeFIiQZkPmxeuGs45SuwLbljIbdLigib4Mx2dNmbhVzSmjYT2jjjm3SBj6vvPzioI5Mk6cJuJCNcYWwyL41dk5swAQenzSJfcSGYDnmN4LA0e9Gcp/vTG+lRDjV/JZGLLoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fofED73X; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so1314115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136315; x=1758741115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5kKzg8OPO0Cw4eskhZqcihDqdYuLltlJ6a6ZgtbvOg=;
        b=fofED73X6YE2fsuVIue5xURq/+ZRKerYTOOlE6mTefXuSaRLcpc4N4LvzM74QQGS6T
         arbGksHjMszMNYUQL/8gO+Q8LecH+lTwibd5HdccjFuQ0C7FOFVoj3cfhtaN8MlbP0Tl
         qkSzw3D/w8N0fzqtNkUnFMmKAAq99sWeoHrOpdP2rDjlekXMOf+CROYxWLVQ5+pxtuG5
         51rVv2Ql0l/t0zVBPaRNTx0oN4KzA/8pdaxzs6hagwnCA6aF1W6GLFBzIH13kMbr1sDB
         0yAxkliuyWSnTb1Gkt7/7vVtF00esr2E8l5arDjYHBZSxPNFvvZ/IPfqXsgSyav4ft7Y
         UmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136315; x=1758741115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5kKzg8OPO0Cw4eskhZqcihDqdYuLltlJ6a6ZgtbvOg=;
        b=jl/L9X5snEO+jnO5ra1Q73frhFsxsTlG6AkZtWbQqshWtylkdIMMrPhkIArOwBiZL6
         qaJc0SEjg03UwH+uGI/7XFtSiuCvBUKlA6nlnRzf7ZGLySWDMG494d2K93Jz4pFT0L1Q
         tv5EAiw/QK9YebDxvuqzV8i4wkur6miZS7yydQBTvQw4RdWUcZKZ71lW7t0dpCD+ytFR
         nO13Ni5yUMJvnjdHCZv5aJ9qDbVZ5T6iPHUFMg5A2XAS3orRe6gznbCYhen/YUdY28Jw
         mSObHJ80lZmLWi4Wa6nKQB7Qdu62VOOX0v2BKz8iq7G9ah2JacbmUlSkJLmaVBerT+J4
         jrNA==
X-Forwarded-Encrypted: i=1; AJvYcCWC3EJD2GscCKadqSZaFlkpjHIi/cYEV/Nz2Nt1v6OdUz0TiXM30NFBdCnxNEuM3m/g0ew5LQxhjmByUeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWxUzHyDZ9YUslmyJnJkuEkcwabFxXPz1AaXDpOwxT12DaTKT
	NSE/EOP51YifMwljmDT24euf+MeBfaiIngtejg5HqPta8KuVA6BIseyDcKq0JwbLxT2qOc/gbxu
	LaLLfFfCs6Td/kQ==
X-Google-Smtp-Source: AGHT+IFOU7LN1P9SI2vg/wWZstNB2r3hO1DClo1GN39AeEZT7OFuBcSCZpdcfIdpWCtlY2IVLQVavjRwLe6APw==
X-Received: from wmbbi16.prod.google.com ([2002:a05:600c:3d90:b0:45b:7fa6:f2ef])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:42c1:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-462d4ca0573mr19699685e9.18.1758136315274;
 Wed, 17 Sep 2025 12:11:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:11:39 +0000
In-Reply-To: <20250917191143.3847487-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917191143.3847487-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191143.3847487-3-smostafa@google.com>
Subject: [PATCH v2 2/3] iommu/io-pgtable-arm-selftests: Modularize the test
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the __init constraint, as the test will be converted to KUnit,
it can run on-demand after later.

Also, as KUnit can be a module, make this test modular.

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
index f7746ff2c7a0..5ac3e792c56d 100644
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
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
@@ -57,9 +57,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
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
@@ -160,15 +160,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
 
@@ -208,4 +208,12 @@ static int __init arm_lpae_do_selftests(void)
 
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
2.51.0.384.g4c02a37b29-goog


