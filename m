Return-Path: <linux-kernel+bounces-882864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0FC2BBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316304F5CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E530CDBB;
	Mon,  3 Nov 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMqS4Eq3"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDF30CDB1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173247; cv=none; b=Y0MlLeI1AIk9RsjS61JsAeY0z3nUfs2U471/2Iy56BhHs26oG4BDLJQuNSOfAGnUb6h1td72BXGRyxvZBcjHkFJpBwB6iobpCvmdewrPi87Oz0tIReeC2K6dzX2ewiZEO8q7CP4vqXgVI91OdXiNB8t5XhHBHm9zC69kCyn4PRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173247; c=relaxed/simple;
	bh=vjkrYPoAZlHM7oLJ+7JDcEL1NOqCh0147DxJfPx6SrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8cyyVuY5ASG7elzR4zhp58FnSpyQgeDbb/k6s6ukX4wERP1plCLC+50M3yHKbqOCyUcoQbxY51tyH10MeJ6hlD2pw0beR9LhNlYErC43IUZnoM4JxicwpVKTOKfcITMhCahEulbW/9p4ttV9x8gBneW23PaamBJ1NbjbSWngbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMqS4Eq3; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c17b29f3so1896601f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173242; x=1762778042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ux05tU7+D0B7IZxmyew0p2paYr4GUNmlb17Kgdor7nc=;
        b=fMqS4Eq3HJp9zVaTcXRIialbtNgUgM18eQ1tx9Z39NHcEM/DQXAZapq2DberUzizcj
         vWTFpioo0hTknvYf+xco4qKNrJgN5FimXnhLsvnL0oTnKZ8JiXA1EsDRkNuzhfnkstC2
         5kydMoZ/TDMovzyhfAbFllnx+BgXjBC7nfLlinEl5gaGRJ5VRitKr/QhzF/1BnIF3JTZ
         AM4kkm15fZZ+WPZgpOKUlvD81B0ZbqxrwzGqcdWg6ZjiWnBkvWQW3dzH4T30RAtydMSa
         WJu0UqwZGJlKIKEMNliItkf6tpM2b0leluZZY067+thUrgwxx2pCjbjzjS1Ab5c2h8oi
         esQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173242; x=1762778042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux05tU7+D0B7IZxmyew0p2paYr4GUNmlb17Kgdor7nc=;
        b=pmSQ7FUACJMjlffXPiV72IFHSr+8eSo2znK2LDA0CxtRAtBjr/K0em/SXu4tyEgOj8
         0vSnLmSPjKpd3CYpnqDr0zI59mpAQ7I1k8tSoi/+9JIVACkRxKYh1BLAmK69JtDqa4x2
         HeJZXoV9G5I0ficeHgAcw3fk0DbsP/ONhoa0bRVaxDSWU0hCZgQonIYesQdn3acx0k3Q
         jxaHKAirzOPcCkTj0UV+RQGKaIXPXUbRq2TIMKNYKnFB8/5ofkwBVFEL4/bDFtfQd95u
         ihqS2cWjFSqCqumNfM7WoDkc80typY/kS/YenPLCxO+ay8a5LK51jX31FoME1ZWw0pOv
         A+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCV8zPMUhzb//gh9NntfoW7i/u5NA4xq8pnQRq9l1L0bqRRNl6yx3vtla+YmdS6Mo0Uu37z8Z/eUA+t7xpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sODuZ4mNVTPMZ+4a/E1PUJQfQmbRyvB49W+v3hp5ceZX4Plx
	L1jsQ3JkoxVXIs+MDlecaVNvirLwFKpcnGc/AAyssfX4Aol0kVl3VraPOmyd6fk3CW5PmEbOS/h
	mkznIyWp1TKMVvQ==
X-Google-Smtp-Source: AGHT+IGrApuZXSqW3lxjcwRKlTmVFlztNd2Jc9n1hjMR+iMt6HX4Z1G6N1X7IymUPj+PYiV5MnuQog6Tf7KgIg==
X-Received: from wmfv2.prod.google.com ([2002:a05:600c:15c2:b0:475:d804:bfd2])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2301:b0:429:bcd7:ac9f with SMTP id ffacd0b85a97d-429bd6ac60fmr10501171f8f.53.1762173242489;
 Mon, 03 Nov 2025 04:34:02 -0800 (PST)
Date: Mon,  3 Nov 2025 12:33:49 +0000
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103123355.1769093-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103123355.1769093-2-smostafa@google.com>
Subject: [PATCH v6 1/4] iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, if the selftest fails it prints a lot of information
about the page table (size, levels...) this requires access to many
internals, which has to be exposed in the next patch moving the
tests out.

Instead, we can simplify the print to only print the fmt and
for each test ias, oas and pgsize_bitmap are already printed.
That is enough to identify the failed case, and the rest can
be deduced from the code.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 41 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..7d6d7221f540 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1297,21 +1297,8 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
-}
-
-#define __FAIL(ops, i)	({						\
+#define __FAIL(i) ({							\
 		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
 		-EFAULT;						\
 })
 
@@ -1340,13 +1327,13 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		 * Empty page tables shouldn't provide any translations.
 		 */
 		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		/*
 		 * Distinct mappings of different granule sizes.
@@ -1359,16 +1346,16 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 					   IOMMU_READ | IOMMU_WRITE |
 					   IOMMU_NOEXEC | IOMMU_CACHE,
 					   GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			/* Overlapping mappings */
 			if (!ops->map_pages(ops, iova, iova + size, size, 1,
 					    IOMMU_READ | IOMMU_NOEXEC,
 					    GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			iova += SZ_1G;
 		}
@@ -1379,18 +1366,18 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			size = 1UL << j;
 
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			/* Remap full block */
 			if (ops->map_pages(ops, iova, iova, size, 1,
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			iova += SZ_1G;
 		}
@@ -1406,11 +1393,11 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				   IOMMU_READ | IOMMU_WRITE |
 				   IOMMU_NOEXEC | IOMMU_CACHE,
 				   GFP_KERNEL, &mapped))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 		if (mapped != size)
-			return __FAIL(ops, i);
+			return __FAIL(i);
 		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		free_io_pgtable_ops(ops);
 	}
-- 
2.51.1.930.gacf6e81ea2-goog


