Return-Path: <linux-kernel+bounces-876624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA800C1C357
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2042801862
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5134F241;
	Wed, 29 Oct 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1AOEayW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B2346A0F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753583; cv=none; b=AIM56M1lAVcp2vR4Z4Z/hRhG5DgYG60deSCii7GMXTB418DGi32NT/nGG4Na/I/DMy8eyfqQdxPfse3A+M/Vp0HAhYkycIMQZ+fVF4zmMAx9OfrTbbha2I2XaEnbVo8+QiiW2B9kP6YwX+gwao/da453FqnTLHqO4l8//IQ7ENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753583; c=relaxed/simple;
	bh=p29r+QUfe/siyZxfbOGJwDMz+sqbsOaa5fULOpNDmmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqDJQiAkeWrXyctqRbCU2X6AfutSYun6I1jHlMxax2T2aGQ7f2Nb1Du2Zb7gvwV50x2zOLopkLqEv6Cn5oC+nQQIR5Wwbov9+Q6LxrJmpwy1JXoAOGpK1H2dij9KDkRzgnpH5aYIeDpoxPgzkLQf0XruONxRTn4BHa1sbvdjZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1AOEayW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2947d345949so65399225ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753580; x=1762358380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0PKlbwwkMgYNvXaDf4Er6Bj6mcJgZLUDsODPjxx62Q=;
        b=c1AOEayW34LRz3hirUk9exmqpYyVdX84xZw9H2A3+dFKd0MozVO7ydRB/JZ4XHrPza
         xvz2i9QbIDXVQEouejqOrK3BbIDPoFG7nzgN65FNy1EVkzgYGv/gqac1cFTvRkXSXYWG
         P5cDnoZJkQHXr9DP8zIqQ/JAP6+p1ZkAWHfXzaGW+DI7n3qfd/gyM6iu/EWhEbJ0Lm4c
         qC/cnQw5YQbguv51Y6cL9xeSfJgWkxGsM9Kx28FeCwlQS8rhcmK45IU1N8p38lCG1GZ9
         avYorD7PM5Lz6nGUh1hj30esLT7EJ+Bvhr13XYEALXaiBU1hma6HJAdvAboWziPl9lIR
         0HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753580; x=1762358380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0PKlbwwkMgYNvXaDf4Er6Bj6mcJgZLUDsODPjxx62Q=;
        b=AenTPpyLxROI9Nvhx7NcU2RfJ3MIlc3/70juMC6bkwhYellsAb+FzGSORjPuJFnI+K
         xMnmCXcrT6m65fwEG1e/dHAKL/luv/EvofAoIZ7w3PyqitDAG/Xyb0t7RV9PllxAJxDd
         3ihmUyjnW+jl8/vQRdBo0Uw6kGETEdJIv7eS2AmJOfrrqhNCK5vTat+hvYllXY2VMYDa
         JkRnITG46ywJxZkUczix1p3XKO0P0xUshe8zscCZyyl2ag8vCJZ+IwM7zocvstNoCOFk
         aaGS5qQRiYZ9uD0cU9ItgrhiietwPl0oiCrLfGMI3rrwZcKbPHvCcQzvLn9X5xlctHge
         MYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBKhp4dfTvKjL4tXfLRLr9W5l4K5o4MOZewUlvWAM6TR1ZOfAVJxloLBv/jZwELrR7Q/l69YPW5nYpSys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOb8qxD/pCsjMC3gQB4AJEcx1wzGUOFipmWXj/x7qPSela5Fs
	nifPDCyOTYHXxx8Z8YOY30U0ON9NDQeg0UgXlEayS0xAftFbYFMnpuTm
X-Gm-Gg: ASbGnct//eqMsq5N4XJx5WAcpENp9zlDj2ZP6Shf5aDH0nXii6zxKqo+EwqZNYZO6JM
	Lnw5STmFiVX8OkSTXihN1HH4NsarppBERIrKKlypxvfaIsvtpOBlC+6KkpPeSRKb/4cEyvQBBee
	N++CY+jmRDBsdhwmdS5qBdcD2HXiUgscGwZmH8VOKPVxrmYPp2XvIuJlNGO6tyUGRgjyzsrACBm
	s+CWK1I6eljQIK9CNqXNZd9GNt/pHT5gARWUSVq7NPcYyw23mpy5J9lzN7ymsQheU0o+bLJcXJo
	fX6xTzw+MXnhtWHeWMRjYSW13V+m1ccOBvQABXP+8UShsqrlQqxlsee7Sy0eXh+D+mH9Mh+m6t3
	esYwa4F4/tGGcJtL16Sg1lo3bzdx5R3AzduozyKc0mggPRqrq3YUbJOsP6YEr7dgJWwNnz3JGLx
	4GKu9D/v4t2ogAC+YmAO21
X-Google-Smtp-Source: AGHT+IGCBgmMdgFmMsePvkB0PmSb+aFjRIQoDbF7xmYjaqCG2xJ9PpuIvij1g6RTJtvdlQmxXngKtQ==
X-Received: by 2002:a17:902:e88b:b0:262:79a:93fb with SMTP id d9443c01a7336-294deea316fmr43936795ad.32.1761753580273;
        Wed, 29 Oct 2025 08:59:40 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:39 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:35 +0800
Subject: [PATCH 09/19] mm, swap: swap entry of a bad slot should not be
 considered as swapped out
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-9-3d43f3b6ec32@tencent.com>
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

When checking if a swap entry is swapped out, we simply check if the
bitwise result of the count value is larger than 0. But SWAP_MAP_BAD
will also be considered as a swao count value larger than 0.

SWAP_MAP_BAD being considered as a count value larger than 0 is useful
for the swap allocator: they will be seen as a used slot, so the
allocator will skip them. But for the swapped out check, this
isn't correct.

There is currently no observable issue. The swapped out check is only
useful for readahead and folio swapped-out status check. For readahead,
the swap cache layer will abort upon checking and updating the swap map.
For the folio swapped out status check, the swap allocator will never
allocate an entry of bad slots to folio, so that part is fine too. The
worst that could happen now is redundant allocation/freeing of folios
and waste CPU time.

This also makes it easier to get rid of swap map checking and update
during folio insertion in the swap cache layer.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  6 ++++--
 mm/swap_state.c      |  4 ++--
 mm/swapfile.c        | 22 +++++++++++-----------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bf72b548a96d..936fa8f9e5f3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -466,7 +466,8 @@ int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
-extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
+extern bool swap_entry_swapped(struct swap_info_struct *si,
+			       unsigned long offset);
 extern int swp_swapcount(swp_entry_t entry);
 struct backing_dev_info;
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
@@ -535,7 +536,8 @@ static inline int __swap_count(swp_entry_t entry)
 	return 0;
 }
 
-static inline bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
+static inline bool swap_entry_swapped(struct swap_info_struct *si,
+				      unsigned long offset)
 {
 	return false;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b3737c60aad9..aaf8d202434d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -526,8 +526,8 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 	if (folio)
 		return folio;
 
-	/* Skip allocation for unused swap slot for readahead path. */
-	if (!swap_entry_swapped(si, entry))
+	/* Skip allocation for unused and bad swap slot for readahead. */
+	if (!swap_entry_swapped(si, swp_offset(entry)))
 		return NULL;
 
 	/* Allocate a new folio to be added into the swap cache. */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 55362bb2a781..d66141f1c452 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1765,21 +1765,21 @@ int __swap_count(swp_entry_t entry)
 	return swap_count(si->swap_map[offset]);
 }
 
-/*
- * How many references to @entry are currently swapped out?
- * This does not give an exact answer when swap count is continued,
- * but does include the high COUNT_CONTINUED flag to allow for that.
+/**
+ * swap_entry_swapped - Check if the swap entry at @offset is swapped.
+ * @si: the swap device.
+ * @offset: offset of the swap entry.
  */
-bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
+bool swap_entry_swapped(struct swap_info_struct *si, unsigned long offset)
 {
-	pgoff_t offset = swp_offset(entry);
 	struct swap_cluster_info *ci;
 	int count;
 
 	ci = swap_cluster_lock(si, offset);
 	count = swap_count(si->swap_map[offset]);
 	swap_cluster_unlock(ci);
-	return !!count;
+
+	return count && count != SWAP_MAP_BAD;
 }
 
 /*
@@ -1865,7 +1865,7 @@ static bool folio_swapped(struct folio *folio)
 		return false;
 
 	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
-		return swap_entry_swapped(si, entry);
+		return swap_entry_swapped(si, swp_offset(entry));
 
 	return swap_page_trans_huge_swapped(si, entry, folio_order(folio));
 }
@@ -3671,10 +3671,10 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 		count = si->swap_map[offset + i];
 
 		/*
-		 * swapin_readahead() doesn't check if a swap entry is valid, so the
-		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
+		 * Allocator never allocates bad slots, and readahead is guarded
+		 * by swap_entry_swapped.
 		 */
-		if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
+		if (WARN_ON(swap_count(count) == SWAP_MAP_BAD)) {
 			err = -ENOENT;
 			goto unlock_out;
 		}

-- 
2.51.1


