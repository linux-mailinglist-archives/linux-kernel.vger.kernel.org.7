Return-Path: <linux-kernel+bounces-784318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD2B339E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8241894AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01712BDC02;
	Mon, 25 Aug 2025 08:51:32 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7529D28A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111892; cv=none; b=tbkYh9k6Bj5kHCmejzPZGUbDGRK+BW8r1kAoaID9DR1WsYgePDIJ72tDOc4uNDgWl2szF81OcYMPC4tDrV4opCdmLHq5hHk+E5GoL9g5dYw+flEVtetvkyKoDAzumpbOt7U2c687mPXKJVFMQLMOnOh4vDaQo2UWXN9aIHnt6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111892; c=relaxed/simple;
	bh=2G0JsDgI+Wq3V0feon2KQDSXSCpdjVZVJXKHJ8zaJ18=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U1+vl5jI/wWRPJXrHJpHrD17+VdKlvstszJdx9XDUaHib7zYmmlb7ajbeF4d32eEtGk4XXfOswe5yCDuSwZaxOT23UHm8bXxpHUnwjC/Lgt6vb868FBtVfYr87BJoxGOGdoD64Pm+uTkjaOTQpUO9WU814i4rhjzxHXZ5jHr8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ed3c254b63so4613965ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111890; x=1756716690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz23suFe+AJG+yjUENL7xEpjOJTJmjoJ0r2drDzUscU=;
        b=HOiWaVyrhL7ha2i3bzIE6KnM2OSr38QO6GMhw3qnVid5W5kH23LL9dcq9cItwNc/yf
         eVCygAHeTq9z4vlTqgW1aVcgC3VNaWJhMQ3mG6PAWkgDSerHOkY1cPQYvrtcGPIk+FAd
         dMcKGcsfu/dTRSdBlWLNHx8iHxOYw9OnEfDFLWRNVbN6wOWuD0WiIV5ngCMlBJFybJDP
         dSWZXK2WYju2Z1HlD6MPQ7dJTthItm0x5O1w/GACIGDSzNQSO4iNBHH/UfF5FPs6Absd
         L1UpPAmDkqYOlThyYg1PmTCTuyp3MZhpDD6Ia3EmFqr7mEPz5qpCyaujU72ax/WAGGZZ
         9AnA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Rkkrej2I1RFJ2VUlQxqdTdlTWRzYaBYHkQzn3rz9LCQwBEcofvb/XLUVzAxFACn4zzdDLEn64jIYmgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78CWBJVhaOu2y0PM5qv4NuBWdyoAbK2aGTZPitYvHNChNiEoC
	/qUHzIBv6Dyxfw36nMEGvZXmRu84MfWnegGUyI7Nr1nynLeyxHP0pL6q9qt3+E/4nZ9IRoz+INF
	DrZthxPaZVd+UUhHJ/owfjgHODYAWq6Tze8GL0AL8auG9P5RL0JEV7oPO5vQ=
X-Google-Smtp-Source: AGHT+IGeRLcb75zkt/DbskhWS2WfYK9d9qwVjyXTlWGonE1tRBFM3mvjNHTUeonLiwn/1LheNY1xk3Iymz91M5LI3Gh5yYvJ7K1n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2591:b0:3e2:9ab4:3ebf with SMTP id
 e9e14a558f8ab-3e921e3b277mr184135545ab.19.1756111889821; Mon, 25 Aug 2025
 01:51:29 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:51:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac2411.050a0220.37038e.0087.GAE@google.com>
Subject: [syzbot] [usb?] BUG: sleeping function called from invalid context in dummy_dequeue
From: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e42062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=8baacc4139f12fa77909
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13317062580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5ea34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/096739d8f0ec/disk-8d245acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83a21aa9b978/vmlinux-8d245acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e7f165a3b29/bzImage-8d245acc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 6118, name: syz.0.17
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by syz.0.17/6118:
 #0: ffff888144724058 (&dum_hcd->dum->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #0: ffff888144724058 (&dum_hcd->dum->lock){+.+.}-{3:3}, at: dummy_dequeue+0x164/0x480 drivers/usb/gadget/udc/dummy_hcd.c:769
irq event stamp: 5054
hardirqs last  enabled at (5053): [<ffffffff8af9b343>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (5053): [<ffffffff8af9b343>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (5054): [<ffffffff86fc2471>] dummy_dequeue+0x151/0x480 drivers/usb/gadget/udc/dummy_hcd.c:768
softirqs last  enabled at (0): [<ffffffff81828ba9>] rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
softirqs last  enabled at (0): [<ffffffff81828ba9>] rcu_read_lock include/linux/rcupdate.h:841 [inline]
softirqs last  enabled at (0): [<ffffffff81828ba9>] copy_process+0x979/0x3ae0 kernel/fork.c:2043
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6118 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 dummy_dequeue+0x164/0x480 drivers/usb/gadget/udc/dummy_hcd.c:769
 usb_ep_dequeue+0x66/0x250 drivers/usb/gadget/udc/core.c:330
 raw_process_ep_io+0x5a3/0xaf0 drivers/usb/gadget/legacy/raw_gadget.c:1124
 raw_ioctl_ep_write drivers/usb/gadget/legacy/raw_gadget.c:1152 [inline]
 raw_ioctl+0x22dc/0x3ba0 drivers/usb/gadget/legacy/raw_gadget.c:1324
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1608d4e7eb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffdcd9fcf80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000044 RCX: 00007f1608d4e7eb
RDX: 00007ffdcd9fd000 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007f16090a0320 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000200000000080
R13: 000000000000000a R14: 00007f1608f75fa0 R15: 0000000000000004
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

