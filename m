Return-Path: <linux-kernel+bounces-841084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604ABB639C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FF119E1373
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910782641F9;
	Fri,  3 Oct 2025 08:14:54 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9834BA50
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479294; cv=none; b=b1va305JjWn0y81xZB6pMkMMOshNegrz3oQb8N5bZNy0efAsyFq3PjVn8/0MyyTLwg+AkieBYjPJ48qYeKYvmCyLIp8hZBvTzAEgjPwX5orKWZQ5nEk6zSoE3ZCn7TdWmNjwUpxZMcHMy04dYASY0S0OZZYpgkfZTfKGQjDdin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479294; c=relaxed/simple;
	bh=y4AbbVI2zm9EjatU3Omkf2IF9HL2oH3g5rJ7sXpWV6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rHLXc7Q6wzldhmMlI0cihD6CoZ4luM6YMH0eEQvBc9uLsqN/OKFVKQVscLyftKaaFxKHGF6cl2AsDWjrpzj7KtdvKH1MPVOvkLRk9ZFcQ+8cAsKgMDAs56ZDSxY9N/vFL7Cz1EPX6s09JBUHWXWGQViLxzmuPZNRVFJa9STv+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937ce715b90so400542039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759479290; x=1760084090;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhESs7nhkpLX12DtYICkVgH7hqFw6zMhaYu6P0p5YOY=;
        b=rIdvBx7b4FfwUtxBbWeRvZLZd4Q4VXgI51VB3pkxgjDizPncpGmKl+q+N9Hr1eqJ8r
         bqL8oy7jQegJHNKxdddS6V5PMJQPRf+lmxs7t7etZXJDkFP3fmqM4Th8AkJHUR7MUboR
         mA/Sgp3KJzSdW210phPQ7YFNZFnWf5K0mPzyLUbUms4p6GVE2LDulDRS3dUPIbvwMv45
         36D/QSi2SH2LZidl/28G0w7Td9WdGbL3FvohBsCsLuGmafZarZrkniKc7E98zNQIbEYo
         2+znZnm6XWyoFbKm3jzEX9n1R78NpLH43DIwT35YyQrW9KGw3HFEigdW4vFwGjNHYeIt
         YMIg==
X-Gm-Message-State: AOJu0Yya1kJT5JqMcW9eH2pJPzL1udS3i9rd99vedcK6JmmU/4QsRWkO
	fE8PdR/2pIXGoDk5K+tn+x2FuU0/Z0XLhN2pCKdB/m9iH+LXxu6vuQV9vOeC7N2uGp55PTHJWor
	WHFmw3BVsY1IlWY0CaBdegegW8/ByTWbykEyC/NnRGhTanzgJEC/lLHeZVMs=
X-Google-Smtp-Source: AGHT+IHRHFDz3501R469rHOs0bYBOtZ9C27t+R0uYMWPNUPSM8me77JXMlY3OiuyWa8HG00ygiOV9ZS2ED1gGHk0ugyw2T2/cqjX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:423:f113:749d with SMTP id
 e9e14a558f8ab-42e7b1af4afmr25351385ab.4.1759479290682; Fri, 03 Oct 2025
 01:14:50 -0700 (PDT)
Date: Fri, 03 Oct 2025 01:14:50 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df85fa.a00a0220.102ee.0110.GAE@google.com>
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

Prevent use-after-free in ext4_search_dir by rejecting inline directory
xattr entries that claim to use external inode storage.

ext4 uses the "system.data" xattr to store inline directory entries
within the inode. When an inode has the EXT4_INODE_INLINE_DATA flag set,
the system.data xattr must use inline storage (e_value_inum == 0).

However, a corrupted filesystem can craft a system.data xattr entry with
e_value_inum != 0, creating an inconsistency. The existing validation in
check_xattrs() skips e_value_offs validation when e_value_inum != 0,
allowing a corrupt e_value_offs to pass through unchecked.

Later, when ext4_find_inline_entry() is called, ext4_get_inline_xattr_pos()
reads the corrupt e_value_offs and calculates an inline_start pointer that
can point outside the inode buffer, potentially into freed memory. When
ext4_search_dir() attempts to access this invalid pointer, it results in
a KASAN use-after-free.

Fix this by validating in check_xattrs() that if an inode has the inline
data flag set, the system.data xattr entry must have e_value_inum == 0.
This enforces the consistency between the inode flag and xattr storage
type, catching the corruption at validation time during inode load before
the corrupt pointer can be used.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..d082fff675ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5417,6 +5417,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
+			if (ext4_has_inline_data(inode)) {
+				ext4_error_inode(inode, function, line, 0,
+						 "inline data flag set but i_extra_isize is zero");
+				ret = -EFSCORRUPTED;
+				goto bad_inode;
+			}
 			/* The extra space is currently unused. Use it. */
 			BUILD_BUG_ON(sizeof(struct ext4_inode) & 3);
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
-- 
2.43.0


