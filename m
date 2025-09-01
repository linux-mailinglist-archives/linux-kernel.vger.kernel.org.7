Return-Path: <linux-kernel+bounces-794078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1FB3DC8D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1520017D224
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC22FB62B;
	Mon,  1 Sep 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3FYys+6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F662FB609;
	Mon,  1 Sep 2025 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715682; cv=none; b=Nxcnr8ORJ71slWElJFJwtgR0QsYbxRTvY9RRion0BdUMn01olsoUm7mD2vOuV9NCTWkSoVMNuLUNrNCGwBVxVOQw3bEvMKA2OeTWBD03cZlhkZijP8tkrJOpUCMqS950Oc+C2Aj+v7zjN570r17wx639csXjy8T1+d3MPfFcMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715682; c=relaxed/simple;
	bh=tijAz1eNA4UUi3u0ThL/Z8I1a2cgIFLE3T1W4G+WSyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osWADBA4WxATLpDAs3Lha/DFl8pyUFHM6Ag6zQ9Gdi1X+k+40j0Yu+a1b3nQDjZTbrz81WToMXxXoUMZPX8Xg/rFflQf7OSdLuLR0VbIWXsXLuGS3Sh6/xy02ez+amarUkdgYE0rfH7RiQ1J8RnqyVt3YEgH8f8jJoOxvHzn7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3FYys+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A5BC4CEF0;
	Mon,  1 Sep 2025 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756715682;
	bh=tijAz1eNA4UUi3u0ThL/Z8I1a2cgIFLE3T1W4G+WSyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3FYys+6jyvfehPZwHKVP9GBRngDIMaxwrEHCeOB1+TGU7YqF51o0r0e0KBBOGgfQ
	 JVrUiwNutdKf9IQk3s/4DfVAbPerLVWa+aqDcguiQV/yxliTGj53ownmsEPk0YNT1Z
	 v7tkPG1pCNXAmcsRQBQRU+CD5rxRicwuudydwlaLykfYa4DDPihjPXVfy8wRY/Y4Wr
	 kOc909JfqH1g0uLfCcWkkcQzCPfl81v/EJwnV9uSxQADi6pnKhmiz/hrnoz1/EClnl
	 N1hZdjPzmqLVjAqIGJspdjjCWzkE0IIadd+sEXE+ILmdDlQLUHox5z6N85D4ORf2Eu
	 fI+TeLKW52OzQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/4] mm/mm_init: drop deferred_init_maxorder()
Date: Mon,  1 Sep 2025 11:34:22 +0300
Message-ID: <20250901083423.3061349-4-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901083423.3061349-1-rppt@kernel.org>
References: <20250901083423.3061349-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

deferred_init_memmap_chunk() calls deferred_init_maxorder() to initialize
struct pages in MAX_ORDER_NR_PAGES because according to commit 0e56acae4b4d
("mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger
sections") this provides better cache locality than initializing the memory
map in larger sections.

The looping through free memory ranges is quite cumbersome in the current
implementation as it is divided between deferred_init_memmap_chunk() and
deferred_init_maxorder(). Besides, the latter has two loops, one that
initializes struct pages and another one that frees them.

There is no need in two loops because it is safe to free pages in groups
smaller than MAX_ORDER_NR_PAGES. Even if lookup for a buddy page will
access a struct page ahead of the pages being initialized, that page is
guaranteed to be initialized either by memmap_init_reserved_pages() or by
init_unavailable_range().

Simplify the code by moving initialization and freeing of the pages into
deferred_init_memmap_chunk() and dropping deferred_init_maxorder().

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Link: https://lore.kernel.org/r/20250818064615.505641-4-rppt@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 127 +++++++++++++--------------------------------------
 1 file changed, 32 insertions(+), 95 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 57b256ea9e6c..7e5e6984bb5d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2046,114 +2046,51 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
 }
 
 /*
- * This function is meant to pre-load the iterator for the zone init from
- * a given point.
- * Specifically it walks through the ranges starting with initial index
- * passed to it until we are caught up to the first_init_pfn value and
- * exits there. If we never encounter the value we return false indicating
- * there are no valid ranges left.
- */
-static bool __init
-deferred_init_mem_pfn_range_in_zone(u64 *i, struct zone *zone,
-				    unsigned long *spfn, unsigned long *epfn,
-				    unsigned long first_init_pfn)
-{
-	u64 j = *i;
-
-	if (j == 0)
-		__next_mem_pfn_range_in_zone(&j, zone, spfn, epfn);
-
-	/*
-	 * Start out by walking through the ranges in this zone that have
-	 * already been initialized. We don't need to do anything with them
-	 * so we just need to flush them out of the system.
-	 */
-	for_each_free_mem_pfn_range_in_zone_from(j, zone, spfn, epfn) {
-		if (*epfn <= first_init_pfn)
-			continue;
-		if (*spfn < first_init_pfn)
-			*spfn = first_init_pfn;
-		*i = j;
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * Initialize and free pages. We do it in two loops: first we initialize
- * struct page, then free to buddy allocator, because while we are
- * freeing pages we can access pages that are ahead (computing buddy
- * page in __free_one_page()).
+ * Initialize and free pages.
+ *
+ * At this point reserved pages and struct pages that correspond to holes in
+ * memblock.memory are already intialized so every free range has a valid
+ * memory map around it.
+ * This ensures that access of pages that are ahead of the range being
+ * initialized (computing buddy page in __free_one_page()) always reads a valid
+ * struct page.
  *
- * In order to try and keep some memory in the cache we have the loop
- * broken along max page order boundaries. This way we will not cause
- * any issues with the buddy page computation.
+ * In order to try and improve CPU cache locality we have the loop broken along
+ * max page order boundaries.
  */
 static unsigned long __init
-deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
-		       unsigned long *end_pfn)
+deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
+			   struct zone *zone)
 {
-	unsigned long mo_pfn = ALIGN(*start_pfn + 1, MAX_ORDER_NR_PAGES);
-	unsigned long spfn = *start_pfn, epfn = *end_pfn;
+	int nid = zone_to_nid(zone);
 	unsigned long nr_pages = 0;
-	u64 j = *i;
-
-	/* First we loop through and initialize the page values */
-	for_each_free_mem_pfn_range_in_zone_from(j, zone, start_pfn, end_pfn) {
-		unsigned long t;
-
-		if (mo_pfn <= *start_pfn)
-			break;
-
-		t = min(mo_pfn, *end_pfn);
-		nr_pages += deferred_init_pages(zone, *start_pfn, t);
-
-		if (mo_pfn < *end_pfn) {
-			*start_pfn = mo_pfn;
-			break;
-		}
-	}
-
-	/* Reset values and now loop through freeing pages as needed */
-	swap(j, *i);
+	phys_addr_t start, end;
+	u64 i = 0;
 
-	for_each_free_mem_pfn_range_in_zone_from(j, zone, &spfn, &epfn) {
-		unsigned long t;
+	for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
+		unsigned long spfn = PFN_UP(start);
+		unsigned long epfn = PFN_DOWN(end);
 
-		if (mo_pfn <= spfn)
+		if (spfn >= end_pfn)
 			break;
 
-		t = min(mo_pfn, epfn);
-		deferred_free_pages(spfn, t - spfn);
+		spfn = max(spfn, start_pfn);
+		epfn = min(epfn, end_pfn);
 
-		if (mo_pfn <= epfn)
-			break;
-	}
+		while (spfn < epfn) {
+			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
+			unsigned long chunk_end = min(mo_pfn, epfn);
 
-	return nr_pages;
-}
-
-static unsigned long __init
-deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
-			   struct zone *zone)
-{
-	unsigned long nr_pages = 0;
-	unsigned long spfn, epfn;
-	u64 i = 0;
+			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
+			deferred_free_pages(spfn, chunk_end - spfn);
 
-	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
+			spfn = chunk_end;
 
-	/*
-	 * Initialize and free pages in MAX_PAGE_ORDER sized increments so that
-	 * we can avoid introducing any issues with the buddy allocator.
-	 */
-	while (spfn < end_pfn) {
-		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		if (irqs_disabled())
-			touch_nmi_watchdog();
-		else
-			cond_resched();
+			if (irqs_disabled())
+				touch_nmi_watchdog();
+			else
+				cond_resched();
+		}
 	}
 
 	return nr_pages;
-- 
2.50.1


