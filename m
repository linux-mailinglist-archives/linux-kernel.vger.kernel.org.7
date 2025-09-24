Return-Path: <linux-kernel+bounces-830763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615AB9A741
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15617B6E66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F47311950;
	Wed, 24 Sep 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKG3pQaR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550531281C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726031; cv=none; b=X7ubR3wQOE3bjE1zBdyHpaCkcBxUrrfKF/pVpY7DmB3JcQGoPTRP865hk96t7hoyjZLuYEBeTwIuk8WRFnXpAmo1AFLrV0vF9/7VkwMfJuWLLT6wadwGgOPDt11yH7+HpCF8u7V7KTzSrHq+qBqfTI06rh4YQH6BqAPPKUD+ayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726031; c=relaxed/simple;
	bh=Nc9wGi4sa/SseUd8+DrYdDIywk30Jds65N0aHDFnlcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nXidndxorV1pTkrmocKM3tKwBUg9VWZ1tpA2hdGw2vywhnmV2cLto6lc8IwGvxL/5fOGNz5jzt6qoDpB8OyPcFFHCMV5gcO/7AZcw4TyItkG3WCEuq4wsFHkfMBze12OitqsE4WsLjf1S2z1BDtbzwNSsgpkAoVvZzCSt50LUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKG3pQaR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e19f00bc2so27320005e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726027; x=1759330827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xK9DdWzysI7MLQZmTS4EgkDsy0LNYBhIo28kzW1svBA=;
        b=yKG3pQaRLLxcI44g9iEtm5NkcrrCpzQLaCVX6hABdIsfg9VUaJ3/z7uCzFJ+M37NYU
         5n5h07vn4FmLDqtvTmAH3SLg4QRagqtu4JUgBw2g29ujW8/PzTYbUtudbJ/XgH92E+tq
         QcKo/OAca8SLqONvu0lphWY1rgRRo3shKINzSuOVduyV2A+31UQEtkTty+mwMHjmF45T
         4DdOIretKHQsc3nVZ0eUG3/W/A6M7JRHYzgR8kW86//0wzhmn+63wd/c2zmfl+JjT/Hg
         FRbSV30mck8f64sU9KUwl2kEDPZJF+qH6L1ZB5e0yO1Z7LLzL6L6f43faBnqc6Rx1Nti
         3WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726027; x=1759330827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK9DdWzysI7MLQZmTS4EgkDsy0LNYBhIo28kzW1svBA=;
        b=WjCGcEChl4XAoc9s1Ah2xgSvLNf/F7dYNns8ZJB/LJwO7dPr8KsLKtPKCTtnF7Soxb
         pv/w4d52T+Ij2vnR/D9ZPwcAbnM1OkbqJQZXXnpzg+c5lnftg/nQdJLYzTjaUv+G4pyA
         NLqpOxKAuy7BI3HK8l87FuP/gyUams4DT2RBFZURAWtZ4+rwsCgaFf5gOalQlEVEsdUD
         920f0w4NqVKW1GJ0LDpiHg422GMSOsxIBOlxYRMtAiA2gY6zJDjJzwpNRVSo9Engqsqy
         55VEN6X9LG67YQ2LT5cRKeCqq+dYObOa9TYtU/H2clzvcJlLnsrGCOXj7OPXJfqRrMJ7
         USuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/IHyYvx1V/bJoA85s8NK3PcEVpvxlPPyngr42Cq5Xs5+5vQF7Z8UVaGfRjlMc2MY3Is0ByTkxCebjAjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CHiJ9pTT9xsowc90Fma6yYbiO5VC5HxILuMRR58ZN1ru8iWA
	qPa81NdnZZgeqSHJuZzaW5wAZ7yitXQF0yPnpcuHpgrKQqMDi6JT8d+ssYjF9VboeGr1BSJ6gRJ
	CWfTk0HpIUTVu7A==
X-Google-Smtp-Source: AGHT+IHRBeDpUtgF245mJUc5ipAYXCdMHfAb0w1ma3Resd3ql66vcD7C0WlHnlWorox4xP6DwHfNcUDqpn/NkQ==
X-Received: from wmrn38.prod.google.com ([2002:a05:600c:5026:b0:46c:f222:92c9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c163:b0:45d:cf5f:cff8 with SMTP id 5b1f17b1804b1-46e329b9b49mr1939205e9.11.1758726027581;
 Wed, 24 Sep 2025 08:00:27 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:54 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-19-2d861768041f@google.com>
Subject: [PATCH 19/21] mm/asi: bad_page() when ASI mappings are wrong
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

Add bad_page() checks that fire when the page allocator thinks a page is
mapped/unmapped in ASI restricted address space, but the pagetables
disagree.

This requires adding an accessor for set_memory.c to walk the page
tables and report the state.

This is implemented with the assumption that the mapping is at pageblock
granularity. That means it doesn't need to be repeated for each order-0
page. As a result of this special order-awareness, it can't go into
free_page_is_bad() and needs to be separately integrated into
free_pages_prepare(). The alloc side is easier - there it just goes into
check_new_pages().

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/set_memory.h |  3 +++
 arch/x86/mm/pat/set_memory.c      | 31 +++++++++++++++++++++++++++
 include/linux/set_memory.h        |  2 ++
 mm/page_alloc.c                   | 45 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 396580693e7d1317537148c0c219296e2b7c13fd..3870fa8cf51c0ece0dedf4d7876c4d14111deffd 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -94,12 +94,15 @@ bool kernel_page_present(struct page *page);
 
 #ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
 int set_direct_map_sensitive(struct page *page, int num_pageblocks, bool sensitive);
+bool direct_map_sensitive(struct page *page);
 #else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 static inline
 int set_direct_map_sensitive(struct page *page, int num_pageblocks, bool sensitive)
 {
 	return 0;
 }
+
+static inline bool direct_map_sensitive(struct page *page) { return false; }
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 88fb65574d4fa0089fa31a9a06fe096c408991e6..d4c3219374f889f9a60c459f0559e5ffb472073d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2721,6 +2721,37 @@ int set_direct_map_sensitive(struct page *page, int num_pageblocks, bool sensiti
 
 	return __change_page_attr_set_clr(&cpa, 1);
 }
+
+/*
+ * Walk the pagetable to check if the page is mapped into all ASI restricted
+ * address spaces.
+ */
+bool direct_map_sensitive(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	pgd_t *pgd = pgd_offset_pgd(asi_nonsensitive_pgd, addr);
+	unsigned int level;
+	bool nx, rw;
+	pte_t *pte = lookup_address_in_pgd_attr(pgd, addr, &level, &nx, &rw);
+
+	switch (level) {
+	case PG_LEVEL_4K:
+		/*
+		 * lookup_address_in_pgd_attr() still returns the PTE for
+		 * non-present 4K pages.
+		 */
+		return !pte_present(*pte);
+	case PG_LEVEL_2M:
+		/*
+		 * pmd_present() checks PSE to deal with some hugetlb
+		 * logic. That's not relevant for the direct map so just
+		 * explicitly check the real P bit.
+		 */
+		return !(pmd_flags(*(pmd_t *)pte) & _PAGE_PRESENT);
+	default:
+		return !pte;
+	}
+}
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index db4225c046c47c114293af8b504886b103dc94ce..6f42d6a35feceeae4623c2da50cfac54e3533228 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -50,6 +50,8 @@ static inline int set_direct_map_sensitive(struct page *page,
 	return 0;
 }
 
+static inline bool direct_map_sensitive(struct page *page) { return false; }
+
 #else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 /*
  * Some architectures, e.g. ARM64 can disable direct map modifications at
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8e3556643b0ff2fe1d35a678937270356006d34..68bc3cc5ed7e7f1adb8dda90edc2e001f9a1c3c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -15,6 +15,7 @@
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
 
+#include <linux/asi.h>
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -1161,6 +1162,33 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	return bad_reason;
 }
 
+static bool page_asi_mapping_bad(struct page *page, unsigned int order, bool sensitive)
+{
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	if (asi_enabled_static()) {
+		struct page *block_page = page;
+
+		/*
+		 * ASI mappings are at pageblock granularity. Check they match
+		 * the requested sensitivity.
+		 */
+		while (block_page < page + (1 << order)) {
+			if (direct_map_sensitive(block_page) != sensitive) {
+				bad_page(page,
+					sensitive ?
+					"page unexpectedly nonsensitive" :
+					"page unexpectedly sensitive");
+				return true;
+			}
+
+			block_page += pageblock_nr_pages;
+		}
+	}
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
+	return false;
+}
+
 static inline bool free_page_is_bad(struct page *page)
 {
 	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
@@ -1471,8 +1499,14 @@ __always_inline bool free_pages_prepare(struct page *page,
 		page->page_type = UINT_MAX;
 
 	if (is_check_pages_enabled()) {
+		freetype_t ft = get_pageblock_freetype(page);
+
 		if (free_page_is_bad(page))
 			bad++;
+
+		if (!bad)
+			bad += page_asi_mapping_bad(page, order,
+						    freetype_sensitive(ft));
 		if (bad)
 			return false;
 	}
@@ -1840,7 +1874,8 @@ static bool check_new_page(struct page *page)
 	return true;
 }
 
-static inline bool check_new_pages(struct page *page, unsigned int order)
+static inline bool check_new_pages(struct page *page, unsigned int order,
+				   bool sensitive)
 {
 	if (!is_check_pages_enabled())
 		return false;
@@ -1852,7 +1887,7 @@ static inline bool check_new_pages(struct page *page, unsigned int order)
 			return true;
 	}
 
-	return false;
+	return page_asi_mapping_bad(page, order, sensitive);
 }
 
 static inline bool should_skip_kasan_unpoison(gfp_t flags)
@@ -3393,7 +3428,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		if (!page)
 			return NULL;
 
-	} while (check_new_pages(page, order));
+	} while (check_new_pages(page, order, freetype_sensitive(freetype)));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 	zone_statistics(preferred_zone, zone, 1);
@@ -3478,7 +3513,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		page = list_first_entry(list, struct page, pcp_list);
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
-	} while (check_new_pages(page, order));
+	} while (check_new_pages(page, order, freetype_sensitive(freetype)));
 
 	return page;
 }
@@ -7231,7 +7266,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	} else if (start == outer_start && end == outer_end && is_power_of_2(end - start)) {
 		struct page *head = pfn_to_page(start);
 
-		check_new_pages(head, order);
+		check_new_pages(head, order, gfp_mask & __GFP_SENSITIVE);
 		prep_new_page(head, order, gfp_mask, 0);
 		set_page_refcounted(head);
 	} else {

-- 
2.50.1


