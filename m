Return-Path: <linux-kernel+bounces-738547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B2B0B9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8D6176AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45A518BC0C;
	Mon, 21 Jul 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9tmU4+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8B3FE4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063357; cv=none; b=p7zGlK1VHQw59qHQJW42JV/oTbHrBg5YSuz9wcDjwtl1BZc16ZgseoxG20KUgXSnURobS71VFKB/AUjXVDl39MTDCgtGVglYgwvVf7fd5Rh/1qC9gAVPZilz3sKPx6UQWimwNLvh7yCDFachvpC+KRwg/UZN/Sl/TePZTPoy9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063357; c=relaxed/simple;
	bh=orgIy60XqVsfiS5IU3qqmpU4wxTQIGlZQlY3DE3J6MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOfsoMgWfjYYtNBheIgjbO5+coEzjGw8wP/HiYBrubIz+ij2Bh221fXmCWCAtnGViLQIEhxDkqHPDQcgBWfY5n9rqmcJZbRBRsckTwoRSLunKKJXNTWXOyYks461loPb6DUKd/GkKKU43P8dh30TwuVNdcqzt56WhhMXgiiGPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9tmU4+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCF8C4CEE7;
	Mon, 21 Jul 2025 02:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753063356;
	bh=orgIy60XqVsfiS5IU3qqmpU4wxTQIGlZQlY3DE3J6MU=;
	h=From:To:Cc:Subject:Date:From;
	b=D9tmU4+M/NAp/JVFUz4UwFAy/9inC5hULK0lxrJQFC/86mpu1nZtwxtZW7J7UIpPZ
	 TbpDl3Sf3TZvLgwhgHoFZoB+VvWOn84Q8EEUOzNjQZdOKokyX6ZjZXp6VMKEBH5GqB
	 hMIA2y+KtyLLjPJfg7iAnM0zn5odatiI0iPBtqQiOE2HezZEPKks1v4XoSzqCnGmLX
	 wtckpb9vgPbxEeAzpbMpyWzekVt2RSfNim8L823le1+NdZFE8o2amRAXgKn8xy2FXs
	 t+NWrRAhPkw/14D3+oYnmS92Fa1P7+LrFvbjg2t5dZd3cyDPt0UrDcw6SngmIIGpxm
	 gAXwKWA5geEeQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daejun Park <daejun7.park@samsung.com>
Subject: [PATCH] f2fs: don't break allocation when crossing contiguous sections
Date: Mon, 21 Jul 2025 10:02:31 +0800
Message-ID: <20250721020231.2482090-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0638a3197c19 ("f2fs: avoid unused block when dio write in LFS
mode") has fixed unused block issue for dio write in lfs mode.

However, f2fs_map_blocks() may break and return smaller extent when
last allocated block locates in the end of section, even allocator
can allocate contiguous blocks across sections.

Actually, for the case that allocator returns a block address which is
not contiguous w/ current extent, we can record the block address in
iomap->private, in the next round, skip reallocating for the last
allocated block, then we can fix unused block issue, meanwhile, also,
we can allocates contiguous physical blocks as much as possible for dio
write in lfs mode.

Testcase:
- mkfs.f2fs -f /dev/vdb
- mount -o mode=lfs /dev/vdb /mnt/f2fs
- dd if=/dev/zero of=/mnt/f2fs/file bs=1M count=3; sync;
- dd if=/dev/zero of=/mnt/f2fs/dio bs=2M count=1 oflag=direct;
- umount /mnt/f2fs

Before:
f2fs_map_blocks: dev = (253,16), ino = 4, file offset = 0, start blkaddr = 0x0, len = 0x100, flags = 1, seg_type = 8, may_create = 1, multidevice = 0, flag = 5, err = 0
f2fs_map_blocks: dev = (253,16), ino = 4, file offset = 256, start blkaddr = 0x0, len = 0x100, flags = 1, seg_type = 8, may_create = 1, multidevice = 0, flag = 5, err = 0
f2fs_map_blocks: dev = (253,16), ino = 4, file offset = 512, start blkaddr = 0x0, len = 0x100, flags = 1, seg_type = 8, may_create = 1, multidevice = 0, flag = 5, err = 0
f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 0, start blkaddr = 0x4700, len = 0x100, flags = 3, seg_type = 1, may_create = 1, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 256, start blkaddr = 0x4800, len = 0x100, flags = 3, seg_type = 1, may_create = 1, multidevice = 0, flag = 3, err = 0

After:
f2fs_map_blocks: dev = (253,16), ino = 4, file offset = 0, start blkaddr = 0x0, len = 0x100, flags = 1, seg_type = 8, may_create = 1, multidevice = 0, flag = 5, err = 0
f2fs_map_blocks: dev = (253,16), ino = 4, file offset = 256, start blkaddr = 0x0, len = 0x100, flags = 1, seg_type = 8, may_create = 1, multidevice = 0, flag = 5, err = 0
f2fs_map_blocks: dev = (253,16), ino = 4, file offset = 512, start blkaddr = 0x0, len = 0x100, flags = 1, seg_type = 8, may_create = 1, multidevice = 0, flag = 5, err = 0
f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 0, start blkaddr = 0x4700, len = 0x200, flags = 3, seg_type = 1, may_create = 1, multidevice = 0, flag = 3, err = 0

Cc: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 28 ++++++++++++++++++----------
 fs/f2fs/f2fs.h |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d1a2616d41be..4e62f7f00b70 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1550,10 +1550,14 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	unsigned int start_pgofs;
 	int bidx = 0;
 	bool is_hole;
+	bool lfs_dio_write;
 
 	if (!maxblocks)
 		return 0;
 
+	lfs_dio_write = (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
+				map->m_may_create);
+
 	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag))
 		goto out;
 
@@ -1600,7 +1604,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create && (is_hole ||
 		(flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
-		!f2fs_is_pinned_file(inode)))) {
+		!f2fs_is_pinned_file(inode) && map->m_last_pblk != blkaddr))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto sync_out;
@@ -1684,10 +1688,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 		if (map->m_multidev_dio)
 			map->m_bdev = FDEV(bidx).bdev;
+
+		if (lfs_dio_write)
+			map->m_last_pblk = NULL_ADDR;
 	} else if (map_is_mergeable(sbi, map, blkaddr, flag, bidx, ofs)) {
 		ofs++;
 		map->m_len++;
 	} else {
+		if (lfs_dio_write && !f2fs_is_pinned_file(inode))
+			map->m_last_pblk = blkaddr;
 		goto sync_out;
 	}
 
@@ -1712,14 +1721,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		dn.ofs_in_node = end_offset;
 	}
 
-	if (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
-	    map->m_may_create) {
-		/* the next block to be allocated may not be contiguous. */
-		if (GET_SEGOFF_FROM_SEG0(sbi, blkaddr) % BLKS_PER_SEC(sbi) ==
-		    CAP_BLKS_PER_SEC(sbi) - 1)
-			goto sync_out;
-	}
-
 	if (pgofs >= end)
 		goto sync_out;
 	else if (dn.ofs_in_node < end_offset)
@@ -4162,7 +4163,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned int flags, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
-	struct f2fs_map_blocks map = {};
+	struct f2fs_map_blocks map = { NULL, };
 	pgoff_t next_pgofs = 0;
 	int err;
 
@@ -4171,6 +4172,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
+	if (flags & IOMAP_WRITE && iomap->private) {
+		map.m_last_pblk = (unsigned long)iomap->private;
+		iomap->private = NULL;
+	}
 
 	/*
 	 * If the blocks being overwritten are already allocated,
@@ -4209,6 +4214,9 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->flags |= IOMAP_F_MERGED;
 		iomap->bdev = map.m_bdev;
 		iomap->addr = F2FS_BLK_TO_BYTES(map.m_pblk);
+
+		if (flags & IOMAP_WRITE && map.m_last_pblk)
+			iomap->private = (void *)map.m_last_pblk;
 	} else {
 		if (flags & IOMAP_WRITE)
 			return -ENOTBLK;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dfddb66910b3..97c1a2a3fbd7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -732,6 +732,7 @@ struct f2fs_map_blocks {
 	block_t m_lblk;
 	unsigned int m_len;
 	unsigned int m_flags;
+	unsigned long m_last_pblk;	/* last allocated block, only used for DIO in LFS mode */
 	pgoff_t *m_next_pgofs;		/* point next possible non-hole pgofs */
 	pgoff_t *m_next_extent;		/* point to next possible extent */
 	int m_seg_type;
-- 
2.49.0


