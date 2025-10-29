Return-Path: <linux-kernel+bounces-876629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16DC1BE73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C659188734C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6F3491E5;
	Wed, 29 Oct 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWL6X3yb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B10350D47
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753608; cv=none; b=WmpSL+T0KIjtffzCnfi3UPDTtDMx9T0H6xS9EGf+WVOsAfDMz+Bu32ACqAgzXujlgcRg2EA9lKrpypuMynR1Mh0GZdRh+rSkf+4f21H/QDynoB3Ro59fcIknQfcRBSl8G6UD8o1DclUhwlZ6X6fnmBdBlso+Xl8WF2KLVjVfE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753608; c=relaxed/simple;
	bh=tksYFpw+Fx21aPVs3ud94B2IERIJ9qKkhy9qUyWaDMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPyNIQr221H4gjS7OsIPMuAC39ATQsMrYoecLwGy9kzPidjAB72MyNXq0FRb9uRa/2GuHvOZeKXpnqpeh9Y6Q0aCcwg/IpLfC74aUWKNPhm5hA/vYPOSNa/vvYjT9jk7U8TJ4tE+NG9PkSgk8dtlgmwICM+IkgQxd2EY2MOgrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWL6X3yb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29292eca5dbso96892835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753605; x=1762358405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0UdXGAMewCWDAEEMa7ZAr4h4jR5pcjvof6VKpTbof4=;
        b=LWL6X3ybsBDSFCwUoXdXeZQAfNK/Flyqf9hl5eV3dmJtJ0HJxHATRk1TsYQTx7/vOY
         qveLmTCnLA8GgNdn+C+bTrJsOBrgC/5ro8NXJmdHXFYL1nXk7894/ygTb+53eQ2K1fYG
         bVBkWHOLLfJraN4db5jIp+2XWRzBU+uVK8hec7Lty9sjP6APzGl4ZRNBxEx7p8gYQ4SD
         1W88yAx5nmalH0JE9x89AnJyj7VNa+lzVknUZiSrPyAAaqjmdv7dTnznKrJb1WwVnyPw
         Mrlfv9IN49FtJc0ofA6eNXNiDaeBzxez0P1QxLw3TWY0Onm88tKfMPNXX9YReK8lHBF5
         rWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753605; x=1762358405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0UdXGAMewCWDAEEMa7ZAr4h4jR5pcjvof6VKpTbof4=;
        b=jw+EWtU3PYvIHJMxsf1QNisCanpkEORV+jx6oy3ijd4aVRmwV6iVBmM+EO2H2CcAyU
         uFpwcj5utzacDjXJ2HYaLj/EpW1VoRanL7MUeVNaO1WoqeST/KitiAPKyHpIeLincLdd
         nnMrU4qB3HqfIUyV3hManFM/SodlPnviFku9GnNCn5a0kTjhVlaUm+mQMquafEqtYkSU
         HhxT6UVv8a3OOyIVOJkCiV0XSNHuBBNg3s/re52s7Mo14Cn6RGXshYN5w3xDh+HVLsU8
         zOXn3YWVE18K6lAsBK9rBYQ5sNBOV6gZe+K50Y2J6PvbuNsQ2aqXVgaat3OaA68TOhKo
         mY6g==
X-Forwarded-Encrypted: i=1; AJvYcCXaOGhDAL+cjVXD4keISbGQkCnzt2ZN4Bszg9QT1VZHgEG66RR+0DpXKm86VRXbcPQlc089HA/cuzbK4HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8Wp6QQb2aC79zlEw3HYpuMuvv1e72b+HirexBwKX7GmVXhUv
	TfOerftgM8FHjS1ibQl895B+vI3XmwDE5aVT5uJkkyh8At+VRzfuZrSLriARspWaMR8=
X-Gm-Gg: ASbGnct/OjWe+dJ5ivvdVdNz1ngBMeSr/AndsG2YkH9EA6YfDETt2dUWPlTmaTy0yf0
	yhizPySl0FJRBebeVhY9rsEL8EIChYYkk0QJh/XUOfQR8Kzttq2iQWMwnbjQEnYwrS1+0DiyW8w
	fzubMPtN+/bvgrLZRO4VoppLTiDsCGiCkBWlr60WIPYyM7htDG9REzeWzsgAFhSMsp+RCq2kFWg
	Qe7uOHLuGKUYo6sITv+7bvui/8fWhCAvoweoXiO9qQvnW90XKZuic3BqYFief4tgdUrMg2Rz3b/
	XFiUuIW+g5W4a2X3/jOZXj+YPzDApHyzu2Yz1lh1jtKK2+S1BRWQoiactatftrzWaKrSPKHK9nG
	IZHoXBGG/jTYuVKJPyQtz0bu/8HhfsO1QR1txGJ2CPDbKbHYTd0oPVR3hFa8HmyI3mx2B7dxY6r
	xDJwsHeHXi1UKVrN3ITKEB
X-Google-Smtp-Source: AGHT+IHuii9ioIbwdwvLXCUqFBOVCyosr5WYGJ1cI0MxYhGX4CKgA31FD6TOAKWXvkOu5RGv/fc9/A==
X-Received: by 2002:a17:902:d4c3:b0:290:94ed:1841 with SMTP id d9443c01a7336-294deedcf83mr48288835ad.41.1761753604431;
        Wed, 29 Oct 2025 09:00:04 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:03 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:40 +0800
Subject: [PATCH 14/19] mm, swap: sanitize swap entry management workflow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-14-3d43f3b6ec32@tencent.com>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

The current swap entry allocation/freeing workflow has never had a clear
definition. This makes it hard to debug or add new optimizations.

This commit introduces a proper definition of how swap entries would be
allocated and freed. Now, most operations are folio based, so they will
never exceed one swap cluster, and we now have a cleaner border between
swap and the rest of mm, making it much easier to follow and debug,
especially with new added sanity checks. Also making more optimization
possible.

Swap entry will be mostly allocated and free with a folio bound.
The folio lock will be useful for resolving many swap ralated races.

Now swap allocation (except hibernation) always starts with a folio in
the swap cache, and gets duped/freed protected by the folio lock:

- folio_alloc_swap() - The only allocation entry point now.
  Context: The folio must be locked.
  This allocates one or a set of continuous swap slots for a folio and
  binds them to the folio by adding the folio to the swap cache. The
  swap slots' swap count start with zero value.

- folio_dup_swap() - Increase the swap count of one or more entries.
  Context: The folio must be locked and in the swap cache. For now, the
  caller still has to lock the new swap entry owner (e.g., PTL).
  This increases the ref count of swap entries allocated to a folio.
  Newly allocated swap slots' count has to be increased by this helper
  as the folio got unmapped (and swap entries got installed).

- folio_put_swap() - Decrease the swap count of one or more entries.
  Context: The folio must be locked and in the swap cache. For now, the
  caller still has to lock the new swap entry owner (e.g., PTL).
  This decreases the ref count of swap entries allocated to a folio.
  Typically, swapin will decrease the swap count as the folio got
  installed back and the swap entry got uninstalled

  This won't remove the folio from the swap cache and free the
  slot. Lazy freeing of swap cache is helpful for reducing IO.
  There is already a folio_free_swap() for immediate cache reclaim.
  This part could be further optimized later.

The above locking constraints could be further relaxed when the swap
table if fully implemented. Currently dup still needs the caller
to lock the swap entry container (e.g. PTL), or a concurrent zap
may underflow the swap count.

Some swap users need to interact with swap count without involving folio
(e.g. forking/zapping the page table or mapping truncate without swapin).
In such cases, the caller has to ensure there is no race condition on
whatever owns the swap count and use the below helpers:

- swap_put_entries_direct() - Decrease the swap count directly.
  Context: The caller must lock whatever is referencing the slots to
  avoid a race.

  Typically the page table zapping or shmem mapping truncate will need
  to free swap slots directly. If a slot is cached (has a folio bound),
  this will also try to release the swap cache.

- swap_dup_entry_direct() - Increase the swap count directly.
  Context: The caller must lock whatever is referencing the entries to
  avoid race, and the entries must already have a swap count > 1.

  Typically, forking will need to copy the page table and hence needs to
  increase the swap count of the entries in the table. The page table is
  locked while referencing the swap entries, so the entries all have a
  swap count > 1 and can't be freed.

Hibernation subsystem is a bit different, so two special wrappers are here:

- swap_alloc_hibernation_slot() - Allocate one entry from one device.
- swap_free_hibernation_slot() - Free one entry allocated by the above
helper.

All hibernation entries are exclusive to the hibernation subsystem and
should not interact with ordinary swap routines.

By separating the workflows, it will be possible to bind folio more
tightly with swap cache and get rid of the SWAP_HAS_CACHE as a temporary
pin.

This commit should not introduce any behavior change

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/s390/mm/pgtable.c |   2 +-
 include/linux/swap.h   |  58 +++++++++----------
 kernel/power/swap.c    |  10 ++--
 mm/madvise.c           |   2 +-
 mm/memory.c            |  15 +++--
 mm/rmap.c              |   7 ++-
 mm/shmem.c             |  10 ++--
 mm/swap.h              |  37 +++++++++++++
 mm/swapfile.c          | 148 ++++++++++++++++++++++++++++++++++---------------
 9 files changed, 192 insertions(+), 97 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..c51304a4418e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -692,7 +692,7 @@ static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 
 		dec_mm_counter(mm, mm_counter(folio));
 	}
-	free_swap_and_cache(entry);
+	swap_put_entries_direct(entry, 1);
 }
 
 void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 69025b473472..ac3caa4c6999 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -452,14 +452,8 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
-int folio_alloc_swap(struct folio *folio);
-bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
-extern swp_entry_t get_swap_page_of_type(int);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern int swap_duplicate_nr(swp_entry_t entry, int nr);
-extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
@@ -472,6 +466,29 @@ struct backing_dev_info;
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
+/*
+ * If there is an existing swap slot reference (swap entry) and the caller
+ * guarantees that there is no race modification of it (e.g., PTL
+ * protecting the swap entry in page table; shmem's cmpxchg protects t
+ * he swap entry in shmem mapping), these two helpers below can be used
+ * to put/dup the entries directly.
+ *
+ * All entries must be allocated by folio_alloc_swap(). And they must have
+ * a swap count > 1. See comments of folio_*_swap helpers for more info.
+ */
+int swap_dup_entry_direct(swp_entry_t entry);
+void swap_put_entries_direct(swp_entry_t entry, int nr);
+
+/*
+ * folio_free_swap tries to free the swap entries pinned by a swap cache
+ * folio, it has to be here to be called by other components.
+ */
+bool folio_free_swap(struct folio *folio);
+
+/* Allocate / free (hibernation) exclusive entries */
+swp_entry_t swap_alloc_hibernation_slot(int type);
+void swap_free_hibernation_slot(swp_entry_t entry);
+
 static inline void put_swap_device(struct swap_info_struct *si)
 {
 	percpu_ref_put(&si->users);
@@ -499,10 +516,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr));
 
-static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
-{
-}
-
 static inline void free_swap_cache(struct folio *folio)
 {
 }
@@ -512,12 +525,12 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline int swap_duplicate_nr(swp_entry_t swp, int nr_pages)
+static inline int swap_dup_entry_direct(swp_entry_t ent)
 {
 	return 0;
 }
 
-static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
+static inline void swap_put_entries_direct(swp_entry_t ent, int nr)
 {
 }
 
@@ -541,11 +554,6 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static inline int folio_alloc_swap(struct folio *folio)
-{
-	return -EINVAL;
-}
-
 static inline bool folio_free_swap(struct folio *folio)
 {
 	return false;
@@ -558,22 +566,6 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 	return -EINVAL;
 }
 #endif /* CONFIG_SWAP */
-
-static inline int swap_duplicate(swp_entry_t entry)
-{
-	return swap_duplicate_nr(entry, 1);
-}
-
-static inline void free_swap_and_cache(swp_entry_t entry)
-{
-	free_swap_and_cache_nr(entry, 1);
-}
-
-static inline void swap_free(swp_entry_t entry)
-{
-	swap_free_nr(entry, 1);
-}
-
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..546a0c701970 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -179,10 +179,10 @@ sector_t alloc_swapdev_block(int swap)
 {
 	unsigned long offset;
 
-	offset = swp_offset(get_swap_page_of_type(swap));
+	offset = swp_offset(swap_alloc_hibernation_slot(swap));
 	if (offset) {
 		if (swsusp_extents_insert(offset))
-			swap_free(swp_entry(swap, offset));
+			swap_free_hibernation_slot(swp_entry(swap, offset));
 		else
 			return swapdev_block(swap, offset);
 	}
@@ -197,6 +197,7 @@ sector_t alloc_swapdev_block(int swap)
 
 void free_all_swap_pages(int swap)
 {
+	unsigned long offset;
 	struct rb_node *node;
 
 	while ((node = swsusp_extents.rb_node)) {
@@ -204,8 +205,9 @@ void free_all_swap_pages(int swap)
 
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
-		swap_free_nr(swp_entry(swap, ext->start),
-			     ext->end - ext->start + 1);
+
+		for (offset = ext->start; offset < ext->end; offset++)
+			swap_free_hibernation_slot(swp_entry(swap, offset));
 
 		kfree(ext);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..3cf2097d2085 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -697,7 +697,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				max_nr = (end - addr) / PAGE_SIZE;
 				nr = swap_pte_batch(pte, max_nr, ptent);
 				nr_swap -= nr;
-				free_swap_and_cache_nr(entry, nr);
+				swap_put_entries_direct(entry, nr);
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
 			} else if (is_hwpoison_entry(entry) ||
 				   is_poisoned_swp_entry(entry)) {
diff --git a/mm/memory.c b/mm/memory.c
index 589d6fc3d424..27d91ae3648a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -933,7 +933,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
 	if (likely(!non_swap_entry(entry))) {
-		if (swap_duplicate(entry) < 0)
+		if (swap_dup_entry_direct(entry) < 0)
 			return -EIO;
 
 		/* make sure dst_mm is on swapoff's mmlist. */
@@ -1746,7 +1746,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 
 		nr = swap_pte_batch(pte, max_nr, ptent);
 		rss[MM_SWAPENTS] -= nr;
-		free_swap_and_cache_nr(entry, nr);
+		swap_put_entries_direct(entry, nr);
 	} else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_folio(entry);
 
@@ -4932,7 +4932,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/*
 	 * Some architectures may have to restore extra metadata to the page
 	 * when reading from swap. This metadata may be indexed by swap entry
-	 * so this must be called before swap_free().
+	 * so this must be called before folio_put_swap().
 	 */
 	arch_swap_restore(folio_swap(entry, folio), folio);
 
@@ -4970,6 +4970,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(folio != swapcache)) {
 		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
+		folio_put_swap(swapcache, NULL);
 	} else if (!folio_test_anon(folio)) {
 		/*
 		 * We currently only expect !anon folios that are fully
@@ -4978,9 +4979,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		VM_WARN_ON_ONCE_FOLIO(folio_nr_pages(folio) != nr_pages, folio);
 		VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
 		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
+		folio_put_swap(folio, NULL);
 	} else {
+		VM_WARN_ON_ONCE(nr_pages != 1 && nr_pages != folio_nr_pages(folio));
 		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
-					rmap_flags);
+					 rmap_flags);
+		folio_put_swap(folio, nr_pages == 1 ? page : NULL);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
@@ -4994,7 +4998,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * swapcache. Do it after mapping so any raced page fault will
 	 * see the folio in swap cache and wait for us.
 	 */
-	swap_free_nr(entry, nr_pages);
 	if (should_try_to_free_swap(si, folio, vma, nr_pages, vmf->flags))
 		folio_free_swap(folio);
 
@@ -5004,7 +5007,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * Hold the lock to avoid the swap entry to be reused
 		 * until we take the PT lock for the pte_same() check
 		 * (to avoid false positives from pte_same). For
-		 * further safety release the lock after the swap_free
+		 * further safety release the lock after the folio_put_swap
 		 * so that the swap count won't change under a
 		 * parallel locked swapcache.
 		 */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1954c538a991..844864831797 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -82,6 +82,7 @@
 #include <trace/events/migrate.h>
 
 #include "internal.h"
+#include "swap.h"
 
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
@@ -2146,7 +2147,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				goto discard;
 			}
 
-			if (swap_duplicate(entry) < 0) {
+			if (folio_dup_swap(folio, subpage) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_abort;
 			}
@@ -2157,7 +2158,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * so we'll not check/care.
 			 */
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-				swap_free(entry);
+				folio_put_swap(folio, subpage);
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_abort;
 			}
@@ -2165,7 +2166,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			/* See folio_try_share_anon_rmap(): clear PTE first. */
 			if (anon_exclusive &&
 			    folio_try_share_anon_rmap_pte(folio, subpage)) {
-				swap_free(entry);
+				folio_put_swap(folio, subpage);
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_abort;
 			}
diff --git a/mm/shmem.c b/mm/shmem.c
index 46d54a1288fd..5e6cb763d945 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -982,7 +982,7 @@ static long shmem_free_swap(struct address_space *mapping,
 	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old != radswap)
 		return 0;
-	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
+	swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
 
 	return 1 << order;
 }
@@ -1665,7 +1665,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 			spin_unlock(&shmem_swaplist_lock);
 		}
 
-		swap_duplicate_nr(folio->swap, nr_pages);
+		folio_dup_swap(folio, NULL);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
 		BUG_ON(folio_mapped(folio));
@@ -1686,7 +1686,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		/* Swap entry might be erased by racing shmem_free_swap() */
 		if (!error) {
 			shmem_recalc_inode(inode, 0, -nr_pages);
-			swap_free_nr(folio->swap, nr_pages);
+			folio_put_swap(folio, NULL);
 		}
 
 		/*
@@ -2172,6 +2172,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 
 	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
+	folio_put_swap(folio, NULL);
 	swap_cache_del_folio(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
@@ -2179,7 +2180,6 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	 * in shmem_evict_inode().
 	 */
 	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
-	swap_free_nr(swap, nr_pages);
 }
 
 static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
@@ -2401,9 +2401,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
 
+	folio_put_swap(folio, NULL);
 	swap_cache_del_folio(folio);
 	folio_mark_dirty(folio);
-	swap_free_nr(swap, nr_pages);
 	put_swap_device(si);
 
 	*foliop = folio;
diff --git a/mm/swap.h b/mm/swap.h
index a3c5f2dca0d5..74c61129d7b7 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -183,6 +183,28 @@ static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
 	spin_unlock_irq(&ci->lock);
 }
 
+/*
+ * Below are the core routines for doing swap for a folio.
+ * All helpers requires the folio to be locked, and a locked folio
+ * in the swap cache pins the swap entries / slots allocated to the
+ * folio, swap relies heavily on the swap cache and folio lock for
+ * synchronization.
+ *
+ * folio_alloc_swap(): the entry point for a folio to be swapped
+ * out. It allocates swap slots and pins the slots with swap cache.
+ * The slots start with a swap count of zero.
+ *
+ * folio_dup_swap(): increases the swap count of a folio, usually
+ * during it gets unmapped and a swap entry is installed to replace
+ * it (e.g., swap entry in page table). A swap slot with swap
+ * count == 0 should only be increasd by this helper.
+ *
+ * folio_put_swap(): does the opposite thing of folio_dup_swap().
+ */
+int folio_alloc_swap(struct folio *folio);
+int folio_dup_swap(struct folio *folio, struct page *subpage);
+void folio_put_swap(struct folio *folio, struct page *subpage);
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -363,9 +385,24 @@ static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 	return NULL;
 }
 
+static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp)
+{
+	return -EINVAL;
+}
+
+static inline int folio_dup_swap(struct folio *folio, struct page *page)
+{
+	return -EINVAL;
+}
+
+static inline void folio_put_swap(struct folio *folio, struct page *page)
+{
+}
+
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
+
 static inline void swap_write_unplug(struct swap_iocb *sio)
 {
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 415db36d85d3..426b0b6d583f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -58,6 +58,9 @@ static void swap_entries_free(struct swap_info_struct *si,
 			      swp_entry_t entry, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr);
+static bool swap_entries_put_map(struct swap_info_struct *si,
+				 swp_entry_t entry, int nr);
 static bool folio_swapcache_freeable(struct folio *folio);
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
@@ -1467,6 +1470,12 @@ int folio_alloc_swap(struct folio *folio)
 	 */
 	WARN_ON_ONCE(swap_cache_add_folio(folio, entry, NULL, true));
 
+	/*
+	 * Allocator should always allocate aligned entries so folio based
+	 * operations never crossed more than one cluster.
+	 */
+	VM_WARN_ON_ONCE_FOLIO(!IS_ALIGNED(folio->swap.val, size), folio);
+
 	return 0;
 
 out_free:
@@ -1474,6 +1483,62 @@ int folio_alloc_swap(struct folio *folio)
 	return -ENOMEM;
 }
 
+/**
+ * folio_dup_swap() - Increase swap count of swap entries of a folio.
+ * @folio: folio with swap entries bounded.
+ * @subpage: if not NULL, only increase the swap count of this subpage.
+ *
+ * Context: Caller must ensure the folio is locked and in the swap cache.
+ * The caller also has to ensure there is no raced call to
+ * swap_put_entries_direct before this helper returns, or the swap
+ * map may underflow (TODO: maybe we should allow or avoid underflow to
+ * make swap refcount lockless).
+ */
+int folio_dup_swap(struct folio *folio, struct page *subpage)
+{
+	int err = 0;
+	swp_entry_t entry = folio->swap;
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio);
+
+	if (subpage) {
+		entry.val += folio_page_idx(folio, subpage);
+		nr_pages = 1;
+	}
+
+	while (!err && __swap_duplicate(entry, 1, nr_pages) == -ENOMEM)
+		err = add_swap_count_continuation(entry, GFP_ATOMIC);
+
+	return err;
+}
+
+/**
+ * folio_put_swap() - Decrease swap count of swap entries of a folio.
+ * @folio: folio with swap entries bounded, must be in swap cache and locked.
+ * @subpage: if not NULL, only decrease the swap count of this subpage.
+ *
+ * This won't free the swap slots even if swap count drops to zero, they are
+ * still pinned by the swap cache. User may call folio_free_swap to free them.
+ * Context: Caller must ensure the folio is locked and in the swap cache.
+ */
+void folio_put_swap(struct folio *folio, struct page *subpage)
+{
+	swp_entry_t entry = folio->swap;
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio);
+
+	if (subpage) {
+		entry.val += folio_page_idx(folio, subpage);
+		nr_pages = 1;
+	}
+
+	swap_entries_put_map(__swap_entry_to_info(entry), entry, nr_pages);
+}
+
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 {
 	struct swap_info_struct *si;
@@ -1714,28 +1779,6 @@ static void swap_entries_free(struct swap_info_struct *si,
 		partial_free_cluster(si, ci);
 }
 
-/*
- * Caller has made sure that the swap device corresponding to entry
- * is still around or has not been recycled.
- */
-void swap_free_nr(swp_entry_t entry, int nr_pages)
-{
-	int nr;
-	struct swap_info_struct *sis;
-	unsigned long offset = swp_offset(entry);
-
-	sis = _swap_info_get(entry);
-	if (!sis)
-		return;
-
-	while (nr_pages) {
-		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		swap_entries_put_map(sis, swp_entry(sis->type, offset), nr);
-		offset += nr;
-		nr_pages -= nr;
-	}
-}
-
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
@@ -1924,16 +1967,19 @@ bool folio_free_swap(struct folio *folio)
 }
 
 /**
- * free_swap_and_cache_nr() - Release reference on range of swap entries and
- *                            reclaim their cache if no more references remain.
+ * swap_put_entries_direct() - Release reference on range of swap entries and
+ *                             reclaim their cache if no more references remain.
  * @entry: First entry of range.
  * @nr: Number of entries in range.
  *
  * For each swap entry in the contiguous range, release a reference. If any swap
  * entries become free, try to reclaim their underlying folios, if present. The
  * offset range is defined by [entry.offset, entry.offset + nr).
+ *
+ * Context: Caller must ensure there is no race condition on the reference
+ * owner. e.g., locking the PTL of a PTE containing the entry being released.
  */
-void free_swap_and_cache_nr(swp_entry_t entry, int nr)
+void swap_put_entries_direct(swp_entry_t entry, int nr)
 {
 	const unsigned long start_offset = swp_offset(entry);
 	const unsigned long end_offset = start_offset + nr;
@@ -1942,10 +1988,9 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	unsigned long offset;
 
 	si = get_swap_device(entry);
-	if (!si)
+	if (WARN_ON_ONCE(!si))
 		return;
-
-	if (WARN_ON(end_offset > si->max))
+	if (WARN_ON_ONCE(end_offset > si->max))
 		goto out;
 
 	/*
@@ -1989,8 +2034,8 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 }
 
 #ifdef CONFIG_HIBERNATION
-
-swp_entry_t get_swap_page_of_type(int type)
+/* Allocate a slot for hibernation */
+swp_entry_t swap_alloc_hibernation_slot(int type)
 {
 	struct swap_info_struct *si = swap_type_to_info(type);
 	unsigned long offset;
@@ -2020,6 +2065,27 @@ swp_entry_t get_swap_page_of_type(int type)
 	return entry;
 }
 
+/* Free a slot allocated by swap_alloc_hibernation_slot */
+void swap_free_hibernation_slot(swp_entry_t entry)
+{
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	pgoff_t offset = swp_offset(entry);
+
+	si = get_swap_device(entry);
+	if (WARN_ON(!si))
+		return;
+
+	ci = swap_cluster_lock(si, offset);
+	swap_entry_put_locked(si, ci, entry, 1);
+	WARN_ON(swap_entry_swapped(si, offset));
+	swap_cluster_unlock(ci);
+
+	/* In theory readahead might add it to the swap cache by accident */
+	__try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
+	put_swap_device(si);
+}
+
 /*
  * Find the swap type that corresponds to given device (if any).
  *
@@ -2181,7 +2247,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	/*
 	 * Some architectures may have to restore extra metadata to the page
 	 * when reading from swap. This metadata may be indexed by swap entry
-	 * so this must be called before swap_free().
+	 * so this must be called before folio_put_swap().
 	 */
 	arch_swap_restore(folio_swap(entry, folio), folio);
 
@@ -2222,7 +2288,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		new_pte = pte_mkuffd_wp(new_pte);
 setpte:
 	set_pte_at(vma->vm_mm, addr, pte, new_pte);
-	swap_free(entry);
+	folio_put_swap(folio, page);
 out:
 	if (pte)
 		pte_unmap_unlock(pte, ptl);
@@ -3725,28 +3791,22 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	return err;
 }
 
-/**
- * swap_duplicate_nr() - Increase reference count of nr contiguous swap entries
- *                       by 1.
- *
+/*
+ * swap_dup_entry_direct() - Increase reference count of a swap entry by one.
  * @entry: first swap entry from which we want to increase the refcount.
- * @nr: Number of entries in range.
  *
  * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
  * but could not be atomically allocated.  Returns 0, just as if it succeeded,
  * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
  * might occur if a page table entry has got corrupted.
  *
- * Note that we are currently not handling the case where nr > 1 and we need to
- * add swap count continuation. This is OK, because no such user exists - shmem
- * is the only user that can pass nr > 1, and it never re-duplicates any swap
- * entry it owns.
+ * Context: Caller must ensure there is no race condition on the reference
+ * owner. e.g., locking the PTL of a PTE containing the entry being increased.
  */
-int swap_duplicate_nr(swp_entry_t entry, int nr)
+int swap_dup_entry_direct(swp_entry_t entry)
 {
 	int err = 0;
-
-	while (!err && __swap_duplicate(entry, 1, nr) == -ENOMEM)
+	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
 		err = add_swap_count_continuation(entry, GFP_ATOMIC);
 	return err;
 }

-- 
2.51.1


