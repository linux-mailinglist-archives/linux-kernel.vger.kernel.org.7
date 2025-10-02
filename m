Return-Path: <linux-kernel+bounces-839869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572BBB29C6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419FE323F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDCF255F28;
	Thu,  2 Oct 2025 06:18:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42B224AF0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385911; cv=none; b=H4HV9uNYHyYW47cKfIbRxIsxvNm3+HztA71R7ItoiWYk9nSavKICAlEuCn/q0j7QeKz0j/gvG+x5NonEIAy2Ns3P4C/2z1n4DIP1wowyyvvqTVk5R8+cTD1Jcpow3mx3KxETauxat6rYgO0zjUHBJCOc7PyB5yaRGbGQO7n0Gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385911; c=relaxed/simple;
	bh=5jQS3eIFDtsPvTVU5adh6cwGmLRkZns3kadqVszJLBU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MkkqtKhYBCM4uIsrmku8DV5kvMdJGHfzgcW85DbSNbIM6gx3EbYI4Fs9fmguv2UpyCJkKCmdGvEpcPDLpNRyErstqsr0Gl8u3nZ7nMk4XYr8Y40iv+wsY0ifxsPz0jtG+FUBjc2a8sqPkFbCk28j3AUhkCqNRGYN41cRombxQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42571c700d2so16310265ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385909; x=1759990709;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbYxd/yTT5Uqjh/FcKhc7Bn+3OUTLVMLJgkAWGksEs0=;
        b=acaP9ks7YmpQk9ON8ShEquSDRTTnn7sJdmk0Ap3/cuoAasYd/uDeloyQ1A34MhUij0
         07HuU6Sch8PU11urTY9wvKdydJCSZuU9Nyf9czzM/u1Om3H6cL253Rnt6+ywhsxIB/Er
         0+YXI7Hw2dOtRBXrcZWcYOz7RSmPHnlb4/MlfT2T7rV3kF7OZzfjmDtQuVoslMDUBQ6q
         +wcOViY0Ft11KcBMN1A4ZMMYnGFIL94UkN8Ge++kqOXWJ+HeyDiItuHZbHV+YK99mzJA
         V9DaK0KlOYcCQk0PvbqeP/Qyy0SrkDrCKG+dryfQQ7fWwBzj2B4d8tklg03NaPSwjgjM
         laeA==
X-Gm-Message-State: AOJu0Yw8iPVd9hxHBIcmmWAgRMquqrx2CWbCa9KBwHX4vwjTommPkV7x
	zHCRuCBkB2ln33MUsNLxj1ZDQNQitp0qJ7XYnYvg4dH9WXOyg0zn8//+s2JFhMzGCE3zv7Y4fe1
	wyz5C9IvobnWeh8N6YVHm3Ne9GhemQey3R1tzwgIeYhjBEGKjyvBbvFmhx5I=
X-Google-Smtp-Source: AGHT+IFFSGo7N1MOlYskctthGHUsqS39oNL7/jZHZq0qun+tRiOY2TqTgfX/cFirVH9bVluQH/FuRb9NhrptQyzPMVEL7ypMqZ2R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aac:b0:425:951f:52fa with SMTP id
 e9e14a558f8ab-42d815caeb7mr81325145ab.14.1759385908851; Wed, 01 Oct 2025
 23:18:28 -0700 (PDT)
Date: Wed, 01 Oct 2025 23:18:28 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de1934.a00a0220.102ee.007b.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject system.data xattr with external inode storage
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject system.data xattr with external inode storage
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Prevent use-after-free in ext4_search_dir by rejecting malformed
inline directory xattr entries during validation.

ext4 uses the system.data xattr to store inline directory entries
within the inode. This xattr must always use inline storage
(e_value_inum == 0). However, a corrupted filesystem can craft a
system.data xattr entry with e_value_inum != 0, bypassing the existing
validation in check_xattrs() which only validates e_value_offs when
e_value_inum == 0.

Later, when ext4_find_inline_entry() is called, ext4_get_inline_xattr_pos()
reads the corrupt e_value_offs and calculates an inline_start pointer
that can point outside the inode buffer, potentially into freed memory.
When ext4_search_dir() attempts to access this invalid pointer, it
results in a KASAN use-after-free.

Fix this by explicitly validating that system.data xattr entries always
have e_value_inum == 0 in check_xattrs(). This catches the corruption
at validation time during inode load, before the corrupt pointer can be
used.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..a9057d0f9e24 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -251,6 +251,13 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
+		if (entry->e_name_index == EXT4_XATTR_INDEX_SYSTEM &&
+		    entry->e_name_len == sizeof(EXT4_XATTR_SYSTEM_DATA) - 1 &&
+		    !memcmp(entry->e_name, EXT4_XATTR_SYSTEM_DATA, entry->e_name_len) &&
+		    ea_ino != 0) {
+			err_str = "system.data xattr cannot use external inode storage";
+			goto errout;
+		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
 			goto errout;
-- 
2.43.0


