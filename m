Return-Path: <linux-kernel+bounces-881981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727CC295E3
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBF97346C7D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60F245010;
	Sun,  2 Nov 2025 19:22:13 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E75241139
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111333; cv=none; b=NOLGtK7fA4/zwGWfnfInhOPngmVy2u/KYhDtH9R8zCeiXvMD8OKnI5SkjHvIrbQScwhDmzbIzPD1HYvTmRLddNW57WGkIuF/ki2RC8PQ9AFpuO3+DpmNbXBv57S1X7wjeUcJh6Pzp/Bfmbq7oz4R9qzBPNIdjonV3I5vhqf6fHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111333; c=relaxed/simple;
	bh=WL0a0kSqjQW7K3mpycFiwHZfZfAI+S5VB+TMsYmATRw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ojZQPNeLrHaD1E7nj6zrp28w40HcdT3THsF4yQWTC80RdsPXHzuUq+58RqvSt4I35C3TMd59NPPr2gKGf9fk8rZqlZpMRRSwD/0yS2UpWawZJnzqeKPBXWBZYKJ38WsLo+9gCsF52en9UvLFTia/tIfcqNisy7zFFh6O/eHPPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43331987addso1103845ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762111330; x=1762716130;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13JNDLu8qvOiEEWJeKZ2fPNHCKW+tUEfzGXhNuvHGHg=;
        b=joi1AOMc7rDEBnZN6RbCdWcbE5p/pj+VpN3k7mWyuRLJivXy4zxFaBftEB+AXE5d7y
         TObnqkLHbQfTi2peZcV3V4KSqlfTkwPW0q+tk59PrhRvcxDQAU6PzKv7FW3Lnv3JRJHM
         cfAKym7aHW23JAereecYzo6EnX99oXWtzFCZjroBECMjAsWJyuNRVxp9OD3ysOLTMw4q
         wZsub7klsuuNtR54096hTmYIJ/wp1nT6Or+dPtlT45Hf6726R2nCoAt3gXCCGuhb5JIw
         C1o0gOM9bWvJM/VaexRdIts0Z9Fc1a/U8DL0v2dXbuDfVkQ/HCXphjva8lDdizXN0Xps
         lWRA==
X-Gm-Message-State: AOJu0Yzofq1v4H5yIbcIwrTD04K9j/EtVIrTKCliyI9uJrlB0NWVTMxd
	jly9dstAhuw7Xqo05P2+x7z3WaNrvMT2Ck8fhrUrAsC8DF5lIk5vqKBs3Aw+ckeKylybCQV/DlG
	mbJy93hAI2N8wJnEkNf3W5+j3LsLFNsZzZYlFQ0XKBDY/HMUqJGhAR3jxzRM=
X-Google-Smtp-Source: AGHT+IHz4InqxDMZJqcQywe4mpo8/1R92Nvvdwi8UNsz/rdFJKydqouT+26xUbHJYv4bq9pvoaNZphtg7cEYwB8jdYLbvW4ENryd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:42f:9501:69e with SMTP id
 e9e14a558f8ab-4330d1b64a5mr121045405ab.20.1762111330733; Sun, 02 Nov 2025
 11:22:10 -0800 (PST)
Date: Sun, 02 Nov 2025 11:22:10 -0800
In-Reply-To: <68f9bea1.a70a0220.3bf6c6.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907af62.a70a0220.37351b.000f.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..ee1760305380 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, mode);
-	if (!inode)
-		return -ENOMEM;
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index fff149af89da..6808b1316b60 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -273,4 +273,6 @@ static inline void hfs_bitmap_dirty(struct super_block *sb)
 	__bh;						\
 })
 
+#define EFSCORRUPTED   EUCLEAN         /* Filesystem is corrupted */
+
 #endif
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..cb74904994cc 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -186,16 +186,22 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -EFSCORRUPTED;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		printk(KERN_CRIT "hfs error: next file id on super block is corrupt");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -209,7 +215,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count > U32_MAX) {
+			printk(KERN_CRIT "hfs error: folder count on super block is corrupt");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -219,7 +228,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			printk(KERN_CRIT "hfs error: file count on super block is corrupt");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -243,6 +255,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);	
+	out_err:
+		return ERR_PTR(err); 
 }
 
 void hfs_delete_inode(struct inode *inode)

