Return-Path: <linux-kernel+bounces-782618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C5B322BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804B7640AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2B2D0C8D;
	Fri, 22 Aug 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAA+E2+B"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E02D130A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890485; cv=none; b=MvZptLWuDwBR5xZlLp1/sFX6X9l6zz8VU2qolln5hh1CcICPsxGkXFFxnqTxhypxme7f8ifQ2RUntrwRq0lAVM9HTZEMPxLGjkA1aKa5YL3fwzWCIX1S0gCfGDPWYs3e3QXPwcPWf01nIY1Pvkp9zPK8bCKVtTY/I5Q+ZPgYy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890485; c=relaxed/simple;
	bh=h2S1QN9MeAb9qDest3HnSpPOpoG4EjZjaB031Qdc+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQ11Wys2j8dfARvBfnnxYzALrPtTQfQH1E5uql9sDwP/6BcQV2DW8R8vCI3KnoX2YoyjT9MSrgC3DkWwxvUPHfBwSG6BNV3N1c8wnfdSmhC5KCuN4Qan1DV9OK9b77om2+CB5NJqlVuQWE4cqkKSPVaZkt7QfBvVVsip7/eV4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAA+E2+B; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87068760bso288920285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890481; x=1756495281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yk1MoPn6Ky673Ox5GotUkZ/TaW7Eguue9tZYIG/fSRw=;
        b=SAA+E2+BqRbPpLcXGEid4qyAmgR1Te058JxngTi3VKPr4Wvx/8glBej8mbPONClxMo
         a7pijnGHqz0EKK3R8Gs52kHJRI1lI37oHcoRamz+DBwjGhbe7J9aSmF0hGG2AjKmK+wu
         YgN3MIF4OfSL62HH1fw9qDADzD+iXUnq9WrWtuOSi6dHOOYqYQDg6vEdGi4nMqBEUhmh
         //3v6t1iEqkXUrq5EbUQqczbvTNf8Aubv3fwfPPLY9+bvSrSSNx6R5tmpnEFe9sXe4+K
         xSXx/UjD57fvu+PBodheqBcwvVoEHr+WCMhQAgaagvfIynpiuFw2l5GwFHhnQiyDLvBU
         sWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890481; x=1756495281;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yk1MoPn6Ky673Ox5GotUkZ/TaW7Eguue9tZYIG/fSRw=;
        b=Ne0DDt2Dy7J96TR2/icgwHU5JWwe0mW4/L5kiTRZlQtZzK+vw1YcnBiC2db0GZKxwK
         2Z6i/LdYK47RSZgWzKPUCSX0y3PZOOO9kDQNfdrp7oIsIvWa6FE/pcGKlXamvfqJWVo/
         IObNIf8t1ojtDoXWNRPuyc+Zs58dI6Mszfj8iSFemSGyxiO1EfHgYKf+VmSaoxURSCVK
         RfLz3DogM958Evl7YNtk32XvGb/JxQdzvxUyQRru7O1EJ8+47C0Se4S6JHPYKgKh8t/E
         /eP2s7Wxyz9B6d/BTH7I/JVjx2WXB52YtBen1arxLRztxJqL4acc0lGwhHnqC+ohVddE
         FeIg==
X-Forwarded-Encrypted: i=1; AJvYcCXSbSQjsy6qTvOFwHc4zvb68vBYu9p9/Sv7NgMPwlVq9/6spdUehcV5Ln+0IXhtplfk5yk8ov32A+Lc8fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1o0fyny4mNFu0D/0h8ej8QGgAQgSALZarX9JvAn943riSou2
	9JV+iY8p6Z0ArEOdd9LotiPZ/MIzDOQ5I9jyv6rmVMGvjF64RiexkKHj
X-Gm-Gg: ASbGncvCtIuXFRPFN4G4OhYHhEnAFijwNG6liUd3ue0phL3quOIhLWqotWzz98gX4xo
	i60l37nJAokNsampyVs0XzXI5gDkn6LShf/BAYER2PYsWsSxHbzzgIVVn9e/RFg57i0Wg513H49
	U5zobk2Nip+1yEj9i/vYkzLjZSKtqhKbfPlqGdJQ5xLzNfA23q9S4QLtR+Szq+R/l7qssCuu6VJ
	RKYGc7aGbfdMGfIR+865v0P9zP0yTQ6gv+aFPeCS1tbd0ymy7AP6aVov6zCjty9jDucl1gf7ydt
	wz7ynnCrSUIEGjTokKAg/Wjbk7hlt+rHxEieOGUhD+Pof/8q832F6BlcR5+mtkCfLe/Hg8EpwFI
	uWFRnPz97BJ3SyvdP8EVsHtcud6hjXwJwxrcK1BCtYOvpwyC5nIk4ng==
X-Google-Smtp-Source: AGHT+IHquE7zcv0x/HIB4hqp2iN/rZ+Zxp3YqRJph3Gu52Y1zFMOLmdJqX+ZFOlq6uVNGZNNEVHMog==
X-Received: by 2002:a05:620a:4085:b0:7ea:458:e6e6 with SMTP id af79cd13be357-7ea11039e4bmr447150485a.42.1755890481157;
        Fri, 22 Aug 2025 12:21:21 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.21.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:21:20 -0700 (PDT)
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
Subject: [PATCH 6/9] mm, swap: use the swap table for the swap cache and switch API
Date: Sat, 23 Aug 2025 03:20:20 +0800
Message-ID: <20250822192023.13477-7-ryncsn@gmail.com>
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

Introduce basic swap table infrastructures, which are now just a
fixed-sized flat array inside each swap cluster, with access wrappers.

Each cluster contains a swap table of 512 entries. Each table entry is
an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE),
a folio type (pointer), or NULL.

In this first step, it only supports storing a folio or shadow, and it
is a drop-in replacement for the current swap cache. Convert all swap
cache users to use the new sets of APIs. Chris Li has been suggesting
using a new infrastructure for swap cache for better performance, and
that idea combined well with the swap table as the new backing
structure. Now the lock contention range is reduced to 2M clusters,
which is much smaller than the 64M address_space. And we can also drop
the multiple address_space design.

All the internal works are done with swap_cache_get_* helpers. Swap
cache lookup is still lock-less like before, and the helper's contexts
are same with original swap cache helpers. They still require a pin
on the swap device to prevent the backing data from being freed.

Swap cache updates are now protected by the swap cluster lock
instead of the Xarray lock. This is mostly handled internally, but new
__swap_cache_* helpers require the caller to lock the cluster. So, a
few new cluster access and locking helpers are also introduced.

A fully cluster-based unified swap table can be implemented on top
of this to take care of all count tracking and synchronization work,
with dynamic allocation. It should reduce the memory usage while
making the performance even better.

Co-developed-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 MAINTAINERS          |   1 +
 include/linux/swap.h |   2 -
 mm/filemap.c         |   2 +-
 mm/huge_memory.c     |  16 +--
 mm/memory-failure.c  |   2 +-
 mm/memory.c          |   2 +-
 mm/migrate.c         |  28 ++--
 mm/shmem.c           |  26 ++--
 mm/swap.h            | 151 +++++++++++++++------
 mm/swap_state.c      | 315 +++++++++++++++++++++----------------------
 mm/swap_table.h      | 106 +++++++++++++++
 mm/swapfile.c        | 105 +++++++++++----
 mm/vmscan.c          |  20 ++-
 mm/zswap.c           |   2 +-
 14 files changed, 500 insertions(+), 278 deletions(-)
 create mode 100644 mm/swap_table.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b6f7c6939ff8..b78adfb3c7f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16214,6 +16214,7 @@ F:	include/linux/swapops.h
 F:	mm/page_io.c
 F:	mm/swap.c
 F:	mm/swap.h
+F:	mm/swap_table.h
 F:	mm/swap_state.c
 F:	mm/swapfile.c
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index cb59c13fef42..7455df9bf340 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -470,8 +470,6 @@ extern int __swap_count(swp_entry_t entry);
 extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 struct backing_dev_info;
-extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
-extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index e4a5a46db89b..1fd0565b56e4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4504,7 +4504,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				 * invalidation, so there might not be
 				 * a shadow in the swapcache (yet).
 				 */
-				shadow = get_shadow_from_swap_cache(swp);
+				shadow = swap_cache_get_shadow(swp);
 				if (!shadow)
 					goto resched;
 			}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47cd3bb649..209580d395a1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3721,7 +3721,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		struct address_space *swap_cache = NULL;
+		struct swap_cluster_info *swp_ci = NULL;
 		struct lruvec *lruvec;
 		int expected_refs;
 
@@ -3765,8 +3765,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 				goto fail;
 			}
 
-			swap_cache = swap_address_space(folio->swap);
-			xa_lock(&swap_cache->i_pages);
+			swp_ci = swap_cluster_lock_by_folio(folio);
 		}
 
 		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
@@ -3798,10 +3797,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 * Anonymous folio with swap cache.
 			 * NOTE: shmem in swap cache is not supported yet.
 			 */
-			if (swap_cache) {
-				__xa_store(&swap_cache->i_pages,
-					   swap_cache_index(new_folio->swap),
-					   new_folio, 0);
+			if (swp_ci) {
+				__swap_cache_replace_folio(swp_ci, new_folio->swap,
+							   folio, new_folio);
 				continue;
 			}
 
@@ -3836,8 +3834,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		unlock_page_lruvec(lruvec);
 
-		if (swap_cache)
-			xa_unlock(&swap_cache->i_pages);
+		if (swp_ci)
+			swap_cluster_unlock(swp_ci);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 		ret = -EAGAIN;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c15ffee7d32b..bb92d0c72aec 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1199,7 +1199,7 @@ static int me_swapcache_clean(struct page_state *ps, struct page *p)
 	struct folio *folio = page_folio(p);
 	int ret;
 
-	delete_from_swap_cache(folio);
+	swap_cache_del_folio(folio);
 
 	ret = delete_from_lru_cache(folio) ? MF_FAILED : MF_RECOVERED;
 	folio_unlock(folio);
diff --git a/mm/memory.c b/mm/memory.c
index 9ca8e1873c6e..f81bf06e6ff5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4696,7 +4696,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				memcg1_swapin(entry, nr_pages);
 
-				shadow = get_shadow_from_swap_cache(entry);
+				shadow = swap_cache_get_shadow(entry);
 				if (shadow)
 					workingset_refault(folio, shadow);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8e435a078fc3..74db32caba2d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -563,10 +563,10 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int expected_count)
 {
 	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
+	struct swap_cluster_info *swp_ci = NULL;
 	struct zone *oldzone, *newzone;
 	int dirty;
 	long nr = folio_nr_pages(folio);
-	long entries, i;
 
 	if (!mapping) {
 		/* Take off deferred split queue while frozen and memcg set */
@@ -592,9 +592,16 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	oldzone = folio_zone(folio);
 	newzone = folio_zone(newfolio);
 
-	xas_lock_irq(&xas);
+	if (folio_test_swapcache(folio))
+		swp_ci = swap_cluster_lock_by_folio_irq(folio);
+	else
+		xas_lock_irq(&xas);
+
 	if (!folio_ref_freeze(folio, expected_count)) {
-		xas_unlock_irq(&xas);
+		if (swp_ci)
+			swap_cluster_unlock(swp_ci);
+		else
+			xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
@@ -615,9 +622,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_swapcache(folio)) {
 		folio_set_swapcache(newfolio);
 		newfolio->private = folio_get_private(folio);
-		entries = nr;
-	} else {
-		entries = 1;
 	}
 
 	/* Move dirty while folio refs frozen and newfolio not yet exposed */
@@ -627,11 +631,10 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		folio_set_dirty(newfolio);
 	}
 
-	/* Swap cache still stores N entries instead of a high-order entry */
-	for (i = 0; i < entries; i++) {
+	if (folio_test_swapcache(folio))
+		__swap_cache_replace_folio(swp_ci, folio->swap, folio, newfolio);
+	else
 		xas_store(&xas, newfolio);
-		xas_next(&xas);
-	}
 
 	/*
 	 * Drop cache reference from old folio by unfreezing
@@ -640,8 +643,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	 */
 	folio_ref_unfreeze(folio, expected_count - nr);
 
-	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
+	if (swp_ci)
+		swap_cluster_unlock(swp_ci);
+	else
+		xas_unlock(&xas);
 
 	/*
 	 * If moved to a different zone then also account
diff --git a/mm/shmem.c b/mm/shmem.c
index e03793cc5169..f088115cf209 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1698,13 +1698,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		}
 
 		/*
-		 * The delete_from_swap_cache() below could be left for
+		 * The swap_cache_del_folio() below could be left for
 		 * shrink_folio_list()'s folio_free_swap() to dispose of;
 		 * but I'm a little nervous about letting this folio out of
 		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
 		 * e.g. folio_mapping(folio) might give an unexpected answer.
 		 */
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 		goto redirty;
 	}
 	if (nr_pages > 1)
@@ -2082,7 +2082,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	new->swap = entry;
 
 	memcg1_swapin(entry, nr_pages);
-	shadow = get_shadow_from_swap_cache(entry);
+	shadow = swap_cache_get_shadow(entry);
 	if (shadow)
 		workingset_refault(new, shadow);
 	folio_add_lru(new);
@@ -2120,13 +2120,11 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 				struct shmem_inode_info *info, pgoff_t index,
 				struct vm_area_struct *vma)
 {
+	struct swap_cluster_info *ci;
 	struct folio *new, *old = *foliop;
 	swp_entry_t entry = old->swap;
-	struct address_space *swap_mapping = swap_address_space(entry);
-	pgoff_t swap_index = swap_cache_index(entry);
-	XA_STATE(xas, &swap_mapping->i_pages, swap_index);
 	int nr_pages = folio_nr_pages(old);
-	int error = 0, i;
+	int error = 0;
 
 	/*
 	 * We have arrived here because our zones are constrained, so don't
@@ -2155,13 +2153,9 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	/* Swap cache still stores N entries instead of a high-order entry */
-	xa_lock_irq(&swap_mapping->i_pages);
-	for (i = 0; i < nr_pages; i++) {
-		WARN_ON_ONCE(xas_store(&xas, new));
-		xas_next(&xas);
-	}
-	xa_unlock_irq(&swap_mapping->i_pages);
+	ci = swap_cluster_lock_by_folio_irq(old);
+	__swap_cache_replace_folio(ci, entry, old, new);
+	swap_cluster_unlock(ci);
 
 	folio_add_lru(new);
 	*foliop = new;
@@ -2198,7 +2192,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
 	if (!skip_swapcache)
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
@@ -2438,7 +2432,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio->swap.val = 0;
 		swapcache_clear(si, swap, nr_pages);
 	} else {
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 	}
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
diff --git a/mm/swap.h b/mm/swap.h
index 7b3efaa51624..4af42bc2cd72 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -2,6 +2,7 @@
 #ifndef _MM_SWAP_H
 #define _MM_SWAP_H
 
+#include <linux/atomic.h> /* for atomic_long_t */
 struct mempolicy;
 struct swap_iocb;
 
@@ -35,6 +36,7 @@ struct swap_cluster_info {
 	u16 count;
 	u8 flags;
 	u8 order;
+	atomic_long_t *table;	/* Swap table entries, see mm/swap_table.h */
 	struct list_head list;
 };
 
@@ -80,22 +82,62 @@ static inline struct swap_cluster_info *swp_offset_cluster(
 	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
 }
 
-static inline struct swap_cluster_info *swap_cluster_lock(
-		struct swap_info_struct *si,
-		unsigned long offset)
+static inline struct swap_cluster_info *swp_cluster(swp_entry_t entry)
+{
+	return swp_offset_cluster(swp_info(entry), swp_offset(entry));
+}
+
+static inline unsigned int swp_cluster_offset(swp_entry_t entry)
+{
+	return swp_offset(entry) % SWAPFILE_CLUSTER;
+}
+
+/*
+ * Lock the swap cluster of the given offset. The caller must ensure the swap
+ * offset is valid and that the following accesses won't go beyond the locked
+ * cluster. swap_cluster_lock_by_folio is preferred when possible
+ */
+static __always_inline struct swap_cluster_info *__swap_cluster_lock(
+		struct swap_info_struct *si, unsigned long offset, bool irq)
 {
 	struct swap_cluster_info *ci = swp_offset_cluster(si, offset);
 
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
-	spin_lock(&ci->lock);
+	if (irq)
+		spin_lock_irq(&ci->lock);
+	else
+		spin_lock(&ci->lock);
 	return ci;
 }
+#define swap_cluster_lock(si, off) __swap_cluster_lock(si, off, false)
+
+/*
+ * Lock the swap cluster that holds a folio's swap entries. Caller needs to lock
+ * the folio and ensure it's in the swap cache, and only touch the folio's swap
+ * entries. A folio's entries are always in one cluster, and a locked folio lock
+ * ensures it won't be freed from the swap cache, hence stabilizing the device.
+ */
+static inline struct swap_cluster_info *__swap_cluster_lock_by_folio(
+		struct folio *folio, bool irq)
+{
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	return __swap_cluster_lock(swp_info(folio->swap),
+				   swp_offset(folio->swap), irq);
+}
+#define swap_cluster_lock_by_folio(folio) __swap_cluster_lock_by_folio(folio, false)
+#define swap_cluster_lock_by_folio_irq(folio) __swap_cluster_lock_by_folio(folio, true)
 
 static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
 {
 	spin_unlock(&ci->lock);
 }
 
+static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
+{
+	spin_unlock_irq(&ci->lock);
+}
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -115,10 +157,11 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
 #define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
-extern struct address_space *swapper_spaces[];
-#define swap_address_space(entry)			    \
-	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
-		>> SWAP_ADDRESS_SPACE_SHIFT])
+extern struct address_space swap_space __ro_after_init;
+static inline struct address_space *swap_address_space(swp_entry_t entry)
+{
+	return &swap_space;
+}
 
 /*
  * Return the swap device position of the swap entry.
@@ -128,15 +171,6 @@ static inline loff_t swap_dev_pos(swp_entry_t entry)
 	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
 }
 
-/*
- * Return the swap cache index of the swap entry.
- */
-static inline pgoff_t swap_cache_index(swp_entry_t entry)
-{
-	BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) != SWP_OFFSET_MASK);
-	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
-}
-
 /**
  * folio_contains_swap - Does this folio contain this swap entry?
  * @folio: The folio.
@@ -160,17 +194,31 @@ static inline bool folio_contains_swap(struct folio *folio, swp_entry_t entry)
 	return offset - swp_offset(folio->swap) < folio_nr_pages(folio);
 }
 
+/*
+ * All swap cache helpers below require the caller to ensure the swap entries
+ * are valid and pin the device. This can be guaranteed by:
+ * - get_swap_device: this ensures a single entry is valid and increases the
+ *   swap device's refcount.
+ * - Locking a folio in the swap cache: this ensures the folio won't be freed
+ *   from the swap cache, stabilizes its entries, and the swap device.
+ * - Locking anything referencing the swap entry: e.g. locking the PTL that
+ *   protects swap entries in the page table, so they won't be freed.
+ */
+extern struct folio *swap_cache_get_folio(swp_entry_t entry);
+extern void *swap_cache_get_shadow(swp_entry_t entry);
+extern int swap_cache_add_folio(swp_entry_t entry,
+				struct folio *folio, void **shadow);
+extern void swap_cache_del_folio(struct folio *folio);
+/* Below helpers also require the caller to lock the swap cluster. */
+extern void __swap_cache_del_folio(swp_entry_t entry,
+				   struct folio *folio, void *shadow);
+extern void __swap_cache_replace_folio(struct swap_cluster_info *ci,
+				      swp_entry_t entry, struct folio *old,
+				      struct folio *new);
+extern void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents);
+
 void show_swap_cache_info(void);
-void *get_shadow_from_swap_cache(swp_entry_t entry);
-int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-		      gfp_t gfp, void **shadowp);
-void __delete_from_swap_cache(struct folio *folio,
-			      swp_entry_t entry, void *shadow);
-void delete_from_swap_cache(struct folio *folio);
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				  unsigned long end);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
-struct folio *swap_cache_get_folio(swp_entry_t entry);
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
@@ -235,6 +283,33 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 
 #else /* CONFIG_SWAP */
 struct swap_iocb;
+
+static inline struct swap_cluster_info *swap_cluster_lock(
+	struct swap_info_struct *si, pgoff_t offset, bool irq)
+{
+	return NULL;
+}
+
+static inline struct swap_cluster_info *swap_cluster_lock_by_folio(
+		struct folio *folio)
+{
+	return NULL;
+}
+
+static inline struct swap_cluster_info *swap_cluster_lock_by_folio_irq(
+		struct folio *folio)
+{
+	return NULL;
+}
+
+static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
+{
+}
+
+static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
+{
+}
+
 static inline struct swap_info_struct *swp_info(swp_entry_t entry)
 {
 	return NULL;
@@ -252,11 +327,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 	return NULL;
 }
 
-static inline pgoff_t swap_cache_index(swp_entry_t entry)
-{
-	return 0;
-}
-
 static inline bool folio_contains_swap(struct folio *folio, swp_entry_t entry)
 {
 	return false;
@@ -298,28 +368,27 @@ static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
 	return NULL;
 }
 
-static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
+static inline void *swap_cache_get_shadow(swp_entry_t end)
 {
 	return NULL;
 }
 
-static inline int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-					gfp_t gfp_mask, void **shadowp)
+static inline int swap_cache_add_folio(swp_entry_t end, struct folio *folio, void **shadow)
 {
-	return -1;
+	return -EINVAL;
 }
 
-static inline void __delete_from_swap_cache(struct folio *folio,
-					swp_entry_t entry, void *shadow)
+static inline void swap_cache_del_folio(struct folio *folio)
 {
 }
 
-static inline void delete_from_swap_cache(struct folio *folio)
+static inline void __swap_cache_del_folio(swp_entry_t entry, struct folio *folio, void *shadow)
 {
 }
 
-static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+static inline void __swap_cache_replace_folio(
+		struct swap_cluster_info *ci, swp_entry_t entry,
+		struct folio *old, struct folio *new)
 {
 }
 
@@ -354,7 +423,7 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 static inline pgoff_t folio_index(struct folio *folio)
 {
 	if (unlikely(folio_test_swapcache(folio)))
-		return swap_cache_index(folio->swap);
+		return swp_offset(folio->swap);
 	return folio->index;
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 721ff1a5e73a..c0342024b4a8 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -23,6 +23,7 @@
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
 #include "internal.h"
+#include "swap_table.h"
 #include "swap.h"
 
 /*
@@ -36,8 +37,11 @@ static const struct address_space_operations swap_aops = {
 #endif
 };
 
-struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
-static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
+/* Set swap_space is read only as swap cache is handled by swap table */
+struct address_space swap_space __ro_after_init = {
+	.a_ops = &swap_aops,
+};
+
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_ORDER_CEILING	5
@@ -69,7 +73,7 @@ void show_swap_cache_info(void)
 	printk("Total swap = %lukB\n", K(total_swap_pages));
 }
 
-/*
+/**
  * swap_cache_get_folio - Lookup a swap entry in the swap cache.
  *
  * A found folio will be returned unlocked and with its refcount increased.
@@ -79,155 +83,179 @@ void show_swap_cache_info(void)
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
-	struct folio *folio = filemap_get_folio(swap_address_space(entry),
-						swap_cache_index(entry));
-	if (!IS_ERR(folio))
-		return folio;
+	unsigned long swp_tb;
+	struct folio *folio;
+
+	for (;;) {
+		swp_tb = __swap_table_get(swp_cluster(entry), swp_cluster_offset(entry));
+		if (!swp_tb_is_folio(swp_tb))
+			return NULL;
+		folio = swp_tb_to_folio(swp_tb);
+		if (folio_try_get(folio))
+			return folio;
+	}
+
 	return NULL;
 }
 
-void *get_shadow_from_swap_cache(swp_entry_t entry)
+/**
+ * swap_cache_get_shadow - Lookup a shadow in the swap cache.
+ *
+ * Context: Caller must ensure @entry is valid and pin the swap device.
+ */
+void *swap_cache_get_shadow(swp_entry_t entry)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swap_cache_index(entry);
-	void *shadow;
+	unsigned long swp_tb;
+
+	swp_tb = __swap_table_get(swp_cluster(entry), swp_cluster_offset(entry));
+	if (swp_tb_is_shadow(swp_tb))
+		return swp_tb_to_shadow(swp_tb);
 
-	shadow = xa_load(&address_space->i_pages, idx);
-	if (xa_is_value(shadow))
-		return shadow;
 	return NULL;
 }
 
-/*
- * add_to_swap_cache resembles filemap_add_folio on swapper_space,
- * but sets SwapCache flag and 'swap' instead of mapping and index.
+/**
+ * swap_cache_add_folio -  add a folio into the swap cache.
+ *
+ * The folio will be used for swapin or swapout of swap entries
+ * starting with @entry. May fail due to race.
+ *
+ * Context: Caller must ensure @entry is valid and pin the swap device.
  */
-int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-			gfp_t gfp, void **shadowp)
+int swap_cache_add_folio(swp_entry_t entry, struct folio *folio, void **shadowp)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	pgoff_t idx = swap_cache_index(entry);
-	XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(folio));
-	unsigned long i, nr = folio_nr_pages(folio);
-	void *old;
-
-	xas_set_update(&xas, workingset_update_node);
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
+	unsigned long exist;
+	void *shadow = NULL;
+	struct swap_cluster_info *ci;
+	unsigned int ci_start, ci_off, ci_end;
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
+
+	ci = swap_cluster_lock(swp_info(entry), swp_offset(entry));
+	ci_start = swp_cluster_offset(entry);
+	ci_end = ci_start + nr_pages;
+	ci_off = ci_start;
+	do {
+		exist = __swap_table_get(ci, ci_off);
+		if (unlikely(swp_tb_is_folio(exist)))
+			goto fail;
+		if (swp_tb_is_shadow(exist))
+			shadow = swp_tb_to_shadow(exist);
+	} while (++ci_off < ci_end);
+
+	ci_off = ci_start;
+	do {
+		__swap_table_set_folio(ci, ci_off, folio);
+	} while (++ci_off < ci_end);
 
-	folio_ref_add(folio, nr);
+	folio_ref_add(folio, nr_pages);
 	folio_set_swapcache(folio);
 	folio->swap = entry;
+	swap_cluster_unlock(ci);
 
-	do {
-		xas_lock_irq(&xas);
-		xas_create_range(&xas);
-		if (xas_error(&xas))
-			goto unlock;
-		for (i = 0; i < nr; i++) {
-			VM_BUG_ON_FOLIO(xas.xa_index != idx + i, folio);
-			if (shadowp) {
-				old = xas_load(&xas);
-				if (xa_is_value(old))
-					*shadowp = old;
-			}
-			xas_store(&xas, folio);
-			xas_next(&xas);
-		}
-		address_space->nrpages += nr;
-		__node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-		__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
-unlock:
-		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
-
-	if (!xas_error(&xas))
-		return 0;
+	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 
-	folio_clear_swapcache(folio);
-	folio_ref_sub(folio, nr);
-	return xas_error(&xas);
+	if (shadowp)
+		*shadowp = shadow;
+	return 0;
+fail:
+	swap_cluster_unlock(ci);
+	return -EEXIST;
 }
 
 /*
- * This must be called only on folios that have
- * been verified to be in the swap cache.
+ * Caller must ensure the folio is in the swap cache and locked,
+ * also lock the swap cluster.
  */
-void __delete_from_swap_cache(struct folio *folio,
-			swp_entry_t entry, void *shadow)
+void __swap_cache_del_folio(swp_entry_t entry, struct folio *folio,
+			    void *shadow)
 {
-	struct address_space *address_space = swap_address_space(entry);
-	int i;
-	long nr = folio_nr_pages(folio);
-	pgoff_t idx = swap_cache_index(entry);
-	XA_STATE(xas, &address_space->i_pages, idx);
-
-	xas_set_update(&xas, workingset_update_node);
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
-
-	for (i = 0; i < nr; i++) {
-		void *entry = xas_store(&xas, shadow);
-		VM_BUG_ON_PAGE(entry != folio, entry);
-		xas_next(&xas);
-	}
+	unsigned long exist;
+	struct swap_cluster_info *ci;
+	unsigned int ci_start, ci_off, ci_end;
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_writeback(folio), folio);
+
+	ci = swp_offset_cluster(swp_info(entry), swp_offset(entry));
+	ci_start = swp_cluster_offset(entry);
+	ci_end = ci_start + nr_pages;
+	ci_off = ci_start;
+	do {
+		exist = __swap_table_get(ci, ci_off);
+		VM_WARN_ON_ONCE(swp_tb_to_folio(exist) != folio);
+		/* If shadow is NULL, we sets an empty shadow */
+		__swap_table_set_shadow(ci, ci_off, shadow);
+	} while (++ci_off < ci_end);
+
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
-	address_space->nrpages -= nr;
-	__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
-	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
+	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
 }
 
 /*
- * This must be called only on folios that have
- * been verified to be in the swap cache and locked.
- * It will never put the folio into the free list,
- * the caller has a reference on the folio.
+ * Replace an old folio in the swap cache with a new one. The caller must
+ * hold the cluster lock and set the new folio's entry and flags.
  */
-void delete_from_swap_cache(struct folio *folio)
+void __swap_cache_replace_folio(struct swap_cluster_info *ci, swp_entry_t entry,
+				struct folio *old, struct folio *new)
+{
+	unsigned int ci_off = swp_cluster_offset(entry);
+	unsigned long nr_pages = folio_nr_pages(new);
+	unsigned int ci_end = ci_off + nr_pages;
+
+	VM_WARN_ON_ONCE(entry.val != new->swap.val);
+	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
+	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
+	do {
+		WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_off)) != old);
+		__swap_table_set_folio(ci, ci_off, new);
+	} while (++ci_off < ci_end);
+
+	/*
+	 * If the old folio is partially replaced (e.g., splitting a large
+	 * folio, the old folio is shrunk in place, and new split sub folios
+	 * are added to cache), ensure the new folio doesn't overlap it.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_VM) &&
+	    folio_order(old) != folio_order(new)) {
+		ci_off = swp_cluster_offset(old->swap);
+		ci_end = ci_off + folio_nr_pages(old);
+		while (ci_off++ < ci_end)
+			WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_off)) != old);
+	}
+}
+
+void swap_cache_del_folio(struct folio *folio)
 {
+	struct swap_cluster_info *ci;
 	swp_entry_t entry = folio->swap;
-	struct address_space *address_space = swap_address_space(entry);
 
-	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(folio, entry, NULL);
-	xa_unlock_irq(&address_space->i_pages);
+	ci = swap_cluster_lock(swp_info(entry), swp_offset(entry));
+	__swap_cache_del_folio(entry, folio, NULL);
+	swap_cluster_unlock(ci);
 
 	put_swap_folio(folio, entry);
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents)
 {
-	unsigned long curr = begin;
-	void *old;
-
-	for (;;) {
-		swp_entry_t entry = swp_entry(type, curr);
-		unsigned long index = curr & SWAP_ADDRESS_SPACE_MASK;
-		struct address_space *address_space = swap_address_space(entry);
-		XA_STATE(xas, &address_space->i_pages, index);
-
-		xas_set_update(&xas, workingset_update_node);
-
-		xa_lock_irq(&address_space->i_pages);
-		xas_for_each(&xas, old, min(index + (end - curr), SWAP_ADDRESS_SPACE_PAGES)) {
-			if (!xa_is_value(old))
-				continue;
-			xas_store(&xas, NULL);
-		}
-		xa_unlock_irq(&address_space->i_pages);
+	struct swap_cluster_info *ci = swp_cluster(entry);
+	unsigned int ci_off = swp_cluster_offset(entry), ci_end;
 
-		/* search the next swapcache until we meet end */
-		curr = ALIGN((curr + 1), SWAP_ADDRESS_SPACE_PAGES);
-		if (curr > end)
-			break;
-	}
+	ci_end = ci_off + nr_ents;
+	do {
+		WARN_ON_ONCE(swp_tb_is_folio(__swap_table_get(ci, ci_off)));
+		__swap_table_init_null(ci, ci_off);
+	} while (++ci_off < ci_end);
 }
 
 /*
@@ -292,8 +320,7 @@ static inline bool swap_use_vma_readahead(void)
 /*
  * Update the readahead statistics of a vma or globally.
  */
-void swap_update_readahead(struct folio *folio,
-			   struct vm_area_struct *vma,
+void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 			   unsigned long addr)
 {
 	bool readahead, vma_ra = swap_use_vma_readahead();
@@ -387,7 +414,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			goto put_and_return;
 
 		/*
-		 * We might race against __delete_from_swap_cache(), and
+		 * We might race against __swap_cache_del_folio(), and
 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
 		 * has not yet been cleared.  Or race against another
 		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
@@ -405,8 +432,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (mem_cgroup_swapin_charge_folio(new_folio, NULL, gfp_mask, entry))
 		goto fail_unlock;
 
-	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
+	if (swap_cache_add_folio(entry, new_folio, &shadow))
 		goto fail_unlock;
 
 	memcg1_swapin(entry, 1);
@@ -572,11 +598,11 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		end_offset = si->max - 1;
 
 	blk_start_plug(&plug);
-	for (offset = start_offset; offset <= end_offset ; offset++) {
+	for (offset = start_offset; offset <= end_offset; offset++) {
 		/* Ok, do the async read-ahead now */
 		folio = __read_swap_cache_async(
-				swp_entry(swp_type(entry), offset),
-				gfp_mask, mpol, ilx, &page_allocated, false);
+				swp_entry(swp_type(entry), offset), gfp_mask, mpol, ilx,
+				&page_allocated, false);
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -600,41 +626,6 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	return folio;
 }
 
-int init_swap_address_space(unsigned int type, unsigned long nr_pages)
-{
-	struct address_space *spaces, *space;
-	unsigned int i, nr;
-
-	nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
-	spaces = kvcalloc(nr, sizeof(struct address_space), GFP_KERNEL);
-	if (!spaces)
-		return -ENOMEM;
-	for (i = 0; i < nr; i++) {
-		space = spaces + i;
-		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
-		atomic_set(&space->i_mmap_writable, 0);
-		space->a_ops = &swap_aops;
-		/* swap cache doesn't use writeback related tags */
-		mapping_set_no_writeback_tags(space);
-	}
-	nr_swapper_spaces[type] = nr;
-	swapper_spaces[type] = spaces;
-
-	return 0;
-}
-
-void exit_swap_address_space(unsigned int type)
-{
-	int i;
-	struct address_space *spaces = swapper_spaces[type];
-
-	for (i = 0; i < nr_swapper_spaces[type]; i++)
-		VM_WARN_ON_ONCE(!mapping_empty(&spaces[i]));
-	kvfree(spaces);
-	nr_swapper_spaces[type] = 0;
-	swapper_spaces[type] = NULL;
-}
-
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 			   unsigned long *end)
 {
@@ -807,7 +798,7 @@ static const struct attribute_group swap_attr_group = {
 	.attrs = swap_attrs,
 };
 
-static int __init swap_init_sysfs(void)
+static int __init swap_init(void)
 {
 	int err;
 	struct kobject *swap_kobj;
@@ -822,11 +813,13 @@ static int __init swap_init_sysfs(void)
 		pr_err("failed to register swap group\n");
 		goto delete_obj;
 	}
+	/* swap_space is set RO after init, so do it here before init ends. */
+	mapping_set_no_writeback_tags(&swap_space);
 	return 0;
 
 delete_obj:
 	kobject_put(swap_kobj);
 	return err;
 }
-subsys_initcall(swap_init_sysfs);
+subsys_initcall(swap_init);
 #endif
diff --git a/mm/swap_table.h b/mm/swap_table.h
new file mode 100644
index 000000000000..ed9676547071
--- /dev/null
+++ b/mm/swap_table.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MM_SWAP_TABLE_H
+#define _MM_SWAP_TABLE_H
+
+#include "swap.h"
+
+/*
+ * A swap table entry represents the status of a swap slot on a swap
+ * (physical or virtual) device. The swap table in each cluster is a
+ * 1:1 map of the swap slots in this cluster.
+ *
+ * Each swap table entry could be a pointer (folio), a XA_VALUE
+ * (shadow), or NULL.
+ */
+
+/*
+ * Helpers for casting one type of info into a swap table entry.
+ */
+static inline unsigned long null_to_swp_tb(void)
+{
+	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(atomic_long_t));
+	return 0;
+}
+
+static inline unsigned long folio_to_swp_tb(struct folio *folio)
+{
+	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(void *));
+	return (unsigned long)folio;
+}
+
+static inline unsigned long shadow_swp_to_tb(void *shadow)
+{
+	BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=
+		     BITS_PER_BYTE * sizeof(unsigned long));
+	VM_WARN_ON_ONCE(shadow && !xa_is_value(shadow));
+	return (unsigned long)shadow;
+}
+
+/*
+ * Helpers for swap table entry type checking.
+ */
+static inline bool swp_tb_is_null(unsigned long swp_tb)
+{
+	return !swp_tb;
+}
+
+static inline bool swp_tb_is_folio(unsigned long swp_tb)
+{
+	return !xa_is_value((void *)swp_tb) && !swp_tb_is_null(swp_tb);
+}
+
+static inline bool swp_tb_is_shadow(unsigned long swp_tb)
+{
+	return xa_is_value((void *)swp_tb);
+}
+
+/*
+ * Helpers for retrieving info from swap table.
+ */
+static inline struct folio *swp_tb_to_folio(unsigned long swp_tb)
+{
+	VM_WARN_ON(!swp_tb_is_folio(swp_tb));
+	return (void *)swp_tb;
+}
+
+static inline void *swp_tb_to_shadow(unsigned long swp_tb)
+{
+	VM_WARN_ON(!swp_tb_is_shadow(swp_tb));
+	return (void *)swp_tb;
+}
+
+/*
+ * Helpers for accessing or modifying the swap table of a cluster,
+ * the swap cluster must be locked.
+ */
+static inline void __swap_table_set(struct swap_cluster_info *ci,
+				    unsigned int off, unsigned long swp_tb)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	atomic_long_set(&ci->table[off], swp_tb);
+}
+
+static inline unsigned long __swap_table_get(struct swap_cluster_info *ci,
+					     unsigned int off)
+{
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	return atomic_long_read(&ci->table[off]);
+}
+
+static inline void __swap_table_set_folio(struct swap_cluster_info *ci,
+					  unsigned int off, struct folio *folio)
+{
+	__swap_table_set(ci, off, folio_to_swp_tb(folio));
+}
+
+static inline void __swap_table_set_shadow(struct swap_cluster_info *ci,
+					   unsigned int off, void *shadow)
+{
+	__swap_table_set(ci, off, shadow_swp_to_tb(shadow));
+}
+
+static inline void __swap_table_init_null(struct swap_cluster_info *ci, unsigned int off)
+{
+	__swap_table_set(ci, off, null_to_swp_tb());
+}
+#endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 85606fbebf0f..df68b5e242a6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -46,6 +46,7 @@
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
+#include "swap_table.h"
 #include "internal.h"
 #include "swap.h"
 
@@ -268,7 +269,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!need_reclaim)
 		goto out_unlock;
 
-	delete_from_swap_cache(folio);
+	swap_cache_del_folio(folio);
 	folio_set_dirty(folio);
 	ret = nr_pages;
 out_unlock:
@@ -422,6 +423,34 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
+static int swap_table_alloc_table(struct swap_cluster_info *ci)
+{
+	WARN_ON(ci->table);
+	ci->table = kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER, GFP_KERNEL);
+	if (!ci->table)
+		return -ENOMEM;
+	return 0;
+}
+
+static void swap_cluster_free_table(struct swap_cluster_info *ci)
+{
+	unsigned int ci_off;
+	unsigned long swp_tb;
+
+	if (!ci->table)
+		return;
+
+	for (ci_off = 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
+		swp_tb = __swap_table_get(ci, ci_off);
+		if (!swp_tb_is_null(swp_tb))
+			pr_err_once("swap: unclean swap space on swapoff: 0x%lx",
+				    swp_tb);
+	}
+
+	kfree(ci->table);
+	ci->table = NULL;
+}
+
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
 			 enum swap_cluster_flags new_flags)
@@ -704,6 +733,25 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 	return true;
 }
 
+/*
+ * Currently, the swap table is not used for count tracking,
+ * just do a sanity check to ensure nothing went wrong.
+ */
+static void cluster_table_check(struct swap_cluster_info *ci,
+				unsigned int start, unsigned int nr)
+{
+	unsigned int ci_off = start % SWAPFILE_CLUSTER;
+	unsigned int ci_end = ci_off + nr;
+	unsigned long swp_tb;
+
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		do {
+			swp_tb = __swap_table_get(ci, ci_off);
+			VM_WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
+		} while (++ci_off < ci_end);
+	}
+}
+
 static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
 				unsigned int start, unsigned char usage,
 				unsigned int order)
@@ -723,6 +771,7 @@ static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 		ci->order = order;
 
 	memset(si->swap_map + start, usage, nr_pages);
+	cluster_table_check(ci, start, nr_pages);
 	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
 
@@ -1100,8 +1149,7 @@ static void swap_range_alloc(struct swap_info_struct *si,
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
-	unsigned long begin = offset;
-	unsigned long end = offset + nr_entries - 1;
+	unsigned long start = offset, end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
 
@@ -1125,7 +1173,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	clear_shadow_from_swap_cache(si->type, begin, end);
+	__swap_cache_clear_shadow(swp_entry(si->type, start), nr_entries);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1282,15 +1330,7 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
 	if (!entry.val)
 		return -ENOMEM;
 
-	/*
-	 * XArray node allocations from PF_MEMALLOC contexts could
-	 * completely exhaust the page allocator. __GFP_NOMEMALLOC
-	 * stops emergency reserves from being allocated.
-	 *
-	 * TODO: this could cause a theoretical memory reclaim
-	 * deadlock in the swap out path.
-	 */
-	if (add_to_swap_cache(folio, entry, gfp | __GFP_NOMEMALLOC, NULL))
+	if (swap_cache_add_folio(entry, folio, NULL))
 		goto out_free;
 
 	return 0;
@@ -1557,6 +1597,7 @@ static void swap_entries_free(struct swap_info_struct *si,
 
 	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
+	cluster_table_check(ci, offset, nr_pages);
 
 	if (!ci->count)
 		free_cluster(si, ci);
@@ -1760,7 +1801,7 @@ bool folio_free_swap(struct folio *folio)
 	if (folio_swapped(folio))
 		return false;
 
-	delete_from_swap_cache(folio);
+	swap_cache_del_folio(folio);
 	folio_set_dirty(folio);
 	return true;
 }
@@ -2634,6 +2675,18 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	}
 }
 
+static void free_cluster_info(struct swap_cluster_info *cluster_info,
+			      unsigned long maxpages)
+{
+	int i, nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
+
+	if (!cluster_info)
+		return;
+	for (i = 0; i < nr_clusters; i++)
+		swap_cluster_free_table(&cluster_info[i]);
+	kvfree(cluster_info);
+}
+
 /*
  * Called after swap device's reference count is dead, so
  * neither scan nor allocation will use it.
@@ -2768,12 +2821,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
-	p->max = 0;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	zeromap = p->zeromap;
 	p->zeromap = NULL;
 	cluster_info = p->cluster_info;
+	free_cluster_info(cluster_info, p->max);
+	p->max = 0;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
@@ -2784,10 +2838,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->global_cluster = NULL;
 	vfree(swap_map);
 	kvfree(zeromap);
-	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
-	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
 
@@ -3171,8 +3223,11 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	if (!cluster_info)
 		goto err;
 
-	for (i = 0; i < nr_clusters; i++)
+	for (i = 0; i < nr_clusters; i++) {
 		spin_lock_init(&cluster_info[i].lock);
+		if (swap_table_alloc_table(&cluster_info[i]))
+			goto err_free;
+	}
 
 	if (!(si->flags & SWP_SOLIDSTATE)) {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
@@ -3233,9 +3288,8 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	}
 
 	return cluster_info;
-
 err_free:
-	kvfree(cluster_info);
+	free_cluster_info(cluster_info, maxpages);
 err:
 	return ERR_PTR(err);
 }
@@ -3429,13 +3483,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		}
 	}
 
-	error = init_swap_address_space(si->type, maxpages);
-	if (error)
-		goto bad_swap_unlock_inode;
-
 	error = zswap_swapon(si->type, maxpages);
 	if (error)
-		goto free_swap_address_space;
+		goto bad_swap_unlock_inode;
 
 	/*
 	 * Flush any pending IO and dirty mappings before we start using this
@@ -3470,8 +3520,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	goto out;
 free_swap_zswap:
 	zswap_swapoff(si->type);
-free_swap_address_space:
-	exit_swap_address_space(si->type);
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
@@ -3486,7 +3534,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
 	kvfree(zeromap);
-	kvfree(cluster_info);
+	if (cluster_info)
+		free_cluster_info(cluster_info, maxpages);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
 	if (swap_file)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b0afd7f41a22..1ed3cf9dac4e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -730,13 +730,18 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 {
 	int refcount;
 	void *shadow = NULL;
+	struct swap_cluster_info *ci;
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(mapping != folio_mapping(folio));
 
-	if (!folio_test_swapcache(folio))
+	if (folio_test_swapcache(folio)) {
+		ci = swap_cluster_lock_by_folio_irq(folio);
+	} else {
 		spin_lock(&mapping->host->i_lock);
-	xa_lock_irq(&mapping->i_pages);
+		xa_lock_irq(&mapping->i_pages);
+	}
+
 	/*
 	 * The non racy check for a busy folio.
 	 *
@@ -776,9 +781,9 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__delete_from_swap_cache(folio, swap, shadow);
+		__swap_cache_del_folio(swap, folio, shadow);
 		memcg1_swapout(folio, swap);
-		xa_unlock_irq(&mapping->i_pages);
+		swap_cluster_unlock_irq(ci);
 		put_swap_folio(folio, swap);
 	} else {
 		void (*free_folio)(struct folio *);
@@ -816,9 +821,12 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	return 1;
 
 cannot_free:
-	xa_unlock_irq(&mapping->i_pages);
-	if (!folio_test_swapcache(folio))
+	if (folio_test_swapcache(folio)) {
+		swap_cluster_unlock_irq(ci);
+	} else {
+		xa_unlock_irq(&mapping->i_pages);
 		spin_unlock(&mapping->host->i_lock);
+	}
 	return 0;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index ee443b317ac7..c869859eec77 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1166,7 +1166,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 out:
 	if (ret && ret != -EEXIST) {
-		delete_from_swap_cache(folio);
+		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 	}
 	folio_put(folio);
-- 
2.51.0


