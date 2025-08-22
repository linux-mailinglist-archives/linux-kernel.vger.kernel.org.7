Return-Path: <linux-kernel+bounces-781759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D0B31651
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121375E43D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D802F656A;
	Fri, 22 Aug 2025 11:29:56 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB22D249A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862195; cv=none; b=saeomG34KLR79uS9aqYCBXV598JUoduMhbpZiNYbAmszFirZpi3Qvvr1lUz1EA0j9BC/S0CuVqedPqv/WEGzDGWAH693rwOnGdRfLy3Q0IklZfsET8AFYZI6QL9ACktTnkZCpeDSLpMwWO2d/PpLXnpXLgeoCAU7y39lqOxKDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862195; c=relaxed/simple;
	bh=CPZ0k7oMVXexbxeEs6Wmr89SnRH3G9ZYWsg8SGPYt1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCjMazNuc6fIRxSDAqJBd/0pnfQrR/d2DxzSyq+KFZ0ktyoKfXsLM0LHYZWnAccmWAbFLCnvOhHy9irQQU4OrQHwkEe72OtmoaqwDXphwr+ZVE6yUuSTirM8TWAhKE7jL6+rj6jecrRVQxzYkJyft0GA5zaoPVdkYIx3kHmgrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>, Wenjie Xu <xuwenjie04@baidu.com>
Subject: [PATCH] mm/hugetlb: two-phase hugepage allocation when reservation is high
Date: Fri, 22 Aug 2025 19:28:28 +0800
Message-ID: <20250822112828.2742-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

When the total reserved hugepages account for 95% or more of system RAM
(common in cloud computing on physical servers), allocating them all in one
go can lead to OOM or fail to allocating huge page during early boot.

The previous hugetlb vmemmap batching change (91f386bf0772) can worsen
peak memory pressure under these conditions by deferring page frees,
exacerbating allocation failures. To prevent this, split the allocation
into two equal batches whenever
	huge_reserved_pages >= totalram_pages() * 90 / 100.

This change does not alter the number of padata worker threads per batch;
it merely introduces a second round of padata_do_multithreaded(). The added
overhead of restarting the worker threads is minimal.

Before:
[    8.423187] HugeTLB: allocation took 1584ms with hugepage_allocation_threads=48
[    8.431189] HugeTLB: allocating 385920 of page size 2.00 MiB failed.  Only allocated 385296 hugepages.

After:
[    8.740201] HugeTLB: allocation took 1900ms with hugepage_allocation_threads=48
[    8.748266] HugeTLB: registered 2.00 MiB page size, pre-allocated 385920 pages

Fixes: 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages")

Co-developed-by: Wenjie Xu <xuwenjie04@baidu.com>
Signed-off-by: Wenjie Xu <xuwenjie04@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/hugetlb.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b..a86d3a0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3587,12 +3587,23 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
+	unsigned long huge_reserved_pages = h->max_huge_pages << h->order;
+	unsigned long huge_pages, remaining, total_pages;
 	unsigned long jiffies_start;
 	unsigned long jiffies_end;
 
+	total_pages = totalram_pages() * 90 / 100;
+	if (huge_reserved_pages > total_pages) {
+		huge_pages =  h->max_huge_pages * 90 / 100;
+		remaining = h->max_huge_pages - huge_pages;
+	} else {
+		huge_pages =  h->max_huge_pages;
+		remaining = 0;
+	}
+
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
 	job.start	= 0;
-	job.size	= h->max_huge_pages;
+	job.size	= huge_pages;
 
 	/*
 	 * job.max_threads is 25% of the available cpu threads by default.
@@ -3616,10 +3627,16 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 	}
 
 	job.max_threads	= hugepage_allocation_threads;
-	job.min_chunk	= h->max_huge_pages / hugepage_allocation_threads;
+	job.min_chunk	= huge_pages / hugepage_allocation_threads;
 
 	jiffies_start = jiffies;
 	padata_do_multithreaded(&job);
+	if (remaining) {
+		job.start   = huge_pages;
+		job.size    = remaining;
+		job.min_chunk   = remaining / hugepage_allocation_threads;
+		padata_do_multithreaded(&job);
+	}
 	jiffies_end = jiffies;
 
 	pr_info("HugeTLB: allocation took %dms with hugepage_allocation_threads=%ld\n",
-- 
2.9.4


