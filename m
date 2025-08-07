Return-Path: <linux-kernel+bounces-759238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976BB1DACB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D76658337E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D9E26A1CF;
	Thu,  7 Aug 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/VIvenW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAF26A0D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580464; cv=none; b=GCCQvGUiZy3tqpdLKJFCxwnRGFcPPlWJX3ykrlZatH/ab+a4BuvopyYJ2R0UnDnkZcHoDS+CXTyeOvlnFiDL/5TGubOTZiJsOJIUsbhzLngR6l0TlkdjQIOt7pJPDO8VM2GONpgO2aTQytefVb+sihM8zUilSaRVRxSefZ/tI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580464; c=relaxed/simple;
	bh=EASAPBQXsOh7DprcKSib+4mPs0vonJ2o+NBVblY+BbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7Cu0Yb+gCLphlDzYVUI+vy7w4F0hrsJ6XE/EyWNN0XhyYAWpw7W8q7G2oS5ZZ2qmmISGJZ8iU3E2ZR7iFLUoxVkc91ZJMoTtI8Y74QTCTsIyTfGKc5B4e+rGyGdcY4FVXZ7KyAYcspggKXCDeRSVXTWYkSQMenXSQn1/HljrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/VIvenW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bdc73f363so1195339b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580461; x=1755185261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W378C/ui4Nn48kbx7spSyMZJiPUfI1BuYCUSwKTLg+w=;
        b=S/VIvenWndUkIUUSYMdL+Hv0AbotavnEt2JQmbEvlt1cf1xk9ahDfDUQ8aT9WWqjgJ
         T9t+QI+XNN3v9mVSDVqCgM7d3iWP1b7XkDcU2sB7V52VqQ0Dbc6UzDl7Ttj1fVkot3nl
         Kzm1ncQKHYwdJ1s4CENU3Dy3TUlrbDSOZhLivDORjICyJOKovWQnQPx7g3PKpClEylke
         LYYT5qjKtJ0vTjKKpQbxWtmD4pFnZCWUUoNa911rEozIZqvkhM135aDfvKCAwoQQ1GgT
         OfdJlRjQsaMvWsAnB2luU5I73djVVZ/RNw11g4iEGYjexstbrjBme8267RekdDlqXrxx
         Bnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580461; x=1755185261;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W378C/ui4Nn48kbx7spSyMZJiPUfI1BuYCUSwKTLg+w=;
        b=qZSy3Q9dhI7HLfv2fuVpA9TQX42Wh9Rzj4p9KPM1e4ityuFAZ37d0ZvMVu2M8Ju0L8
         Ea6LCM5WBAXZm79lw+Lz9kpCWfGavguUA4t7tKQ6yLXvUllLcAPas+7blWlpqIuscXFR
         qXlcqmBJ4KZAb6WV9TH5NZnK6c8vKHSvH1oMPTf2AkFk1deoJsuWL2dBVNseOPabQNoi
         vE+OlR2mbCg3snhlv9nIcnYrpoelnpEmqGji8cJRW7/77HZMGz461jos2gj4mgckjf3i
         YTXeZxoLijwFrM7cjhPPppBOtIrU4v2C4m2gg8h6Igp+fP7TMA3/taIj1GH8/N5bLYBj
         eGCg==
X-Forwarded-Encrypted: i=1; AJvYcCWgNXvezz5NQ+E/R33Z6AG3S2EFdkdVmBOsOmfqtltF7pdBYafk5tvimymEdgbbSO99TlEvj8ZORLRQLRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQceK0qvZ1ZGMf5fDmT/O+aQfO6ThG2DrOlSQ45nItWzyPMJM
	KMUC9IdZUWi1DqGQOaZ5ZBeXE+k0gP4tyuUakEik5Tx8X7ri6eELQQJp
X-Gm-Gg: ASbGncuiI3RkMK4ctv2p/4jOmRkZHwublySIEtKjARwEN+TrZCEBGX306IvlB+HZ9/g
	I22FhFUv8BjT/K84qkFNVZ3M7vQJdvTVir7RPE4FP2n0aMNuQ/UOUaNcfAUyBSyWv0aCWJVyzIF
	jK0+MMB2Uen3DAzx3ar5I53sAl6XEVXDQdXtPQZ4zZlPqMzYo8OdL5zHLv3a9Mo6Tr79qwyGhMp
	/3X+J3E9jcmAjeAiyVJHSU1q0hU8AZHqCkrffz6Sh6bFT2cow3ZXi7AhS4EBCOKdhOdux5oLrMo
	6hfWxfkO117G/76Oo2ZoyR9oLlkPoHUdXGONW96UtfvtHAO5e6UP+gyOMBLXkzpFwAgYuNgkbvp
	BPtygXD6wiMvEAmXfmY6EyG/+xbQ=
X-Google-Smtp-Source: AGHT+IHRT5ELRk/Sa92iZBCL1/be7hEx7q/BlsCMtTe8yujnS/awxHGt04gM6xNE27+vWJ2mZc4/Ng==
X-Received: by 2002:a05:6a00:b95:b0:76b:d93a:69e2 with SMTP id d2e1a72fcca58-76c44a08e0bmr118401b3a.19.1754580461253;
        Thu, 07 Aug 2025 08:27:41 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm18430540b3a.18.2025.08.07.08.27.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:27:40 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 1/3] mm/mincore, swap: consolidate swap cache checking for mincore
Date: Thu,  7 Aug 2025 23:27:18 +0800
Message-ID: <20250807152720.62032-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807152720.62032-1-ryncsn@gmail.com>
References: <20250807152720.62032-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The filemap_get_incore_folio (previously find_get_incore_page) helper
was introduced by commit 61ef18655704 ("mm: factor find_get_incore_page
out of mincore_page") to be used by later commit f5df8635c5a3 ("mm: use
find_get_incore_page in memcontrol"), so memory cgroup charge move code
can be simplified.

But commit 6b611388b626 ("memcg-v1: remove charge move code") removed
that user completely, it's only used by mincore now.

So this commit basically reverts commit 61ef18655704 ("mm: factor
find_get_incore_page out of mincore_page"). Move it back to mincore side
to simplify the code.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/mincore.c    | 29 +++++++++++++++++++++++++++--
 mm/swap.h       | 10 ----------
 mm/swap_state.c | 38 --------------------------------------
 3 files changed, 27 insertions(+), 50 deletions(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 10dabefc3acc..f0d3c9419e58 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -64,8 +64,33 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t index)
 	 * any other file mapping (ie. marked !present and faulted in with
 	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
 	 */
-	folio = filemap_get_incore_folio(mapping, index);
-	if (!IS_ERR(folio)) {
+	if (IS_ENABLED(CONFIG_SWAP) && shmem_mapping(mapping)) {
+		folio = filemap_get_entry(mapping, index);
+		/*
+		 * shmem/tmpfs may return swap: account for swapcache
+		 * page too.
+		 */
+		if (xa_is_value(folio)) {
+			struct swap_info_struct *si;
+			swp_entry_t swp = radix_to_swp_entry(folio);
+			/* There might be swapin error entries in shmem mapping. */
+			if (non_swap_entry(swp))
+				return 0;
+			/* Prevent swap device to being swapoff under us */
+			si = get_swap_device(swp);
+			if (si) {
+				folio = filemap_get_folio(swap_address_space(swp),
+							  swap_cache_index(swp));
+				put_swap_device(si);
+			} else {
+				return 0;
+			}
+		}
+	} else {
+		folio = filemap_get_folio(mapping, index);
+	}
+
+	if (folio) {
 		present = folio_test_uptodate(folio);
 		folio_put(folio);
 	}
diff --git a/mm/swap.h b/mm/swap.h
index 911ad5ff0f89..1ae44d4193b1 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -64,9 +64,6 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
-struct folio *filemap_get_incore_folio(struct address_space *mapping,
-		pgoff_t index);
-
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
@@ -178,13 +175,6 @@ static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
 	return NULL;
 }
 
-static inline
-struct folio *filemap_get_incore_folio(struct address_space *mapping,
-		pgoff_t index)
-{
-	return filemap_get_folio(mapping, index);
-}
-
 static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
 {
 	return NULL;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c354435a0923..99513b74b5d8 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -323,44 +323,6 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 	return folio;
 }
 
-/**
- * filemap_get_incore_folio - Find and get a folio from the page or swap caches.
- * @mapping: The address_space to search.
- * @index: The page cache index.
- *
- * This differs from filemap_get_folio() in that it will also look for the
- * folio in the swap cache.
- *
- * Return: The found folio or %NULL.
- */
-struct folio *filemap_get_incore_folio(struct address_space *mapping,
-		pgoff_t index)
-{
-	swp_entry_t swp;
-	struct swap_info_struct *si;
-	struct folio *folio = filemap_get_entry(mapping, index);
-
-	if (!folio)
-		return ERR_PTR(-ENOENT);
-	if (!xa_is_value(folio))
-		return folio;
-	if (!shmem_mapping(mapping))
-		return ERR_PTR(-ENOENT);
-
-	swp = radix_to_swp_entry(folio);
-	/* There might be swapin error entries in shmem mapping. */
-	if (non_swap_entry(swp))
-		return ERR_PTR(-ENOENT);
-	/* Prevent swapoff from happening to us */
-	si = get_swap_device(swp);
-	if (!si)
-		return ERR_PTR(-ENOENT);
-	index = swap_cache_index(swp);
-	folio = filemap_get_folio(swap_address_space(swp), index);
-	put_swap_device(si);
-	return folio;
-}
-
 struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
-- 
2.50.1


