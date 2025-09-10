Return-Path: <linux-kernel+bounces-810626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A7B51D26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4541F580ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76A337684;
	Wed, 10 Sep 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpo5w/td"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774C32ED31
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520552; cv=none; b=tp+0CcQ8w2Jpmt3cVv25ANgpe6mTIXqISiagsF5JYsVeAavQ4mXeWx97RLd/MCzJ5yWrzhsVxaNUIghAIusQcPrwGE9WGrcB1+3NAp9NEWJXSiKx9D/wMXiZ+H1d28HITHfiqMM4lqYF+sIlurei4e8V01q5koXkM/HhtkqKGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520552; c=relaxed/simple;
	bh=X64UaZp8N953S724ZjvtTL010EKdcF41YX+AMjP9KzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRRAkFkx5aSCGb8PCSA3BjAzD0ZOi5oy5EcGQk2oxmGur4GDKKZCgqtmd7XP9qY3crY9A5u0RrjhyN4mSuMJ/3Obi21D29vI+ptU/Kf7raEomLybeeTbfzzIonejxBBdRHP2J+nSvIq71/D281YhZaP0jShoA6PVZQQgRSc+x6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpo5w/td; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722bcb989aso5278901b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520550; x=1758125350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/WGEOxJHrA21wqgG+5kS81ezpjU55LK2AmGw+vBNHk=;
        b=Bpo5w/td3nUiL4xnYOLW/eWUJK+Hp47zfDiZhXHWMotScHIYlDrP7XaKX9td48Jnqs
         L2zxTG7pHIII6D2w7Am1C2MrlpFKmUBVlZ3wuGU4KVjGGh+8xhrCUfkF5SVQDJggoMgR
         pyhSCOqjVT9prTxxGkt5OLHbzRjy7ZIXRRsyO+7iDTO67T9C9rApc87yFijHcIbXQ6yV
         i3s53YXyYWAIBq5mdDQKFpNOZbJv87WCsELDaicv8K82TmDclQRmfP210LyUF/TE3rDR
         OIUz38SeEzqouN11zpgZjaNcW4ZCtchgj3tNDNhsq1MFwfaskoz0lY6/m8Abth2Xkmql
         b3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520550; x=1758125350;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/WGEOxJHrA21wqgG+5kS81ezpjU55LK2AmGw+vBNHk=;
        b=FmIsNI4ZDlHN6UfcfMBoksstlTyZBSYiuttGcmeudL2sN9XHiF2n+yv0yh0amIks5E
         3UuAWCAguKuztEXX9u3W8hPn0haIbriNIZ7Fxr/TqB/qtfcEBS5m4l438Qrej4q42JRh
         m8GdVmrBW9AGJe4B78p077+rbnD6328SBZCqAGwjuaYJo7ZsnwZPL04KlBMu7pKi9PdK
         HKfx1DU/WMkXCJT8Ehoe+jeShZQ7ozbqJX5FoNn9o3vSOG3vgdy5LmF/nYG/y8HtyobM
         3M5pWHFWpsgQEoHV6frJRNpfJB7eL9dYx6RGr5aHVXv7B4JWJoN/S5d1RJyyNKw5bN+2
         csiA==
X-Forwarded-Encrypted: i=1; AJvYcCUhoDFLS0X0dsQIqyIv5QodaVskeHYGDpbDkQEks3NfBUMybHMURh33vwyu4B0JjV4JSTCLkNdR6dx/L4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjon4MdBjg0ZtABR17YstqJVYpqOXVyE7ELasvZl3jC7rFJ6Gp
	UIwICrv6C6tsTJeBJuiY+gqFuxJiExDb9iJMglsmj+5FIyMrGV5iAU01
X-Gm-Gg: ASbGncuZVbOkdK5LvA4lNL9bqaFI1w6k82D0NOS+Y96qiooi17zLDPYre/g6rdqNUKK
	EWKqYDRM0pT1epdysmGkB90ju7m9M2KYPcmCn2ia0ajYBLhV6jP+8Ok+fiif3yOumPhQGAc9L5S
	8pB+YREDMglHXfWGz5fz37ZirIirjvaN7w5vtM1qQwLfdYywmi6SdWILJMah0aEmxVb7q5KZxQE
	jIIv0sXc0oXrW4BQAqOr2Ra0FdTofe0fJKkMBrv4GOcQQGCz3OCJks36ms9fcpXBTLZQfrO87Fu
	GIMQG4D7KGiqTb8SJptF2SmY6c1/VWXR2r1rWb53uBtnjbF/3whAnS7qK8Jzj2KGG8yXv2VM1bR
	p7qoBqHoJM69/yqBhWSl37KwJy5B1OjURQoK2b0KhnwUzlNI=
X-Google-Smtp-Source: AGHT+IGtx55UQI+upmfsPN7ALnjl37EWjQTi7JoiDM2lB8YgnmOo7UdwmjQczornIDM65bBjDgqC/Q==
X-Received: by 2002:a05:6a20:6a10:b0:248:e0f7:1331 with SMTP id adf61e73a8af0-2533e94fa7fmr24671362637.3.1757520550410;
        Wed, 10 Sep 2025 09:09:10 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:09 -0700 (PDT)
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
Subject: [PATCH v3 05/15] mm, swap: always lock and check the swap cache folio before use
Date: Thu, 11 Sep 2025 00:08:23 +0800
Message-ID: <20250910160833.3464-6-ryncsn@gmail.com>
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
---
 mm/memory.c     |  3 +--
 mm/swap.h       | 27 +++++++++++++++++++++++++++
 mm/swap_state.c |  7 +++++--
 mm/swapfile.c   | 11 ++++++++---
 4 files changed, 41 insertions(+), 7 deletions(-)

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
index 4baebd8b48f4..f1a4d381d719 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -240,14 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * Offset could point to the middle of a large folio, or folio
 	 * may no longer point to the expected offset before it's locked.
 	 */
-	if (offset < swp_offset(folio->swap) ||
-	    offset >= swp_offset(folio->swap) + nr_pages) {
+	if (!folio_matches_swap_entry(folio, entry)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto again;
 	}
 	offset = swp_offset(folio->swap);
-
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
 			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)));
@@ -2004,6 +2002,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
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


