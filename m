Return-Path: <linux-kernel+bounces-882866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B829DC2BBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 493594F620D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E5530E0D9;
	Mon,  3 Nov 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJZMGrJp"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5230E0CB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173248; cv=none; b=c1s+suzz3rxQqj6ADbCA1O3u0X/Xp/SlElFn3URMELTKLeJ6tf4LnmkB2aBhAh8w6E1WPXXu9KrqwXQJa+sCm7qDFE8FO8XI0JF2SxoUjujrpedXEjuESMjx2rqlx8cF0NtTUlLhowAPZMY+nEEhjBQCzNulZxQL9gV99fklDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173248; c=relaxed/simple;
	bh=EY2v8ftlRDhqQWW4H3Xk1bbgHzma4n1wHwx/sHkL/Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i6Y7miaTN7B2UWk8FF5iz9WVOEkI6IATjGrPt8JnIZeNgdxZjR58Y/o4t2WJSAW3j+s1MqcaJCmCDYHmzD8xTZA1lqAkwI2ZzMEuSits6Y0yHVHZcGz2EAc+gcwUbz5Mt1ehw+AQYeEDKeTmaPZzEzcV/bk2J90rK+OoKOETegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJZMGrJp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477212937eeso31012975e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173244; x=1762778044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eb5/iRLBLqsffznaL4L+fLHOh9qr7aNQqsvWygVRwbI=;
        b=EJZMGrJpUUFjxp/nIRtugFvwiE6P/VKKsFG6hIMXJWz59MB+PpqdEbxJye0jwybJhn
         myzfC7Z7nVgW3T9pLkpYIFyM19EVBUJdrDeeBx70IS4jXro5GHcgz5ZmxNFWkDvtnTlx
         odjIyssVLY6Ns4zQMyKOJhVLxf7fgrZ7qVk8ppMJLmy2PN8YJA3OTB7JTWIF1hN9p53Q
         3qgtLroT32ck0WUpW6Z1KAOUvhFugn3hI2AxoZjekma22fpDezaaXm2OoQQOZLKHY9oL
         dbxxPxUiZEGIDqk+lXDttXip5O4yLGFm4ehGfZPmg4sNcfZKi22tFOgFMwjjyr/KqTq9
         ehng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173244; x=1762778044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eb5/iRLBLqsffznaL4L+fLHOh9qr7aNQqsvWygVRwbI=;
        b=hsqWTg7bhlaMwQf/nfV0kpuzxFv9j406B11obkeIQQSYw4e/TV3Pzc+0jcie8+0lvQ
         ezGkkfkmVTIWcvpEDdBB2bwdp/UgCmcR5pmGhRpHHozjeY/KM1K+3A6AQqIxkQJNv3L8
         qkhSGzCwDKu9sk735h1whEzoyKX2Vw1C8nbKpmI2lSbvHEYhUsr3ByGiqKG5Htu6V0mg
         DUMgnh+eXxU2fPD/nHO7PsC0pHreX3CTY8k6xOeMw+6sJRgCo/SPkPIyYf9WcGUxlwyh
         c/TCpQHSX+3jN2TAPeBeiHCtlWh/bYzJuJqajn1Ue24zf0yRFtb0/hdW5RdfNY9pJ3zN
         /WNw==
X-Forwarded-Encrypted: i=1; AJvYcCUMvKgRaLdUFiYCZBze40IiySMDZPzEDYyOdefJYIE+Y8srWc95ZwT25Pdpevh7BkTeftsMYFe2Pwcx/Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaGb749+V8YJaxO8lFmZNKNSl7sI6AlCelOqKgJnNYAwFTY3n
	LfXsSanX9Vf9358abZGeHGiojhCyxHlGQDzZLi8Yk3oEyhr29BMSAACNUdOCkc4GMRvNZqROyf4
	yUMy3/ccnB8CZaw==
X-Google-Smtp-Source: AGHT+IEVmWefjtycrwY1ECoBVYWfmLjbUY7S32z2Glhi1U/9AlZNIJz93PqCys7M1yOpDXipEHbSZOCG4Dm05Q==
X-Received: from wmbdv10.prod.google.com ([2002:a05:600c:620a:b0:475:df4b:95a9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:530e:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-47751697433mr11754125e9.30.1762173244166;
 Mon, 03 Nov 2025 04:34:04 -0800 (PST)
Date: Mon,  3 Nov 2025 12:33:51 +0000
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103123355.1769093-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103123355.1769093-4-smostafa@google.com>
Subject: [PATCH v6 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
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
index 5da6d4b69920..8361d01b49c5 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -15,28 +15,28 @@
 
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
@@ -47,9 +47,9 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
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
@@ -150,15 +150,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
 
@@ -198,4 +198,12 @@ static int __init arm_lpae_do_selftests(void)
 
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
2.51.1.930.gacf6e81ea2-goog


