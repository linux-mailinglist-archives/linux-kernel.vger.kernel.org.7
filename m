Return-Path: <linux-kernel+bounces-852402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DCABD8DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23289424C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C12F656B;
	Tue, 14 Oct 2025 11:02:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223132877F2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439749; cv=none; b=MGEa4lIUiMfWl38MfE9Z/HtNPD+6bAQ6p56YL4CZEuvmMb9ApbLgkJzgTRtK3LRv0fvJWX0o1QUkXxwMnkXyPx3ovahjWVNLENxjLNUIWu04Eurc7/9J9YiETcfb/vNommliHcL8O6w1qYgidgS+oYYJRURhjC/262TV+NC9dzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439749; c=relaxed/simple;
	bh=tZ2LOnCKIM5AGsDTXUmH4H14TGQWt9d4lBEBiIkRt4I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YOAoVs6NrbGip4Tbid7n/S1kMF4d8a3J1gmHDuffRvna+YgQRTlMUTFYi/VV/8mYiJ8hPggVToHEEs85YUqRYK4acmuVzaep7qT2LxpvAVEbtMULvofLR6F89N9meX24RTcdJ+K3Wf9J2gxSDUAKMbwfhbKWGRkybW2Eg6bM95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43095c446dfso21308405ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439746; x=1761044546;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2jWFsdTD/h5vYL6pb2IaDViets6NfKjzKtZzds+8Q=;
        b=sdPiLma84I8Rs7z7uaK98RNOb6f/FAC7gfwDPOS66MMY6/QIIkFHkKZz7XKaT4SG0Q
         cSV61vHDC0tWSu6kgfCJV1MCMKIuI/zepUZGYfedvq/i8tsrgK3oKWpVyLITUd3FYItf
         jv2pQfSpsLuya7g9vFwzn+9PITvX4mDn2Upotf8PVi1dI6Vs83XRvSHy1n5yQysdir19
         nTb4LanXoN108UsOnTDcmNCycgmr6wpkqu4bPfUQqpkSyg9i/qF6zL3sNmB9R4r3ZYN5
         ejNxzEPiwt16DZZkp1Zq9JgG6IUWoWzJD8EZANj4TwCplARNfF97bQh2G70+euFA5wTk
         QlJg==
X-Gm-Message-State: AOJu0YxPvAhhYvo35nqADd80pAIKm4F5ZUpnRj2KzFhkZD8UCmaQT+Jy
	1dDpDLjc5bQ6SXLeF971EuC/LOJ4gpVHdp2q/KCOSf1xtbnT0fSjv4U2gPaPPXmIkc0Wnhl/x+T
	kVQf4ATjV4O4Jpde+ZKQQfNlPoIQEov0ZYi/6gYB1j9VzIlQDg5YqZlP/dE0=
X-Google-Smtp-Source: AGHT+IH6zAY1IJJcnu3w5pIvgTmsnxrhuLsO7j3HV89sKTTNXGWtAYsA7QWpHG8Ag/Ezx9FqcXASBQwYPPtfMTLRu/Qz+6FLfu8K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:430:a53c:a221 with SMTP id
 e9e14a558f8ab-430a53ca43amr10752375ab.14.1760439746151; Tue, 14 Oct 2025
 04:02:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:02:26 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee2dc2.050a0220.91a22.0207.GAE@google.com>
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
 fs/ntfs3/inode.c | 83 +++++++++++++++++++++++++++++++++---------------
 2 files changed, 58 insertions(+), 26 deletions(-)

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
index 3959f23c487a..222c97f7f299 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// Created regular file inode// SPDX-License-Identifier: GPL-2.0
 /*
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
@@ -50,7 +50,10 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	/* Setup 'uid' and 'gid' */
 	inode->i_uid = sbi->options->fs_uid;
 	inode->i_gid = sbi->options->fs_gid;
-
+	if (ino == 25) {
+		ntfs_warn(sb, "DEBUG: ntfs_read_mft ENTERED for inode 25");
+		//dump_stack();
+	}
 	err = mi_init(&ni->mi, sbi, ino);
 	if (err)
 		goto out;
@@ -462,7 +465,11 @@ static struct inode *ntfs_read_mft(struct inode *inode,
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
@@ -527,33 +534,52 @@ static int ntfs_set_inode(struct inode *inode, void *data)
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
@@ -1180,6 +1206,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
 		      struct ntfs_fnd *fnd)
 {
+	printk(KERN_WARNING "GET THE MESSAGE deepanshu \n");
+	//ntfs_warn(sb, "DEBUG: In inodde function");
 	int err;
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -1597,6 +1625,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_size = size;
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
+		ntfs_warn(dir->i_sb, "DEBUG: Setting up regular file inode %lu", inode->i_ino);
 		inode->i_op = &ntfs_file_inode_operations;
 		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
 				       &ntfs_legacy_file_operations :
@@ -1604,6 +1633,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
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


