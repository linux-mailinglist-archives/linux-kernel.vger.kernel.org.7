Return-Path: <linux-kernel+bounces-841093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E9BB63E8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DE421910
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B626C3A8;
	Fri,  3 Oct 2025 08:36:16 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24A26F2BC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480576; cv=none; b=pI2CIUn6Nn9MuFKh7uptiDqcWGKMPRvHbbs31P2XYok0TNSmLuyUI8CqeJysPbnI5n/SAnKrWve/kpeug4LRt/78JRHt/YsEhZyZOIcAB/+WXGviH76Qbmiei7x/IdCpjvyZ9+5sa5W4KFcSqI3+ercEoZC5WmjUZhdm0VwWWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480576; c=relaxed/simple;
	bh=DY2LpIw+buD76/TQi8/+FFrw7iGIpPfinV+MQ53jhno=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LhSwgZwTDx3QkUYCOdtZYSVjSKYCtnOwSIq/25sVlLjXO4twYUogcJzi15G0JfMgfgYe5Z2kHXrRHRqjPhuOWGg1eq49J/+zcX594k8axkZ6pgNzhP9FP4ZPQnjHipbbIJRzdemPCi/UnXQzdxQJ7GilInQXzVr8UhW3t6EfnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so22933805ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759480572; x=1760085372;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5vs9n9028GGJFsoBbT/p4gNDi1uzSRnj3Xc4sJwfKs=;
        b=OqudD2jiFWMmZXbgibJYs4YcfX1vHkqoGZ6j396q0xuCS2LB83Uz5kU+HjLEbDx4OG
         lb2INUfFwt5mZ2Zh9r11WmOG8w6vS7WkMiIXqrlFpb/E67uCUDG9XWghF7noV5OyjhI/
         36HT7a0PPCnx/Xu4UblX0dP5cfaP1U+7CO6r5D2LP5EIrDe/CB9wrvHgdGnv2pd+dkRv
         60PU0M0hzgiUW1i+o2fxmQ/5udAj8/I3Dt/SosTHSpNcJz3BKFbmMw3YsHj8Qg2nmA3K
         jBEfuRFcfXgrx9UM2ddhcffLeTBn5PA6U/enewFjHTONQ3TOKZ2H0q1HTHnIPywbspBF
         NGag==
X-Gm-Message-State: AOJu0Yy5i2KOH9ZILH2BhMy7j3OxC2eyF54d0qHJ5AWpzKmZTblbd5UN
	eNwAP7jfZkn85FyjzZWPOCUgjaNvNGsv3EubQLCr1bvkWfT9Iyx5ZZxm7qTOg2k7Ra+nB2Xiyvy
	oOImPAoW3K1JoOF53OSCS85ZTezow5/6a4PL7uOm4QPxjQWadnJ95ya7uyeU=
X-Google-Smtp-Source: AGHT+IE1VJ1glV4FMpaTSjCfQKE9YbI49JVngyUMC1QpNSskbTFc6+fdimigU9iFedC2lJ4DISPZ7hvAINGpgayq8DVRAxTJH/A4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c88:b0:42a:7339:94a3 with SMTP id
 e9e14a558f8ab-42e7aced6damr22381085ab.1.1759480572465; Fri, 03 Oct 2025
 01:36:12 -0700 (PDT)
Date: Fri, 03 Oct 2025 01:36:12 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df8afc.050a0220.2c17c1.001d.GAE@google.com>
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


