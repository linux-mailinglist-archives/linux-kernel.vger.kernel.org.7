Return-Path: <linux-kernel+bounces-821772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D051B82340
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356842A86E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A205C311947;
	Wed, 17 Sep 2025 22:54:33 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83D311597
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149672; cv=none; b=O7TAVZ8OM8VwJM5i/gpJ107cFvmaRLiNephtu+kSfuRco+uEX4Ihwg43v97gxiOV1v4pNmJMCDoTPzZ3Nh9bigCWfRDssOznalwb7gfkKN2C/i3yJ9xllUnN1RMDCE5Wdn58cDRZT1r/ChUyqVMVXqkilg1jt4x6fxdQXwgjuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149672; c=relaxed/simple;
	bh=6Bc9Z56nvJY3AWg21VhVUwCOOEP8u77ZBI6X9yvD97c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XnhI/mdxTKMK25TKC0uaXgzhF/exh9llo7wr2Nb9m8Oog+ecdy1C1edNnQS7Nw7MxJC5hmnCm30bHkNPvLb28YtvPIKcKKaq1bkDCTo8ooBP00GZhxCsRY7an7RcFJOp+UxnnkI7pCdIGMzm6Yq4pVtrNs7OVSXtDGW0JMH/sVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so4126505ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149669; x=1758754469;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06CHxq/WPG0PVFhPJ86gevsyl51sBseWlIvVlv/rxLk=;
        b=wOBTUUrU3mhhxqY51adtuLuenUwaKbo3NElq0OkdjikbYP3Ez2rzKzjYXehM5ujrID
         KppazQ1SsjjXQvuwcCp7mox2wbZaRzt/TpZy9oG4hNmomwoX9K1o5ykv5VkiBXQG2BFm
         nJALcCohxttXaGeGdMasqXkE+dsx5CqKOx8IG12xWBLJV2BDqYwduP7SMF9QdbBY4lGy
         GqL02D0NAUA8xGJwISgXMz4NRMQNAweja+t0zsWFWVvz1XB4OyzMP/VN62i6HOIFxJZC
         TTRMgv7ImxxbB35lyZY+i4aSbxb5hPZhnaJEaKvuXbMK+p1qVJ2zZN+UARg39coYvPst
         O/3g==
X-Forwarded-Encrypted: i=1; AJvYcCV5sR2jFAQNeeH/XhHSUCAAvk0CS1H8JypXi3U2iGzXlC9iMDvb4Cg+UcKHwffJeRas4dlejlzLC164CL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AoWOAzB7SZ6WeZxx5KH/jvQjsHd6dC+GUuOzjWzh4q9nUAsj
	gzAEKmFGj710mcPr8DtpRlN0BiAR5oHauoE4t8vYpzXl1zx2rgBCrizkjlfMDpXCfd1Jh/AUwsU
	vlqynkUE75Bq46RDfnCaF/FCJ1Ud8jrbzyjxNMCl2coTkntIuxsWJAHBYNaI=
X-Google-Smtp-Source: AGHT+IGnF1kzCknSSj/AFh2KkQ3+LYXq/Co4yAUkJINTnQzr+DXx5+E7Y5FpeJlFQWQ89vlaSorffmr1EQuDWA2dlbWW+V8ARoEX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194a:b0:401:9e1:ce68 with SMTP id
 e9e14a558f8ab-4241a4e1ef1mr55600385ab.13.1758149669199; Wed, 17 Sep 2025
 15:54:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:54:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb3c25.050a0220.50883.002a.GAE@google.com>
Subject: [syzbot] [bfs?] INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1735fb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1498ce42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1372f47c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6619a20dd985/disk-46a51f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1bd79f3645b/vmlinux-46a51f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf4ae36aa984/bzImage-46a51f4f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5effb040f80e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com

INFO: task syz.0.17:6050 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27944 pid:6050  tgid:6048  ppid:5989   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
 __lookup_slow+0x297/0x3d0 fs/namei.c:1808
 lookup_slow+0x53/0x70 fs/namei.c:1825
 walk_component fs/namei.c:2129 [inline]
 link_path_walk+0x935/0xea0 fs/namei.c:2497
 path_parentat fs/namei.c:2701 [inline]
 __filename_parentat+0x246/0x670 fs/namei.c:2725
 filename_parentat fs/namei.c:2743 [inline]
 filename_create+0xd2/0x3c0 fs/namei.c:4120
 do_mkdirat+0xa0/0x590 fs/namei.c:4391
 __do_sys_mkdirat fs/namei.c:4416 [inline]
 __se_sys_mkdirat fs/namei.c:4414 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4414
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2cbfd8eba9
RSP: 002b:00007f2cc0c24038 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f2cbffd6090 RCX: 00007f2cbfd8eba9
RDX: 00000000000001ff RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f2cbfe11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2cbffd6128 R14: 00007f2cbffd6090 R15: 00007fff497ab7d8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
 #0: ffff88801a481148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801a481148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000127bc0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000127bc0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8f539f48 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:303
1 lock held by khungtaskd/31:
 #0: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kswapd0/85:
2 locks held by kworker/u8:9/3515:
 #0: ffff8880b8639f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
 #1: ffff8880b8624008 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
3 locks held by kworker/u8:11/3585:
 #0: ffff88802f1b4148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88802f1b4148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc9000c50fbc0 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000c50fbc0 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8f539f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8f539f48 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4734
2 locks held by getty/5618:
 #0: ffff8880331760a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.0.17/6049:
2 locks held by syz.0.17/6050:
 #0: ffff88805b33c160 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff88805b33c160 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff88807eec4ad8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
2 locks held by syz.1.18/6074:
2 locks held by syz.1.18/6075:
 #0: ffff888075e98160 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff888075e98160 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff888142f9ecd8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
3 locks held by syz.2.19/6105:
2 locks held by syz.2.19/6106:
 #0: ffff888075e98680 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff888075e98680 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff88807ff9f8d8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
2 locks held by syz.3.20/6130:
2 locks held by syz.3.20/6131:
 #0: ffff88805b33c680 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff88805b33c680 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff88807669e6d8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
2 locks held by syz.4.21/6163:
2 locks held by syz.4.21/6164:
 #0: ffff888075e98ba0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff888075e98ba0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff88807e38ead8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
4 locks held by syz.5.22/6201:
2 locks held by syz.5.22/6202:
 #0: ffff88805b33cba0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff88805b33cba0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff888079c822d8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
2 locks held by syz.6.23/6232:
2 locks held by syz.6.23/6233:
 #0: ffff88805b33d0c0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: inode_lock_shared include/linux/fs.h:885 [inline]
 #0: ffff88805b33d0c0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff88807f1d6ed8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_lookup+0xe3/0x1d0 fs/bfs/dir.c:136
3 locks held by syz-executor/6236:
 #0: ffffffff8eca94a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8eca94a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8eca94a0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f539f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f539f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f539f48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4056
 #2: ffffffff8e13fb78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #2: ffffffff8e13fb78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:957

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6105 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:32 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:109 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:127 [inline]
RIP: 0010:lock_release+0xaa/0x3e0 kernel/locking/lockdep.c:5885
Code: 92 41 83 bf ec 0a 00 00 00 0f 85 1e 02 00 00 49 81 3e 20 73 64 93 0f 84 11 02 00 00 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 <48> 8b 5c 24 20 fa 48 c7 c7 ce d9 9c 8d e8 64 f3 dc 09 65 ff 05 0d
RSP: 0018:ffffc900031e7118 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffffff81aac64d RCX: 2a325ada796eef00
RDX: 0000000000000000 RSI: ffffffff8be33e60 RDI: ffffffff8be33e20
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff81aac64d
R10: dffffc0000000000 R11: ffffffff81ac4b00 R12: ffff88807c293c00
R13: ffffffff81aac64d R14: ffffffff8e13a0e0 R15: ffff88807c293c00
FS:  00007f813c8526c0(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563fc1d6aa38 CR3: 0000000032a9c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 is_module_text_address+0x18b/0x1e0 kernel/module/main.c:3847
 kernel_text_address+0x94/0xe0 kernel/extable.c:119
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfc/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_node_noprof+0x276/0x4e0 mm/slub.c:4382
 kmalloc_array_node_noprof include/linux/slab.h:1020 [inline]
 alloc_slab_obj_exts+0x39/0xa0 mm/slub.c:2033
 __memcg_slab_post_alloc_hook+0x31e/0x7f0 mm/memcontrol.c:3174
 memcg_slab_post_alloc_hook mm/slub.c:2221 [inline]
 slab_post_alloc_hook mm/slub.c:4201 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x2bf/0x3c0 mm/slub.c:4247
 alloc_buffer_head+0x2a/0x270 fs/buffer.c:3025
 folio_alloc_buffers+0x32d/0x640 fs/buffer.c:935
 grow_dev_folio fs/buffer.c:1075 [inline]
 grow_buffers fs/buffer.c:1116 [inline]
 __getblk_slow fs/buffer.c:1134 [inline]
 bdev_getblk+0x286/0x660 fs/buffer.c:1461
 __bread_gfp+0x89/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 bfs_find_entry+0x1c2/0x420 fs/bfs/dir.c:333
 bfs_lookup+0xf1/0x1d0 fs/bfs/dir.c:137
 lookup_open fs/namei.c:3686 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0x1101/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f813b98eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f813c852038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f813bbd5fa0 RCX: 00007f813b98eba9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007f813ba11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f813bbd6038 R14: 00007f813bbd5fa0 R15: 00007fffad51a318
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

