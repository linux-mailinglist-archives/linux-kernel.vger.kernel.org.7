Return-Path: <linux-kernel+bounces-753941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891E0B18A69
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D885850C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373781991D2;
	Sat,  2 Aug 2025 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkuvWOCi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDA1917F0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754101122; cv=none; b=OyG4lvRHAjZ6JWuQrfrlbBuZUlwZ6KkXxHICKlLYg3w3gPEQYco+c1P9Dp0lj1rqW6V3NTbl7XAU27gLN4x6sY4eOilR3+Rbmena8F2JwYYAHJFCZKiXK9NFAt7jMz3n5MuMLUmMcZo/xtY4+ppzUfmSl+qEpcj/9KfGnqpJW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754101122; c=relaxed/simple;
	bh=+G3TPsT84hENM48wb5T4JMxURRdU/RnRJbW0ImSt1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbg2jwwVbgqwB5glSPHGhMVCx2vH3qobEjOerl5bk41xzOG16dGg911WVrHv8+CihUL5f0+HjvG8Xj1cGUA5A4cY6nOqIzcdCpT0w1XjkY2WjHmvwocsi7Y2k9nVgd+8qPeCLGraE+doNHz5EpYsLKyPzdRiSHALb1LTK2V+Fho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkuvWOCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3137C4CEF9;
	Sat,  2 Aug 2025 02:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754101122;
	bh=+G3TPsT84hENM48wb5T4JMxURRdU/RnRJbW0ImSt1Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkuvWOCimkxwhAdrBkpkkmb8uFLMX+Vnd/Jsl5mUFaNvhnAMy3WSVDsxW9P0rxjlj
	 dHLYGIcgtSX5OoTCC0Gc3Iiwb+WDnJbvgCjFBS/aG914RsfsGYU7osVLs6zu/OQlmT
	 eSHmAaEuqrBh0IfY9r94+o1/3rqHFAgEZcF0UzKO0KmO9lN4m0fqD3PILqgeXXcvMw
	 f8qHlOzH1aUkdwG5hmeHD9NBnyQEqjwxoWi911NcfOvIQtOdI1vNDvJvlg8LsCbSf1
	 BRQs7VH0lYAbOFbTrajr2U+fL3oItq3epOhDfi5/F9qyYURufANLo0hKfFN+Cc1H/L
	 nMofofoq+O/BQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chaseyu@google.com>,
	Jan Prusakowski <jprusakowski@google.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: fix to zero data after EOF for compressed file correctly
Date: Sat,  2 Aug 2025 10:18:32 +0800
Message-ID: <20250802021832.1882302-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250802021832.1882302-1-chao@kernel.org>
References: <20250802021832.1882302-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chaseyu@google.com>

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
- don't dirty pages post eof
- call filemap_write_and_wait_range() to flush page
- call truncate_pagecache() to drop pages or zero partial page post eof

Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Reported-by: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e37a7ed801e5..e029c8109b24 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1245,16 +1245,29 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	for (i = (1 << log_cluster_size) - 1; i >= 0; i--) {
 		struct folio *folio = page_folio(rpages[i]);
 		loff_t start = (loff_t)folio->index << PAGE_SHIFT;
+		loff_t offset = from > start ? from - start : 0;
 
-		if (from > start) {
-			folio_zero_segment(folio, from - start,
-					folio_size(folio));
-			break;
+		folio_zero_segment(folio, offset, folio_size(folio));
+
+		/* for folios post EOF, just drop them instead of redirty them */
+		if (from <= start) {
+			f2fs_folio_put(folio, true);
+			rpages[i] = NULL;
 		}
-		folio_zero_segment(folio, 0, folio_size(folio));
+
+		if (from >= start)
+			break;
 	}
 
 	f2fs_compress_write_end(inode, fsdata, start_idx, true);
+
+	err = filemap_write_and_wait_range(inode->i_mapping,
+			round_down(from, 1 << log_cluster_size << PAGE_SHIFT),
+			LLONG_MAX);
+	if (err)
+		return err;
+
+	truncate_pagecache(inode, from);
 	return 0;
 }
 
-- 
2.49.0


