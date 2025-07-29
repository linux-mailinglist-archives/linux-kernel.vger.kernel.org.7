Return-Path: <linux-kernel+bounces-749896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B52B15466
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0051B18A54B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FF27816B;
	Tue, 29 Jul 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scX6cQJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7926B74E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822042; cv=none; b=t7Db3WJNOCQ4/CrnGs2Mntro7P1qP1Tizk+DM4tcIlvJ+jrtsiBtQ69z/Tv1DTWlcKPONppQG5L1qsIVUJX6wWdKY/JTQWT3KqeJux7PQiEJzPwhI1/JSpKsrYUb4mPNzy/XQRIJGMEJsKY75CtbL+cAakGvEHETWIzgo39HMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822042; c=relaxed/simple;
	bh=b6s0yx8astzM5SvN+qTAi1m/KmlWhi4qvNDzaSolpqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDMPUsADhmX5g8M+yjv8m5FmkFTP8+A4GDBH22/snXTn3MnQUtO/upsIyEt5r0mBksZCQIYq6/xsxCg7BfzUH3GxzWzrHi1u1tmL426T66nV1fVVjU1RKiH8b2EitbZRdYtCn4JNTRwvZ4HbxXiEqn9U88MJXcPQrb8meYKZ2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scX6cQJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4036C4CEEF;
	Tue, 29 Jul 2025 20:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753822041;
	bh=b6s0yx8astzM5SvN+qTAi1m/KmlWhi4qvNDzaSolpqo=;
	h=From:To:Cc:Subject:Date:From;
	b=scX6cQJQFcWqxL6oOB3UngL0/BGc4F0O5OIu336p7EozRzFFLQfY2cLriXuCEAFBq
	 7iPV/j3OB8LyjVrbqU/VJ7VZiPGVEtz7tqksm1OQ4T6FYvYi2QZqr+eqndZBUn+dtP
	 9ZyoyWaDpl+c0BBqElZE9QSlnG1HWiKly48azdQ4x+29qrzHeyfjdP2MOppxXLR2ec
	 gdojJ/QHs8lvu2iJV12GE3X28WDdrJEsp/EVBeatLa4PZRQEUW+B/ilbzTbBM9Gdaa
	 qopYD97VfgYCXcPG6UsEkMCenVlXz6ytejkZQ5oULh1mtrjDLvJ0Rbsz9hA+UtxgjH
	 CitKdO6x9+AGw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: drop inode from the donation list when the last file is closed
Date: Tue, 29 Jul 2025 20:47:19 +0000
Message-ID: <20250729204719.1253285-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's drop the inode from the donation list when there is no other
open file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 ++
 fs/f2fs/file.c  | 8 +++++++-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/super.c | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97c1a2a3fbd7..7029aa8b430e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -876,6 +876,7 @@ struct f2fs_inode_info {
 	/* linked in global inode list for cache donation */
 	struct list_head gdonate_list;
 	pgoff_t donate_start, donate_end; /* inclusive */
+	atomic_t open_count;		/* # of open files */
 
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
@@ -3652,6 +3653,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_update_inode(struct inode *inode, struct folio *node_folio);
 void f2fs_update_inode_page(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
+void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
 void f2fs_handle_failed_inode(struct inode *inode);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 176889d778f9..9b8d24097b7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -628,7 +628,10 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	return finish_preallocate_blocks(inode);
+	err = finish_preallocate_blocks(inode);
+	if (!err)
+		atomic_inc(&F2FS_I(inode)->open_count);
+	return err;
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
@@ -2037,6 +2040,9 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
+	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
+		f2fs_remove_donate_inode(inode);
+
 	/*
 	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 154106aa350b..8c4eafe9ffac 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -821,7 +821,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
-static void f2fs_remove_donate_inode(struct inode *inode)
+void f2fs_remove_donate_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30c038413040..e16c4e2830c2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1701,6 +1701,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
+	atomic_set(&fi->open_count, 0);
 	init_f2fs_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.50.1.552.g942d659e1b-goog


