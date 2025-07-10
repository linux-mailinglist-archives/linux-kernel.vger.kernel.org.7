Return-Path: <linux-kernel+bounces-724858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B573AFF7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5A01743C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1522836A4;
	Thu, 10 Jul 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khPuDqZS"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879B28506B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118671; cv=none; b=YEgR7e7iqSrsoZwq0R4RCdPL6wX4tIBYc6rsLd3coRzQdFpHNKvhp7IFUqi2at9xZSnVwPjLPduuKUL3BTNcNb5Z/43UVcLV3eUmNleIKdUoky2Jwassg5N+MB2xvDHFeF9fSDZqPM1jnkpbnNXcKkz7MgEc8Sz+5PfBfYmeDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118671; c=relaxed/simple;
	bh=+/w7KUoG3+HE19096K5cJ0YGlmFO1FHNTw3jb2v9E8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpVJDxRQzGck+cYjn54WceypzAC3nWGHvlWQUSrkgEYBaTbu3RCm9ULW1KNdegjSXd/24oL2MgYzZdI2DsG7wZErGvipChn3o4+PUgBMsJldD5EZStFUcIloNps1l8SY0cLXxiQoDWt+3qU23drwAO+ctjAY93ePP0zngr9lTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khPuDqZS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31329098ae8so564516a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118669; x=1752723469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUngWupCRmA1NcaSn0JYmN9Vt9g7u4CLfwO2X664xO0=;
        b=khPuDqZS9kheJkNY1qI7P1DHkyP2qm4fMqhwPF7TDXxaUPA+zP1SaibYcKqSGOScha
         Pv9Eywj3JU1nIXzhqQ91ofkJWHy2kmjieSmycyGnTWWeyoScshJ69AZ8y13ydTcudSMj
         x6sMnKm1KuMdW70ufAbV7R2GEILKhLsblyoZyW6fywPxE12UrYM8I+0cy7Ar1uI92/I6
         x/uReyhLuqxrmc+QS4/aIZM4uw9yzMlPjeD0ARKFeOJ+LFbtmyKjy2AOCiFqNvlKj4k9
         XUAKZfQuLvM2PNHfrJc+vIPIFBP+JPWm2Ea2eNmLdTl8LYcapVV/j7/1V1TqSiHK10vu
         E/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118669; x=1752723469;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUngWupCRmA1NcaSn0JYmN9Vt9g7u4CLfwO2X664xO0=;
        b=dw2/wNfV3qVzN9QCwNxfuEmeanBrzOtFJIpZc1gIxEmX/M7Oishp1mvDgg+RUUtq0G
         jtRqAnFFl+1Zrese2iwNatVmxROf3TD8PqKHWBRNH+4PgRRwRdDelKAqKjpPsycwjwLx
         Kf+ORGge1pkvkEVeooyOFg2m6cyT6gwodMvGWAXs+GJi0fCU/cjl2Ye0Ftj+8PLMbJ7B
         yYB0FK3wkWNmXtRJWPslkIaM1mhR3appBKGNEUIUPQo/YhGwWGnJGk2Hd8EXVBu2Msjh
         VHMyxqjhuFaZRRRgeBQBemcXP/EnG/C1oGr//VHMcoQo2aYprFnAN8s9CZ3kbys68K2u
         mcoA==
X-Forwarded-Encrypted: i=1; AJvYcCW3el6agvfFT75vRMkjfB/xWuTa61e4UtP2ifFmXYIqls1UBNDv9ewaUqM0rEkl0QhLmplHqKC/voiAHPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OmXgoty7lbW3PkcWfmjpXm30zm0KeIBg0WRT8wliJdW72kLj
	gVri7N7u8jhty36GluwUfPpLdfa7l4ANtkgDuw1fKNWSXXsXtqJHqBY/
X-Gm-Gg: ASbGncvPu0Aya2SVgc87AXjQO+CSoc6oLsz5emtTLU09CtM8QPw3395XfAXuvzA0WPh
	XCUHaAtGMjF/wzGc07C3D1M07hE8nml/HzM8qETxDeZaf8T7I+wdXPj4IuFTfyu2kC2Ju7JDjd9
	WkFDMTMptrmYXcXSEuSvDy3R4lZpU332ZDvol4kxjgLZp0AxY+G9+Ssao+gH/FyS/8PywSLjX8q
	fF6OQ9Yivs/yfNH8an+AngsAD4H/Zpr8hnPPn4qcmdnw4ARvb17n/HhXNIJBNF71wwErMPiZCm4
	k0on9pLmUUkyJokhwyODsnlCB8JfnlxYfkmiFySr/+A1tuRohduGWGJH0D66pm8WjVd5iO33ywY
	m
X-Google-Smtp-Source: AGHT+IGJMcv9Y48MgcubipVQ2N+kHU4eIToB95Q+8RK8anRoIeqtEpzS8aLCS0SfzRYrIcL0Mzs1eg==
X-Received: by 2002:a17:90a:c887:b0:30e:6a9d:d78b with SMTP id 98e67ed59e1d1-31c3cf77947mr2551192a91.12.1752118668551;
        Wed, 09 Jul 2025 20:37:48 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:47 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 4/8] mm/shmem, swap: tidy up swap entry splitting
Date: Thu, 10 Jul 2025 11:37:02 +0800
Message-ID: <20250710033706.71042-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710033706.71042-1-ryncsn@gmail.com>
References: <20250710033706.71042-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Instead of keeping different paths of splitting the entry before the
swap in start, move the entry splitting after the swapin has put
the folio in swap cache (or set the SWAP_HAS_CACHE bit). This way
we only need one place and one unified way to split the large entry.
Whenever swapin brought in a folio smaller than the shmem swap entry,
split the entry and recalculate the entry and index for verification.

This removes duplicated codes and function calls, reduces LOC,
and the split is less racy as it's guarded by swap cache now. So it
will have a lower chance of repeated faults due to raced split.
The compiler is also able to optimize the coder further:

bloat-o-meter results with GCC 14:

With DEBUG_SECTION_MISMATCH (-fno-inline-functions-called-once):
./scripts/bloat-o-meter mm/shmem.o.old mm/shmem.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-82 (-82)
Function                                     old     new   delta
shmem_swapin_folio                          2361    2279     -82
Total: Before=33151, After=33069, chg -0.25%

With !DEBUG_SECTION_MISMATCH:
./scripts/bloat-o-meter mm/shmem.o.old mm/shmem.o
add/remove: 0/1 grow/shrink: 1/0 up/down: 949/-750 (199)
Function                                     old     new   delta
shmem_swapin_folio                          2878    3827    +949
shmem_split_large_entry.isra                 750       -    -750
Total: Before=33086, After=33285, chg +0.60%

Since shmem_split_large_entry is only called in one place now. The
compiler will either generate more compact code, or inlined it for
better performance.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 56 ++++++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d8c872ab3570..97db1097f7de 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2266,14 +2266,16 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	swp_entry_t swap, index_entry;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
-	swp_entry_t swap;
 	int error, nr_pages, order, split_order;
+	pgoff_t offset;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
-	swap = radix_to_swp_entry(*foliop);
+	index_entry = radix_to_swp_entry(*foliop);
+	swap = index_entry;
 	*foliop = NULL;
 
 	if (is_poisoned_swp_entry(swap))
@@ -2321,46 +2323,35 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		}
 
 		/*
-		 * Now swap device can only swap in order 0 folio, then we
-		 * should split the large swap entry stored in the pagecache
-		 * if necessary.
-		 */
-		split_order = shmem_split_large_entry(inode, index, swap, gfp);
-		if (split_order < 0) {
-			error = split_order;
-			goto failed;
-		}
-
-		/*
-		 * If the large swap entry has already been split, it is
+		 * Now swap device can only swap in order 0 folio, it is
 		 * necessary to recalculate the new swap entry based on
-		 * the old order alignment.
+		 * the offset, as the swapin index might be unalgined.
 		 */
-		if (split_order > 0) {
-			pgoff_t offset = index - round_down(index, 1 << split_order);
-
+		if (order) {
+			offset = index - round_down(index, 1 << order);
 			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
 		}
 
-		/* Here we actually start the io */
 		folio = shmem_swapin_cluster(swap, gfp, info, index);
 		if (!folio) {
 			error = -ENOMEM;
 			goto failed;
 		}
-	} else if (order > folio_order(folio)) {
+	}
+alloced:
+	if (order > folio_order(folio)) {
 		/*
-		 * Swap readahead may swap in order 0 folios into swapcache
+		 * Swapin may get smaller folios due to various reasons:
+		 * It may fallback to order 0 due to memory pressure or race,
+		 * swap readahead may swap in order 0 folios into swapcache
 		 * asynchronously, while the shmem mapping can still stores
 		 * large swap entries. In such cases, we should split the
 		 * large swap entry to prevent possible data corruption.
 		 */
-		split_order = shmem_split_large_entry(inode, index, swap, gfp);
+		split_order = shmem_split_large_entry(inode, index, index_entry, gfp);
 		if (split_order < 0) {
-			folio_put(folio);
-			folio = NULL;
 			error = split_order;
-			goto failed;
+			goto failed_nolock;
 		}
 
 		/*
@@ -2369,15 +2360,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		 * the old order alignment.
 		 */
 		if (split_order > 0) {
-			pgoff_t offset = index - round_down(index, 1 << split_order);
-
-			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+			offset = index - round_down(index, 1 << split_order);
+			swap = swp_entry(swp_type(swap), swp_offset(index_entry) + offset);
 		}
 	} else if (order < folio_order(folio)) {
 		swap.val = round_down(swap.val, 1 << folio_order(folio));
 	}
 
-alloced:
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
@@ -2434,12 +2423,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		shmem_set_folio_swapin_error(inode, index, folio, swap,
 					     skip_swapcache);
 unlock:
-	if (skip_swapcache)
-		swapcache_clear(si, swap, folio_nr_pages(folio));
-	if (folio) {
+	if (folio)
 		folio_unlock(folio);
+failed_nolock:
+	if (skip_swapcache)
+		swapcache_clear(si, folio->swap, folio_nr_pages(folio));
+	if (folio)
 		folio_put(folio);
-	}
 	put_swap_device(si);
 
 	return error;
-- 
2.50.0


