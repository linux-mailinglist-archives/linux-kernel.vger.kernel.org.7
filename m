Return-Path: <linux-kernel+bounces-891958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF9C43E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21203B287B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03362F6933;
	Sun,  9 Nov 2025 13:27:46 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A034D395
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762694866; cv=none; b=IWT44Qv0dkb4gB3pxSBigHntjv0EAK0LEl7z1NyRzVlI+/1Kuyg/nJC+MmRoN5meqnyS6xgNi3cT41Sp6SX8KAN1dX29ThJS1kY/g1/O1NS32DFN4TQ5oKvxRWEaQr8sC1wnU0N0IYpWZu5ERw6r+4vhzecmcjXRU39NuN2rGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762694866; c=relaxed/simple;
	bh=b/rGwfYereAWWCa21aLzql4pE4k3JAXEN1oChc63HH0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=APVDMLNMIhyR51Jfdk6ZsJAIg/sczeKOPVUUI+WwimQkMs5OfXV1+unolrn6NcthvVY03/b50af2D6c3DdoM9jl6d9TCb5Wuuc00yeqTo7rm/e1rofnrhE5fxpjIc+wqtm+zX9PRvLky3nImHftshqnM6svciFwDLWtmJa5pdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337e902d2bso1484545ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 05:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762694864; x=1763299664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29lLnYKRkWhL7gcHrrn70CmAVjWazEwQ/j0AqKgV5AY=;
        b=Hv1X+fhnaLj1TjiyaeE1ceZX1mo3VXoqdfB2/LlEPrhDY9+SUPZJwaq3ov5+y5jRW0
         bFdUauy00HhlDT6RkvOUsxNlzQerfrt2SIoq3BgVz+z0hy7PmSYdHtwaOeONjmENMWkg
         Uwgc2dtgdFQnLX7FgASTSCIo/RjAS6dsAtRx0BKXUMYNRWWe+9I2HxX4eeDwfqwiOjd/
         H2Dymjmufv2xPPdedHUzVjSFWunpoGu9213J4O0LPF4lH1H1tO11IFguJyulr4NRaqDL
         iQgjUozNP3Qcvk0Kk4/M7MwAhp5s6s9yzwSCOrP1giM1+Bm3feOXukCmbfRu9boFHgmZ
         ISdA==
X-Gm-Message-State: AOJu0YypHw97Ar8ONjLT0FQJDQOW1nPdE6c/1YafAjSplQgLDntXVgNk
	nbcDGH3H9FY+Wm36ABl4AiM1F8vF7ayxWdQ7UWH6a/nOYrjjWDRFXwqJOkt0Ag9+tEz/hdSvcr7
	zx0UgniwL97oZao3MthzIJY6nR45ZJ4rCsBvnAeN4BPRNfNw8UzMc/JeJmqU=
X-Google-Smtp-Source: AGHT+IHFlczUW+xcT+kUHWuDnrl6FYGDj+K2JhUkGIdxoeUjY/N3zhEhc0n1hl3TcAo8P4CDvQ1EaG7qzZgq7Rpv1DtMlCRKgYKc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:433:3487:ea22 with SMTP id
 e9e14a558f8ab-43367deafd7mr86797315ab.13.1762694864032; Sun, 09 Nov 2025
 05:27:44 -0800 (PST)
Date: Sun, 09 Nov 2025 05:27:44 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691096d0.a70a0220.22f260.00b4.GAE@google.com>
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
index c895146c1444..84f7267aac3d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -987,6 +987,11 @@ static inline __must_check int inode_lock_killable(struct inode *inode)
 
 static inline void inode_unlock(struct inode *inode)
 {
+	printk(KERN_INFO "[%d] inode_unlock: inode=%p, owner=%lx, current=%p (%s:%d)\n",
+	       count, inode,
+	       atomic_long_read(&inode->i_rwsem.owner),
+	       current, current->comm, current->pid);
+	dump_stack();
 	up_write(&inode->i_rwsem);
 }
 
-- 
2.43.0


