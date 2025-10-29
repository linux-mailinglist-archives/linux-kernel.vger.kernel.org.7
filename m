Return-Path: <linux-kernel+bounces-876617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA16C1BF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812CF802FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5334405D;
	Wed, 29 Oct 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktRah+pl"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0E347BBA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753554; cv=none; b=mkenhCYzDgfne7ntqQ/aE/RZ3T2Rrv2bwMW6JEe0XVuw7FB8bCcBpkKJOcSSFJzIsc128zNLyMn1jKoi4m5GM42gaqUldx+2f8rvHz1r3Zlckfm81745EeelTGqwiufsRHzCd/M1pbljX/2zhtM+fkjI1q34Ysj+ggzivotzAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753554; c=relaxed/simple;
	bh=1IVHDV0i+aP1djw0MDDj7S7+2W4CnRFTmxJMVUtd+O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3/gUv6Vs8TcX9zVcaqxZk1qhRKe9R13NIOcjmMeGb8Ntve+Nj8RqVn52TqnPhFbrGLu37ziDycTViEAFgylCQaZaewmzWd8IzhopNSwqUpigR0AcdiGopxm3Xf36XagF35rU8cs01VIu3IaUTmJP2AwiIfUkS/KE95Tq+iWhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktRah+pl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so57182a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753552; x=1762358352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rz2hi28hudNS4IT/qIl1dMVj4a37Bo5V3Z4J+XpiKOE=;
        b=ktRah+plgooAgGCzkopxyC/OE0gP9gcMxCNrA0N2054f4oa5/bwx2z2iq71DwmUNyl
         WxZhbaEQA8BP8bzw9JFuzftCU/volCrj9dHx+t63KAO4gqoNXuSNfgADxNBDCb6ii6Ux
         ykNmcvh1mh++1osUKGQCzT52jkqxpoeEUl0fegA8gmGq5zohRjSWYVzv4pu6ZDss/NkU
         M/wfOiOTLbL2Mdc8LVAFLfHN9uOUtXy5S4X4dd/rCvEi0f6FIiMfhMK2oFJURwtmsZ5s
         ah0JsH3v0Qj1yp70wJjsDSlRk8zwZyoi0KST9ToiT1Lp3ZNKtN5JsGSmvx+iEhCF3JmH
         eJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753552; x=1762358352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz2hi28hudNS4IT/qIl1dMVj4a37Bo5V3Z4J+XpiKOE=;
        b=JXlnEaheXii7IjtNwkJXvbbFANh2avdT4EvNWJzPfQ3vg4Uj6kCfj/rnxsPD+Py9Ba
         vD1Zp0DWFsOS+pBm2YkoZOwqeNWmeAe/aZrIgUHpLYgoxNPTtE3f6LRuLtDqsten6MvE
         wSV2pLEtG0tbu0WuFhCpNKUkgwgafDfZqoUQWX5YyUcL345mACr7lDQL8wKzd+DX/lWQ
         nIk6B9vXB/hW2zWgZovU2oxB5ugnYyfZfmLspQmg36uhREI49rePwegb2TIUFHjZSNBb
         bBRL1hjrH/UWWGxdrLN3aeFzG07OHXmWThIDyc4lke0TvVVbjCoGnfIoVVFj4A9pJ6rB
         9Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCW70vuvfHye2+0SL15tvZfGcTI1K4BcXBBs4holYc0mJ7+L2i36i+CQDKh6k0CAeAJHYwdi5r6fsnQ7VQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzqqhu5J18+DTytB87LIJC9E1dQIlJAsai2wPBnguw11Si0cLq
	PVEiIPBOtKSOm2L12J05orQgCYHoVarWd6WURaflBzOnF+bpUnf3HmAk
X-Gm-Gg: ASbGncuTItMctX5rs9sPvhUSiiWuaBKeEmae7krgu9vg8PFx6Y0MyaXqXQ+eIuHE0c0
	81ZIAWj19WfxsN/W6KYgVnvI3fOxV4SYYDUm/prc+uDgwWvy+ZKyO0rANDoMIs4BQm5edzOhNdE
	UR+LAU8huwERlZh1iS512Y8oHOL8v9gFw/uPJOWB+41EYk4GfJWWr75NYxUwLJwl+Z7VWBBYhfm
	SHOpbAKN07vnU6ObsGpY7ohOJ9WuvXNerK+PCbQuqlN9yQPn39RvyoXDGPtWu3dsVOAha6cJj5+
	5EateIb/gzBHY4Da2pE1rNVgN4V7yIU1OH1lVMWTtGVgT1VGpe+VEw0TNaF5yC59CGZIuxdEwrB
	0XXkc0qrxvRDd3WFtNN7CBBGDvZSLZUgGJagJ5eDuRPuDpOdm3d1+Xit/7g1IEy23p1BSwJYo+6
	a+h/E8gY1OXdzVy1TGYi/Q
X-Google-Smtp-Source: AGHT+IE9F28VM9txLlXQyguLph+CDkmsOFET1zyslpkasaXaif9c0pcrkP9t25GnzgOy0wRXAaEphQ==
X-Received: by 2002:a17:90a:fc46:b0:32e:38b0:1600 with SMTP id 98e67ed59e1d1-3403a25a8e2mr4106451a91.6.1761753551634;
        Wed, 29 Oct 2025 08:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:11 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:29 +0800
Subject: [PATCH 03/19] mm, swap: never bypass the swap cache even for
 SWP_SYNCHRONOUS_IO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-3-3d43f3b6ec32@tencent.com>
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

Now the overhead of the swap cache is trivial, bypassing the swap
cache is no longer a valid optimization. So unify the swapin path using
the swap cache. This changes the swap in behavior in multiple ways:

We used to rely on `SWP_SYNCHRONOUS_IO && __swap_count(entry) == 1` as
the indicator to bypass both the swap cache and readahead. The swap
count check is not a good indicator for readahead. It existed because
the previously swap design made readahead strictly coupled with swap
cache bypassing. We actually want to always bypass readahead for
SWP_SYNCHRONOUS_IO devices even if swap count > 1, But bypassing the
swap cache will cause redundant IO.

Now that limitation is gone, with the new introduced helpers and design,
we will always swap cache, so this check can be simplified to check
SWP_SYNCHRONOUS_IO only, effectively disabling readahead for all
SWP_SYNCHRONOUS_IO cases, this is a huge win for many workloads.

The second thing here is that this enabled a large swap for all swap
entries on SWP_SYNCHRONOUS_IO devices. Previously, the large swap in is
also coupled with swap cache bypassing, and so the count checking side
effect also makes large swap in less effective. Now this is also fixed.
We will always have a large swap in support for all SWP_SYNCHRONOUS_IO
cases.

And to catch potential issues with large swap in, especially with page
exclusiveness and swap cache, more debug sanity checks and comments are
added. But overall, the code is simpler. And new helper and routines
will be used by other components in later commits too. And now it's
possible to rely on the swap cache layer for resolving synchronization
issues, which will also be done by a later commit.

Worth mentioning that for a large folio workload, this may cause more
serious thrashing. This isn't a problem with this commit, but a generic
large folio issue. For a 4K workload, this commit increases the
performance.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 136 +++++++++++++++++++++-----------------------------------
 mm/swap.h       |   6 +++
 mm/swap_state.c |  27 +++++++++++
 3 files changed, 84 insertions(+), 85 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4c3a7e09a159..9a43d4811781 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4613,7 +4613,15 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
+/* Sanity check that a folio is fully exclusive */
+static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
+				 unsigned int nr_pages)
+{
+	do {
+		VM_WARN_ON_ONCE_FOLIO(__swap_count(entry) != 1, folio);
+		entry.val++;
+	} while (--nr_pages);
+}
 
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
@@ -4626,17 +4634,14 @@ static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
 vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct folio *swapcache, *folio = NULL;
-	DECLARE_WAITQUEUE(wait, current);
+	struct folio *swapcache = NULL, *folio;
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
-	bool need_clear_cache = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
-	void *shadow = NULL;
 	int nr_pages;
 	unsigned long page_idx;
 	unsigned long address;
@@ -4707,57 +4712,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	folio = swap_cache_get_folio(entry);
 	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
-	swapcache = folio;
-
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
-		    __swap_count(entry) == 1) {
-			/* skip swapcache */
+		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			folio = alloc_swap_folio(vmf);
 			if (folio) {
-				__folio_set_locked(folio);
-				__folio_set_swapbacked(folio);
-
-				nr_pages = folio_nr_pages(folio);
-				if (folio_test_large(folio))
-					entry.val = ALIGN_DOWN(entry.val, nr_pages);
 				/*
-				 * Prevent parallel swapin from proceeding with
-				 * the cache flag. Otherwise, another thread
-				 * may finish swapin first, free the entry, and
-				 * swapout reusing the same entry. It's
-				 * undetectable as pte_same() returns true due
-				 * to entry reuse.
+				 * folio is charged, so swapin can only fail due
+				 * to raced swapin and return NULL.
 				 */
-				if (swapcache_prepare(entry, nr_pages)) {
-					/*
-					 * Relax a bit to prevent rapid
-					 * repeated page faults.
-					 */
-					add_wait_queue(&swapcache_wq, &wait);
-					schedule_timeout_uninterruptible(1);
-					remove_wait_queue(&swapcache_wq, &wait);
-					goto out_page;
-				}
-				need_clear_cache = true;
-
-				memcg1_swapin(entry, nr_pages);
-
-				shadow = swap_cache_get_shadow(entry);
-				if (shadow)
-					workingset_refault(folio, shadow);
-
-				folio_add_lru(folio);
-
-				/* To provide entry to swap_read_folio() */
-				folio->swap = entry;
-				swap_read_folio(folio, NULL);
-				folio->private = NULL;
+				swapcache = swapin_folio(entry, folio);
+				if (swapcache != folio)
+					folio_put(folio);
+				folio = swapcache;
 			}
 		} else {
-			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
-			swapcache = folio;
+			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
 		}
 
 		if (!folio) {
@@ -4779,6 +4748,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 	}
 
+	swapcache = folio;
 	ret |= folio_lock_or_retry(folio, vmf);
 	if (ret & VM_FAULT_RETRY)
 		goto out_release;
@@ -4848,24 +4818,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
-	/* allocated large folios for SWP_SYNCHRONOUS_IO */
-	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
-		unsigned long nr = folio_nr_pages(folio);
-		unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
-		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
-		pte_t *folio_ptep = vmf->pte - idx;
-		pte_t folio_pte = ptep_get(folio_ptep);
-
-		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
-		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
-			goto out_nomap;
-
-		page_idx = idx;
-		address = folio_start;
-		ptep = folio_ptep;
-		goto check_folio;
-	}
-
 	nr_pages = 1;
 	page_idx = 0;
 	address = vmf->address;
@@ -4909,12 +4861,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
 	BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
 
+	/*
+	 * If a large folio already belongs to anon mapping, then we
+	 * can just go on and map it partially.
+	 * If not, with the large swapin check above failing, the page table
+	 * have changed, so sub pages might got charged to the wrong cgroup,
+	 * or even should be shmem. So we have to free it and fallback.
+	 * Nothing should have touched it, both anon and shmem checks if a
+	 * large folio is fully appliable before use.
+	 *
+	 * This will be removed once we unify folio allocation in the swap cache
+	 * layer, where allocation of a folio stabilizes the swap entries.
+	 */
+	if (!folio_test_anon(folio) && folio_test_large(folio) &&
+	    nr_pages != folio_nr_pages(folio)) {
+		if (!WARN_ON_ONCE(folio_test_dirty(folio)))
+			swap_cache_del_folio(folio);
+		goto out_nomap;
+	}
+
 	/*
 	 * Check under PT lock (to protect against concurrent fork() sharing
 	 * the swap entry concurrently) for certainly exclusive pages.
 	 */
 	if (!folio_test_ksm(folio)) {
+		/*
+		 * The can_swapin_thp check above ensures all PTE have
+		 * same exclusivenss, only check one PTE is fine.
+		 */
 		exclusive = pte_swp_exclusive(vmf->orig_pte);
+		if (exclusive)
+			check_swap_exclusive(folio, entry, nr_pages);
 		if (folio != swapcache) {
 			/*
 			 * We have a fresh page that is not exposed to the
@@ -4992,18 +4969,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
 
 	/* ksm created a completely new copy */
-	if (unlikely(folio != swapcache && swapcache)) {
+	if (unlikely(folio != swapcache)) {
 		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 	} else if (!folio_test_anon(folio)) {
 		/*
-		 * We currently only expect small !anon folios which are either
-		 * fully exclusive or fully shared, or new allocated large
-		 * folios which are fully exclusive. If we ever get large
-		 * folios within swapcache here, we have to be careful.
+		 * We currently only expect !anon folios that are fully
+		 * mappable. See the comment after can_swapin_thp above.
 		 */
-		VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
-		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+		VM_WARN_ON_ONCE_FOLIO(folio_nr_pages(folio) != nr_pages, folio);
+		VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
 		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
 		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
@@ -5043,12 +5018,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
-	/* Clear the swap cache pin for direct swapin after PTL unlock */
-	if (need_clear_cache) {
-		swapcache_clear(si, entry, nr_pages);
-		if (waitqueue_active(&swapcache_wq))
-			wake_up(&swapcache_wq);
-	}
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -5056,6 +5025,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
+	if (folio_test_swapcache(folio))
+		folio_free_swap(folio);
 	folio_unlock(folio);
 out_release:
 	folio_put(folio);
@@ -5063,11 +5034,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (need_clear_cache) {
-		swapcache_clear(si, entry, nr_pages);
-		if (waitqueue_active(&swapcache_wq))
-			wake_up(&swapcache_wq);
-	}
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/swap.h b/mm/swap.h
index 0fff92e42cfe..214e7d041030 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -268,6 +268,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 		struct vm_fault *vmf);
+struct folio *swapin_folio(swp_entry_t entry, struct folio *folio);
 void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 			   unsigned long addr);
 
@@ -386,6 +387,11 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
+static inline struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
+{
+	return NULL;
+}
+
 static inline void swap_update_readahead(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d18ca765c04f..b3737c60aad9 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -544,6 +544,33 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 	return result;
 }
 
+/**
+ * swapin_folio - swap-in one or multiple entries skipping readahead.
+ * @entry: starting swap entry to swap in
+ * @folio: a new allocated and charged folio
+ *
+ * Reads @entry into @folio, @folio will be added to the swap cache.
+ * If @folio is a large folio, the @entry will be rounded down to align
+ * with the folio size.
+ *
+ * Return: returns pointer to @folio on success. If folio is a large folio
+ * and this raced with another swapin, NULL will be returned. Else, if
+ * another folio was already added to the swap cache, return that swap
+ * cache folio instead.
+ */
+struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
+{
+	struct folio *swapcache;
+	pgoff_t offset = swp_offset(entry);
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	entry = swp_entry(swp_type(entry), round_down(offset, nr_pages));
+	swapcache = __swap_cache_prepare_and_add(entry, folio, 0, true, false);
+	if (swapcache == folio)
+		swap_read_folio(folio, NULL);
+	return swapcache;
+}
+
 /*
  * Locate a page of swap in physical memory, reserving swap cache space
  * and reading the disk if it is not already cached.

-- 
2.51.1


