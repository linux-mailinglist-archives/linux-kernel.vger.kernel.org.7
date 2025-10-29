Return-Path: <linux-kernel+bounces-876628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E8C1C280
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2B775C7677
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E823350A14;
	Wed, 29 Oct 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geSZPLtb"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D3347FE9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753603; cv=none; b=DfUiJ5s6PwxncKxUmlJClCqgFZIduHZxUKuqOjwOQVn5rB9ibvjerVsBjAll/ojEG3cdhQcv+HUUpdNiM3xh33attfhXpFSBf2hdFED0a7zM8A4ck3lLtGUa/uH/7Cnf10UzvXnRGIUVnBzcoAIgUI9lCAXv3EqK9oBhn+p+77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753603; c=relaxed/simple;
	bh=ByTK2SoyQgaA/mDCQcIjTZ8xrs8DpFkCl7HauPrEv1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvB7ucWUwi4u80yhuBxjkwW/4bgwidtlkX+v0b+fY1E0aY7jAFmbwQRe3M2PPIQiTGm0pjtIz3my9On7hujzP/UeA6u4cp0Ug5u4T6aAYS8220EOA2fx3k7TxzVPo/pnVjboC2GonXppml/OvH+a2+tJUg3PCclO+yzydhejSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geSZPLtb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3307de086d8so65875a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753599; x=1762358399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaJeOLc41bvRnU13WOF01XHE844GkJvbSlk0im22rDM=;
        b=geSZPLtbm/Eove1aWva6FamxThVtO0NUquAmNQAsOe0N32Z+GNbateWG6qZh9SnBiq
         dr6tCnw4rBfW4rJVJ6S7bb79n3JehAGXUAZKow7JJ4iT1S9ISLxDLi+Sc02CvOSw6HMe
         GtWV7JVNvtWbM6QPCSAMsNI/az9tEdVbKKd6Cnyd57mB6p98I8N5PrI4L3W1gAGktAdu
         64/KqmiUp3jOZ6BP6ekGb5HVMU+nGpPuSBB0gsQhFAwKug2CxGOoUjW0Mdg4ZNHE8HuO
         oqu/0QfrZRvcreqRi3N97Nj1axahmsLi9y2upmX8j0ccWo6fIxpoKdVYw1P0gWZ2yS+0
         dfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753599; x=1762358399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaJeOLc41bvRnU13WOF01XHE844GkJvbSlk0im22rDM=;
        b=oiqPZrNa3NO2LqhSFX/lJJ2Ft8SRUkRRr3IuM4O8XtcxrvX/vtlkRqtbbCbxtrQv28
         p7M825+gf2+9JzkGDIRS/yix9U2tYCcEEMWD2qAdkOgtKPilWH6Te3ikL7ua75XW4MHd
         ViUQ7AEgn6OSs0wbWfrd9w2u7hQUJhXg/0YmyVDaQDn1/PvyOQku4q033/ijBNQG9yrO
         5PqZRpd6tyM5S9d7kA1MrsVeaf0O5GsxImT88jQl1Ju9A9ckOPVWHk+0OjWmDnE0nLeK
         8GmfdoWObHuIXyi0A06SeyXn9skIgMvcUA7uG+jO0LSEW1gTBcteNCvGo/xfSI0qlP2l
         D6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqbOajzOLiJajdsNM5Lnuun7eExtvgrdVg/SBKgQT8lLuv3q9kFQxJgaM9s/ilmImzardaEpQaHvNoCkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMlJVG+j5ip5/AFErje4aW0uRpSxEUQ9eoQ1LXN4SqIWt8+4v
	xNpkxAHVnwHwev8tJgEX7rqOHL1cyZ/FhQIlk23SD1HSaapAf3JYz4W5
X-Gm-Gg: ASbGncuUW2ocCKrB2C7q7sR/G4VPZkaBGqUYM+tv/WWR1ce3ctCEYveobL2Br/Fqhjx
	I6B2AuXkf2Lv8/0fGISEJt2x3UCI5nYHC8kFmzBDdYtmQ3ls9htMLFsphygZIynDzPNGn8JGrDf
	ORFByni1U0qDN9NBmxGbtdrFyiXTkb5H1wyRE4Y+oSWm7RPTYftsud9rRTL6x7Lp/lt2MnGmQ2l
	Mtl1I+d8SWEl+etslvREhmfrg08XUIAd1NwJ/XwK9AvN4W3k9KV2X9o8bcS/1CTuyoBn5fMzPz4
	usd7FFJFpdRF7KUybB+tebFzgRfHEvKbBVMJ6H+dqsnrcvrzA3fS0DTqlIr/m1SLyjT88IbX3NP
	x8ZBajtBlGSM8YtxQAQTP0NBKGMwZPkRJx9IWwOwGJRTpLpbdP53dnUtCtKTbls9v2PtMRep0W1
	YDdLd5QqJtyxYATYcvvw4+WnZkCeAqfbk=
X-Google-Smtp-Source: AGHT+IFBM69X5pxHyD3MEtjs9Hok3q/yPZBDJUCYgD5ZLroaODN6kmz+XKztQfn2faRgu7hlU5vjoA==
X-Received: by 2002:a17:90b:2e4b:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-3403a305995mr3636072a91.34.1761753599453;
        Wed, 29 Oct 2025 08:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:59 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:39 +0800
Subject: [PATCH 13/19] mm, swap: remove workaround for unsynchronized swap
 map cache state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-13-3d43f3b6ec32@tencent.com>
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

Remove the "skip if exists" check from commit a65b0e7607ccb ("zswap:
make shrinking memcg-aware"). It was needed because there is a tiny time
window between setting the SWAP_HAS_CACHE bit and actually adding the
folio to the swap cache. If a user is trying to add the folio into the
swap cache but another user was interrupted after setting SWAP_HAS_CACHE
but hasn't added the folio to the swap cache yet, it might lead to a
deadlock.

We have moved the bit setting to the same critical section as adding the
folio, so this is no longer needed. Remove it and clean it up.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |  2 +-
 mm/swap_state.c | 27 ++++++++++-----------------
 mm/zswap.c      |  2 +-
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 3cd99850bbaf..a3c5f2dca0d5 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -260,7 +260,7 @@ int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 void swap_cache_del_folio(struct folio *folio);
 struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
 				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *alloced, bool skip_if_exists);
+				     bool *alloced);
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_del_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry, void *shadow);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2d53e3b5e8e9..d2bcca92b6e0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -447,8 +447,6 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
  * @folio: folio to be added.
  * @gfp: memory allocation flags for charge, can be 0 if @charged if true.
  * @charged: if the folio is already charged.
- * @skip_if_exists: if the slot is in a cached state, return NULL.
- *                  This is an old workaround that will be removed shortly.
  *
  * Update the swap_map and add folio as swap cache, typically before swapin.
  * All swap slots covered by the folio must have a non-zero swap count.
@@ -459,8 +457,7 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
  */
 static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 						  struct folio *folio,
-						  gfp_t gfp, bool charged,
-						  bool skip_if_exists)
+						  gfp_t gfp, bool charged)
 {
 	struct folio *swapcache = NULL;
 	void *shadow;
@@ -480,7 +477,7 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 		 * might return a folio that is irrelevant to the faulting
 		 * entry because @entry is aligned down. Just return NULL.
 		 */
-		if (ret != -EEXIST || skip_if_exists || folio_test_large(folio))
+		if (ret != -EEXIST || folio_test_large(folio))
 			goto failed;
 
 		swapcache = swap_cache_get_folio(entry);
@@ -513,8 +510,6 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
  * @mpol: NUMA memory allocation policy to be applied
  * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
  * @new_page_allocated: sets true if allocation happened, false otherwise
- * @skip_if_exists: if the slot is a partially cached state, return NULL.
- *                  This is a workaround that would be removed shortly.
  *
  * Allocate a folio in the swap cache for one swap slot, typically before
  * doing IO (swap in or swap out). The swap slot indicated by @entry must
@@ -526,8 +521,7 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
  */
 struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *new_page_allocated,
-				     bool skip_if_exists)
+				     bool *new_page_allocated)
 {
 	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct folio *folio;
@@ -548,8 +542,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 	if (!folio)
 		return NULL;
 	/* Try add the new folio, returns existing folio or NULL on failure. */
-	result = __swap_cache_prepare_and_add(entry, folio, gfp_mask,
-					      false, skip_if_exists);
+	result = __swap_cache_prepare_and_add(entry, folio, gfp_mask, false);
 	if (result == folio)
 		*new_page_allocated = true;
 	else
@@ -578,7 +571,7 @@ struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	entry = swp_entry(swp_type(entry), round_down(offset, nr_pages));
-	swapcache = __swap_cache_prepare_and_add(entry, folio, 0, true, false);
+	swapcache = __swap_cache_prepare_and_add(entry, folio, 0, true);
 	if (swapcache == folio)
 		swap_read_folio(folio, NULL);
 	return swapcache;
@@ -606,7 +599,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
-					&page_allocated, false);
+				       &page_allocated);
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
@@ -725,7 +718,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		folio = swap_cache_alloc_folio(
 			swp_entry(swp_type(entry), offset), gfp_mask, mpol, ilx,
-			&page_allocated, false);
+			&page_allocated);
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -743,7 +736,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
-					&page_allocated, false);
+				       &page_allocated);
 	if (unlikely(page_allocated))
 		swap_read_folio(folio, NULL);
 	return folio;
@@ -838,7 +831,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
-						&page_allocated, false);
+					       &page_allocated);
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -858,7 +851,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 skip:
 	/* The folio was likely read above, so no need for plugging here */
 	folio = swap_cache_alloc_folio(targ_entry, gfp_mask, mpol, targ_ilx,
-					&page_allocated, false);
+				       &page_allocated);
 	if (unlikely(page_allocated))
 		swap_read_folio(folio, NULL);
 	return folio;
diff --git a/mm/zswap.c b/mm/zswap.c
index a7a2443912f4..d8a33db9d3cc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1015,7 +1015,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, mpol,
-				       NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
+				       NO_INTERLEAVE_INDEX, &folio_was_allocated);
 	put_swap_device(si);
 	if (!folio)
 		return -ENOMEM;

-- 
2.51.1


