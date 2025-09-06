Return-Path: <linux-kernel+bounces-804209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EDB46CDC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D8C189835F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC228B400;
	Sat,  6 Sep 2025 12:28:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CF23D7EC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161687; cv=none; b=uAeTDKiuYy0iNxc+CXHTnzU+QAAKFGRmd6BPPm8nmI+wNUhaZaqGZpqhZ7XDT2NcpkE1xBBRmApvOrs98+frbS2rmEBpp3cJDitgyCl5Z48arWvwN0yxI4UaC9OPmOzJ4oXXfCC4yDW59igyGDrAC8xNmqrX52KV2GiVixZc+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161687; c=relaxed/simple;
	bh=5ZyoqMOkY+4CP0jcTsZM23+GLIPv5N31NwuHpJDGZKM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rvwMY7cQi4dB33o4G8bQyvimKRLTYrk4HxNgikiZ1BttR+ec7qRZ9yHttXFhF94g1OBsqkmlr2o7MRTCiJxaiaUDVQpGoKnTP+oMmhtqrhfJBpBNySmdCdg58xF4yQPJARyp4jHOSN/+B7woP82XC0v6ZoIbDCEnSutWsDhrgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f761116867so61543095ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 05:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757161685; x=1757766485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZC6RWwXtyOq+69ZLGlh8HKD0iDGwhDSE+K1DCcE7zI=;
        b=havgEfLXCZt8dznEhU2VRU5r8kXyb0U3Y0vjr8w5i3xe1qxwY6Bso90Rz74U6JRbLF
         45RrGl8Z0x7Z4T+2j1wGbE1eftWOz9keVG1WW9e7MotaL6Qq1Do+Iyq6Peu4tnETMI9Z
         CwGjkdS+80mylZ0gwA8pX9wyzeP+1TA28VWkc9ATJVDcrCNmIDgX/ivRVvFzzGJIbbs8
         SE37SkXPw4cEOQm0YvXIe6+aOcTd5BHkESKpPAc81+RsbNRvo3D5+sXNKfR7EQM3rCrP
         Xp6qI7XzrNKzCReKwwRBeoqgArqmxdjqAAYzScd6dQHHzfI3mIszpJyowrQ7S9KEuPok
         Aw7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1BZWL6XL5fVUTwvDkz+Cg+82BdXkLYaSi6K4VUn0v9XZWveYtFf0j6pLMRUVo2oRbfgD6dxA3yl1cGoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CBcsBIjBoRXNN6DUjEEjd5AY6fNEe9HbbeBiagPenhvg4Y6i
	oEKkOugsVv9SXFIbmTh9WMj6wRFFQe3BR8gqMrqhPt8gMbsgmxUi9It7v6WR/blk17dlC3R0KOO
	X/sPzPue9d79ZYaNejsLbFviKSl5RfLQPw3kT5Ovv4u992yCkiGJLK9prSq8=
X-Google-Smtp-Source: AGHT+IEoAQIGC05m9rCvKcdSriDAVJrBCz8p/ZxSxG8lhxJ5lC814iyDJO2CI/SYLIbfQ2Y8rq7tj1MaROkKuGxuFdHQ7hQCzEBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0d:b0:3f3:180b:cfd7 with SMTP id
 e9e14a558f8ab-3fd88114d37mr32061195ab.15.1757161684933; Sat, 06 Sep 2025
 05:28:04 -0700 (PDT)
Date: Sat, 06 Sep 2025 05:28:04 -0700
In-Reply-To: <20250906105611.103868-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc28d4.a00a0220.eb3d.0022.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in az6007_i2c_xfer

az6007_i2c_xfer 1 : ffff8880273c0000
az6007_i2c_xfer 6 : ffff8880273c0000
az6007: tried to read 4109 bytes, but I2C max size is 4096 bytes
az6007_i2c_xfer 7 : 0
az6007_i2c_xfer 8 : 0
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
WARNING: CPU: 0 PID: 6819 at kernel/locking/mutex.c:933 __mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Modules linked in:
CPU: 0 UID: 0 PID: 6819 Comm: syz.0.46 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Code: 08 84 c9 0f 85 78 02 00 00 44 8b 15 f2 ac 1a 05 45 85 d2 75 19 90 48 c7 c6 a0 5a ad 8b 48 c7 c7 60 56 ad 8b e8 79 29 ea f5 90 <0f> 0b 90 90 90 48 c7 c1 80 60 e3 9a 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90003f77918 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a2388
RDX: ffff8880273c0000 RSI: ffffffff817a2395 RDI: 0000000000000001
RBP: 1ffff920007eef28 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
R13: fffffbfff35c6c10 R14: ffffc90003f779a0 R15: ffff88807cef0000
FS:  00007f6691eda6c0(0000) GS:ffff8881246e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000025c0 CR3: 00000000250f0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 az6007_i2c_xfer+0x821/0xe50 drivers/media/usb/dvb-usb-v2/az6007.c:859
 __i2c_transfer+0x6b6/0x2190 drivers/i2c/i2c-core-base.c:2264
 i2c_transfer drivers/i2c/i2c-core-base.c:2320 [inline]
 i2c_transfer+0x1da/0x380 drivers/i2c/i2c-core-base.c:2296
 i2c_transfer_buffer_flags+0x10c/0x190 drivers/i2c/i2c-core-base.c:2348
 i2c_master_recv include/linux/i2c.h:79 [inline]
 i2cdev_read+0x111/0x280 drivers/i2c/i2c-dev.c:155
 do_loop_readv_writev fs/read_write.c:847 [inline]
 do_loop_readv_writev fs/read_write.c:835 [inline]
 vfs_readv+0x5c1/0x8b0 fs/read_write.c:1020
 do_preadv+0x1a6/0x270 fs/read_write.c:1132
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6690f8e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6691eda038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f66911b5fa0 RCX: 00007f6690f8e169
RDX: 0000000000000001 RSI: 00002000000025c0 RDI: 0000000000000004
RBP: 00007f6691010a68 R08: 000000000000007e R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f66911b5fa0 R15: 00007ffc5efdc628
 </TASK>


Tested on:

commit:         d1d10cea Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116d5962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d6d312580000


