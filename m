Return-Path: <linux-kernel+bounces-801892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ADFB44B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2527E48823F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B41EB5D6;
	Fri,  5 Sep 2025 01:27:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6F72625
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035626; cv=none; b=gGhW61kcZ3eo5v3MwuG0pueQolmUdU6DdXETEJ0Ika4ljKSz0c2XWyO2bKYlFJStqEpROSRiiMEZeHtsgBN25OZNr85Bg3Cd2Dnwe/uRndsVr/ajLeefC3GVvSbXC/ELSNWynokTHnpcumJ6nVwUe0uCvzYY6GMh1/JqraJBCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035626; c=relaxed/simple;
	bh=93JY4xz2xRgtpaGRIN3WA/KsqZvJnxKKmqN8yQX5AyE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eCZfPYdlyK/TfB8NbSo501hI/4DqpifZPCIBmD99T0CmH/MFrZjcCaRnZ8KFTMTGnOjsIqJRbfsHmmwNvNrg+NHe160nPN4akmbs3DHPjkHZNQqGr0mXPBcGBeDZkVZG//sZdLFpFqIl1h/uCLLTzZlU8ZS6nf5t5PprM8F3vjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed39b8563cso39927805ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757035624; x=1757640424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mo7TK3mXNTwp8MB3UkBrmUVU82XM7lgXM+Yr+S1F9QY=;
        b=whKvYTcdsGnXWnWetRCL//IwkHXmMCehVsQ+Hi8uSmaiaZ8BhHgLGYzmdso0/4pS6p
         LZvimMyFXfR6RPnl/Obf07vwZaFbp1eP85nmJsGovZkpB/8bn3fPW+OduqURFsXMfrua
         yhssjtIVapVatbbVrnaMIGB97o4slcK+zAnJp+k53iWJPleQ9u7mxp9QhViqk/s6SRz7
         Q7QHu3cqSXtgShdzynFUjJ5nWusMi3SVn7XzMXwdQrlVnNMw1Q2LVCo8WGXyqHALi5GP
         Ni/5qBah8ibbN/i0Oig+iotZd61qic2+M2h5Sx74gEOx6xdEmeOogTaD4kc0Z48cnkgx
         kkeA==
X-Gm-Message-State: AOJu0YynlJDSuucUOrMps9bcM3lYaibQV/z2NhD0JQMt4OS9xybhNOkQ
	i2sPHiz+sckDAaQuzgzMTPzrDwI/27F5Hgvl020+4rogy7u2zAUzAjLEcaqkErleg3RlB4bMW3i
	wBWDwrKGjNKvouGn+DSCyvBDSFdvJvrui5Fj7T5N2a25bdZ+WdNZO576KZwY=
X-Google-Smtp-Source: AGHT+IFiaZTcDLLEAo50h2nb7GDb86TdbmU//rXSw4h/8b5kX7qai41u2qX4e/HwHtqE45EXZHAqNJ0Q/KYpT6Wf+SUsREw3RfTA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3f0:db99:aad8 with SMTP id
 e9e14a558f8ab-3f40047622fmr311540135ab.11.1757035623960; Thu, 04 Sep 2025
 18:27:03 -0700 (PDT)
Date: Thu, 04 Sep 2025 18:27:03 -0700
In-Reply-To: <20250905004621.1849126-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ba3c67.a00a0220.eb3d.000e.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_perform_write
From: syzbot <syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in v9fs_evict_inode

INFO: task syz-executor:10275 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23976 pid:10275 tgid:10275 ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 netfs_wait_for_outstanding_io include/linux/netfs.h:552 [inline]
 v9fs_evict_inode+0x26f/0x300 fs/9p/vfs_inode.c:348
 evict+0x3e3/0x920 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput fs/inode.c:1923 [inline]
 iput+0x521/0x880 fs/inode.c:1909
 dentry_unlink_inode+0x29c/0x480 fs/dcache.c:466
 __dentry_kill+0x1d0/0x600 fs/dcache.c:669
 dput.part.0+0x4b1/0x9b0 fs/dcache.c:911
 dput fs/dcache.c:901 [inline]
 do_one_tree fs/dcache.c:1607 [inline]
 shrink_dcache_for_umount+0x159/0x3e0 fs/dcache.c:1621
 generic_shutdown_super+0x6c/0x390 fs/super.c:621
 kill_anon_super+0x3a/0x60 fs/super.c:1282
 v9fs_kill_super+0x3d/0xa0 fs/9p/vfs_super.c:195
 deactivate_locked_super+0xc1/0x1a0 fs/super.c:474
 deactivate_super fs/super.c:507 [inline]
 deactivate_super+0xde/0x100 fs/super.c:503
 cleanup_mnt+0x225/0x450 fs/namespace.c:1375
 task_work_run+0x150/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcecc38ff17
RSP: 002b:00007ffd3a66f178 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fcecc411c05 RCX: 00007fcecc38ff17
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd3a66f230
RBP: 00007ffd3a66f230 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd3a6702c0
R13: 00007fcecc411c05 R14: 000000000003f589 R15: 00007ffd3a670300
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1260 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1260 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1260 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:3/37:
 #0: ffff88801b881148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc90000ad7d10 ((work_completion)(&rreq->cleanup_work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
2 locks held by getty/5606:
 #0: ffff88814d69e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036bb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
1 lock held by syz-executor/10275:
 #0: ffff88805bc120e0 (&type->s_umount_key#68){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805bc120e0 (&type->s_umount_key#68){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805bc120e0 (&type->s_umount_key#68){+.+.}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88805bc120e0 (&type->s_umount_key#68){+.+.}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
1 lock held by syz-executor/14777:
 #0: ffffffff8e5cc6c0 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x48/0x6e0 kernel/rcu/tree.c:3815

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
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
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__bfs+0x1ba/0x290 kernel/locking/lockdep.c:1815
Code: 01 15 44 29 cb 81 e3 ff 0f 00 00 39 1d df f5 45 14 48 89 04 f5 00 6a 98 96 73 0c 89 1d cf f5 45 14 eb 04 4c 89 78 30 48 8b 00 <4c> 39 c0 75 f4 e9 2b ff ff ff b8 01 00 00 00 48 83 c4 28 5b 5d 41
RSP: 0018:ffffc90000117300 EFLAGS: 00000006
RAX: ffffffff9770e2a8 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000111 RSI: 0000000000000001 RDI: ffffc900001173c0
RBP: 0000000000000030 R08: ffffffff95dd9b90 R09: 0000000000000001
R10: ffffc900001174a0 R11: 0000000000000000 R12: ffffffff81974ec0
R13: ffffc900001173a0 R14: ffffffff819759d0 R15: ffffc900001173c0
FS:  0000000000000000(0000) GS:ffff8881246b6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555593ff75c8 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __bfs_backwards kernel/locking/lockdep.c:1860 [inline]
 check_irq_usage+0xcb/0x920 kernel/locking/lockdep.c:2796
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x12bc/0x1ce0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 lock_hrtimer_base kernel/time/hrtimer.c:171 [inline]
 hrtimer_try_to_cancel+0xa9/0x2f0 kernel/time/hrtimer.c:1362
 update_curr_dl_se+0x42c/0xa10 kernel/sched/deadline.c:1468
 update_curr+0x3fb/0x550 kernel/sched/fair.c:1243
 pick_task_fair+0x171/0x330 kernel/sched/fair.c:8753
 pick_next_task_fair+0x20/0x1010 kernel/sched/fair.c:8778
 __pick_next_task+0xf1/0x6c0 kernel/sched/core.c:6001
 pick_next_task kernel/sched/core.c:6099 [inline]
 __schedule+0x5d3/0x5de0 kernel/sched/core.c:6902
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:7145
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 on_each_cpu_cond_mask+0x75/0x90 kernel/smp.c:1045
 on_each_cpu include/linux/smp.h:71 [inline]
 smp_text_poke_sync_each_cpu arch/x86/kernel/alternative.c:2653 [inline]
 smp_text_poke_batch_finish+0x7b4/0xdb0 arch/x86/kernel/alternative.c:2946
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x376/0x550 kernel/jump_label.c:919
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate mm/kfence/core.c:850 [inline]
 toggle_allocation_gate+0xfa/0x280 mm/kfence/core.c:842
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         d69eb204 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1551b162580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=b73c7d94a151e2ee1e9b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dd1312580000


