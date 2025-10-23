Return-Path: <linux-kernel+bounces-867286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6FC021DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA65F4EE256
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2833B97F;
	Thu, 23 Oct 2025 15:30:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DA33B97D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233406; cv=none; b=njBwU0nCydBpCy0iRoKSoaZ9/z4Go3LkdMGup47PjmImb20v6AZz/y4X2YR/JuE9Sk4UPSR/6x5CdvNmHYbJzFu1N1vxgvBnx6SE3q7rtJkLEUXh1BH72yFAwpjT1by2HeoC2S84WS8yb6eRThJKh1Af1sE7+8kknkuQNtMeu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233406; c=relaxed/simple;
	bh=HiHP9JvM5Fi7MB5WGTK1Jq/XrDudyPh4o/WB/w0uviM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PNjcmJsDmxi8RzZuY8/dLCGnrwZi2k0kjMFL6XXzaxhO9NYBr4iK/71h3ocY4oOYDYvFrf9AExhdOYNfi0537RgifONKUQoxyq5ezwTn/sp8zxS4eItnwrF1UZwhksOgXelFUaUX+N0HFFWzS7ip65l+5ATx+BmXLKYfp1YghX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so12208205ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233404; x=1761838204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibty3QfEHYMnCmcXjfMXmdHZroqhZDl6lAHyPrOj2FI=;
        b=rHnAoh2qwcd8bqSIu/LoxVaheA9M1prfF1h+QtlR88keS7N5s4d89D1CyOQkZlktlX
         qe1cX0/dhXC2Zu4sjwTvPFzT7pQxla5VYSyL45TxCqCtGgAkYFVvwIPcOzxWWP1FmAXa
         CZBQ2fbA+gY/ue6zuQXzFr0Z+TcC1rLhzncJ0k+GWdRgr2rF9KKNvori9MPpu2S32GFj
         KBBA9bmqzQJi1WS0EULmsr7BuPWXmWN0Sp6KrqgCLnE5Af2ShuxPwNQy88EP87hYZX8q
         hbpu0OmHFzPC90UoJm8tJ3DOWs7RYWjyiNiYae0dlJ5HTSNZ1wvGAy9JzqNM6BWbVvKV
         mr+g==
X-Forwarded-Encrypted: i=1; AJvYcCVEUC6tnVxE8ZdFojheGNDpJqeA67A6+KFmJF5vDW/b9xn9FXMY/B9MOPreeXkK8C2q4ARUfOhTsq1iKjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0XxQKv4to7nGvpcQybNFhFeMChDFzLzELvnXzDJgkcxwVXB1
	r3J5Qwx4qcZM7wXGSENKmRZuNumd8lv1HUQJ78M7B6OAHxtIWZLCAP9QsjhmZjCMiXpUeLumWJu
	twDA5KJSQPALzG1HobE+nwHF1DMV9z2J1hpAIwRh40eRv1GZzRPnG4+3mDOU=
X-Google-Smtp-Source: AGHT+IEr2G40inCiGWoGt42gDNLXU6I/w5PbAroi98XBvFjC77cmaaeg0TkeDpzd3SoBh3SgBAUFcUlZANsGv7P5pVX76ceavm+T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:430:afae:fe24 with SMTP id
 e9e14a558f8ab-431d31b3cdamr83446655ab.8.1761233403802; Thu, 23 Oct 2025
 08:30:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:30:03 -0700
In-Reply-To: <CABFDxMHe8Ewe9BcnH-wiSpAzFQR2Nyu=Ek+Xqp0Ockjp4r4wtg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa49fb.050a0220.346f24.007e.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_new_inode
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in hfs_new_inode

loop0: detected capacity change from 0 to 64
hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB
------------[ cut here ]------------
kernel BUG at fs/hfs/inode.c:222!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6697 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:hfs_new_inode+0xbc4/0xbd0 fs/hfs/inode.c:222
Code: 89 f1 80 e1 07 fe c1 38 c1 0f 8c 15 fa ff ff 4c 89 f7 e8 0f 6d 8b ff e9 08 fa ff ff e8 c5 b5 29 ff 90 0f 0b e8 bd b5 29 ff 90 <0f> 0b e8 b5 b5 29 ff 90 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003b37848 EFLAGS: 00010293
RAX: ffffffff829557c3 RBX: ffff88803a419748 RCX: ffff888026245a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1004f94608 R12: ffff888027ca3000
R13: 1ffff110068414f3 R14: 0000000100000000 R15: ffff88803a419748
FS:  00007f166458e6c0(0000) GS:ffff888126bc2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31463fff CR3: 000000003ad7a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hfs_create+0x2a/0xe0 fs/hfs/dir.c:198
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x1500/0x3840 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1664f1efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f166458e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f1665175fa0 RCX: 00007f1664f1efc9
RDX: 0000000000000042 RSI: 00002000000002c0 RDI: ffffffffffffff9c
RBP: 00007f1664fa1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000058 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1665176038 R14: 00007f1665175fa0 R15: 00007ffeb72a90b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_new_inode+0xbc4/0xbd0 fs/hfs/inode.c:222
Code: 89 f1 80 e1 07 fe c1 38 c1 0f 8c 15 fa ff ff 4c 89 f7 e8 0f 6d 8b ff e9 08 fa ff ff e8 c5 b5 29 ff 90 0f 0b e8 bd b5 29 ff 90 <0f> 0b e8 b5 b5 29 ff 90 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003b37848 EFLAGS: 00010293
RAX: ffffffff829557c3 RBX: ffff88803a419748 RCX: ffff888026245a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1004f94608 R12: ffff888027ca3000
R13: 1ffff110068414f3 R14: 0000000100000000 R15: ffff88803a419748
FS:  00007f166458e6c0(0000) GS:ffff888126bc2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31463fff CR3: 000000003ad7a000 CR4: 00000000003526f0


Tested on:

commit:         43e9ad0c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128eb734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=216353986aa62c5d
dashboard link: https://syzkaller.appspot.com/bug?extid=17cc9bb6d8d69b4139f0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dd5b04580000


