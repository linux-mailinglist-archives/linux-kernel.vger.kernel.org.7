Return-Path: <linux-kernel+bounces-829710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED56CB97AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D382E5A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86F30F7FD;
	Tue, 23 Sep 2025 22:09:00 +0000 (UTC)
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [92.204.81.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD930C357
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665340; cv=none; b=WBx9c7rbUSIo6PP8PUQnNw6C7urmrWztZNslRfrJrPF+2hXbKGzNKeJMt8/3YgaYFwZZ56AZUYSHPAzTVc+0NEJVbKV6gVayESQG6e++GFd3RW4Op1jamX2U+vg1QoO0pLfkBsbVUmodYQcOLexeZfo4BvSf66opkdekeabHras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665340; c=relaxed/simple;
	bh=u5fl5ICoaanZSbJ0nmGAh0TMt8jc4in7PCrNaO1/ufY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHEBk21fOwdOPSoBXjP5iWiLsa1hlXM1B01Fv8LW+lVvZ9JkjgZRgQqdKyTJPfe21NtwhysH5InXsSnDVF9VWGck9JyeMTTopxe59ZlHq/237X95N6b2orXayojtTANF2j0tiwi7XgSJ8OEjysPk9iwZun85dJ/0Dx+3LQSz9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 1B9IvdJrlRKdg1B9Wvhvsx; Tue, 23 Sep 2025 15:06:27 -0700
X-CMAE-Analysis: v=2.4 cv=cL65cleN c=1 sm=1 tr=0 ts=68d319e4
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=_v5trmpiMvKuf-VRmTkA:9 a=UObqyxdv-6Yh2QiB9mM_:22 a=irvUdcZYBsSKPCvlqN3O:22
Feedback-ID: 7f792593433213f080771ca666aa9d6c:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 1/2] Squashfs: add additional inode sanity checking
Date: Tue, 23 Sep 2025 23:06:51 +0100
Message-Id: <20250923220652.568416-2-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250923220652.568416-1-phillip@squashfs.org.uk>
References: <20250923220652.568416-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOMQZJ0kxU0mMUfK66mmEu4M4QEIiXoUFSU419+CNP1y9AJv/tJV3V98tNNyY4OZCbqZUY71NBQkKkRrf/7dK5PMWEV7SotbMPxdbx7DKGv1A+YZU8Ka
 7/3M3lfJUIcWca8lRa6YJaRVXb2kZTfygQarx2/Q7u/IypgYndO4U8EmOQ7GTD6J7VilMWGXBGWXwU9uxG/RIoRHQILjstb8GsWblFTgEoVd5frS6vYXB73+
 8PbdDb/k6zUtlMPD7o5y9YUoLlFnk9hg9vdIqoAIFWFk4Pp/8PdDyHimH9jWco1C

Add an additional sanity check when reading regular file inodes.

A regular file if the file size is an exact multiple of the filesystem
block size cannot have a fragment.  This is because by definition a
fragment block stores tailends which are not a whole block in size.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/inode.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e3..77eec1772998 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -140,8 +140,17 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
+			/*
+			 * the file cannot have a fragment (tailend) and have a
+			 * file size a multiple of the block size
+			 */
+			if ((inode->i_size & (msblk->block_size - 1)) == 0) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
@@ -155,7 +164,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		}
 
 		set_nlink(inode, 1);
-		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
 		inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
@@ -183,8 +191,17 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
+			/*
+			 * the file cannot have a fragment (tailend) and have a
+			 * file size a multiple of the block size
+			 */
+			if ((inode->i_size & (msblk->block_size - 1)) == 0) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
@@ -199,7 +216,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 		xattr_id = le32_to_cpu(sqsh_ino->xattr);
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
 		inode->i_op = &squashfs_inode_ops;
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
-- 
2.39.5


