Return-Path: <linux-kernel+bounces-782613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB82CB322BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F00F1CC8938
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1C2C327A;
	Fri, 22 Aug 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZX2SLWs"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2342D0C97
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890452; cv=none; b=at08YGs0drIQghXMGIoJCAj6guvRRJK9ZtxhxhFql96ZpX71bpR/zH1NfJePHjZdPSX251aOTbtWGm5XVJbDUH3cCioh/5mKwmVSF3MdAo1IJttTSp96o3SQ+fmlQqWsjHXSHkEKg1pfF71WdJKAVenHmzFQ92vlKf5O0CwACLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890452; c=relaxed/simple;
	bh=cDRXKhx85jlB8g5rnIzuJNCFec4cu/7fE4oo9Rho1Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWnVuJBkEGWlOzPENtAnGKIWEKN1wNVG7/KFESsmi/vXjlMDblW2nLGiPkvacP5CD1UvYNwr2dNFBZ35jnjatA75dg6Xf82SvzCkRD6+0OuMCA/xILAjwieTMHiQkvZWV62eFJ+fhjSMlfLM2KByiwTR1njTDh5bxrk27h632B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZX2SLWs; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70d93f5799bso13977426d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890450; x=1756495250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=scLHsbDs+ArcmFRsGn5Cx+L6FeMMrFmBpcYyEjUVG0s=;
        b=RZX2SLWswUfZWB/Tfp87D8rS4fv/TjJBLPQ7Zq6Xcw9hbalkOKC9b4SozDwPrEyOBi
         R31eV6Hby4gJwcvKwmE3lhoCdJEI4wxzy9N9MfBJGTsDBRzqHQcygvYvjndGWsatW1OL
         vosTli5FDYX4F/wVSfnGGyCmM/CV+y0Q8BmiHQRK0XHiKuMNFviaJ/HHpBqMnYOqjn8z
         hOUO6kRolM/VF4po0UOaDeg6BZ6W8bnVTuwMJRiWgF4MS1cu08GO+LiBRqe9L6K8Grio
         vzxyhcdedhLXiVC/YO0QwukH7nhp3ZVaqP+MDog6XM408HbOUCGvZ19EsNCm9OSYhnyb
         hIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890450; x=1756495250;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scLHsbDs+ArcmFRsGn5Cx+L6FeMMrFmBpcYyEjUVG0s=;
        b=ElW9NMqHUeeZt2qFRUTutp7pdpOLql+5E9jD4Qt9Jb3FcG7tFykcA4xhlcA4YiP3TR
         +ddCnZTwD5EAdSzvLUGowKxBhIHwAuo4efYcGL5nhxr2jTe1vyb6GPVB7kXuKWJ7hIHX
         H6OY4HwnLgA0HbsrK2ULIa87wADK+dUgwUwZUhUlhOnxwzWmd6ilzpV/qtlflGzmwenZ
         F9xLB2kQvPpC8z1RDuPBv6YDzgg+u5H7tEGTgbRPtWKURBqr1ZqtkM2c3YRb3fpVgvA2
         5XMt60AQPnXY8knvPqmWwWIXuI7Ce3TDdgGa5ajsI4WMeOKU4jVo0OGc1Nl+VQPHC1bA
         rmjw==
X-Forwarded-Encrypted: i=1; AJvYcCUZB8XgDG/gOo0+InY14wcLoM6Pt40T+GJTg6GpkCbm0qSNHRe/nH/dHOUY9B4iLDaVR/QEkLJ6jXsf8ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8tM9Sond2wY+sIOycJUN0+vPxiD6L7GGv1OmC/H1tR88AJnz
	iVsxriifYRyEEOsYLzRKnRLidK1+VI+5UUz9eYegxd4tTLqrlodYu7cc
X-Gm-Gg: ASbGncvIjAUlGIqi1jqT9YzFerzG5AkwIE4hQOHnk3WragQfE0lOA63t8tBrXQdh/wq
	B9apP2AMy9jmEn2vMPYK9P9Rr1hUX3beH8tsQ5WW68wlGmN2ewDP/KU/EEiwi8FWs8NY8zz6AyP
	CcHr4yjOYAGC2GvqAR11sSbu0Fgh0Ba35IVdQdLt0qG6759XvzvmKitQ8s+dHttxDqztiPpZBy9
	AqkpNc8V/hItN2ZquIwX8LXtgqZelEgJqajOrsgil4cOGGxucKB7bdAjX4MnkBxJHCmSX+xVZ04
	1hWdJK0/obCWwgyyGs+8a3zYP71nD/p+kdaK1VsqXIpxbo9gfgwP+x/i9813P1Rfe6aX0XlaPjT
	6Cmwiaf/y9ezzlPTu/djRX0JCm7yqEJbcDUzakzQQT4Q=
X-Google-Smtp-Source: AGHT+IFiwxZNvGWuVzEZPlsigrtEjNG+eiRSrQs49PTgdnaqUMY7rK4GzwChHIz9LB8CYcRy1pwq6Q==
X-Received: by 2002:ad4:5c6f:0:b0:70d:85d0:f85b with SMTP id 6a1803df08f44-70d970b2899mr56158606d6.10.1755890449755;
        Fri, 22 Aug 2025 12:20:49 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.20.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:20:49 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
Date: Sat, 23 Aug 2025 03:20:15 +0800
Message-ID: <20250822192023.13477-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
References: <20250822192023.13477-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Always use swap_cache_get_folio for swap cache folio look up. The reason
we are not using it in all places is that it also updates the readahead
info, and some callsites want to avoid that.

So decouple readahead update with swap cache lookup into a standalone
helper, let the caller call the readahead update helper if that's
needed. And convert all swap cache lookups to use swap_cache_get_folio.

After this commit, there are only three special cases for accessing swap
cache space now: huge memory splitting, migration and shmem replacing,
because they need to lock the Xarray. Following commits will wrap their
accesses to the swap cache too with special helpers.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c      |  6 ++-
 mm/mincore.c     |  3 +-
 mm/shmem.c       |  4 +-
 mm/swap.h        | 13 +++++--
 mm/swap_state.c  | 99 +++++++++++++++++++++++-------------------------
 mm/swapfile.c    | 11 +++---
 mm/userfaultfd.c |  5 +--
 7 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d9de6c056179..10ef528a5f44 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4660,9 +4660,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(!si))
 		goto out;
 
-	folio = swap_cache_get_folio(entry, vma, vmf->address);
-	if (folio)
+	folio = swap_cache_get_folio(entry);
+	if (folio) {
+		swap_update_readahead(folio, vma, vmf->address);
 		page = folio_file_page(folio, swp_offset(entry));
+	}
 	swapcache = folio;
 
 	if (!folio) {
diff --git a/mm/mincore.c b/mm/mincore.c
index 2f3e1816a30d..8ec4719370e1 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -76,8 +76,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 		if (!si)
 			return 0;
 	}
-	folio = filemap_get_entry(swap_address_space(entry),
-				  swap_cache_index(entry));
+	folio = swap_cache_get_folio(entry);
 	if (shmem)
 		put_swap_device(si);
 	/* The swap cache space contains either folio, shadow or NULL */
diff --git a/mm/shmem.c b/mm/shmem.c
index 13cc51df3893..e9d0d2784cd5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2354,7 +2354,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0);
+	folio = swap_cache_get_folio(swap);
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct swapin skipping swap cache & readahead */
@@ -2379,6 +2379,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
+	} else {
+		swap_update_readahead(folio, NULL, 0);
 	}
 
 	if (order > folio_order(folio)) {
diff --git a/mm/swap.h b/mm/swap.h
index 1ae44d4193b1..efb6d7ff9f30 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -62,8 +62,7 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr);
+struct folio *swap_cache_get_folio(swp_entry_t entry);
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
@@ -74,6 +73,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 		struct vm_fault *vmf);
+void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
+			   unsigned long addr);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -159,6 +160,11 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
+static inline void swap_update_readahead(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+}
+
 static inline int swap_writeout(struct folio *folio,
 		struct swap_iocb **swap_plug)
 {
@@ -169,8 +175,7 @@ static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entr
 {
 }
 
-static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 99513b74b5d8..ff9eb761a103 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -69,6 +69,21 @@ void show_swap_cache_info(void)
 	printk("Total swap = %lukB\n", K(total_swap_pages));
 }
 
+/*
+ * Lookup a swap entry in the swap cache. A found folio will be returned
+ * unlocked and with its refcount incremented.
+ *
+ * Caller must lock the swap device or hold a reference to keep it valid.
+ */
+struct folio *swap_cache_get_folio(swp_entry_t entry)
+{
+	struct folio *folio = filemap_get_folio(swap_address_space(entry),
+						swap_cache_index(entry));
+	if (!IS_ERR(folio))
+		return folio;
+	return NULL;
+}
+
 void *get_shadow_from_swap_cache(swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
@@ -273,54 +288,40 @@ static inline bool swap_use_vma_readahead(void)
 }
 
 /*
- * Lookup a swap entry in the swap cache. A found folio will be returned
- * unlocked and with its refcount incremented - we rely on the kernel
- * lock getting page table operations atomic even if we drop the folio
- * lock before returning.
- *
- * Caller must lock the swap device or hold a reference to keep it valid.
+ * Update the readahead statistics of a vma or globally.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+void swap_update_readahead(struct folio *folio,
+			   struct vm_area_struct *vma,
+			   unsigned long addr)
 {
-	struct folio *folio;
-
-	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
-	if (!IS_ERR(folio)) {
-		bool vma_ra = swap_use_vma_readahead();
-		bool readahead;
+	bool readahead, vma_ra = swap_use_vma_readahead();
 
-		/*
-		 * At the moment, we don't support PG_readahead for anon THP
-		 * so let's bail out rather than confusing the readahead stat.
-		 */
-		if (unlikely(folio_test_large(folio)))
-			return folio;
-
-		readahead = folio_test_clear_readahead(folio);
-		if (vma && vma_ra) {
-			unsigned long ra_val;
-			int win, hits;
-
-			ra_val = GET_SWAP_RA_VAL(vma);
-			win = SWAP_RA_WIN(ra_val);
-			hits = SWAP_RA_HITS(ra_val);
-			if (readahead)
-				hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
-			atomic_long_set(&vma->swap_readahead_info,
-					SWAP_RA_VAL(addr, win, hits));
-		}
-
-		if (readahead) {
-			count_vm_event(SWAP_RA_HIT);
-			if (!vma || !vma_ra)
-				atomic_inc(&swapin_readahead_hits);
-		}
-	} else {
-		folio = NULL;
+	/*
+	 * At the moment, we don't support PG_readahead for anon THP
+	 * so let's bail out rather than confusing the readahead stat.
+	 */
+	if (unlikely(folio_test_large(folio)))
+		return;
+
+	readahead = folio_test_clear_readahead(folio);
+	if (vma && vma_ra) {
+		unsigned long ra_val;
+		int win, hits;
+
+		ra_val = GET_SWAP_RA_VAL(vma);
+		win = SWAP_RA_WIN(ra_val);
+		hits = SWAP_RA_HITS(ra_val);
+		if (readahead)
+			hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
+		atomic_long_set(&vma->swap_readahead_info,
+				SWAP_RA_VAL(addr, win, hits));
 	}
 
-	return folio;
+	if (readahead) {
+		count_vm_event(SWAP_RA_HIT);
+		if (!vma || !vma_ra)
+			atomic_inc(&swapin_readahead_hits);
+	}
 }
 
 struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
@@ -336,14 +337,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	*new_page_allocated = false;
 	for (;;) {
 		int err;
-		/*
-		 * First check the swap cache.  Since this is normally
-		 * called after swap_cache_get_folio() failed, re-calling
-		 * that would confuse statistics.
-		 */
-		folio = filemap_get_folio(swap_address_space(entry),
-					  swap_cache_index(entry));
-		if (!IS_ERR(folio))
+
+		/* Check the swap cache in case the folio is already there */
+		folio = swap_cache_get_folio(entry);
+		if (folio)
 			goto got_folio;
 
 		/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a7ffabbe65ef..4b8ab2cb49ca 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -213,15 +213,14 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
 	swp_entry_t entry = swp_entry(si->type, offset);
-	struct address_space *address_space = swap_address_space(entry);
 	struct swap_cluster_info *ci;
 	struct folio *folio;
 	int ret, nr_pages;
 	bool need_reclaim;
 
 again:
-	folio = filemap_get_folio(address_space, swap_cache_index(entry));
-	if (IS_ERR(folio))
+	folio = swap_cache_get_folio(entry);
+	if (!folio)
 		return 0;
 
 	nr_pages = folio_nr_pages(folio);
@@ -2131,7 +2130,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		pte_unmap(pte);
 		pte = NULL;
 
-		folio = swap_cache_get_folio(entry, vma, addr);
+		folio = swap_cache_get_folio(entry);
 		if (!folio) {
 			struct vm_fault vmf = {
 				.vma = vma,
@@ -2357,8 +2356,8 @@ static int try_to_unuse(unsigned int type)
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
 		entry = swp_entry(type, i);
-		folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
-		if (IS_ERR(folio))
+		folio = swap_cache_get_folio(entry);
+		if (!folio)
 			continue;
 
 		/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 50aaa8dcd24c..af61b95c89e4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1489,9 +1489,8 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 		 * separately to allow proper handling.
 		 */
 		if (!src_folio)
-			folio = filemap_get_folio(swap_address_space(entry),
-					swap_cache_index(entry));
-		if (!IS_ERR_OR_NULL(folio)) {
+			folio = swap_cache_get_folio(entry);
+		if (folio) {
 			if (folio_test_large(folio)) {
 				ret = -EBUSY;
 				folio_put(folio);
-- 
2.51.0


