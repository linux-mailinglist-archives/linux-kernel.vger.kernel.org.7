Return-Path: <linux-kernel+bounces-791537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2644B3B837
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BDEA04506
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA823090C5;
	Fri, 29 Aug 2025 10:09:22 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27762877DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462161; cv=none; b=lpmA+KdT/zHsc2QSxl14Q/6F4suez7biUGIgXrFm8+dqbsZBzk9q2tqbHM5sLeMlD/qdBJMKGx4vXHydCjdm74Eyok7GUDQ3yjkC/eFMBbgLmOSgYwa+mCB2Pll1h33X77xNjjL2UQpqSF2QSEa3kx3rHvvY5cnT6TwM6pETlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462161; c=relaxed/simple;
	bh=LULWHCojxv+sHgqE8kViayclEvTMcl++589AVYPm3dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcNH+ekUquQqv5RYqYvpZMO/RATgy+3mLKtHVgH1/6uQ9GlJWSgPf+3P+DEFvUmIt3Pvga+eQ2eQdsr6yFw7Fztop3P6j4Vc1o/LSfxMjzDihqnACeX4WqXPMzq+RIFu0Wg+6u1waNkZ/tw0GiN7Htytszcj6/yUCTejZS5gV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <giorgitchankvetadze1997@gmail.com>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v3] mm/hugetlb: Retry to allocate for early boot hugepage allocation
Date: Fri, 29 Aug 2025 17:52:41 +0800
Message-ID: <20250829095241.2651-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

In cloud environments with massive hugepage reservations (95%+ of system
RAM), single-attempt allocation during early boot often fails due to
memory pressure.

Commit 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages") intensified
this by deferring page frees, increase peak memory usage during allocation.

Introduce a retry mechanism that leverages vmemmap optimization reclaim
(~1.6% memory) when available. Upon initial allocation failure, the system
retries until successful or no further progress is made, ensuring reliable
hugepage allocation while preserving batched vmemmap freeing benefits.

Testing on a 256G machine allocating 252G of hugepages:
Before: 128056/129024 hugepages allocated
After:  Successfully allocated all 129024 hugepages

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v2: auto retry mechanism
Diff with v1: add log if two-phase hugepage allocation is triggered
		add the knod to control split ratio

 mm/hugetlb.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b..18e54ea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3589,10 +3589,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 
 	unsigned long jiffies_start;
 	unsigned long jiffies_end;
+	unsigned long remaining;
 
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
-	job.start	= 0;
-	job.size	= h->max_huge_pages;
 
 	/*
 	 * job.max_threads is 25% of the available cpu threads by default.
@@ -3616,10 +3615,30 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 	}
 
 	job.max_threads	= hugepage_allocation_threads;
-	job.min_chunk	= h->max_huge_pages / hugepage_allocation_threads;
 
 	jiffies_start = jiffies;
-	padata_do_multithreaded(&job);
+	do {
+		remaining = h->max_huge_pages - h->nr_huge_pages;
+
+		job.start     = h->nr_huge_pages;
+		job.size      = remaining;
+		job.min_chunk = remaining / hugepage_allocation_threads;
+		padata_do_multithreaded(&job);
+
+		if (h->nr_huge_pages == h->max_huge_pages)
+			break;
+
+		/*
+		 * Retry allocation if vmemmap optimization is available, the
+		 * optimization frees ~1.6% of memory of hugepages, this reclaimed
+		 * memory enables additional hugepage allocations
+		 */
+		if (!hugetlb_vmemmap_optimizable(h))
+			break;
+
+	/* Continue if progress was made in last iteration */
+	} while (remaining != (h->max_huge_pages - h->nr_huge_pages));
+
 	jiffies_end = jiffies;
 
 	pr_info("HugeTLB: allocation took %dms with hugepage_allocation_threads=%ld\n",
-- 
2.9.4


