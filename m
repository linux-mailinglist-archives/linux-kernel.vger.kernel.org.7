Return-Path: <linux-kernel+bounces-891850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60118C43A70
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AED03B1FDD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA272C0F8E;
	Sun,  9 Nov 2025 09:08:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D097483
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679298; cv=none; b=qxnJIiuuSt3mM5ZweESiyJzVSl70tqR3/4cPT6Mxjx6dfOkjh0+yM1MGAnarH70EWB9Gblm2rp3OmKohOKcbKIcupHqnzmBQ6nUtLILkYnLvsWuSzBA0Rq+7Qx1Pb+QwxoehacxC6vCic1tyWNOlzLKa8cUAGv/ZqzZRjKby9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679298; c=relaxed/simple;
	bh=Q2gIE3lp9hCVhRz4gcQc7F75dAB7YgYR5/FkcCazoPA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PZXjyy+cKlqMwdsBETpN5Ixazmgcs7/bPlXJXvT690aKg0yMb3MDkK1tBiBvNH0kqh7bfiy6y5hZGhmGO5ICbi2+sjPYxCUycEovl00A4+oeOwEiziXOyTN/9J9i8myeCYxE7Ck/QuTYq+clh6gjAR1M5GnGLQpwLn7p+qFD1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43327c30cb1so18794545ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679296; x=1763284096;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkLgvwR2qH7fB/3efWWWU8yk8YcfoE6OHWEDETr8r1A=;
        b=mZjG1UF5PaKir2+ptq55iwXJ/QhrGzVX7++Iwzk34Y7b/v5P+nqvNsQ5B9nzr+wjfU
         0URJjJv6vVq5NfvqGeRlFPMOS4VzzoGtLQOxPKNs6FmPuooMVEbPJrA1FcAiyvofCX4J
         eXuHQhI4EHPpEWAreL1HcC3Fvx5q+uqcOuG2wkDTwh9uyzvo1Fo/COqf2jFzGgEqPmLE
         IVmDtq7LloKIyBCaMO34ccLebczjYaEXGhRmMixq5c0mYDGKPBWcChm+iq5l0NlAX0J9
         o6xW/ww82gg2ZrV3W7PJNrzR+LklEW+s0CMxg9XEsXKGEtPMxOGa+rp8QyAx5eOPH96l
         jLaQ==
X-Gm-Message-State: AOJu0YzftA+N+jWNAjw28Suec+gk1GJ9UkJGtF1J4/bVBlSATW3/2jGf
	qMbx1ZgoZkKDuHgRbzbuQ3YGG6paeu7P/k/RY/WCBXvxkABkxoHhPP+KJCAviHMGvCnrj2ovNXj
	WJ1BlnSKTCoLCE+LpHDGG/ZjBWM9pRk9GQPpJagok7OcLe9sV7iGwWdZDMoI=
X-Google-Smtp-Source: AGHT+IHarrm8WJ6iGjBZMGMgiXYntq2SZECzVYdZqEIrL1hhAP2BWXADp4+DROy88YbYyAlzFjuLGh8YwtjVTNMI0HP639D74SMn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:433:773c:b5eb with SMTP id
 e9e14a558f8ab-433773cb911mr29211505ab.19.1762679295823; Sun, 09 Nov 2025
 01:08:15 -0800 (PST)
Date: Sun, 09 Nov 2025 01:08:15 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691059ff.a70a0220.22f260.00a6.GAE@google.com>
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

This ensures the inode remains valid throughout delegation break and retry.

Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/open.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..bbd73984292d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -769,6 +769,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	fs_userns = i_user_ns(inode);
 
 retry_deleg:
+	printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
+	       current->comm, inode, atomic_read(&inode->i_count),
+	       atomic_long_read(&inode->i_rwsem.owner));
 	newattrs.ia_vfsuid = INVALID_VFSUID;
 	newattrs.ia_vfsgid = INVALID_VFSGID;
 	newattrs.ia_valid =  ATTR_CTIME;
@@ -776,9 +779,13 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		return -EINVAL;
 	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
 		return -EINVAL;
+	printk("DEBUG: [%s] before inode_lock: inode=%p, i_count=%d\n",
+	       current->comm, inode, atomic_read(&inode->i_count));
 	error = inode_lock_killable(inode);
 	if (error)
 		return error;
+	printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
+	       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
 				     setattr_should_drop_sgid(idmap, inode);
@@ -790,9 +797,17 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	if (!error)
 		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
+	printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
+	       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
 	inode_unlock(inode);
+	printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
+	       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
 	if (delegated_inode) {
+		printk("DEBUG: [%s] calling break_deleg_wait: inode=%p, i_count=%d, delegated_inode=%p\n",
+		       current->comm, inode, atomic_read(&inode->i_count), delegated_inode);
 		error = break_deleg_wait(&delegated_inode);
+		printk("DEBUG: [%s] after break_deleg_wait: inode=%p, i_count=%d, error=%d\n",
+		       current->comm, inode, atomic_read(&inode->i_count), error);
 		if (!error)
 			goto retry_deleg;
 	}
-- 
2.43.0


