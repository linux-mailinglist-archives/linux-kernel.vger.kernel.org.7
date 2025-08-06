Return-Path: <linux-kernel+bounces-757290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15451B1C057
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBC3188AAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B931F561D;
	Wed,  6 Aug 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0vUjU7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB7273FE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460676; cv=none; b=gzkbKBGuNU+T9Qim66dyo+TX5IomCyvQMh0kZ1yUq6vpMIDDtvuWKszfUFShHtxTv43L6RujzS285SGpLQgRR7lMjOqrcAoA1MQydd5Uz4oNFTElEwM4up/XJFPjtPC+q86CxxmYHFKvV2fJ6NXQmahxIM4Cjp8NnrWtjqqOWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460676; c=relaxed/simple;
	bh=UGRY8U7DyQIAExkPpgwhAztMw+LzvH6mrxdC0BG9rKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LACc0OXzXE90rYFW1hXUG53FUHHVmjrJUXmav/RF9RT80iUvWDkjH7crCJZRu67HxZe7OGfq8bFVJOZIsyAzyB+DRz2fhhqen18IMjwkNdMJS+mz7S9W31CHDfYNmhIzPks/cpfB5gVkAFMzawuYnNZStSH9zUoX1oqlMIUdtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0vUjU7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032CEC4CEE7;
	Wed,  6 Aug 2025 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754460676;
	bh=UGRY8U7DyQIAExkPpgwhAztMw+LzvH6mrxdC0BG9rKw=;
	h=From:To:Cc:Subject:Date:From;
	b=o0vUjU7v2hvImqezzBHGghNRv1MPIxihHdzpDsW8LXDIuFV/lTIqfq0qz+VEKjGtV
	 Daf+SwCKdMR4GgVa0M5d1tcnGHuYNBRxF8J4qMEfKypxu5Dvagbf1T3tfciQE5GrM1
	 3lQa92cwXicg5VwpL4K2KZbMOeWN9zfKkp4t4DoT9wBYk2fmU7p4RzpcB3j25/MJsO
	 8YfVe1Zm8UV3krf9lAjdOA/VFE4jnD8w1OpHUDxbD/wWFbC7cUsp3tqKRNuNchxT07
	 NqCNS7Pw7Rlre6YRPWpr8cvh6wLEybpMrVztz40zAOiT7MbRSzNIOY7iYqeuCu8ArZ
	 AiKLAx8zMhrUw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH v4 2/3] f2fs: fix to zero data after EOF for compressed file correctly
Date: Wed,  6 Aug 2025 14:11:06 +0800
Message-ID: <20250806061106.3445717-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
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
dropped, however on-disk compressed cluster is still valid, it may
include non-zero data post eof, result in exposing previous non-zero data
post eof while reading.

Fix:
In f2fs_truncate_partial_cluster(), let change as below to fix:
- call filemap_write_and_wait_range() to flush dirty page
- call truncate_pagecache() to drop pages or zero partial page post eof
- call f2fs_do_truncate_blocks() to truncate non-compress cluster to
  last valid block

Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Reported-by: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- update commit message to avoid typo and misunderstanding.
 fs/f2fs/compress.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6cd8902849cf..72bc05b913af 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1246,19 +1246,28 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 		for (i = cluster_size - 1; i >= 0; i--) {
 			struct folio *folio = page_folio(rpages[i]);
 			loff_t start = (loff_t)folio->index << PAGE_SHIFT;
+			loff_t offset = from > start ? from - start : 0;
 
-			if (from <= start) {
-				folio_zero_segment(folio, 0, folio_size(folio));
-			} else {
-				folio_zero_segment(folio, from - start,
-						folio_size(folio));
+			folio_zero_segment(folio, offset, folio_size(folio));
+
+			if (from >= start)
 				break;
-			}
 		}
 
 		f2fs_compress_write_end(inode, fsdata, start_idx, true);
+
+		err = filemap_write_and_wait_range(inode->i_mapping,
+				round_down(from, cluster_size << PAGE_SHIFT),
+				LLONG_MAX);
+		if (err)
+			return err;
+
+		truncate_pagecache(inode, from);
+
+		err = f2fs_do_truncate_blocks(inode,
+				round_up(from, PAGE_SIZE), lock);
 	}
-	return 0;
+	return err;
 }
 
 static int f2fs_write_compressed_pages(struct compress_ctx *cc,
-- 
2.49.0


