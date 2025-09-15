Return-Path: <linux-kernel+bounces-817703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 118D1B58583
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C52B1AA30BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E32874E1;
	Mon, 15 Sep 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGGCLwc4"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B2289367
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965948; cv=none; b=rGMW3VmN24vmsXhz18Py146U/mfBmWtvxddCL/W4bf9IafuEujROYYtuhvyKX5NwULD7e3P8c3WWIRUv0jLOGy+hgqbZHWv5zQUrC/ea3BcFNwQzZFL8NQm0Q1FAJfJgmnKWhpTmHwR8pwe0ZchhjQvz+DkyRX9tWV81SBPV75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965948; c=relaxed/simple;
	bh=8LKRYHLCAZTJKnDKNFoSC4CZNzre4T6N3gX2Sm3PQrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRodtMaefsokpUikcVQ7Zw1eoJy6jmPoAjjGsCFP+V4GZ03mhSChvhmLrJivoi/oWh0JsT6mu7jX3NpfipMaMhrRxk9FdW8/X3miH+3UMVcSMQhtxyFWqqw0QaQ+ih82zBCmkfYp2FFDxAJH71YCkYXuBYycnIDWFklWgux3IYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGGCLwc4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4d3ab49a66so6505489a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965946; x=1758570746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HSCepCK3t1UxBnW9wh+oSKVJTG/pFFOaZ/Yho235Fc=;
        b=FGGCLwc4xUJXsIPuHKn/+edeY+TnfqIYX7w5Y9N1d08V2ePyMn9jsZ9H0Wm5HfiSnL
         uX6PjjhdDx4YZwlGBpCGr+1s4frnBaDOClVcODpphKuWWiH9UfIHb8HLrxQyfSi8w69f
         iexPZlfJogqPu23axMN2IIZdZ0AuMh2V7CoCmlK3e1l/mnI0SaIYawqDoWnBG5sFGVE/
         9l/MCFWp6Tccgw6IwqfEHvSiAgyyLc7Txidr4tssgz58yZ1YkP+une4J1IMHZln1TNFl
         I2RgJ6tWR9O4bwOXW9ohN5RvosTSzk9dDjAx64krFTvE43ClEC3SVJnEPjCuB/Yx8XMS
         Jjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965946; x=1758570746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HSCepCK3t1UxBnW9wh+oSKVJTG/pFFOaZ/Yho235Fc=;
        b=SZovL4VwpGpGq87S0bmrMyRIzowZohd/K1MZnonRVehTBDGs2kGfkYr2VMnLvAKVSx
         hoNYVN8eLjCRgehhahfD1hArPrjgXS9Licw6pcqP1xf9GR81yVp54X1HnRWDNy8/WS+o
         uhyBeys2thff6F4T4gvbF1WO0kZt1K+yO8QZ+yWYwOPalSXS4kIF99JzzWOlUbV4plEi
         hvXm7EhV5DAho7L60pnHtzcFdLFp0GPePW+x59vJlWfcxRtmxo0uhm0wKW38O4BXS7nB
         xSvtmLz6uEMpYtI5I/H0cXyr1MFmBBnJ3Qiz3rme3QiMe+S7bZSrzQQ2U4WboeROTqlw
         TACg==
X-Forwarded-Encrypted: i=1; AJvYcCV1UzPp+ivj80LR7dsrolUnCMegp1RgWY85BWr9qooaDivjxjjZgM6vf3DYeZqM2P2Bg7UavrthkuvIxeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04//Bt2OGUXtLvUcpe24rCxdcRk1q91cEbyZAbem5xr+6ec4w
	pB4H2dcfUJejdUX8nGd6ULhVxttVUjhOqkVA1KmV4LGCjMJNWjVjf69n1eznUzcX27vdsIgq7g=
	=
X-Google-Smtp-Source: AGHT+IH/aG7LJ/XwS+oMxCdx7EksVfml5Du7v3Dy129jptRP6+MPmhejd017Z1fgvIWqbyZ0zd5FVA53
X-Received: from pjv14.prod.google.com ([2002:a17:90b:564e:b0:32d:69b3:b7b0])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c81:b0:32e:96b1:fb7f
 with SMTP id 98e67ed59e1d1-32e96b1ff96mr1957825a91.11.1757965945709; Mon, 15
 Sep 2025 12:52:25 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:46 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-6-fvdl@google.com>
Subject: [RFC PATCH 05/12] mm/cma: add helper functions for CMA balancing
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add some CMA helper functions to assist CMA balancing. They
are:

cma_get_available.
    - Returns the number of available pages in a CMA area

cma_numranges
    - Returns the total number of CMA ranges.

cma_next_balance_pagerange
    - Get the next CMA page range in a zone that has is available
      as a target for CMA balancing. This means a range that
      consists of CMA pageblocks that are managed by the buddy
      allocator (not allocated through cma_alloc). The array of
      CMA ranges is walked top down.

cma_next_noncma_pagerange
    - Get the next non-CMA page range in a zone. The zone is
      traversed bottom up.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/cma.h |  30 +++++++++
 mm/cma.c            | 161 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index ec48f2a11f1d..0504580d61d0 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -37,6 +37,7 @@ enum cma_flags {
 #define CMA_INIT_FLAGS (CMA_FIXED|CMA_RESERVE_PAGES_ON_ERROR)
 
 struct cma;
+struct zone;
 
 extern unsigned long totalcma_pages;
 extern phys_addr_t cma_get_base(const struct cma *cma);
@@ -79,6 +80,12 @@ extern void cma_reserve_pages_on_error(struct cma *cma);
 struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
 bool cma_free_folio(struct cma *cma, const struct folio *folio);
 bool cma_validate_zones(struct cma *cma);
+int cma_numranges(void);
+unsigned long cma_get_available(const struct cma *cma);
+bool cma_next_balance_pagerange(struct zone *zone, struct cma *cma, int *rindex,
+			    unsigned long *startpfn, unsigned long *endpfn);
+bool cma_next_noncma_pagerange(struct zone *zone, int *rindex,
+			       unsigned long *startpfn, unsigned long *endpfn);
 #else
 static inline struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
 {
@@ -93,6 +100,29 @@ static inline bool cma_validate_zones(struct cma *cma)
 {
 	return false;
 }
+
+static inline int cma_numranges(void)
+{
+	return 0;
+}
+
+static inline unsigned long cma_get_available(const struct cma *cma)
+{
+	return 0;
+}
+
+static inline bool cma_next_balance_pagerange(struct zone *zone,
+			struct cma *cma, int *rindex, unsigned long *start_pfn,
+			unsigned long *end_pfn)
+{
+	return false;
+}
+
+static inline bool cma_next_noncma_pagerange(struct zone *zone, int *rindex,
+			     unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index 1f5a7bfc9152..53cb1833407b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -54,6 +54,11 @@ const char *cma_get_name(const struct cma *cma)
 	return cma->name;
 }
 
+unsigned long cma_get_available(const struct cma *cma)
+{
+	return cma->available_count;
+}
+
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
 					     unsigned int align_order)
 {
@@ -202,6 +207,11 @@ static void __init cma_activate_area(struct cma *cma)
 static struct cma_memrange **cma_ranges;
 static int cma_nranges;
 
+int cma_numranges(void)
+{
+	return cma_nranges;
+}
+
 static int cmprange(const void *a, const void *b)
 {
 	struct cma_memrange *r1, *r2;
@@ -214,6 +224,157 @@ static int cmprange(const void *a, const void *b)
 	return r1->base_pfn - r2->base_pfn;
 }
 
+/*
+ * Provide the next free range in a cma memory range, as derived
+ * from the bitmap.
+ *
+ * @cmr: memory range to scan
+ * @start_pfn: the beginning of the previous range
+ * @end_pfn: the end of the previous range, zero for the first call
+ *
+ * The caller can adjust *end_pfn end use it as a starting point.
+ */
+static bool cma_next_free_range(struct cma_memrange *cmr,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	unsigned long zerobit, onebit, start, nbits, offset, base;
+	struct cma *cma = cmr->cma;
+
+	nbits = cma_bitmap_maxno(cmr);
+
+	if (!*end_pfn)
+		offset = start = 0;
+	else {
+		start = ((*end_pfn - cmr->base_pfn) >> cma->order_per_bit);
+		if (start >= nbits)
+			return false;
+
+		offset = *end_pfn -
+			(cmr->base_pfn + (start << cma->order_per_bit));
+	}
+
+	spin_lock_irq(&cma->lock);
+	zerobit = find_next_zero_bit(cmr->bitmap, nbits, start);
+	if (zerobit >= nbits) {
+		spin_unlock_irq(&cma->lock);
+		return false;
+	}
+	onebit = find_next_bit(cmr->bitmap, nbits, zerobit);
+	spin_unlock_irq(&cma->lock);
+
+	base = (zerobit << cma->order_per_bit) + cmr->base_pfn;
+	*start_pfn = base + offset;
+	*end_pfn = base + ((onebit - zerobit) << cma->order_per_bit);
+
+	return true;
+}
+
+static inline bool cma_should_balance_range(struct zone *zone,
+				      struct cma_memrange *cmr)
+{
+	if (page_zone(pfn_to_page(cmr->base_pfn)) != zone)
+		return false;
+
+	return true;
+}
+
+/*
+ * Get the next CMA page range containing pages that have not been
+ * allocated through cma_alloc. This is just a snapshot, and the caller
+ * is expected to deal with the changing circumstances. Used to walk
+ * through CMA pageblocks in a zone in an optimized fashion during
+ * zone CMA balance compaction.
+ *
+ * If @cma is NULL, the global list of ranges is walked, else
+ * the ranges of the area pointed to by @cma are walked.
+ */
+bool cma_next_balance_pagerange(struct zone *zone, struct cma *cma,
+			    int *rindex, unsigned long *start_pfn,
+			    unsigned long *end_pfn)
+{
+	struct cma_memrange *cmr;
+	int i, nranges;
+
+	if (!cma_nranges)
+		return false;
+
+	nranges = cma ? cma->nranges : cma_nranges;
+
+	if (*rindex == -1) {
+		if (*end_pfn != 0) {
+			for (i = nranges - 1; i >= 0; i--) {
+				cmr = cma ? &cma->ranges[i] : cma_ranges[i];
+				if (!cma_should_balance_range(zone, cmr))
+					continue;
+				if (*end_pfn > cmr->base_pfn &&
+				    *end_pfn < (cmr->base_pfn + cmr->count))
+					break;
+			}
+		} else {
+			i = nranges - 1;
+		}
+	} else {
+		i = *rindex;
+	}
+
+	for (; i >= 0; i--) {
+		cmr = cma ? &cma->ranges[i] : cma_ranges[i];
+		if (!cma_should_balance_range(zone, cmr))
+			continue;
+		if (cma_next_free_range(cmr, start_pfn, end_pfn)) {
+			*rindex = i;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Get the next stretch of memory in a zone that is not MIGRATE_CMA
+ * pageblocks.
+ */
+bool cma_next_noncma_pagerange(struct zone *zone, int *rindex,
+						unsigned long *start_pfn,
+						unsigned long *end_pfn)
+{
+	struct cma_memrange *cmr;
+	unsigned long cma_start, cma_end;
+	int i;
+
+	if (*end_pfn >= zone_end_pfn(zone))
+		return false;
+
+	if (*rindex == -1) {
+		*rindex = 0;
+		if (*start_pfn == 0)
+			*start_pfn = zone->zone_start_pfn;
+	} else {
+		cmr = cma_ranges[*rindex];
+		*start_pfn = cmr->base_pfn + cmr->count;
+	}
+
+	for (i = *rindex; i < cma_nranges; i++) {
+		cmr = cma_ranges[i];
+		cma_start = cmr->base_pfn;
+		cma_end = cmr->base_pfn + cmr->count;
+		if (page_zone(pfn_to_page(cma_start)) != zone)
+			continue;
+		if (*start_pfn == cma_start) {
+			*start_pfn = cma_end;
+		} else if (*start_pfn < cma_start) {
+			*rindex = i;
+			*end_pfn = cma_start;
+			return true;
+		}
+	}
+
+	*rindex = cma_nranges;
+	*end_pfn = zone_end_pfn(zone);
+
+	return true;
+}
+
 static int __init cma_init_reserved_areas(void)
 {
 	int i, r, nranges;
-- 
2.51.0.384.g4c02a37b29-goog


