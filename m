Return-Path: <linux-kernel+bounces-894361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D877DC49D85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B01D3ADE27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBE1A267;
	Tue, 11 Nov 2025 00:12:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA9DDC5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819925; cv=none; b=lhU0IyVF9/NieukgJbo+TH8vFcv6uustq6cvIipncV3dsmSIEmpYCpm3HsT1aX1KJbY1I4ggA5qR9gSlDgAM+aEE+3IK1Vfv3bTXEAxlTU6GQQI7ty1nvRvwzNLanH1a0O/8ZilruOnCfsF8yAxilEPSDTrf92z3wCQMZ64VQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819925; c=relaxed/simple;
	bh=+G1IPlxrb/JYBxs9vRi9f0UO7HN9g/ZrusBGzcZktio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m59MAOfSurzyE3A8O+/puItHYEGbyTD1jPu5KkW1hwWrWfEu9lD/nDeqI7HvrJDKTxg+0S+PoGl28io6+XIuUvG2ikNryp0Y2wjSfQRSn7iIdUAKDCgYd2iaGgVy3m+l4W8aQvHvvk0EW9La0l2JyhIYBgT/7WWn7fHEiXqhAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-432fb58f876so301215ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819922; x=1763424722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP/4OQV/CsJsW5sbsSwl47Xppx7yGrb4eY4o2WHDAag=;
        b=rVybvi8aRWs2uc7pAwu34yt6OLpA3cFqc/wTiBQOMY4HuKtf6lw6r/mkmaoeyiLPvX
         sUIVflTYYVCP49UrVi3hJ/1oztnoYC+pYt/rnesWEFeiO1Nv97piR4PuDqO3ORczjTnT
         grfRhVrLfGltfs13PTj8c6wSHk9luzyEhg92codcIzkvajE1DVw85sjcpa4q2MRsBB9x
         zozNL55qy2bhlEnwShVYH2ejSbX8WsigHDibCrFW4FRbliEWo0uXIDF9SYtZyzzN2Ndt
         DkSnUYvBjvoYSxqBx0jR/mYwuh2RnuN3OFlZVHat4qnuaKL0W0uaq0BO/AQ36tJcpSEv
         CPrg==
X-Forwarded-Encrypted: i=1; AJvYcCVUUU0oiDCPPYeBohv9xUKi5lGy3f4azO+m8ZVaIgNsJ/qk+ZPYgW9NWP9JSFQRm0IdaSh39Y3xZD70lMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgoLJj7HzhMs8mGga/ypjr1dt7SKaH6oEyQKOv265f6zMG5YWW
	LqMAdx9uwTAC5rgYm++rt7ik6z1ebKMnN62pBBraraGtVFQc4Sh/huLpkYRtHrSscFEpjhgp/Aq
	O7QwZLDNf1FJ77Z+F9h0240AuhzBI2WSKQ+vrHTejRLozsih018iLWNn9fmU=
X-Google-Smtp-Source: AGHT+IEVvDoh8575+bcXS2sfUI1U0NjWmxF7yxdh0teTr1Jb1ojbhY2Aztw5fbwP1deqxPeqBcAYqOpMqgR0pbGs3mec8EkWf05g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2591:b0:433:78fa:8000 with SMTP id
 e9e14a558f8ab-43378fa8345mr86530025ab.24.1762819922694; Mon, 10 Nov 2025
 16:12:02 -0800 (PST)
Date: Mon, 10 Nov 2025 16:12:02 -0800
In-Reply-To: <tencent_D9EC2EDB4C9167E306CDD2F1C64A49B2AE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69127f52.a70a0220.22f260.0113.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in lmLogClose

INFO: task syz-executor:6329 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6329  tgid:6329  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7aaeff09f7
RSP: 002b:00007fff8b07eca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f7aaf071d7d RCX: 00007f7aaeff09f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff8b07ed60
RBP: 00007fff8b07ed60 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff8b07fdf0
R13: 00007f7aaf071d7d R14: 000000000002acee R15: 00007fff8b07fe30
 </TASK>
INFO: task syz-executor:6332 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6332  tgid:6332  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53340009f7
RSP: 002b:00007fffc0564578 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f5334081d7d RCX: 00007f53340009f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffc0564630
RBP: 00007fffc0564630 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffc05656c0
R13: 00007f5334081d7d R14: 000000000002b399 R15: 00007fffc0565700
 </TASK>
INFO: task syz-executor:6333 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21512 pid:6333  tgid:6333  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ecd6409f7
RSP: 002b:00007fff36361348 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f8ecd6c1d7d RCX: 00007f8ecd6409f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff36361400
RBP: 00007fff36361400 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff36362490
R13: 00007f8ecd6c1d7d R14: 000000000002af4b R15: 00007fff363624d0
 </TASK>
INFO: task syz-executor:6334 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20968 pid:6334  tgid:6334  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f377a2509f7
RSP: 002b:00007ffd68f8e948 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f377a2d1d7d RCX: 00007f377a2509f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd68f8ea00
RBP: 00007ffd68f8ea00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd68f8fa90
R13: 00007f377a2d1d7d R14: 000000000002b4b8 R15: 00007ffd68f8fad0
 </TASK>

Showing all locks held in the system:
4 locks held by pr/legacy/17:
1 lock held by khungtaskd/38:
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
1 lock held by syslogd/5150:
 #0: ffff8881499ff598 (&ei->socket.wq.wait){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #0: ffff8881499ff598 (&ei->socket.wq.wait){+.+.}-{3:3}, at: finish_wait+0xbf/0x1f0 kernel/sched/wait.c:394
3 locks held by klogd/5157:
2 locks held by getty/5560:
 #0: ffff88823bf3c8a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e832e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor/6325:
 #0: ffff8880597e00d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880597e00d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880597e00d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6329:
 #0: ffff8880353f20d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880353f20d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880353f20d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6332:
 #0: ffff88805bfdc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805bfdc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805bfdc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6333:
 #0: ffff888035c120d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888035c120d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888035c120d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6334:
 #0: ffff888055c2c0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888055c2c0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888055c2c0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6841:
 #0: ffff888025ce40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888025ce40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888025ce40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6842:
 #0: ffff8880385120d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880385120d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880385120d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6859:
 #0: ffff8880605a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880605a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880605a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6864:
 #0: ffff888036a0a0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888036a0a0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888036a0a0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6866:
 #0: ffff8880372cc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880372cc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880372cc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz.2.269/7574:
3 locks held by syz.4.270/7576:
3 locks held by syz.0.271/7578:
3 locks held by syz.1.273/7582:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 17 Comm: pr/legacy Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:400
Code: e8 0e 05 ba fc 44 89 f9 d3 e3 49 83 ee 80 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 3f bd 1b fd 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 da 76 bf 05 cc 44 89 f9 80 e1 07
RSP: 0000:ffffc90000167870 EFLAGS: 00000202
RAX: 1ffffffff31d2100 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff98e910f0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff8504a800 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff98e90e60 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0a792a000 CR3: 000000003556c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1aa/0x2f0 drivers/tty/serial/8250/8250_port.c:1961
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3234 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3275 [inline]
 serial8250_console_write+0x1341/0x1b40 drivers/tty/serial/8250/8250_port.c:3342
 console_emit_next_record kernel/printk/printk.c:3091 [inline]
 console_flush_all+0x666/0xb40 kernel/printk/printk.c:3199
 __console_flush_and_unlock+0x9b/0x160 kernel/printk/printk.c:3258
 legacy_kthread_func+0x13b/0x1a0 kernel/printk/printk.c:3611
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         4427259c Merge tag 'riscv-for-linus-6.18-rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cb30b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1195b412580000


