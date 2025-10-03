Return-Path: <linux-kernel+bounces-840968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C1BB5D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 05:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C143C7217
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 03:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A92D3759;
	Fri,  3 Oct 2025 03:02:14 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFA12CD8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759460534; cv=none; b=GcsMRPxNvFydCkzl2Tjg2YSCdjbWoSZubkUCKzsk5QDAtxx91LCXlEpUZZ5hxNkfqGPq5943QP+kUJkFVsqCWu1pjLZuR7DZXuySxjFOr51X64RgejGfM5Nkdx391jWMJ6LiKVQ5PsxpAe51FUy4fSU8fiBUjo7iuOURRiiqQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759460534; c=relaxed/simple;
	bh=DY2LpIw+buD76/TQi8/+FFrw7iGIpPfinV+MQ53jhno=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hl2I1scpykHDY3DccelsibCdrH/EkdJDLQ1qqVwk/nfjCAIlr9W+ilpqBUQ2u35aWO8NwviJ0XvoyStPflNurxDZscKsc/DYVNGb6CIaU9Q2UmYVdoknDBhFDcqZBNWt4q7m6Ri8wLY6B5jbC8KkmKeqdokh5c9sXkwmP5VKdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso218592239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 20:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759460532; x=1760065332;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5vs9n9028GGJFsoBbT/p4gNDi1uzSRnj3Xc4sJwfKs=;
        b=IrlhnbpBa11FA1kNtLgRLGYKxVyG+x6kqS0JfKiKccMVa/8m7PgKnk5t19l/gcBIEk
         UM5/QbvDUAPcbAqGd9omAXuQwaEcydM0S/cbxlYW0arnpHwEB37H5Jjiq7WsGjdJgVJ3
         IC+0w4qoD2So/3+EgV8GgDIvWJevsjvou7TEeERkTV0pOoBAhH+72Z6XKLhyo7786O6K
         VQqklNnt4fJePRAauaOybZOqXXeDe2b/FJT9AI5qVlJNdBscw71Vkn8VrNwySSPQEe1e
         czyNaw/TdsW79XjFq7LW2PLknu8ScJMITCfFKutvejBaZliWo6UUyjFfIheKaXKcmgNI
         RTAA==
X-Gm-Message-State: AOJu0YyEb73h9CvDvSSu6pafTNtdHKvTlCTeMLmLTYse8Vwu9a5SQ/xY
	9KI413lKim3CWZ/a7nKZNZr/+MREZTK7GTryuhZ5FE6qZNB4XReM8jTdYTRNJuXX4LqTtGHEokM
	Oii5qan8V6NhROg+70zRl5nJ2wQGR059Om4fgm24bPjt4E4574LSdnR7q3Pw=
X-Google-Smtp-Source: AGHT+IFooqksmvjO0V2F/d3Pv/9g1YYcv+Y+UlvasO3cLgjK9tGYjUzFABd7sUrej7TsH8lEA9pjajpjdTTaLHt/nfr6GfLuUjxD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda2:0:b0:429:4c65:e8f7 with SMTP id
 e9e14a558f8ab-42e7ad7b4e1mr15492035ab.24.1759460531890; Thu, 02 Oct 2025
 20:02:11 -0700 (PDT)
Date: Thu, 02 Oct 2025 20:02:11 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df3cb3.050a0220.2c17c1.0012.GAE@google.com>
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


