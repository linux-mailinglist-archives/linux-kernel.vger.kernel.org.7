Return-Path: <linux-kernel+bounces-897057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB4C51E68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C154F425739
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CA30E0D0;
	Wed, 12 Nov 2025 11:08:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8AE30B51D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945705; cv=none; b=aLvz5B6b2StkVfNCDbkbNKWfCOZ296h4WpwL3ju38j15D1ZkEkHhEv1dZbpUClFWz0O6khpM1nyxF0brzKQpDP53gzP4d3ZD358uVgB8M67UNtHvh81HBpvc+EebdlR0x1obke3Om2DEHggFP/qaLJ2XvVWFJCjiC79AuUn5InY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945705; c=relaxed/simple;
	bh=tvUZ1ITVHFIV2GPwT0pQJ6YP+HUC7Ddooa/+p5Gy+pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6yjOMN9pzPGtelsprK7KeTMq7BIhMs2kJ9yJ684LaLwH1jaVrj2LjUZ7yBiP+sT5Nt5aca6T2+hpXch/sp+Oh1LTgb1Yoq/HCeIMYPHehdtmXcZrPA26HPki+M2V92/Ah5TfKWuHGLTBdOfYoIs7rpFGLGHdjejyXAQYHsFaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B70531595;
	Wed, 12 Nov 2025 03:08:15 -0800 (PST)
Received: from MacBook-Pro.blr.arm.com.com (unknown [10.164.18.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58F5D3F66E;
	Wed, 12 Nov 2025 03:08:18 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	shijie@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	npiggin@gmail.com,
	willy@infradead.org,
	david@kernel.org,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH 1/2] mm/vmalloc: Do not align size to huge size
Date: Wed, 12 Nov 2025 16:38:06 +0530
Message-Id: <20251112110807.69958-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251112110807.69958-1-dev.jain@arm.com>
References: <20251112110807.69958-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmalloc() consists of the following:

(1) find empty space in the vmalloc space -> (2) get physical pages from
the buddy system -> (3) map the pages into the pagetable.

It turns out that the cost of (1) and (3) is pretty insignificant. Hence,
the cost of vmalloc becomes highly sensitive to physical memory allocation
time.

Currently, if we decide to use huge mappings, apart from aligning the start
of the target vm_struct region to the huge-alignment, we also align the
size. This does not seem to produce any benefit (apart from simplification
of the code), and there is a clear disadvantage - as mentioned above, the
main cost of vmalloc comes from its interaction with the buddy system, and
thus requesting more memory than was requested by the caller is suboptimal
and unnecessary.

This change is also motivated due to the next patch ("arm64/mm: Enable
vmalloc-huge by default"). Suppose that some user of vmalloc maps 17 pages,
uses that mapping for an extremely short time, and vfree's it. That patch,
without this patch, on arm64 will ultimately map 16 * 2 = 32 pages in a
contiguous way. Since the mapping is used for a very short time, it is
likely that the extra cost of mapping 15 pages defeats any benefit from
reduced TLB pressure, and regresses that code path. 

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/vmalloc.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..ddd9294a4634 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -647,7 +647,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
+	unsigned int i, step, nr = (end - addr) >> PAGE_SHIFT;
 
 	WARN_ON(page_shift < PAGE_SHIFT);
 
@@ -655,7 +655,8 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 			page_shift == PAGE_SHIFT)
 		return vmap_small_pages_range_noflush(addr, end, prot, pages);
 
-	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
+	step = 1U << (page_shift - PAGE_SHIFT);
+	for (i = 0; i < ALIGN_DOWN(nr, step); i += step) {
 		int err;
 
 		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
@@ -666,8 +667,9 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 		addr += 1UL << page_shift;
 	}
-
-	return 0;
+	if (IS_ALIGNED(nr, step))
+		return 0;
+	return vmap_small_pages_range_noflush(addr, end, prot, pages + i);
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
@@ -3171,7 +3173,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 	unsigned long requested_size = size;
 
 	BUG_ON(in_interrupt());
-	size = ALIGN(size, 1ul << shift);
+	size = PAGE_ALIGN(size);
 	if (unlikely(!size))
 		return NULL;
 
@@ -3327,7 +3329,7 @@ static void vm_reset_perms(struct vm_struct *area)
 	 * Find the start and end range of the direct mappings to make sure that
 	 * the vm_unmap_aliases() flush includes the direct map.
 	 */
-	for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+	for (i = 0; i < ALIGN_DOWN(area->nr_pages, 1U << page_order); i += (1U << page_order)) {
 		unsigned long addr = (unsigned long)page_address(area->pages[i]);
 
 		if (addr) {
@@ -3339,6 +3341,18 @@ static void vm_reset_perms(struct vm_struct *area)
 			flush_dmap = 1;
 		}
 	}
+	for (; i < area->nr_pages; ++i) {
+		unsigned long addr = (unsigned long)page_address(area->pages[i]);
+
+		if (addr) {
+			unsigned long page_size;
+
+			page_size = PAGE_SIZE;
+			start = min(addr, start);
+			end = max(addr + page_size, end);
+			flush_dmap = 1;
+		}
+	}
 
 	/*
 	 * Set direct map to something invalid so that it won't be cached if
@@ -3602,6 +3616,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
+page_map:
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -3633,13 +3648,18 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * If zero or pages were obtained partly,
 			 * fallback to a single page allocator.
 			 */
-			if (nr != nr_pages_request)
+			if (nr != nr_pages_request) {
+				order = 0;
 				break;
+			}
 		}
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
+		if (nr_pages - nr_allocated < (1UL << order))
+			goto page_map;
+
 		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
 			break;
 
@@ -5024,7 +5044,9 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v,
 
 	memset(counters, 0, nr_node_ids * sizeof(unsigned int));
 
-	for (nr = 0; nr < v->nr_pages; nr += step)
+	for (nr = 0; nr < ALIGN_DOWN(v->nr_pages, step); nr += step)
+		counters[page_to_nid(v->pages[nr])] += step;
+	for (; nr < v->nr_pages; ++nr)
 		counters[page_to_nid(v->pages[nr])] += step;
 	for_each_node_state(nr, N_HIGH_MEMORY)
 		if (counters[nr])
-- 
2.30.2


