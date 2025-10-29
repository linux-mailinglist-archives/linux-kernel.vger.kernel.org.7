Return-Path: <linux-kernel+bounces-876627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17289C1C4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B58071C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026E350A0D;
	Wed, 29 Oct 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUYMFliY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB9350A07
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753597; cv=none; b=lCWn15hceYkERJ5q2MY5vVk2vP/ruoEO9Y8romyaCjuVP2vM6VQuChXnl3xq64pObj1wv3gJPyIcI/CahWRYLtY1evlhhTmXebEdUcRK9oVJvD09pQXW6aHRn63TLUScqhMqAggCp+9VI1MomQkHO94huNcOcUtf42jh6Ez2tXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753597; c=relaxed/simple;
	bh=L+rdjO2vtp13dx9EhKBaRDdv3v/dIFE6uM6xYJiOIPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdEPpB3nfRCYTFvlDNXENb9Dmwk40jnQN+85mvQGxbCc5qN0mF5CjTR8MDzxpX9LapGr/sPvYubz1SB/o0JF+I8nfBmxGi3v/8OUCg7r7s9vKoHoKteqsYIW+deFw0GUh5q9VdELEt2+yu63c51YMstM/nrprrqcoc4jEiMLONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUYMFliY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso6814014a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753595; x=1762358395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oro6FwqIkTmuaMWEGle1A3mIt+YqWKAuLSr+vB3zc4c=;
        b=nUYMFliYNDJ+rqw3NghmwK38AgY+zlgqDiAcb0BKBt1reSAiyP6yjT7TBhZ1cebbGj
         bqL3HFMLlsU7LnThDS3bV0zg9n9FDv+P6W1MGlAeo/XdFTOZ7nDFLhx0mSc72XIPNU2s
         1LpYQ5ojA23Q5ZjtkS2nANijmS+f3Lm3nGvNpoupplpUnsrvUCCrve/CtCKQ7jp6+5v4
         sjgb11BiM3I0xpe+kYW5MbgKMEgNz5X0nfFiTXl7u+GwcW5jBBA5FiE3y67mDzOC8qSM
         BuL8Zc3r70WhCnMPVwcYgm2M7ojMOnJ4Lm7lwlA34wK2lHV6OP0JwJj+/5qCi28KAjri
         765w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753595; x=1762358395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oro6FwqIkTmuaMWEGle1A3mIt+YqWKAuLSr+vB3zc4c=;
        b=spuEC4CVrnvELgkXSru1kraT2uzCpe2j0XkNmjeNOBW1Q55pMZqOvwyWB4r67qMzKc
         znX0sbvp2gWvzipfURS5j1pkOQ/TILOOOda+taG/wfYPpf0b4Xz3lVoMRspLuws6LnHF
         Op7k+UFgYwEVCtuWwCbC2+A7qV6ntLwOgsnG7s2lDdBzDLTtXKCGB0rDMe5+pl1IPqkC
         1JRWcqd1sZFDg9zgl8irccuhmwYJCt+TBmZ790ydVRAtF+OMaiHBFFekqBmxFWiNsqXo
         ZuGqJ4qBp1qjDhaMu7F/4MTrIZP5HCKVi5N9x3Xp1Iv4NzGVatW9nC4poN16VQddzZln
         u+SA==
X-Forwarded-Encrypted: i=1; AJvYcCXoi3plZpijGua7otNtegVjJFjzpCBrMoS1wyVYuP1+9TRg94Wziq62ce5scMIKDttEzpgGjAKbJ+oWae0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQU3Ve2acMaJGbwe6OuNw9na9CyYPkFqUUocAW+eAy91srWst
	CARWvYB+XmCJOAN1n4MiNJqXAGWnXht82Qrf/4JXPKOrQRa3xV8P7Q9V
X-Gm-Gg: ASbGncuLl01pS0pFD5HcuBXRdNn0vkQZfOY8FZm6+zFb2tLkkvclouTm1pSm8sZdLYQ
	/KdasHN+1POK2FQPd5c6Z/TeaFIrhP7O6/jaSnu+ukCVCtkBYNSdm/GGAMt3xlSALUBMp97CGju
	942x/esM+bZiNG3X90MRhP2TlDsCk6CIY2Eu5JQ3RJhlT7hStIPxIgBEwg/N7+Z8p2Xw+4kqOyC
	CGRTgSuHOTkTIqTcLPaKQr6BwjlnfU4NIqCjFve5iNFweUzUVQGwh+yoTzoZ7sd+jB5TFl8AZfq
	FydkiD9ULwKjkbg8YIHwoQCq5ULauMkDV4ZXtfxoM+1JnLOZAu6nFah8LgpPaAqME3heOXPVvSl
	mHRBV8h1VLboL9e5f3DIYX8R+Rk8yaBPeo2sZo5Zfib/sNfoXYhiVqeY9HFMkTOQ3e03ibhKa3A
	QCpjLO7oIPhA==
X-Google-Smtp-Source: AGHT+IHOMMDiT1d3KDkNSsyTngQflKh7MDlf/06YJIchSbedr8pH+Ab6kM95BleLFAmEkO+PZdRYrQ==
X-Received: by 2002:a17:903:2301:b0:290:c5c8:941d with SMTP id d9443c01a7336-294dee9970fmr42231285ad.39.1761753594783;
        Wed, 29 Oct 2025 08:59:54 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:54 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:38 +0800
Subject: [PATCH 12/19] mm, swap: use swap cache as the swap in synchronize
 layer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-12-3d43f3b6ec32@tencent.com>
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

Current swap in synchronization mostly uses the swap_map's
SWAP_HAS_CACHE bit. Whoever sets the bit first does the actual
work to swap in a folio.

This has been causing many issues as it's just a poor implementation
of a bit lock. Raced users have no idea what is pinning a slot, so
it has to loop with a schedule_timeout_uninterruptible(1), which is
ugly and causes long-tailing or other performance issues. Besides,
the abuse of SWAP_HAS_CACHE has been causing many other troubles for
synchronization or maintenance.

This is the first step to remove this bit completely. This will also save
one bit for the 8-bit swap counting field.

We have just removed all swap in paths that bypass the swap cache, and
now both the swap cache and swap map are protected by the cluster lock.
So now we can just resolve the swap synchronization with the swap cache
layer directly using the cluster lock. Whoever inserts a folio in the
swap cache first does the swap in work. And because folios are locked
during swap operations, other raced users will just wait on the folio
lock.

The SWAP_HAS_CACHE will be removed in later commit. For now, we still set
it for some remaining users. But now we do the bit setting and swap cache
folio adding in the same critical section, after swap cache is ready.
No one will have to spin on the SWAP_HAS_CACHE bit anymore.

This both simplifies the logic and should improve the performance,
eliminating issues like the one solved in commit 01626a1823024
("mm: avoid unconditional one-tick sleep when swapcache_prepare fails"),
or the "skip_if_exists" from commit a65b0e7607ccb
("zswap: make shrinking memcg-aware"), which will be removed very soon.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   6 ---
 mm/swap.h            |  14 ++++++-
 mm/swap_state.c      | 103 +++++++++++++++++++++++++++++----------------------
 mm/swapfile.c        |  39 ++++++++++++-------
 mm/vmscan.c          |   1 -
 5 files changed, 95 insertions(+), 68 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 936fa8f9e5f3..69025b473472 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -458,7 +458,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern int swap_duplicate_nr(swp_entry_t entry, int nr);
-extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
@@ -518,11 +517,6 @@ static inline int swap_duplicate_nr(swp_entry_t swp, int nr_pages)
 	return 0;
 }
 
-static inline int swapcache_prepare(swp_entry_t swp, int nr)
-{
-	return 0;
-}
-
 static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
diff --git a/mm/swap.h b/mm/swap.h
index e0f05babe13a..3cd99850bbaf 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -234,6 +234,14 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
 	return folio_entry.val == round_down(entry.val, nr_pages);
 }
 
+/* Temporary internal helpers */
+void __swapcache_set_cached(struct swap_info_struct *si,
+			    struct swap_cluster_info *ci,
+			    swp_entry_t entry);
+void __swapcache_clear_cached(struct swap_info_struct *si,
+			      struct swap_cluster_info *ci,
+			      swp_entry_t entry, unsigned int nr);
+
 /*
  * All swap cache helpers below require the caller to ensure the swap entries
  * used are valid and stablize the device by any of the following ways:
@@ -247,7 +255,8 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
-void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
+int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+			 void **shadow, bool alloc);
 void swap_cache_del_folio(struct folio *folio);
 struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
 				     struct mempolicy *mpol, pgoff_t ilx,
@@ -413,7 +422,8 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
-static inline void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow)
+static inline int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+				       void **shadow, bool alloc)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index aaf8d202434d..2d53e3b5e8e9 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -128,34 +128,66 @@ void *swap_cache_get_shadow(swp_entry_t entry)
  * @entry: The swap entry corresponding to the folio.
  * @gfp: gfp_mask for XArray node allocation.
  * @shadowp: If a shadow is found, return the shadow.
+ * @alloc: If it's the allocator that is trying to insert a folio. Allocator
+ *         sets SWAP_HAS_CACHE to pin slots before insert so skip map update.
  *
  * Context: Caller must ensure @entry is valid and protect the swap device
  * with reference count or locks.
  * The caller also needs to update the corresponding swap_map slots with
  * SWAP_HAS_CACHE bit to avoid race or conflict.
  */
-void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp)
+int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+			 void **shadowp, bool alloc)
 {
+	int err;
 	void *shadow = NULL;
+	struct swap_info_struct *si;
 	unsigned long old_tb, new_tb;
 	struct swap_cluster_info *ci;
-	unsigned int ci_start, ci_off, ci_end;
+	unsigned int ci_start, ci_off, ci_end, offset;
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
 
+	si = __swap_entry_to_info(entry);
 	new_tb = folio_to_swp_tb(folio);
 	ci_start = swp_cluster_offset(entry);
 	ci_end = ci_start + nr_pages;
 	ci_off = ci_start;
-	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
+	offset = swp_offset(entry);
+	ci = swap_cluster_lock(si, swp_offset(entry));
+	if (unlikely(!ci->table)) {
+		err = -ENOENT;
+		goto failed;
+	}
 	do {
-		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
-		WARN_ON_ONCE(swp_tb_is_folio(old_tb));
+		old_tb = __swap_table_get(ci, ci_off);
+		if (unlikely(swp_tb_is_folio(old_tb))) {
+			err = -EEXIST;
+			goto failed;
+		}
+		if (!alloc && unlikely(!__swap_count(swp_entry(swp_type(entry), offset)))) {
+			err = -ENOENT;
+			goto failed;
+		}
 		if (swp_tb_is_shadow(old_tb))
 			shadow = swp_tb_to_shadow(old_tb);
+		offset++;
+	} while (++ci_off < ci_end);
+
+	ci_off = ci_start;
+	offset = swp_offset(entry);
+	do {
+		/*
+		 * Still need to pin the slots with SWAP_HAS_CACHE since
+		 * swap allocator depends on that.
+		 */
+		if (!alloc)
+			__swapcache_set_cached(si, ci, swp_entry(swp_type(entry), offset));
+		__swap_table_set(ci, ci_off, new_tb);
+		offset++;
 	} while (++ci_off < ci_end);
 
 	folio_ref_add(folio, nr_pages);
@@ -168,6 +200,11 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
 
 	if (shadowp)
 		*shadowp = shadow;
+	return 0;
+
+failed:
+	swap_cluster_unlock(ci);
+	return err;
 }
 
 /**
@@ -186,6 +223,7 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
 void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 			    swp_entry_t entry, void *shadow)
 {
+	struct swap_info_struct *si;
 	unsigned long old_tb, new_tb;
 	unsigned int ci_start, ci_off, ci_end;
 	unsigned long nr_pages = folio_nr_pages(folio);
@@ -195,6 +233,7 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_writeback(folio), folio);
 
+	si = __swap_entry_to_info(entry);
 	new_tb = shadow_swp_to_tb(shadow);
 	ci_start = swp_cluster_offset(entry);
 	ci_end = ci_start + nr_pages;
@@ -210,6 +249,7 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 	folio_clear_swapcache(folio);
 	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
+	__swapcache_clear_cached(si, ci, entry, nr_pages);
 }
 
 /**
@@ -231,7 +271,6 @@ void swap_cache_del_folio(struct folio *folio)
 	__swap_cache_del_folio(ci, folio, entry, NULL);
 	swap_cluster_unlock(ci);
 
-	put_swap_folio(folio, entry);
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
@@ -423,67 +462,37 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 						  gfp_t gfp, bool charged,
 						  bool skip_if_exists)
 {
-	struct folio *swapcache;
+	struct folio *swapcache = NULL;
 	void *shadow;
 	int ret;
 
-	/*
-	 * Check and pin the swap map with SWAP_HAS_CACHE, then add the folio
-	 * into the swap cache. Loop with a schedule delay if raced with
-	 * another process setting SWAP_HAS_CACHE. This hackish loop will
-	 * be fixed very soon.
-	 */
+	__folio_set_locked(folio);
+	__folio_set_swapbacked(folio);
 	for (;;) {
-		ret = swapcache_prepare(entry, folio_nr_pages(folio));
+		ret = swap_cache_add_folio(folio, entry, &shadow, false);
 		if (!ret)
 			break;
 
 		/*
-		 * The skip_if_exists is for protecting against a recursive
-		 * call to this helper on the same entry waiting forever
-		 * here because SWAP_HAS_CACHE is set but the folio is not
-		 * in the swap cache yet. This can happen today if
-		 * mem_cgroup_swapin_charge_folio() below triggers reclaim
-		 * through zswap, which may call this helper again in the
-		 * writeback path.
-		 *
-		 * Large order allocation also needs special handling on
+		 * Large order allocation needs special handling on
 		 * race: if a smaller folio exists in cache, swapin needs
 		 * to fallback to order 0, and doing a swap cache lookup
 		 * might return a folio that is irrelevant to the faulting
 		 * entry because @entry is aligned down. Just return NULL.
 		 */
 		if (ret != -EEXIST || skip_if_exists || folio_test_large(folio))
-			return NULL;
+			goto failed;
 
-		/*
-		 * Check the swap cache again, we can only arrive
-		 * here because swapcache_prepare returns -EEXIST.
-		 */
 		swapcache = swap_cache_get_folio(entry);
 		if (swapcache)
-			return swapcache;
-
-		/*
-		 * We might race against __swap_cache_del_folio(), and
-		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
-		 * has not yet been cleared.  Or race against another
-		 * swap_cache_alloc_folio(), which has set SWAP_HAS_CACHE
-		 * in swap_map, but not yet added its folio to swap cache.
-		 */
-		schedule_timeout_uninterruptible(1);
+			goto failed;
 	}
 
-	__folio_set_locked(folio);
-	__folio_set_swapbacked(folio);
-
 	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
-		put_swap_folio(folio, entry);
-		folio_unlock(folio);
-		return NULL;
+		swap_cache_del_folio(folio);
+		goto failed;
 	}
 
-	swap_cache_add_folio(folio, entry, &shadow);
 	memcg1_swapin(entry, folio_nr_pages(folio));
 	if (shadow)
 		workingset_refault(folio, shadow);
@@ -491,6 +500,10 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 	/* Caller will initiate read into locked folio */
 	folio_add_lru(folio);
 	return folio;
+
+failed:
+	folio_unlock(folio);
+	return swapcache;
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 56054af12afd..415db36d85d3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1461,7 +1461,11 @@ int folio_alloc_swap(struct folio *folio)
 	if (!entry.val)
 		return -ENOMEM;
 
-	swap_cache_add_folio(folio, entry, NULL);
+	/*
+	 * Allocator has pinned the slots with SWAP_HAS_CACHE
+	 * so it should never fail
+	 */
+	WARN_ON_ONCE(swap_cache_add_folio(folio, entry, NULL, true));
 
 	return 0;
 
@@ -1567,9 +1571,8 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
  *   do_swap_page()
  *     ...				swapoff+swapon
  *     swap_cache_alloc_folio()
- *       swapcache_prepare()
- *         __swap_duplicate()
- *           // check swap_map
+ *       swap_cache_add_folio()
+ *         // check swap_map
  *     // verify PTE not changed
  *
  * In __swap_duplicate(), the swap_map need to be checked before
@@ -3748,17 +3751,25 @@ int swap_duplicate_nr(swp_entry_t entry, int nr)
 	return err;
 }
 
-/*
- * @entry: first swap entry from which we allocate nr swap cache.
- *
- * Called when allocating swap cache for existing swap entries,
- * This can return error codes. Returns 0 at success.
- * -EEXIST means there is a swap cache.
- * Note: return code is different from swap_duplicate().
- */
-int swapcache_prepare(swp_entry_t entry, int nr)
+/* Mark the swap map as HAS_CACHE, caller need to hold the cluster lock */
+void __swapcache_set_cached(struct swap_info_struct *si,
+			    struct swap_cluster_info *ci,
+			    swp_entry_t entry)
+{
+	WARN_ON(swap_dup_entries(si, ci, swp_offset(entry), SWAP_HAS_CACHE, 1));
+}
+
+/* Clear the swap map as !HAS_CACHE, caller need to hold the cluster lock */
+void __swapcache_clear_cached(struct swap_info_struct *si,
+			      struct swap_cluster_info *ci,
+			      swp_entry_t entry, unsigned int nr)
 {
-	return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
+	if (swap_only_has_cache(si, swp_offset(entry), nr)) {
+		swap_entries_free(si, ci, entry, nr);
+	} else {
+		for (int i = 0; i < nr; i++, entry.val++)
+			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
+	}
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5e74a2807930..76b9c21a7fe2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -762,7 +762,6 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		__swap_cache_del_folio(ci, folio, swap, shadow);
 		memcg1_swapout(folio, swap);
 		swap_cluster_unlock_irq(ci);
-		put_swap_folio(folio, swap);
 	} else {
 		void (*free_folio)(struct folio *);
 

-- 
2.51.1


