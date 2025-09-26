Return-Path: <linux-kernel+bounces-834738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F14BA564E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0933D7B7144
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEEC2BE7D0;
	Fri, 26 Sep 2025 23:42:02 +0000 (UTC)
Received: from sxb1plsmtpa01-14.prod.sxb1.secureserver.net (sxb1plsmtpa01-14.prod.sxb1.secureserver.net [188.121.53.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EA1F91D6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758930121; cv=none; b=o5r5GilMrEwjLmRd4Wl75b7f1gLVFtensAgVPRMoLCdNUh5FMRPZfzzSAr15dpPr/0bmpWpXrxeUpCXDPbWhxd2l8dg9dyu73t9+T8YrFL8H7XDeQkM5ycVWMF0ded1szG4kJzdQc/AEqZIXOEZXWhZDPH2/YgJ6YOY03qKoAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758930121; c=relaxed/simple;
	bh=AEkl3tHYtGdl3krN7EQjl0kU1VaztJ3jc7kI64ZjNyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idOr8y2sYRWICbDScnGYHs1lpbb/24Gv6/R5j4ENAqBifdGT4zvpgGC/l6BNBkmrrCCwzvYmc4QdFt995ESNrSL+ivOUbNOzA6CC48HaU5aSfIM4uWYw1/bIDHpPgsVy7hKaP2O59pYuTJ02pPYinA09KFVLZ+exxljJlhTrsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 2GTAvdJ09WSMH2GTTvCFIR; Fri, 26 Sep 2025 14:59:32 -0700
X-CMAE-Analysis: v=2.4 cv=OIl+HSaB c=1 sm=1 tr=0 ts=68d70cc5
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=FXvPX3liAAAA:8 a=dKNdsOhYWSn6lg1XZoUA:9
 a=cQPPKAXgyycSBL8etih5:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=irvUdcZYBsSKPCvlqN3O:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
Feedback-ID: e8c5774583dc32ed31c7f385c2b011cf:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: amir73il@gmail.com,
	Phillip Lougher <phillip@squashfs.org.uk>,
	syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Subject: [PATCH] Squashfs: reject negative file sizes in squashfs_read_inode()
Date: Fri, 26 Sep 2025 22:59:35 +0100
Message-Id: <20250926215935.107233-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHnTQfjZsiMGi5EROkyGLIgLLOfVkxO2YR5b86UcKoy4aAj4mDTsRlLy/vfJGtAsVykQPYe1Oxszk9bxK+IPAUIZK+vdKVEAufUjdr+oLTff5sIWdSOY
 5OO7kSb/OFQh0w1UPjQYGNVRERHFYERBlukFcwl5FCGydKcBk4nGQvnKA82eYN1sqWEwfDkWv75U3lWJwFzifW3+Bc6Cq6TVeeOJSFlxlEgB3OI6T4jbOmLb
 VYLJbRfwU6WoWK5PGpu8Y/lRW/xFsEKNhLMk7chYYWGt4U0eFGnemJCaalsZVWFjZ7kPW7Hnrp6Dy4mNiaNXusfHn7KoWdyYlyvSGkjvOlOtPdpsqDAJ29Mi
 ukS6euj/u+l04y/o0N7hcQ7OunHdyYBnopBwjVB5W55uV9zf3wA=

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying
Squashfs file system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/inode.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 5920a33e44a1..8bbdd74a8d29 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -141,6 +141,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*
@@ -192,6 +196,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*
@@ -243,8 +251,12 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
-		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le16_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
+		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_dir_inode_ops;
 		inode->i_fop = &squashfs_dir_ops;
 		inode->i_mode |= S_IFDIR;
@@ -267,9 +279,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		xattr_id = le32_to_cpu(sqsh_ino->xattr);
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		inode->i_op = &squashfs_dir_inode_ops;
 		inode->i_fop = &squashfs_dir_ops;
 		inode->i_mode |= S_IFDIR;
@@ -296,7 +312,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
-		if (inode->i_size > PAGE_SIZE) {
+		if (inode->i_size < 0 || inode->i_size > PAGE_SIZE) {
 			ERROR("Corrupted symlink\n");
 			return -EINVAL;
 		}
-- 
2.39.2


