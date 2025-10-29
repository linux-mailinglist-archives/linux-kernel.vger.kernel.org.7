Return-Path: <linux-kernel+bounces-876623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA9C1C087
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F105A49B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2254833DED3;
	Wed, 29 Oct 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncJ1Kjv5"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506134DCF5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753578; cv=none; b=bbmlXnkEkLTNCBIkaokqnqYpU9VJRYzgV7FDjDGDcG4xvqR1lJkKewBArSNWLnNk8d1/pLpd+dHV14AJb9zr7sq2+9lPZASZhJwrdn2S5FoigyzyQnCNP4T+uxertzWnyMkrVl/fOMjbS/664icc3Q6TyUuBEem/geYrCxaGxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753578; c=relaxed/simple;
	bh=ktAJtCBnfIA5dlLd5QM2wr4zYggg7zfGW4XFUwzGcBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/VBiEO3v088TXyT97JtxRxC8tpTp8brhQFZMF1yzAzmLTnVF/fNWj47jL51Wy2ZGE97TvGgPh7Pl2MSr1ZBhgmHBx2WpNHnHMfAGas8k6dwBkxIIzXdTI0zqoYSsbVIcbPNgVHUqCGLk0vJcIhmmXKypepmfSvR8ZrBRBNF6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncJ1Kjv5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33067909400so58092a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753576; x=1762358376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1touJCt8Ij13wXVlFKC93n8YCKM/wZXGXqqqq+QSOpw=;
        b=ncJ1Kjv5R0B8WfzF7t1fPXBpGyCKS5uiX+giQD72s64Da4IOj/xJV+h1izqAdyd/aA
         2sLA0rZUpmZiTNNK4t7EVvGLHEmrWVKXXglUfydn38IphkxcvlwporjQVQenxf5ahqoo
         NVvnuiw3BJ9V1TR+JoWD5ErUa+H1PAGCIvD/KiEkhxQpJKvGekz92cygVe/B+Dy+X0Be
         TpXpuqM5/RWj2mQ2pt7Q4Qs+WMCgpX+88jUuHND9caPSMYb17ycg9kHlmHjQLUWtWgmN
         GOxEZVcQyebid8FTMVw9rlzx1jfK72mCbR1BOQehrLCGFQkpoJRW8AyWkWjBWXiU80Mp
         s1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753576; x=1762358376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1touJCt8Ij13wXVlFKC93n8YCKM/wZXGXqqqq+QSOpw=;
        b=VRshzL/sGdRtQYNkxmC0ZySjjO4LvrPLpHXevuioXa6bFeFiWKDMrEhcFsUZ4DcLST
         1KmCdGFOw0tg5zheQ2WiAMZoq0NnvmxBag8bkPYWUSS60xmZTwhVU17QL3GMLRN3hBDQ
         CK+XLbbn6qRWKYIdz12jCRpnGHE0/xx9ux0XkFHKgw6edjP2yDkKHbdFAAee4HQ+IukI
         dFToxcsf2AmyRsm5MAEL+Zfz5WWN4DIv5hB3paxTFd4br1luY0z8M5c2oksxzB4Avvau
         uNEQ5A1JlCWWBVcKQpcvzpRtHUcPxIHi06Ucndtp7lPnXq3p/N1Y2n7t7hPHblASzagR
         gQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCX8qk/m7IzB5BHoJ4RUEpx+ZbprIni4PIpY/dQgAkHa3Z3dn+4vd7zDdmtcAUnI0HWGo3QkGFEsJXiHZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRehGeFVWtvGMsbLaA+jLL0Cdujsg25bS1TgI9Krof9czBvQa
	XP3KRGgYWwLP3zZxXBxBItpfgdwkWZhTIMmFmWz63IB1PP+9mSO2C92M
X-Gm-Gg: ASbGncvdWNO3mWlUEOyEgTvI8ICuqhmhQfTBGBHfLU/C0UvEN+sKfbrW3Icall1m7Ic
	YU95QU4A6Wyw6glesxXIW9TRrSX5u0EU3pBKlfKoE+vbv/aG4OdZRuYMDuwkGOsFKLFnvW9QqOs
	HYNqUtZozNG+iDUVhYuWukr0qxDlLzTfjQEnoa5D5bFfE45ICBV2Bi7qQ4+iom2CdS9mUvaa+rG
	9+zYlXBjOXlQoa88d/pVhkVu4NH+NYVe3Xsw46qixlKS6A81DsAH3ewcDTg/UfGGhOmiYAZQeWI
	NJW+XNw3TwWmrfm0y/bF5qIIS3MvkiKbSnp7YoLzy8FJ9SEhmfyP/1D+sBQS/0dR/MEXNzUiZOs
	JnQDIfwpgVO4M/d3pjgmsFymSarDByXbwnOmQAT8KzsoR1eAq0PiPlHkb9bHwCm23bpshDygGNR
	aeTF6DOwjSR9f6W8XZ8Niq
X-Google-Smtp-Source: AGHT+IFHuFprzRWbK9qS6JvIV2N1AbXu0GbLXktN8sr1Qqk543SOL3MlPU4u1zXhTQjIeIb0517XQQ==
X-Received: by 2002:a17:902:ced2:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-294def36255mr40105735ad.49.1761753575586;
        Wed, 29 Oct 2025 08:59:35 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:35 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:34 +0800
Subject: [PATCH 08/19] mm/shmem, swap: remove SWAP_MAP_SHMEM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-8-3d43f3b6ec32@tencent.com>
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

From: Nhat Pham <nphamcs@gmail.com>

The SWAP_MAP_SHMEM state was introduced in the commit aaa468653b4a
("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a swap entry
belongs to shmem during swapoff.

However, swapoff has since been rewritten in the commit b56a2d8af914
("mm: rid swapoff of quadratic complexity"). Now having swap count ==
SWAP_MAP_SHMEM value is basically the same as having swap count == 1,
and swap_shmem_alloc() behaves analogously to swap_duplicate(). The only
difference of note is that swap_shmem_alloc() does not check for
-ENOMEM returned from __swap_duplicate(), but it is OK because shmem
never re-duplicates any swap entry it owns. This will stil be safe if we
use (batched) swap_duplicate() instead.

This commit adds swap_duplicate_nr(), the batched variant of
swap_duplicate(), and removes the SWAP_MAP_SHMEM state and the
associated swap_shmem_alloc() helper to simplify the state machine (both
mentally and in terms of actual code). We will also have an extra
state/special value that can be repurposed (for swap entries that never
gets re-duplicated).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h | 15 +++++++--------
 mm/shmem.c           |  2 +-
 mm/swapfile.c        | 42 +++++++++++++++++-------------------------
 3 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 38ca3df68716..bf72b548a96d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -230,7 +230,6 @@ enum {
 /* Special value in first swap_map */
 #define SWAP_MAP_MAX	0x3e	/* Max count */
 #define SWAP_MAP_BAD	0x3f	/* Note page is bad */
-#define SWAP_MAP_SHMEM	0xbf	/* Owned by shmem/tmpfs */
 
 /* Special value in each swap_map continuation */
 #define SWAP_CONT_MAX	0x7f	/* Max count */
@@ -458,8 +457,7 @@ bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
+extern int swap_duplicate_nr(swp_entry_t entry, int nr);
 extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -514,11 +512,7 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
-{
-}
-
-static inline int swap_duplicate(swp_entry_t swp)
+static inline int swap_duplicate_nr(swp_entry_t swp, int nr_pages)
 {
 	return 0;
 }
@@ -569,6 +563,11 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 }
 #endif /* CONFIG_SWAP */
 
+static inline int swap_duplicate(swp_entry_t entry)
+{
+	return swap_duplicate_nr(entry, 1);
+}
+
 static inline void free_swap_and_cache(swp_entry_t entry)
 {
 	free_swap_and_cache_nr(entry, 1);
diff --git a/mm/shmem.c b/mm/shmem.c
index 759981435953..46d54a1288fd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1665,7 +1665,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 			spin_unlock(&shmem_swaplist_lock);
 		}
 
-		swap_shmem_alloc(folio->swap, nr_pages);
+		swap_duplicate_nr(folio->swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
 		BUG_ON(folio_mapped(folio));
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3898c3a2be62..55362bb2a781 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -201,7 +201,7 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 	unsigned char *map_end = map + nr_pages;
 	unsigned char count = *map;
 
-	if (swap_count(count) != 1 && swap_count(count) != SWAP_MAP_SHMEM)
+	if (swap_count(count) != 1)
 		return false;
 
 	while (++map < map_end) {
@@ -1522,12 +1522,6 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
 	if (usage == SWAP_HAS_CACHE) {
 		VM_BUG_ON(!has_cache);
 		has_cache = 0;
-	} else if (count == SWAP_MAP_SHMEM) {
-		/*
-		 * Or we could insist on shmem.c using a special
-		 * swap_shmem_free() and free_shmem_swap_and_cache()...
-		 */
-		count = 0;
 	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
 		if (count == COUNT_CONTINUED) {
 			if (swap_count_continued(si, offset, count))
@@ -1625,7 +1619,7 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
 	if (nr <= 1)
 		goto fallback;
 	count = swap_count(data_race(si->swap_map[offset]));
-	if (count != 1 && count != SWAP_MAP_SHMEM)
+	if (count != 1)
 		goto fallback;
 
 	ci = swap_cluster_lock(si, offset);
@@ -1679,12 +1673,10 @@ static bool swap_entries_put_map_nr(struct swap_info_struct *si,
 
 /*
  * Check if it's the last ref of swap entry in the freeing path.
- * Qualified value includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
  */
 static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
 {
-	return (count == SWAP_HAS_CACHE) || (count == 1) ||
-	       (count == SWAP_MAP_SHMEM);
+	return (count == SWAP_HAS_CACHE) || (count == 1);
 }
 
 /*
@@ -3672,7 +3664,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-	VM_WARN_ON(usage == 1 && nr > 1);
 	ci = swap_cluster_lock(si, offset);
 
 	err = 0;
@@ -3732,27 +3723,28 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	return err;
 }
 
-/*
- * Help swapoff by noting that swap entry belongs to shmem/tmpfs
- * (in which case its reference count is never incremented).
- */
-void swap_shmem_alloc(swp_entry_t entry, int nr)
-{
-	__swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
-}
-
-/*
- * Increase reference count of swap entry by 1.
+/**
+ * swap_duplicate_nr() - Increase reference count of nr contiguous swap entries
+ *                       by 1.
+ *
+ * @entry: first swap entry from which we want to increase the refcount.
+ * @nr: Number of entries in range.
+ *
  * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
  * but could not be atomically allocated.  Returns 0, just as if it succeeded,
  * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
  * might occur if a page table entry has got corrupted.
+ *
+ * Note that we are currently not handling the case where nr > 1 and we need to
+ * add swap count continuation. This is OK, because no such user exists - shmem
+ * is the only user that can pass nr > 1, and it never re-duplicates any swap
+ * entry it owns.
  */
-int swap_duplicate(swp_entry_t entry)
+int swap_duplicate_nr(swp_entry_t entry, int nr)
 {
 	int err = 0;
 
-	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
+	while (!err && __swap_duplicate(entry, 1, nr) == -ENOMEM)
 		err = add_swap_count_continuation(entry, GFP_ATOMIC);
 	return err;
 }

-- 
2.51.1


