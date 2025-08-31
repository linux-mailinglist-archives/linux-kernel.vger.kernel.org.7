Return-Path: <linux-kernel+bounces-793248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC30B3D110
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107453BA80D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196A221FC4;
	Sun, 31 Aug 2025 06:29:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57074192B66
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756621747; cv=none; b=aJ0smLM+wtVS0PlQxZvRvf2mliVcphz7eE5d/dVnN2O2ED1YfvrcI3Flkalm+TeohjLgD4bbdvrqoHqZV2imqUFJW9XHMv/NOyxqRNrMmD87yrlktXm1EIdwZvjhNZTzgEW5Pu9B17wR+sVGmRmHFsxtlS1dgwOH91Yz4U+krVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756621747; c=relaxed/simple;
	bh=Bo1bFOBd5L7oOlWQxw69Z5qYHq7Q54MMvs4QURS9uAc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mXkfNAXap5ELswcnrW3VOw4/0io9C2MKX3mzOZoQQpl9mcaf/NkNlPlqYH9CUsPeGYEmoqM6gDZZoRjFsI4qdpFmuc5wuoZmrxHN70tC/HjU/I7TuYd1xcCJcrVBhjiQWui2pLnzkVScDbvOqpty1tlzIROrR2nQbvpBwTT3s8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ee1d164774so51435225ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 23:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756621744; x=1757226544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlN/OMq221hSbCNSJvZw1KKUtVLeVcdWKFWjVSmBW3o=;
        b=KMFmF3pBeBl2opoz6Qm+vv3Cx5yVNAaoiAW2UqxKE1xWazmqfxbCulauAt2C+ps99O
         CiG0JwSXzmRy9QC1bYlgiMOMGLQ6lkr/bc2hw2VSwUvj68dqTecLTu6vMTLetq1k8nFq
         PhKGe4bfJyO/9xv+u5kjTiUwQFoSPWgFvXqEQEpCljzbkCoNCcpuTJM7hHGD2tBX1zMZ
         u5qvBeWXm1cXRecxYTLhMg6bcHxsZd1asUsz7iqjobhas7pLG4HfIXK1Z1gSlCg91NAi
         2Vwmcil1bokfkJjXs8i+u+jN4+/pl5kxkWEvlTrghVSvRPynBgWkhH6mJyYlZemFjYok
         0zUg==
X-Forwarded-Encrypted: i=1; AJvYcCVUkTetZEDKgG1ohrR5C0muItV5pAaNNLpBccgJUID21eIaZ3xkt/NCqFA2G3fbSwqbpngjAdaVYRiAXgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxer/NSpKvB0/PyC8gvAJkj6kYkPwTYSCu75SYnfXb9uZT91bgE
	NsL9mlSbVbz1RtGfRAPxheBIJzZt6UixpK4vGZTXzhCBq1SZXWAzfgCdj8aS9+wSEegYR4iTtJ4
	T1Rx8L0ld/zFhq4c5plujOePvg4aqQimHRgH2leTEDJ/NTjeRHdwI8v7OUe4=
X-Google-Smtp-Source: AGHT+IGYuhUijBLC/04yqOlLmio3TH5G4B5a+vfgV3SyToXLKbsDC9HtHz73nHOirTYFWmjCULfZ0hxKdFQZ3b4uP9kA/B4LFueE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:3f3:3a9a:9ce8 with SMTP id
 e9e14a558f8ab-3f3d60dc5c4mr113243865ab.10.1756621744492; Sat, 30 Aug 2025
 23:29:04 -0700 (PDT)
Date: Sat, 30 Aug 2025 23:29:04 -0700
In-Reply-To: <20250831055402.6159-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b3ebb0.a00a0220.1337b0.002d.GAE@google.com>
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __vhost_worker_flush

INFO: task syz.0.17:6534 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:26264 pid:6534  tgid:6534  ppid:6428   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:121
 __vhost_worker_flush+0x1a8/0x1d0 drivers/vhost/vhost.c:296
 vhost_worker_flush drivers/vhost/vhost.c:303 [inline]
 vhost_dev_flush+0xac/0x110 drivers/vhost/vhost.c:313
 vhost_vsock_flush drivers/vhost/vsock.c:698 [inline]
 vhost_vsock_dev_release+0x19f/0x400 drivers/vhost/vsock.c:750
 __fput+0x3ff/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f15c9b8ebe9
RSP: 002b:00007fffe67e3fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f15c9dc7da0 RCX: 00007f15c9b8ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f15c9dc7da0 R08: 0000000000000000 R09: 00000008e67e42df
R10: 00007f15c9dc7cb0 R11: 0000000000000246 R12: 000000000001d5b5
R13: 00007fffe67e40e0 R14: ffffffffffffffff R15: 00007fffe67e4100
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
5 locks held by kworker/u8:4/59:
3 locks held by kworker/u8:6/2981:
 #0: ffff8880b853a318 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:636
 #1: ffff8880b8524088 (psi_seq){-.-.}-{0:0}, at: psi_sched_switch kernel/sched/stats.h:220 [inline]
 #1: ffff8880b8524088 (psi_seq){-.-.}-{0:0}, at: __schedule+0x1861/0x5de0 kernel/sched/core.c:6955
 #2: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 #2: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: batadv_nc_worker+0x159/0x1030 net/batman-adv/network-coding.c:719
2 locks held by getty/5607:
 #0: ffff88803612d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000362c2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222

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
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 0c 62 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 12 16 00 fb f4 <e9> 4c 09 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e207e08 EFLAGS: 000002c2
RAX: 000000000018d07d RBX: 0000000000000000 RCX: ffffffff8b93fc29
RDX: 0000000000000000 RSI: ffffffff8de50a38 RDI: ffffffff8c162980
RBP: fffffbfff1c52ef8 R08: 0000000000000001 R09: ffffed1017086655
R10: ffff8880b84332ab R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8e2977c0 R14: ffffffff90ab5290 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881246b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dea603fc80 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x391/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 rest_init+0x16b/0x2b0 init/main.c:744
 start_kernel+0x3ee/0x4d0 init/main.c:1097
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x148
 </TASK>


Tested on:

commit:         c8bc81a5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14882242580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121b41f0580000


