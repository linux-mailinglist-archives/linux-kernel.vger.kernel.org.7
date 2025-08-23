Return-Path: <linux-kernel+bounces-782960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9322EB327A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523051BA1676
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD81239E9A;
	Sat, 23 Aug 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npLmb3i0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF021576E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938216; cv=none; b=jdmi4fCac04/kRYNvree9FrJudULfm02s8GEc0nM99rHAXjXFh9rJxinKoMLjlcS/35qutdHWiwyKxF4Fb4G+NU6JOWLavw+N4VDaihXfNeaW/SPGhHiNA6yxF71qCoFeVwfzINlLYHnYxnATk/MYdlTo9TqgLywrPFimWCYkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938216; c=relaxed/simple;
	bh=pEXIJRsKWMgfwe7mP0cGm5NGO0n6J1mDZ42J7yTw1Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QqSfm93n/xj74UxVNZOl/2sT4AQzsmGEg1RlN7Y2q0hC1O2SRVm9UGg2HKu7/kvsLE5IpkvmfebcNDwg4olAfzA7mbgQu5KXEvEoym4uAMGg/24KIMw6ZVQA7AZ1beF0ZWzOoh57j7bz6IeETic6IDiAJCK+94OpouXJaTuySzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npLmb3i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9BAC4CEE7;
	Sat, 23 Aug 2025 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755938216;
	bh=pEXIJRsKWMgfwe7mP0cGm5NGO0n6J1mDZ42J7yTw1Ws=;
	h=From:To:Cc:Subject:Date:From;
	b=npLmb3i0i0FmfVbQPF/fTAqDUSJLcEWU2RNp+rO3wBIQuZoNGehjPjlkqCXCS5NaV
	 G+CXcAM0b98eriPXWSO+TZolMsJZLmt1W+1hDDAmGj8u5iPodoUI99voqLYspunXnl
	 m6hBY0M1ajBVl5+3/a/FF6W5XFOku0xs8A7+kC8AD2P7u9lKn8K0LlL6HXNNrXUsA9
	 yN7zsi6RhSz4NIS//tvj61uoJLXY8KKRg6pud3oZrKNfS9AHQ6j7f2tMVwA4bRclj0
	 +ks0cW1U/3GbvtOf/DRV/DhL/XiO0lnqwqj+Y+ycCFhLWVXIUDkLzRjmKP9Am8h8WJ
	 +SzY+tHMGyzOw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+b9c7ffd609c3f09416ab@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to do sanity check on node footer for non inode dnode
Date: Sat, 23 Aug 2025 13:45:34 +0800
Message-Id: <20250823054534.41037-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As syzbot reported below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/file.c:1243!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT(full)
RIP: 0010:f2fs_truncate_hole+0x69e/0x6c0 fs/f2fs/file.c:1243
Call Trace:
 <TASK>
 f2fs_punch_hole+0x2db/0x330 fs/f2fs/file.c:1306
 f2fs_fallocate+0x546/0x990 fs/f2fs/file.c:2018
 vfs_fallocate+0x666/0x7e0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e65f8ebe9

w/ a fuzzed image, f2fs may encounter panic due to it detects inconsistent
truncation range in direct node in f2fs_truncate_hole().

The root cause is: a non-inode dnode may has the same footer.ino and
footer.nid, so the dnode will be parsed as an inode, then ADDRS_PER_PAGE()
may return wrong blkaddr count which may be 923 typically, by chance,
dn.ofs_in_node is equal to 923, then count can be calculated to 0 in below
statement, later it will trigger panic w/ f2fs_bug_on(, count == 0 || ...).

	count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);

This patch introduces a new node_type NODE_TYPE_NON_INODE, then allowing
passing the new_type to sanity_check_node_footer in f2fs_get_node_folio()
to detect corruption that a non-inode dnode has the same footer.ino and
footer.nid.

Scripts to reproduce:
mkfs.f2fs -f /dev/vdb
mount /dev/vdb /mnt/f2fs
touch /mnt/f2fs/foo
touch /mnt/f2fs/bar
dd if=/dev/zero of=/mnt/f2fs/foo bs=1M count=8
umount /mnt/f2fs
inject.f2fs --node --mb i_nid --nid 4 --idx 0 --val 5 /dev/vdb
mount /dev/vdb /mnt/f2fs
xfs_io /mnt/f2fs/foo -c "fpunch 6984k 4k"

Cc: stable@kernel.org
Reported-by: syzbot+b9c7ffd609c3f09416ab@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68a68e27.050a0220.1a3988.0002.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h     |  4 +++-
 fs/f2fs/gc.c       |  4 ++--
 fs/f2fs/node.c     | 58 +++++++++++++++++++++++++++++++---------------
 fs/f2fs/node.h     |  1 +
 fs/f2fs/recovery.c |  2 +-
 5 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e3d0f6d1d4c..bba9ff617ea6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3817,6 +3817,7 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname);
  * node.c
  */
 struct node_info;
+enum node_type;
 
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
@@ -3839,7 +3840,8 @@ int f2fs_remove_inode_page(struct inode *inode);
 struct folio *f2fs_new_inode_folio(struct inode *inode);
 struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
-struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
+						enum node_type node_type);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b57b8fd64747..ed3acbfc83ca 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1071,7 +1071,7 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 		}
 
 		/* phase == 2 */
-		node_folio = f2fs_get_node_folio(sbi, nid);
+		node_folio = f2fs_get_node_folio(sbi, nid, NODE_TYPE_REGULAR);
 		if (IS_ERR(node_folio))
 			continue;
 
@@ -1145,7 +1145,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	nid = le32_to_cpu(sum->nid);
 	ofs_in_node = le16_to_cpu(sum->ofs_in_node);
 
-	node_folio = f2fs_get_node_folio(sbi, nid);
+	node_folio = f2fs_get_node_folio(sbi, nid, NODE_TYPE_REGULAR);
 	if (IS_ERR(node_folio))
 		return false;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 109bc8898bc6..68d210f7798a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -876,7 +876,8 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 		}
 
 		if (!done) {
-			nfolio[i] = f2fs_get_node_folio(sbi, nids[i]);
+			nfolio[i] = f2fs_get_node_folio(sbi, nids[i],
+						NODE_TYPE_NON_INODE);
 			if (IS_ERR(nfolio[i])) {
 				err = PTR_ERR(nfolio[i]);
 				f2fs_folio_put(nfolio[0], false);
@@ -994,7 +995,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
 		return 1;
 
 	/* get direct node */
-	folio = f2fs_get_node_folio(sbi, dn->nid);
+	folio = f2fs_get_node_folio(sbi, dn->nid, NODE_TYPE_NON_INODE);
 	if (PTR_ERR(folio) == -ENOENT)
 		return 1;
 	else if (IS_ERR(folio))
@@ -1038,7 +1039,8 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
 	trace_f2fs_truncate_nodes_enter(dn->inode, dn->nid, dn->data_blkaddr);
 
-	folio = f2fs_get_node_folio(F2FS_I_SB(dn->inode), dn->nid);
+	folio = f2fs_get_node_folio(F2FS_I_SB(dn->inode), dn->nid,
+						NODE_TYPE_NON_INODE);
 	if (IS_ERR(folio)) {
 		trace_f2fs_truncate_nodes_exit(dn->inode, PTR_ERR(folio));
 		return PTR_ERR(folio);
@@ -1116,7 +1118,8 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	/* get indirect nodes in the path */
 	for (i = 0; i < idx + 1; i++) {
 		/* reference count'll be increased */
-		folios[i] = f2fs_get_node_folio(F2FS_I_SB(dn->inode), nid[i]);
+		folios[i] = f2fs_get_node_folio(F2FS_I_SB(dn->inode), nid[i],
+							NODE_TYPE_NON_INODE);
 		if (IS_ERR(folios[i])) {
 			err = PTR_ERR(folios[i]);
 			idx = i - 1;
@@ -1501,21 +1504,37 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t nid,
 					enum node_type ntype)
 {
-	if (unlikely(nid != nid_of_node(folio) ||
-		(ntype == NODE_TYPE_INODE && !IS_INODE(folio)) ||
-		(ntype == NODE_TYPE_XATTR &&
-		!f2fs_has_xattr_block(ofs_of_node(folio))) ||
-		time_to_inject(sbi, FAULT_INCONSISTENT_FOOTER))) {
-		f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
-			  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-			  ntype, nid, nid_of_node(folio), ino_of_node(folio),
-			  ofs_of_node(folio), cpver_of_node(folio),
-			  next_blkaddr_of_node(folio));
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
-		return -EFSCORRUPTED;
+	if (unlikely(nid != nid_of_node(folio)))
+		goto out_err;
+
+	switch (ntype) {
+	case NODE_TYPE_INODE:
+		if (!IS_INODE(folio))
+			goto out_err;
+		break;
+	case NODE_TYPE_XATTR:
+		if (!f2fs_has_xattr_block(ofs_of_node(folio)))
+			goto out_err;
+		break;
+	case NODE_TYPE_NON_INODE:
+		if (IS_INODE(folio))
+			goto out_err;
+		break;
+	default:
+		break;
 	}
+	if (time_to_inject(sbi, FAULT_INCONSISTENT_FOOTER))
+		goto out_err;
 	return 0;
+out_err:
+	f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
+		  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+		  ntype, nid, nid_of_node(folio), ino_of_node(folio),
+		  ofs_of_node(folio), cpver_of_node(folio),
+		  next_blkaddr_of_node(folio));
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+	return -EFSCORRUPTED;
 }
 
 static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
@@ -1572,9 +1591,10 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	return ERR_PTR(err);
 }
 
-struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
+						enum node_type node_type)
 {
-	return __get_node_folio(sbi, nid, NULL, 0, NODE_TYPE_REGULAR);
+	return __get_node_folio(sbi, nid, NULL, 0, node_type);
 }
 
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino)
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 030390543b54..9cb8dcf8d417 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -57,6 +57,7 @@ enum node_type {
 	NODE_TYPE_REGULAR,
 	NODE_TYPE_INODE,
 	NODE_TYPE_XATTR,
+	NODE_TYPE_NON_INODE,
 };
 
 /*
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 842b2daffa85..870b68c2c032 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -548,7 +548,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	}
 
 	/* Get the node page */
-	node_folio = f2fs_get_node_folio(sbi, nid);
+	node_folio = f2fs_get_node_folio(sbi, nid, NODE_TYPE_REGULAR);
 	if (IS_ERR(node_folio))
 		return PTR_ERR(node_folio);
 
-- 
2.40.1


