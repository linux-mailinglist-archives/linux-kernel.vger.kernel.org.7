Return-Path: <linux-kernel+bounces-817702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E00B58582
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A401AA2934
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9FB28A705;
	Mon, 15 Sep 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOiD94Vs"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE0288C2C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965947; cv=none; b=kBzrKvVX7mLql33kbjhPx4HAWGWfCL4kbFBCpxuEkrlgYLGSimmBZyAIwwNylxKmk670NbTiHCehSlxArV5cI/rEEYBOMsCsUVpGTxhL3fZk9faYw4cXOhsdacRsFMlJ9ITJgi8BPhE5Y1C+IEn0lB3pB3Mz0OpB3mfFuiYpg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965947; c=relaxed/simple;
	bh=q3V3MsJ7DztIP8fpon5vJbX30D6R7q52PZAummA8iI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=at4XqzT9D3g8iXmOwDlTwAU/+VAGFU0pVw8DRrDIFs7WLm5HEIsbErG8j7tRXfHfPSWwBzGNZN27rzXcZhFzc+m7LtFBy7r+w+49uqKSWw4OTk7UaWztsHB7Zhwjk3f2zpGr9hps9j9MDx0fnANNWiCPTQs5XY/bTC7rsnGVzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOiD94Vs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2641084fb5aso17846135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965944; x=1758570744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg42YXvjHFhdSPyd/4e9YIQchkUAG0NxSAV9DDvIrlA=;
        b=gOiD94Vsid3c9lQXwjmmC9/m+CbfuYPbM0QnsKNrAIe08z/SKY4VGs7NANbeLmMt5W
         KGyNGWQAlPKTV8vWk19bIQSCBpRhRq1eiXpzCQ9jwK4l0kMdgw+SBI3MsSgfeBHM6hrT
         LlP7b/kKlLkkPgA3Bbvi55Egs/prUXIDyvKyzRbyEHfwzTIDpx9Hw/ufiTk5q7EY6fdj
         628bqhJFYsY2VJwMTDJdmbThlRK5BW2vEJKKYWgQLlVYEq3H+vfBwTO3Q56ey5++XLhO
         x1GwJjNRUUxzeMDR6bOmABaRwE/VqcDxfcXIL7M4CcCEF46IbdFgYlhtZN0rKKGM9Ty3
         Dzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965944; x=1758570744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg42YXvjHFhdSPyd/4e9YIQchkUAG0NxSAV9DDvIrlA=;
        b=IQxZmzAZpRgnM7KLe91rKZ2p4HYnKa3XtehpTmJjHssTdm81jTV0KZD0lPAg5OFZgy
         QPvCoGWbVbXJOPD6xCdx1p/WdWIVOen+QMZ7Vx4YEFqlQn2NObnp2RI4ZeeIMDRW/Ugy
         1YZDFklmaJP2VOxNoj45Ub1hj1+C0E6BC0VeuZndAlAwm0jKV1PH4xiPO7aib+Vj6Hux
         L0PF36BeW2sW8dnQEMZmL5S32sEX1x71qdLaB0ApvCHxqUOQehZroceruxPTxsCZ2h1H
         mxnSkAmyssB5ItWsJYePx018m0gAP4wwx2s7tx9eMXmVxLMOiG3APDlwWeEMWj3LqXZX
         o3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVuw8RC6UbpV0diBOfiPfj1eBf2XXuv3d4WGQXCN7kodnQ0ym/0+0aPMm3Rs9Qv9DYE7MNQyAYG8V074ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSK2npyw8o//LdF6Ljxz2N1huT/lqzws9V62PL2ezI5/J7Vrxs
	O6VMgrQZegNOysjHy6L5GfG7CRLnJoO3eFwPr31LMQ7XF8OSvEWRO/YPEqzLzHx55020YJkZ2Q=
	=
X-Google-Smtp-Source: AGHT+IFLZf3/R1udLdGzfNx7SuklFJxoiGyP5wz+2NArO8lgYrlOW7Rh8Rc5osSmdBqt/k2sJfzU7IDn
X-Received: from pjn16.prod.google.com ([2002:a17:90b:5710:b0:32d:d956:20fb])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228f:b0:24c:be1f:c204
 with SMTP id d9443c01a7336-25d24da3763mr151368475ad.22.1757965944068; Mon, 15
 Sep 2025 12:52:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:45 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-5-fvdl@google.com>
Subject: [RFC PATCH 04/12] mm/cma: keep a global sorted list of CMA ranges
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to walk through CMA areas efficiently, it is useful
to keep a global sorted list of ranges.

Create this list when activating the areas.

Since users of this list may want to reference the CMA area
the range came from, there needs to be a link from the range
to that area. So, store a pointer to the CMA structure in
the cma_memrange structure. This also reduces the number
of arguments to a few internal functions.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/cma.c | 72 ++++++++++++++++++++++++++++++++++++++++++--------------
 mm/cma.h |  6 ++---
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 00d8d365f0b5..1f5a7bfc9152 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -23,6 +23,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/sort.h>
 #include <linux/log2.h>
 #include <linux/cma.h>
 #include <linux/highmem.h>
@@ -65,12 +66,11 @@ static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
  * Find the offset of the base PFN from the specified align_order.
  * The value returned is represented in order_per_bits.
  */
-static unsigned long cma_bitmap_aligned_offset(const struct cma *cma,
-					       const struct cma_memrange *cmr,
+static unsigned long cma_bitmap_aligned_offset(const struct cma_memrange *cmr,
 					       unsigned int align_order)
 {
 	return (cmr->base_pfn & ((1UL << align_order) - 1))
-		>> cma->order_per_bit;
+		>> cmr->cma->order_per_bit;
 }
 
 static unsigned long cma_bitmap_pages_to_bits(const struct cma *cma,
@@ -79,11 +79,12 @@ static unsigned long cma_bitmap_pages_to_bits(const struct cma *cma,
 	return ALIGN(pages, 1UL << cma->order_per_bit) >> cma->order_per_bit;
 }
 
-static void cma_clear_bitmap(struct cma *cma, const struct cma_memrange *cmr,
+static void cma_clear_bitmap(const struct cma_memrange *cmr,
 			     unsigned long pfn, unsigned long count)
 {
 	unsigned long bitmap_no, bitmap_count;
 	unsigned long flags;
+	struct cma *cma = cmr->cma;
 
 	bitmap_no = (pfn - cmr->base_pfn) >> cma->order_per_bit;
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
@@ -147,8 +148,7 @@ static void __init cma_activate_area(struct cma *cma)
 	for (allocrange = 0; allocrange < cma->nranges; allocrange++) {
 		cmr = &cma->ranges[allocrange];
 		early_pfn[allocrange] = cmr->early_pfn;
-		cmr->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma, cmr),
-					    GFP_KERNEL);
+		cmr->bitmap = bitmap_zalloc(cma_bitmap_maxno(cmr), GFP_KERNEL);
 		if (!cmr->bitmap)
 			goto cleanup;
 	}
@@ -199,12 +199,45 @@ static void __init cma_activate_area(struct cma *cma)
 	pr_err("CMA area %s could not be activated\n", cma->name);
 }
 
+static struct cma_memrange **cma_ranges;
+static int cma_nranges;
+
+static int cmprange(const void *a, const void *b)
+{
+	struct cma_memrange *r1, *r2;
+
+	r1 = *(struct cma_memrange **)a;
+	r2 = *(struct cma_memrange **)b;
+
+	if (r1->base_pfn < r2->base_pfn)
+		return -1;
+	return r1->base_pfn - r2->base_pfn;
+}
+
 static int __init cma_init_reserved_areas(void)
 {
-	int i;
+	int i, r, nranges;
+	struct cma *cma;
+	struct cma_memrange *cmr;
+
+	nranges = 0;
+	for (i = 0; i < cma_area_count; i++) {
+		cma = &cma_areas[i];
+		nranges += cma->nranges;
+		cma_activate_area(cma);
+	}
+
+	cma_ranges = kcalloc(nranges, sizeof(*cma_ranges), GFP_KERNEL);
+	cma_nranges = 0;
+	for (i = 0; i < cma_area_count; i++) {
+		cma = &cma_areas[i];
+		for (r = 0; r < cma->nranges; r++) {
+			cmr = &cma->ranges[r];
+			cma_ranges[cma_nranges++] = cmr;
+		}
+	}
 
-	for (i = 0; i < cma_area_count; i++)
-		cma_activate_area(&cma_areas[i]);
+	sort(cma_ranges, cma_nranges, sizeof(*cma_ranges), cmprange, NULL);
 
 	return 0;
 }
@@ -297,6 +330,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	cma->ranges[0].base_pfn = PFN_DOWN(base);
 	cma->ranges[0].early_pfn = PFN_DOWN(base);
 	cma->ranges[0].count = cma->count;
+	cma->ranges[0].cma = cma;
 	cma->nranges = 1;
 	cma->nid = NUMA_NO_NODE;
 
@@ -687,6 +721,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		cmrp->base_pfn = PHYS_PFN(mlp->base);
 		cmrp->early_pfn = cmrp->base_pfn;
 		cmrp->count = size >> PAGE_SHIFT;
+		cmrp->cma = cma;
 
 		sizeleft -= size;
 		if (sizeleft == 0)
@@ -772,7 +807,7 @@ static void cma_debug_show_areas(struct cma *cma)
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
 
-		nbits = cma_bitmap_maxno(cma, cmr);
+		nbits = cma_bitmap_maxno(cmr);
 
 		pr_info("range %d: ", r);
 		for_each_clear_bitrange(start, end, cmr->bitmap, nbits) {
@@ -786,9 +821,9 @@ static void cma_debug_show_areas(struct cma *cma)
 	spin_unlock_irq(&cma->lock);
 }
 
-static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
-				unsigned long count, unsigned int align,
-				struct page **pagep, gfp_t gfp)
+static int cma_range_alloc(struct cma_memrange *cmr,
+			   unsigned long count, unsigned int align,
+			   struct page **pagep, gfp_t gfp)
 {
 	unsigned long mask, offset;
 	unsigned long pfn = -1;
@@ -796,10 +831,11 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
 	int ret = -EBUSY;
 	struct page *page = NULL;
+	struct cma *cma = cmr->cma;
 
 	mask = cma_bitmap_aligned_mask(cma, align);
-	offset = cma_bitmap_aligned_offset(cma, cmr, align);
-	bitmap_maxno = cma_bitmap_maxno(cma, cmr);
+	offset = cma_bitmap_aligned_offset(cmr, align);
+	bitmap_maxno = cma_bitmap_maxno(cmr);
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
@@ -840,7 +876,7 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 			break;
 		}
 
-		cma_clear_bitmap(cma, cmr, pfn, count);
+		cma_clear_bitmap(cmr, pfn, count);
 		if (ret != -EBUSY)
 			break;
 
@@ -879,7 +915,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	for (r = 0; r < cma->nranges; r++) {
 		page = NULL;
 
-		ret = cma_range_alloc(cma, &cma->ranges[r], count, align,
+		ret = cma_range_alloc(&cma->ranges[r], count, align,
 				       &page, gfp);
 		if (ret != -EBUSY || page)
 			break;
@@ -1011,7 +1047,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 		return false;
 
 	free_contig_range(pfn, count);
-	cma_clear_bitmap(cma, cmr, pfn, count);
+	cma_clear_bitmap(cmr, pfn, count);
 	cma_sysfs_account_release_pages(cma, count);
 	trace_cma_release(cma->name, pfn, pages, count);
 
diff --git a/mm/cma.h b/mm/cma.h
index 25b696774c6a..384d1109d438 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -30,6 +30,7 @@ struct cma_memrange {
 		unsigned long early_pfn;
 		unsigned long *bitmap;
 	};
+	struct cma *cma;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct debugfs_u32_array dfs_bitmap;
 #endif
@@ -67,10 +68,9 @@ struct cma {
 extern struct cma cma_areas[MAX_CMA_AREAS];
 extern unsigned int cma_area_count;
 
-static inline unsigned long cma_bitmap_maxno(struct cma *cma,
-		struct cma_memrange *cmr)
+static inline unsigned long cma_bitmap_maxno(struct cma_memrange *cmr)
 {
-	return cmr->count >> cma->order_per_bit;
+	return cmr->count >> cmr->cma->order_per_bit;
 }
 
 #ifdef CONFIG_CMA_SYSFS
-- 
2.51.0.384.g4c02a37b29-goog


