Return-Path: <linux-kernel+bounces-851470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76CBD694E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0DE94F7FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B052E9EA8;
	Mon, 13 Oct 2025 22:08:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628613DBA0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393315; cv=none; b=MvqoPbEdYAmGgZgIt7mhMiZtSTLmAbRNscSizLjq8KG0FDISBDZinIaTfUFV/TzafPpHPnWtKblAryN2PaKd+6fDTnsOtAms0fNU544w2Dc8nW8tcEPNuEpZZiFW/hKbrzT4i8VnECeDfTLmMECWwJYaV6pxug4MetJm9S0n4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393315; c=relaxed/simple;
	bh=kjNnr5VDlN6Wh41AKgP1HdqxVz+te2xB2CD25EOGiGI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MRyeLXd8kQccifK2BQnUr/MUh8w64ehQ0TJhBmCTTfHlNgA21Ty6CJB4kxVPoEQINqFcPLDy/NYetOwkeyglaK6Tp1GEloUIHsgg8xAn67rVou9I5SxEwyfa95TMZQ7Jov+Ou0Ta6e1fOArsd6RPqhMtTy+JKZMqDLOCMchFcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42f8824b65fso289179325ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393313; x=1760998113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIbIgugtklvHTqqJJgJ+BdTc9znNIGMO83GoObH33ZA=;
        b=oof82gBsadnfANbsM+6TVXSAMd7H4Sa08D79cFIeYukfKDXYeR51+C+Q5Hn5CgT4n8
         PYjV3FHcx5o5rBdLkZotDMNC3A7Cw+y1XaD+1B3XEEW1JZ9/3hNOWyUehmk9cuSAIKnO
         tq/P7O9hBtyB7GL9TZ/PbJhf+CWL4cgR4ZxejHJX4hH/1g3GN958I2MPA6s/e4eMyPD/
         K91WGbTtXJVCDXT1oE0astDyc7C5tgITGboLg5JtcsBALiGoBbo0BFL8AL4ZEKOx7qwI
         5oO0lYFFyD/IOhOqjKwjmrNjE3FrtWGY9e8pGy8JJH9c0WhB24ShZGn7Fp5KOtYp8SWI
         XBlA==
X-Forwarded-Encrypted: i=1; AJvYcCWGhpTa9qN7iSwdNzgKlgNhh2VgZdUCzDtBsf7vUHK7GI6QkDA3ndu/aA494PqbZDA4TtrY5ujtqVosWVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfI+z8PSbbIKtfhaNF4DkhtgawPRwzzlhTchhQJoDME0PmCYr
	gek6yje+yD380tOrL31/2yA/4qynN7mNL7ybld3m5MQtGLcoSdQi09sW+bu5QYOC9QVbPakTl9/
	hluRgXADb0/z10waf04/L5ViH5FsEVEwjDLsZSYmH70hCtiDKQBpPxrD7NvM=
X-Google-Smtp-Source: AGHT+IGwirS9dcCgq4QyeX3JxDsTTYwLGyx3bt+7kcItEESXGjdvumqlKkFUVuU4LSZJPPQ1J83SZsDSMKfqfJSaPxNpdo7iRwQG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:42f:9353:c7af with SMTP id
 e9e14a558f8ab-42f9353c8bfmr202885975ab.4.1760393312850; Mon, 13 Oct 2025
 15:08:32 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed7860.050a0220.ac43.003d.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in p9_fd_close (3)
From: syzbot <syzbot+ed53e35a1e9dde289579@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b763d465239 Add linux-next specific files for 20251010
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=166ab304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=ed53e35a1e9dde289579
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ab304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12758c58580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a00344625c3/disk-2b763d46.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd34c500f8eb/vmlinux-2b763d46.xz
kernel image: https://storage.googleapis.com/syzbot-assets/660905c62cb2/bzImage-2b763d46.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed53e35a1e9dde289579@syzkaller.appspotmail.com

INFO: task syz.0.20:6088 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.20        state:D stack:26696 pid:6088  tgid:6087  ppid:5996   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
 __flush_work+0x9b9/0xbc0 kernel/workqueue.c:4273
 __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4393
 p9_conn_destroy net/9p/trans_fd.c:909 [inline]
 p9_fd_close+0x251/0x430 net/9p/trans_fd.c:944
 p9_client_create+0xd1c/0x10b0 net/9p/client.c:1060
 v9fs_session_init+0x1d7/0x19a0 fs/9p/v9fs.c:410
 v9fs_mount+0xc8/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0xfd/0x1a0 fs/fs_context.c:663
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f91ced8eec9
RSP: 002b:00007f91cfbb6038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f91cefe5fa0 RCX: 00007f91ced8eec9
RDX: 0000200000000540 RSI: 0000200000000180 RDI: 0000000000000000
RBP: 00007f91cee11f91 R08: 0000200000000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f91cefe6038 R14: 00007f91cefe5fa0 R15: 00007ffd736e9798
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:0/9:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900000e7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900000e7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by kworker/0:1/10:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900000f7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900000f7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by kworker/1:0/24:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900001e7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900001e7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
1 lock held by khungtaskd/31:
 #0: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kworker/1:2/982:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900039f7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900039f7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
5 locks held by kworker/u8:5/1314:
5 locks held by kworker/u8:6/1334:
 #0: ffff8880b873a058 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:638
 #1: ffff8880b8724048 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
 #2: ffff8880b8725958 (&base->lock){-.-.}-{2:2}, at: lock_timer_base kernel/time/timer.c:1004 [inline]
 #2: ffff8880b8725958 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x1ae/0xf30 kernel/time/timer.c:1085
 #3: ffffffff99c711e0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0xbb/0x420 lib/debugobjects.c:818
 #4: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #4: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 #4: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0xa5/0x2390 arch/x86/kernel/unwind_orc.c:479
2 locks held by getty/5592:
 #0: ffff88803400a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
2 locks held by kworker/1:3/5829:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc90003f2fba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc90003f2fba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by kworker/1:4/5923:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc90003b9fba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc90003b9fba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by kworker/0:4/6056:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900030c7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900030c7ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by kworker/0:5/6192:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc90003537ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc90003537ba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by kworker/0:8/6344:
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88813fe55948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900044bfba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900044bfba0 ((work_completion)(&m->rq)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
2 locks held by dhcpcd/6414:
 #0: ffff88802c816258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
 #0: ffff88802c816258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x33/0xd30 net/packet/af_packet.c:3197
 #1: ffffffff8e142d78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #1: ffffffff8e142d78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:957

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 e1 1b 00 f3 0f 1e fa fb f4 <e9> c8 e6 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 1d6302149d16bc00 RBX: ffffffff8196bc07 RCX: 1d6302149d16bc00
RDX: 0000000000000001 RSI: ffffffff8d7e9b20 RDI: ffffffff8bc079e0
RBP: ffffc90000197f10 R08: ffff8880b8732fdb R09: 1ffff110170e65fb
R10: dffffc0000000000 R11: ffffed10170e65fc R12: ffffffff8f9e1870
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff11003a54b58
FS:  0000000000000000(0000) GS:ffff888125e0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005598ff692660 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e7/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
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

