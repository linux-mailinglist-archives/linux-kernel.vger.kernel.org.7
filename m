Return-Path: <linux-kernel+bounces-820680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E34B7DB18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304797A426B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB9189BB0;
	Wed, 17 Sep 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La9IYq6c"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033117A30A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112378; cv=none; b=lkEjAlkcXd/z3GZTQXlq3xk2UdRecguyl+aEBbDtGvm0/5NDgCTopRENUMjE4/10bwZZD+yuUKzVzQRdX+T0u4vkxnNDvMFcwEsMJUd26OX9LYb8i94jCV2SrrktEWz6wVrGZmugShwzRfXhV51zbi3Lm2sb9i1H4X03PU1HSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112378; c=relaxed/simple;
	bh=ZSfmOwjxQiI6qmLgxPQS+AZvXtntXYIwm90GNzJWEnA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PeZGiQB+yz9gfZ0uNR7MyjwG0OZ6HM1+prNvIu7btKk5C5qPjrmzBquoW1LBgg6eshB3b40X8gulKk14y84q1LpxUMVkH5021M0xmpER2MM65G91jHGOGe36P6qwK3P60SixPlgMqyvf1ky49cm4gK32PoA+BNGGNNkxsrKRWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La9IYq6c; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3eb0a50a518so1134500f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758112375; x=1758717175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGExNynnqYK/ZqCJ7ukjmzItbcXmGcwmJziwMXpS7pE=;
        b=La9IYq6cnyfrTgX3SFAt/DNY9HUgnsNZ8cH/xlCpne5xC2EU5ZUm4KN/8xX3zNJIrz
         rPCoA1dSRrfHIlbDQrXAPBTnZ+tQWSwLTKdCwCs32qt1zQdlzuGlFN5ByqFAwHhA2J0c
         GsvxRAovAoS5U2lgeb50bM1CdLXAM6/plBDVyyc97AWnyxUp5vQOS+6sER11FR1AL89p
         pgn6PfRkrJocIS+kx1DlceE5RpngcnsEJ2he7+HdkkZvn3Fk0nE77qntoY40Su29XzM+
         YmCT96R5woNPJ9OMZQSI5Z8VKut2oo3E5dsf7P/rmz9tJiwy3aU8luJIoZa7qNIDMnDE
         Xv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112375; x=1758717175;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGExNynnqYK/ZqCJ7ukjmzItbcXmGcwmJziwMXpS7pE=;
        b=wvGtVHlEuo3d4VZUgC6vd0eFP9+6RgIPN+smvgXWoxmVkwi8fT6Ofa10IXG8pXpJRb
         ixpZuB9otBRCEfOFyfTqMVIGvljqTOzZdEl5BBnlvf33t43zhU2UHV2X17mjKU8oeIld
         gg03pTHmzdUNZQ4xA2G34dMBJLyhjtJ2JXeCtIfYoVOrvY96aLZLyJFK02HTOYQZbZzy
         7iYh/G4rLsLxu8vzqdP0QBrQ3LL9SrhsQd4r14Fzl/0cge7CMNSPqFKu0OAJhd680bLw
         L7u4uYbZ5CZH8syfa8XbttwuFrk1VHz7XIKKiKFKaV9Lvi2GfhGnp+UaHrx3nkQwVtJ3
         rMmg==
X-Forwarded-Encrypted: i=1; AJvYcCWnzLBEtJ5TVvLtN0bqG1HUUMPe6Y97UybWprgVjs5f2cVOCnwzZXq48HaJwEOCjrRFzq1Kaxfc5A9m54w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DqOuoKqGmCvhirl0FdqtPAeH/n64nu9sSgotkg3MsVn8gNP1
	3mjWHivTrD36bMd9lfkweyrygOkACX+YvHYMYEDBYO+S8vizf2AJtUfUefc8XE7MR4/qyYPQC54
	AjjFAlw==
X-Google-Smtp-Source: AGHT+IGDr7/rZ8Lz2UDuNsmg0UK0rM+imdFAZEus6WN4w0ovnTMSdLLxblWDQmsHkKpeXcc+Eb+cvXvBIv0=
X-Received: from wroa6.prod.google.com ([2002:adf:ed06:0:b0:3e8:8959:563a])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2c0b:b0:3ec:d78d:8fd9
 with SMTP id ffacd0b85a97d-3ecdfa171eemr2138728f8f.36.1758112375451; Wed, 17
 Sep 2025 05:32:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:32:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917123250.3597556-1-glider@google.com>
Subject: [PATCH v1] mm/memblock: Correct totalram_pages accounting with KMSAN
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz, 
	rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	elver@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, 
	Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"

When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
for metadata instead of returning them to the early allocator. The callers,
however, would unconditionally increment `totalram_pages`, assuming the
pages were always freed. This resulted in an incorrect calculation of the
total available RAM, causing the kernel to believe it had more memory than
it actually did.

This patch refactors `memblock_free_pages()` to return the number of pages
it successfully frees. If KMSAN stashes the pages, the function now
returns 0; otherwise, it returns the number of pages in the block.

The callers in `memblock.c` have been updated to use this return value,
ensuring that `totalram_pages` is incremented only by the number of pages
actually returned to the allocator. This corrects the total RAM accounting
when KMSAN is active.

Cc: Aleksandr Nogikh <nogikh@google.com>
Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/internal.h |  4 ++--
 mm/memblock.c | 18 +++++++++---------
 mm/mm_init.c  |  9 +++++----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..ae1ee6e02eff9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -742,8 +742,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
-extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
+extern unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
+					 unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order,
 		enum meminit_context context);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c9..de7ff644d8f4f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1834,10 +1834,9 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 	cursor = PFN_UP(base);
 	end = PFN_DOWN(base + size);
 
-	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
-		totalram_pages_inc();
-	}
+	for (; cursor < end; cursor++)
+		totalram_pages_add(
+			memblock_free_pages(pfn_to_page(cursor), cursor, 0));
 }
 
 /*
@@ -2259,9 +2258,11 @@ static void __init free_unused_memmap(void)
 #endif
 }
 
-static void __init __free_pages_memory(unsigned long start, unsigned long end)
+static unsigned long __init __free_pages_memory(unsigned long start,
+						unsigned long end)
 {
 	int order;
+	unsigned long freed = 0;
 
 	while (start < end) {
 		/*
@@ -2279,10 +2280,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
 
-		memblock_free_pages(pfn_to_page(start), start, order);
+		freed += memblock_free_pages(pfn_to_page(start), start, order);
 
 		start += (1UL << order);
 	}
+	return freed;
 }
 
 static unsigned long __init __free_memory_core(phys_addr_t start,
@@ -2297,9 +2299,7 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	if (start_pfn >= end_pfn)
 		return 0;
 
-	__free_pages_memory(start_pfn, end_pfn);
-
-	return end_pfn - start_pfn;
+	return __free_pages_memory(start_pfn, end_pfn);
 }
 
 static void __init memmap_init_reserved_pages(void)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b2..9883612768511 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *tablename,
 	return table;
 }
 
-void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
+unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
+					 unsigned int order)
 {
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
 
 		if (!early_page_initialised(pfn, nid))
-			return;
+			return 0;
 	}
 
 	if (!kmsan_memblock_free_pages(page, order)) {
 		/* KMSAN will take care of these pages. */
-		return;
+		return 0;
 	}
 
 	/* pages were reserved and not allocated */
 	clear_page_tag_ref(page);
 	__free_pages_core(page, order, MEMINIT_EARLY);
+	return 1UL << order;
 }
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
-- 
2.51.0.384.g4c02a37b29-goog


