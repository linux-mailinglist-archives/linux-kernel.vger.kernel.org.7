Return-Path: <linux-kernel+bounces-839874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF1BB29EA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F417AE7C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B02877F1;
	Thu,  2 Oct 2025 06:28:18 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B02877D9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386497; cv=none; b=hVBudYllwAeCcjGlfglbJIFThtrcSaot+S8nRvVsXi9ksEYu1++zjpjHh6TGMpJewge37SI9UchH7b0rjD2b6oT2DK+wLdhaKv1keqJR+QzjqVOKSkafuq3XEIGPZpIg8LXwCEmMKREsiNwLOkFiS7J8v0Bqo1w7ucoQ45UVoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386497; c=relaxed/simple;
	bh=9WEH4vKZFM2k4Xsmy2GwEKxrX+eNQP9rESl8edllpcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lIQpi7tijx8NqJsmJISS6sQX1aasNl+0ekLFmLfqQfq8rcnQ0JRLxdoDEUhXjGQZzqmZtRQIWfjU5yIhTBW1UX47xO38N/YgvF1DY2HaSJRfNhk1V7qbGRDxBI2WiLyzTU+iP2W6xqSx7bFY6A8jhuVEFU5I3juA7rDqdxCARjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso89065139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759386493; x=1759991293;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROjITWJuB2PqB72RMSnOzd9aCzel9Vg1gKRJuRBaIc0=;
        b=KICGrTeErLKwHCF5nNC7DqQUM1J4lfg2gBuTSJf+VOg/yUrWeh+4auXPWVuMreCAu+
         cOOWFbnF5Z4j78V5x1iWnC2d6aQ5NQwkwTgv6DKLyhyendZJJgdDg+iHgSLkjPUFBiE+
         bAtTZ4HQjAo6Ys9lYLcmNWTjnQ7tF83iz0bkBlOKp3S6Jvstv2ghtuum1AnqqFyXZcIY
         fJZ0UCVZ2yClORLUN3SNpOd2GECET/Ed1B7mSRWum1avFp0vs0KzL0dKPrCW5CdT3/P0
         UUiDk6K7GBVp0jWEYwsxe4A4rlJDmQxFtu0xoye/i7Gnxwb4BKteeUJEglTn5UU//XfQ
         sqHw==
X-Gm-Message-State: AOJu0Ywq1pwib8vGsWpS4RAxErjx+GsLsZ47U++6CVihImwjseAML+/S
	ZjG8UUV3Io9iTJ+WqvkUX23f6h+ZF8G5l8mdVOUoZi9Myf4EFigi+slv7Jh4TTQgVICZTmYogR8
	ceSiBapCCinufUhHnyhaKmTBW9CqxdKzVQK7Bgr1MgGxQzQa7raauTtGaeio=
X-Google-Smtp-Source: AGHT+IGsPsmh/InfxW45Lv76MgfILfkgjy5ZMrd56RtkOc6graARhI+Hji6xFa/JrXahvtG8M32/rWpuUHXWbIJ7dJtAd+aGCJRK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340b:b0:92f:575a:6df0 with SMTP id
 ca18e2360f4ac-937afb06682mr840440239f.19.1759386492873; Wed, 01 Oct 2025
 23:28:12 -0700 (PDT)
Date: Wed, 01 Oct 2025 23:28:12 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de1b7c.050a0220.1696c6.002c.GAE@google.com>
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
index 5a6fe1513fd2..8680f649ea7e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -251,6 +251,13 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
+		if (entry->e_name_index == EXT4_XATTR_INDEX_SYSTEM &&
+		    entry->e_name_len == 4 &&
+		    !memcmp(entry->e_name, "data", 4) &&
+		    ea_ino != 0) {
+			err_str = "system.data xattr cannot use external inode storage";
+			goto errout;
+		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
 			goto errout;
-- 
2.43.0


