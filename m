Return-Path: <linux-kernel+bounces-859989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E3BEF185
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE05D4E77A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DFB29A309;
	Mon, 20 Oct 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7cO3mFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C478F5D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927699; cv=none; b=M7WT7kg4rE1C3OtgFa+moXwPCh7p3HfVA3MtDogmsub3xSpt5b02n4/eNEASVxX9NQk4WGoBk0NybAUVOUNPEOHymQ+URd1Dqdl4vPVaH0vMW2B96ZZAmQETdkfJWMAd5UC8Zu7NhWkNyOJw6wdG+KD9nYJrrBOzCiNdxcEUARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927699; c=relaxed/simple;
	bh=gibS2058zF3QhWAGHmp65PdhuCBaNlt5skZcjoX8bkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFq5r/90veDB5ciqhsxwuOJpM6frr8ZWsiMghF62DznyX/BsY8xLJjjuPe4MhK+Vyrlmui/3ad/J4wFbsipvwZCoyaGMPb1PIJBM9fnAMm9mTJZOPWDu1+k5y3C2tsRKW1jEBgtqROymvSm74T02fyTMx2A5zqvrKxqXeh0G+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7cO3mFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA66C4CEE7;
	Mon, 20 Oct 2025 02:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760927698;
	bh=gibS2058zF3QhWAGHmp65PdhuCBaNlt5skZcjoX8bkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=r7cO3mFxYKHmrgFjgzxMVNR+VmwYtSWA65Cs0u1X1M7N9USCHLVRes4wuQc2/kx8w
	 R2/6v7wRxvkOmS48fPPYmCgdjMSxgfM+1M8+23SxOdgCGPhhPmqvdBboWmC1P/ww0r
	 AVazXJtl9jzKGy91Dj1Fnei/BpaJm01O6jRQ//xPddn8x+5WwmWvaZMg+cknjBZmA1
	 tF+QwKNGt9ZRRhL/Ynl3xxZr0SQuu94mcl5vMuPJ4CxyTV6xEghw3L8NG7ZZcXSiWy
	 +s0z4+svpp8SqqaAB5T3IBUbwdERHxIjHMPGn3LvOY+GbldmXttG64peUeIJ8F/yYJ
	 zrvzkRbLngvCQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	"Bai, Shuangpeng" <sjb7183@psu.edu>
Subject: [PATCH] f2fs: fix to avoid updating compression context during writeback
Date: Mon, 20 Oct 2025 10:34:53 +0800
Message-ID: <20251020023453.329467-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bai, Shuangpeng <sjb7183@psu.edu> reported a bug as below:

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 11441 Comm: syz.0.46 Not tainted 6.17.0 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:f2fs_all_cluster_page_ready+0x106/0x550 fs/f2fs/compress.c:857
Call Trace:
 <TASK>
 f2fs_write_cache_pages fs/f2fs/data.c:3078 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3290 [inline]
 f2fs_write_data_pages+0x1c19/0x3600 fs/f2fs/data.c:3317
 do_writepages+0x38e/0x640 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 file_write_and_wait_range+0x2ba/0x3e0 mm/filemap.c:794
 f2fs_do_sync_file+0x6e6/0x1b00 fs/f2fs/file.c:294
 generic_write_sync include/linux/fs.h:3043 [inline]
 f2fs_file_write_iter+0x76e/0x2700 fs/f2fs/file.c:5259
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7e9/0xe00 fs/read_write.c:686
 ksys_write+0x19d/0x2d0 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x470 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The bug was triggered w/ below race condition:

fsync				setattr			ioctl
- f2fs_do_sync_file
 - file_write_and_wait_range
  - f2fs_write_cache_pages
  : inode is non-compressed
  : cc.cluster_size =
    F2FS_I(inode)->i_cluster_size = 0
   - tag_pages_for_writeback
				- f2fs_setattr
				 - truncate_setsize
				 - f2fs_truncate
							- f2fs_fileattr_set
							 - f2fs_setflags_common
							  - set_compress_context
							  : F2FS_I(inode)->i_cluster_size = 4
							  : set_inode_flag(inode, FI_COMPRESSED_FILE)
   - f2fs_compressed_file
   : return true
   - f2fs_all_cluster_page_ready
   : "pgidx % cc->cluster_size" trigger dividing 0 issue

Let's change as below to fix this issue:
- introduce a new atomic type variable .writeback in structure f2fs_inode_info
to track the number of threads which calling f2fs_write_cache_pages().
- use .i_sem lock to protect .writeback update.
- check .writeback before update compression context in f2fs_setflags_common()
to avoid race w/ ->writepages.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@kernel.org
Reported-by: Bai, Shuangpeng <sjb7183@psu.edu>
Closes: https://lore.kernel.org/lkml/44D8F7B3-68AD-425F-9915-65D27591F93F@psu.edu
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c  | 17 +++++++++++++++++
 fs/f2fs/f2fs.h  |  3 ++-
 fs/f2fs/file.c  |  5 +++--
 fs/f2fs/super.c |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e2e8ea81a6f..1f090c018f1b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3231,6 +3231,19 @@ static inline bool __should_serialize_io(struct inode *inode,
 	return false;
 }
 
+static inline void account_writeback(struct inode *inode, bool inc)
+{
+	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+		return;
+
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	if (inc)
+		atomic_inc(&F2FS_I(inode)->writeback);
+	else
+		atomic_dec(&F2FS_I(inode)->writeback);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+}
+
 static int __f2fs_write_data_pages(struct address_space *mapping,
 						struct writeback_control *wbc,
 						enum iostat_type io_type)
@@ -3276,10 +3289,14 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 		locked = true;
 	}
 
+	account_writeback(inode, true);
+
 	blk_start_plug(&plug);
 	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
+	account_writeback(inode, false);
+
 	if (locked)
 		mutex_unlock(&sbi->writepages);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d295dc6bad84..94eb9a2d3a73 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -947,6 +947,7 @@ struct f2fs_inode_info {
 	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
 	unsigned char i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
+	atomic_t writeback;			/* count # of writeback thread */
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
@@ -4671,7 +4672,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 		f2fs_up_write(&fi->i_sem);
 		return true;
 	}
-	if (f2fs_is_mmap_file(inode) ||
+	if (f2fs_is_mmap_file(inode) || atomic_read(&fi->writeback) ||
 		(S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))) {
 		f2fs_up_write(&fi->i_sem);
 		return false;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c045e38e60ee..6d42e2d28861 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2128,8 +2128,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 
 			f2fs_down_write(&fi->i_sem);
 			if (!f2fs_may_compress(inode) ||
-					(S_ISREG(inode->i_mode) &&
-					F2FS_HAS_BLOCKS(inode))) {
+				atomic_read(&fi->writeback) ||
+				(S_ISREG(inode->i_mode) &&
+				F2FS_HAS_BLOCKS(inode))) {
 				f2fs_up_write(&fi->i_sem);
 				return -EINVAL;
 			}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1dd4a93ba4bb..4c384c6c6481 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1759,6 +1759,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	atomic_set(&fi->dirty_pages, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
 	atomic_set(&fi->open_count, 0);
+	atomic_set(&fi->writeback, 0);
 	init_f2fs_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.49.0


