Return-Path: <linux-kernel+bounces-825679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F3B8C7BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F0E1B26BFB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614893009D4;
	Sat, 20 Sep 2025 12:19:36 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992727B329
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370775; cv=none; b=eB6reCX6IREbf/ghVKCoeFmiJQK+pU84wnabrdbWxJ3CHIaWRcGkKAUAjbQ6zqNCfMlzHslt5dN2BvyVqjfcuBvyAQwjwKmMovZxjfBY4PO6oRYaBFn53diJXXU5WcxJntVg9oTLjdN5l5fEqV3Xg7lVYE8sHTJH3QhYHtlrw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370775; c=relaxed/simple;
	bh=T4l6Icg4ndZUdoZvRS/31tkTklp+eNXThh2+2qEooeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hoLWQzKtyNm4MeMWRjwze+H8puZIf/bEFi9PhPHR6SkLYZjPAFPB0l/M2KxdGH/w2GR2qvmMj6h5dknfBDxi8IhOh8E/LJ4GRBkDeBvzzP+3prJFCjJeEJcJol7BtmGO9wSo5nt5iXiiG6bJYpkeuaeR40EdZlRu/iW3LGHpvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-425635e2928so3621455ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 05:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758370773; x=1758975573;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75BhtGCxuclbzYByP5JnJJlEqgQWYSuejqrISwjyxpw=;
        b=tY/jsdj9+pQGFKRQvtzZrBYi/mDMlJrcynrdrFVaihFmzLoNeGr0Bcd569XMe+FEcu
         96Yjl+sXoImb+Xo0Rw84Sh4COQf3AaPHUS8d4W+BKYv/p6Kg0pxC51v+MnIMCjdVI48M
         3/1nB0ecZsLrxlI747DNfuoQ7bz/W281pnebtpG/LL+ILap9NJ3XZ5M5pQhBuntTcEO+
         JkNJZJgoiymcZQQNJyZ6FuRRxf/EyZpkXwkCQnJas+YuppumyDxxdCZo+4iOJFzqAiS5
         yNWaNlzYs8MgRKdzta1BNKWPS7HIq18urC4Mdxhjo1cAFrx3DlLSte5y8LKPAGtRgwCQ
         sltQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7RiWrQLDDBmGXsLb+/kBFsJJrIl/NVHZ26vXYbIUgcJiW7Q1t634TGWCLbixzLxApysIjkK6CajXFt4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5QHHF5Ks3iDhzFWSGdVVzu0SZABlSuKXPd+/grkYTK/HrTIS
	zTjAI/Sr613sBqswAKuW2udKRFRfXjXVSY+4SFJw7ULaIo21mYL5Ed2cXwjeizVlBQgehcQk69/
	giZ/R8khpnasMhWymILPkAcWSXu/hTNqOEFiVjMvDjM3Im8atiYOR2SleZ5Q=
X-Google-Smtp-Source: AGHT+IEXnn8/Kf33GEPpgvOu4Zm0v3HkBUCqHcNdLVAfK2kbwMnCWXXfE1RK76KagUOiehH2Qq38IXfdDvcB/eGHV/MAbCxQEPrZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3782:b0:412:c994:db15 with SMTP id
 e9e14a558f8ab-42481947474mr105745755ab.14.1758370773216; Sat, 20 Sep 2025
 05:19:33 -0700 (PDT)
Date: Sat, 20 Sep 2025 05:19:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce9bd5.a00a0220.37dadf.0028.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in rds_tcp_listen_stop (3)
From: syzbot <syzbot+b3b8ea37bd20c5ffe24c@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1522b530ac3e Merge tag 'block-6.17-20250918' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a510e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b8ea37bd20c5ffe24c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35d453c89d0e/disk-1522b530.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a88828d9934c/vmlinux-1522b530.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c1dc4a65e69/bzImage-1522b530.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3b8ea37bd20c5ffe24c@syzkaller.appspotmail.com

INFO: task kworker/u8:4:8310 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:4    state:D stack:25080 pid:8310  tgid:8310  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:121
 __flush_workqueue+0x3e2/0x1230 kernel/workqueue.c:4000
 rds_tcp_listen_stop+0x104/0x150 net/rds/tcp_listen.c:331
 rds_tcp_kill_sock net/rds/tcp.c:611 [inline]
 rds_tcp_exit_net+0xcb/0x810 net/rds/tcp.c:634
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x2eb/0xab0 net/core/net_namespace.c:251
 cleanup_net+0x408/0x890 net/core/net_namespace.c:682
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1420 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1420 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1420 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
1 lock held by syz-executor/5863:
1 lock held by syz-executor/5870:
3 locks held by kworker/u8:4/8310:
 #0: ffff88801c6fe948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc900037e7d10 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
 #2: ffffffff90372890 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xad/0x890 net/core/net_namespace.c:658
2 locks held by getty/10914:
 #0: ffff8880314e20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f302f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
1 lock held by syz.1.1114/11849:
 #0: ffffffff90372890 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x286/0x5f0 net/core/net_namespace.c:566

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
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
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

