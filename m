Return-Path: <linux-kernel+bounces-794123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF70B3DD1A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FE6189C6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06152FB973;
	Mon,  1 Sep 2025 08:55:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811247262F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716906; cv=none; b=TiiTChEJC+bOeB4oUodTwDS59+23JGxo/Vo3dW9UCpH+2IY2sExubxNBAYm6scA4GvC7kiQxsaNrvaJTC2ipHVVXtrFUj5VK9q6PzSk/6rDAAa2LeWsdI1kgmqVtqHLFfRDzTxKY6c4N04eQgtA2k6rhBNZf93cGNZnAW4lRNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716906; c=relaxed/simple;
	bh=ignJTHS+TYx8OTeK0ik8thF5g9bzlfu4QK/LBcuXyV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZBhW9vsGZyRohFvDrjJwuApKopDlereSRciZn+Ud1TGeTt9jijkK5dQBgojHT2WbUT9EOH1IGYQbxnJN9Zc+UoTQdI7UMEFLJXsEEP1Lngr9/RuSExZV2/3P6uARWp64X9TpDpQFxPyoKQea4VcCZtThKCGw1VwxhToLmS3mxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3f46ca1f136so22611315ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716903; x=1757321703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMxy3RrMFoeJXKbK9sDv44ND9YwbO2kcG/EGGCD3i4Q=;
        b=TpuWuMhFjxbzT2ezE4dhHhRDEyp5c3wIW2z7P3ZEv0LBu7SSp5xRTAqVLb0HR7iXNJ
         1zshe3c7M57Yx6WkZ4r6jvG1GD0Q3XgTe9MCFsh1Qdld/67o59kDFVNsR7NRwCMbnB28
         cUKILXOvWXt7znB4xCvGlu8dETAlG3uL3KRUs5CnQvCoeW4RcCXaSQvvOy9cD91SHcQc
         FlxWrnm8egc7zdfkNxl2bqwGuGBM4KOkt1/q1PVcX7SHZzsTaZ6G1uL0YHIzK0ak4Ffk
         lzkkOpRIhnUpyPU0pumrVXjVH+Qwmz3yjWn2ZauNDR4spPmg376EiWuoZQ23WebpfopW
         G69Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8F4QvcG2og8fIzpnRaSNlKN3Nj/yYyZQ1lL3LG4eJl1I4u9f7dFVqrPLMBp/XPO9rr2a8PkeVlhN8uc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6KpgcAFVXZ5HlxQEYOLYgmJ7Lm3djzrUxa5DoCpGzeBaeDzp
	GySca2URuicXvoR+reyHwtPMh1WU95o5zzC9nvwPNO2CCtolzBu8NrH5EJn7c3y9PQkgYlyTvcN
	LPlcrZ55cNSunalZsR5lcqdHp5qPTD0gAj0k72podDtxTnkNc8wdzVpn9rrE=
X-Google-Smtp-Source: AGHT+IGz8fB+bcQo9hPKZkesK1oRnWyJOukX9pOGoyGsjcsebPnj7qmxzangnet+nl476fjhPY2aieCcMZbQ2e04B28smrj1wDum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:3ee:b038:56c8 with SMTP id
 e9e14a558f8ab-3f400097b23mr144064125ab.3.1756716903515; Mon, 01 Sep 2025
 01:55:03 -0700 (PDT)
Date: Mon, 01 Sep 2025 01:55:03 -0700
In-Reply-To: <20250901065724.6315-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b55f67.050a0220.3db4df.01bf.GAE@google.com>
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in vhost_worker_flush

INFO: task syz.0.17:7125 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:26880 pid:7125  tgid:7125  ppid:7031   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1049/0x5e50 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x2f0 kernel/sched/core.c:6778
 schedule_timeout+0x25b/0x2a0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e4/0x600 kernel/sched/completion.c:116
 vhost_worker_flush+0xc5/0x100 drivers/vhost/vhost.c:293
 vhost_dev_flush+0xaa/0x190 drivers/vhost/vhost.c:307
 vhost_vsock_flush drivers/vhost/vsock.c:693 [inline]
 vhost_vsock_dev_release+0x1a5/0x400 drivers/vhost/vsock.c:745
 __fput+0x270/0xb80 fs/file_table.c:394
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x217/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x53/0x120 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9fadd8ebe9
RSP: 002b:00007ffc203f0568 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f9fadfc7da0 RCX: 00007f9fadd8ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f9fadfc7da0 R08: 0000000000000000 R09: 00000008203f085f
R10: 00007f9fadfc7cb0 R11: 0000000000000246 R12: 0000000000023e71
R13: 00007ffc203f0660 R14: ffffffffffffffff R15: 00007ffc203f0680
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u4:0/11:
1 lock held by khungtaskd/28:
 #0: ffffffff8d9b4320 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8d9b4320 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8d9b4320 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by kworker/u4:11/2965:
2 locks held by getty/5543:
 #0: ffff888030e8a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000325e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfb3/0x1460 drivers/tty/n_tty.c:2201
1 lock held by syz.0.17/7125:
 #0: ffff888028c3c470 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.1.18/7168:
 #0: ffff888066b28b70 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.2.19/7204:
 #0: ffff888073648070 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
2 locks held by kworker/0:5/7217:
 #0: ffff88801a476938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x788/0x15e0 kernel/workqueue.c:2605
 #1: ffffc90003717d80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7ea/0x15e0 kernel/workqueue.c:2606
1 lock held by syz.3.20/7235:
 #0: ffff888028fcbf70 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.4.21/7271:
 #0: ffff888030fdb670 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.5.22/7308:
 #0: ffff88806680fc70 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.6.23/7350:
 #0: ffff888030a54070 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.7.24/7386:
 #0: ffff888073602a70 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
1 lock held by syz.8.25/7422:
 #0: ffff88801ff7d570 (&worker->mutex){+.+.}-{4:4}, at: vhost_dev_flush+0xeb/0x190 drivers/vhost/vhost.c:302
2 locks held by syz-executor/7426:
 #0: ffffffff8f562fe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f562fe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x372/0xe10 net/core/rtnetlink.c:6555
 #1: ffffffff8d9bfd78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #1: ffffffff8d9bfd78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x6b5/0x800 kernel/rcu/tree_exp.h:996

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf95/0x1220 kernel/hung_task.c:379
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5135 Comm: klogd Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:get_current arch/x86/include/asm/current.h:41 [inline]
RIP: 0010:write_comp_data+0x9/0x90 kernel/kcov.c:235
Code: 8b 80 f0 15 00 00 c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 49 89 d2 49 89 f8 49 89 f1 <65> 48 8b 14 25 40 bc 03 00 65 8b 05 2f 3f 77 7e a9 00 01 ff 00 74
RSP: 0018:ffffc900032074b8 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffc90003207540 RCX: ffffffff813cdcda
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000002 R11: ffff88807de2a400 R12: ffffffff905d514c
R13: ffffffff905d5151 R14: 0000000000000002 R15: ffffc90003207575
FS:  00007f1b8d59bc80(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fca41409e9c CR3: 0000000033162000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0x5ea/0x2390 arch/x86/kernel/unwind_orc.c:505
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x90/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node_track_caller+0x5a/0x90 mm/slab_common.c:1027
 kmalloc_reserve+0xef/0x260 net/core/skbuff.c:582
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xdb/0x700 net/core/skbuff.c:6331
 sock_alloc_send_pskb+0x7f4/0x980 net/core/sock.c:2780
 unix_dgram_sendmsg+0x455/0x1c40 net/unix/af_unix.c:1976
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x4b0/0x510 net/socket.c:2190
 __do_sys_sendto net/socket.c:2202 [inline]
 __se_sys_sendto net/socket.c:2198 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2198
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x43/0x120 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f1b8d6eb407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffcc76a21e0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f1b8d59bc80 RCX: 00007f1b8d6eb407
RDX: 0000000000000039 RSI: 00007ffcc76a2320 RDI: 0000000000000003
RBP: 00007ffcc76a2750 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000202 R12: 00007ffcc76a2768
R13: 00007ffcc76a2320 R14: 000000000000001e R15: 00007ffcc76a2320
 </TASK>


Tested on:

commit:         3652117f eventfd: simplify eventfd_signal()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e36242580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72e26fe183bbe37e
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

