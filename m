Return-Path: <linux-kernel+bounces-786452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D42B359FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275561B28107
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ED829E0E9;
	Tue, 26 Aug 2025 10:20:08 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D529992E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203607; cv=none; b=kEO/4ThEaNlWE0aOJeFU/Q7oi8zkI841DQUZVP+T8ElVuijDIfXtCUUBcfj3HOmc1DMLV714Qt04wLmS8bOWuRNtja9nhN/DkK7Fsoztf5B3eT15VFvhzkzwkTUqASsxLArdI8R8bG4yrQJGvd9OyvXfLF83cWYB0v8ltP3cOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203607; c=relaxed/simple;
	bh=oAkXsdiMFng0cw165O8QJJiDhjH0zGQicoIoHtBLd/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tHsUqAZWcPkDYkx6+jQXoRwbLlPlB0pBEMYYeTjnNqlF/Z9tIrOQRpnim1+a3iMb6fspCCXbw0GkhLJ6XS02HnVv5RJ2m6f6cCLuN5h47zNQmGMZfEUKOZJTu6k3dDxrBrirpDZNsoJl59pFfBTpCHVtudJVJfhEZRfRoU3ZcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <giorgitchankvetadze1997@gmail.com>
CC: Li RongQing <lirongqing@baidu.com>, Wenjie Xu <xuwenjie04@baidu.com>
Subject: [PATCH] mm/hugetlb: two-phase hugepage allocation when reservation is high
Date: Tue, 26 Aug 2025 18:18:40 +0800
Message-ID: <20250826101840.3954-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

When the total reserved hugepages account for 95% or more of system RAM
(common in cloud computing on physical servers), allocating them all in one
go can lead to OOM or fail to allocate huge page during early boot.

The commit 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages") can
worsen peak memory pressure under these conditions by deferring page frees,
exacerbating allocation failures. To prevent this, split the allocation
into two equal batches whenever
	huge_reserved_pages >= totalram_pages() * 90 / 100.

This change does not alter the number of padata worker threads per batch;
it merely introduces a second round of padata_do_multithreaded(). The added
overhead of restarting the worker threads is minimal.

The result on a 256G memory machine as below:
Before:
[    4.350400] HugeTLB: allocation took 706ms with hugepage_allocation_threads=32
[    4.351577] HugeTLB: allocating 128512 of page size 2.00 MiB failed.  Only allocated 128074 hugepages.
[    4.355608] HugeTLB: registered 2.00 MiB page size, pre-allocated 128074 pages
After:
[    3.561088] HugeTLB: two-phase hugepage allocation is used
[    4.280300] HugeTLB: allocation took 712ms with hugepage_allocation_threads=32
[    4.281054] HugeTLB: registered 2.00 MiB page size, pre-allocated 128512 pages

Fixes: 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages")

Co-developed-by: Wenjie Xu <xuwenjie04@baidu.com>
Signed-off-by: Wenjie Xu <xuwenjie04@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: add log if two-phase hugepage allocation is triggered
              add the knod to control split ratio

 Documentation/admin-guide/mm/hugetlbpage.rst | 12 +++++++++
 mm/hugetlb.c                                 | 39 ++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 67a9419..5cfb6e3 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -156,6 +156,18 @@ hugepage_alloc_threads
 		hugepage_alloc_threads=8
 
 	Note that this parameter only applies to non-gigantic huge pages.
+
+hugepage_split_ratio
+    Controls the threshold for two-phase hugepage allocation.
+    When the total number of reserved hugepages (huge_reserved_pages) exceeds
+    (totalram_pages * hugepage_split_ratio / 100), the hugepage allocation process
+    during boot is split into two batches.
+
+    Default value is 90, meaning the two-phase allocation is triggered when
+    reserved hugepages exceed 90% of total system RAM.
+    The value can be adjusted via the kernel command line parameter
+    "hugepage_split_ratio=". Valid range is 1 to 99.
+
 default_hugepagesz
 	Specify the default huge page size.  This parameter can
 	only be specified once on the command line.  default_hugepagesz can
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b..576f402 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -88,6 +88,7 @@ static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
 static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 static unsigned long hugepage_allocation_threads __initdata;
+static int hugepage_split_ratio __initdata = 90;
 
 static char hstate_cmdline_buf[COMMAND_LINE_SIZE] __initdata;
 static int hstate_cmdline_index __initdata;
@@ -3587,12 +3588,24 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
+	unsigned long huge_reserved_pages = h->max_huge_pages << h->order;
+	unsigned long huge_pages, remaining, total_pages;
 	unsigned long jiffies_start;
 	unsigned long jiffies_end;
 
+	total_pages = totalram_pages() * hugepage_split_ratio / 100;
+	if (huge_reserved_pages > total_pages) {
+		huge_pages =  h->max_huge_pages * hugepage_split_ratio / 100;
+		remaining = h->max_huge_pages - huge_pages;
+		pr_info("HugeTLB: two-phase hugepage allocation is used\n");
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
@@ -3616,10 +3629,16 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
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
@@ -5061,6 +5080,22 @@ static int __init hugepage_alloc_threads_setup(char *s)
 }
 __setup("hugepage_alloc_threads=", hugepage_alloc_threads_setup);
 
+static int __init hugepage_split_ratio_setup(char *s)
+{
+	int ratio;
+
+	if (kstrtoint(s, 0, &ratio) != 0)
+		return 1;
+
+	if (ratio > 99 || ratio < 0)
+		return 1;
+
+	hugepage_split_ratio = ratio;
+
+	return 1;
+}
+__setup("hugepage_split_ratio=", hugepage_split_ratio_setup);
+
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
-- 
2.9.4


