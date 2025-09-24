Return-Path: <linux-kernel+bounces-830291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ECCB99529
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073914C5B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA12DC77B;
	Wed, 24 Sep 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WSebGjN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C732DCF6E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708192; cv=none; b=ntzGWrkpszmVt1ay0ufm2Auv4f4FhAcwDTB6SDT678rlYXcZCj/Jp/j7NiSIxe8pH2TOizktpzruphygDZHmRydGTrByExttEGVVrUVUuu+0d+vkJiLqvcRZgHYMazgOfJT29Nama5FPHs8djt/2SKxvWRgt89A2+SqltcjgQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708192; c=relaxed/simple;
	bh=MyiCCOGvDAD3E1VblRvdBzle5CZUWUHDnvr/LgUGNms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AlBFcMEN363AdXOdpHRm4MJBnueI+GUditvQTu+pRqJs8m8VU/kMCBU9h4NUqW86MyPOT0NukgtWxyahYKgsA8CPL54MqByvR7T29TxCvC5PnFLDFjgvan2RLcAeDb1NvVI7RCYWJjkH1zw7gfw8dfPLMaufbEg7dK0sds5FSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WSebGjN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso52921365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758708185; x=1759312985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjocDtApH+mYILuh2MoVR7BbFeZzIGZsGcmRz0O6aqA=;
        b=3WSebGjNaWKIF7CA4rNsC1LyVKwf2OgCjcY7vMDGE9oxz/Xlf9QhBse2GXZyNPTtd6
         dMmpaXiLTlPaY3QHKc7WZPqTPfHSgDSpxD3q2OVjE/0a8Q7hGsbykHNE+2mCzr8w2HIF
         nqmjttLBHD1pyhV5NwvxITqkx943SllN0tmldoD+2K+BEX/8Y9E9nRwPIUlG17TVf/b1
         djgFaKPN+uuVf7QeI3j81r2sorxct0A8cotkSxdovHg0JCzFhcL3kRLncggEde1cvemt
         TrSXZ53LRfLFPjXmQH06d87zmQc/W/Z1ia/xN3m7YZNHREXx40Em6FOwhyIVlHd+cXPX
         2lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708185; x=1759312985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjocDtApH+mYILuh2MoVR7BbFeZzIGZsGcmRz0O6aqA=;
        b=oyg2yeDlqiXR73w9PS5NTiN+f9w0Wumtf+kpw2FLTmhz47IC0CBIrFP4/Mm8TimKJw
         07VTrJ58qLr9Jm5YFtLKZuVlm0IO5Htkm4fnc5BYQrrbtkXP22FI/bNTooozGDEsTFId
         uAZo7J2AOxA/G2wSeN9eZtuF2hw81AzDJt5jzIWh2y8hkIejdEb9/kq+TrCMaVTcB1xy
         ih7pIfYT/wqqMVKYfskGVSyBrXaxVMquxRmk8jzoP/jCyCwA69Lm0OwslK3j/3jjviyE
         ZVfIiUd4/5Os5q6dG6hdRqiz9eqczJkhnQ/tTFauJVirPuHT6OoIowvrdgRidkEK6+0C
         Z09Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIUyDvgq/IDVW4bAaSOlo/CSo78iZPb+fFleTCJLH3VXOV2pFS5F+kmhMPcyLWDdjaskmqwo8aO87wEqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYvUpRvOV1WlLSXBYdalOl3ueRiey+mY7k9gs5v3vrByh835n
	B+kBRjvTDTt3Pe9k1+84BM8V5eaDFjvD6vFcW/oR835/ahQuzTZpdh0tbDlcC67pAqOTw+4P1Ej
	Dfy4LRQ==
X-Google-Smtp-Source: AGHT+IHt24AXDuzRv8mfV0+Dd7gn9yVXlAssjjo5xVzAkMIAyKd0XpBQuf6DwkbGgm2mAJytPIKDsRe4zdo=
X-Received: from wrbet7.prod.google.com ([2002:a05:6000:2307:b0:3ed:665b:ec9d])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:288b:b0:3ee:1296:d9e6
 with SMTP id ffacd0b85a97d-405cdc1e751mr3789906f8f.61.1758708184637; Wed, 24
 Sep 2025 03:03:04 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924100301.1558645-1-glider@google.com>
Subject: [PATCH v2] mm/memblock: Correct totalram_pages accounting with KMSAN
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
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v2:
- Remove extern from the declaration of memblock_free_pages() in
  mm/internal.h as suggested by Mike Rapoport.
- Fix formatting in the definition of memblock_free_pages() in
  mm/mm_init.c as suggested by Mike Rapoport.
- Refactor memblock_free_late() to improve readability as suggested by
  David Hildenbrand.
---
 mm/internal.h |  4 ++--
 mm/memblock.c | 21 +++++++++++----------
 mm/mm_init.c  |  9 +++++----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..ac841c53653eb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -742,8 +742,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
-extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
+unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
+				  unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order,
 		enum meminit_context context);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c9..9b23baee7dfe7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1826,6 +1826,7 @@ void *__init __memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align,
 void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t cursor, end;
+	unsigned long freed_pages = 0;
 
 	end = base + size - 1;
 	memblock_dbg("%s: [%pa-%pa] %pS\n",
@@ -1834,10 +1835,9 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 	cursor = PFN_UP(base);
 	end = PFN_DOWN(base + size);
 
-	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
-		totalram_pages_inc();
-	}
+	for (; cursor < end; cursor++)
+		freed_pages += memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+	totalram_pages_add(freed_pages);
 }
 
 /*
@@ -2259,9 +2259,11 @@ static void __init free_unused_memmap(void)
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
@@ -2279,14 +2281,15 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
 
-		memblock_free_pages(pfn_to_page(start), start, order);
+		freed += memblock_free_pages(pfn_to_page(start), start, order);
 
 		start += (1UL << order);
 	}
+	return freed;
 }
 
 static unsigned long __init __free_memory_core(phys_addr_t start,
-				 phys_addr_t end)
+					       phys_addr_t end)
 {
 	unsigned long start_pfn = PFN_UP(start);
 	unsigned long end_pfn = PFN_DOWN(end);
@@ -2297,9 +2300,7 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
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
2.51.0.534.gc79095c0ca-goog


