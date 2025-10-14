Return-Path: <linux-kernel+bounces-851908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90BBD7985
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E4C3B5958
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5692D12F5;
	Tue, 14 Oct 2025 06:41:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12462D0C7D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424088; cv=none; b=NorooP8nycwslNyxtqPLC8jM2YAsb9et2DRB3/vGNhQRo8i/lHA6CYtZ3umAlEiFRhnSK/wZvOMjws7iY8b9nAntbOj7f2RmmeZWJGAPi3P7+ePfInu171sKkOy0Bp587Hp6stPC2H/CE+LdIFMLZ4hGhbCBdxSPote2OcmOeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424088; c=relaxed/simple;
	bh=xsCA2QA3aByKKN9mzfJtCmvz/r2kEajE37D7kFDURms=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z7flrZl2MWaFQKXt17whbmArQX/0Cd6kcpgpLYwYD0i1oWG/vC6lQSpTtrKvpfH60JYgn487Eutr5cMZM+u2LCEDrRkWMx4rgP6NyonfB1g1gwAbEUUb1ulAscBA8ufKFOscYd14ilsgJ701dvj0/Ppe1ebIe0itFN28lxcTGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso99091085ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424086; x=1761028886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8DQxZ5iEBLeUGYy76vYnItUZbuCk9FL1bC3osdo4tM=;
        b=o3zeNPOdVvM1uGXjpy9AqVeYlJB3+QQtDCqXOeVb9AYyf8CVtcW0wDumCroqf7krLf
         p+YKdein1fsqcPek5b6Tn6HbGGQDGij4+Wp79GnzGTejVZP9n58JhM45O/WH/Csj5jVU
         USRLsms/VxFNq8IwoJ1+e4rRwkGTQCwDcrIw/glki/NBJvTTyEfAbdndSn/OB+O0tGP6
         vnaR3b7fke28wLHBjoEplEe0BId25QFvBgp7Ag+IhT3piiIP+5z8MKJOPN8hFB5oH4OK
         faHZsfAf+NI3r5DbDd/mb8pFF28D3BaiyS7dwpuGLcYD7WNquqGYTFk71m6dRNHBPWCx
         ytMQ==
X-Gm-Message-State: AOJu0YwyVtyxdbSvOYrxA+ABsR7uro91jNaBfjnr45N6hN1WmQDD1m2x
	LMZE+jr3zO5+mBMG3xW9CfC1z/4KZwdazKX5FuPXpSQoLvkRDNnNifPhZL81Ky6KM0kRiqMkbOg
	b+1q62QMoBtV2rgUz4/4CIDZxrqleFKm+OMYOHTGTzs+sVdrsrJsAq+gn9n4=
X-Google-Smtp-Source: AGHT+IE677NfgeBMNrSzfFfGjLUvejb0pttkfKUpctLjPLyHJlfZMsoZGnIpVjhAtiaPKViUhyDmXOMxtNLerAoKyz/lEZxplqrv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2501:b0:425:8d77:547f with SMTP id
 e9e14a558f8ab-42f87362767mr211787735ab.5.1760424085736; Mon, 13 Oct 2025
 23:41:25 -0700 (PDT)
Date: Mon, 13 Oct 2025 23:41:25 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edf095.050a0220.91a22.01fe.GAE@google.com>
Subject: Forwarded: [PATCH] ntfs3: initialize run_lock for MFT inode in ntfs_read_mft
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ntfs3: initialize run_lock for MFT inode in ntfs_read_mft
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The run_lock rwsem was not being initialized for MFT inodes when
accessed outside the initial mount path. This caused lockdep warnings
when operations like truncate tried to acquire the uninitialized lock.

During initial mount (!sb->s_root), the MFT inode's run_lock is
correctly initialized. However, if the MFT inode is accessed later
through the regular S_ISREG path in ntfs_read_mft, the condition
"if (ino != MFT_REC_MFT)" skips initialization, leading to an
uninitialized lock being used.

Remove the MFT check so run_lock is always initialized for regular
files, ensuring the lock is properly initialized in all code paths.

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..80d80dfad308 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -461,8 +461,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 				       &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
-		if (ino != MFT_REC_MFT)
-			init_rwsem(&ni->file.run_lock);
+		init_rwsem(&ni->file.run_lock);
 	} else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
 		   S_ISSOCK(mode)) {
 		inode->i_op = &ntfs_special_inode_operations;
-- 
2.34.1


