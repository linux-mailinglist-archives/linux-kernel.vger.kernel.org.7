Return-Path: <linux-kernel+bounces-656982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE2ABED59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983B31BA50A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5725D235043;
	Wed, 21 May 2025 07:56:09 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DD17BD3
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814169; cv=none; b=p8x0Lbz7KJuI+cQODg4Sh5CC56aKT2Aicpml4sB9si325ILxlw5bKLPrtfAaV2731MtLOXfqEaL0TrSx2f3gE8bMERkUVIwNjw//g4/9Ow0eTaE/IsdYFdhBv2JfqDC8SWgol7RKKho1jgD1/ul1mr2lPOyLDKEWPIx4/Y3EA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814169; c=relaxed/simple;
	bh=X7TivkcYcg/eD32G9v1sqNLtIi3aPrvIGSvY66BeYXI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C+y4tlVsQ9ZmWZq39jbBZKsdjIFhDHk4kvpAdVQjhQBftdsoL0pqll4eISpeKNy/Et5ldhC9MNrycwIZoWtfYmDo4jqYXXlFvqzgeL7C60LHFOhhv1oSiBm7SqbiBK57Jx/Rn2VNBuDFoCAgdq7wOJUicUWmGT/mSF6siF57WqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.52 with ESMTP; 21 May 2025 16:26:02 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.151 with ESMTP; 21 May 2025 16:26:02 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH v2] squashfs: Add optional full compressed block caching
Date: Wed, 21 May 2025 16:25:59 +0900
Message-Id: <20250521072559.2389-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The commit 93e72b3c612adcaca1 ("squashfs: migrate from ll_rw_block usage to
BIO") removed caching of compressed blocks in SquashFS, causing fio
performance regression in workloads with repeated file reads. Without
caching, every read triggers disk I/O, severely impacting performance in
tools like fio.

This patch introduces a new CONFIG_SQUASHFS_COMP_CACHE_FULL Kconfig option
to enable caching of all compressed blocks, restoring performance to
pre-BIO migration levels. When enabled, all pages in a BIO are cached in
the page cache, reducing disk I/O for repeated reads. The fio test results
with this patch confirm the performance restoration:

For example, fio tests (iodepth=1, numjobs=1,
ioengine=psync) show a notable performance restoration:

Disable CONFIG_SQUASHFS_COMP_CACHE_FULL:
  IOPS=815, BW=102MiB/s (107MB/s)(6113MiB/60001msec)
Enable CONFIG_SQUASHFS_COMP_CACHE_FULL:
  IOPS=2223, BW=278MiB/s (291MB/s)(16.3GiB/59999msec)

The trade-off is increased memory usage due to caching all compressed
blocks. The CONFIG_SQUASHFS_COMP_CACHE_FULL option allows users to enable
this feature selectively, balancing performance and memory usage for
workloads with frequent repeated reads.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 fs/squashfs/Kconfig | 21 +++++++++++++++++++++
 fs/squashfs/block.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 60fc98bdf421..7db4d5b869a2 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -149,6 +149,27 @@ config SQUASHFS_XATTR
 
 	  If unsure, say N.
 
+config SQUASHFS_COMP_CACHE_FULL
+	bool "Enable full caching of compressed blocks"
+	depends on SQUASHFS
+	default n
+	help
+	  This option enables caching of all compressed blocks, Without caching,
+	  repeated reads of the same files trigger excessive disk I/O, significantly
+	  reducinng performance in workloads like fio-based benchmarks.
+
+	  For example, fio tests (iodepth=1, numjobs=1, ioengine=psync) show:
+	   With caching: IOPS=2223, BW=278MiB/s (291MB/s)
+	   Without caching: IOPS=815, BW=102MiB/s (107MB/s)
+
+	  Enabling this option restores performance to pre-regression levels by
+	  caching all compressed blocks in the page cache, reducing disk I/O for
+	  repeated reads. However, this increases memory usage, which may be a
+	  concern in memory-constrained environments.
+
+	  Enable this option if your workload involves frequent repeated reads and
+	  memory usage is not a limiting factor. If unsure, say N.
+
 config SQUASHFS_ZLIB
 	bool "Include support for ZLIB compressed file systems"
 	depends on SQUASHFS
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 2dc730800f44..3061043e915c 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -88,6 +88,10 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 	struct bio_vec *bv;
 	int idx = 0;
 	int err = 0;
+#ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
+	struct page **cache_pages = kmalloc_array(page_count,
+			sizeof(void *), GFP_KERNEL | __GFP_ZERO);
+#endif
 
 	bio_for_each_segment_all(bv, fullbio, iter_all) {
 		struct page *page = bv->bv_page;
@@ -110,6 +114,11 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			head_to_cache = page;
 		else if (idx == page_count - 1 && index + length != read_end)
 			tail_to_cache = page;
+#ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
+		/* Cache all pages in the BIO for repeated reads */
+		else if (cache_pages)
+			cache_pages[idx] = page;
+#endif
 
 		if (!bio || idx != end_idx) {
 			struct bio *new = bio_alloc_clone(bdev, fullbio,
@@ -163,6 +172,25 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 		}
 	}
 
+#ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
+	if (!cache_pages)
+		goto out;
+
+	for (idx = 0; idx < page_count; idx++) {
+		if (!cache_pages[idx])
+			continue;
+		int ret = add_to_page_cache_lru(cache_pages[idx], cache_mapping,
+						(read_start >> PAGE_SHIFT) + idx,
+						GFP_NOIO);
+
+		if (!ret) {
+			SetPageUptodate(cache_pages[idx]);
+			unlock_page(cache_pages[idx]);
+		}
+	}
+	kfree(cache_pages);
+out:
+#endif
 	return 0;
 }
 
-- 
2.17.1


