Return-Path: <linux-kernel+bounces-793287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A30B3D18D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360EF17E79D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D5253954;
	Sun, 31 Aug 2025 09:14:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D224DFF4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631645; cv=none; b=BvY8xqCwaoOGRWw+jvXNc6iyAH4nkx+MOKZZj7mJtQylCbRkEPX1bEpU1Nk9slLX980Ugmd4xRhxFHGy0VwIHI/CgyW3VmFCGREJfIoeAfo9cMTWsRGvEEyllWZYwMKvMmK/AmUmsYPLw5D/Rj1/40FA+PZBiC/RlfO7gb1Cl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631645; c=relaxed/simple;
	bh=vqwUr4PJdLzaL+PV0nB/Nuw0k7o8LZZXJCtEefjmQ0A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LBJTtx4cStwlADVbp5MJUeSbQ9W7ahNIvocXXjiNkW2+VzvZ1VVajK4KjsooM2ILtZ9uTxitU25LELa7XBSyUbkW3P81yWZVBp4I6Eb/B0UzwTwMWAnYml3lyqixEQTCDcgUZYQQkHIzd2+BbafKY7qt6O5pa7TKunDHpPTYras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f340e9b5c5so38315035ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631643; x=1757236443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTgXpDb1YhEkvxCEigA/jIv6QjnIbxoxZPcFqHYLo6Q=;
        b=LYJTikZJHGOfikHe8455BSnEknpYvBzY8yVRH0SshtJrI9OqGvLDNEl3V/5FzN3b9H
         YtGd4ORIBIetKZxYJVFes/yOg0r+rw467j9/a7IVMFqVIaf+8PkBQkfdSMgv1hJt2Jir
         DJUYRL0TB/hxFMEGvLenXaMipCvxL4CIfIotlQy81bTBRxZ/uAjYLN1p/OWvE4+YCZBG
         LsfT2ffS8Md1iX2GLHcktDPghe5Jlmg2BVC/DkJfPGVHTHI/t2ppBII+dPrBNYPxF27q
         WwnERzJ4ln45EVo9PZlQ7B6k7iCFNL+JzZQ36ttVht023f3bt0t68iBg2qOovMkkS/ZU
         z0iA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0qrq6/1iN4idjUBf1zEgU1EMgrZGkhG0eL/7w4yrWl1dHKs8e+IF6bs4TuF9sk8PtnkwVwtmdseU43M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOno4uxfTpCMQeGElUaNAhiP++QSwor71kk7Ybu65SBaaKr/3
	VNQH5Bl8WxS3bJWYATxBOjC4HEx99vBk/EdMhwlxJnX2HC4CLje6aTKoUoC2hxCClZL6XsVGDMg
	RN/nE9DY18QRo5COSFOTSNQGbjkj7dq8JS+DKx9FCxf41ds1+Y1xNwz03uJk=
X-Google-Smtp-Source: AGHT+IFGQgEwDK6kXf5+JSL2v19XTf+EKwzMt8yAxAvFMsPxdKwHP1DM+8p/068WJHSN+TfipccTYhK0j82iBI3CoxFsMWQG7yoy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:3ec:2c8a:f35 with SMTP id
 e9e14a558f8ab-3f4019f6ae7mr94936475ab.18.1756631642765; Sun, 31 Aug 2025
 02:14:02 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:14:02 -0700
In-Reply-To: <20250831084130.6242-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b4125a.050a0220.3db4df.01b1.GAE@google.com>
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __vhost_worker_flush

INFO: task syz.0.17:6497 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27928 pid:6497  tgid:6497  ppid:6385   task_flags:0x400040 flags:0x00004004
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
RIP: 0033:0x7f970df8ebe9
RSP: 002b:00007ffdf6784698 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f970e1c7da0 RCX: 00007f970df8ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f970e1c7da0 R08: 0000000000000000 R09: 00000008f678498f
R10: 00007f970e1c7cb0 R11: 0000000000000246 R12: 000000000001e9d9
R13: 00007ffdf6784790 R14: ffffffffffffffff R15: 00007ffdf67847b0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
1 lock held by klogd/5210:
 #0: ffff8880b843a318 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:636
2 locks held by getty/5611:
 #0: ffff8880361060a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 0c 62 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 12 16 00 fb f4 <e9> 4c 09 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000197df8 EFLAGS: 000002c2
RAX: 000000000016ae1b RBX: 0000000000000001 RCX: ffffffff8b93fc29
RDX: 0000000000000000 RSI: ffffffff8de50a38 RDI: ffffffff8c162980
RBP: ffffed1003c5d488 R08: 0000000000000001 R09: ffffed10170a6655
R10: ffff8880b85332ab R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801e2ea440 R14: ffffffff90ab5290 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881247b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cc5af69be0 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x391/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x148
 </TASK>


Tested on:

commit:         c8bc81a5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102a7a62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124cc1f0580000


