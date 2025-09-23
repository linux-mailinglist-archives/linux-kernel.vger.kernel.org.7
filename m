Return-Path: <linux-kernel+bounces-828384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E53B94835
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2340D17EF23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6C30DEDA;
	Tue, 23 Sep 2025 06:11:49 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2C30E0D8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607909; cv=none; b=uaArlCEeh6XxB0yX8d+XEF+MKv16DGHxzl5x7NJIb/pbIky47fJphNttLmv1bevnhuLZJOg1d5QRjxM9TTw/kRXZxon1R+vnsUmsxNpytWtq7om2HJnSnCzamTvtwmt9hsez9CAMXBQNIJFbW7JQQjvQvGNUD77DxbeQaAxla78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607909; c=relaxed/simple;
	bh=l3CIeIFezP3uJv5ibG1AXRYljWvoStznABGLEkBdTeo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dyc/VXo0yz/KQygVsfe9oSOlMkXyqyDmgryPfpdIlGIfA3paHDln0aI9S/p5jHBUJj8JhLm+TJujs2ImuN/XCQpD4Bkf+fkMIb0aPjgbCGKk4Rh181toCB3XiT6Ky7f+eNElXU4fBbZfa9FiHyPDdmYgAxvcn7DXShAk7NhxWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4248adc62e0so38460595ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758607906; x=1759212706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SUB0yOiSUghDGSbfdHE8acwCLX9d753sssq7OJ9RKw=;
        b=iqUELXsAu0kEblUQijWFpZOJT8R24Ky5w23lojHOf/8yqlSpCAoa4rXkgraIByIuFL
         9q3L6oP8CKqR3IToRMlDEEwgIb78qU6U/NTOKP7mVPe6k58mHHySkQ8HwGYonyjkajhh
         kIdmkapTB2PkTVBMD203DfpGXST/7SbVFlYhZLUcLZRUOAF17emFSOF0A3V4rnNOU1ge
         cwSVE+m1A3WE+N+erYwn7uwLxdQCdn2frMB7n81vXLPTcI6bItadZUpYI9gHJ1qqF8Cd
         y34hlNRue5DKSXvW8dBCnpQcbKxjvds6TpmTDsdIh9xXiadkpfXI0gsp8yMJksSUzGOh
         JuiA==
X-Gm-Message-State: AOJu0Ywblwh8072ta0VrTkoqpMjHPU95H4s9SeJl0Wdp3YI9B+xNDo6k
	9IwpCOT6fFvaU+97q4OitkMeRa//8/FgMdWlIdK0j6IvkxLJWD9mxr7moVR983olGuyBiNwT2o4
	zQQ3TO+B8VPUyFXYo7PefRtIo0ZwP8QHHWPIHcuSOMEUT7gw+LThBB/T3gRI=
X-Google-Smtp-Source: AGHT+IE4sMApfTp79ITYZyNi7SMGLsH4UGjlEUI8Y7wqU0Y6HHLiSTCJTSWFSahXVio5v+kCx6u95inl22UxjnZ6CgGrd7N0mfuJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:424:fd76:2a2d with SMTP id
 e9e14a558f8ab-42581ee17f5mr24940225ab.29.1758607906695; Mon, 22 Sep 2025
 23:11:46 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:11:46 -0700
In-Reply-To: <68c9c3fc.050a0220.3c6139.0e66.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d23a22.a70a0220.1b52b.0051.GAE@google.com>
Subject: Forwarded: [PATCH] Subject: [PATCH] ext4: skip inode expansion on
 readonly filesystems
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] Subject: [PATCH] ext4: skip inode expansion on readonly filesystems
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Fix WARNING in ext4_xattr_block_set() during orphan cleanup on readonly
filesystems when debug_want_extra_isize mount option is used.
The issue occurs when ext4_try_to_expand_extra_isize() attempts to modify
inodes on readonly filesystems during orphan cleanup, leading to warnings
when encountering invalid xattr entries. Add a readonly check to skip
expansion in this case.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..67300baa8e4e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6345,6 +6345,15 @@ static int __ext4_expand_extra_isize(struct inode *inode,
 	unsigned int inode_size = EXT4_INODE_SIZE(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int error;
+	if (sb_rdonly(inode->i_sb)) {
+	    printk(KERN_ERR "ext4: READONLY CHECK TRIGGERED - skipping expansion\n");
+	return 0;
+	}
+
+	if (IS_RDONLY(inode)) {
+	     printk(KERN_ERR "ext4: READONLY CHECK TRIGGERED IS_RDONLY - skipping expansion\n");
+	return 0;
+	}
 
 	/* this was checked at iget time, but double check for good measure */
 	if ((EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize > inode_size) ||
-- 
2.43.0


