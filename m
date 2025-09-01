Return-Path: <linux-kernel+bounces-794079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6AB3DC92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2879189D84A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4072FD1BB;
	Mon,  1 Sep 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJhi5ygu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E642FD1BA;
	Mon,  1 Sep 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715686; cv=none; b=e+bivPhDOEWcaP1/NvYd4w98ntVRcx7OfcNafdsoP3hcsnKx3anY42OGEn06o3taD27V0t4ah5HtzI2DrH0sfM2YOZB1pcC8TolsG69g6BMSJDB97niiS/FFArMe/+OVkQbLfb7h3vP8QhNJI19RNrSitOJv0q+fQphgNufJImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715686; c=relaxed/simple;
	bh=zkkspZlHcKC4C7aIeuCgP1WZ3hWEhniSwzjVItRMrh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKlrqtp4rXYoNna5v/TnAgHlj24F5hUAYHEKFKhTdU0StJVtcjE/A4UL1xQSO7FHMTMT9Fmc5cruu4zuhj2CK1srR1iy0GsanPKO5bPaSkVSkq/AKxkWlMY2n8RUfPrqkFv0BoGm2jSKY+dV9HWbSG/Y/VrYKbEE6GXEbSOgHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJhi5ygu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39ABC4CEF4;
	Mon,  1 Sep 2025 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756715686;
	bh=zkkspZlHcKC4C7aIeuCgP1WZ3hWEhniSwzjVItRMrh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJhi5yguJHsnSZp7RF3kwwUDCXuzjvFgxpVADQAv5/mix6G3N9uE1k04Qf/aoEHWV
	 rWchSAh71hq7+Z5BQmOd6Yda71T9HGIoo902H0K1wDX6Ia5NkN4BesDI/jrP7VoSDg
	 R/vs//u5RpXX1GmZsYiKSyJII+E7xAqHWaiDRUEzWUyE8icEzuecQAzhMk360tEROs
	 z4vFOokX3rDir5mkAhQD/XXcZ1mn1uVdVVsbmxmMdWWWpxLEfnZ4t7ST7oUcZlM50r
	 Hk+c1z0OgS0NivzwoZGwUVMliKnisZAb/zcaO3lNOO09SL0rvMFmPOWM2XPeMBJSYU
	 U8M2ymxeU7Mkg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 4/4] memblock: drop for_each_free_mem_pfn_range_in_zone_from()
Date: Mon,  1 Sep 2025 11:34:23 +0300
Message-ID: <20250901083423.3061349-5-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901083423.3061349-1-rppt@kernel.org>
References: <20250901083423.3061349-1-rppt@kernel.org>
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

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Link: https://lore.kernel.org/r/20250818064615.505641-5-rppt@kernel.org
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
index fcda8481de9a..221118b5a16e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -324,28 +324,6 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
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
index 117d963e677c..120a501a887a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1445,70 +1445,6 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
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


