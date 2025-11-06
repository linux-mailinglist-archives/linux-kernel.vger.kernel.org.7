Return-Path: <linux-kernel+bounces-888848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB4C3C0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329DC1AA72B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750022550A4;
	Thu,  6 Nov 2025 15:28:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393311EDA2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442890; cv=none; b=BkaMJgYo8cBUOB+2kHkf0jkYXNolbSiAw1dwYojeKAeywOVH0F4v1SH+rAcrgcu3JMrkn6CAfzqjmQuYmMuGokaa3H6X25Sik2rgEMLOZ47bUtn6utp1caBSRLYn3MgEkdGR2fqcV2gRrO/cd0dEpHWWpQuX334MIFtKsppkE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442890; c=relaxed/simple;
	bh=0EOen5BEeElBzeTo3WVz5nzsuBg8PeF20mfivseVamA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mKoLVZZZvh/vq8kTLotO0qAwqvUN1mvZVQknNX6O2DltlZS7UcAoGPFFHDPhVxyJvw64T51uXpY+4zNfMxhl8no/z7rJ/rfI4Ik+eum/dymOZmUw1Srzi9IW1V5ElwpcFgF1eN1LKjRvU5JVB8h+80fviHOmRwzQJlN93e/2I2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94880a46eaeso153711339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442884; x=1763047684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZMDOcpZaDUoDgmi5ie879VxEFvQRQ7HOEUUjk1eDIA=;
        b=hH1BO41dJ15eWuAkWnOxDrgpah4L/1SZEloX62fTWm1ODOhWnMs/mRBep3S3BT7n+r
         2FLTeFOk3tFYgMW79aHrLYFuP58gwmX74DCQp/A4Hy7n0d9sT7XWKevthb+desp5iPMd
         YVXOZzGAGXNfMtfed/uKb/rVp6cGObT9+CP5Lfwng1TMqYpgRgl9RWknDA4+6OTdQ903
         uHrHVnUSL+hAFwzmV2OxXgDByJRUvvxr+54mctRQ0Cz/p3VS/VGetWzk2AG2IaQic2sH
         8ZtTD6MytmxaY/ok3NtvbRnMNBNMmrYy9RTtKHV9WLjRlmucR8uZCx27hjo39CbE0Xj2
         0FZg==
X-Gm-Message-State: AOJu0Yw4/efKLrSRFuu32NiHCSbJZulxCkGyw+f8CoUPbDDpiPzHILZ9
	k643DTjqdlwOIhzJvTSHNZkhS8N/2TOteuSxABbqIaGCcIEMkw6HhIr33IfDSzrQuvcNFsBb2sx
	pvLB9OIEXgkG0LCsn5JYXGROmAWv/FooOGjyxDb6vc/DgrqBYzzVF4ab3INg=
X-Google-Smtp-Source: AGHT+IFHJEyfLyfvE3NcldFF8UR0sg+GAbQu1Q465ziL4xUQrLe7BYVIJUWOMX0ybqv6s63d1EkY8ARR3gq+VlGy0fh7fc1aNJFI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcb:b0:948:3ec6:7806 with SMTP id
 ca18e2360f4ac-94869cbf6bdmr1085517739f.2.1762442884339; Thu, 06 Nov 2025
 07:28:04 -0800 (PST)
Date: Thu, 06 Nov 2025 07:28:04 -0800
In-Reply-To: <CAPrAcgOWmK1FLk8r0LszmPO3ysPi4G+EJw=YcSg3o6Ozy1wGbw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690cbe84.050a0220.3d0d33.0162.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in handle_tx (2)
From: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	3-....: (10499 ticks this GP) idle=2da4/1/0x4000000000000000 softirq=16891/16891 fqs=4445
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:     5252          0            0
rcu: 	cputime:      219          0        52189   ==> 52490(ms)
rcu: 	(t=10500 jiffies g=13101 q=1869 ncpus=4)
Sending NMI from CPU 3 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 1419 Comm: aoe_tx0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:uart_port_deref drivers/tty/serial/serial_core.c:74 [inline]
RIP: 0010:uart_port_unlock_deref drivers/tty/serial/serial_core.c:92 [inline]
RIP: 0010:uart_port_unlock_deref drivers/tty/serial/serial_core.c:88 [inline]
RIP: 0010:uart_write+0x4ff/0xb30 drivers/tty/serial/serial_core.c:626
Code: 00 0f 85 e3 05 00 00 48 8b 85 08 01 00 00 be 04 00 00 00 48 8d 98 9c 03 00 00 48 89 df e8 99 61 01 fd f0 ff 0b 0f 94 c3 31 ff <89> de e8 da c7 98 fc 84 db 0f 84 4a fe ff ff e8 ed cc 98 fc 4c 89
RSP: 0018:ffffc90006f3f980 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffff888105518f00 RCX: ffffffff8523e2e7
RDX: ffffed1020aa31f1 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffffff9ab86620 R08: 0000000000000001 R09: ffffed1020aa31f0
R10: ffff888105518f87 R11: 0000000000000001 R12: ffffffff9ab86728
R13: 0000000000000003 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880d6e58000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f58c1ec300 CR3: 000000000df82000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 handle_tx+0x204/0x630 drivers/net/caif/caif_serial.c:222
 __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
 netdev_start_xmit include/linux/netdevice.h:5257 [inline]
 xmit_one net/core/dev.c:3845 [inline]
 dev_hard_start_xmit+0x97/0x740 net/core/dev.c:3861
 __dev_queue_xmit+0xa46/0x4490 net/core/dev.c:4763
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 tx+0xcc/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1e4/0x3e0 drivers/block/aoe/aoecmd.c:1241
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
CPU: 3 UID: 0 PID: 54 Comm: kworker/3:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events ser_release
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 17 59 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 03 06 16 00 fb f4 <e9> 3c 0a 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000a7f688 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000002
RDX: ffff88802179a480 RSI: ffffffff816b3141 RDI: ffffffff8bd06840
RBP: ffff88802bf8e540 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff905ff2d7 R11: 0000000000000001 R12: 0000000000000003
R13: 0000000000000003 R14: ffff88806a93b280 R15: ffffed10057f1ca8
FS:  0000000000000000(0000) GS:ffff8880d7158000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0cc637e286 CR3: 00000000288be000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 kvm_wait arch/x86/kernel/kvm.c:1080 [inline]
 kvm_wait+0x186/0x1f0 arch/x86/kernel/kvm.c:1062
 pv_wait arch/x86/include/asm/paravirt.h:569 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:466 [inline]
 __pv_queued_spin_lock_slowpath+0x4e1/0xcf0 kernel/locking/qspinlock.c:325
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:557 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:116
 spin_lock include/linux/spinlock.h:351 [inline]
 __netif_tx_lock include/linux/netdevice.h:4685 [inline]
 netif_freeze_queues+0xdf/0x1e0 net/sched/sch_generic.c:461
 netif_tx_lock net/sched/sch_generic.c:470 [inline]
 netif_tx_lock_bh include/linux/netdevice.h:4770 [inline]
 netdev_watchdog_down net/sched/sch_generic.c:570 [inline]
 dev_deactivate_many+0x243/0xd50 net/sched/sch_generic.c:1370
 __dev_close_many+0x150/0x760 net/core/dev.c:1739
 netif_close_many+0x233/0x630 net/core/dev.c:1780
 netif_close net/core/dev.c:1797 [inline]
 netif_close+0x17f/0x230 net/core/dev.c:1791
 dev_close+0xaa/0x240 net/core/dev_api.c:220
 ser_release+0x184/0x340 drivers/net/caif/caif_serial.c:295
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         dc77806c Merge tag 'rust-fixes-6.18' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10625bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f009a9a8d50667
dashboard link: https://syzkaller.appspot.com/bug?extid=827272712bd6d12c79a4
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c25bcd980000


