Return-Path: <linux-kernel+bounces-830272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E0B9941F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C932E7A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910E2D9EFC;
	Wed, 24 Sep 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDG0H0HV"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E52D73B5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707775; cv=none; b=mnZ4Dsz69L98YERq0CkvxQqYabXbVzB/KaYdickXwtDQFPDslKVfr2xI+1M/WGyt8nhkXTMLPR0KyNWd9FTo90IH+iYDvBdKwuJrDorD4RGP8hgx0CeHjtNLg+d1fvFtRb+EmjWCa6JHUrXwHOIox3pZulJP9nqsX61LJB9DJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707775; c=relaxed/simple;
	bh=21JSh7YV6cM8xSPIPYnqxfeY9Z9RlI03qVsY0y6vUlw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vC2D8ibNgMLFeS0p/vpzHsNS9LjhBt9h6pfIY9ZuN0l16aokBGGTuqFSyTjHLv6z5M5rtlL4cIA9DaLYeCesGvXJng2zkljNUCIdgq5vsY/88vZLEsurdwn8fPAFCRGvs7YDrzP0v+XAEGwAjczsvyIBmOY1xoSgq0qSJxOVZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDG0H0HV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45e037fd142so54804595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758707768; x=1759312568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAmycbMkPNpKo2rKRIkxeOAbE/X03s6JAmOKI9ShzKQ=;
        b=HDG0H0HVje9+NV3lEn6QMBe2oGeGapsfRprgKQTDCFCFAzQNRBkMM41HjWZyJ620gh
         XO9VeVO2lB/TYBvzpycezhXyITVENOlHnnnCk1fJfte75bbVczSmI9L3cD2n/OIAo1iU
         RJ0O9s2IdVqFIg51IfwSq9ZFoL6ler+XXTWWLNW+BJ88771O9phV+sXMrjHY/XDAUj2G
         sPd2dJY9yHeFEC8ivvmSF8JO45TMM8NyvNzmM645uj3WTS/l7VXSuj+FWZroDIyh3TUk
         LK+jrorpri6Ay8QRNwdsP1rd7sZ/BkabvbTpEvPU88ux3Hxia/VUNwmy7aOMtbmnDd4y
         BGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707768; x=1759312568;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAmycbMkPNpKo2rKRIkxeOAbE/X03s6JAmOKI9ShzKQ=;
        b=bTl3CSx9PAW5GxWmYgzUPSNb0jaM8YK52yTLmHDMqbStuXsAVQPdQMv5gC+gCFWZi9
         0NNkGtHarldHLPGrGuKvbEEdQb6fuQZEvdGg0mYqBgdLOIYsp3onnCHUAYaChJTcM5QT
         QjpKZ24Ye3wsTs03WxeYcUbcYQJrAovzDSH6CV75RfAka1H0GC+DGlyPCCwic7Hl1XVN
         9TV44CtLzEyzcCPUSlQKEByMdWegik3Pev+KzqxtM+Uz+fYGoIfqoieve/GULUeRF8q1
         KUOia3OtNoCzQviCyVAIkk6/VP7v1UVqm07/2FqyhcUMn1uk5XZNfy9Zm5Q06VaxwCvt
         s8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVEjTs+JDTrrilrmyiaUidSP3QOP6z7PP3wNMnBuhp2GGvAg0ram4vfdRFpAVtvtvH0FJlLTRQcGqdwMaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmWSJMfRrfrBXFSLqnvVgweEi99OaWYDjqHsooY9VNBSKtQrM
	/9iRdL4jQhvWIVtB+fMdTQPU3STB5I93kfYo+kIi+8s3r23vzbQymMnjKgaDx2h/RNKz2j+4uqh
	uW6bepw==
X-Google-Smtp-Source: AGHT+IFcYpf+nNo8eIO//grBA5BZmYeaVIKAa87wo+W9+idFnU+8Z2dRZEyljZbwJZH4nEW9LUAy1FyA2Yk=
X-Received: from wmsr5.prod.google.com ([2002:a05:600c:8b05:b0:46e:2897:9c17])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1f12:b0:465:a51d:d4
 with SMTP id 5b1f17b1804b1-46e1d97d858mr54128675e9.6.1758707768216; Wed, 24
 Sep 2025 02:56:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:56:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924095604.1553144-1-glider@google.com>
Subject: [PATCH v2] mm/memblock: Correct totalram_pages accounting with KMSAN
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz, 
	rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	elver@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, 
	Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

---                                                                        =
                                                 =E2=94=82
v2:                                                                        =
                                                 =E2=94=82
- Remove extern from the declaration of memblock_free_pages() in           =
                                                 =E2=94=82
  mm/internal.h as suggested by Mike Rapoport.                             =
                                                 =E2=94=82
- Fix formatting in the definition of memblock_free_pages() in             =
                                                 =E2=94=82
  mm/mm_init.c as suggested by Mike Rapoport.                              =
                                                 =E2=94=82
- Refactor memblock_free_late() to improve readability as suggested by     =
                                                 =E2=94=82
  David Hildenbrand.                                                       =
                                                 =E2=94=82
---
 mm/internal.h |  4 ++--
 mm/memblock.c | 21 +++++++++++----------
 mm/mm_init.c  |  9 +++++----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..ac841c53653eb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -742,8 +742,8 @@ static inline void clear_zone_contiguous(struct zone *z=
one)
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
-extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
+unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
+				  unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order,
 		enum meminit_context context);
=20
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c9..9b23baee7dfe7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1826,6 +1826,7 @@ void *__init __memblock_alloc_or_panic(phys_addr_t si=
ze, phys_addr_t align,
 void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t cursor, end;
+	unsigned long freed_pages =3D 0;
=20
 	end =3D base + size - 1;
 	memblock_dbg("%s: [%pa-%pa] %pS\n",
@@ -1834,10 +1835,9 @@ void __init memblock_free_late(phys_addr_t base, phy=
s_addr_t size)
 	cursor =3D PFN_UP(base);
 	end =3D PFN_DOWN(base + size);
=20
-	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
-		totalram_pages_inc();
-	}
+	for (; cursor < end; cursor++)
+		freed_pages +=3D memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+	totalram_pages_add(freed_pages);
 }
=20
 /*
@@ -2259,9 +2259,11 @@ static void __init free_unused_memmap(void)
 #endif
 }
=20
-static void __init __free_pages_memory(unsigned long start, unsigned long =
end)
+static unsigned long __init __free_pages_memory(unsigned long start,
+						unsigned long end)
 {
 	int order;
+	unsigned long freed =3D 0;
=20
 	while (start < end) {
 		/*
@@ -2279,14 +2281,15 @@ static void __init __free_pages_memory(unsigned lon=
g start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
=20
-		memblock_free_pages(pfn_to_page(start), start, order);
+		freed +=3D memblock_free_pages(pfn_to_page(start), start, order);
=20
 		start +=3D (1UL << order);
 	}
+	return freed;
 }
=20
 static unsigned long __init __free_memory_core(phys_addr_t start,
-				 phys_addr_t end)
+					       phys_addr_t end)
 {
 	unsigned long start_pfn =3D PFN_UP(start);
 	unsigned long end_pfn =3D PFN_DOWN(end);
@@ -2297,9 +2300,7 @@ static unsigned long __init __free_memory_core(phys_a=
ddr_t start,
 	if (start_pfn >=3D end_pfn)
 		return 0;
=20
-	__free_pages_memory(start_pfn, end_pfn);
-
-	return end_pfn - start_pfn;
+	return __free_pages_memory(start_pfn, end_pfn);
 }
=20
 static void __init memmap_init_reserved_pages(void)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b2..9883612768511 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *ta=
blename,
 	return table;
 }
=20
-void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
+unsigned long __init memblock_free_pages(struct page *page, unsigned long =
pfn,
+					 unsigned int order)
 {
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid =3D early_pfn_to_nid(pfn);
=20
 		if (!early_page_initialised(pfn, nid))
-			return;
+			return 0;
 	}
=20
 	if (!kmsan_memblock_free_pages(page, order)) {
 		/* KMSAN will take care of these pages. */
-		return;
+		return 0;
 	}
=20
 	/* pages were reserved and not allocated */
 	clear_page_tag_ref(page);
 	__free_pages_core(page, order, MEMINIT_EARLY);
+	return 1UL << order;
 }
=20
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
--=20
2.51.0.534.gc79095c0ca-goog


