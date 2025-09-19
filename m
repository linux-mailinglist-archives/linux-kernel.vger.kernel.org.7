Return-Path: <linux-kernel+bounces-824624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E88B89B06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E6580B12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0EA311C2D;
	Fri, 19 Sep 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFZ4urbM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7830F94F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288806; cv=none; b=fZ7ZcUcqB0MxvGUMnHEy0NB9wIbEtTjVO7Fgbm2i++qu8Q5U5+cWZ6r+i1FjV5oqsQB9u3t2/IPm5Kk2u7g2MFihGasnPgPjErdu89sPSb+0FT907jwmQZCk6QSl6JmBV+YEUim6SVbcFt2odvrlXucW5D1nZKtVIhWzVm7w2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288806; c=relaxed/simple;
	bh=7oXYl5Po4AjfBd/5rYjBxuYp+0gnhDH956S33u0vZDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qBgCdgJUN6kVjKUBZlCVt0R5OXCDWCY9KAIN4uWfe8mZKviK8M9Shyc83QQevpFVCMiLiO4tRvD2LODc1jKHJMlwASckTnuu3MfLw9Gjy4WQl+qwOeIE57cHMXOFcRx9QnKUW5ZJ7I4Tm6y+SA7t6xS758E9+m2qRJS1I25BJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFZ4urbM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so17157745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758288803; x=1758893603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+B9Rd0QSKX3f0a8GqzDwyxDt6n7MbipsBAu2cM0NNI=;
        b=OFZ4urbMJNa5d4cd56Os67V9LzAPs5uLoqJs05/sXa2xnOUq1vZTHh29DTNKwjIbnL
         MaMpN7dz5vmrepS+iW0LD962FTRvGq4mDlyVlYrLcVVqhDJ20F610DNcxd5CUH0qjQ67
         0B696/x43XR9T/9PmtHK65bWJoSIFcS/7yZHRwvvn8JU1fd7IPV0dIDDA07PCOOvm2G2
         jt8nADDqUbrE7eAF+Fn/70aLYuoRw8/fhFIt27UnkjezByTrVurYE7Cu2aj4puoGCB0t
         GphkorWhWGwYkjYcdDo3IMURRF58D0bRnxXtqZbykPZRsldoNuLyVLbcQmtwIrEKOYpe
         Yrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288803; x=1758893603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+B9Rd0QSKX3f0a8GqzDwyxDt6n7MbipsBAu2cM0NNI=;
        b=JpMc/9hWHAN0bFSt4kShim6Ng/1gndTA54nmSK0wgWHoEF6x0WbFp7UzgnMoqYokTn
         V7Dxy3yAW9X3Mndgos1u89MUcxdN5Bplgv7f5RAgk4e9UALp2d6wdzU0KlmldBvjyZyY
         J1Tk55smM9tI7sIf1wN//ZKYlPnUfq7pF9yVAWpf5Yt31BjMvVYEDPnEAChnEc4xVtI7
         TZRwiC3BWYd0eCacsaJfuolHA9x16wVatMoxgaQJsbe1Xv6b1nMPCBcE2MqA2c7xPSHe
         NDwFTGQLO98sTgXOjpzx78lWEkbio5mbcTM8DqvOURNvHo646klWyyef5HcK9hBRS0ft
         NY2A==
X-Forwarded-Encrypted: i=1; AJvYcCX5uhPtHTZtA/AjTC5PjdMKpXqqmTxXV1mPrbsfobIWbDcIfNqfZFVWCPD9zKoFDwRaR085hI7v37bOZqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzL9uNPpCF6riIsTi3r86aLJ3VpQMG9njOBiZylUUOkORFAgqj
	4nfVzYZMlvjJjkcedNZkoH+Sp2hqdXZUe9ZwojYmwC/RXMSkRMk5mPkfLknDPurxH+jUyOQVdw3
	PPAkRmPs18v1kng==
X-Google-Smtp-Source: AGHT+IHgv9Oc1Q90zGIOvBR/gtnADwG6axckvKn1MbwYC6fQkHZhHVTfgauS5SWZ9dYzPTFs0YjJunsuQ96/hQ==
X-Received: from wmbeq6.prod.google.com ([2002:a05:600c:8486:b0:45d:e59b:2eb0])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3595:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-467f00c5fd6mr42464245e9.24.1758288803025;
 Fri, 19 Sep 2025 06:33:23 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:33:12 +0000
In-Reply-To: <20250919133316.2741279-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919133316.2741279-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919133316.2741279-4-smostafa@google.com>
Subject: [PATCH v3 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
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
 drivers/iommu/io-pgtable-arm-selftests.c | 34 +++++++++++++++---------
 2 files changed, 22 insertions(+), 14 deletions(-)

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
index 17f48216647c..4c3dee4ba895 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -13,28 +13,28 @@
 
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


