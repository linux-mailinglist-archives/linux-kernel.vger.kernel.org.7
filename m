Return-Path: <linux-kernel+bounces-749062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3CB14988
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BDC18875E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFC274FD9;
	Tue, 29 Jul 2025 07:52:43 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2D26CE26
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775563; cv=none; b=El3ip3twj9HLZeAVFiA+5rhMsa0pnGJ2NTHUFKWmX77u9KbgzDt6qK2WnSsM0ivu5MKCptGsAKu9OG5Lage7l63kv+SQ8GY9amjWO+tLi3Uio9XmehtR4rCJ8VM7mcgjr0liiR2j8EBm4/KsEsHJBeXl3OY0q9n7yt2Y3s2sWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775563; c=relaxed/simple;
	bh=JK+Yyk1lKU6YOKonCJlGa63Tn9Q0PZa1t/8lBHGY/Hw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ufW5hcVk1hJXl3BCirA7ldxXabw+dBB+v1yXlDRNZTrr4Cjle5X3lKwCiuZjTWYwqiUUTIrCrbGYYtZZxPiXDJuR9DZsugpQj6m4tMALnKwcWPY4sbzTTl5E9J0eE19R5pvMKuncZEHKefcdWYTK3O4/Hs9BOIGWZ1ZdDYGWARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e3ed8b5d05so3477995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775560; x=1754380360;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbG8wd61X6ynMDPJo7MPMMjMERfBKuH4wO9zJ3JvFWw=;
        b=HCsBVdd46q+CgPaBQxulJkD1yU7gMvBtylbp3v9ZtlczZL1pA9gPEqmQuClspDgs6I
         9yw7n2c/xDgYGY7+tjZkWvgMHfXz5Oa/ujQ6Sarbkp23z1y5XqRESvlSKIP2aDumuEmu
         B97LfJV5YwFAyfhOconyKaTs4J0WNfX0HWUZLU/os2z3jBZIhEZYIYW4xxX2hyrPipxr
         aQJTwEFgjlO9fYZkuKrPPYZbABDddWOHSHWakGnD9bK858UcEb1wZFzNRbJbR4eTb/sa
         HLEVO+nbFjTRmEwYXNgXuNxcafO5ommWTmfmHeHmn0jk5lR2qhnWSri0aQPWra9dUzIr
         cFpA==
X-Forwarded-Encrypted: i=1; AJvYcCWCuvkSymugmk2u2LOXbR72nlw9SBHrmPEyaGbABr5Bjo2bfiOVJtxCwCrZwswjVx1iqlt5YXDOpdasFo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWnOiiD/VMNykcJrD5oMpSlPoO32/MJ7ANAs6QOpX54tAjD+Q
	HnpHaQJPpk22o6BdGGDXgqeCNc6khrGkfYPONty3hTlcNeJvsr/9QHoYPd5xjGoE5sWhXKe1otp
	c1RirsXudZGge/7fX6f3GOTrz2L/vYVNprXzkXch0oHbKImbdsvfbFaWkvEI=
X-Google-Smtp-Source: AGHT+IH+iNQai/JtuO7kN5Osv7FHpXRBDH7MMcJwfJP/YcoFfQs42hRG+CGNZYWHNOR5TCTDplZpelSrQVHa3HAUfZJZ3Ql36XcR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:3de:e74:be13 with SMTP id
 e9e14a558f8ab-3e3e9217c4bmr36637405ab.0.1753775560671; Tue, 29 Jul 2025
 00:52:40 -0700 (PDT)
Date: Tue, 29 Jul 2025 00:52:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68887dc8.050a0220.3cc461.0012.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING: kobject bug in hci_disconnect_all_sync
From: syzbot <syzbot+860000a5278649faf5f6@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    25fae0b93d1d Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130a10a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4bcc0a11b3192be
dashboard link: https://syzkaller.appspot.com/bug?extid=860000a5278649faf5f6
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e51e91fa1800/disk-25fae0b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49603fd616e9/vmlinux-25fae0b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31b7fb718dea/bzImage-25fae0b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+860000a5278649faf5f6@syzkaller.appspotmail.com

Bluetooth: hci2: Opcode 0x0c1a failed: -4
Bluetooth: hci0: Opcode 0x0c1a failed: -4
------------[ cut here ]------------
kobject: '(null)' (ffff888034398be8): is not initialized, yet kobject_get() is being called.
WARNING: CPU: 1 PID: 18293 at lib/kobject.c:642 kobject_get+0x7d/0x120 lib/kobject.c:640
Modules linked in:
CPU: 1 UID: 0 PID: 18293 Comm: syz.1.2765 Not tainted 6.16.0-rc7-syzkaller-00034-g25fae0b93d1d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:kobject_get+0x7d/0x120 lib/kobject.c:640
Code: 90 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 e6 4c be f6 48 8b 33 48 c7 c7 40 8c b9 8c 48 89 da e8 44 2a 20 f6 90 <0f> 0b 90 90 eb 0c e8 c8 3a 5c f6 eb 46 e8 c1 3a 5c f6 4c 8d 73 38
RSP: 0018:ffffc900040473f0 EFLAGS: 00010246
RAX: d5e6b273e7d72b00 RBX: ffff888034398be8 RCX: 0000000000080000
RDX: ffffc9000f833000 RSI: 000000000001c99e RDI: 000000000001c99f
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: ffff888034398000
R13: ffff888034398be8 R14: ffff888034398c24 R15: dffffc0000000000
FS:  00007f6d5d6746c0(0000) GS:ffff888125d23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000015000 CR3: 000000007e615000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 hci_conn_get include/net/bluetooth/hci_core.h:1620 [inline]
 hci_disconnect_all_sync+0x115/0x350 net/bluetooth/hci_sync.c:5705
 hci_suspend_sync+0x3b8/0xc00 net/bluetooth/hci_sync.c:6188
 hci_suspend_dev+0x28d/0x4d0 net/bluetooth/hci_core.c:2851
 hci_suspend_notifier+0xf2/0x290 net/bluetooth/hci_core.c:2422
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust+0x85/0x100 kernel/notifier.c:345
 pm_notifier_call_chain_robust+0x2c/0x60 kernel/power/main.c:102
 snapshot_open+0x19c/0x280 kernel/power/user.c:77
 misc_open+0x2bc/0x330 drivers/char/misc.c:161
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf3/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d5c78e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d5d674038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6d5c9b6240 RCX: 00007f6d5c78e9a9
RDX: 0000000000040000 RSI: 0000200000000680 RDI: ffffffffffffff9c
RBP: 00007f6d5c810d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000019 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6d5c9b6240 R15: 00007fffd9731ce8
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

