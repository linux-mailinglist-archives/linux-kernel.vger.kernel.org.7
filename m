Return-Path: <linux-kernel+bounces-819206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98885B59CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EF41C04979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA137C0E0;
	Tue, 16 Sep 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STb1ljDT"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4F233D9C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038506; cv=none; b=Gy2LD2yh3TC+li5njvmQJewQhdXjFbhBrustaFFbm3koEcoZesz5bhsok2iDyhNRgwn4Jv73qk13o3wTHv1gCbfqf2AgDCCEi5TFX4i1YtF+xT+2XEUVhlNaeNbAErKNlQgaNB/xfncLH8acv/IOSgi/jz5vLX2Lph1qicHNKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038506; c=relaxed/simple;
	bh=yieOT8/80M/1WnN5biSPhKtXAGpzbL26RDyuZIwykEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy1dgVKJeEX9j9YjzGyjF+hQ5sln2q19hKqlO7xDJkfiPFym64lPK/6VQlw4ID48ICGp0J1JHjH8dmu28lEzMgbIB1gTMdRck4qP533Y0WKKxgDD8nkKCKFlnlqxvlipLYPak7fYCZ5WDlC9uWfRotLdFOQ61bos3+fseV85nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STb1ljDT; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43d2da52291so946856b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038504; x=1758643304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5WUbuObwR/zGB6o+458rEcXiMc4zzBo5aJZO+2YfyDE=;
        b=STb1ljDTL52wNwOxMrnRtOqht+UIX6vGlQFgfqvfql/KuP/456g/NW0wJbZ8QnHQBv
         0ZwvfOv2cP8l55hQ8ic1PA3g2nxR0MVhAJZ/V/pDPzgYMavCTpFUJPBQ+TQqkl066Fvs
         MGfTiMyEtFm2/n5DCzfFNGeEuEfN9c4M7rbm/kDiYmmRn+MOpTWLWCBvKJoaBlAdvmOK
         yty3HD2AA1xZPERUq0U48YPk0kLA4A1D+YM+qeCjaV6YHaELg6Xv26O71sWqknhbGZC/
         OXg3qvIf/DTGTB6qIa/oNYQe735T8O5A6ekmFpAB0iHzfChrdelPdJfkidF+LoO3xkM/
         zU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038504; x=1758643304;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WUbuObwR/zGB6o+458rEcXiMc4zzBo5aJZO+2YfyDE=;
        b=O8vWC35zfsNX7opzpBm5RaumeXYoghDq2zwtnVKe8/vZfVZrdSoj/VO3VFYERcvoK0
         J5JV7sEW1Ce4zQOOOObFwPJ9aePW9XkoxzevroIxkWDEWlT7qaUy+abK4ElH0PCAugSZ
         8s9K2sAVc9aR81p58PETIOjohrRM1k2pVLcuLwM8v6OchW1TDq/xp7mZRSwC2piUovWS
         UpI7aPclbCtfyoZqGKemYwdcL/x1NFhR59/OYm0G8qRpOq+zgp8lK86jmmklwNsA5mUX
         idKK1WdiZqP7N/wRm2FT3cfid+5xdSP9tYtEt7NC33LXhkxfHOfL20i1LSNtp+dJbGSL
         mXTw==
X-Forwarded-Encrypted: i=1; AJvYcCVyTkDHOst5AaRDgEO/Zbt5qm9UFLE/LN4Zf+pMGxaFWXpvhZ88tNDbTclfWC43J02joAGGtH0k3jeZ8Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPpfAK6uL6UDylOaQv02MGy8T609mwqCjJIK24mab6saH08VX
	4B+jHVGpgDpfQkYU3VhKMh+wiWaTzgFDqILPJY4stSB5vpd0pDSh7FSm
X-Gm-Gg: ASbGncugOc6a7qlEG9tdF1Y6T3Ce1f3SxOODCBxEs4VlYs6Nus+re3ucToxsTx5JnuM
	NuDA6YpROn2wSPe9Pam7mBqkzLbFssl2b2FWc3O8neSNSxy/KY/P0R0SGBl2GBfbxI8okSy6Uoz
	pnfj36hlNYqK7z1EW9CVWnfjZRwr6aHkW/XMp4bhbr1ezDkV2iYdSmU15e1RmCFrVyvTNzcS/46
	Di0suCO4dx68MhyUhrvrscHgUsIBzsqMmzFgBkvIYbwrgjj7nKzssnxIyRSQKviFlvEf+hSi6Jj
	NNC/DcFMMjD2E6d6tibrl31070VOgxlEfuTrU+qfiKpqDZ0GaAxBuU/HYaqnrGPxxTVVZi9bNu4
	6hdmxL+bczVY3tUnJJ0yYABVQLBctzB/uWNnct0FtfXe2GJM=
X-Google-Smtp-Source: AGHT+IFBhPfVPOhAahuA6aEtJjmdTvB1mnKAm6YCg8IDJDgWKnZus2UsNTSxw89RB9zsYks/2PG9OQ==
X-Received: by 2002:a05:6808:1514:b0:437:f998:22 with SMTP id 5614622812f47-43d3f46503emr1431448b6e.21.1758038503102;
        Tue, 16 Sep 2025 09:01:43 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.01.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:01:42 -0700 (PDT)
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
Subject: [PATCH v4 05/15] mm, swap: always lock and check the swap cache folio before use
Date: Wed, 17 Sep 2025 00:00:50 +0800
Message-ID: <20250916160100.31545-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swap cache lookup only increases the reference count of the returned
folio. That's not enough to ensure a folio is stable in the swap
cache, so the folio could be removed from the swap cache at any
time. The caller should always lock and check the folio before using it.

We have just documented this in kerneldoc, now introduce a helper for swap
cache folio verification with proper sanity checks.

Also, sanitize a few current users to use this convention and the new
helper for easier debugging. They were not having observable problems
yet, only trivial issues like wasted CPU cycles on swapoff or
reclaiming. They would fail in some other way, but it is still better to
always follow this convention to make things robust and make later
commits easier to do.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/memory.c     |  3 +--
 mm/swap.h       | 27 +++++++++++++++++++++++++++
 mm/swap_state.c |  7 +++++--
 mm/swapfile.c   | 10 ++++++++--
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 94a5928e8ace..5808c4ef21b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4748,8 +4748,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * swapcache, we need to check that the page's swap has not
 		 * changed.
 		 */
-		if (unlikely(!folio_test_swapcache(folio) ||
-			     page_swap_entry(page).val != entry.val))
+		if (unlikely(!folio_matches_swap_entry(folio, entry)))
 			goto out_page;
 
 		if (unlikely(PageHWPoison(page))) {
diff --git a/mm/swap.h b/mm/swap.h
index efb6d7ff9f30..7d868f8de696 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -52,6 +52,28 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
 	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
 }
 
+/**
+ * folio_matches_swap_entry - Check if a folio matches a given swap entry.
+ * @folio: The folio.
+ * @entry: The swap entry to check against.
+ *
+ * Context: The caller should have the folio locked to ensure it's stable
+ * and nothing will move it in or out of the swap cache.
+ * Return: true or false.
+ */
+static inline bool folio_matches_swap_entry(const struct folio *folio,
+					    swp_entry_t entry)
+{
+	swp_entry_t folio_entry = folio->swap;
+	long nr_pages = folio_nr_pages(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	if (!folio_test_swapcache(folio))
+		return false;
+	VM_WARN_ON_ONCE_FOLIO(!IS_ALIGNED(folio_entry.val, nr_pages), folio);
+	return folio_entry.val == round_down(entry.val, nr_pages);
+}
+
 void show_swap_cache_info(void);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
 int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
@@ -144,6 +166,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
 	return 0;
 }
 
+static inline bool folio_matches_swap_entry(const struct folio *folio, swp_entry_t entry)
+{
+	return false;
+}
+
 static inline void show_swap_cache_info(void)
 {
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 68ec531d0f2b..9225d6b695ad 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -79,7 +79,7 @@ void show_swap_cache_info(void)
  * with reference count or locks.
  * Return: Returns the found folio on success, NULL otherwise. The caller
  * must lock and check if the folio still matches the swap entry before
- * use.
+ * use (e.g. with folio_matches_swap_entry).
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
@@ -346,7 +346,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	for (;;) {
 		int err;
 
-		/* Check the swap cache in case the folio is already there */
+		/*
+		 * Check the swap cache first, if a cached folio is found,
+		 * return it unlocked. The caller will lock and check it.
+		 */
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			goto got_folio;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4baebd8b48f4..c3c3364cb42e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -240,8 +240,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * Offset could point to the middle of a large folio, or folio
 	 * may no longer point to the expected offset before it's locked.
 	 */
-	if (offset < swp_offset(folio->swap) ||
-	    offset >= swp_offset(folio->swap) + nr_pages) {
+	if (!folio_matches_swap_entry(folio, entry)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto again;
@@ -2004,6 +2003,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	bool hwpoisoned = false;
 	int ret = 1;
 
+	/*
+	 * If the folio is removed from swap cache by others, continue to
+	 * unuse other PTEs. try_to_unuse may try again if we missed this one.
+	 */
+	if (!folio_matches_swap_entry(folio, entry))
+		return 0;
+
 	swapcache = folio;
 	folio = ksm_might_need_to_copy(folio, vma, addr);
 	if (unlikely(!folio))
-- 
2.51.0


