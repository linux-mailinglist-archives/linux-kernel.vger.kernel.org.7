Return-Path: <linux-kernel+bounces-761753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73566B1FE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B773B75BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEDE247298;
	Mon, 11 Aug 2025 03:13:38 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2713AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754882018; cv=none; b=ey31mjnTxsAmXte6sWcZ6/kVKmmaj/leOT9mytWabpchpDrAGkuqzzrhDtZQYNH3qMv07j0SW2Zaih0JuTmseItGvVQevimygH6tbOmR+tGCqImoA/s6jIvEqJ/HgJ3BgdkM8ioCUaK56k1l+rgLLG+CsaJDwTWQ+GwIgRem4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754882018; c=relaxed/simple;
	bh=1ldSvqLpow780r0Wpa5mYBvA0pVNW4ZUOtDrrBaahF8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=joKEuqFhC/zbcXbLJeC+xF6k8skFvsvaKYi7RLHKPZwDflsVetAueTpSQUC4lwQ8pQM/kbmUkw8nd/xLBTLOOb3CvW7mwVI4mk3p4zgESVNzMX+ViE03p2umgcWOpefDHE/NXrTZh4iF+aJdyQh2mGpexGy+W0kh2BXF0BAnsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8816e763309so384832539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754882015; x=1755486815;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BEJ6HI0E3GfV7j1qKxNTbLrJfQPDuSQLOAPXJ0Gx9s=;
        b=EOjuIiRb7yxjkr8EWf96auak4l4sHn0nXp5MzFkK+Ecvg5euJuZGC/69/Bn/g7W+xO
         ekHYp7I0gP2Ib1enLfoBl8WuU8kF2Ul4u6mfm0FfLJ4xMd7rlIyMFy0UW6j0c88evjML
         HIuYQ1Zq5YQmDz06VXsSg8hJB/rQQxBI+QU4kH+oiUiG/WQKfv+pvLQYxIQSw9IH+B0S
         6YSdPIdltFPQ2UX5ewl6ffIIQzqpGvSp4/sxPLOaBvvilfvY24iVdL+CVtvkU3/RKm9q
         p1DaQQxf1gPFFkDF/BOKR7eZXUwxha/zzT6YlzcSKe8/kcxV8koHMANrliF1p+04loEv
         RYsw==
X-Forwarded-Encrypted: i=1; AJvYcCUF64d0ySWvzhuETenfqv3uFKSwvpdJO2xmbA2iKplQQ5I0R1xRa7M5nMaQaxLTx8bDl4dKs84HpDNojXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrq0XogQxFFfjZP1gzelg6+txRxbJhTfHWBkMRhUStcBF12P+I
	8n7bNwDs/Prr3y/o0MbjCkTsATVid8X9gsNRiLiBBJp3cVpDKEFfym2vFeQXlXM60vnPXwPDm8W
	x1a3wfebNQ9D+6MbX/jGYa1JrcApGrKwjUZkdADaoSqY0MLLvwjKcORFSiaQ=
X-Google-Smtp-Source: AGHT+IFXt+FHNOJszidktyYeWqw9KTMULIreDIvwaBR2mOR4+bumOfCMP5rRfLoJDWJtm6HOnBsFMwltPgxLJ/i2Iul588AejbLj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:628a:b0:87c:2540:2338 with SMTP id
 ca18e2360f4ac-883f11af054mr1985074739f.2.1754882015560; Sun, 10 Aug 2025
 20:13:35 -0700 (PDT)
Date: Sun, 10 Aug 2025 20:13:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68995fdf.050a0220.7f033.00e8.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in block_invalidate_folio (2)
From: syzbot <syzbot+85194ada5aabdfff265b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    479058002c32 Merge tag 'ata-6.17-rc1-fixes' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16b7d6a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=85194ada5aabdfff265b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14641042580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15eda434580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1650700d2cd2/disk-47905800.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83bf9b805048/vmlinux-47905800.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9cae2a559c08/bzImage-47905800.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6d12a3c13c7b/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=169362f0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85194ada5aabdfff265b@syzkaller.appspotmail.com

INFO: task kworker/1:1H:95 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1H    state:D stack:27176 pid:95    tgid:95    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: gfs2-glock/syz:syz glock_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x80/0xd0 kernel/sched/core.c:7903
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit_lock+0xec/0x4f0 kernel/sched/wait_bit.c:93
 out_of_line_wait_on_bit_lock+0x123/0x170 kernel/sched/wait_bit.c:120
 wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
 __lock_buffer fs/buffer.c:71 [inline]
 lock_buffer include/linux/buffer_head.h:432 [inline]
 discard_buffer fs/buffer.c:1606 [inline]
 block_invalidate_folio+0x376/0x730 fs/buffer.c:1663
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0x2d8/0x430 mm/truncate.c:160
 truncate_inode_pages_range+0x233/0xda0 mm/truncate.c:379
 do_xmote+0x6e7/0x1260 fs/gfs2/glock.c:757
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1095
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor410:5883 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:25128 pid:5883  tgid:5883  ppid:5880   task_flags:0x400100 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
 __flush_work+0x9b9/0xbc0 kernel/workqueue.c:4244
 flush_work kernel/workqueue.c:4265 [inline]
 flush_delayed_work+0x13e/0x190 kernel/workqueue.c:4287
 gfs2_clear_rgrpd+0xd7/0x690 fs/gfs2/rgrp.c:731
 gfs2_put_super+0x8a7/0x950 fs/gfs2/super.c:635
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1766
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1378
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 ptrace_notify+0x281/0x2c0 kernel/signal.c:2520
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x1d0 kernel/entry/syscall-common.c:111
 syscall_exit_to_user_mode_work include/linux/entry-common.h:173 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2ad/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc361d61587
RSP: 002b:00007ffef83329e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000555584179338 RCX: 00007fc361d61587
RDX: 00000000000108d0 RSI: 0000000000000009 RDI: 00007ffef8333b90
RBP: 0000000000000064 R08: 0000555584182773 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffef8333b90
R13: 0000555584182700 R14: 431bde82d7b634db R15: 00007ffef8334c20
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
5 locks held by kworker/u8:2/36:
2 locks held by kworker/1:1H/95:
 #0: ffff88807c887548 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88807c887548 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900025dfbc0 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900025dfbc0 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
2 locks held by getty/5617:
 #0: ffff8880336520a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036c32f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz-executor410/5883:
 #0: ffff88807c9340e0 (&type->s_umount_key#42){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88807c9340e0 (&type->s_umount_key#42){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88807c9340e0 (&type->s_umount_key#42){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:506

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:mark_held_locks kernel/locking/lockdep.c:4313 [inline]
RIP: 0010:__trace_hardirqs_on_caller kernel/locking/lockdep.c:4351 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare+0x155/0x2a0 kernel/locking/lockdep.c:4410
Code: 75 bc eb 79 48 c7 c7 d0 ac 00 8e 4c 89 fe e8 d2 4f 61 03 eb c2 85 c0 7e 64 83 bb d0 0a 00 00 00 74 5b 45 31 ff eb 13 49 ff c7 <48> 63 83 e8 0a 00 00 49 83 c6 28 49 39 c7 7d 43 49 83 ff 31 73 2c
RSP: 0018:ffffc90000ac7680 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffff8881416f9e00 RCX: ffffffff93492018
RDX: 0000000000000006 RSI: ffff8881416fa8f0 RDI: ffff8881416f9e00
RBP: ffffc90000ac7810 R08: ffffffff8fa34137 R09: 1ffffffff1f46826
R10: dffffc0000000000 R11: fffffbfff1f46827 R12: ffff8881416faa08
R13: ffff88801a46e558 R14: ffff8881416fa8f0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d24000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055feacc3c660 CR3: 000000000df36000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:78
 __text_poke+0x748/0xa10 arch/x86/kernel/alternative.c:2527
 text_poke arch/x86/kernel/alternative.c:2552 [inline]
 smp_text_poke_batch_finish+0x90a/0x1130 arch/x86/kernel/alternative.c:2885
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x250 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xad/0x240 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.546 msecs


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

