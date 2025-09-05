Return-Path: <linux-kernel+bounces-803647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C4B46356
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D56917153B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02952741A6;
	Fri,  5 Sep 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBOi0Hli"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120327B32B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099679; cv=none; b=tN2nPM7/N+kD/sl3aj4XadxURLY5QH4UN06bGP0e6+wxewR50GNrWuntnSSpOepnPNUaTUek0wpJkmJmHbtQrdJamKIYGMPb1vGYI73oNMCPlM0Z6CdbiRaAq3OvtMpB1HS3h+4SSnWGDh+PfA0kbjUuGaaR4qio1sIjYnxQy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099679; c=relaxed/simple;
	bh=4KpjepTCIfFn2CYzGFPHQ95P8vG1TGauuBTZWpu7bfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erjSVq5hCcF2XlnYoXkCIukzrTnW5y5GVcj8Iu4cYjiZQgl5CLz+7n/3jvMUh+tNNpDB/DZZPYTqIsCgdXw0XCY7RDjEjIcTcAm94IVft42DWUg6gujncUDoW3zEWjp8NMPwwpApIOxeGL7WmA3ojj9eZFhnlD9HNERDV1db1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBOi0Hli; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b52196e8464so391411a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099677; x=1757704477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcBRC1dfTG2s+aFL1L7sgVVmaFlNWBkL9Ua/k3R9Js8=;
        b=nBOi0HliRzXtnNrW22gPoEkHJeH3o6ts4kC970AI+el4sOg2kAfpDtsO68X0oObCiq
         pd+V4fQPQ/QDcGWzl/DWEq2c+AOd5HWCGiM6mBwqUlgm+PAmpdssOY3gQ00/zp2r6+o7
         +9Os10EFW8thI2A+bsQY1oX6rpbHB+YC9tMHCRNpL43MV9vTNcsyg8MRiLbrrnHhHRmp
         ulMcxiNBjP6WLw4pl1K4bAJi/T29LWMRQuANFEo/k/Rzn3wm/9rYq71YDWKuz225+Bdt
         IaepBA5Icc/kxtMUlKUlnnh3g0sMc4ayklUGUI7DSJTCNADlUuQtUa78LaHQehmjFH5R
         X6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099677; x=1757704477;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcBRC1dfTG2s+aFL1L7sgVVmaFlNWBkL9Ua/k3R9Js8=;
        b=ZFJTBGZpqH4wSM+szCEiw4QC8lA8vqSBdoOlU5DbImI9r1wZwDa7DaFMK1rY76NCPv
         UUd8ZyFGe8bybCvPTJqIb09PFgLunV4Reh3zieztMY37bFsNwId4ATOH2imRRaoovVMh
         +9Xkomt6C+IprgWsT/WS8jqLGSxSpLt7t11yCmrBwV3U8ooIrdB8ieoATOaSW1v20azB
         4BkQA92BbbeEvOj1Aejcg9rA4Ih1250M9afdk5qKr9ZZBJrRpr7JKTMaiUFDM+89ll5W
         kqgoiXfjljj2SYjIv5zNT8m9GCg1w7WeuyZOZXHrlpQvQw2g87xaS92Ru6rrMEclnBK2
         mPfg==
X-Forwarded-Encrypted: i=1; AJvYcCUB3v2F1DM76MchgYB0j6Hwp0mvjhNHZ3rz8VYm0LSpNcMWX1Ocuq1nfPiv8sc546odI0vmZX+Z0YcygRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/31U/G/Fq0A6fCfAWjnvfCZ9/LwmetWBoEe50ooixiouFHxh
	f4ED495h24IYLSEfVW4FFtLDsODpdpbX/9kNm9C8KDTovLLklMakxX84
X-Gm-Gg: ASbGnculTJ65gJwTDMFo4Zy011gZYs+qU3UcCxfsnqH8GOaEito6LkuPEQ8zUYC6y9P
	LSHTPsfzQG890qzM+q0UhL+UcKVegZeKvL94GseaUG9akBKwe4LZPNd7xFBU6eEXaWJoHkGW7lW
	Fft2crYsy2H4nl/P3GRV4m5ZyJzxObuH4jUR0uETNEz8F6AuBNtAg2p0lAOMWgnYVfVUbzHDg4m
	gYMVhDI51EBcVaeCmV6gcNIl5zZPTbj2lUsnv+89z0eG9wfNcMbiuYEjgFuRad4nvP7mZlGVeQm
	jobpkh61WwRJPOWUS9ZSC31+rzi6RGbqvXNqYtOcJq/5qpct5uF5UM4JZO0g5kxCwCcSmyZBk0N
	rs/smyOetj481JsM68iCov6QQtkC1WDlcXmaP5WsTElDZEPI=
X-Google-Smtp-Source: AGHT+IH0gGzdjlZMueDj/hSEJuQyIDnEEPfDmDuK23QnXLBRkJurBKBb+WQfJlSWK4T1Xzn33MtTuA==
X-Received: by 2002:a17:90b:51c4:b0:32b:98a3:7409 with SMTP id 98e67ed59e1d1-32b98a37612mr8823618a91.34.1757099676730;
        Fri, 05 Sep 2025 12:14:36 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:36 -0700 (PDT)
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
Subject: [PATCH v2 05/15] mm, swap: always lock and check the swap cache folio before use
Date: Sat,  6 Sep 2025 03:13:47 +0800
Message-ID: <20250905191357.78298-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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
 mm/swap.h       | 24 ++++++++++++++++++++++++
 mm/swap_state.c |  7 +++++--
 mm/swapfile.c   | 10 +++++++---
 4 files changed, 37 insertions(+), 7 deletions(-)

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
index efb6d7ff9f30..a69e18b12b45 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -52,6 +52,25 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
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
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	if (!folio_test_swapcache(folio))
+		return false;
+	VM_WARN_ON_ONCE_FOLIO(!IS_ALIGNED(folio->swap.val, folio_nr_pages(folio)), folio);
+	return folio->swap.val == round_down(entry.val, folio_nr_pages(folio));
+}
+
 void show_swap_cache_info(void);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
 int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
@@ -144,6 +163,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
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
index 4c63fc62f4cb..1bd90f17440f 100644
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
@@ -2150,6 +2148,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 
 		folio_lock(folio);
+		if (!folio_matches_swap_entry(folio, entry)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
 		folio_wait_writeback(folio);
 		ret = unuse_pte(vma, pmd, addr, entry, folio);
 		if (ret < 0) {
-- 
2.51.0


