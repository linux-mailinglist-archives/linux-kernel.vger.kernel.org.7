Return-Path: <linux-kernel+bounces-891910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D5C43CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03084E285F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA92D5C6C;
	Sun,  9 Nov 2025 11:40:21 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D233987
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762688421; cv=none; b=oVoqtbJ8XsfW7MPZHzX3fchqD8qeaSeMKsg0oMZpPSOK6NF/uy3nqlrIr0cxUWGXE2vovsnF1Zs7THEM9OmUxKxQkH89LZAAsP1QE8VvBp6FJGHMeil+36zvHOfTwo/PcrcFeI2CVluSr6oRMUN/DV7R7oBs4KL/dq9TfTulOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762688421; c=relaxed/simple;
	bh=JrHNDet/7jcfVHo2tKDIZfZS/AbCX/9uasI+948tjKk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GEVghku0R66S4RrGErd7kP6WxUKMZxva76m9OXOLvW1ViLDej/HxPb8eu5Tpbk81VuL5PzkRUIaBemcEyQG6LhMyItejBmxOaLPJ0oY5b2pfLI4OjRzW6eCIccDwZy91Hfu2SKvVx0cuEWDfygFmGC+6IvCub/7Q2XzaSZk4z88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43331f93979so19917105ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762688419; x=1763293219;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4/B0tPdS57HOEGekTg+aaK1PyOIOOMf1oKR91qVWG4=;
        b=n/ADB4t4jR/gKhrijc2VfpWR/EaiVyi92SU/HCw58jyAGI1H+55dt/xekcZkBh83BJ
         5+Nh1W25O47sfaCOYgwVD7nt6AGV0Yy5h9JcZQB1cGcuLTsdE89JSzrIHkLfpJOXX/y+
         s9WTFRmfxkQFmVW96RbYs0O+WOFogiZVsniS8NDaWjz7WvXzpnVr8YMlKIxuata6x6OI
         qQB8xJK2wsa4hdR6xwCtVRXP+mnxbsKBjXEpV+rHVyeZ+WogeZQjKy5SffLhYnbDWZlZ
         eA3ecEG5wRlVbA8aX/qQD/pViNnFFo3/kMNsgaaRjpEO32wx0Roh5+w0lZUsQwTOHg+i
         nBxA==
X-Gm-Message-State: AOJu0YwBZghmVZmsslrMMKgGeHcBAlNMPRfhOYSdxnXomyuYi1vlR/lD
	46mbcgBg9gK5+2yFRYHtKMjBi4RS3YGJSbEkfTWHZdYMA6UyRJUgOaoNkADE1wvdZUhoIP8KXmT
	uvsONZywDOrysFLEW4PnjduIhghXMuY3i4PPCmWJ6EZoQjiC/aasPQNM4qNg=
X-Google-Smtp-Source: AGHT+IFF15MMwOUYrVHhCaafB5UGbqUlc9BrraAfPBef5XG/Pna3ijH5UgrPnzjVZPGf0tUGFDZLbNoG9BNr2//vnMSek/6wuTPX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:433:31d0:c4c with SMTP id
 e9e14a558f8ab-43367dfc2a7mr67948485ab.8.1762688418842; Sun, 09 Nov 2025
 03:40:18 -0800 (PST)
Date: Sun, 09 Nov 2025 03:40:18 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69107da2.a70a0220.22f260.00ad.GAE@google.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

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
 fs/open.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..9d0f88ce56f9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -790,6 +790,14 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	if (!error)
 		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
+	if (atomic_long_read(&inode->i_rwsem.owner) != (long)current) {
+		printk(KERN_ERR "BUG: About to unlock rwsem we don't own!\n");
+		printk(KERN_ERR "  inode=%p\n", inode);
+		printk(KERN_ERR "  i_rwsem.owner=%lx\n", atomic_long_read(&inode->i_rwsem.owner));
+		printk(KERN_ERR "  current=%p\n", current);
+		printk(KERN_ERR "  delegated_inode=%p\n", delegated_inode);
+		dump_stack();
+	}
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-- 
2.43.0


