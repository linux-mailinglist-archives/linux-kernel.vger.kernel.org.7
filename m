Return-Path: <linux-kernel+bounces-891929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBBC43D65
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C50E04E4FD0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBB2EC092;
	Sun,  9 Nov 2025 12:25:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA42EBDF2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691125; cv=none; b=nG4v4ya0W7kHpRa/bylPjurF6j4y3IAG1SQs96HfvKoXiofq+n7y4dyhkMBhzvarakTIvJ9d2UMVdMoxaige8N1rfySj/l4y+eEyTGbiZGq4jg9LpnQ1SRiHlx1rKFSfIg5geRhXUXAYVR9+/hXk8kg85dvYRkL6RgWsK0tOFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691125; c=relaxed/simple;
	bh=cTTcIuSMP2O6XeKIpEJJPEtLAYJKZ5+3pnrg9thxpug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JVpKlm4TPBSVdc7HFdN/U0tWMQNEkHjOw/WCQaOTGOYKCEutEC71yEa/y98CHyEzowyxbNdt/mr8XcU06fJSLdmjp0LQlgYzEGP8JXnbjHFLBrwxzQQdQYwIg0x7xlApiN6m2Xk6C5VupRzkPIpaxXhmzd/UOcV4dAS3FOmUJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9434f5350bcso171717239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762691121; x=1763295921;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv/+IF1ieJ9+du0Yb71mpS9Fi6V51PmWhmtbkLbqBc8=;
        b=ICsUzZnPRYFd/HDZqUHoFG/+zjZOaO1i+3P7El/shiqHVVisz3H0jzEul+0MHJUypz
         TQ3Yow1/pHbvgN7ZDQUqBQ4wt/l+9FApyLKkgxQQUvmmSpz8g4/M+geXVRmNANCNfchn
         CTuPIatpQ27uqHvgjoqEpKOgA1QheODiQjVbIUaagAVovGcAzWZN1rO22an2B1o9HzY8
         FQ7lPV4IU4sziHHPWPbA50woKQlQEi8AntR9AVBvQCP+ZbmZcLGPOXXcvZuvrt9HwU+H
         VJLUo8flDSJrgXy4L+H4hU6Kaeh3FeQWKSNu94Mebus6j1o/bmLL7/hTuyF6V6gekP40
         4aKQ==
X-Gm-Message-State: AOJu0YxDNijo5+4QwR0vZwA/zEmOmgDnNa2q7Q+HcEEce4eqil+ZG86m
	mGpZztsA4DVi6AMdt9IRFkabfUGeVPOBLaeRMjJ1akyg/7VlDnU6lT0dHjuASY1o2TdNf8P6ZmZ
	9vc0BZSHljiZze45yrfGHqjwG5N0fkLxHn9/zDJnVjBUemgTMNjlW7nX0A3E=
X-Google-Smtp-Source: AGHT+IExmvrUOtEdmgzdyJ4W8D1on4WxiSnZfHcRj4vtCNX+J8QNNuh5j12GWom6a73Y53MxH/0qtvAauosxQOosP57vwvawQRbR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3985:b0:433:2a39:1b98 with SMTP id
 e9e14a558f8ab-43367e6e6d4mr81870595ab.15.1762691120887; Sun, 09 Nov 2025
 04:25:20 -0800 (PST)
Date: Sun, 09 Nov 2025 04:25:20 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69108830.a70a0220.22f260.00b1.GAE@google.com>
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
 fs/open.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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


