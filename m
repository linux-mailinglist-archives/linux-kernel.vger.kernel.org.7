Return-Path: <linux-kernel+bounces-752372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA7B174BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45402161E40
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FB21FF27;
	Thu, 31 Jul 2025 16:10:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E75213E9F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978231; cv=none; b=Cmg/QH/NH8VTovB0og8iKh9S9T94L0zi9jUjYQG4SsSlwXhoV4IIgedAD3yrIJjg6lNfAFpoDNAtzc5pUr85g17CTLzTYWuh7FMO4Pcf73FzSK27R9ND6A8arEhpPghUJ3MuTKYh1b5lz4VJ6HU6rSo9hA8+uSU9kgnqWqtY/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978231; c=relaxed/simple;
	bh=J8qGltEnODPu2SSj+aQXC2AOhToIfmN4Sw1bECGc+k8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lB+SRXDNwxM2sXOEPrYimlFE9Hb2ZhtExgJP2C6jNkmSnMB4f4ZKDVu7aJ6Z0HwBDB+pGhwjEkTRKjg+zy0sRSJs7z6oC9e3Y17VN1kyqsSwLWe9U530GdoejFHkOupYnrCV7gQWXt5I9mikpsYHzXW2wE0lyn1syOWJzoMgMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c2bcfd156so86601939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978229; x=1754583029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFYW+aA6uJvr5ak42W6WPAm5tGUnfUH0d4GaZ1MeOr8=;
        b=lmJnRqUur1KP8mSlgXC2TSYAENrk6Xwgr5bt08o/ZOYIRquJC0xCHmbtVOxNg72Jso
         g7yGfAuv1ezaC4oZfn7kKhl3YMO8rMtUCTO7dHPYllhXtE800QFqGMToSXer0LNgx8DK
         M8Uzb3ANagrhBwDtgUueGG8tExKVA8QREg7g3WzYA8noN9ASPhiPCwVMsAOgRwkHZeJV
         JsbdcaLtHIRGWNxTz7IcRbMKZH8h8MQrylQvuxmB/KcpG+1q3qO8k8C9LpHL8PvV/3nU
         oyO0ydIXkPMrmM0C7V2XWOrkP5AQUo7liwksDtk69IgSbrF/jICJnr6MiMnPZ5Nebn5X
         qw6A==
X-Forwarded-Encrypted: i=1; AJvYcCXaQwOqIC15XxCy6pvoMYPzc/JM3Qm9HJn9mUqxxIXI0atCyEoMjxQ6b1/rU8RacHAYRL6f06s7KR3GgLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3m40Y8vuDEsqVUM74Fj6M3ZUL2DM7rO03tOT24dWKiq4xZYz
	qJUkqO7FsIyNDZqSErl8x3ExhqnzcYwu5zfkw1AKnNAeO/UDvyTKQ6bCMTSSi+/DwnlpqVOBU64
	JJoWoPcsbiLyEyM+MWMPh+dOmV+7mwWDec5YF30oI3pk7pqkm63niqoeIGHE=
X-Google-Smtp-Source: AGHT+IEBWKJnRi02CIml13bV219sFKiR4qTzX2+0YIHtx47EDxBIwT//WumcU+Qu/Gpb+9g2yaTAo6DLgn06ImXzLJ402kX9Lgjz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:44c:b0:876:4204:b63d with SMTP id
 ca18e2360f4ac-8814eb92c9amr307669639f.8.1753978229183; Thu, 31 Jul 2025
 09:10:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 09:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b9575.a00a0220.26d0e1.0046.GAE@google.com>
Subject: [syzbot] [kernfs?] WARNING: locking bug in kernfs_remove_by_name_ns
From: syzbot <syzbot+5ab23ab3166ecc1f994c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec2df4364666 Merge tag 'spi-fix-v6.16-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d098a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=5ab23ab3166ecc1f994c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3a245163b514/disk-ec2df436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74d521df2d2b/vmlinux-ec2df436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c35af89dc507/bzImage-ec2df436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ab23ab3166ecc1f994c@syzkaller.appspotmail.com

comedi comedi0: c6xdigio: a I/O base address must be specified
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 27407 at kernel/locking/lockdep.c:238 hlock_class kernel/locking/lockdep.c:238 [inline]
WARNING: CPU: 0 PID: 27407 at kernel/locking/lockdep.c:238 check_wait_context kernel/locking/lockdep.c:4857 [inline]
WARNING: CPU: 0 PID: 27407 at kernel/locking/lockdep.c:238 __lock_acquire+0x379/0xd20 kernel/locking/lockdep.c:5190
Modules linked in:
CPU: 0 UID: 0 PID: 27407 Comm: syz.1.5864 Not tainted 6.16.0-rc7-syzkaller-00140-gec2df4364666 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4857 [inline]
RIP: 0010:__lock_acquire+0x379/0xd20 kernel/locking/lockdep.c:5190
Code: eb 33 90 e8 b9 b6 17 03 85 c0 74 22 83 3d 92 a4 02 0e 00 75 19 90 48 c7 c7 05 eb b6 8d 48 c7 c6 ab 64 a6 8d e8 a8 d4 e5 ff 90 <0f> 0b 90 90 90 31 c0 48 8b 3c 24 0f b6 98 c4 00 00 00 41 8b 46 20
RSP: 0018:ffffc9000c487810 EFLAGS: 00010046
RAX: 8d19c7b7fdc9a800 RBX: ffffffff8b232418 RCX: 0000000000080000
RDX: ffffc9000cf89000 RSI: 000000000000365e RDI: 000000000000365f
RBP: 0000000000001c9b R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880550ca968 R15: ffff8880550ca8f0
FS:  00007f2f114696c0(0000) GS:ffff888125c57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d41fffc CR3: 000000005d526000 CR4: 00000000003526f0
DR0: 0000000000000004 DR1: 0004000000000002 DR2: 0000000000000408
DR3: 1000000100000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
 kernfs_remove_by_name_ns+0x3d/0x130 fs/kernfs/dir.c:1712
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x198/0x2f0 drivers/base/bus.c:743
 comedi_device_detach+0x134/0x720 drivers/comedi/drivers.c:207
 comedi_device_attach+0x568/0x670 drivers/comedi/drivers.c:1003
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:855 [inline]
 comedi_unlocked_ioctl+0x686/0xfc0 drivers/comedi/comedi_fops.c:2156
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f1058e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f11469038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2f107b5fa0 RCX: 00007f2f1058e9a9
RDX: 0000200000000080 RSI: 0000000040946400 RDI: 0000000000000003
RBP: 00007f2f10610d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2f107b5fa0 R15: 00007fff884948c8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

