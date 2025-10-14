Return-Path: <linux-kernel+bounces-852494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D44BD91BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9196F4068E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485430E849;
	Tue, 14 Oct 2025 11:49:13 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF201F91C8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442552; cv=none; b=Q88zNrirSyMNIMw15Fxfab+DXmdu+khTSiREG30lS7/mzykmdg3+HH/3KEobP5UgkHzdO/X+2yBSJSImt+NA6646D+g6RAAqv1kaSvOmyoSmor2ap8I6RTo53gWrngH4NGXp9l9+HQ4AN+Lxe7D7bYvFYgyKuSjBSsGrw5jDNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442552; c=relaxed/simple;
	bh=fljnQofbLvsZv0I2zeJz4+5/mXzdoPezU+QnY4zkZxc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u4LB9oZIpKYeOU1LzlgaA8TRjx47O8RDa0tev+zeY7r9rEufLdTErNPqkNe9N6UR4lvbSsWmsF6e9VEtBs0C1r4HmHEBo76EL4hAJ8JvikTtDaIilOaLMs03zH9rgq5v8Td0Jyb8gWW5PfC1M6NckdsVk+NeqUwZuXBJpcEddhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42955823202so129715635ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442549; x=1761047349;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wKfBmiTr007nrqFQNabh3dC0O2Zz6Zc6sW5W2sgTuk=;
        b=jqfZ8MTkO/HzUuXLHT05sucsqEvar54/HQPAB+gZHTa62NxIxS4BEvi0qcFp9CNiFu
         lv8x2LWVzppJxYgLopWGgRbUNPmqWJRR0l9ioJeAJKzP8mXlccKoq5N0mFOVbxEN6MeP
         ZIXQsJIt0ESYPG5SzM8ltrVuUYJPN20JFuJaKaOBn0RF3oqRUTK8H6PciSZCvflqxqRL
         TUL3tlnHFULGPXdiNu+KY1SuyJuG7gY1UOE+djf8ZFwfW3SeFLFU/D03PhPji1HaNk3E
         BzCYgEMEcjKs5bZNDAWYHCWYyCqRT4gjkyE9dc7h58SsdpmOkjsMyJZg5nRZAXXI86lX
         Rn8g==
X-Gm-Message-State: AOJu0Ywts7CvLWUWpxqDarlUAb5TkYb2ZjhQYKSu4w8f1TtYXsP3knuQ
	D+2wyW63IOsU8I0rLSv8pnK9B5DAplNSoy6bzGZsgjjkpUyMBz078GfYwSln1/dhbyoNZ7Z9DEt
	UIwEun/9jtHYZ7O8ZkMaQFc2Cv90k0YX7eI5ndB99bbXklOH0RgMTbGKMcLo=
X-Google-Smtp-Source: AGHT+IFoxKPh6J11N4qExfnyC0/938eXNxDxq0rd+Mcj9KbTXNSJXq1cxeV7zh3q3Av35BAhpNjqkvNtOk1XHa6DieaCd9gALZdj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-42f874727c4mr251016765ab.11.1760442549161; Tue, 14 Oct 2025
 04:49:09 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:49:09 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee38b5.050a0220.ac43.00fd.GAE@google.com>
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
 fs/ntfs3/file.c  |   1 +
 fs/ntfs3/inode.c | 115 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 87 insertions(+), 29 deletions(-)

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
index 3959f23c487a..d5fe133f8845 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// Created regular file inode// SPDX-License-Identifier: GPL-2.0
 /*
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
@@ -50,10 +50,17 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	/* Setup 'uid' and 'gid' */
 	inode->i_uid = sbi->options->fs_uid;
 	inode->i_gid = sbi->options->fs_gid;
-
+	
+	if (ino == 25) {
+		printk(KERN_ERR "DEEPANSHU: ntfs_read_mft ENTERED for inode 25\n");
+	}
+	
 	err = mi_init(&ni->mi, sbi, ino);
-	if (err)
+	if (err) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 - mi_init FAILED, err=%d\n", err);
 		goto out;
+	}
 
 	if (!sbi->mft.ni && ino == MFT_REC_MFT && !sb->s_root) {
 		t64 = sbi->mft.lbo >> sbi->cluster_bits;
@@ -407,8 +414,14 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 end_enum:
 
-	if (!std5)
+	if (ino == 25)
+		printk(KERN_ERR "DEEPANSHU: inode 25 reached end_enum, mode=0%o\n", mode);
+
+	if (!std5) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 - NO std5, going to out\n");
 		goto out;
+	}
 
 	if (is_bad_inode(inode))
 		goto out;
@@ -436,6 +449,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	set_nlink(inode, links);
 
 	if (S_ISDIR(mode)) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 is DIR\n");
 		ni->std_fa |= FILE_ATTRIBUTE_DIRECTORY;
 
 		/*
@@ -449,11 +464,15 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 				       &ntfs_dir_operations;
 		ni->i_valid = 0;
 	} else if (S_ISLNK(mode)) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 is SYMLINK\n");
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_link_inode_operations;
 		inode->i_fop = NULL;
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 is REGULAR FILE, about to init lock\n");
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_file_inode_operations;
 		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
@@ -461,18 +480,27 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 				       &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
-		if (ino != MFT_REC_MFT)
+		if (ino != MFT_REC_MFT) {
+			if (ino == 25)
+				printk(KERN_ERR "DEEPANSHU: inode 25 - INITIALIZING run_lock NOW\n");
 			init_rwsem(&ni->file.run_lock);
+		}
 	} else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
 		   S_ISSOCK(mode)) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 is SPECIAL\n");
 		inode->i_op = &ntfs_special_inode_operations;
 		init_special_inode(inode, mode, inode->i_rdev);
 	} else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
 		   fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 is EXTEND record\n");
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
 	} else {
+		if (ino == 25)
+			printk(KERN_ERR "DEEPANSHU: inode 25 - INVALID mode, going to out\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -494,11 +522,16 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (ino == MFT_REC_MFT && !sb->s_root)
 		sbi->mft.ni = NULL;
 
+	if (ino == 25)
+		printk(KERN_ERR "DEEPANSHU: inode 25 - SUCCESS, about to unlock_new_inode\n");
+
 	unlock_new_inode(inode);
 
 	return inode;
 
 out:
+	if (ino == 25)
+		printk(KERN_ERR "DEEPANSHU: inode 25 - ERROR PATH, err=%d\n", err);
 	if (ino == MFT_REC_MFT && !sb->s_root)
 		sbi->mft.ni = NULL;
 
@@ -527,33 +560,52 @@ static int ntfs_set_inode(struct inode *inode, void *data)
 }
 
 struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
-			 const struct cpu_str *name)
+                         const struct cpu_str *name)
 {
-	struct inode *inode;
-
-	inode = iget5_locked(sb, ino_get(ref), ntfs_test_inode, ntfs_set_inode,
-			     (void *)ref);
-	if (unlikely(!inode))
-		return ERR_PTR(-ENOMEM);
-
-	/* If this is a freshly allocated inode, need to read it now. */
-	if (inode->i_state & I_NEW)
-		inode = ntfs_read_mft(inode, name, ref);
-	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/*
-		 * Sequence number is not expected.
-		 * Looks like inode was reused but caller uses the old reference
-		 */
-		iput(inode);
-		inode = ERR_PTR(-ESTALE);
-	}
-
-	if (IS_ERR(inode))
-		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
-
-	return inode;
+    struct inode *inode;
+    unsigned long ino = ino_get(ref);
+    
+    if (ino == 25) {
+        printk(KERN_ERR "DEEPANSHU: ntfs_iget5 START for inode 25\n");
+        //dump_stack();
+    }
+    
+    inode = iget5_locked(sb, ino, ntfs_test_inode, ntfs_set_inode,
+                         (void *)ref);
+    
+    if (unlikely(!inode))
+        return ERR_PTR(-ENOMEM);
+    
+    if (inode->i_ino == 25) {
+        printk(KERN_ERR "DEEPANSHU: After iget5_locked for inode 25, I_NEW=%d, i_state=0x%x\n", 
+               !!(inode->i_state & I_NEW), inode->i_state);
+        //dump_stack();
+    }
+    
+    /* If this is a freshly allocated inode, need to read it now. */
+    if (inode->i_state & I_NEW) {
+        if (inode->i_ino == 25)
+            printk(KERN_ERR "DEEPANSHU: Calling ntfs_read_mft for inode 25\n");
+        inode = ntfs_read_mft(inode, name, ref);
+        if (inode->i_ino == 25 && IS_ERR(inode))
+            printk(KERN_ERR "DEEPANSHU: ntfs_read_mft FAILED for inode 25\n");
+    } else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
+        if (inode->i_ino == 25)
+            printk(KERN_ERR "DEEPANSHU: inode 25 seq mismatch\n");
+        iput(inode);
+        inode = ERR_PTR(-ESTALE);
+    } else if (inode->i_ino == 25) {
+        printk(KERN_ERR "DEEPANSHU: inode 25 found in CACHE, skipping ntfs_read_mft!\n");
+        //dump_stack();
+    }
+
+    if (IS_ERR(inode))
+        ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
+
+    return inode;
 }
 
+
 enum get_block_ctx {
 	GET_BLOCK_GENERAL = 0,
 	GET_BLOCK_WRITE_BEGIN = 1,
@@ -1180,6 +1232,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
 		      struct ntfs_fnd *fnd)
 {
+	printk(KERN_WARNING "GET THE MESSAGE deepanshu \n");
+	//ntfs_warn(sb, "DEBUG: In inodde function");
 	int err;
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -1597,6 +1651,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_size = size;
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
+		ntfs_warn(dir->i_sb, "DEBUG: Setting up regular file inode %lu", inode->i_ino);
 		inode->i_op = &ntfs_file_inode_operations;
 		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
 				       &ntfs_legacy_file_operations :
@@ -1604,6 +1659,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
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


