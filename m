Return-Path: <linux-kernel+bounces-759208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B544AB1DA4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D38585EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF4265298;
	Thu,  7 Aug 2025 14:45:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17802E36F7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577905; cv=none; b=adbOQGkHzq6ig13JTRfUlHfcvwM+wV6Yhp4HQ3biCHjMh6KY9ZAcOrpIV5gAbUSyMMLG5DL6uhmazgbxFY1eYrNuC2iYS2+sb6tURXiSvngevxPGqBC88jSt8RR8plZ0RUc0NsreZmNI5q+pziqjkmvQ/GKC0ZV3LgG5sl8r/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577905; c=relaxed/simple;
	bh=IQvNjWNP7oB07ClwtwFWL69LkBbb9QO+GWdiNrEyVgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tDm0/C4rTtC1jgAz6gFAiidA0LocAwDP/gRbv0oU3lZ1P2kSk2A1/eClDVyDkH0eEpkZtLEQFc22EkU5alasKTCtwBNa6cxHi6Yud+adXdj4osEvLXjgC55qVcAe9cgFtOnsAC89Fu7FwNkmu9aWKGVd5UPeOEMEMlOuPXRyMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881878af906so196800039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754577903; x=1755182703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qp+5ZKj+7h5dSquMnel9XJmaM3eq/NIRccTETbA0x8=;
        b=LCdBTbS/SMetA5ObgQTmyQ7h5l5L+0seJJu9fDD0sjEdNlECJplqrlcZ17W5LiZYQY
         fFUNBbY8LiP4TPAdWCMT4MNmAWOTIg2Fwj5YHwnbj/BV2AOS52iXBgGxDiSOGIv2oEnP
         nZS6wQ4TuE8CRRTa6jhfGPLerLvBE0BFVfguRpbi01/A6Y+pChZhtcn4XrpzWTLuqyd8
         S9c889BXBU5A+4j1j2p9nzVVnSN0fNYpJGky8T3MxjgyXDwmuHGgOuF2OFSC5EolkER6
         m1DHoR7Kdy93hnIy8HRyKKXSyhQPnwWk8h9KbEdkr3thpG9NmtcxjNbGumEXU3M3y6Wp
         BvDw==
X-Forwarded-Encrypted: i=1; AJvYcCU39ZYC1N1qrmf8GtgXTp0oP0VchtMAg/4P0hOAIzrvzoutYQmQBqPIUELrw4tg3krGXzZ6pZAH2NvfjVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUS1OTX8SNkHaJA+w+R7xUqMMB/B2jGoIcoRmPnHNqYfraoAB
	ShoqkNzwaqqZpr5DolceMJoq1xC+0QZGmW9eZ7E2UAyHwugMvoh/KA/oPH/0gC79njPs847proZ
	0xHi7dgIh586993S5l45JVg4NpVVqqgi1CmCtKA4ZzIahBU7Y1dbTlaWS+X8=
X-Google-Smtp-Source: AGHT+IEIQ36VVE7hRvW43PbiLAzkjBROoy3TXW4rl/vwYq7ikBFClw00121B7Jhqx6hloHYbhMJHzl+XLBHX/TDfWKTdJ5mDOU77
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0d:b0:881:9412:c917 with SMTP id
 ca18e2360f4ac-883e602df7emr787656039f.0.1754577902729; Thu, 07 Aug 2025
 07:45:02 -0700 (PDT)
Date: Thu, 07 Aug 2025 07:45:02 -0700
In-Reply-To: <tencent_12A5C08DB79240DDA95D9119784FA08DAC07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6894bbee.a70a0220.7865.000b.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
From: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in nbd_queue_rq

INFO: task kworker/0:1H:56 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-06619-gd942fe13f72b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1H    state:D stack:26152 pid:56    tgid:56    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: kblockd blk_mq_requeue_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5351 [inline]
 __schedule+0x1737/0x4d30 kernel/sched/core.c:6954
 __schedule_loop kernel/sched/core.c:7036 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7051
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 wait_for_reconnect drivers/block/nbd.c:1104 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1146 [inline]
 nbd_queue_rq+0x662/0xf10 drivers/block/nbd.c:1204
 blk_mq_dispatch_rq_list+0x4bd/0x1900 block/blk-mq.c:2120
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
 __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
 blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2358
 blk_mq_run_hw_queues+0x33e/0x430 block/blk-mq.c:2407
 blk_mq_requeue_work+0x717/0x760 block/blk-mq.c:1574
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task udevd:6344 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-06619-gd942fe13f72b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:22232 pid:6344  tgid:6344  ppid:5208   task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5351 [inline]
 __schedule+0x1737/0x4d30 kernel/sched/core.c:6954
 __schedule_loop kernel/sched/core.c:7036 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7051
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 wait_for_reconnect drivers/block/nbd.c:1104 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1146 [inline]
 nbd_queue_rq+0x662/0xf10 drivers/block/nbd.c:1204
 blk_mq_dispatch_rq_list+0x4bd/0x1900 block/blk-mq.c:2120
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
 __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
 blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2358
 blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
 blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2967
 __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
 blk_finish_plug block/blk-core.c:1247 [inline]
 __submit_bio+0x2d3/0x5a0 block/blk-core.c:649
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x4ab/0xb50 block/blk-core.c:751
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x599/0x830 fs/buffer.c:2447
 filemap_read_folio+0x114/0x380 mm/filemap.c:2412
 do_read_cache_folio+0x350/0x590 mm/filemap.c:3923
 read_mapping_folio include/linux/pagemap.h:999 [inline]
 read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
 adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
 blkdev_get_whole+0x380/0x510 block/bdev.c:748
 bdev_open+0x31e/0xd30 block/bdev.c:957
 blkdev_open+0x3a8/0x510 block/fops.c:691
 do_dentry_open+0xdf3/0x1970 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f986eca7407
RSP: 002b:00007ffdca12bcc0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f986f34e880 RCX: 00007f986eca7407
RDX: 00000000000a0800 RSI: 000056006750eac0 RDI: ffffffffffffff9c
RBP: 00005600674fd910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000056006751af30
R13: 0000560067515430 R14: 0000000000000000 R15: 000056006751af30
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/0:1H/56:
 #0: ffff8881412b2d48 ((wq_completion)kblockd){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff8881412b2d48 ((wq_completion)kblockd){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000131fbc0 ((work_completion)(&(&q->requeue_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000131fbc0 ((work_completion)(&(&q->requeue_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888025119490 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff888025119490 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff888025119490 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x31f/0x4f0 block/blk-mq.c:2358
 #3: ffff88802549e178 (&cmd->lock){+.+.}-{4:4}, at: nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
2 locks held by getty/5600:
 #0: ffff88814d0e90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036be2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by udevd/6344:
 #0: ffff8880253b6358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:945
 #1: ffff888025119490 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #1: ffff888025119490 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #1: ffff888025119490 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x31f/0x4f0 block/blk-mq.c:2358
 #2: ffff88802549e338 (&cmd->lock){+.+.}-{4:4}, at: nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
7 locks held by syz.0.5658/18624:
 #0: ffff8880b8739f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
 #1: ffff8880b8724008 (per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:937
 #2: ffffffff8e8caf58 (pool_lock#2){-.-.}-{2:2}, at: class_raw_spinlock_constructor include/linux/spinlock.h:535 [inline]
 #2: ffffffff8e8caf58 (pool_lock#2){-.-.}-{2:2}, at: pcpu_alloc+0x25b/0x310 lib/debugobjects.c:273
 #3: ffff8880249d88a0 (&____s->seqcount#6){....}-{0:0}, at: exit_notify kernel/exit.c:782 [inline]
 #3: ffff8880249d88a0 (&____s->seqcount#6){....}-{0:0}, at: do_exit+0x15f2/0x22e0 kernel/exit.c:976
 #4: ffff8880770e0538 (&pid->wait_pidfd){....}-{3:3}, at: __wake_up_common_lock+0x2f/0x1f0 kernel/sched/wait.c:106
 #5: ffffffff8e1306d8 (console_owner_lock){....}-{2:2}, at: console_lock_spinning_disable_and_check+0x76/0x170 kernel/printk/printk.c:1963
 #6: ffffffff99d9a4b8 (&port_lock_key){-.-.}-{3:3}, at: uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
 #6: ffffffff99d9a4b8 (&port_lock_key){-.-.}-{3:3}, at: serial8250_console_write+0x17e/0x1ba0 drivers/tty/serial/8250/8250_port.c:3355

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-syzkaller-06619-gd942fe13f72b-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:470
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 18632 Comm: syz.0.5662 Not tainted 6.16.0-syzkaller-06619-gd942fe13f72b-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:io_serial_out+0x7c/0xc0 drivers/tty/serial/8250/8250_port.c:407
Code: 92 73 fc 44 89 f9 d3 e5 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 1c b5 d6 fc 41 03 2e 89 d8 89 ea ee <5b> 41 5c 41 5e 41 5f 5d e9 87 8e 26 06 cc 44 89 f9 80 e1 07 38 c1
RSP: 0018:ffffc9000df76bd0 EFLAGS: 00000002
RAX: 0000000000000033 RBX: 0000000000000033 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 00000000000003f8 R08: ffff888024808237 R09: 1ffff11004901046
R10: dffffc0000000000 R11: ffffffff854c1e10 R12: dffffc0000000000
R13: ffffffff99a958ea R14: ffffffff99d9a4e0 R15: 0000000000000000
FS:  00007f5db15d86c0(0000) GS:ffff888125d80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001ac0 CR3: 00000000774f4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_port_out include/linux/serial_core.h:798 [inline]
 serial8250_console_putchar drivers/tty/serial/8250/8250_port.c:3246 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:-1 [inline]
 serial8250_console_write+0x1410/0x1ba0 drivers/tty/serial/8250/8250_port.c:3396
 console_emit_next_record kernel/printk/printk.c:3138 [inline]
 console_flush_all+0x725/0xc40 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 nbd_genl_connect+0x9b0/0x18f0 drivers/block/nbd.c:2127
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5db078eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5db15d8038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5db09b5fa0 RCX: 00007f5db078eb69
RDX: 0000000020000000 RSI: 0000200000001ac0 RDI: 0000000000000004
RBP: 00007f5db0811df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5db09b5fa0 R15: 00007ffc2c157058
 </TASK>


Tested on:

commit:         d942fe13 net: ti: icssg-prueth: Fix skb handling for X..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16382058580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=484535f4eb25fe17
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1002a5bc580000


