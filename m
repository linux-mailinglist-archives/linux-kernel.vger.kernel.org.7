Return-Path: <linux-kernel+bounces-772978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17C7B29A04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF7E1888FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0144278774;
	Mon, 18 Aug 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+XFnarF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6901271457;
	Mon, 18 Aug 2025 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499587; cv=none; b=JPMBpZJjdtP986XUsBhd4y8lSfbxhGo8+Gu1/SrC8NzTv7MH/iPDZUoSjd314XmBk7+COQ4fymCKDXFqGikLv+ecQguBQ86V98V9jj6uTp8NBfpZ6Ogf/+G6l4AQX1gmHk08NET98KIoVcnEG+rDVe2He70Oa1AZjS+IEemwh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499587; c=relaxed/simple;
	bh=ToPABIT8QK9PCW9+WkqU/491rrTUTTVEcOSU5pzOhyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1eE71yDpOE1U6l+QuHnNmQn9kqGmIOKsYQg58cdsYe/4+s3gTc1j4/hn+EzpmlORjBA/V2kwNGl3UmQoVVhObjwyXBP96/+Pgo7/0rqyBPB0rCRSOSwwjfukGjG6Dh7LsPsP6xkwn6yU7KNWuCQ9wjjqViXTBCtuZdiNUi+zq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+XFnarF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F7C4CEED;
	Mon, 18 Aug 2025 06:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755499586;
	bh=ToPABIT8QK9PCW9+WkqU/491rrTUTTVEcOSU5pzOhyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+XFnarFgko6oqbL2InH2xpcouOfZmq8dhXw2n1dYcgxlqdklKMK26ttMOjscc/Ii
	 8SsSFXJbsnFLbOWyXC/dkPDp8N+OUGJjai17davlyrFyQm+sgjfZU06MuPCTkcbGWs
	 ueBHZNPFmLMMyET/B9l1AOkSAk0yF2H6uigdq40qxcQvHhPIQ526VKbKXVy96PS2SZ
	 xkLc6fAOAKMMORb7nzJiijwQpgG8NhDAb7ffVgaL8vDCLNYoU4FbM1BW24vLnYernK
	 6muOvZmHPwGsDBj/3HtlhJ8OxXbm54tiQ5b8aNRLesdGAEy0jas8VvOhqtcLZcFzv+
	 SaGKf8uF57bGg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/4] mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
Date: Mon, 18 Aug 2025 09:46:12 +0300
Message-ID: <20250818064615.505641-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818064615.505641-1-rppt@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

deferred_grow_zone() initializes one or more sections in the memory map
if buddy runs out of initialized struct pages when
CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

It loops through memblock regions and initializes and frees pages in
MAX_ORDER_NR_PAGES chunks.

Essentially the same loop is implemented in deferred_init_memmap_chunk(),
the only actual difference is that deferred_init_memmap_chunk() does not
count initialized pages.

Make deferred_init_memmap_chunk() count the initialized pages and return
their number, wrap it with deferred_init_memmap_job() for multithreaded
initialization with padata_do_multithreaded() and replace open-coded
initialization of struct pages in deferred_grow_zone() with a call to
deferred_init_memmap_chunk().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 65 ++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b..81809b83814b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2134,12 +2134,12 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
 	return nr_pages;
 }
 
-static void __init
+static unsigned long __init
 deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
-			   void *arg)
+			   struct zone *zone)
 {
+	unsigned long nr_pages = 0;
 	unsigned long spfn, epfn;
-	struct zone *zone = arg;
 	u64 i = 0;
 
 	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
@@ -2149,9 +2149,20 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	 * we can avoid introducing any issues with the buddy allocator.
 	 */
 	while (spfn < end_pfn) {
-		deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
 		cond_resched();
 	}
+
+	return nr_pages;
+}
+
+static void __init
+deferred_init_memmap_job(unsigned long start_pfn, unsigned long end_pfn,
+			 void *arg)
+{
+	struct zone *zone = arg;
+
+	deferred_init_memmap_chunk(start_pfn, end_pfn, zone);
 }
 
 static unsigned int __init
@@ -2204,7 +2215,7 @@ static int __init deferred_init_memmap(void *data)
 	while (deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, first_init_pfn)) {
 		first_init_pfn = ALIGN(epfn, PAGES_PER_SECTION);
 		struct padata_mt_job job = {
-			.thread_fn   = deferred_init_memmap_chunk,
+			.thread_fn   = deferred_init_memmap_job,
 			.fn_arg      = zone,
 			.start       = spfn,
 			.size        = first_init_pfn - spfn,
@@ -2240,12 +2251,11 @@ static int __init deferred_init_memmap(void *data)
  */
 bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 {
-	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
+	unsigned long nr_pages_needed = SECTION_ALIGN_UP(1 << order);
 	pg_data_t *pgdat = zone->zone_pgdat;
 	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
 	unsigned long spfn, epfn, flags;
 	unsigned long nr_pages = 0;
-	u64 i = 0;
 
 	/* Only the last zone may have deferred pages */
 	if (zone_end_pfn(zone) != pgdat_end_pfn(pgdat))
@@ -2262,37 +2272,26 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 		return true;
 	}
 
-	/* If the zone is empty somebody else may have cleared out the zone */
-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
-						 first_deferred_pfn)) {
-		pgdat->first_deferred_pfn = ULONG_MAX;
-		pgdat_resize_unlock(pgdat, &flags);
-		/* Retry only once. */
-		return first_deferred_pfn != ULONG_MAX;
+	/*
+	 * Initialize at least nr_pages_needed in section chunks.
+	 * If a section has less free memory than nr_pages_needed, the next
+	 * section will be also initalized.
+	 * Note, that it still does not guarantee that allocation of order can
+	 * be satisfied if the sections are fragmented because of memblock
+	 * allocations.
+	 */
+	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
+	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
+	     spfn = epfn, epfn += PAGES_PER_SECTION) {
+		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
 	}
 
 	/*
-	 * Initialize and free pages in MAX_PAGE_ORDER sized increments so
-	 * that we can avoid introducing any issues with the buddy
-	 * allocator.
+	 * There were no pages to initialize and free which means the zone's
+	 * memory map is completely initialized.
 	 */
-	while (spfn < epfn) {
-		/* update our first deferred PFN for this section */
-		first_deferred_pfn = spfn;
-
-		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		touch_nmi_watchdog();
-
-		/* We should only stop along section boundaries */
-		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
-			continue;
-
-		/* If our quota has been met we can stop here */
-		if (nr_pages >= nr_pages_needed)
-			break;
-	}
+	pgdat->first_deferred_pfn = nr_pages ? spfn : ULONG_MAX;
 
-	pgdat->first_deferred_pfn = spfn;
 	pgdat_resize_unlock(pgdat, &flags);
 
 	return nr_pages > 0;
-- 
2.50.1


