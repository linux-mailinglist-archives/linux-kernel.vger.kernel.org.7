Return-Path: <linux-kernel+bounces-852234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 830DDBD8811
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9556F4FBC33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D292F3600;
	Tue, 14 Oct 2025 09:43:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583F2ECE89
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434998; cv=none; b=p183/NDpg5BQW5r0JXZcj29NABlez+fyGRlG5ypnO2YOcfPwyQOsazP+NvVBjSqihKhgoiOdhQxDfvZI9fm1bEqLhcRAZJhXMsk3dknde9PWWN9oZBcz3/8YtXHRoU0Kx1jMcptXQaPh4cCknAPyMkxirfg3K9vEUoh9Annq7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434998; c=relaxed/simple;
	bh=Oh2doJr/fJMs/OiBy7EfblDXV9fbk6YKmWtlI9yBdYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I9RnsXnM962jtDEm2ieaEuULzgFCuRT3qFt7zax3Ex2K/NUeYwWhbnJ2V474FxKRU0WhgghJujoqQUatgx2CE4PCeRv8o4LY+p2GqUo/1WEnmBbZYIaqjp7XJErovVz+lOw2sIzPmGtfI8x4pQvCcO98Apu7Njriyj/1/SmDz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9143e8a4c5eso2685157039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434996; x=1761039796;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSkD+2BbvQuCp7JdNYB5V4RMP+gYI8XNuoU9a0pEALA=;
        b=BDsxiOMk+B9m7vbLxxmV6jKKOlshuCW/HUkJU8HO77zYG6VvpwOYE5+isWTVh9AI17
         3LzqilixFbQV5avRL3CIFSpfB1YiqRldRFpBUTJs4q4ZkocuDifpAmsYh/Nc1/MR7lWe
         jVzpNfaBf/x91Ogu6waFFBd1D/98bV5aBqVQ/3THkC0Uu5VFRi+QRtFeyp+V7N3+NVUl
         v/atOhdQaTW9tSfiRda70J9zFT+1E1rTK85Qh5jXwJppZ160MRr3BCeIHXt1xWe9eZ0s
         IxyHsADWkRYfvzzBDXtNmhOSficF2jyN5vQLoX61RLRhenq6bwlYWb3+kmq8lSj/3Ckf
         AYRw==
X-Gm-Message-State: AOJu0YzylNHPcNswGITqu6LE66FRLmBFsn0JykU3FNVAlvcDfB89qulb
	6e7Fd3k6NPUeF0PBkbVlapSroYUzabVx8dJ3O1tOcaw93s9Dnw5vtrXAZwmBeqrffMbh7iA20rk
	RjY6QWFptwoH2j3EhApGphhzOkjGji70kNhEw4KJTVzkEWG5BirZ3BdIR75c=
X-Google-Smtp-Source: AGHT+IF3cy/m8EZkr4pNFfAT9xEKwFH441utcoEDIZIt4Pph99Jry+FLr43yvhkydmEE7YI21X2buxeem8+efszEs7YfIE4m8nU9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:42f:9560:f733 with SMTP id
 e9e14a558f8ab-42f95610242mr236007095ab.13.1760434995826; Tue, 14 Oct 2025
 02:43:15 -0700 (PDT)
Date: Tue, 14 Oct 2025 02:43:15 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee1b33.050a0220.91a22.0203.GAE@google.com>
Subject: Forwarded: [PATCH] ntfs3: add debug warnings for run_lock initialization
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ntfs3: add debug warnings for run_lock initialization
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Add debug messages to track when run_lock is initialized for regular
files to help diagnose lockdep warnings.

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/file.c  |  1 +
 fs/ntfs3/inode.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..0eb218a2b999 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -773,6 +773,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
+	printk(KERN_WARNING "ntfs_setattr: testing by deepanshu \n");
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u32 ia_valid = attr->ia_valid;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..6efd2cfe8aa4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// Created regular file inode// SPDX-License-Identifier: GPL-2.0
 /*
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
@@ -462,7 +462,11 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		if (ino != MFT_REC_MFT)
+		{
+			ntfs_warn(sb, "DEBUG: deepanshu  Read inode %lu, S_ISREG=%d, run_lock_init=%d",
+          ino, S_ISREG(mode), (ino != MFT_REC_MFT));
 			init_rwsem(&ni->file.run_lock);
+		}
 	} else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
 		   S_ISSOCK(mode)) {
 		inode->i_op = &ntfs_special_inode_operations;
@@ -1180,6 +1184,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
 		      struct ntfs_fnd *fnd)
 {
+	printk(KERN_WARNING "GET THE MESSAGE deepanshu \n");
+	//ntfs_warn(sb, "DEBUG: In inodde function");
 	int err;
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -1597,6 +1603,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_size = size;
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
+		ntfs_warn(dir->i_sb, "DEBUG: Setting up regular file inode %lu", inode->i_ino);
 		inode->i_op = &ntfs_file_inode_operations;
 		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
 				       &ntfs_legacy_file_operations :
@@ -1604,6 +1611,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		init_rwsem(&ni->file.run_lock);
+		ntfs_warn(sb, "DEBUG: Created regular file inode %lu, run_lock initialized", 
+              inode->i_ino);
 	} else {
 		inode->i_op = &ntfs_special_inode_operations;
 		init_special_inode(inode, mode, dev);
-- 
2.43.0


