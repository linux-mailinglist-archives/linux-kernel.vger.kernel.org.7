Return-Path: <linux-kernel+bounces-840915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F0BB5B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1551AE398E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77F19DF66;
	Fri,  3 Oct 2025 01:07:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B822EE5
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453631; cv=none; b=EUJf7UmGAPcXD5eZxQdFdXBHBQPPgR846QIWWq/dAEM+c/rKVkfXsxsUfnenmLgirupQ1aaiXDdbPDAgq8ljIERGUB/tTM83uoFo0xJZNpGILnjASGjeq0bwmmkGQ1DM37vsL+X9G+1QelABia69pU7fPZQte2m1ca9vtCUu7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453631; c=relaxed/simple;
	bh=d3a8T0QbVMhjGOCztSXjtMcJKWobAhRPxLYciLIOa7Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iLZSS2SBOWEtibbOJOq/SFwYDILGoWas8lX+l8tdt6FLVhd1NIwswOqhhSV6uwGY7RlqbhNF5A/1jVSbUKRtRefRGNzn+VUY+zETk2sAxRWE74g9hddAxvQFn2+XsEwzqAYOYsoQSSi3rWLiPTAL8PzSt/6glnAIGcAXILx07eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-911c5f72370so214690839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759453625; x=1760058425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JskjAC5lkX5vBxHbA2UfDdyzJPYJc29fyXEjgYdNr1M=;
        b=e7ZSqK0yAglbABi+sgTEFajjqPsKzSG8Z/2IUBkGdVRXHFQyYFMpVXFI9WTeoW1+63
         1CAhtBkeEknokqn1oFne81aEtiw63fjt4Ca1FakBPUi2YkwqfvR4rjeNOS6atus2a30o
         fu77jLPs13IRSfxW56+LfFLbRCcVhVIEiAVowaFeOfSzaVv+xFExFy9xTnkDjEBhgt1e
         LFgIliESx/UwSGJVloKzv6d64mZj9Oxw3aMxl1S4XdjRA8HSQWlrO1d9DR0wvmsiQFLk
         sSQE8Kl/xiU1ihUFVZNSQqYHEvaZo9l/jvw3M36fuW9JxZF3ng6tIh+uYNuawPcs4xtV
         rK1g==
X-Gm-Message-State: AOJu0YzvUfdFy0Um0OY69z7r0IyG7lPAF+EpQl9KQe9WX1fv0w7QDVqi
	ViQ6kaILhbZtCnuSg27L9JHBirP2PCzbp9OP2UCD4rH2esjcHnh9YJ0MFrTcplrOuI0ZFLMSaL3
	xuP2jbQSE4vpt6wWPDhqaX8aqPLJ3f4Ltr7Q1CRuI7LcGaAsl3coAV3jHGDU=
X-Google-Smtp-Source: AGHT+IGX1D3JyEfz2lIMBlT0+ArQROKefAei0dOSafx2KkazKPN/1ADIVMx9iPn/ZktDWJdDiPrvGLbrkCvHFSSCdPEaqqElfmZ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:424:8b66:fbdc with SMTP id
 e9e14a558f8ab-42e7adac357mr15226065ab.28.1759453625442; Thu, 02 Oct 2025
 18:07:05 -0700 (PDT)
Date: Thu, 02 Oct 2025 18:07:05 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df21b9.050a0220.2c17c1.000d.GAE@google.com>
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
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..8682ee8f1e50 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5414,6 +5414,13 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
@@ -5422,6 +5429,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
 					    EXT4_GOOD_OLD_INODE_SIZE;
 		} else {
+			ext4_error_inode(inode, function, line, 0,
+					"wow! this inode has reached ext4 iget");
 			ret = ext4_iget_extra_inode(inode, raw_inode, ei);
 			if (ret)
 				goto bad_inode;
-- 
2.43.0


