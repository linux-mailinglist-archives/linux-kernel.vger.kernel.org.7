Return-Path: <linux-kernel+bounces-840101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96880BB3888
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD70320ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7295A2FDC51;
	Thu,  2 Oct 2025 10:01:19 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE72F4A04
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399279; cv=none; b=QfDDQWLGKxXH4Zve5uuz6x+QOKs1qnOESSiS2iqdDg6So0M3q8UGDcGHkau05czmkX0OFyWWsKsgG80WQn2qSFGa2frHIIR53VRypG68fNwSw07bOMUqMAF34fHDylCY++diB08AaH+Re3QxBaeofE5FF0NPWNkQWKePJKFgNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399279; c=relaxed/simple;
	bh=t5adGd/9QenwTBRArbdOKpQYSS1jfz1aS1S3ZgVzVgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JQzt/RsUTbJWrhAvZ/jPVCMt7xOrHqdijIX6rn3DElmbmW1Ld84apWmsxstUDrjW7kDp9QOdKzqtx0CNC0hVj32izYcl/4/0oKPJ3lRqKuJbeTdPBPxZfkbHz8+NFMpaz4hdk1Ao/xARteRgp0nNu0/2G5vB7pfvlbIbZKk/bnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-919d48f1869so214461039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399276; x=1760004076;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EB+lJIQ9cs9+eVEjVz/FKR/apksQabe+P3vSNK3bgLw=;
        b=ZGYYwTtNsMmqHy4nLSitRv69JPGWrJV3H/OtxkCf/S09cQ2T+mi873eL+/S5cZrTVA
         dq3bA4MgYGOB5wMeQjChVDE3vo/m/opdyjXrcUrE/onEVAKDtuECvKsnZZxaigvf5jRA
         Vza/VVykgFlhCFQwJ6BQywXQWJYdUi+gsZ7IO7gZLHSI2dNyDGJKFEHM9GFjQK6qzxcv
         h5ojynkbJ27H7ibtuui308IQ5CcuUnUYldivrTBdnwYdQu11cWdAKPksUHRQvtwsDxqJ
         g+o9ECtJ52SbfrdftjJvSQ3KfV6slgqRjV7bAxlOrwO5nk4per+UzNe5YCIoycGGMGiB
         XYWQ==
X-Gm-Message-State: AOJu0YzIkX5qt4WIHVnlIUVSKA0TDp554cwLenw5pge+LUj9U3yKv5Dp
	+o4R53fi3YA08St/54cqLDlZixHeE8ZDwhqYgGHYVstduSPr+vjK7HX2U2aYo9AHqnGc9ob3hHX
	1V46X8ANr39OaaC5jC4I9wYh0fq488j7m0iATAyWlhQOpZz0FyaC19X1dSKY=
X-Google-Smtp-Source: AGHT+IERnsgZp/XxpC/SVolXewtN9Cfst0TSLQZ1hkuKCI+CT0WxyKvhdRykWuAPLhQoWmni5VWajpBJBpWS2w1WxpKVJcEKtar4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1483:b0:887:638a:29b5 with SMTP id
 ca18e2360f4ac-937aca230c1mr944189539f.9.1759399276648; Thu, 02 Oct 2025
 03:01:16 -0700 (PDT)
Date: Thu, 02 Oct 2025 03:01:16 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de4d6c.050a0220.1696c6.0031.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject inline data flag when i_extra_isize
 is zero
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Prevent use-after-free in ext4_search_dir by rejecting inodes that
claim to have inline data but have no extra inode space allocated.

ext4 inline data is stored in the extra inode space beyond the
standard 128-byte inode structure. This requires i_extra_isize to be
non-zero to provide space for the system.data xattr that stores the
inline directory entries or file data.

However, a corrupted filesystem can craft an inode with both:
- i_extra_isize == 0 (no extra space)
- EXT4_INODE_INLINE_DATA flag set (claims to use extra space)

This creates a fundamental inconsistency. When i_extra_isize is zero,
ext4_iget() skips calling ext4_iget_extra_inode(), which means the
inline xattr validation in check_xattrs() never runs. Later, when
ext4_find_inline_entry() attempts to access the inline data, it reads
unvalidated and potentially corrupt xattr structures, leading to
out-of-bounds memory access and use-after-free.

Fix this by validating in ext4_iget() that if an inode has the
EXT4_INODE_INLINE_DATA flag set, i_extra_isize must be non-zero.
This catches the corruption at inode load time before any inline
data operations are attempted.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..d76800c65317 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5417,6 +5417,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
+			if (ext4_has_inline_data(inode)) {
+				ext4_error_inode(inode, function, line, 0,
+				"inline data flag set but i_extra_isize is zero");
+				ret = -EFSCORRUPTED;
+				goto bad_inode;
+			}
 			/* The extra space is currently unused. Use it. */
 			BUILD_BUG_ON(sizeof(struct ext4_inode) & 3);
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
-- 
2.43.0


