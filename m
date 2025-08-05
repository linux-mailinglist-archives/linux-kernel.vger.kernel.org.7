Return-Path: <linux-kernel+bounces-755982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56653B1AE5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F1684E20DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339223771E;
	Tue,  5 Aug 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAFzDZgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595F231C9F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375361; cv=none; b=hF8GSfVYwuQR3GLmzus04nzI+mji8PLmCwekLCVX4JGXG7nCQx7WXJlKiN4Ov3gjnAtV63EYc6gK/i2EVYLSTw6s92WtSajuVgqFTTw/kzIp0xmrersFqScq+UqIvZJQ4bSB5XFVU7Sw685aR5ftRmLDtPA3A9xWv8DF1D8Hnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375361; c=relaxed/simple;
	bh=EwTLvFeBezG7V6z2Hw0a8N8j6VdCJXp0nWCQ1ghQkZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btNYfhdBjgii5XTUE4C1aI+ocIzuPqpxaNezCT6vMHgJFYxqS2FlispwwC8yv0lXYIjvXMcRF5D3eF6hhOSW9coKWcDiLBFybKpUa/myq1FkPdd4t0t32MD2k7UXcyjusz5kq8ymi5dk7cSLL4KnsBrlzdJpmbrzo+u+DG8cHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAFzDZgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E433C4CEF8;
	Tue,  5 Aug 2025 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754375361;
	bh=EwTLvFeBezG7V6z2Hw0a8N8j6VdCJXp0nWCQ1ghQkZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAFzDZgbc1lwC+ilNoAw2zjnISevehWzq55U41ETYesGG47LnUs0YR9PYKZmWWJrk
	 UIhYARK/TWVw8SIjI7J47RWy00ApRG36iXXeERpelLt81XwMxYc2IoergSRGt9Zdko
	 tURQfX+SuiAbU5gSHBQrl3ehCaV17UpEYW3VjtYisz5X4oYu2FoBAaGzaIg/PGn4ov
	 Lj2QZupPQdowVLUNcGQKdgnKOJRCJWyOL4dEFDGQ7tNfga+pq5dQ0X7Okz0a93z27+
	 IMWxoXVndoDI4hVMJYDkteSEpxivhYa91Q0uMIl/2ssU5UEfekuLSaaSFax8odgdS4
	 l5CifOW962hZw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH v3 2/3] f2fs: fix to zero data after EOF for compressed file correctly
Date: Tue,  5 Aug 2025 14:29:11 +0800
Message-ID: <20250805062912.3070949-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250805062912.3070949-1-chao@kernel.org>
References: <20250805062912.3070949-1-chao@kernel.org>
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
v3:
- reorder patch 2 and patch 3
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


