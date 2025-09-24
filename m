Return-Path: <linux-kernel+bounces-830758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDBBB9A722
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6987B859B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF6311958;
	Wed, 24 Sep 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/klGdsS"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912230FC11
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726025; cv=none; b=VgYdB82OMjvx7MR76yFu9euTpOorcNlNLUHLN/cMxsSUVFbdazAYxCJIFpLZszzKxCG75Yo0QS88oxo7w7c/8XXlWfBNr/VpCwYIrnKAu0tn7syZIQVQyiVKuub+Dh1xPhOusKSRkswcBpXUOW5AESG+vBnjd/og9RI+tzuKdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726025; c=relaxed/simple;
	bh=ToEJOWiUgA3tqyi4V/GGuiGh+drLHiNu1T9bHrSLgNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EugKD+80NhPlL1dBZnCPkk8btPGRdYnrNqZRXtgYUG09KAJIGgKPyWhwnDx2ngulWrfXr72qmkWPsNnX7YNJACG2hoV6YAyUbw6L2sDACkrvjBEOeDtOt54i/+7D5Pu0LLW9o4na2UAavohdSE3408SfncHPBMkDvnfTf2AKlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/klGdsS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3eff3936180so2017272f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726021; x=1759330821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bFXVx3R0RyJR3UqZnAzI+0uj7yd2IK0QOGE6ezKlUY=;
        b=V/klGdsSh99pvfvkv+iUHFqlGuP5PtyLTS9xisHgwqPkOzfDiehajfeePh2vU/N5Sg
         3ORYdwHb2VDHNAgRfdBkwscmd2NOsq6W/I/f7l68RYPTQDh1CBEOKAvd7JM4p+N+1RW8
         Rxgjz69xJJ6VonAUlZZjyEZ2+lIAJMPKJpq4YGzJvTRNJm15IwmXr5mJUCZwpi47iXtA
         Nm3UCVmlORxwhj25R0aEUGycMGNMKzFpE6b/0TSpp4sW2Xakbq/G0fRDsvFhbQWJh4iA
         8xuk/5xkg/aKaTivTL9KXe0tF8JGXy+puJS/MlOgVzu3mtHgrG97AqUtvjaIUwhntQvd
         6ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726021; x=1759330821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bFXVx3R0RyJR3UqZnAzI+0uj7yd2IK0QOGE6ezKlUY=;
        b=HytEhS+qUNb1r1tA2YzCNrqUq3cMhNkDVmQbJKripRiRUhUaqE5TMIBrkHAavRFTBN
         H6o9NIE0ZsvJWymVDQG7UE2FO5Q+ZUXK9RdgfhZrfGN1VCEBxPkeHL7pTuI7ALnuy9bC
         pM2QEsUzyGi9LDJlBldz5srK+0OQmjUd8QCTYapsY39m13SKaCg1HSKM75BkHn0hrhng
         wHU8qrAFzjn2Wr/TeC4vORTzhFeq6FAKAc9tryfJ5VSsbcY9ttYooHirk1/RcJIyB2vA
         pMU5y4FhsdMcl0txiY521JeQ/8QWP4CkmN/JTTpCZ+S5imlqhy7ypqqjUzermMMLlFX9
         UssQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdJCMw6mFhuLC++NL2mFHkKhtafVM5csDC2f/m8HLlg5P/ZwLIQcSgVD2Pqs4WVzNvNawb4npfJhCfDDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4wNkiN6/W8gSDhpRJ1XY9OPIDw4SuxC5gspGYLYsUa2sX2fX
	+6KDewGGK2m2FLMPTMD0ZOTg0e8114PAOeHEliXAV7j4rWOa3Fry5los/WvHGukq/ECP4jdr41H
	r6wyGO4dYbBNvnQ==
X-Google-Smtp-Source: AGHT+IHFVakseZTMWKw/YOwvxPSBppIbseG235GM/Mq7WzEAVq/9qbzbdj/TNAOCE62qZnIbK4YhRn+KuowqWA==
X-Received: from wrwu11.prod.google.com ([2002:a5d:6acb:0:b0:402:78b6:a467])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2586:b0:407:77f9:949d with SMTP id ffacd0b85a97d-40e4b945911mr255186f8f.40.1758726020780;
 Wed, 24 Sep 2025 08:00:20 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:48 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-13-2d861768041f@google.com>
Subject: [PATCH 13/21] mm/page_alloc_test: unit test pindex helpers
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

The author struggles with really basic arithmetic. This test checks for
errors in the helpers that are used to map to and from pcplist indices.

This can be run via a basic kunit.py invocation:

tools/testing/kunit/kunit.py run "page_alloc.*"

That will run it via UML which means no THP or ASI. If you want to test
with those enabled you can set the --arch flag to run it via QEMU:

tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_TRANSPARENT_HUGEPAGE=y "page_alloc.*"
tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION=y "page_alloc.*"
tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION=y \
	--kconfig_add CONFIG_TRANSPARENT_HUGEPAGE=y \
	"page_alloc.*"

Signed-off-by: Brendan Jackman <jackmanb@google.com>

fix
---
 mm/Kconfig           |  5 ++++
 mm/Makefile          |  1 +
 mm/internal.h        |  6 +++++
 mm/page_alloc.c      | 10 +++++---
 mm/page_alloc_test.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 034a1662d8c1af320b2262ebcb0cb51d4622e6b0..e25451c1adbd6e079f2d00e3eb8a28affcedab7e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1375,4 +1375,9 @@ config FIND_NORMAL_PAGE
 
 source "mm/damon/Kconfig"
 
+config PAGE_ALLOC_KUNIT_TEST
+	tristate "KUnit Tests for page_alloc code" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550153a7a477640e4fa6dc6df327541..c6ce46a2abf144f2e62df96ec7f606f90affc5f0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -65,6 +65,7 @@ page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 
 obj-y += page-alloc.o
+obj-$(CONFIG_PAGE_ALLOC_KUNIT_TEST) += page_alloc_test.o
 obj-y += page_frag_cache.o
 obj-y += init-mm.o
 obj-y += memblock.o
diff --git a/mm/internal.h b/mm/internal.h
index 0401412220a76a233e14a7ee7d64c1194fc3759d..6006cfb2b9c7e771a0c647c471901dc7fcdad242 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1693,4 +1693,10 @@ static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
 	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
 }
 
+#ifdef CONFIG_KUNIT
+unsigned int order_to_pindex(freetype_t freetype, int order);
+int pindex_to_order(unsigned int pindex);
+bool pcp_allowed_order(unsigned int order);
+#endif /* CONFIG_KUNIT */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5943b821089b72fd148bd93ee035c0e70e45ec91..0b205aefd27e188c492c32754db08a4488317bd8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -56,6 +56,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
 #include <asm/div64.h>
+#include <kunit/visibility.h>
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
@@ -691,7 +692,7 @@ static void bad_page(struct page *page, const char *reason)
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
-static inline unsigned int order_to_pindex(freetype_t freetype, int order)
+VISIBLE_IF_KUNIT inline unsigned int order_to_pindex(freetype_t freetype, int order)
 {
 	int migratetype = free_to_migratetype(freetype);
 	/* pindex if the freetype is nonsensitive */
@@ -713,8 +714,9 @@ static inline unsigned int order_to_pindex(freetype_t freetype, int order)
 	return (NR_PCP_LISTS_PER_SENSITIVITY * freetype_sensitive(freetype))
 		+ pindex_ns;
 }
+EXPORT_SYMBOL_IF_KUNIT(order_to_pindex);
 
-inline int pindex_to_order(unsigned int pindex)
+VISIBLE_IF_KUNIT inline int pindex_to_order(unsigned int pindex)
 {
 	/* pindex if the freetype is nonsensitive */
 	int pindex_ns = (pindex % NR_PCP_LISTS_PER_SENSITIVITY);
@@ -731,8 +733,9 @@ inline int pindex_to_order(unsigned int pindex)
 
 	return order;
 }
+EXPORT_SYMBOL_IF_KUNIT(pindex_to_order);
 
-static inline bool pcp_allowed_order(unsigned int order)
+VISIBLE_IF_KUNIT inline bool pcp_allowed_order(unsigned int order)
 {
 	if (order <= PAGE_ALLOC_COSTLY_ORDER)
 		return true;
@@ -742,6 +745,7 @@ static inline bool pcp_allowed_order(unsigned int order)
 #endif
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(pcp_allowed_order);
 
 /*
  * Higher-order pages are called "compound pages".  They are structured thusly:
diff --git a/mm/page_alloc_test.c b/mm/page_alloc_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..1cc615ce90d95c47ecae206a87f2af3fab3a5581
--- /dev/null
+++ b/mm/page_alloc_test.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitmap.h>
+
+#include <kunit/test.h>
+
+#include "internal.h"
+
+/* This just checks for basic arithmetic errors. */
+static void test_pindex_helpers(struct kunit *test)
+{
+	unsigned long bitmap[bitmap_size(NR_PCP_LISTS)];
+
+	/* Bit means "pindex not yet used". */
+	bitmap_fill(bitmap, NR_PCP_LISTS);
+
+	for (unsigned int order = 0; order < NR_PAGE_ORDERS; order++) {
+		for (unsigned int mt = 0; mt < MIGRATE_PCPTYPES; mt++)  {
+			if (!pcp_allowed_order(order))
+				continue;
+
+			for (int sensitive = 0; sensitive < NR_SENSITIVITIES; sensitive++) {
+				freetype_t ft = migrate_to_freetype(mt, sensitive);
+				unsigned int pindex = order_to_pindex(ft, order);
+				int got_order;
+
+				KUNIT_ASSERT_LT_MSG(test, pindex, NR_PCP_LISTS,
+					"invalid pindex %d (order %d mt %d sensitive %d)",
+					pindex, order, mt, sensitive);
+				KUNIT_EXPECT_TRUE_MSG(test, test_bit(pindex, bitmap),
+					"pindex %d reused (order %d mt %d sensitive %d)",
+					pindex, order, mt, sensitive);
+
+				/*
+				 * For THP, two migratetypes map to the
+				 * same pindex, just manually exclude one
+				 * of those cases.
+				 */
+				if (!(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+				      order == HPAGE_PMD_ORDER &&
+				      mt == min(MIGRATE_UNMOVABLE, MIGRATE_RECLAIMABLE)))
+					clear_bit(pindex, bitmap);
+
+				got_order = pindex_to_order(pindex);
+				KUNIT_EXPECT_EQ_MSG(test, order, got_order,
+					"roundtrip failed, got %d want %d (pindex %d mt %d sensitive %d)",
+					got_order, order, pindex, mt, sensitive);
+
+			}
+		}
+	}
+
+	KUNIT_EXPECT_TRUE_MSG(test, bitmap_empty(bitmap, NR_PCP_LISTS),
+		"unused pindices: %*pbl", NR_PCP_LISTS, bitmap);
+}
+
+static struct kunit_case page_alloc_test_cases[] = {
+	KUNIT_CASE(test_pindex_helpers),
+	{}
+};
+
+static struct kunit_suite page_alloc_test_suite = {
+	.name = "page_alloc",
+	.test_cases = page_alloc_test_cases,
+};
+
+kunit_test_suite(page_alloc_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

-- 
2.50.1


