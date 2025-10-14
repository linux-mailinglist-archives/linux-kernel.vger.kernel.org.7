Return-Path: <linux-kernel+bounces-852323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7E1BD8AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4871349E23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1E2EDD60;
	Tue, 14 Oct 2025 10:09:46 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4532ED15F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436586; cv=none; b=Ee75g5Bh86ET6BG7XafXFOwPifOLisaKQRHW57gCisC8gAduZXqDnTHG1zkd07jYwv68J8+VRvI3GILXunJhH+dvvqPtBBH+ud0jDciKDlGU9YQcMfC8e2FNYJq0+hIu/kCxUmY/2VxUB62Wa082OTLfPZKtKpQKaqU26oKhIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436586; c=relaxed/simple;
	bh=J99FI+lwR/syZ0sNfvEjQfPJK6O2lyLp+Q5k/L3dBM0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IJ0llN3ZOv2vnCvQt9gByRvD6FXYJ28/72JZTbarPEINFhfJh/7w/YAzxHupw8ALgyS6ECSdPQg7AH8R+EPU17rezSUo9DFwY8DxsFvM9Ox3XrGMa9QlkFhbpnr/+bH6ES8ygC0PwMCszyHTPwmGxBgQhPUP/OZSKPo7P8n8xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-927b19c5023so1126202839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436583; x=1761041383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbE6hFyL7cs2WccLSn5D38rYbn63t6Fzd2HO3xX5DaQ=;
        b=hGIivYsUnZK/doPP/SkXyWlGtJ1EmjkfEVNKwssajOzmeNLlvcYAQXu+qbBaWEkCzJ
         oJ7nYC6v7/hrOSLcD0pkwHUEURsj3DvO61AXg5yphO9EJxedgPjkUcscIoVMe4a7vEua
         SbKlSpkw5uWCMBxb/HKxdKfSEszJzl17b9nNnIw3/Vnh5dgSU10BG4ZKPIadbT0o/whV
         57jQiQurarcg/aHgU7PtR5sCxAFoEVhSdcJsyfvOsKghpZAeDY0f9eG8JKv5TXdqA3B2
         +HfduBgx1rdPvQNFxSLsNfXkIPIpAzSqepjklIfWgqafYdPtbqXx0znTqrcT4yWzno0f
         hzoQ==
X-Gm-Message-State: AOJu0YxIahM4DNpcJ01NvDKkyjlLgX88rqdTi6ry0Kfop+hxS3NUeh/P
	gGtuoGmuakSXuRk7Y5ZK6Ay9WFLlUj26iYFFdcu/JGCDyOsXhlQoOBtSuuDpP7D1m5Pw5TnTODj
	NpihZM451PS41+5z+vk6ohpqw4lE4BOBZU56Q77cN286g01uytCO3JrVmMFY=
X-Google-Smtp-Source: AGHT+IHgC1+h32p1AwK+zRQMHL7GQd13Hap4AIqrW+y9pC8yY/v6BOO4Fv79mUfuZOFh5uCzciey/I0tMlTAVY47R5cmw8cooKiS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:430:a65c:a83a with SMTP id
 e9e14a558f8ab-430a65cc7ebmr6703835ab.32.1760436583562; Tue, 14 Oct 2025
 03:09:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 03:09:43 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee2167.050a0220.ac43.00f1.GAE@google.com>
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
 fs/ntfs3/inode.c | 57 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 7 deletions(-)

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
index 3959f23c487a..dafac23e20be 100644
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
+		dump_stack();
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
@@ -529,27 +536,58 @@ static int ntfs_set_inode(struct inode *inode, void *data)
 struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 			 const struct cpu_str *name)
 {
+	
 	struct inode *inode;
-
+	unsigned long ino = ino_get(ref);
+	 if (ino == 25) {
+                ntfs_warn(sb, "DEBUG: ntfs_iget5 called for inode 25");
+                dump_stack();
+        }
 	inode = iget5_locked(sb, ino_get(ref), ntfs_test_inode, ntfs_set_inode,
 			     (void *)ref);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-
+	 if (ino == 25)
+                ntfs_warn(sb, "DEBUG: inode 25 - I_NEW=%d", !!(inode->i_state & I_NEW));
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (inode->i_state & I_NEW)
+	if (inode->i_state & I_NEW){
+		if (ino == 25)
+                        ntfs_warn(sb, "DEBUG: Calling ntfs_read_mft for inode 25");
 		inode = ntfs_read_mft(inode, name, ref);
+		if (ino == 25 && IS_ERR(inode)) {
+                        ntfs_warn(sb, "DEBUG: ntfs_read_mft FAILED for inode 25, error=%ld",
+                                  PTR_ERR(inode));
+                        dump_stack();
+                }
+	}
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
 		/*
 		 * Sequence number is not expected.
 		 * Looks like inode was reused but caller uses the old reference
 		 */
+		if (ino == 25 && IS_ERR(inode)) {
+                        ntfs_warn(sb, "DEBUG: ntfs_read_mft FAILED for inode 25, error=%ld",
+                                  PTR_ERR(inode));
+                        dump_stack();
+                }
 		iput(inode);
 		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode))
-		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
+	else if (ino == 25) {
+                ntfs_warn(sb, "DEBUG: inode 25 found in cache, skipping ntfs_read_mft!");
+                dump_stack();
+        }
+
+	/*if (IS_ERR(inode))
+		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);*/
+	if (IS_ERR(inode)) {
+                if (ino == 25)
+                        ntfs_warn(sb, "DEBUG: inode 25 IS_ERR, setting DIRTY_ERROR");
+                ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
+        } else if (ino == 25) {
+                ntfs_warn(sb, "DEBUG: inode 25 returning successfully");
+        }
 
 	return inode;
 }
@@ -1180,6 +1218,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
 		      struct ntfs_fnd *fnd)
 {
+	printk(KERN_WARNING "GET THE MESSAGE deepanshu \n");
+	//ntfs_warn(sb, "DEBUG: In inodde function");
 	int err;
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -1597,6 +1637,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_size = size;
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
+		ntfs_warn(dir->i_sb, "DEBUG: Setting up regular file inode %lu", inode->i_ino);
 		inode->i_op = &ntfs_file_inode_operations;
 		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
 				       &ntfs_legacy_file_operations :
@@ -1604,6 +1645,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
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


