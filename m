Return-Path: <linux-kernel+bounces-754604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D1B199FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E123B7C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5F120102B;
	Mon,  4 Aug 2025 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxX8r24+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5A1FE45A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271832; cv=none; b=pSE0lJgae08FppNCphsgI+w0X8mP5MGRZjIl7Aclt/U818ItEPUkjrEgGkEnxsjQKktsg3oLZh6dkF9H88qEe52MNASMRX/VRuWs9B5+UPuveY5wgzRrr2ehM5OdhP+1wAxGthjxi+0MYovV9Ok6uKVj/TYIQxVyVIhB1R7E/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271832; c=relaxed/simple;
	bh=Yi9KE/+A5RlPKQxaZwXXTeBQUPlphTVDzSCvxOglwRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqQEVHZ2KZxuvOU2LEXYy8/LxjRCmAYohvD0EZCFQV/gBt/qXvFOaMZRI9rhZLzuq5DNDHEGZUnQVtNS+NUADNHxFWl2PL17prdPDORGLlczkvUGeKQswi+R+fvHxN1w1+4W22m9uCs9wfxj9mnQNHIJJPeL51VN4CiuI/1am0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxX8r24+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877DAC4CEF9;
	Mon,  4 Aug 2025 01:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754271832;
	bh=Yi9KE/+A5RlPKQxaZwXXTeBQUPlphTVDzSCvxOglwRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxX8r24+o3AAQxICqeLn67kyYtp5stNDeXndy2gwe8hv3HPSEdgoeIq/tLx+ycNko
	 ol3WEE+jAdi2l2kQhLvVQjx3ReoWbuQdKEfCggelILjUtk/HateEuApnM+G/u/Dscw
	 9A3y4ZT5RxEYwNh53CqPzZ4raFPQYpdvGNqt01XWD+S/7M2nFmU4+RJIiA77yRTR18
	 Av2xmJheN6QbLIJlybAkHjq7GTff9UMwnSCl11+YWmL0eT1y9R7ydN7A+zTXqd+fmm
	 AgRcMg1+I9GFWBtQnxFi+7kxuWt54x5ylpwmoFoOCu5m/mAeFfDT5Caa4iSOhEVSGy
	 pAlnMWBEkHXvg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH v2 3/3] f2fs: fix to zero data after EOF for compressed file correctly
Date: Mon,  4 Aug 2025 09:43:39 +0800
Message-ID: <20250804014340.2537172-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804014340.2537172-1-chao@kernel.org>
References: <20250804014340.2537172-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/091 may fail, then it bisects to the bad commit ba8dac350faf
("f2fs: fix to zero post-eof page").

What will cause generic/091 to fail is something like below Testcase #1:
1. write 16k as compressed blocks
2. truncate to 12k
3. truncate to 20k
4. verify data in range of [12k, 16k], however data is not zero as
expected

Script of Testcase #1
mkfs.f2fs -f -O extra_attr,compression /dev/vdb
mount -t f2fs -o compress_extension=* /dev/vdb /mnt/f2fs
dd if=/dev/zero of=/mnt/f2fs/file bs=12k count=1
dd if=/dev/random of=/mnt/f2fs/file bs=4k count=1 seek=3 conv=notrunc
sync
truncate -s $((12*1024)) /mnt/f2fs/file
truncate -s $((20*1024)) /mnt/f2fs/file
dd if=/mnt/f2fs/file of=/mnt/f2fs/data bs=4k count=1 skip=3
od /mnt/f2fs/data
umount /mnt/f2fs

Analisys:
in step 2), we will redirty all data pages from #0 to #3 in compressed
cluster, and zero page #3,
in step 3), f2fs_setattr() will call f2fs_zero_post_eof_page() to drop
all page cache post eof, includeing dirtied page #3,
in step 4) when we read data from page #3, it will decompressed cluster
and extra random data to page #3, finally, we hit the non-zeroed data
post eof.

However, the commit ba8dac350faf ("f2fs: fix to zero post-eof page") just
let the issue be reproduced easily, w/o the commit, it can reproduce this
bug w/ below Testcase #2:
1. write 16k as compressed blocks
2. truncate to 8k
3. truncate to 12k
4. truncate to 20k
5. verify data in range of [12k, 16k], however data is not zero as
expected

Script of Testcase #2
mkfs.f2fs -f -O extra_attr,compression /dev/vdb
mount -t f2fs -o compress_extension=* /dev/vdb /mnt/f2fs
dd if=/dev/zero of=/mnt/f2fs/file bs=12k count=1
dd if=/dev/random of=/mnt/f2fs/file bs=4k count=1 seek=3 conv=notrunc
sync
truncate -s $((8*1024)) /mnt/f2fs/file
truncate -s $((12*1024)) /mnt/f2fs/file
truncate -s $((20*1024)) /mnt/f2fs/file
echo 3 > /proc/sys/vm/drop_caches
dd if=/mnt/f2fs/file of=/mnt/f2fs/data bs=4k count=1 skip=3
od /mnt/f2fs/data
umount /mnt/f2fs

Anlysis:
in step 2), we will redirty all data pages from #0 to #3 in compressed
cluster, and zero page #2 and #3,
in step 3), we will truncate page #3 in page cache,
in step 4), expand file size,
in step 5), hit random data post eof w/ the same reason in Testcase #1.

Root Cause:
In f2fs_truncate_partial_cluster(), after we truncate partial data block
on compressed cluster, all pages in cluster including the one post eof
will be dirtied, after another tuncation, dirty page post eof will be
dropped, however on-disk compressed cluster is still valid, it includes
invalid data post eof, result in exposing previous data post eof while
reading.

Fix:
In f2fs_truncate_partial_cluster(), let change as below to fix:
- call filemap_write_and_wait_range() to flush dirty page
- call truncate_pagecache() to drop pages or zero partial page post eof
- call f2fs_do_truncate_blocks() to truncate non-compress cluster to
  last vali block

Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Reported-by: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- should dirty & flush all pages in cluster and truncate blocks post eof
later
 fs/f2fs/compress.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e37a7ed801e5..6ad8d3bc6df7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1245,17 +1245,25 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	for (i = (1 << log_cluster_size) - 1; i >= 0; i--) {
 		struct folio *folio = page_folio(rpages[i]);
 		loff_t start = (loff_t)folio->index << PAGE_SHIFT;
+		loff_t offset = from > start ? from - start : 0;
 
-		if (from > start) {
-			folio_zero_segment(folio, from - start,
-					folio_size(folio));
+		folio_zero_segment(folio, offset, folio_size(folio));
+
+		if (from >= start)
 			break;
-		}
-		folio_zero_segment(folio, 0, folio_size(folio));
 	}
 
 	f2fs_compress_write_end(inode, fsdata, start_idx, true);
-	return 0;
+
+	err = filemap_write_and_wait_range(inode->i_mapping,
+			round_down(from, 1 << log_cluster_size << PAGE_SHIFT),
+			LLONG_MAX);
+	if (err)
+		return err;
+
+	truncate_pagecache(inode, from);
+
+	return f2fs_do_truncate_blocks(inode, round_up(from, PAGE_SIZE), lock);
 }
 
 static int f2fs_write_compressed_pages(struct compress_ctx *cc,
-- 
2.49.0


