Return-Path: <linux-kernel+bounces-772981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60344B29A07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E063B7985
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8192798EB;
	Mon, 18 Aug 2025 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0Rpyu4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98625C83A;
	Mon, 18 Aug 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499597; cv=none; b=uneCBYueVItCwGjen+uE1LSZcuNReKX5vOWpSBO4hRUmQf1VNn1i/rJiGAAQT4SjyBqLn0GzQz1+az9mVkAF2AXqarfqTH7+D0q4B/wV+lJaw8cL5x/ydG2HsGutHwkLG8nfywA6JpGgQt4DaqdS/cqhHvsz3V9MfOoMGTqxJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499597; c=relaxed/simple;
	bh=mWBw2dxrn3qCb6ZjGXqIStKZeXRZV0QwSHDvWZaNzXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYaTldkY4j4JlPPTGuw/gyuvDu2WWzptplKLuNcyDY+KQ5elhvPzbJv6age3NWHyV+3gvmlK9C6ZwGbgTwRjw3/8hwncMEnZkRLaAJePNntLJBjqm/i4bGCkWyp65uRwxP8/6AwboKCwEj/uLBHYSNXNMfpoeXZvU63UixqAw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0Rpyu4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325E2C4CEEB;
	Mon, 18 Aug 2025 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755499597;
	bh=mWBw2dxrn3qCb6ZjGXqIStKZeXRZV0QwSHDvWZaNzXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0Rpyu4y8bEUq8EbFwZHD5j3l2gjivkI8HDDJLhyxDRHEzCdCC1nxhMjOdh19vgTq
	 l2Rzc/qXKbDwoWkF8Ma9mBNItHubHiDEcL60X2pyfsp/yozfyASpmtNvkn2ppiP6bB
	 K6wWyhJ/w6QjVyS96IfFo28aq/M+NW61AdgJE1nl989dXsHPbfrR1fQmRp6glOM3xP
	 5DSgy8XwoD+L7Spl9BPnUEIZbM9qVXYU7mj/i2XxngBbxSUtSsf8JKLy3qvkjxZySg
	 d7lut5t2oHgzynTJjzf0lUc+6ZM4fT2vERwhMokUsHvgPSi31DWsxsDcw2doc3jVyJ
	 qazIie45dnMmQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 4/4] memblock: drop for_each_free_mem_pfn_range_in_zone_from()
Date: Mon, 18 Aug 2025 09:46:15 +0300
Message-ID: <20250818064615.505641-5-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818064615.505641-1-rppt@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

for_each_free_mem_pfn_range_in_zone_from() and its "backend" implementation
__next_mem_pfn_range_in_zone() were only used by deferred initialization of
the memory map.

Remove them as they are not used anymore.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 .clang-format            |  1 -
 include/linux/memblock.h | 22 --------------
 mm/memblock.c            | 64 ----------------------------------------
 3 files changed, 87 deletions(-)

diff --git a/.clang-format b/.clang-format
index 48405c54ef27..f371a13b4d19 100644
--- a/.clang-format
+++ b/.clang-format
@@ -294,7 +294,6 @@ ForEachMacros:
   - 'for_each_fib6_node_rt_rcu'
   - 'for_each_fib6_walker_rt'
   - 'for_each_file_lock'
-  - 'for_each_free_mem_pfn_range_in_zone_from'
   - 'for_each_free_mem_range'
   - 'for_each_free_mem_range_reverse'
   - 'for_each_func_rsrc'
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b96746376e17..20b61e910f4d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -323,28 +323,6 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
-				  unsigned long *out_spfn,
-				  unsigned long *out_epfn);
-
-/**
- * for_each_free_mem_pfn_range_in_zone_from - iterate through zone specific
- * free memblock areas from a given point
- * @i: u64 used as loop variable
- * @zone: zone in which all of the memory blocks reside
- * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
- * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
- *
- * Walks over free (memory && !reserved) areas of memblock in a specific
- * zone, continuing from current position. Available as soon as memblock is
- * initialized.
- */
-#define for_each_free_mem_pfn_range_in_zone_from(i, zone, p_start, p_end) \
-	for (; i != U64_MAX;					  \
-	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
-
-#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /**
  * for_each_free_mem_range - iterate through free memblock areas
diff --git a/mm/memblock.c b/mm/memblock.c
index 154f1d73b61f..337c025109fa 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1438,70 +1438,6 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	return 0;
 }
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-/**
- * __next_mem_pfn_range_in_zone - iterator for for_each_*_range_in_zone()
- *
- * @idx: pointer to u64 loop variable
- * @zone: zone in which all of the memory blocks reside
- * @out_spfn: ptr to ulong for start pfn of the range, can be %NULL
- * @out_epfn: ptr to ulong for end pfn of the range, can be %NULL
- *
- * This function is meant to be a zone/pfn specific wrapper for the
- * for_each_mem_range type iterators. Specifically they are used in the
- * deferred memory init routines and as such we were duplicating much of
- * this logic throughout the code. So instead of having it in multiple
- * locations it seemed like it would make more sense to centralize this to
- * one new iterator that does everything they need.
- */
-void __init_memblock
-__next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
-			     unsigned long *out_spfn, unsigned long *out_epfn)
-{
-	int zone_nid = zone_to_nid(zone);
-	phys_addr_t spa, epa;
-
-	__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
-			 &memblock.memory, &memblock.reserved,
-			 &spa, &epa, NULL);
-
-	while (*idx != U64_MAX) {
-		unsigned long epfn = PFN_DOWN(epa);
-		unsigned long spfn = PFN_UP(spa);
-
-		/*
-		 * Verify the end is at least past the start of the zone and
-		 * that we have at least one PFN to initialize.
-		 */
-		if (zone->zone_start_pfn < epfn && spfn < epfn) {
-			/* if we went too far just stop searching */
-			if (zone_end_pfn(zone) <= spfn) {
-				*idx = U64_MAX;
-				break;
-			}
-
-			if (out_spfn)
-				*out_spfn = max(zone->zone_start_pfn, spfn);
-			if (out_epfn)
-				*out_epfn = min(zone_end_pfn(zone), epfn);
-
-			return;
-		}
-
-		__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
-				 &memblock.memory, &memblock.reserved,
-				 &spa, &epa, NULL);
-	}
-
-	/* signal end of iteration */
-	if (out_spfn)
-		*out_spfn = ULONG_MAX;
-	if (out_epfn)
-		*out_epfn = 0;
-}
-
-#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
-
 /**
  * memblock_alloc_range_nid - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
-- 
2.50.1


