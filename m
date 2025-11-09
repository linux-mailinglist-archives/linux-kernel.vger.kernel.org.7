Return-Path: <linux-kernel+bounces-891919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5FC43CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84B774E58A9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6D22E1747;
	Sun,  9 Nov 2025 11:57:53 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE712DC76A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689472; cv=none; b=unLKsCJm4woxg69dgNylchjZUppggTm9ZxbioWAz4JGVKknJYH18dm6zB/r1GhwnJ2+Wv9G0zaa/Gx84qvcY/unu8iEWsFmgm6d9TIKakZ7wKNik/C1P3miqZdQCudgvNdBgbqeWJWeRry2Y741HQRA8ZKTQdPNlh7RaiwcbrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689472; c=relaxed/simple;
	bh=LfMZnu81+psAuFKzrx4a2Mnpy+2sXjEY97Tr815ToTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MxGXRUWLPMBeiQJ0b/GZoCLXuGG7rRzRnrdjSKxvPVEeZxcjV7WsDItle8Vo98N+CD4Bnxp86WS1ZdJL2J8UuAUFMSLZYNh0czoFS2r634TISIqcqpBbF/nDHDpRwtzJBEaXXQvcnYZn0ccbA0j7DypWrmCg4pvP9vaKQBHjrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-948a20160ceso19233139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762689470; x=1763294270;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCizcojp8cv7RklSDe9wBDnbbSoXZFb6Y/6xpIwK5hs=;
        b=pa7TrePvK/71q6p8YFnId3hW/h+pOCNC8H8g4ciiHT5v/cjfan2O12QOBK5vOIQERH
         X1FmOMqC7HNS07fZH0N8NdNtiy7CMuXTJCPhbjPpiGmI/vN8xVOVOCeKsC+u9vJ1sJdn
         KCR6F9SGLlvm6Pkk7RvX+HuJ/uzgT89CbDn4xndLxmkgrmB2xty2YLNODsmcMk8eS0nF
         wJKsXsBbmramC6LvTaU0zvxnHA0yU45NPWjmnlRk77VxYGyZWlWhmee6r0JDNMwvD02k
         sxaDLPV1O3oWU9F79DWhz29GltBJL7YPiuyNYid9NAHh/fHWiM8RIDi6R6IuT0AL4+B5
         VUJQ==
X-Gm-Message-State: AOJu0YzuO1yjMbr4bfmOhKhUpNlegTSFmM/7y3L4ZkGp66qcJP8BNsYb
	3PU9kkR5jeaV2yZ/TzuBmf8DenL07SwxxIuWYMts4i6qQbSoq0hSx5tLFHdor9mEwXSnIJjF3UY
	VGu4UuoUYIvXABtF/7X9gci4o89+ykzd4vP8xIf1N+M/KcKZPmZb3mPHPwEE=
X-Google-Smtp-Source: AGHT+IH9v87QuptW1sZz/wNGB7qai8WFWimvcTcn00mZBDa1tyjBcWLdcw5xv0MsSMZDaA2XT8ofhAEQKPQYnEZkuPacHpARxxY+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:433:2341:bc12 with SMTP id
 e9e14a558f8ab-43367dfa2f3mr85236565ab.2.1762689470460; Sun, 09 Nov 2025
 03:57:50 -0800 (PST)
Date: Sun, 09 Nov 2025 03:57:50 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691081be.a70a0220.22f260.00af.GAE@google.com>
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


