Return-Path: <linux-kernel+bounces-794055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62632B3DC3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5CB18984A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB72F1FCC;
	Mon,  1 Sep 2025 08:21:51 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65042F0C41
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714910; cv=none; b=LgWEcjAtQjM2SYdLwuL3QxuAwI6suijQ4sxp+qXNHEtNMW4mcMpOpmabAbcODk0b+FXIihTnP80pH1JR4+1hMOAS5/WrOT7SNnNBKs93XYOccngX3SfMl/okuAxeIH4pVZHKJQthGM337Rmyh4xNxJrCpe7CDb0aGFl9dEhqjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714910; c=relaxed/simple;
	bh=CZOS5QghR7MNWOh6P8RwRJdeHu9mu31HNR7Pe+f02Cw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+zYoFDr5hSYIjE16G+FgKSEEBmRAqjS3PXunygyah1GeXiQ+AFj2sUfwarzYKegP0WjgB1sBdYxoMdR753H9gIOR3YTC8GW1XLDJqoV38J0h+gCsWG2a6ccUXeUvd5mpPqGnv5IhP2JadWS6HROdwHkPxCEVQE5kfNMzeiqdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <giorgitchankvetadze1997@gmail.com>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v4] mm/hugetlb: retry to allocate for early boot hugepage allocation
Date: Mon, 1 Sep 2025 16:20:52 +0800
Message-ID: <20250901082052.3247-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
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
 Diff with v3: rewrite comment
 Diff with v2: auto retry mechanism
 Diff with v1: add log if two-phase hugepage allocation is triggered
 		add the knod to control split ratio


 mm/hugetlb.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b..af7c36f 100644
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
@@ -3616,10 +3615,29 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
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
+		 * Retry only if the vmemmap optimization might have been able to free
+		 * some memory back to the system.
+		 */
+		if (!hugetlb_vmemmap_optimizable(h))
+			break;
+
+		/* Continue if progress was made in last iteration */
+	} while (remaining != (h->max_huge_pages - h->nr_huge_pages));
+
 	jiffies_end = jiffies;
 
 	pr_info("HugeTLB: allocation took %dms with hugepage_allocation_threads=%ld\n",
-- 
2.9.4


