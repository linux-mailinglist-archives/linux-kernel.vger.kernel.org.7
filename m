Return-Path: <linux-kernel+bounces-751404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CDB16932
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5AD16677B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B755226CF7;
	Wed, 30 Jul 2025 23:05:42 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311892264D3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916741; cv=none; b=k25tir1eK+PXcLXRcaUk7ToMgPaf47FAq7sIu8GZlC0GYn0bGzRotoJOCS5Cxlr4qvA3PgrLqWk83OVeZSPQQwRp6if7V0ikLb7xG4gOQkZscsxEvaJIOXIfLPPwJ7LZwEmnATQgMyvXj2qQ7vIJOG+FqPv4lv32w5GOqVcXHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916741; c=relaxed/simple;
	bh=w4Qznet9/4kSnMby8rdcHEHhPP0yVSofyMrFPXGStks=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G3YrKBa3jk+X1mXt3pSnTWAjFAQ4YRx6y8Da2StYaNius04CgO7vo9iedKhSsztljbxXYKpXXfMjY5HiEndEcsp+KhhltCor2Bhu97c595C0yeCcKnF0F4n9B7Y2ryV3ZcCuUHzevlteXkFMXFnwuvWLaBdk5xXBK09DdMLFvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3e973055fso6100185ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753916739; x=1754521539;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WupEvVecvzGgVHKWUVZidsbwyM0n4Sqpj33g67c98BU=;
        b=N0qG2nGkiAUgSd8Yzrd3yJgt6O6L5dPQQA2887DvHEEiJOnh3v0ltmCXjwT+odxKW/
         cXeqeHUiZAi9KCu9O92dooQnnRQFRNKpQ97ces4wCDenLZ4AG1TfTpOxvUYZiVWzVwox
         fUR/6su66ufHpk6Np0TvBPTrU2aecG1/FiDl9WKOa2gKPud1TMTXUdKIBT47hMSJQz9b
         wVbkO+WLYzEKGIUhwuTfQ2EXCREsNzzcpc5Dc33e/0BSfe+Gl4v9kkzdVxlcXJU4P0Tx
         7/gMX2+igpefFtzAp71cN3zpgkpD1Psd4S6632Z/n+HMjD3k5JtsatWqHEiFTpLqB9jr
         GCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUArqhk/5jMiolYABFJywhkdlGI3Iv+soOkto2k2N16LEizOLAueoYSwdNP4ZJc4BbHrotzBllxQaD/EhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mYS5ilZdv9l4JAWjBVHwHXZULUDxU/HGizKjvQSuJ+sfMac0
	HDcFE0McgjUB+py7uNcvAKnJDM3Ie5qo9m9/8/20ncVORH8vcKNnagoTwJ/SCSDnYoeC6sRGV3p
	pAE0ORgqWYy/asiKMxYkPvRp9qVepozjg3aSWKL323YSK/SAf1SQ2/CZgK+E=
X-Google-Smtp-Source: AGHT+IFIqa8UObAP2bub6nVOZ9YDrm6e6Ni35zIa/yslUp8rsR0WBzSekOa1jkCtbZlMo0+9x8KUXazXSrAo8BDFwkGv6kPa1NJb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3046:b0:3e2:a7a1:8cd8 with SMTP id
 e9e14a558f8ab-3e3f60e0567mr98326265ab.5.1753916739276; Wed, 30 Jul 2025
 16:05:39 -0700 (PDT)
Date: Wed, 30 Jul 2025 16:05:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688aa543.a00a0220.26d0e1.0030.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in hidp_session_remove
From: syzbot <syzbot+234fdcc5f6633833a35c@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    733923397fd9 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10997f70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=234fdcc5f6633833a35c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aa4a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12997f70580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-73392339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be7feaa77b8c/vmlinux-73392339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a663b3e31463/bzImage-73392339.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+234fdcc5f6633833a35c@syzkaller.appspotmail.com

INFO: task khidpd_15e20040:5506 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:khidpd_15e20040 state:D stack:29000 pid:5506  tgid:5506  ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:148
 __flush_work+0x9b9/0xbc0 kernel/workqueue.c:4246
 __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4366
 hidp_session_remove+0x62/0x260 net/bluetooth/hidp/core.c:1169
 l2cap_unregister_user+0x18e/0x1b0 net/bluetooth/l2cap_core.c:1734
 hidp_session_thread+0x3c9/0x410 net/bluetooth/hidp/core.c:1304
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.0.171:5661 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.171       state:D stack:27240 pid:5661  tgid:5661  ppid:5462   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6964
 l2cap_sock_connect+0x5c5/0x7a0 net/bluetooth/l2cap_sock.c:256
 __sys_connect_file net/socket.c:2038 [inline]
 __sys_connect+0x313/0x440 net/socket.c:2057
 __do_sys_connect net/socket.c:2063 [inline]
 __se_sys_connect net/socket.c:2060 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2060
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e5c78e929
RSP: 002b:00007ffe356d7bb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3e5c9b5fa0 RCX: 00007f3e5c78e929
RDX: 000000000000000e RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00007f3e5c810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3e5c9b5fa0 R14: 00007f3e5c9b5fa0 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/9:
2 locks held by kworker/0:1/10:
1 lock held by khungtaskd/26:
 #0: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
2 locks held by getty/5125:
 #0: ffff8880317890a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000018e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
2 locks held by khidpd_15e20040/5506:
 #0: ffff8880330c80b8 (&hdev->lock){+.+.}-{4:4}, at: l2cap_unregister_user+0x6a/0x1b0 net/bluetooth/l2cap_core.c:1728
 #1: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_remove+0x2c/0x260 net/bluetooth/hidp/core.c:1165
1 lock held by syz.0.171/5661:
 #0: ffff8880330c80b8 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6964
1 lock held by syz.1.172/5698:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.2.173/5730:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.3.174/5761:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.4.175/5805:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.5.176/5841:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.6.177/5879:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.7.178/5914:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026
1 lock held by syz.8.179/5957:
 #0: ffffffff8f6ae9b0 (hidp_session_sem){++++}-{4:4}, at: hidp_session_find+0x1a/0x100 net/bluetooth/hidp/core.c:1026

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
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

