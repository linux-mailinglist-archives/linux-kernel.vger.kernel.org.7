Return-Path: <linux-kernel+bounces-734591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F07B08397
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627C1A454B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DB1EB9E1;
	Thu, 17 Jul 2025 03:55:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053244A11
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752724505; cv=none; b=APiOmaOtBnsNmsAMdmk3lcErfh77/POjX1UcuBLA3zE55G6iB/7Pc2IY7lrxoj0Kj3mhrMnT+vC1oCuLifwO6VO8AOOAoHhM8wHR6oK8/gdqNMY4ttgCJO5YqH1vwmkaaxt5dfKT/OE4mxaSF7Q1h+8ccDRtOJub/k61tM+EnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752724505; c=relaxed/simple;
	bh=uMqR9YeljcNjJOg5Q5GY+Iw977S6CLucGyLgjCrPbIQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AKR67zNAe3kphesADT7iUvkqoGAdrNdA6TLipvoPMjIf0Bp0fdXjJY86Qs2rXuhluHClCD7bwgn3bqA7dJ4B8QQXgXLajsptM93r8DfCqS550/on49XJL1Qt3J1X9fIA7oCtuAYaYlba3XCciV+0Cp6C2hB/uJWCH3QJneT+8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-875bd5522e9so46023139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752724503; x=1753329303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6vNO+KHbmwMPuw1xVmkccFDZAOgyQcKEsbczf1QR28=;
        b=nFfOa+PGVZe1X4bGZ2fBBbJ3Ndwz2PBQPP4oOYRnRY/xKli7ioOZnW1ptT0yN7aD4E
         wTUCXAOl2M1SdM5pWGtAek2W3klpdV/BkF8/8e2H1nR14oCxSGiBulh0zndOkYsWUbqQ
         VpnwM58Djsuh6A+TnpXhvBZzhilu3E54TCHuvG8u0o271v08RzLyXHwNQI7KGF0QYoN+
         K+sKVtgeGFEn/aV3oxFejMZnRQb+M8wK2GI2hZSZpnyIn9VNe1hWn42QxHLF+Eg2n5XQ
         2+xllgH5yz+UyDyo89iFhdmyJUTPqK3n6IM3vtJlIlyIcGkm4RjjzbdIkb+BPBfMXv0K
         45Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX6eskNeXdRlGl792A2EfyUqkAiRygxa77GRRhZcJNGP26PtdefqPlES6xgnyLSPyhRj7G3vexKZE2GQH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomFLb1M8gfsvYsqz5U0uVYKYIbdgXvGK7/Ttk6dA3Fi2KTY1r
	NKOfEmZikEbDdB8kp8ZRufc6+FT1hS3TC84ZTppPgiM+X8SG8sLCyadtPhjxwxKwZvkOOTgQ9S4
	iRNslEc5C6IohjNf1jjgDhby6q3ocLs+4yev1bQf4TauuG8ctrLWgvsurjl8=
X-Google-Smtp-Source: AGHT+IHaKC2B+CBLkmls+II5lLbYTJxioCF5F+T1QSg/VN3D1bjKThTP+5B+vkJU0emoTWM3Ypkocyd67oyEBSpK5YxGDWur5dp0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:6513:0:b0:873:35c8:16f9 with SMTP id
 ca18e2360f4ac-879c28d0ee3mr499571839f.8.1752724503108; Wed, 16 Jul 2025
 20:55:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 20:55:03 -0700
In-Reply-To: <20250717014623.2253-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68787417.a70a0220.693ce.0037.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot (2)
From: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hdanton@sina.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in exit_mm

INFO: task syz.0.16:6665 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.16        state:D stack:26920 pid:6665  tgid:6665  ppid:6577   task_flags:0x40044c flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5314 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6697
 __schedule_loop kernel/sched/core.c:6775 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6790
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
 rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1088
 __down_read_common kernel/locking/rwsem.c:1263 [inline]
 __down_read kernel/locking/rwsem.c:1276 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1541
 mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 exit_mm+0xcc/0x2c0 kernel/exit.c:557
 do_exit+0x648/0x2300 kernel/exit.c:947
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f524bb8e963
RSP: 002b:00007ffc99164708 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: fffffffffffffffc RBX: 00007f524b5ff6c0 RCX: 00007f524bb8e963
RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffc99164860
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
 </TASK>
INFO: task syz.1.17:6807 blocked for more than 144 seconds.
      Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.17        state:D stack:26920 pid:6807  tgid:6807  ppid:6787   task_flags:0x40044c flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5314 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6697
 __schedule_loop kernel/sched/core.c:6775 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6790
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
 rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1088
 __down_read_common kernel/locking/rwsem.c:1263 [inline]
 __down_read kernel/locking/rwsem.c:1276 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1541
 mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 exit_mm+0xcc/0x2c0 kernel/exit.c:557
 do_exit+0x648/0x2300 kernel/exit.c:947
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc6b58e963
RSP: 002b:00007ffe5b639e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: fffffffffffffffc RBX: 00007efc6afff6c0 RCX: 00007efc6b58e963
RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffe5b639fe0
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
3 locks held by kworker/0:3/981:
3 locks held by kworker/u8:9/3028:
 #0: ffff8880b8739f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:606
 #1: ffff8880b8724008 (per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:937
 #2: ffff8880b8725918 (&base->lock){-.-.}-{2:2}, at: lock_timer_base kernel/time/timer.c:1004 [inline]
 #2: ffff8880b8725918 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x1ae/0xf30 kernel/time/timer.c:1085
2 locks held by getty/5607:
 #0: ffff88814df960a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz.0.16/6665:
 #0: ffff8880242d4260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff8880242d4260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.0.16/6666:
1 lock held by syz.1.17/6807:
 #0: ffff88807b8c57e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88807b8c57e0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.1.17/6808:
1 lock held by syz.2.18/6831:
 #0: ffff88807e36c260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88807e36c260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.2.18/6832:
1 lock held by syz.3.19/6858:
 #0: ffff88807b8c2ce0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88807b8c2ce0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
3 locks held by syz.3.19/6859:
1 lock held by syz.4.20/6888:
 #0: ffff88801a476d60 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88801a476d60 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.4.20/6889:
1 lock held by syz.5.21/6925:
 #0: ffff88801a472220 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88801a472220 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.5.21/6926:
1 lock held by syz.6.22/6955:
 #0: ffff88807f93b7a0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88807f93b7a0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.6.22/6956:
1 lock held by syz.7.24/6990:
 #0: ffff88807c9ec260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
 #0: ffff88807c9ec260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
1 lock held by syz.7.24/6992:
2 locks held by dhcpcd/6995:
 #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
 #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
 #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:967
1 lock held by dhcpcd/6996:
 #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
 #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
1 lock held by dhcpcd/6997:
 #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
 #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
2 locks held by dhcpcd/6998:
 #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
 #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
 #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:967

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:491
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:__this_cpu_preempt_check+0xe/0x20 lib/smp_processor_id.c:64
Code: 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 c7 c7 00 65 e3 8b <e9> bd fe ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90
RSP: 0018:ffffc90000a08bc8 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffffffff822479bd RCX: da4b2af8b834fd00
RDX: ffff888029254d90 RSI: ffffffff8d994444 RDI: ffffffff8be36500
RBP: ffffc90000a08ed0 R08: 00000000c506ef33 R09: 00000000624b5ae2
R10: 000000000000000e R11: ffffffff81ac3010 R12: 0000000000000000
R13: ffffffff81a7e844 R14: ffff88801cecda00 R15: 0000000000000286
FS:  0000000000000000(0000) GS:ffff888125ce2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a7ec2b0660 CR3: 000000005fa88000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lockdep_hardirqs_off+0x74/0x110 kernel/locking/lockdep.c:4514
 trace_hardirqs_off+0x12/0x40 kernel/trace/trace_preemptirq.c:104
 kasan_quarantine_put+0x3d/0x220 mm/kasan/quarantine.c:207
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free_after_rcu_debug+0x129/0x2a0 mm/slub.c:4730
 rcu_do_batch kernel/rcu/tree.c:2584 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2840
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:833 [inline]
 nsim_dev_trap_report_work+0x7c7/0xb80 drivers/net/netdevsim/dev.c:864
 process_one_work kernel/workqueue.c:3239 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         e8352908 Add linux-next specific files for 20250716
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1523c58c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2594af20939db736
dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10776382580000


