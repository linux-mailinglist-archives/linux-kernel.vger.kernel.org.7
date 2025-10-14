Return-Path: <linux-kernel+bounces-852719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE9BD9B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F383818999EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174EF28751B;
	Tue, 14 Oct 2025 13:25:15 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F45DF49
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448314; cv=none; b=JDT5f1NsjOEpeD2XtulPSN2zkFh6Pl1MzoDj3I9YxLQ2Tp1n8gQs7TAhdrnuTLh84rslHbyu5iDEVIillg9oDXxQy4Vb/mv8TP8fohjB3Is1dxBne1IlgaDsv2dE7seLHa9geRiBzqhYuA0S0lfqw8ZdzUjIU+FptlouXYtEx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448314; c=relaxed/simple;
	bh=a579V2bO0+BZ1IMWxFTxLqjn0Eukhv7mzcdFfiBKkJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iNtzm6Qa3nxLMQlFooBN0gu6Pzk5JJXJ8lsCCVEDKuje+hFhU65zt6iS48gfFbsyth/VoFkF5GR2ag/gGpxjihZjZdztcSdyqxqykYHFr09Ron5GZivWx81qGVKmhyy7184bAcSmuKphiq2JUmRGEusKeXCgr4WxMAzpYCcTUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-91fbba9a0f7so1083063239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448312; x=1761053112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bPB4o/ifG8gaq8dCuVVRnkyTImwnAVmIhKP9lLsdAY=;
        b=Bqm3xrqioR+ZhXoQ1+anH8wCzSTQJTV3ZooYGddpL8m1OLcI0gZvTAd1E+TFQUf59F
         kALuLeJtHlt3O43wOFdKXO7HI6yvrIGT2YpLJJlxEvIcByPiIul1a4qRQsFKOgSdSCkz
         6OlKkGbwzeKKFwHLIB9ni2sHxzsB+PwBG69gzzDeXQfpwU0+VcjrLXVHPYF+ofm298OY
         RVGlXIOX8osYQUzB0+N7fNrcAw5LnhlAEur0oHQsla3S++aA6BIPanYKM5HmV0EuRxvV
         cGhm1nXJVnlwpJQlU2cG0NLuAVGnmLz2tWITiQ0KekKlyI0uyKRWcFh8Y7VTVWxG0l7h
         FViQ==
X-Gm-Message-State: AOJu0Yzhiw4fMesE/2A+fJ0l2Cfwm9ZIYErQoY6nBcEGqAPQF37KhBDA
	N+FBZpB5YkjCSGyr4NyvPLmIBW7miyA+L3JKZQF6WvoABsF00ZLmpFGqbnM7Q+Spcwki+aTcYlC
	cKTzgUlUXIwcXDu46p6YmmUvXuL0rSpiMrOX3iW01uHvqyWFuZhHnaH4z5TY=
X-Google-Smtp-Source: AGHT+IHMK8cawIuhYGNrYM6hl3D1GwfxRyMZe7F095LePIlxKxSR5O6bNvL7Vs+i+2GwqFYG/iSCN8NaOhT6G+GVIRYXDpLZ7L0X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a04:b0:424:8b66:fbdc with SMTP id
 e9e14a558f8ab-42f873fb8a8mr240201585ab.28.1760448312260; Tue, 14 Oct 2025
 06:25:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:25:12 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee4f38.050a0220.ac43.0105.GAE@google.com>
Subject: Forwarded: [PATCH] ntfs3: prevent operations on NTFS system files
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ntfs3: prevent operations on NTFS system files
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Commit 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")
set the mode for $Extend records to S_IFREG to satisfy VFS requirements.
This made system metadata files appear as regular files, allowing
operations like truncate to be attempted on them.

NTFS system files (inode numbers below MFT_REC_FREE) should not have
their size modified by userspace as this can corrupt the filesystem.
Additionally, the run_lock was not initialized for $Extend records,
causing lockdep warnings when such operations were attempted.

Fix both issues by:
1. Initializing run_lock for $Extend records to prevent crashes
2. Blocking size-change operations on all NTFS system files to prevent
   filesystem corruption

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Fixes: 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/file.c  | 6 +++++-
 fs/ntfs3/inode.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..c5b2bddb0cee 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -792,7 +792,11 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (ia_valid & ATTR_SIZE) {
 		loff_t newsize, oldsize;
-
+		/* Prevent size changes on NTFS system files */
+		if (ni->mi.rno < MFT_REC_FREE) {
+			err = -EPERM;
+			goto out;
+		}
 		if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
 			/* Should never be here, see ntfs_file_open(). */
 			err = -EOPNOTSUPP;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..180cd984339b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -472,6 +472,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
+		init_rwsem(&ni->file.run_lock);
 	} else {
 		err = -EINVAL;
 		goto out;
-- 
2.43.0


