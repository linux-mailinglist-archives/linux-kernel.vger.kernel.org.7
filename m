Return-Path: <linux-kernel+bounces-891807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A3C438AC
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 06:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED18188C7B4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 05:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451AD1F4C96;
	Sun,  9 Nov 2025 05:02:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37564149C41
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762664548; cv=none; b=iVkg/P1qtlUl+OGXWDJya9cSjqXitypGKshVlg1noxUmhaRoQ7N/P9sqmMjwLEztNbH8hcgdXM+qXLGAfzPRkMybUVY9tem8/GO0/Ltg1bTJ2+LNMUF+fEiXwa0iHUWMu8NZXjK+gfdGQP4/BCV791FIPGMNqqG1zeEanaH2/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762664548; c=relaxed/simple;
	bh=zp2+xhIjF9L50xQ1pEkXO59r4m/nKhdozZDpXHxHt7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KwcLhzA6ohd4QnwT4EhajFoBDIX6v4nHXbA2pIN772YPrG6/GbcQ+L57UKBxa/sM6QhmXLH8B6eGwOL+QHJZmaJEzW4PTQ5/CS9nObk79Jz/38kn11a5k3n+6mgh9xRJOJFGd2UTJ65XsdJXZNbrZAzCk3VqiUJ0Bu83XHZroRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4337b5c3388so6687255ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 21:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762664546; x=1763269346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBOMKh52uFHDxhD4EmVlsejoiNxQk2wdkXVLGnX0t8o=;
        b=I2FpiiR7WAjuh5u0TQGtmpJ7cbwsUwzX0e2mW5pq65nyYKS2Wv1Oc8a80QekN+rxlF
         TQI4/V8gPcBnMBlYm1+Kb97dcQdriRe95wKrJCoqcpM3yfr2yTPnFm2mMi+l86gffSvg
         irJckhURqyxpdpMRIIys23Nztycz3xKBPsBJlWFyDe6OE+st+flM3c2zqNuCvcPQl4rG
         RtYWvWi104U24rpH3tmexv7+ydONs8V3aRY4Ki31572A2B8fSpBooFxO2PTJtY+C49gr
         H2O+4Vo64CmzROZU5JAG6kg1mafcxZw4ufnjDJIXfWqDanj3tDgqTUk62N7aknebEDtv
         dKOQ==
X-Gm-Message-State: AOJu0Yxfp95pAQ1tr4K6ImT9BIjyOGSa+qBNToZGJc9C/eR4lPTM+yiF
	NFd6hZ6q6wMDnPbYn7CLWrFUYIHTDqxAj1fZwSAHoRr7RPAQD9pdTGE/2q1djJzRBvBBUaBsa//
	3w8FihM3epFCD1DPe53oShMmdB3XvpjX58FDeIrSp9I3VyL72LcJ0LE7QJmI=
X-Google-Smtp-Source: AGHT+IEDQ5nNS8j7hxQxPO+sx8g4SYnNd0N8VDeCa7+gC9socGYW5kQ4c6jrrtLQWiBcsJj9Z69aHsN47y1aEE6oydP4SlqiPSD9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2581:b0:433:7a7c:e29f with SMTP id
 e9e14a558f8ab-4337a7d0856mr11562535ab.21.1762664546358; Sat, 08 Nov 2025
 21:02:26 -0800 (PST)
Date: Sat, 08 Nov 2025 21:02:26 -0800
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69102062.a70a0220.22f260.009b.GAE@google.com>
Subject: Forwarded: [PATCH] fs: fix inode reference leak in chown_common
 delegation retry path
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] fs: fix inode reference leak in chown_common delegation retry path
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The chown_common() function can trigger a use-after-free when retrying
after breaking a file delegation. The issue occurs because break_deleg_wait()
calls iput() on the delegated inode, potentially freeing it if this was the
last reference. However, chown_common() continues to use the stale inode
pointer on retry, leading to operations on a freed or reused inode.

This manifests as a rwsem warning:
  DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
                       !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
  owner = 0x0

The warning occurs because the inode's rwsem is in an invalid state after
the inode has been freed or reused by another thread.

The bug is particularly reproducible on GFS2 filesystem where delegations
are more common due to its clustered nature, and can be triggered by
concurrent fchownat() calls on the same file.

Fix this by:
1. Re-fetching the inode pointer from path->dentry->d_inode on each
   iteration at the retry_deleg label
2. Holding an explicit reference with ihold() at the start of each iteration
3. Releasing the reference with iput() on all exit paths, including before
   the retry

This ensures the inode remains valid throughout the delegation break and
retry sequence, preventing use-after-free.

Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/open.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..a564f05c0c91 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -755,7 +755,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 {
 	struct mnt_idmap *idmap;
 	struct user_namespace *fs_userns;
-	struct inode *inode = path->dentry->d_inode;
+	struct inode *inode;
 	struct inode *delegated_inode = NULL;
 	int error;
 	struct iattr newattrs;
@@ -766,19 +766,27 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	idmap = mnt_idmap(path->mnt);
-	fs_userns = i_user_ns(inode);
 
 retry_deleg:
+	inode = path->dentry->d_inode;
+	ihold(inode);
+	fs_userns = i_user_ns(inode);
 	newattrs.ia_vfsuid = INVALID_VFSUID;
 	newattrs.ia_vfsgid = INVALID_VFSGID;
 	newattrs.ia_valid =  ATTR_CTIME;
-	if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
+	if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid)) {
+		iput(inode);
 		return -EINVAL;
-	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
+	}
+	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid)) {
+		iput(inode);
 		return -EINVAL;
+	}
 	error = inode_lock_killable(inode);
-	if (error)
+	if (error) {
+		iput(inode);
 		return error;
+	}
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
 				     setattr_should_drop_sgid(idmap, inode);
@@ -793,9 +801,12 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-		if (!error)
+		if (!error) {
+			iput(inode);
 			goto retry_deleg;
+		}
 	}
+	iput(inode);
 	return error;
 }
 
-- 
2.43.0


