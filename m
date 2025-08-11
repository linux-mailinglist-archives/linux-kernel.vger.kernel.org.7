Return-Path: <linux-kernel+bounces-761748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27DB1FE03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A496C3B42A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848011367;
	Mon, 11 Aug 2025 02:52:28 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7713B7A3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754880748; cv=none; b=s14szcbazQh8u9/rLn6xFuHXdqVvZwqIKILs7Ubj2gKAkpJedmi8DFcOlIm0Uu0JsKMJsQ6nIdztSEhcUZ9Td4aMul/i58kGn1DfVCY5ZXXK42FErCBClfkmwucNgIJjqPYWNcftIFmd6jN/eePqkAeRECJTAf97uL+o+oxEIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754880748; c=relaxed/simple;
	bh=ePVF13VnvcNmbBkuoXsRvHXUiFRbHxBV7a+tjb3RZQA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qu+GeHE6Ub0cdKNlaJxd2lY0Bncb7D402mUtUwXWss2etSvy5l9Df/vqyKX68foDZVjvFTEFk2wxtsIdyj2FJbhGw6faBCrNGG8UvEBa3ZD/1vBLzDRUhM3tBFOVeF7bDfzNBxQGlG12a+T8HvgIzPQGVCUhCyE08mLH5dH/plE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-881878af906so800478039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 19:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754880745; x=1755485545;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLqHtODNg9yZAW29ftWwGBy+UqBt0e1Hwe2aS6qEPK4=;
        b=kj2BWgrqvlYmDSTuAJzxRtMdjgBFKcs4wQ15jBh7xN2rpX1NI7/RbrbDjXAgHWxoxo
         5ml+Rqyw+338DZEPaPc1SRNML6JUw6ZGKYpo7GzSpbd8z8/tpQOTnziTpxhUcgIkt51C
         kCjM53a9CjIMEuv1/t3C+pFBrYd8Y9uCnmgNb6XWlbdVxh2ccAq4DINizJbSsdaNnt4U
         ouY1l3XUzIFrGGMZRhLZD9osZSLZ1ws8T78RGy64tRFnv7FtJGaciSCVZ2kcPaUNwExc
         OK1o+G35OmhtHrE3/7ouT6xG8vHbo6il/4k4Oe8KUg5UL8VvlKH4I8nNVgh/vDx/2gMI
         Czaw==
X-Forwarded-Encrypted: i=1; AJvYcCUTZpmTRhFUxbjmyAna64NdD2ZK+5BNqYj4PnZYoLg0B5l+eln7Qlo4w7XVmj6a321PSsDQBrDnh30nPb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKMr9M0X7sgB/U21WsZNj9NDbBJby1pTTsCxzksFl554xhGpT
	BSTF38i+HnpCy4v53m2bIT2eBOzbEMJYKnsTFIAnZe+XS3w3KzgnOrfM8F/zcZTDvB4oVu+Snf8
	QN5P91+BmP4/ZlYyzz2QYv0LBA/xZx54gxyq3qAHKW4uDEZxuh4YyyJfGWJI=
X-Google-Smtp-Source: AGHT+IH2qpJz8/ZkW9szGOiYZKy9M2BG/Id14kXvLZkYa3aXWNfNAO0dcF+yZ2M23u3x5DFMRntHyKeOxNXMDo4HdJTB2rNi6MpR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcd:b0:881:7e0c:7a79 with SMTP id
 ca18e2360f4ac-883f11b58b4mr2271375139f.2.1754880745383; Sun, 10 Aug 2025
 19:52:25 -0700 (PDT)
Date: Sun, 10 Aug 2025 19:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68995ae9.050a0220.7f033.00e7.GAE@google.com>
Subject: [syzbot] [usb?] INFO: task hung in dvb_usbv2_exit
From: syzbot <syzbot+295c63688014c13a0a59@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    479058002c32 Merge tag 'ata-6.17-rc1-fixes' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e34ea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1bb6a60e53533c7
dashboard link: https://syzkaller.appspot.com/bug?extid=295c63688014c13a0a59
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b81042580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e34ea2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0b41f31d6eb/disk-47905800.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf9aa4f62fd4/vmlinux-47905800.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1c94d24385a/bzImage-47905800.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+295c63688014c13a0a59@syzkaller.appspotmail.com

INFO: task kworker/0:1:10 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:22616 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:121
 i2c_del_adapter+0x546/0x6f0 drivers/i2c/i2c-core-base.c:1817
 dvb_usbv2_i2c_exit drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:86 [inline]
 dvb_usbv2_exit.isra.0+0x45b/0x9f0 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:844
 dvb_usbv2_probe+0x1f61/0x3e50 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:993
 usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/0:1/10:
 #0: ffff8881442d3548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc900000f7d10 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
 #2: ffff888029d20198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #2: ffff888029d20198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1c0/0x4fe0 drivers/usb/core/hub.c:5898
 #3: ffff8880252bc198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #3: ffff8880252bc198 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1006
 #4: ffff8880252bf160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #4: ffff8880252bf160 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1006
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1160 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1160 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1160 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
2 locks held by getty/5608:
 #0: ffff88814dfe80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
4 locks held by udevd/5873:
 #0: ffff888078ae8d58 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x12c0 fs/seq_file.c:182
 #1: ffff888023aa7888 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888034e142d8 (kn->active#29){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff8880252bc198 (&dev->mutex){....}-{4:4}, at: device_lock_interruptible include/linux/device.h:916 [inline]
 #3: ffff8880252bc198 (&dev->mutex){....}-{4:4}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf0e/0x1260 kernel/hung_task.c:491
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 4c 63 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d f3 82 17 00 fb f4 <e9> 4c 0d 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000197df8 EFLAGS: 000002c2
RAX: 000000000008bab9 RBX: 0000000000000001 RCX: ffffffff8b928c29
RDX: 0000000000000000 RSI: ffffffff8de4d731 RDI: ffffffff8c161100
RBP: ffffed1003c5d488 R08: 0000000000000001 R09: ffffed10170a6655
R10: ffff8880b85332ab R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801e2ea440 R14: ffffffff90aaf390 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881247c6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561297f2f660 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x391/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x148
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

