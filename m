Return-Path: <linux-kernel+bounces-848784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55FBCE8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDC6A4F32FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2463019D2;
	Fri, 10 Oct 2025 20:49:34 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6020D4FC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129373; cv=none; b=qMz8YcR5hDQfrgDc5xxlO6e7Fu1YQeQbS9aP+qBFbGL4LVlX9uKZmgrH6XiyiWWcvUYZzkQPuqKJR/nvjaYsOrg0lVkOQiGC7M4FEc58LyCRw+ENXesvkoRmkrATYG2QgEFzZXdfP5YeXAgGMVU5Gx3cN6f6dsfEMD463gywgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129373; c=relaxed/simple;
	bh=4mXEDrrhypEPQz5+piye9uYxO7tpXkYE1dLsqf9WOWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eKuSb6lEr+VuxZx2MZ78pMI99UPgGRzGdBr3hU/f4q5naRIqweAAohW6koSrTBdaHXknjiLVGxmfMwnrVPuq9yUScK6STkNaCgc+i50xvjWZ5ZH3eP3H59Jl2JLuZWGUs5LX9e9pnv0koVedKfYVATng1gUjhhtLR9ZqqEYVIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-91fbba9a0f7so648429639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760129371; x=1760734171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVTuNA5ql/hfwpigfYYlQPJxWzzwq1mutn6TW1faGDc=;
        b=JhjeXBMEB3azBLqOkNQBvbOqJUfz4MjPqHlgfpsBM4DpKiHoXDz1eTprzqE5uD4u8M
         1wSMPBg2Xzn1IlPVvcMxkoX341+I7HpW8jpEc6DWgK9HyIrUjsaskdzeICQ9SKxhxu4V
         0hqGPuejVTZ2U3+pChu1G6fKkPcwjMdvHS8bVu0XsxmSqhTsLT5RhOwLHHHhJM7Pcqxj
         BOFLdkhPDktRIKprfoF/cxYjd6IKQO6ktWSUrTBtaXpqJw6Zdc1wir99UOf4IuH0a4FG
         s/na+PjkX6rUB53Y8WZQwBRZhUlLw0/+I2ZOVXCDBqXRrWFvDSvtpmTZGlmT7wSEKsBt
         9Pvg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOzG2qrOPyazmr17n5cjbPW9WV1ffu+FAmp2sAokApvzoV/tgSXeRL8j5TiI8anDYf3pYc1JZJjq40Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnHd8L/gGrinufNWKOJk2fokrm9Cld2RDsHku8Qc/L1Le65NP
	2Pt1PxBgN/LV1jrtr/C3RrnwnJHhJirydXnBwgyQdPrGw7E8C3hy/W8dHBVl+7uHXVDhwWIcTSZ
	EcUsr9Lq2refIG2tvAlT7v7cuxd2InOEotbCYnxtT3hH9bEjHr0MVVFbcZZk=
X-Google-Smtp-Source: AGHT+IHERW+nUmEOlATq80l3hR5CUDLi7PBeUhA2oX2u4Llm8FukPKlwcJMO0eyD7Bvcp4YXHpBQekoM8i3qWsItcW+OigqaQFt8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1582:b0:90e:3ea6:f77e with SMTP id
 ca18e2360f4ac-93bd18b9faemr1631985639f.4.1760129370865; Fri, 10 Oct 2025
 13:49:30 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:49:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e9715a.050a0220.1186a4.000d.GAE@google.com>
Subject: [syzbot] [mm?] INFO: task hung in __rmap_walk_file
From: syzbot <syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	harry.yoo@oracle.com, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, riel@surriel.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5472d60c129f Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d69304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b213914b883d014
dashboard link: https://syzkaller.appspot.com/bug?extid=2d9c96466c978346b55f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133e89e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f3ba7c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-5472d60c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af61e8db8b22/vmlinux-5472d60c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2c11e401d8a/bzImage-5472d60c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com

INFO: task syz.5.48:5749 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.48        state:D stack:27656 pid:5749  tgid:5747  ppid:5477   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1261 [inline]
 __down_read kernel/locking/rwsem.c:1274 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1539
 i_mmap_lock_read include/linux/fs.h:568 [inline]
 __rmap_walk_file+0x227/0x620 mm/rmap.c:2905
 remove_migration_ptes mm/migrate.c:471 [inline]
 unmap_and_move_huge_page mm/migrate.c:1520 [inline]
 migrate_hugetlbs mm/migrate.c:1641 [inline]
 migrate_pages+0xc98/0x2930 mm/migrate.c:2080
 do_mbind mm/mempolicy.c:1539 [inline]
 kernel_mbind mm/mempolicy.c:1682 [inline]
 __do_sys_mbind mm/mempolicy.c:1756 [inline]
 __se_sys_mbind+0xa47/0xc40 mm/mempolicy.c:1752
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd36cd8eec9
RSP: 002b:00007fd36dccd038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fd36cfe5fa0 RCX: 00007fd36cd8eec9
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000200000001000
RBP: 00007fd36ce11f91 R08: 0000000000000040 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd36cfe6038 R14: 00007fd36cfe5fa0 R15: 00007ffec3386808
 </TASK>
INFO: task syz.5.48:5754 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.48        state:D stack:26920 pid:5754  tgid:5747  ppid:5477   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 io_schedule+0x80/0xd0 kernel/sched/core.c:7871
 folio_wait_bit_common+0x6b0/0xb80 mm/filemap.c:1330
 __folio_lock mm/filemap.c:1706 [inline]
 folio_lock include/linux/pagemap.h:1141 [inline]
 __filemap_get_folio+0x139/0xaf0 mm/filemap.c:1960
 filemap_lock_folio include/linux/pagemap.h:820 [inline]
 filemap_lock_hugetlb_folio include/linux/hugetlb.h:814 [inline]
 hugetlbfs_zero_partial_page+0xae/0x610 fs/hugetlbfs/inode.c:654
 hugetlbfs_punch_hole fs/hugetlbfs/inode.c:708 [inline]
 hugetlbfs_fallocate+0xb91/0x1100 fs/hugetlbfs/inode.c:741
 vfs_fallocate+0x666/0x7e0 fs/open.c:342
 madvise_remove mm/madvise.c:1049 [inline]
 madvise_vma_behavior+0x31b3/0x3a10 mm/madvise.c:1346
 madvise_walk_vmas+0x51c/0xa30 mm/madvise.c:1669
 madvise_do_behavior+0x38e/0x550 mm/madvise.c:1885
 do_madvise+0x1bc/0x270 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __x64_sys_madvise+0xa7/0xc0 mm/madvise.c:1985
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd36cd8eec9
RSP: 002b:00007fd36dcac038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fd36cfe6090 RCX: 00007fd36cd8eec9
RDX: 0000000000000009 RSI: 0000000000600002 RDI: 0000200000000000
RBP: 00007fd36ce11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd36cfe6128 R14: 00007fd36cfe6090 R15: 00007ffec3386808
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u4:0/12:
 #0: ffff88801a479948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88801a479948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900001e7ba0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900001e7ba0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:303
1 lock held by khungtaskd/26:
 #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
5 locks held by kworker/u4:6/1041:
 #0: ffff88801b6f8948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88801b6f8948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900025b7ba0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900025b7ba0 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffffffff8f4d4c50 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf7/0x820 net/core/net_namespace.c:669
 #3: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0xdc/0x890 net/core/dev.c:12807
 #4: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #4: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:957
1 lock held by dhcpcd/5017:
 #0: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x323/0x1b50 net/ipv4/devinet.c:1120
2 locks held by getty/5110:
 #0: ffff88803597c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000018e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz.5.48/5749:
 #0: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: i_mmap_lock_read include/linux/fs.h:568 [inline]
 #0: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: __rmap_walk_file+0x227/0x620 mm/rmap.c:2905
3 locks held by syz.5.48/5754:
 #0: ffff88801ebe2420 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3111 [inline]
 #0: ffff88801ebe2420 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f0/0x7e0 fs/open.c:341
 #1: ffff888011d3f348 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #1: ffff888011d3f348 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: hugetlbfs_punch_hole fs/hugetlbfs/inode.c:683 [inline]
 #1: ffff888011d3f348 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: hugetlbfs_fallocate+0x3cc/0x1100 fs/hugetlbfs/inode.c:741
 #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: i_mmap_lock_write include/linux/fs.h:548 [inline]
 #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: hugetlbfs_punch_hole fs/hugetlbfs/inode.c:691 [inline]
 #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: hugetlbfs_fallocate+0x4b5/0x1100 fs/hugetlbfs/inode.c:741
2 locks held by syz-executor/20402:
 #0: ffffffff8ec74400 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8ec74400 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8ec74400 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8e9/0x1c80 net/core/rtnetlink.c:4064
1 lock held by syz.4.7446/21125:
 #0: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #0: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:957

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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

