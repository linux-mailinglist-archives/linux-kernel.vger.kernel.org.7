Return-Path: <linux-kernel+bounces-793266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2FB3D15D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066A9189E160
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410E20A5EA;
	Sun, 31 Aug 2025 08:17:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689912AD25
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756628226; cv=none; b=ND7h8HRBcFZwrkaB3vGRoP+5qZGp3KX8caYw9ecwgSe6jP7nppHAvn+ZtNHPvIrNRy+6p5XkPj+663gvpLhX7LNJA4eCI6JYf9ca9VSkL9CmmbwrT7su9WTeOFwPNXSvYwq0ZUoT7Vb5ucQeX8wlsRzo1yz2sTBFGQyr7KjvGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756628226; c=relaxed/simple;
	bh=cy4UI5ctTcL0pk6ZEiETC1cfc+TtonnDgpbgk62PAew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mkCUbNh+FpUg6gVTuBW76P6c/aZdy1tL6bUNLfwZejnV1qEwbTR/Bjs1w1xQdZrf2vj1VZpQ3EWgfievSCHYTLQja1BSExRMxyjj5SsJn26Miqx/4cXrKCvr1FPgXPhZ/2URTR5Y/Use1rNRBjaKoi2OD8/Ad8ENX5sItdRWKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f568d603e9so2361315ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756628223; x=1757233023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czydMbm0Azoi/1CrKIlfrPdIl2Sf8m0DdH02qzrou0M=;
        b=Ljb869tygz9Akth2RIp2moSi3FK+dNgIWibAeylCMU12O/IOaMQcEGeeiGehFTNAMu
         bBSHiIX4owXkwsrI1ezIvU5zgmFW5kedLXDIhuhOPI6X4BWE+CkD2O6f0f5LnP0k3bds
         lNpz3TbShUB6sUO5yB8Oce3fQp6KdSAiUm1ydjbAv6UX5EsxDNonnwVXLVLPpAYEZHoh
         lXlHtChWbFGX0qPHQR+dqOUtM020NSdQDhgz1hw7w2Hd6GO3+jZ+OgKYigdCoRZL5eaL
         zXcKn9EHtOtlFyzSYYPcrtVT3uyO1yo4CHu7pw65VcAULOZTQ4iadPhYf43tb93T/Pf8
         7bxw==
X-Forwarded-Encrypted: i=1; AJvYcCWjOlXjx+DDmd7vhuRn2XS35s3lYlMzDF2+1uY80qYk7eqIxEyfYFQOOVNcusczeRgt49GJ5b/zM7bNFkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEuCRZhbmtXwHbtda0ubzrM/FATeXw3MtiDoW/+eHIH06m1f3
	H8ufM2UNpuhPRY5ljJ3HdQ3KOcsc78gcETcYWgSS+YidE9anpXuhRQRsMC8h45crmbvs1fdokrO
	QdYz6dt/uB+8cNnsqUjD0QQSuDH/FFO/1w/7OA0uuwJlr2lUxSKCMBsHivU0=
X-Google-Smtp-Source: AGHT+IEffQtyZX9/TPk/F28Ners4E4NPgFOmV5u+l/pdYS8CHCeIHwRsSj5VYqCIE1ElRhYbE5C4yDxu1v8kWw3T0ngNw5HEZTij
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3eb:5f74:ed9b with SMTP id
 e9e14a558f8ab-3f4000971a4mr91152695ab.2.1756628223446; Sun, 31 Aug 2025
 01:17:03 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:17:03 -0700
In-Reply-To: <20250831073458.6191-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b404ff.a00a0220.1337b0.0032.GAE@google.com>
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __vhost_worker_flush

INFO: task syz.0.17:6483 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27928 pid:6483  tgid:6483  ppid:6379   task_flags:0x400040 flags:0x00004004
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
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbbf8f8ebe9
RSP: 002b:00007ffc4fda04f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fbbf91c7da0 RCX: 00007fbbf8f8ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fbbf91c7da0 R08: 0000000000000000 R09: 000000084fda07ef
R10: 00007fbbf91c7cb0 R11: 0000000000000246 R12: 000000000001e441
R13: 00007ffc4fda05f0 R14: ffffffffffffffff R15: 00007ffc4fda0610
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1220 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
5 locks held by kworker/u8:2/35:
3 locks held by kworker/u9:1/5173:
 #0: ffff88807d124148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc9000f90fd10 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
 #2: ffff8880773d8dc0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x175/0x430 net/bluetooth/hci_sync.c:331
2 locks held by getty/5611:
 #0: ffff88814de1b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036bb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222

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
CPU: 1 UID: 0 PID: 1167 Comm: kworker/u8:10 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:mark_lock+0xad/0x610 kernel/locking/lockdep.c:4722
Code: 54 24 68 65 48 2b 15 ba e6 3e 12 0f 85 e8 04 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc f6 46 22 03 74 8d <41> bd 00 02 00 00 bb 09 00 00 00 eb 8e 44 8b 1d ff 56 4e 19 45 85
RSP: 0000:ffffc90003e0f480 EFLAGS: 00000002
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffffff95e3eb08
RDX: 0000000000000008 RSI: ffff888028468b90 RDI: ffff888028468000
RBP: ffffc90003e0f520 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000a0 R11: 0000000000000001 R12: ffff888028468b90
R13: ffff888028468000 R14: 0000000000000004 R15: ffff888028468000
FS:  0000000000000000(0000) GS:ffff8881247b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564fc0756be0 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mark_usage kernel/locking/lockdep.c:4674 [inline]
 __lock_acquire+0x3f8/0x1ce0 kernel/locking/lockdep.c:5191
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xd1/0x20a0 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4879
 skb_kfree_head net/core/skbuff.c:1047 [inline]
 skb_free_head+0x114/0x210 net/core/skbuff.c:1059
 skb_release_data+0x795/0x9e0 net/core/skbuff.c:1086
 skb_release_all net/core/skbuff.c:1151 [inline]
 __kfree_skb net/core/skbuff.c:1165 [inline]
 consume_skb net/core/skbuff.c:1397 [inline]
 consume_skb+0xbf/0x100 net/core/skbuff.c:1391
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:836 [inline]
 nsim_dev_trap_report_work+0x8bd/0xcf0 drivers/net/netdevsim/dev.c:866
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         c8bc81a5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143cce34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c4ce34580000


