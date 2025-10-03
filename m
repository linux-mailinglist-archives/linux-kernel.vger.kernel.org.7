Return-Path: <linux-kernel+bounces-841128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DCEBB652C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC77C344B12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947C28643E;
	Fri,  3 Oct 2025 09:09:45 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF617A2EA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482585; cv=none; b=eNH/hJOoujW8DfOq/wsIMEidw04IiX4KfelqVfC+83WSb7CpPy9yTXOsPtuBeAcSPw4ByOx1i0zq3JI1MPxKmWxiwZg+VJeqp7KeMmVy3pBTvN6Q0xFxRres7Lf/mzKbpMnbCzkhUrZqUq8LLTZkUcFyqjStuLJYIZlznUnP21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482585; c=relaxed/simple;
	bh=DY2LpIw+buD76/TQi8/+FFrw7iGIpPfinV+MQ53jhno=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mEqhl+Rleo2pA+NYz52Xh/ujyalrH4q93mugNPdR5VyALEG+teLqMsScIqv3P1OjF5+4OUOw7ULwaDFKveCFAjBBjVYTo/roNsc9mFbC7tSJTiOFtlb9pCpSpOUXN2MOk6jE5fmPgw0bovVe+qHk2OlGtj3vYnMk4XihOm0qBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42486f6da6fso25755485ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482583; x=1760087383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5vs9n9028GGJFsoBbT/p4gNDi1uzSRnj3Xc4sJwfKs=;
        b=qHn7gZqql14c7+QWfPOKePXuX9vBu/hJeerb0D8x6+7EU195B++gUwjLz25oEV1PjO
         eBQ3SU0+lI7StDZI4/9YM6ZxZn8lKefCtUjzdMglo0hz50mHcW7WXaMATS7onQeYLekb
         7DzUUks+Hw++ditnf+4CL86/HrLz+1TO7aKtmprm4nazWtk2mDO+q9VsYl7urdPDfD6N
         Wplcm7PQSwULZhq6s7LHhgAN5JiTeWTHSJTiiwwn6fMMVy67jg6GlyqTA0YBF9mCS+8N
         bbkGSMqW/+x3fsG1TBFo8ESVuij/gCn8nq7m8OOd/WQBL2BzFMf51l/aF2ZQZVN40tIt
         oOAA==
X-Gm-Message-State: AOJu0Ywg14eKXxcbzVWSZkeUFTx50cAFJZIoH9h8rDj6VX4iPMJkui3e
	eZhEXTLorF2JnCmY4Paq/9/sXOoBHRQjcC1ITuHtmrczx2Vr2RgmSFlYzdUnAX88q1ZHpP5HVKw
	jxmjD9i0UWnG2X2i8gIMNf41Mr+ijWlnXkZFRS2rl4RopPF53TIxPsc8l4F0=
X-Google-Smtp-Source: AGHT+IF/ZRqbeF3dBvGIizhSZNuUa4WocT0fl1nKliIZVx0A+oL/CANbcn1McCDjJ4TujZN3rBjT67+Q/coXEA835J4lKyY22zWp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-42e7ad336d6mr30029435ab.13.1759482583035; Fri, 03 Oct 2025
 02:09:43 -0700 (PDT)
Date: Fri, 03 Oct 2025 02:09:43 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df92d7.050a0220.2c17c1.0020.GAE@google.com>
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


