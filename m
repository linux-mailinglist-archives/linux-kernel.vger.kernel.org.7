Return-Path: <linux-kernel+bounces-891988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61AC44028
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76FEE4E25E1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75F2FDC54;
	Sun,  9 Nov 2025 14:29:44 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3D2D63E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762698583; cv=none; b=h290XMyie8/i+2WvuGrka0/qf+kQR2BbPZzwciYYuTRqZ4HKJCCBrM+ityJLa/MO+mg0TY3G5YIMfFAC3S2ay5+BppB23DEwCeyRF3ddwPgxghQdRcw6eWK7l1QdENv98Ps96O3sJ5DzrDlj7PIeKtEHu36UwjnPF6HDHlw529g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762698583; c=relaxed/simple;
	bh=El850s7JwySWKVYInbHEg10TgWEZ3tVf+qoUNbg+B2M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ienuf4CrMNJAl+FEbCGUanHCW3nI1IlumwLtPfQeQkHC1isv7lz/1HKn1i3YIfiCHvrW0OO6vKc5hwwC7O3VoWMxbyPbJ8VlNRri6XG8XgDTxZ53Vb9zmUBfeNH2UF/rtjHezKTdH9DsXPSbxhG+jmti8ItoAEvz2xRqWQylK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so80637945ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762698581; x=1763303381;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKoh+MOfooAHbWdf4H36yFifk8wqW7vCid63G7HG7ng=;
        b=wrgeRvNN2ZoB7AMt4CD383efOAVb04RVX4QIVKDS83z9mhqWC9QnnyAJNkuF5tTsO9
         kM2//CWXWcf/QBiEr9K1l4eHHN1EHaSAioGHGHemn+Cg08/twvzMR8mfJM25fMsfsFLI
         dq1cY+Qxto0y2ctsiH5ritIfBS+/5TUd6wFJM3oHRu86zJQfTyoX8vB6YyzZBCLy/Mx3
         0qNR3+TieN7Jizx2ESSThDPA9uqWNZqUvPFYLMLI3Xk1J6//7nGIxXVyBci3LqmwCWO+
         FXjRqVGFYENcI1inYGkjF+ykREfQ467XkDMEf6oX/PtHolenrPNB1OlqrpHVsSR+4MyF
         uH8Q==
X-Gm-Message-State: AOJu0YwnFtuER40NdqnxVhUVpExU+2speqBGVjuaFDbbKGPz9CIoL6PJ
	An8GmfELgkadPEoikWnljq7nnzJDsRHFJzHXxTy51YJCynkBSUFX/x4vdipQaCulxdLT6LQBlxc
	6aQLKIJs54t1zdwueHhwszDWPx7w28hzaOd8QeOk2pHfn7IV9apPAZI2g+CA=
X-Google-Smtp-Source: AGHT+IGDNTjT9KvZMKVXazCOYUzDls3UtwB26vPgk5TncPnCDRBE1MiBU6c4Ng7JSAeP4lTL5TDJn0HBIBqZC/K5aBWxKkbMi434
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:433:39bc:2f6e with SMTP id
 e9e14a558f8ab-43367e69755mr76375275ab.26.1762698581640; Sun, 09 Nov 2025
 06:29:41 -0800 (PST)
Date: Sun, 09 Nov 2025 06:29:41 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910a555.a70a0220.22f260.00b9.GAE@google.com>
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
 fs/open.c          | 12 ++++++++++++
 include/linux/fs.h |  5 +++++
 2 files changed, 17 insertions(+)

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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..005586e26688 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -987,6 +987,11 @@ static inline __must_check int inode_lock_killable(struct inode *inode)
 
 static inline void inode_unlock(struct inode *inode)
 {
+	printk(KERN_INFO "inode_unlock: inode=%p, owner=%lx, current=%p (%s:%d)\n",
+	       inode,
+	       atomic_long_read(&inode->i_rwsem.owner),
+	       current, current->comm, current->pid);
+	dump_stack();
 	up_write(&inode->i_rwsem);
 }
 
-- 
2.43.0


