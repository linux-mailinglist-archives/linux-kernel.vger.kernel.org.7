Return-Path: <linux-kernel+bounces-816524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5F2B574F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE136167C21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D8A2F5313;
	Mon, 15 Sep 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqU5CNoT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1012F546D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928897; cv=none; b=MYk81AokoyTOe6EoeBrJPObvGT3tpi6GGWwnsGhYSs4szX+NpUscsnw4ZpGT9AQdYiGSi5DNww0m45JSnGhn7mLHRuK5eCT4XYqg1tlOzT5bHgKw6v/FI0CovhGB0AgGpMc8pvSQUf8xHMISzacfE9W398nUeZRdNU35SpjwhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928897; c=relaxed/simple;
	bh=QZMX6GkwFBWgTBkjZS74DvKgneBWRDpU+Kd4625oEPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiZ88zV82k7WKap73IjtG33BkTUFpt5W4Wj/7eFKB4SIxt/kpcKba/uG2lIO/0UHxnZAhn6PE9o3srC0vERi9aca9gaun5hFJICdAOThxtv+qw0D2nAoGWO7M0R4F6CdJEcNQrs7zdvj+T9YzeZ1dYpV6L6DzEfXq6KfDznWRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqU5CNoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9341C4CEF5;
	Mon, 15 Sep 2025 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928897;
	bh=QZMX6GkwFBWgTBkjZS74DvKgneBWRDpU+Kd4625oEPM=;
	h=From:To:Cc:Subject:Date:From;
	b=gqU5CNoTNMdUO2fWX9ZxfSGdNEjVLI+ZFBNHZlCrDzshK31on832kPz+gOG70NWTE
	 252FnHsS1a3bl4zxwgY5ResK7JUL43dD+x2ksVcn5+/pk1hOTPlS/tElQDORAur+SL
	 T4wOX4h8EHwsGZW+Hcc42UlOv+6/r+OWxIrNu8v///lL99SfTCu+ipnw4BMQCBc2D1
	 S5IiQVpqRiOkr1EKeailfM/sQd9lN4ItpatKlQsV7CJLuHHyPNA1RvflRtCzGHIoJ6
	 o9kg3MduIAQU1T/WiNRu/0K8PAj4JTX/ryTxwAMudxk1/BGno+8oEtSk/hBaqeuKxB
	 bS73knibL6xUA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to mitigate overhead of f2fs_zero_post_eof_page()
Date: Mon, 15 Sep 2025 17:34:45 +0800
Message-ID: <20250915093445.3790583-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_zero_post_eof_page() may cuase more overhead due to invalidate_lock
and page lookup, change as below to mitigate its overhead:
- check new_size before grabbing invalidate_lock
- lookup and invalidate pages only in range of [old_size, new_size]

Fixes: ba8dac350faf ("f2fs: fix to zero post-eof page")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1aae4361d0a8..92538d0113f8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -35,15 +35,20 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
-static void f2fs_zero_post_eof_page(struct inode *inode, loff_t new_size)
+static void f2fs_zero_post_eof_page(struct inode *inode,
+					loff_t new_size, bool lock)
 {
 	loff_t old_size = i_size_read(inode);
 
 	if (old_size >= new_size)
 		return;
 
+	if (lock)
+		filemap_invalidate_lock(inode->i_mapping);
 	/* zero or drop pages only in range of [old_size, new_size] */
-	truncate_pagecache(inode, old_size);
+	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
+	if (lock)
+		filemap_invalidate_unlock(inode->i_mapping);
 }
 
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
@@ -114,9 +119,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT);
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT, true);
 
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
@@ -1149,7 +1152,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		filemap_invalidate_lock(inode->i_mapping);
 
 		if (attr->ia_size > old_size)
-			f2fs_zero_post_eof_page(inode, attr->ia_size);
+			f2fs_zero_post_eof_page(inode, attr->ia_size, false);
 		truncate_setsize(inode, attr->ia_size);
 
 		if (attr->ia_size <= old_size)
@@ -1268,9 +1271,7 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, offset + len);
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len, true);
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1555,7 +1556,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	f2fs_zero_post_eof_page(inode, offset + len);
+	f2fs_zero_post_eof_page(inode, offset + len, false);
 
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
@@ -1678,9 +1679,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
-	filemap_invalidate_lock(mapping);
-	f2fs_zero_post_eof_page(inode, offset + len);
-	filemap_invalidate_unlock(mapping);
+	f2fs_zero_post_eof_page(inode, offset + len, true);
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1814,7 +1813,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
 
-	f2fs_zero_post_eof_page(inode, offset + len);
+	f2fs_zero_post_eof_page(inode, offset + len, false);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1872,9 +1871,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	if (err)
 		return err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, offset + len);
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len, true);
 
 	f2fs_balance_fs(sbi, true);
 
@@ -4922,9 +4919,8 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		return err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, iocb->ki_pos + iov_iter_count(from));
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode,
+		iocb->ki_pos + iov_iter_count(from), true);
 	return count;
 }
 
-- 
2.49.0


