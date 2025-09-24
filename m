Return-Path: <linux-kernel+bounces-830762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA749B9A744
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B14C17904D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F1313283;
	Wed, 24 Sep 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM4LIAFz"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277A30B516
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726030; cv=none; b=do/48EE6s/kcNmu86kkrEeg3X0caau6MgzQOwVLA5E97HSufeWCrc0hnOD6bDgp9z+CosjiYKY0xYIcv3qEiALjHS2fTjMI6OVd0Q4HLQqdncEhRbzLkxSFNgDeCTmqptIVvKIFdLCqb+5ULSEdufm7AZN7hJcK5rtx+LR8cTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726030; c=relaxed/simple;
	bh=wUbWX91BQp6M0/mnNhy3/4WzdN/SwErhAcw4rqPjQcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nv5HwWXNibfW//LkazLQnSxIeuxor/YEwOCWru+Tn2/jj/V/usb3MShZr/skYgq+cG/J2Ho2TTOkn6l0BD1KFRNxpBiJcGRjpPeZDqChZ7Awc/YGNExbfIYs5jqzC/2CEaaUTJzpLCSx1WYxK3ThPuMWQGF9bJHlqsgHQzi/j7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM4LIAFz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46d8ef3526dso21392255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726026; x=1759330826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yt3Q1XTnbMGvlZgCdZ/CgJSleEFjvQwQBSgYepLM/TE=;
        b=kM4LIAFzTWVpBHx9Ns+zBbNWRLg/vhqXIJD4if55rS0vM6o8GoT92t6hE+qicxxU31
         4jfPth1WO8JirPu5nk5mh0Di8q/kIKJ412sJvjFa2fwxxfqbtd16eO//a2J5MCTAcAkF
         wpKVbgvvyzBN+t9QqYBVn7WQbxOOCFo30J43cs6Tw2/fsJybJX0Q4l53j26Z3KSxTrJ/
         Cl6fqw2ISYUI/YKqV0qjrcQbZdlZOT4O4LDyUK2yaWRzboTanvjZGpK+ixWBtrw3UpWN
         +5Ntlrjx3MQWhGmQxTwpma1QV8ED8BHAF/s5EoD+QulKFaugDOhjwP+XtvwABT4itd/2
         Crug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726026; x=1759330826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yt3Q1XTnbMGvlZgCdZ/CgJSleEFjvQwQBSgYepLM/TE=;
        b=lTBCMcHrYn12KiRxCCtgGJV41np+/8nIbDogQ9WTqmA/bhXwSpvwf65mjVgMTVDC9s
         nCOz1D1GQgO1VEkvBJ80yu3klP3EKuEuEuCidtbCK/YzEtiXB/eLqhmoSBOKFDiB2eF6
         aPdX7mrXWbeWfhL6x4qRv08u3s/KT9FdNBim2ll5kF/CmO4qecyqGt4m8PUII2i5R2dQ
         KGHF1qCrZqnTLeLpQd0Asp72KenIX25BWgaqG3m55deYo2vzy8pbSG3n5dlmQtuld6Mh
         2zMnU1AJ0sD4mRKKTdJrz+k5MhMTqgCoLJVsjinjNi8BIqVza0PH31EwHR5J5pcMTReY
         RXbA==
X-Forwarded-Encrypted: i=1; AJvYcCVqpHhD6aM4ustY9z9ESvmk0+t+JTsI+GueMpWJiDppOhfq9iOner+prQxfLFhrEl5b5IqOsifxG7O9Nd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+3zMn8ObegHdZvSRK79/03QjQQsbvQhjZg5GYC+NMAWDgP8M
	ZZXTPX6quqMbBDKPjfAbKF58mI+mM7+OX2x6kHHPjvL7cfPwXqV/sMxvoC6i7JLHWL5xUaAU3Ne
	MaFUDt6K3jIqEJw==
X-Google-Smtp-Source: AGHT+IEOgWk7seh/trUQUGpJ6ZsEL7UmOVpxpeIq06m/4rtBPuJiGJmuPe07oAhOUg5xOwd6Wn79YD2LQK3VBw==
X-Received: from wmbhe13.prod.google.com ([2002:a05:600c:540d:b0:46d:2f48:35f9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6306:b0:46d:9d28:fb5e with SMTP id 5b1f17b1804b1-46e329ab29cmr2315835e9.5.1758726026374;
 Wed, 24 Sep 2025 08:00:26 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:53 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-18-2d861768041f@google.com>
Subject: [PATCH 18/21] mm/asi: support changing pageblock sensitivity
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

Currently all pages are sensitive and there's no way to change that.
This patch introduces one. Changing sensitivity has some requirements:

- It can only be done at pageblock granularity. This means that
  there's never a need to allocate pagetables to do it (since the
  restricted direct map is always pre-allocated down to pageblock
  granularity).

- Flipping pages from nonsensitive to sensitive (unmapping) requires a
  TLB shootdown, meaning IRQs must be enabled.

- Flipping from sensitive to nonsensitive requires zeroing pages, which
  seems like an undesirable thing to do with a spinlock held.

This makes allocations that need to change sensitivity _somewhat_
similar to those that need to fallback to a different migratetype. But,
the locking requirements mean that this can't just be squashed into the
existing "fallback" allocator logic, instead a new allocator path just
for this purpose is needed.

The new path is assumed to be much cheaper than the really heavyweight
stuff like compaction and reclaim. But at present it is treated as less
desirable than the mobility-related "fallback" and "stealing" logic.
This might turn out to need revision (in particular, maybe it's a
problem that __rmqueue_steal(), which causes fragmentation, happens
before __rmqueue_asi()), but that should be treated as a subsequent
optimisation project.

Now that !__GFP_SENSITIVE allocations are no longer doomed to fail, stop
hard-coding it at the top of the allocator.

Note that this does loads of unnecessary TLB flushes and IPIs. The
design goal here is that the transitions are rare enough that this
doesn't matter a huge amount, but it should still be addressed in later
patches.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/set_memory.h |  10 ++++
 arch/x86/mm/pat/set_memory.c      |  28 ++++++++++
 include/linux/set_memory.h        |   6 +++
 mm/page_alloc.c                   | 106 +++++++++++++++++++++++++++++++++-----
 4 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 61f56cdaccb5af18e36790677b635b4ab6f5e24d..396580693e7d1317537148c0c219296e2b7c13fd 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -92,6 +92,16 @@ int set_direct_map_default_noflush(struct page *page);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+int set_direct_map_sensitive(struct page *page, int num_pageblocks, bool sensitive);
+#else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+static inline
+int set_direct_map_sensitive(struct page *page, int num_pageblocks, bool sensitive)
+{
+	return 0;
+}
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
 extern int kernel_set_to_readonly;
 
 #endif /* _ASM_X86_SET_MEMORY_H */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2a50844515e81913fed32d5b6d1ec19e8e249533..88fb65574d4fa0089fa31a9a06fe096c408991e6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -4,6 +4,7 @@
  * Thanks to Ben LaHaise for precious feedback.
  */
 #include <linux/asi.h>
+#include <linux/align.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/sched.h>
@@ -2695,6 +2696,33 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 	return __set_pages_np(page, nr);
 }
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+/*
+ * Map/unmap a set of contiguous pageblocks into all ASI restricted address
+ * spaces. All pagetables are pre-allocated so this can be called anywhere.
+ * This should not be called on pages that may be mapped elsewhere.
+ */
+int set_direct_map_sensitive(struct page *page, int num_pageblocks, bool sensitive)
+{
+	if (WARN_ON_ONCE(!IS_ALIGNED(page_to_pfn(page), 1 << pageblock_order)))
+		return -EINVAL;
+
+	unsigned long tempaddr = (unsigned long)page_address(page);
+	struct cpa_data cpa = { .vaddr = &tempaddr,
+				.pgd = asi_nonsensitive_pgd,
+				.numpages = num_pageblocks << pageblock_order,
+				.flags = CPA_NO_CHECK_ALIAS,
+				.on_fault = CPA_FAULT_ERROR, };
+
+	if (sensitive)
+		cpa.mask_clr = __pgprot(_PAGE_PRESENT);
+	else
+		cpa.mask_set = __pgprot(_PAGE_PRESENT);
+
+	return __change_page_attr_set_clr(&cpa, 1);
+}
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 3030d9245f5ac8a35b27e249c6d8b9539f148635..db4225c046c47c114293af8b504886b103dc94ce 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -44,6 +44,12 @@ static inline bool kernel_page_present(struct page *page)
 {
 	return true;
 }
+
+static inline int set_direct_map_sensitive(struct page *page,
+					   int num_pageblocks, bool sensitive) {
+	return 0;
+}
+
 #else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 /*
  * Some architectures, e.g. ARM64 can disable direct map modifications at
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b0aeb97baa13af038fff0edae33affbbf49e825c..a8e3556643b0ff2fe1d35a678937270356006d34 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -44,6 +44,7 @@
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/migrate.h>
+#include <linux/set_memory.h>
 #include <linux/sched/mm.h>
 #include <linux/page_owner.h>
 #include <linux/page_table_check.h>
@@ -585,6 +586,13 @@ static void set_pageblock_migratetype(struct page *page,
 				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
+static inline void set_pageblock_sensitive(struct page *page, bool sensitive)
+{
+	__set_pfnblock_flags_mask(page, page_to_pfn(page),
+				  sensitive ? 0 : PAGEBLOCK_NONSENSITIVE_MASK,
+				  PAGEBLOCK_NONSENSITIVE_MASK);
+}
+
 void __meminit init_pageblock_migratetype(struct page *page,
 					  enum migratetype migratetype,
 					  bool isolate)
@@ -3264,6 +3272,85 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 #endif
 }
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+static inline struct page *__rmqueue_asi(struct zone *zone, unsigned int request_order,
+				unsigned int alloc_flags, freetype_t freetype)
+{
+	freetype_t freetype_other = migrate_to_freetype(
+		free_to_migratetype(freetype), !freetype_sensitive(freetype));
+	unsigned long flags;
+	struct page *page;
+	int alloc_order;
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
+	int nr_pageblocks;
+
+	if (!asi_enabled_static())
+		return NULL;
+
+	/*
+	 * Might need a TLB shootdown. Even if IRQs are on this isn't
+	 * safe if the caller holds a lock (in case the other CPUs need that
+	 * lock to handle the shootdown IPI).
+	 */
+	if (alloc_flags & ALLOC_NOBLOCK)
+		return NULL;
+	lockdep_assert(!irqs_disabled() || unlikely(early_boot_irqs_disabled));
+
+	/*
+	 * Need to [un]map a whole pageblock (otherwise it might require
+	 * allocating pagetables). First allocate it.
+	 */
+	alloc_order = max(request_order, pageblock_order);
+	nr_pageblocks = 1 << (alloc_order - pageblock_order);
+	spin_lock_irqsave(&zone->lock, flags);
+	page = __rmqueue(zone, alloc_order, freetype_other, alloc_flags, &rmqm);
+	spin_unlock_irqrestore(&zone->lock, flags);
+	if (!page)
+		return NULL;
+
+	if (!freetype_sensitive(freetype)) {
+		/*
+		 * These pages were formerly sensitive so we need to clear them
+		 * out before exposing them to CPU attacks. Doing this with the
+		 * zone lock held would have been undesirable.
+		 */
+		kernel_init_pages(page, 1 << alloc_order);
+	}
+
+	/*
+	 * Now that IRQs are on it's safe to do a TLB shootdown, so change
+	 * mapping and update pageblock flags.
+	 */
+	set_direct_map_sensitive(page, nr_pageblocks, freetype_sensitive(freetype));
+	for (int i = 0; i < nr_pageblocks; i++) {
+		struct page *block_page = page + (pageblock_nr_pages * i);
+
+		set_pageblock_sensitive(block_page, freetype_sensitive(freetype));
+	}
+
+	if (request_order >= alloc_order)
+		return page;
+
+	/* Free any remaining pages in the block. */
+	spin_lock_irqsave(&zone->lock, flags);
+	for (unsigned int i = request_order; i < alloc_order; i++) {
+		struct page *page_to_free = page + (1 << i);
+
+		__free_one_page(page_to_free, page_to_pfn(page_to_free), zone,
+			i, freetype, FPI_SKIP_REPORT_NOTIFY);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	return page;
+}
+#else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+static inline struct page *__rmqueue_asi(struct zone *zone, unsigned int request_order,
+				 unsigned int alloc_flags, freetype_t freetype)
+{
+	return NULL;
+}
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
 static __always_inline
 struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			   unsigned int order, unsigned int alloc_flags,
@@ -3297,13 +3384,15 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 */
 			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_HARDER)))
 				page = __rmqueue_smallest(zone, order, ft_high);
-
-			if (!page) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return NULL;
-			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+
+		/* Try changing sensitivity, now we've released the zone lock */
+		if (!page)
+			page = __rmqueue_asi(zone, order, alloc_flags, freetype);
+		if (!page)
+			return NULL;
+
 	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -5285,13 +5374,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
-	/*
-	 * Temporary hack: Allocation of nonsensitive pages is not possible yet,
-	 * allocate everything sensitive. The restricted address space is never
-	 * actually entered yet so this is fine.
-	 */
-	gfp |= __GFP_SENSITIVE;
-
 	/*
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.

-- 
2.50.1


