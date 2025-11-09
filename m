Return-Path: <linux-kernel+bounces-892013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB58C44155
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 16:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1557D4E633C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE11D799D;
	Sun,  9 Nov 2025 15:16:13 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287682EBBAA
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762701372; cv=none; b=TnSm/ijZJMvWzsamneUqeaY6nsKEWcvO9KMDBcElNCSgRVh/u7XxNcEO5UcBC2iFZI/kZ5/ls1logEfUcoBPodV1tBUUOfbLFznmwXNehXSrhkLs0WeGOOPtlKG7TMNcBZBXdM3X4u/7jvQek6y4XlC/4nulWhe3sCgrmntWDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762701372; c=relaxed/simple;
	bh=50xjl0tdCp1eXb5sD/1a5GX+U8Dq3v1oi0/SD7mNPWo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JYUzygZs07Rbrk/mCVqR1h5Ta0fJkaR+KqtdR/l21NxHwupjh3vAz2zydvK4WE9KKZpBBPeEXDHnOzd9Z3gvTmPd4R2H0z53pJRhO+an3uCaoxfDhmiYQk1THb1cmtVZvDViQGKw3P8Gd+W8UqSJXW5QnYA0Dm5WGFDXtcMH7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43329b607e0so38380745ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 07:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762701368; x=1763306168;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PlEUa1PiuST6rG63+D/5294jUbY5YhJU4bLLRPF3wo=;
        b=gWTFR+RX2OwGYCy7cSyA0wGFukCHtf13hqPBruBEzDe1WvCYWEqcg7N5r49LWeUou5
         UDJbHgSEudAeOaycJjh5ndPxoCjloGB4NZ0MNkZY9AeHXhZAdYxHruQUzxrGgQal8E7O
         ZmJRg2Bvwk93QzH7gpziqN0E0J0UsOePZlSZyeFa24XVMI4smJ8ary4Cg8OEq3O/3Ryo
         L9hvemSH9Va7Qi1o8S38QepzdPVfoKBuEzCJw6HojajEbg2bZI5Sj0fh32sHKGGcO7K4
         Hbi36vZvNQ5AZjiwlxwOZqzXd2BKB0esN8UBQS8seaJAyBsvAHkOIcTrf+5YNDdiH0DD
         MJQQ==
X-Gm-Message-State: AOJu0YxQrDZb0igewcFIf0ap9Loqh9uNq9QiUoIbFpskTM2rahmx8CIo
	k4eryRiDEFXt53uNDPORYY7WwfWAqRGq6lqP96LpWeTb/lcBy5xKNnfkszvbavG2xfTDAnxQ3aK
	t4vAGjvR8vbmGbRYfszQIlFYg/QvMtuU7WrhZQ+mcNnp1yJy2iGODd8mEwnA=
X-Google-Smtp-Source: AGHT+IHofZj5IKVGWyF1vgkilHH7ptgavgN1y7mQ/UjeyBDyLDb7lBxOVmA4x+RSZoFejkmoBmCOg6Flhk3nNgmu5s9dMg9laisZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:433:4f9c:96a7 with SMTP id
 e9e14a558f8ab-43367dd8073mr85038605ab.10.1762701368301; Sun, 09 Nov 2025
 07:16:08 -0800 (PST)
Date: Sun, 09 Nov 2025 07:16:08 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910b038.a70a0220.22f260.00bb.GAE@google.com>
Subject: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common
 delegation retry
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] fs: fix inode use-after-free in chown_common delegation retry
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The chown_common() function has a use-after-free bug in its delegation
retry path. When break_deleg_wait() is called, it internally calls
iput() on the delegated inode, potentially freeing it if this was the
last reference. However, chown_common() continues using the stale inode
pointer on retry, leading to operations on freed memory.

This manifests as a rwsem warning where the inode's rwsem owner field
is corrupted:
  DEBUG_RWSEMS_WARN_ON: owner = 0x0

The bug is triggered by concurrent fchownat() calls and is reproducible
on GFS2 filesystems where delegations are common.

Fix by:
1. Re-fetching inode from path->dentry->d_inode on each retry iteration
2. Holding an explicit inode reference with ihold() at iteration start
3. Releasing the reference with iput() on all exit paths

This ensures the inode remains valid throughout delegation break and
retry.

Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/attr.c |  5 ++++-
 fs/open.c | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 795f231d00e8..a45d29032283 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -418,6 +418,8 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
+	printk(KERN_INFO "notify_change START: inode=%p, owner=%lx\n",
+	       inode, atomic_long_read(&inode->i_rwsem.owner));
 	umode_t mode = inode->i_mode;
 	int error;
 	struct timespec64 now;
@@ -551,7 +553,8 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		fsnotify_change(dentry, ia_valid);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
 	}
-
+	printk(KERN_INFO "notify_change END: inode=%p, owner=%lx, error=%d\n",
+	       inode, atomic_long_read(&inode->i_rwsem.owner), error);
 	return error;
 }
 EXPORT_SYMBOL(notify_change);
diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..e5ff4d052f80 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -787,9 +787,21 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		path,
 		from_vfsuid(idmap, fs_userns, newattrs.ia_vfsuid),
 		from_vfsgid(idmap, fs_userns, newattrs.ia_vfsgid));
+	printk(KERN_INFO "After security_path_chown: owner=%lx\n",
+       		atomic_long_read(&inode->i_rwsem.owner));
 	if (!error)
 		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
+	printk(KERN_INFO "After notify_change: owner=%lx, error=%d\n",
+       		atomic_long_read(&inode->i_rwsem.owner), error);
+	if (atomic_long_read(&inode->i_rwsem.owner) != (long)current) {
+   		printk(KERN_ERR "BUG: About to unlock rwsem we don't own!\n");
+    		printk(KERN_ERR "  inode=%p\n", inode);
+    		printk(KERN_ERR "  i_rwsem.owner=%lx\n", atomic_long_read(&inode->i_rwsem.owner));
+    		printk(KERN_ERR "  current=%p\n", current);
+    		printk(KERN_ERR "  delegated_inode=%p\n", delegated_inode);
+    		dump_stack();
+	}
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-- 
2.43.0


