Return-Path: <linux-kernel+bounces-763309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93271B2130A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458A219082F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E02D4807;
	Mon, 11 Aug 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+bQhFVp"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4029BDBA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932893; cv=none; b=R3AoSDYquhi18aJYg5r+9qzamu3smR7AyDoIFRnaebQHXGoXqL2jvTG9+U5UQqg/BDQyFibcEckYfrEibBm+tfJWqcFvFEiGa5pUxq5vk4KGiTDaYFOR76OgvyIZYRDfLxiDb2itnmka1SodgbxX9obHI8wF13DmRHsKPlngJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932893; c=relaxed/simple;
	bh=eUg/NQbLQKznC4XMAHNYR9IvreWPbdosBLoCoX+38wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqaFG2he/RVUMmr1SqGq0l/XKgPkvy3yXRdOCfR7/R8h8/DF+f66qSCQAkdzaDSxNnNpdM6gKrEp4nf13tec4iXs4oVN2WAh4Wh84laC2/OR2k3kVTQGllbBh4fts4XCqBZb+sQqZpkQ5/pM2M1EE8BtTXnAex9GzqgR4F3wLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+bQhFVp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4209a0d426so4617465a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932892; x=1755537692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7dP24dMk2MxdJIZqIqscUPVY/qEbDzRaJ+4erSqRyE=;
        b=K+bQhFVplXI7jHD7gXfNtIJYrbsn1YDR4t4ciMun6kc741gaHc38Z9ru+glGyqzGcF
         fnZsijKBC6LK5p18EYNttXGIZpDkwsFgM4t/k+DNF8oyU1cknLQ3K5TzcpzpiBAkWhGu
         OZ2uRbaYBYNSYX2E/4PpOU6bzqpe1eQ9DebMxXpLYYkAjCiT8SdSvDJJLc0FL3YQUyp0
         sPDZwJ1XP4OH2RER7zuoLnKyIbbCWnqTBjsXB8+XBlEXWDVeLxh4atzreCmD1oVcm9WJ
         ee+AYcoVlLQYgXQzgEPOtFh2fJ4sH9MTJfXOCDHomhJMsJsOpdqM5l0MPjDLbMBnhIp8
         Jl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932892; x=1755537692;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7dP24dMk2MxdJIZqIqscUPVY/qEbDzRaJ+4erSqRyE=;
        b=CzgsOPbgjjOWetsHGNQQfsU6eVwO+GUZdNePMkhATLHrAn3V7e5OuIY3RVYWIn/Kq+
         mHlpTNjGU57cjFVTxB3DsNurf6OeCedgpt5mKRHT5HqaPpYm2CrJEihKfRW5JikMrJ3y
         nN3VMNlCxtdxigrJ4TCJOpQOPQz7Yt4Qfv1T3+qlEEssZbMlZeTSqThnHegT5AzfaDs4
         BBmgmKpe2qO0wZskEQrTvB0Ma014uYBFURlfUgjVpMsA/Ntr/s+qJGx6ajCsWIKRoby3
         spsleOB3prLDf510hxSUkYQDywGJQh0bT0yPc92y/UHhqRpTkjGUj6xVRmCvD+hXdfKa
         smlw==
X-Forwarded-Encrypted: i=1; AJvYcCVX9xrDni8jI+U+7po+v0SWQbC7mna+QitTyVx5xbTTxTrKZouTVhuHu/ynWSTIDpwFUon6xp5KWaGb0kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncO0PNRyKeLsLDXe9TPhjp0yqSnwGWEH2qEimmz4zA4mJ1CBZ
	PGyIgAFd/PXX4lUBGQoyYsK5moZOzOOqsX8OEfp6dDpgNIohxWEEVh8S
X-Gm-Gg: ASbGnctISOLYm1chcygkUVHxNu/GBmOlNzCPSO3fCGZsgwSluzntqLMVbtQ1ooWbWHH
	/w9VW8rjOrOP5QT22f9pNIao4+2FT0Kdsi9vZ7bwkf2TqhD03+8N/nFZGjtVCsrrzDq9bt1spgf
	5k6cCxY6LUK/H9sIwqCHcQCiYNLv+NTvogGnhfEgbVnuvc6Fbj57Rrg1/LPufsNJsS5glLiBxbg
	/rs4RPBSWPhEV34Fes9qHmuBaS1RMsWI+7BKjTPn1xW9QkxpMrCQRAr+P8Fd6l/PvCLFG+06IH5
	RJQ77YhaJ8uVgRFoc+5u1iup2vY5J2kNnHmUvMxWZqaTfCNBgm1wMoflJ7Htkc8fSaqB9HTdZje
	FdIm4EyMF6aF9Hp+P02TdhcaO1vc=
X-Google-Smtp-Source: AGHT+IFopuiQlwhkYcY6L9G8/wk66sE58pMCCXKa6Jg6gb+DGlh9Pfbxl9B/SDORPgDwthkus9CoGA==
X-Received: by 2002:a17:902:c94d:b0:242:c66f:9f80 with SMTP id d9443c01a7336-242fc37288cmr4463315ad.53.1754932891475;
        Mon, 11 Aug 2025 10:21:31 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769fasm276685055ad.107.2025.08.11.10.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 10:21:31 -0700 (PDT)
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
Subject: [PATCH 1/2] mm/mincore, swap: consolidate swap cache checking for mincore
Date: Tue, 12 Aug 2025 01:20:17 +0800
Message-ID: <20250811172018.48901-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811172018.48901-1-ryncsn@gmail.com>
References: <20250811172018.48901-1-ryncsn@gmail.com>
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
index 10dabefc3acc..20fd0967d3cb 100644
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
+	if (!IS_ERR_OR_NULL(folio)) {
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


