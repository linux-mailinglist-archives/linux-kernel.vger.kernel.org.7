Return-Path: <linux-kernel+bounces-817707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4DB58588
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1477F2085DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD091298CB2;
	Mon, 15 Sep 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xL1W9xiT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4328751F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965954; cv=none; b=HxO5sZjMqbNC9xRQx3sooE6uT2fK7hC/aHRdKIXwftrZqd/ozHA7REcvRoym6bfPx4Wlj5V2Lvm1VA8wgUPfbfD81A8AwBVUq7vepdllg7OsRErET1Wajh+qCKtDH4ez2LM/gpEXo4ZaiqEJOmanVTSRJ6JF7v/UcQc6D56CKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965954; c=relaxed/simple;
	bh=E/S4wLBAzx3NQ/Hxx3Nf5H4FA79Ki+KpoQsmHrveUyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUyVuY+aI4w6eelY8nNo5P4mM5Zh8S+jE5CWEbBGfeya3vHwwhmqxfCDTfg3EfNWpf6mtz2jiPDCp5OKJgCGIPlvM2o+3IZa6bFxh4rmbthoX69rwAvL0naSprkPRkt3Dl+F7/wIY7+OOj840T+NjiPCTgwen0enZZ92kCWQIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xL1W9xiT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244582bc5e4so55267475ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965952; x=1758570752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DjbF4KpmP4NywIoDsroRavthjlO6MqxRwXYsW+YSfA=;
        b=xL1W9xiTW7CB5hNfl9ll2/sM1zVleuI4v4W7Ih+Q5FPPwjGM+p9jK+VRbyz5u8UKkM
         2NgDQPMSJS4QFrUkQmggsNOHVogQgSYiSjXq/BO/di5jdvLYolOSTK80DVpp9xwTQ3qd
         miyqeBPB9gnU6iAkOnx/96s/dLJpKG0Ny2GAT97eNrasBp1Z2S59jwmcGHDzllaascqH
         6Qz+M5cqI6ZnTlGks2u6LeobsWAyk3FMW1a/XpZSPP2BYEUW5Nnim4Z+FSF4GHNNCDRS
         ZYl3BmmsZWtfsIbDDLlmMx2nJQ4mUG5Jj6eEnc9T+cejnzIqNmGY3e/1QUs/9iVEEDTs
         tcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965952; x=1758570752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DjbF4KpmP4NywIoDsroRavthjlO6MqxRwXYsW+YSfA=;
        b=X8711CGpUbkVKDxkNJ73SUrDhg1XkyxWlbkGiN7VKkeGUJFsPtA+14Pt+3MlbbckS5
         Rucy++eIum4vROsYtk/2+sr5V7Se86c0qPcJ7Nb3DOS7SdF3L89ODCZfOkbOnsi9LSUF
         EerXGg407pLWBB47yNzXqZex/kW6moO3MkSiGEDL4xQLu+q7z2TuA5SEKrd+HjcovEU0
         uPxtlNwjz7bOGyJMmGzYQELkXWqtkWD6hMoeF/Xo6yjHCWpOBkMVNJBJI4p0u7B/LXxg
         rphPN+Iia/bZhxVkI4PzGdTYhfCbv3q6wns5Bxt8VLtGbxFXaRobKqEstoFoHvmP58mP
         ECTg==
X-Forwarded-Encrypted: i=1; AJvYcCVRe+V26gMkn/rgN5L0PVuJ75MtUGzJRvah1u52Y8lFqp+SWWQGItLvx3SrPJrjqIaS/ywaqEeVF1xYaYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVJAT3/eGULCfDwd6q3Uwh7KrcVLkzWZ2g3Y3mym+ULUSsa4C
	0TyYj3CZmJBmMntYwJqY/RDhHZhbB2nQDM4tL9RjEan7sjb+Tgqj2M7DjZc4hBqM6Ud+UI1ssg=
	=
X-Google-Smtp-Source: AGHT+IF8O+VLtGgAGnPoMFPwPtML+wPGmo10/Gb9GlzY+4KfLm4QkQw7DA2FoDyUrRDSv5yLbXqWtzOk
X-Received: from plbiz4.prod.google.com ([2002:a17:902:ef84:b0:24c:863e:86a3])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dacd:b0:25d:8043:781d
 with SMTP id d9443c01a7336-25d804381bcmr162786945ad.21.1757965952236; Mon, 15
 Sep 2025 12:52:32 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:50 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-10-fvdl@google.com>
Subject: [RFC PATCH 09/12] mm/cma: introduce CMA balancing
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

A longstanding problem with having a lot of CMA pageblocks in
the system (through hugetlb_cma), is that this limits the amount
of memory that the kernel can use for its allocations. Kernel
allocations are unmovable and can not come from CMA pageblocks.

This can lead to situations where kernel allocations cause OOMs,
when in fact there might still enough memory available. There
isn't much that can be done if the non-CMA part of memory is
already taken up by unmovable allocations. That scenario can
be considered a misconfigured system. But if there are movable
allocations in the non-CMA areas, they are unnecessarily
taking away space from the kernel.

Currently, the page allocator tries to avoid this scenario
by allocating from CMA first if more than half of free pages
in a zone come from CMA. But that's not a guarantee.

For example, take the case where a lot of memory is being
taken up by 1G hugetlb pages, allocated from hugetlb_cma, and
that the hugetlb_cma area has been fully used by hugetlbfs.
This means that new movable allocations will land in the
non-CMA part of memory, and that the kernel may come under
memory pressure. If those allocations are long-lasting,
freeing up hugetlb pages will not reduce that pressure,
since the kernel can't use the new space, and the long-lasting
allocations residing in non-CMA memory will stay put.

To counter this issue, introduce interfaces to explicitly
move pages in to CMA areas. The number of pages moved
depends on cma_first_limit. It will use that percentage to
calculate the target number of pages that should be moved.

A later commit will call one of these interfaces to move pages
to CMA if needed, after CMA-allocated hugetlb pages have been
freed.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/migrate_mode.h   |   1 +
 include/trace/events/migrate.h |   3 +-
 mm/compaction.c                | 168 +++++++++++++++++++++++++++++++++
 mm/internal.h                  |   4 +
 4 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index 265c4328b36a..3e235499cd73 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -25,6 +25,7 @@ enum migrate_reason {
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
 	MR_DAMON,
+	MR_CMA_BALANCE,
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index cd01dd7b3640..53d669ee26be 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -23,7 +23,8 @@
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
 	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
 	EM( MR_DEMOTION,	"demotion")			\
-	EMe(MR_DAMON,		"damon")
+	EM( MR_DAMON,		"damon")			\
+	EMe(MR_CMA_BALANCE,	"cma_balance")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/compaction.c b/mm/compaction.c
index 2e6c30f50b89..3200119b8baf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,6 +24,7 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/cma.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -2512,6 +2513,173 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 	return COMPACT_CONTINUE;
 }
 
+#ifdef CONFIG_CMA
+
+static void
+isolate_free_cma_pages(struct compact_control *cc)
+{
+	unsigned long end_pfn, pfn, next_pfn, start_pfn;
+	int i;
+
+	i = -1;
+	end_pfn = 0;
+
+	next_pfn = end_pfn = cc->free_pfn;
+	start_pfn = 0;
+	while (cc->nr_freepages < cc->nr_migratepages) {
+		if (!cma_next_balance_pagerange(cc->zone, cc->cma, &i,
+						&start_pfn, &end_pfn))
+			break;
+		for (pfn = start_pfn; pfn < end_pfn; pfn = next_pfn) {
+			next_pfn = pfn + pageblock_nr_pages;
+			isolate_freepages_block(cc, &pfn, next_pfn,
+					cc->freepages, 1, false);
+			if (cc->nr_freepages >= cc->nr_migratepages)
+				break;
+		}
+	}
+	cc->free_pfn = next_pfn;
+}
+
+static void balance_zone_cma(struct zone *zone, struct cma *cma)
+{
+	struct compact_control cc = {
+		.zone = zone,
+		.cma = cma,
+		.isolate_freepages = isolate_free_cma_pages,
+		.nr_migratepages = 0,
+		.nr_freepages = 0,
+		.free_pfn = 0,
+		.migrate_pfn = 0,
+		.mode = MIGRATE_SYNC,
+		.ignore_skip_hint = true,
+		.no_set_skip_hint = true,
+		.gfp_mask = GFP_KERNEL,
+		.migrate_large = true,
+		.order = -1,
+	};
+	unsigned long nr_pages;
+	int order;
+	unsigned long free_cma, free_pages, allocated, allocated_noncma;
+	unsigned long target_free_cma;
+	int rindex, ret = 0, n;
+	unsigned long start_pfn, end_pfn, pfn, next_pfn;
+	long nr_migrated;
+
+	if (zone_idx(zone) == ZONE_MOVABLE)
+		return;
+
+	if (!cma && !cma_numranges())
+		return;
+
+	/*
+	 * Try to move allocated pages from non-CMA pageblocks
+	 * to CMA pageblocks (possibly in a specific CMA area), to
+	 * give the kernel more space for unmovable allocations.
+	 *
+	 * cma_first_limit, the percentage of free pages that are
+	 * MIGRATE_CMA, is used to calculcate the target number.
+	 */
+	free_pages = zone_page_state(zone, NR_FREE_PAGES);
+	free_cma = zone_page_state(zone, NR_FREE_CMA_PAGES);
+	if (!free_cma)
+		return;
+
+	target_free_cma = (cma_first_limit * free_pages) / 100;
+	/*
+	 * If we're already below the target, nothing to do.
+	 */
+	if (free_cma <= target_free_cma)
+		return;
+
+	/*
+	 * To try to avoid scanning too much non-CMA memory,
+	 * set the upper bound of pages we want to migrate
+	 * to the minimum of:
+	 * 1. The number of MIGRATE_CMA pages we want to use.
+	 * 2. The space available in the targeted CMA area (if any).
+	 * 3. The number of used non-CMA pages.
+	 *
+	 * This will still likely cause the scanning of more
+	 * pageblocks than is strictly needed, but it's the best
+	 * that can be done without explicit tracking of the number
+	 * of movable allocations in non-CMA memory.
+	 */
+	allocated = zone_managed_pages(zone) - free_pages;
+	allocated_noncma = allocated - (zone_cma_pages(zone) - free_cma);
+
+	nr_pages = free_cma - target_free_cma;
+	if (cma)
+		nr_pages = min(nr_pages, cma_get_available(cma));
+	nr_pages = min(allocated_noncma, nr_pages);
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
+		INIT_LIST_HEAD(&cc.freepages[order]);
+	INIT_LIST_HEAD(&cc.migratepages);
+
+	rindex = -1;
+	start_pfn = next_pfn = end_pfn = 0;
+	nr_migrated = 0;
+	while (nr_pages > 0) {
+		ret = 0;
+		if (!cma_next_noncma_pagerange(cc.zone, &rindex,
+					      &start_pfn, &end_pfn))
+			break;
+
+		for (pfn = start_pfn; pfn < end_pfn; pfn = next_pfn) {
+			next_pfn = pfn + pageblock_nr_pages;
+			cc.nr_migratepages = 0;
+
+			if (!pageblock_pfn_to_page(pfn, next_pfn, zone))
+				continue;
+
+			ret = isolate_migratepages_block(&cc, pfn, next_pfn,
+					ISOLATE_UNEVICTABLE);
+			if (ret)
+				continue;
+			ret = migrate_pages(&cc.migratepages, compaction_alloc,
+					    compaction_free, (unsigned long)&cc,
+					    cc.mode, MR_CMA_BALANCE, &n);
+			if (ret)
+				putback_movable_pages(&cc.migratepages);
+			nr_migrated += n;
+			if (nr_migrated >= nr_pages)
+				break;
+		}
+
+		nr_pages -= min_t(unsigned long, nr_migrated, nr_pages);
+	}
+
+	if (cc.nr_freepages > 0)
+		release_free_list(cc.freepages);
+}
+
+void balance_node_cma(int nid, struct cma *cma)
+{
+	pg_data_t *pgdat;
+	int zoneid;
+	struct zone *zone;
+
+	if (!cma && !cma_numranges())
+		return;
+
+	if (nid >= MAX_NUMNODES || !node_online(nid))
+		return;
+
+	pgdat = NODE_DATA(nid);
+
+	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
+
+		zone = &pgdat->node_zones[zoneid];
+		if (!populated_zone(zone))
+			continue;
+
+		balance_zone_cma(zone, cma);
+	}
+}
+
+#endif /* CONFIG_CMA */
+
 static enum compact_result
 compact_zone(struct compact_control *cc, struct capture_control *capc)
 {
diff --git a/mm/internal.h b/mm/internal.h
index ffcb3aec05ed..7dcaf7214683 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -857,6 +857,8 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
+struct cma;
+
 /*
  * in mm/compaction.c
  */
@@ -887,6 +889,7 @@ struct compact_control {
 	unsigned long migrate_pfn;
 	unsigned long fast_start_pfn;	/* a pfn to start linear scan from */
 	struct zone *zone;
+	struct cma *cma;		/* if moving to a specific CMA area */
 	unsigned long total_migrate_scanned;
 	unsigned long total_free_scanned;
 	unsigned short fast_search_fail;/* failures to use free list searches */
@@ -938,6 +941,7 @@ struct cma;
 #ifdef CONFIG_CMA
 void *cma_reserve_early(struct cma *cma, unsigned long size);
 void init_cma_pageblock(struct page *page);
+void balance_node_cma(int nid, struct cma *cma);
 #else
 static inline void *cma_reserve_early(struct cma *cma, unsigned long size)
 {
-- 
2.51.0.384.g4c02a37b29-goog


