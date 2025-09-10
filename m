Return-Path: <linux-kernel+bounces-810631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8CB51D34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E99170D83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05BD3375C2;
	Wed, 10 Sep 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhqYjrI3"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2333CEBA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520578; cv=none; b=Vk/sXXYKV6eOXa9tp3aYYbRJ8mdGm9qJbc1xeW4ty1Y9HlZEMvfqtwgLlA24ND5uKrblX2l7Hh5AIXx7VTTG+xhkY66zYyb4iFNfGQp+n/XuAV4+HW7ROtilTTq6GpFWRnEh5QjWtIzvnVKtMMjHCoJpDj3Nh80zkQpx89Xlkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520578; c=relaxed/simple;
	bh=wezNe+McLtBEyF9B2AQrUKduS6WWFRf6QeCr+ValA6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhbFysAauzJB8dLiDB+UVG4qFn6iiJBLf0/hjM9HrvVvlFtegmIyYI/GkxMOxRl3f8/XcRIHvtcfTcTLZlH28ovM5AOtftTXdf3gcBUqabdBvKllnlpyv8DNv3zshK3eZV6fwy166BMB2cdffEfEcPEndX44Uwvt96ruQcH+DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhqYjrI3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7724cacc32bso5634755b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520575; x=1758125375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXr0Gr+eyBH1J2ZOC4B1nLxnwl36iHb/5ARHAVX+lWM=;
        b=NhqYjrI3efKGWa2VjQLoN+h/VLJxY/3ZfgJpmNryCHTSTw71gVVyCJkiMyBV9/cwUe
         3EMigPg41ACLsKi5NYfuuIrKkC+mlnbACONb3///vCKVMn62oqppXlaX6ZDBJqODfOF4
         A3W9VZV5wSDfOfzREQykNZGNWe27e2mQrIIh6smBYc1hGJ872VcGikX5veSU/3/lpaA5
         wFFTCR5VhWbGhd6AhtWnIzBS5K5Ccpo/tg6CN4h4U1uQZePjtZJLhEHcuFXFhy8NLww/
         6nJkEP0gAgk5mn4m7R41VVtPx3Gd/N3RalP2r/fgyOSTAF0yruiweKEBRDdB76jZcfWZ
         VoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520575; x=1758125375;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXr0Gr+eyBH1J2ZOC4B1nLxnwl36iHb/5ARHAVX+lWM=;
        b=qtsREnUDL+8btQxvA7rfQMcDtnUCbXeLAyBlzRd/YnoWsR3JvBNyNAw0EjmShsNqlh
         bGSRhjYLKtXOHx42MTnCtLrh17op5gIMtj1/fD9WWxKgStBTjVaIGoEEi/YMz8RXk9Rr
         1fyYg+wvB/z2aTyCaK1T7s4xyFwDd/Fuig8Wbh2q654fJH1ILVJ0ga7M7+g6YCuqbC9O
         oYknuLdICzjcdJKHBbcDCBgaenyuhbkcKIxGVZnbgW25mJ9yDHHxnDYbxJttX3ddF7/8
         sCdVfP6O7cIb1UIA0j0X+afQgflFpTUrf3c+Og9J+YL8gHPg4xCK+F1DKs2SHbiWwA2S
         EDjA==
X-Forwarded-Encrypted: i=1; AJvYcCWPYHCEbZbjZuLNyxPfp2fIwL/9pS4UENsRMfHzhC508apaWbDcQEQFUsZVFrqNnZA+AEpKaKe+TqgKN5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoQEfHvq6pv9MuxOSI6OObZVhZCpGdQdMRJVFsLA22NHgtM7R
	k7pnGdV9VfQp7HxCuF1/NREuP8VuOGNnMvy9YPIPqhenE2F8+6f2Nt6B
X-Gm-Gg: ASbGncv2uz4XINcxDNHaCNKT3hkzv6nDBZbGNlmPDpV7MNlzwZYPj3CGzoLtL03Eya9
	Bw+N69Oy/QzPJNcqkkL4s+zpoeB9jcW2ZcpqKX0GVLEuXliSZKoW2maG2prjh/9dLpBm4kkuRp3
	sBAvRGQ1QQYYDPKJfkaNvYaifQX1Nfo3GdvYqo3IcqdMmJpedm29UpdiAQbZ/7mfnVniRAv4Avj
	lw/nkvorRAPxmiXYx8pjUtk3T784ve191BBNxQbbNKtDp4mgBuxdf/F3G15Vk4rBD0Ch4BMALY6
	dH6bRpouvSWYGSQW3IXA3jnNwS/pW+J/LS7pofMDNwPgsXggpN0YwHG/m3EZdDNhBgCUC6UKF0Z
	DLgG6ZC4IHnqFrjoJyWDT3e4PnvsjEhamCG9R0z7y+ifdMVAvB+JaB5b0Mw==
X-Google-Smtp-Source: AGHT+IGd1fs3d/xLWFIH8x0QD2Wv+0XsIfWldgkL360dAU+YTjAIy2jV9nMZXESeItmlntKEcr6Daw==
X-Received: by 2002:a05:6a20:3d19:b0:24d:301a:79b1 with SMTP id adf61e73a8af0-2533e94d169mr26623227637.15.1757520575417;
        Wed, 10 Sep 2025 09:09:35 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:34 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v3 10/15] mm, swap: wrap swap cache replacement with a helper
Date: Thu, 11 Sep 2025 00:08:28 +0800
Message-ID: <20250910160833.3464-11-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are currently three swap cache users that are trying to replace an
existing folio with a new one: huge memory splitting, migration, and
shmem replacement. What they are doing is quite similar.

Introduce a common helper for this. In later commits, this can be easily
switched to use the swap table by updating this helper.

The newly added helper also makes the swap cache API better defined, and
make debugging easier by adding a few more debug checks.

Migration and shmem replace are meant to clone the folio, including
content, swap entry value, and flags. And splitting will adjust each
sub folio's swap entry according to order, which could be non-uniform in
the future. So document it clearly that it's the caller's responsibility
to set up the new folio's swap entries and flags before calling the helper.
The helper will just follow the new folio's entry value.

This also prepares for replacing high-order folios in the swap cache.
Currently, only splitting to order 0 is allowed for swap cache folios.
Using the new helper, we can handle high-order folio splitting better.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c |  4 +---
 mm/migrate.c     | 11 +++--------
 mm/shmem.c       | 10 ++--------
 mm/swap.h        |  5 +++++
 mm/swap_state.c  | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26cedfcd7418..4c66e358685b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3798,9 +3798,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 * NOTE: shmem in swap cache is not supported yet.
 			 */
 			if (swap_cache) {
-				__xa_store(&swap_cache->i_pages,
-					   swap_cache_index(new_folio->swap),
-					   new_folio, 0);
+				__swap_cache_replace_folio(folio, new_folio);
 				continue;
 			}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8e435a078fc3..c69cc13db692 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -566,7 +566,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	struct zone *oldzone, *newzone;
 	int dirty;
 	long nr = folio_nr_pages(folio);
-	long entries, i;
 
 	if (!mapping) {
 		/* Take off deferred split queue while frozen and memcg set */
@@ -615,9 +614,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_swapcache(folio)) {
 		folio_set_swapcache(newfolio);
 		newfolio->private = folio_get_private(folio);
-		entries = nr;
-	} else {
-		entries = 1;
 	}
 
 	/* Move dirty while folio refs frozen and newfolio not yet exposed */
@@ -627,11 +623,10 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		folio_set_dirty(newfolio);
 	}
 
-	/* Swap cache still stores N entries instead of a high-order entry */
-	for (i = 0; i < entries; i++) {
+	if (folio_test_swapcache(folio))
+		__swap_cache_replace_folio(folio, newfolio);
+	else
 		xas_store(&xas, newfolio);
-		xas_next(&xas);
-	}
 
 	/*
 	 * Drop cache reference from old folio by unfreezing
diff --git a/mm/shmem.c b/mm/shmem.c
index 5f395fab489c..8930780325da 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2086,10 +2086,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	struct folio *new, *old = *foliop;
 	swp_entry_t entry = old->swap;
 	struct address_space *swap_mapping = swap_address_space(entry);
-	pgoff_t swap_index = swap_cache_index(entry);
-	XA_STATE(xas, &swap_mapping->i_pages, swap_index);
 	int nr_pages = folio_nr_pages(old);
-	int error = 0, i;
+	int error = 0;
 
 	/*
 	 * We have arrived here because our zones are constrained, so don't
@@ -2118,12 +2116,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	/* Swap cache still stores N entries instead of a high-order entry */
 	xa_lock_irq(&swap_mapping->i_pages);
-	for (i = 0; i < nr_pages; i++) {
-		WARN_ON_ONCE(xas_store(&xas, new));
-		xas_next(&xas);
-	}
+	__swap_cache_replace_folio(old, new);
 	xa_unlock_irq(&swap_mapping->i_pages);
 
 	mem_cgroup_replace_folio(old, new);
diff --git a/mm/swap.h b/mm/swap.h
index 6c4acb549bec..fe579c81c6c4 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -185,6 +185,7 @@ int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 void swap_cache_del_folio(struct folio *folio);
 void __swap_cache_del_folio(struct folio *folio,
 			    swp_entry_t entry, void *shadow);
+void __swap_cache_replace_folio(struct folio *old, struct folio *new);
 void swap_cache_clear_shadow(int type, unsigned long begin,
 			     unsigned long end);
 
@@ -336,6 +337,10 @@ static inline void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry
 {
 }
 
+static inline void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+{
+}
+
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f3a32a06a950..d1f5b8fa52fc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -234,6 +234,39 @@ void swap_cache_del_folio(struct folio *folio)
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
+/**
+ * __swap_cache_replace_folio - Replace a folio in the swap cache.
+ * @old: The old folio to be replaced.
+ * @new: The new folio.
+ *
+ * Replace an existing folio in the swap cache with a new folio. The
+ * caller is responsible for setting up the new folio's flag and swap
+ * entries. Replacement will take the new folio's swap entry value as
+ * the starting offset to override all slots covered by the new folio.
+ *
+ * Context: Caller must ensure both folios are locked, also lock the
+ * swap address_space that holds the old folio to avoid races.
+ */
+void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+{
+	swp_entry_t entry = new->swap;
+	unsigned long nr_pages = folio_nr_pages(new);
+	unsigned long offset = swap_cache_index(entry);
+	unsigned long end = offset + nr_pages;
+
+	XA_STATE(xas, &swap_address_space(entry)->i_pages, offset);
+
+	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
+	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
+	VM_WARN_ON_ONCE(!entry.val);
+
+	/* Swap cache still stores N entries instead of a high-order entry */
+	do {
+		WARN_ON_ONCE(xas_store(&xas, new) != old);
+		xas_next(&xas);
+	} while (++offset < end);
+}
+
 /**
  * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
  * @type: Indicates the swap device.
-- 
2.51.0


