Return-Path: <linux-kernel+bounces-798086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FCB41959
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3522189F689
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C302ECD23;
	Wed,  3 Sep 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VRr/TdD1"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F52EC56C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889680; cv=none; b=NL11PoMpA4TcLMeE7LI4pAqjYjWFhb0tAGYRLyBeByEe84eGfj6jUZSRA285c7diqESZj0oxtmcpeONj8XZnXXXMA5VhVRSV4rXYk2DqYpzk2vJdcg+mFSDq41OHPNbIUmJApBDmt02NP4mG6zGCxeebNPA+hNBcULm+48iyiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889680; c=relaxed/simple;
	bh=R0L7+bMeiFKKhtssvrIFQxk8oslOIc2+e4coBDR1Yw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0YAORYv1xg4yBKkJ5AH8S9cF2AXF+F4bHjBCTqFsbDmdcPnUilspW4Wi13cvMjgv19BuUrsdZXR1QLi/jyQ9CkO47hKIPLtNW6K/scPraQk0EX6tXLUYRtNazDy6gGXfZiNsvUULZsMq0Gn9VYSPcc85BGrOPK3/SEwS+ouRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VRr/TdD1; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756889669; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gEHG9nUxE9p+ugJXn8Eg6VJXyeh53liew47f+ZzW61M=;
	b=VRr/TdD10tkspcHeBZwlXYZGZtcJ7r/beNUy8MclLMf2/fQUdRR5WIJJvk2K5GtiCJ/I9hcS2vGFHlnCeKLgMQW5yLvR45su5ZJh/aLigiR9fuvQUf/iX9/AGZhZURCKe57YncLhURdCZrIHPFUPKv4xAmD2b54rQFmJ5CI1/jg=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnBDMmT_1756889666 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 16:54:27 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shmem: fix the strategy for the tmpfs 'huge=' options
Date: Wed,  3 Sep 2025 16:54:24 +0800
Message-ID: <10e7ac6cebe6535c137c064d5c5a235643eebb4a.1756888965.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
we have extended tmpfs to allow any sized large folios, rather than just
PMD-sized large folios.

The strategy discussed previously was:
"
Considering that tmpfs already has the 'huge=' option to control the
PMD-sized large folios allocation, we can extend the 'huge=' option to
allow any sized large folios.  The semantics of the 'huge=' mount option
are:

    huge=never: no any sized large folios
    huge=always: any sized large folios
    huge=within_size: like 'always' but respect the i_size
    huge=advise: like 'always' if requested with madvise()

Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
allocate the PMD-sized huge folios if huge=always/within_size/advise is
set.

Moreover, the 'deny' and 'force' testing options controlled by
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
semantics.  The 'deny' can disable any sized large folios for tmpfs, while
the 'force' can enable PMD sized large folios for tmpfs.
"

This means that when tmpfs is mounted with 'huge=always' or 'huge=within_size',
tmpfs will allow getting a highest order hint based on the size of write() and
fallocate() paths. It will then try each allowable large order, rather than
continually attempting to allocate PMD-sized large folios as before.

However, this might break some user scenarios for those who want to use
PMD-sized large folios, such as the i915 driver which did not supply a write
size hint when allocating shmem [1].

Moreover, Hugh also complained that this will cause a regression in userspace
with 'huge=always' or 'huge=within_size'.

So, let's revisit the strategy for tmpfs large page allocation. A simple fix
would be to always try PMD-sized large folios first, and if that fails, fall
back to smaller large folios. This approach differs from the strategy for
large folio allocation used by other file systems, however, tmpfs is somewhat
different from other file systems, as quoted from David's opinion:
"
There were opinions in the past that tmpfs should just behave like any other fs,
and I think that's what we tried to satisfy here: use the write size as an
indication.

I assume there will be workloads where either approach will be beneficial. I also
assume that workloads that use ordinary fs'es could benefit from the same strategy
(start with PMD), while others will clearly not.
"

[1] https://lore.kernel.org/lkml/0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com/
Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from RFC:
 - Update the commit message.
---
 Documentation/admin-guide/mm/transhuge.rst |  6 ++-
 mm/shmem.c                                 | 47 +++-------------------
 2 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index a16a04841b96..1654211cc6cf 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -419,6 +419,8 @@ option: ``huge=``. It can have following values:
 
 always
     Attempt to allocate huge pages every time we need a new page;
+    Always try PMD-sized huge pages first, and fall back to smaller-sized
+    huge pages if the PMD-sized huge page allocation fails;
 
 never
     Do not allocate huge pages. Note that ``madvise(..., MADV_COLLAPSE)``
@@ -426,7 +428,9 @@ never
     is specified everywhere;
 
 within_size
-    Only allocate huge page if it will be fully within i_size.
+    Only allocate huge page if it will be fully within i_size;
+    Always try PMD-sized huge pages first, and fall back to smaller-sized
+    huge pages if the PMD-sized huge page allocation fails;
     Also respect madvise() hints;
 
 advise
diff --git a/mm/shmem.c b/mm/shmem.c
index 640fecc42f60..85a40a5b3f2b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -573,42 +573,6 @@ static int shmem_confirm_swap(struct address_space *mapping, pgoff_t index,
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 static int tmpfs_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-/**
- * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
- * @mapping: Target address_space.
- * @index: The page index.
- * @write_end: end of a write, could extend inode size.
- *
- * This returns huge orders for folios (when supported) based on the file size
- * which the mapping currently allows at the given index. The index is relevant
- * due to alignment considerations the mapping might have. The returned order
- * may be less than the size passed.
- *
- * Return: The orders.
- */
-static inline unsigned int
-shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
-{
-	unsigned int order;
-	size_t size;
-
-	if (!mapping_large_folio_support(mapping) || !write_end)
-		return 0;
-
-	/* Calculate the write size based on the write_end */
-	size = write_end - (index << PAGE_SHIFT);
-	order = filemap_get_order(size);
-	if (!order)
-		return 0;
-
-	/* If we're not aligned, allocate a smaller folio */
-	if (index & ((1UL << order) - 1))
-		order = __ffs(index);
-
-	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
-	return order > 0 ? BIT(order + 1) - 1 : 0;
-}
-
 static unsigned int shmem_get_orders_within_size(struct inode *inode,
 		unsigned long within_size_orders, pgoff_t index,
 		loff_t write_end)
@@ -655,22 +619,21 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 	 * For tmpfs mmap()'s huge order, we still use PMD-sized order to
 	 * allocate huge pages due to lack of a write size hint.
 	 *
-	 * Otherwise, tmpfs will allow getting a highest order hint based on
-	 * the size of write and fallocate paths, then will try each allowable
-	 * huge orders.
+	 * For tmpfs with 'huge=always' or 'huge=within_size' mount option,
+	 * we will always try PMD-sized order first. If that failed, it will
+	 * fall back to small large folios.
 	 */
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
 		if (vma)
 			return maybe_pmd_order;
 
-		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
+		return THP_ORDERS_ALL_FILE_DEFAULT;
 	case SHMEM_HUGE_WITHIN_SIZE:
 		if (vma)
 			within_size_orders = maybe_pmd_order;
 		else
-			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
-								       index, write_end);
+			within_size_orders = THP_ORDERS_ALL_FILE_DEFAULT;
 
 		within_size_orders = shmem_get_orders_within_size(inode, within_size_orders,
 								  index, write_end);
-- 
2.43.7


