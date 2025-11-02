Return-Path: <linux-kernel+bounces-881948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA414C294AB
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59C9B4E8291
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D6221FB2;
	Sun,  2 Nov 2025 18:07:53 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9D1ACEDA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762106873; cv=none; b=V7PhHjledQ31w74PPw5jJ9d0K79C1egTbbqxYzhr8c2QCKVQLV7S4eGDf56zNm526tDW0krwct84qt/lOKx2xzivbbyh8jNHqGsS0FMtTK+NsIujtXcvyIausopE3BbZ9dcutZQhB4lQm+KkyqTEFP2T8BHxmBMyAjGG9L1FSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762106873; c=relaxed/simple;
	bh=zgTtF9jRRBY+HRWQgiVGw4DKJ8kGILP2jbnc6Q4sdXg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oW/MpTgB9YhpifomYLTgnc0AAiZj/AHXi8fQaC9FAhJghaai4U4/elHaGokJZHhpeLO8JvxK0CACSlbzJEbkPLJn/uNgwsaadVBvxHc3lQhDXUCSaS8ItVtQvMiD5WTD+pdl1LgCirMNhK+fmLkr3m+CdUj5SRftfMG2jQj1iTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945a5690cb4so1236211939f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 10:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762106871; x=1762711671;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXb0d1mbKK0MZiOX5W+56pzGry52mbHKe4supDsmUOU=;
        b=gnDWAp+23YNYkT6P1Xo1Z0rc0CTl/Arp2KLtjJuNVMJhoNKM/juL3CEEoCXbPslHNM
         RtPWSKIiv64s+666Ff8hYAW0/+k7fgzd5146uY4SqltxowMxTAPbo499buQL0iQv6qZ8
         bX40ORhOhreb+eKdFCKaIwkKNjDu6l2oaY7E8s9e3AQ/ZHaMY82H3csxBYl4wtR+yYgj
         /nxX1GTbNv+RD5RQ0HjjhWuVkwj5US5su12EZpPxJ1aWccTbfJOTl6+t6sTIraTQisKT
         jJS1/xlGm0XyNJGDNcjZ6OOJ5urVAw2+K54IruEueaavtIpPDwdT/PUWC7Neo5Vwt4yi
         bYWA==
X-Gm-Message-State: AOJu0YzKQ25faa3R/W6PQr4pGV/GIUDpH/7HxUJaal5oAcAOoJg6vg8e
	jObeCLOQ0Uwz8uKGO1rY85jqtPgMBaJI8KZOV02NzQXmYxxlMOmExJYPtK7ldMCH90g17OmlQc0
	8meFcEt+YHTq0UaLxQg/hsYkwkJ0WLpP/+GkhG0QguGl+FBZ042HTDDnSfns=
X-Google-Smtp-Source: AGHT+IGN/ZMnxI/8alzKq9FB6Fn0GMJn98Av40uh2aFA5YiJEQX5CEimOmxCAkSLLBsR6ymAAAwyxixAyR1fvEP+52DB4SWQJYt8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2683:b0:433:231e:9bf with SMTP id
 e9e14a558f8ab-433232d4ec3mr74723655ab.25.1762106871141; Sun, 02 Nov 2025
 10:07:51 -0800 (PST)
Date: Sun, 02 Nov 2025 10:07:51 -0800
In-Reply-To: <68f9bea1.a70a0220.3bf6c6.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69079df7.a70a0220.37351b.000c.GAE@google.com>
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
-       if (!inode)
-               return -ENOMEM;
+       if (IS_ERR(inode))
+               return PTR_ERR(inode);
 
        res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
        if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
        int res;
 
        inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-       if (!inode)
-               return ERR_PTR(-ENOMEM);
+       if (IS_ERR(inode))
+               return ERR_CAST(inode);
 
        res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
        if (res) {
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index fff149af89da..6808b1316b60 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -273,4 +273,6 @@ static inline void hfs_bitmap_dirty(struct super_block *sb)
        __bh;                                           \
 })
 
+#define EFSCORRUPTED   EUCLEAN         /* Filesystem is corrupted */
+
 #endif
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..ef46a2d29d6a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -188,7 +188,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
        s64 folder_count;
 
        if (!inode)
-               return NULL;
+               return ERR_PTR(-ENOMEM);
 
        mutex_init(&HFS_I(inode)->extents_lock);
        INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
@@ -209,7 +209,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
        if (S_ISDIR(mode)) {
                inode->i_size = 2;
                folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-               BUG_ON(folder_count > U32_MAX);
+               if (folder_count > U32_MAX) {
+                       printk(KERN_CRIT "hfs error: folder count on super block is corrupt");
+                       return ERR_PTR(-EFSCORRUPTED);
+               }
                if (dir->i_ino == HFS_ROOT_CNID)
                        HFS_SB(sb)->root_dirs++;
                inode->i_op = &hfs_dir_inode_operations;
@@ -219,7 +222,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
        } else if (S_ISREG(mode)) {
                HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
                file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-               BUG_ON(file_count > U32_MAX);
+               if (file_count > U32_MAX) {
+                       printk(KERN_CRIT "hfs error: file count on super block is corrupt");
+                       return ERR_PTR(-EFSCORRUPTED);
+               }
                if (dir->i_ino == HFS_ROOT_CNID)
                        HFS_SB(sb)->root_files++;
                inode->i_op = &hfs_file_inode_operations;

