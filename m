Return-Path: <linux-kernel+bounces-793440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F2FB3D35D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B6B18857D6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA39A25A341;
	Sun, 31 Aug 2025 12:45:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1E25E47D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756644306; cv=none; b=kfT6fvkYbiQ9c341ZSHyXnUwF1dbmBWr8se7xFwW5X58eY9IrhnFoy/nlXh9FXIvH/JKtNcYI4gNlnkHaKwQ6cSoNIfTez61DxEkhTbtnl3n1zzXJYqhALEwD1GPj0AaXYDju5jqhFvZ+CIkLWGyUGG223b1l4JjOMLI9K/bHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756644306; c=relaxed/simple;
	bh=Q+C3Q42XMMA4CO1tce+/iiIEHy7/uCLYowNcRNTa+fg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gQLp8pYLQdaOGnL5p7ft25bJ3L2+b1NqgL3xii2bjJtz5vp+0Qvb+kYAZUHR4HZRZ8DiG2w1XzS48duEIA9qvMx77EdEkXCT0ltS/zccyjQvuc85Wi5SOXO4zCVFM+AEK8pff3jTucSR6euYL0bWr4ivjOdyEZkwfLFQhLMDbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ed0ba44c87so42928535ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 05:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756644303; x=1757249103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R4cnDIvQcPBSkv9Qkr1oJrv/pIHrwS+U5hGlqqSfLY=;
        b=WclxglSTzKp7hgFJzTgdIO3aCr/S1U7es2Vv5L9hmYhBskBECntoyz+kPyHsYuYc/o
         ioeUTeMWRsysyqB0Z7mMWjulyKYW3q7I/71+MF3SOxdPPuYn3bKEKZjcexXFVKnN3FZr
         Qx7zf1/vPFDx9X3fNyFAoch/017HvFe5QjXrgcBcLy0Rm7x9+WGoMu4rXJ/Kze1kngsy
         fo0vUj2l3F6WIWfp8ACcwdUxJrQibl6jNoHHbHoMXNpPTWbA6vleF60/UYaa/oikhCe6
         oPXT5hZOg99Pbd/5tmZIzK9naVbglwLpZv90TChlLoy0ofCIXc8ILeoMXRvNP/5Sf9z3
         2ecw==
X-Gm-Message-State: AOJu0YyxcLO25mclo11F/1VoIjP8AtMpj/sjFNHQ+SWlmvj1SPpuUpy8
	0s3jAHnAxELgXD7UhDuhxaZUucvDYuPyLggQAuJYhuB7tnizXgeouf8vvSrx9SeDLQddZNZBHta
	xtsuCZ/uDU1hASBNQi0z1O2nhp7uxYagDsI2SJZdiiTEnj9iSHmCjA2/+y+s=
X-Google-Smtp-Source: AGHT+IGXFqzJ+4uuYAuOD4PlZ2H5T4O0LVBH1AxysYQX8WoSOUYd7YmV5QTYGt7hZEZWc8JHtCSGx+9NEcQ/36RlpEiQJev+wE3R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:3e5:51bb:9cd9 with SMTP id
 e9e14a558f8ab-3f400674ac2mr111972285ab.8.1756644303371; Sun, 31 Aug 2025
 05:45:03 -0700 (PDT)
Date: Sun, 31 Aug 2025 05:45:03 -0700
In-Reply-To: <20250831080725-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b443cf.050a0220.3db4df.01b4.GAE@google.com>
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mst@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __vhost_worker_flush

INFO: task syz.0.17:6636 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27880 pid:6636  tgid:6636  ppid:6529   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5de0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2ff/0x4e0 kernel/sched/completion.c:116
 __vhost_worker_flush+0x1cd/0x210 drivers/vhost/vhost.c:288
 vhost_worker_flush drivers/vhost/vhost.c:295 [inline]
 vhost_dev_flush+0xac/0x110 drivers/vhost/vhost.c:305
 vhost_vsock_flush drivers/vhost/vsock.c:697 [inline]
 vhost_vsock_dev_release+0x19f/0x400 drivers/vhost/vsock.c:749
 __fput+0x402/0xb70 fs/file_table.c:465
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f978f78ebe9
RSP: 002b:00007ffc3ab7e268 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f978f9c7da0 RCX: 00007f978f78ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f978f9c7da0 R08: 0000000000000000 R09: 000000083ab7e55f
R10: 00007f978f9c7cb0 R11: 0000000000000246 R12: 000000000001d01b
R13: 00007ffc3ab7e360 R14: ffffffffffffffff R15: 00007ffc3ab7e380
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c2a40 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c2a40 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c2a40 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6770
5 locks held by kworker/u8:2/36:
2 locks held by udevd/5203:
 #0: ffff8880b843a2d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:606
 #1: ffff8880b8424088 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2c1/0x8e0 kernel/sched/psi.c:987
2 locks held by getty/5594:
 #0: ffff88814dcd80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000333b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xf70/0x12c0 kernel/hung_task.c:470
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5154 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: hci9 hci_cmd_timeout
RIP: 0010:unwind_get_return_address+0x4e/0xa0 arch/x86/kernel/unwind_orc.c:369
Code: 7e 59 8b 03 85 c0 75 09 31 c0 5b 5d e9 0b 32 1a 0a 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 48 48 89 ea 48 c1 ea 03 80 3c 02 00 <75> 36 48 8b 7b 48 e8 57 9c 19 00 85 c0 74 cf 48 b8 00 00 00 00 00
RSP: 0018:ffffc90000a08828 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffffc90000a08840 RCX: ffffc90000a08794
RDX: 1ffff92000141111 RSI: ffffffff8de01fb5 RDI: ffffc90000a08840
RBP: ffffc90000a08888 R08: ffffffff913e3972 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000007c23 R12: ffffffff81a6bcc0
R13: ffffc90000a08900 R14: 0000000000000000 R15: ffff88803756c880
FS:  0000000000000000(0000) GS:ffff888124841000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffeff55cff8 CR3: 0000000028574000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 arch_stack_walk+0xa6/0x100 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x10f0 kernel/workqueue.c:2341
 call_timer_fn+0x197/0x620 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1793 [inline]
 __run_timers+0x569/0x960 kernel/time/timer.c:2372
 __run_timer_base kernel/time/timer.c:2384 [inline]
 __run_timer_base kernel/time/timer.c:2376 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2393
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2403
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2061 [inline]
RIP: 0010:vprintk_emit+0x567/0x6d0 kernel/printk/printk.c:2449
Code: 00 4d 85 ed 0f 85 19 01 00 00 e8 64 59 20 00 9c 5d 81 e5 00 02 00 00 31 ff 48 89 ee e8 c2 54 20 00 48 85 ed 0f 85 25 01 00 00 <e8> 44 59 20 00 45 31 c9 41 b8 01 00 00 00 31 c9 48 8d 05 00 00 00
RSP: 0018:ffffc900105c79c8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000023 RCX: ffffffff819ac02c
RDX: ffff88803756c880 RSI: ffffffff819ac036 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff920020b8f3b
R13: 0000000000000200 R14: ffff8880212b8000 R15: ffffc900105c7a90
 _printk+0xc7/0x100 kernel/printk/printk.c:2475
 bt_err+0xe4/0x120 net/bluetooth/lib.c:296
 hci_cmd_timeout+0x1ff/0x260 net/bluetooth/hci_core.c:1475
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         d9ea58b5 vdpa: Fix IDR memory leak in VDUSE module exit
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11068662580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4931b9b3bcbb1c4c
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

