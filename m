Return-Path: <linux-kernel+bounces-857643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012ABE7535
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA620627CED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EEA2D24A7;
	Fri, 17 Oct 2025 08:57:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068C2BDC0E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691455; cv=none; b=s9YaJnY43mLqZrLPhLyPb3P8Om/XHsDOTEF6nP+bM5b6yLm6ela1kAPEMR/5rbL3+VOla3ds3yPrICDoNIlNkBnVFzCg/Dq6RMfgSXIUrwenUsYavuei28yw6KO+ciRUi13vS6GoA3tUP/2Xmz0lIQKMSb1f+PE042a1wr1nOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691455; c=relaxed/simple;
	bh=+hqDM6+8L/tFzS20limIuvpxVyXOM2NhkElpZjHKKPE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0RFRf0V6c3Fj4LbST35xu0o82LLpdhhGbzem8E805ItY+CQj+RY+IrWE9AWLbzYt+VAhEHHUQCpqAA/ECr0d1/OeKIHAkkD1i419s6GkArUh8ZmFpUpGbQWMLglEjuHq9kKFFiVduzz7Z+ioxHmi63SpQ1qBFniR9WcVWW353U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e4390c056so159017039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691452; x=1761296252;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz7opAJOPtEUpqdbMru/mhdJ8A+K38vy28KXfUcDrpk=;
        b=ex0c1hKOZy6xO3M5Jx+7C2TN7y4QQCWEojAJkTnMxXp1Re3WhmbIh5Tuc9131n3SaN
         UApdeqbzvjUNg2lL1bSf/oR19Qy+ICbI9ob5IKqS3/kATTifvXUyA2dKfvrNKYudW1Sl
         te/gD+QX56TILsoXVPQgYWu2cWulE2xOF5jmIGBGcCF2CKnQHL8FRoevKcxrcK4N9fjf
         0yrM7KHvMXuKVfj4dauCFrmmNuTPzPiXKgzZY6DkIpIF7th1hq/4df8vhxCNFGUsa2TV
         Rtr2NbqgtaLG9tRPqJWq5qKo8cldDRfyW8k5wPtvYUJdaVl7r33n2pDH5cET1x+ZI00l
         VH+A==
X-Gm-Message-State: AOJu0YyBN970BNXuvN290QFwZxSqqSAG5Fd/+NIIgpJWnLObKPSitRM3
	mnSIg3lM5NblbiQ7rP5V6wyZEUDTa7n4VNsX8q77jWwHy3lXT8VW8gPd2iVfGSZhbGS+YDNJsWV
	0uD4zIgYki+uWzWZ2Kp+klML5VKkyRZQO5ALzXLegwcRFyO0EwbYBe491jfs=
X-Google-Smtp-Source: AGHT+IGQAULdiDYxA2qXejzAP/X/svpyitQCOeP81ID4KtMu9z4jnC6US/vdQ6ndiYgbVbCYYVu5vGJqmU3WSVE9s9x/IzXWdsxt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2301:b0:424:7ef5:aeb with SMTP id
 e9e14a558f8ab-430c526b27fmr46130295ab.17.1760691452584; Fri, 17 Oct 2025
 01:57:32 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:57:32 -0700
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f204fc.050a0220.1186a4.0514.GAE@google.com>
Subject: Forwarded: [PATCH] fs: fix stale inode access in chown_common() retry path
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] fs: fix stale inode access in chown_common() retry path
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

When chown_common() retries due to delegation, it reuses the inode
pointer fetched before the retry_deleg label. However, break_deleg_wait()
can cause the dentry to be updated, making path->dentry->d_inode point
to a different inode. The stale inode pointer leads to locking/unlocking
an invalid or freed inode, triggering a rwsem warning.

The issue manifests as:
  WARNING: CPU: 0 PID: 5699 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420
  DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
                       !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)):
  count = 0x0, owner = 0x0

Fix by refreshing both the inode pointer and its associated filesystem
user namespace on each retry iteration, ensuring operations are always
performed on the current, valid inode.

Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/open.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..8672072fb4c1 100644
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
@@ -766,9 +766,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	idmap = mnt_idmap(path->mnt);
-	fs_userns = i_user_ns(inode);
 
 retry_deleg:
+	inode = path->dentry->d_inode;
+	fs_userns = i_user_ns(inode);
 	newattrs.ia_vfsuid = INVALID_VFSUID;
 	newattrs.ia_vfsgid = INVALID_VFSGID;
 	newattrs.ia_valid =  ATTR_CTIME;
-- 
2.34.1


