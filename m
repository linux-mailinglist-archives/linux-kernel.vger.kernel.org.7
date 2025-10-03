Return-Path: <linux-kernel+bounces-841016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF768BB5F89
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5691D19E46AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCE1F5617;
	Fri,  3 Oct 2025 06:17:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29A158DAC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759472232; cv=none; b=Ra9FLkWQI/4hfCK2GJfYejegLNYs5NVwn9XML/MOWh9RZJvv8T2p8vquV+vUwntJxb1jNplrPmCxZJzHDyg+M9FO233svbeuNg+hYu+hDKsNmFGYFBUWUS81EoTTTHaQAq/0vY+Df5wK3AL5bT32hpyNh/GpA1OYEJIIGrC09VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759472232; c=relaxed/simple;
	bh=DY2LpIw+buD76/TQi8/+FFrw7iGIpPfinV+MQ53jhno=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b9ALsRlI779aJOTNqn17/iNRADA0wj5vMq1PY744bqFVotQg27FvnWVdg6RoCFSOnAmJlAAQviwbPjYb3YrzDMpEDWEW1m49DB/hDCT6uRgBOU411U2iJ0mebB4MsizWD1OgZB7AaNRcueegnUjq3ai0Ol/mcrq7Q+uH+tUFpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42d88ae6e6aso20635035ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759472227; x=1760077027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5vs9n9028GGJFsoBbT/p4gNDi1uzSRnj3Xc4sJwfKs=;
        b=TX/I9ZYYebCt8jCFMt3TySOzTIZzCBBy7vNDf/wBwq/vwtNw+NuLaJW4fy78kf6lLC
         vcM4yT4bBbUjYxqHPZq9FLoIrFQb2/70S4o7MIGOj5uM2zLLvOlO7GZH5W2Lycg+rgCp
         d73nfvi0cDfblm4y2HdzPSIBuVT5+uPEgtqkJFoJIRU3dIZMvJDZ57UfFP5RQaGeD9k/
         H966OePkElLaww6TT1tLmQXrklY51gsiwTDz8lViZiSC8uZQhyqvpZYtZ/7nPcs1DqYj
         iloKH2DlssOBwvnyAqVioBp1w5gQkI8KsfelFlJXbPEN6ILG5zxN+xd+09tqWxr1o7ac
         YmxQ==
X-Gm-Message-State: AOJu0YyitdYQhyKL74oyAbcRX5SPDmqR1U9ga9UviPeYi1gTAw1mfjCN
	DPbLBxQ04v1lACa/Bstex3nVK8nfu8qqIKuU8qi/QISbp3lZpoWifYbBYeJ+TydqnnHju7H+UF8
	++5wODU/nyZy76ffWy4Q3kpc46Fl3SHDChGzvBPHHypgvTto4K27PkD7sVAw=
X-Google-Smtp-Source: AGHT+IGN0CR5RM0gcMakJJbFf4//tFC3Ujc50fVpQ34lyj9FaFpJN4JiJqiGNYmBjmN7yp7m07qqR0vParoupnWxwBIxgT+C6PGU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:425:94f5:5e3 with SMTP id
 e9e14a558f8ab-42e7b220cc5mr24276065ab.10.1759472226753; Thu, 02 Oct 2025
 23:17:06 -0700 (PDT)
Date: Thu, 02 Oct 2025 23:17:06 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df6a62.050a0220.2c17c1.0018.GAE@google.com>
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
 fs/ext4/inode.c | 13 ++++++++++++-
 fs/ext4/xattr.c |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..257e9b1c6416 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5099,7 +5099,8 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
-
+		ext4_error_inode(inode, "ext4_iget_extra_inode", 5102, 0,
+				 "wow this inode has extra space");
 		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
 					ITAIL(inode, raw_inode));
 		if (err)
@@ -5112,6 +5113,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 		return err;
 	} else
 		EXT4_I(inode)->i_inline_off = 0;
+
 	return 0;
 }
 
@@ -5414,6 +5416,13 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ei->i_sync_tid = tid;
 		ei->i_datasync_tid = tid;
 	}
+	if (EXT4_INODE_SIZE(inode->i_sb) < EXT4_GOOD_OLD_INODE_SIZE) {
+		ext4_error_inode(inode, function, line, 0,
+				 "wow! this inode has less data");
+		if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA)) {
+			ext4_error_inode(inode, function, line, 0, "wow! this inode is line");
+		}
+	}
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
@@ -5422,6 +5431,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
 					    EXT4_GOOD_OLD_INODE_SIZE;
 		} else {
+			ext4_error_inode(inode, function, line, 0,
+					"wow! this inode has reached ext4 iget");
 			ret = ext4_iget_extra_inode(inode, raw_inode, ei);
 			if (ret)
 				goto bad_inode;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..9b4a6978b313 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -195,7 +195,7 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 	struct ext4_xattr_entry *e = entry;
 	int err = -EFSCORRUPTED;
 	char *err_str;
-
+	ext4_error_inode(inode, "check_xattrs", 198, 0, "wow! we are in check_xattrs");
 	if (bh) {
 		if (BHDR(bh)->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
 		    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
-- 
2.43.0


