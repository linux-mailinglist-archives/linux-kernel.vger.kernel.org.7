Return-Path: <linux-kernel+bounces-823905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB22B87B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CF8566649
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A46262815;
	Fri, 19 Sep 2025 02:15:40 +0000 (UTC)
Received: from sxb1plsmtpa01-09.prod.sxb1.secureserver.net (sxb1plsmtpa01-09.prod.sxb1.secureserver.net [92.204.81.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2525A626
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248139; cv=none; b=rp5FGRRwBHuKlgm5OQzdSSTUZXs7xg4K3z1br1ule6Ae/EHYUHjB9U5xA2/9W2f4wgcOevCP2bR2yZqyLOJfEcJMcb2CNK4X+NzRtAKBWMQ41kCj+auJIUJKa/Ufcsgl2j9eqKRp8qHHy8CVBw1FIbkvpRSIXwEcrJ9yu1Fdk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248139; c=relaxed/simple;
	bh=2rMkJJihBf3J9DxJ3zC1lOpX5yf+oowDXYstP9/P+ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqkpUYGDUUcR0uQKamz50JxCiPL77uNnCloQfdkxzADVmw68m0tHUQwr4zAUWHe+IFGp05d1Ehwixvd+puCh8t02ebSvnNejNSdaGtkwClIac1nbL+icfarvvzDOcbQlezDsKREaPZLV+HcUAEAHKQNLu0PyOFBSR2wQ0tH2lSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id zO7RupvPuQTbTzO7fu70lU; Thu, 18 Sep 2025 16:33:08 -0700
X-CMAE-Analysis: v=2.4 cv=OMp+HSaB c=1 sm=1 tr=0 ts=68cc96b4
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=FXvPX3liAAAA:8 a=SQVHjW8cbvKmi7E3iwQA:9
 a=cQPPKAXgyycSBL8etih5:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=irvUdcZYBsSKPCvlqN3O:22
Feedback-ID: be4d3acd4d0474bd90f04c564a3eca74:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	syzbot+157bdef5cf596ad0da2c@syzkaller.appspotmail.com
Subject: [PATCH] Squashfs: fix uninit-value in squashfs_get_parent
Date: Fri, 19 Sep 2025 00:33:08 +0100
Message-Id: <20250918233308.293861-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKPEw2ovanV3k0gtEzy0CJOpDmFfwSr+j8F9R06C+2ldxqHFap90pFjZmueKbGbfs4T8Ml1n9JS61mOwh0yv4YMpTsPsPJs5kC099S4wa4HRLtommQ3/
 Mq5wdxpsohkjV495jCiQAKwOrGNnqJRLG2itz9epXcnuMx9acxybetipw8jlIDMvsLCaPyW033eBYhh64msSRNKzVPCqFLy+5ckrfhBWR7kB+bVAKIk5C5YR
 ArPb7j8JAvv9KH/d+Tu+xRmktYSrZoo+931U7xhgPlGt5aOhOiwnPVhj8Ey0exjfHBiVHDjBC0Du3EtJ7o4PSkkf1HZE4d7vmh6nY7qN7XRT+mrk7y/DL46A
 BF86uxIt

Syzkaller reports a "KMSAN: uninit-value in squashfs_get_parent" bug.

This is caused by open_by_handle_at() being called with a file handle
containing an invalid parent inode number.  In particular the inode
number is that of a symbolic link, rather than a directory.

Squashfs_get_parent() gets called with that symbolic link inode, and
accesses the parent member field.

	unsigned int parent_ino = squashfs_i(inode)->parent;

Because non-directory inodes in Squashfs do not have a parent value,
this is uninitialised, and this causes an uninitialised value access.

The fix is to initialise parent with the invalid inode 0, which
will cause an EINVAL error to be returned.

Regular inodes used to share the parent field with the block_list_start
field.  This is removed in this commit to enable the parent field
to contain the invalid inode number 0.

Fixes: 122601408d20 ("Squashfs: export operations")
Reported-by: syzbot+157bdef5cf596ad0da2c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68cc2431.050a0220.139b6.0001.GAE@google.com/
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/inode.c         | 7 +++++++
 fs/squashfs/squashfs_fs_i.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e3..53104f25de51 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -165,6 +165,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->start = le32_to_cpu(sqsh_ino->start_block);
 		squashfs_i(inode)->block_list_start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
@@ -212,6 +213,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->start = le64_to_cpu(sqsh_ino->start_block);
 		squashfs_i(inode)->block_list_start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
@@ -292,6 +294,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_mode |= S_IFLNK;
 		squashfs_i(inode)->start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
@@ -329,6 +332,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		rdev = le32_to_cpu(sqsh_ino->rdev);
 		init_special_inode(inode, inode->i_mode, new_decode_dev(rdev));
+		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
 				SQUASHFS_INODE_BLK(ino), offset, rdev);
@@ -353,6 +357,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		rdev = le32_to_cpu(sqsh_ino->rdev);
 		init_special_inode(inode, inode->i_mode, new_decode_dev(rdev));
+		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
 				SQUASHFS_INODE_BLK(ino), offset, rdev);
@@ -373,6 +378,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			inode->i_mode |= S_IFSOCK;
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		init_special_inode(inode, inode->i_mode, 0);
+		squashfs_i(inode)->parent = 0;
 		break;
 	}
 	case SQUASHFS_LFIFO_TYPE:
@@ -392,6 +398,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_op = &squashfs_inode_ops;
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		init_special_inode(inode, inode->i_mode, 0);
+		squashfs_i(inode)->parent = 0;
 		break;
 	}
 	default:
diff --git a/fs/squashfs/squashfs_fs_i.h b/fs/squashfs/squashfs_fs_i.h
index 2c82d6f2a456..8e497ac07b9a 100644
--- a/fs/squashfs/squashfs_fs_i.h
+++ b/fs/squashfs/squashfs_fs_i.h
@@ -16,6 +16,7 @@ struct squashfs_inode_info {
 	u64		xattr;
 	unsigned int	xattr_size;
 	int		xattr_count;
+	int		parent;
 	union {
 		struct {
 			u64		fragment_block;
@@ -27,7 +28,6 @@ struct squashfs_inode_info {
 			u64		dir_idx_start;
 			int		dir_idx_offset;
 			int		dir_idx_cnt;
-			int		parent;
 		};
 	};
 	struct inode	vfs_inode;
-- 
2.39.2


