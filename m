Return-Path: <linux-kernel+bounces-852969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371FFBDA53B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CD718839FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D92FF65C;
	Tue, 14 Oct 2025 15:24:45 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4D23C50A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455485; cv=none; b=i3P9nUDYga0/84PsXDz1YvobUjeF1TAhO7FHGmexGrC5rT382ELyqU9kPXE3dkdQ2ouHLeGPEY012tXhowcTnShR9TwNq3NGaUf7SuL7hCCc11wmE9LbaPV0KOHC5YeXMxz4nrfZtWpC5vtJpAUKGxIa2Dhq97BbY3fuN73O91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455485; c=relaxed/simple;
	bh=i8btHZCMTtZjqQDQ84zJW0BiA+BbFXHeOXr1LKBiFdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kpAmZI+hdYmCnIZZcnRTSJFC2nI4U+8wFJmR8In11XK16FbKrSmi41umCcE23rhkcj4U0QqPtUnEQcJYYsOz3Xk0aL4V+tfuH9E43oa9buuZvg9mKo0Df3SF0xFB/VQFbj5VN46iQ+KDziKPSsmyDrEvpuj5+9qT7T8/nZ3+I1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257567fb7cso135719705ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455482; x=1761060282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp4pEEGk8tezdbOvms1wig9qjZJ9jc0YnwBjsS4toMg=;
        b=hKrOkHr9lOqP1QFnADBqslQRKqC5PE9++NN2je000oTSQd1dZhV71uBBuKgLuzYnV+
         ujzyIGp8QPdYgVV2j+X360kVpZ1yAYnioWAdzGxZ53ti19iBkdZHY2UlUC+iMNogiFfi
         ZL8fuCaXfsjSwX7Mu+9/gGOj/0jzG8Z6EqvA7aUhX1czl7S+TBGADiJg3sxEvpK/nVxZ
         atNcwbZ8oPoyuB06mcfC+dQuupKiiscgOD452jyDt3J2lwL2QQ4EO2gLIsyHhxmwiN66
         dHRQ5XKMxItbBc8uuPILLGD2fQxJ+yLWY7glrT4Ek3FP9yU70HiuIQwhCX8D5fsl46cY
         zneQ==
X-Gm-Message-State: AOJu0YwDxUMxH0rXvL8y9DW3CiopjMO0cW0JS2ss9IITT/aiRiOdJM8q
	NOWsz9umU8rXieSbIrS7UtI0hOx22CDBUt88cU9K0yXSiMDVvS3MVTGpJt9kwNH2iPjS8Q1bvYc
	1AiPiZJDZaSUs5UWxRzSt+R7X9IlSeemid5tYexSFBAjsy6diex2cApaGiyM=
X-Google-Smtp-Source: AGHT+IFhAB+YYOWfywU6GGNTMFMvzm1m1taQa0yFEduLl5dVdZcdKr19VBuKccpgMUuBd1OGF+Pcy4lyyJ+8370QWnOeu5NVjs4X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:42f:9353:c7bc with SMTP id
 e9e14a558f8ab-42f9353c88dmr231043285ab.6.1760455482701; Tue, 14 Oct 2025
 08:24:42 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:24:42 -0700
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee6b3a.a00a0220.361615.0007.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
 fs/minix/inode.c | 14 ++++++++++++++
 fs/minix/namei.c | 22 ++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f007e389d5d2..e27907fc9bf2 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -517,6 +517,13 @@ static struct inode *V1_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks == 1) {
+		printk("MINIX-fs: directory inode (%lu) has single i_nlink\n",
+		       inode->i_ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
@@ -555,6 +562,13 @@ static struct inode *V2_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks == 1) {
+		printk("MINIX-fs: directory inode (%lu) has single i_nlink\n",
+		       inode->i_ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..8297ee6651a1 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,15 +161,21 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
-
-	if (minix_empty_dir(inode)) {
-		err = minix_unlink(dir, dentry);
-		if (!err) {
-			inode_dec_link_count(dir);
-			inode_dec_link_count(inode);
-		}
+	int err = -EIO;
+
+	if (dir->i_nlink <= 2)
+		goto out;
+
+	err = -ENOTEMPTY;
+	if (!minix_empty_dir(inode))
+		goto out;
+
+	err = minix_unlink(dir, dentry);
+	if (!err) {
+		inode_dec_link_count(dir);
+		inode_dec_link_count(inode);
 	}
+out:
 	return err;
 }
 
-- 
2.51.0

