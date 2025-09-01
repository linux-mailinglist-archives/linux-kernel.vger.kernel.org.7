Return-Path: <linux-kernel+bounces-793685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E12B3D6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A2A1896A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4FE20B80D;
	Mon,  1 Sep 2025 02:46:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244721E1DE9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694765; cv=none; b=PYnjOOjzXlUlgEJTQ4WkgO56kLQ7OphfDwPT74I+YEp4BP0FxIvCfhORL7/6gLTkV6WS46GZAIYMaNs/wn3/ncvEbaNtQ14lY/8hAFyBRKfqkplI0fHm834VxAyYNC93NvPfv7abVe73w6k/svxhCrH9FcRDQrkz4bCboxQ1L5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694765; c=relaxed/simple;
	bh=InOIVVRqnM9v+OYFcO1yDIMQZ0Y4RuZMKc/QTUPbRK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MN7UF4HwOl/biQFNN4A770Z5loDudkgBomlz5UhSDYcYyCUg0IhOoaUXQ0x4oQvXzVBAN/sJo59GRSGeoGb2rALYL+MVaD0RD30z4yWertSODeeJYf38fPis8EyAM5Nsy1L3Wz2yDbGa52pyw0W/JsRQY0q6G7fLHYO6W0sQXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f34562d2c6so27398445ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756694763; x=1757299563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfSqYf+3jtEOmaPgsllTgzT86MLg0ZfN5QrYeS5Wzrs=;
        b=AY4UQgyQJ+thcnvPDI7XLsPY1RuBRnc7oBkECrX979DpljPWhdUrgJyFH3Vjk0HUpn
         3xK5k1ic9ECxOxRM2dX1HXoXRUoO2OAS5BnTyu72tZVbL+VIFgvv8Mo5H4ks4dS22PHg
         ULI1ghx45bcE1VQS4cZSv9kphiBPFT0vyDc5cHR5zqFldWs5zwRbKgF/dTDswjseHw3v
         sQui9vZdfOyqYl8uQ+Rn8Rlig24tJZyphFYYYSLM9h6ap/IDSL2rgyNaVjUrYtCnLgpa
         glEBW1iWK0fpgwWczqXdyfHwwzzk0yLeBii+WT0XRgIgaVNx29ZP6eW7eRXdIMIck2Ot
         /EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpQ03TrwV7SlwrT+j6PDJ050rgZthYkxrl3rGwDNKzRs8qkDBmArjVI8qLjH2FWdbZj5yeN6bWRJo+6SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzo8f6azn9JN01cV2B3AGih1MYP+MJ+hFXa3UHBlJ29MwRB8zf
	UL3WAs53DRuWMEDC1MuE6yD9bC9D+f7j11o6tQjgKAmbnAdc3lAkWt/xmr92Q7j34Dz5/Tropyr
	KFD13mpOjPy+IlRgwiGcyvh1LrKAeEjXvmjy8OaTckRIRwbllpsRF22cYYTU=
X-Google-Smtp-Source: AGHT+IH3RQ73iZcPiGNtMYDxz4bp0E6wiu3gHdYfrTHdYcO9nuVFR/bwbeO2y70AOtJ7MaskPrcmmkvdtZT4AUYJPPx80tslprXj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3f1:700a:3f78 with SMTP id
 e9e14a558f8ab-3f401ed81e4mr151221905ab.10.1756694763187; Sun, 31 Aug 2025
 19:46:03 -0700 (PDT)
Date: Sun, 31 Aug 2025 19:46:03 -0700
In-Reply-To: <20250901013758.6300-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b508eb.a70a0220.1c57d1.04d4.GAE@google.com>
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __vhost_worker_flush

INFO: task syz.0.17:6484 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27928 pid:6484  tgid:6484  ppid:6375   task_flags:0x400040 flags:0x00004004
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
RIP: 0033:0x7f4ae478ebe9
RSP: 002b:00007ffe922fd5f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f4ae49c7da0 RCX: 00007f4ae478ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f4ae49c7da0 R08: 0000000000000000 R09: 00000008922fd8ef
R10: 00007f4ae49c7cb0 R11: 0000000000000246 R12: 000000000001e366
R13: 00007ffe922fd6f0 R14: ffffffffffffffff R15: 00007ffe922fd710
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e5c1260 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e5c1260 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e5c1260 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:2/36:
1 lock held by klogd/5209:
 #0: ffff8880b853a318 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:636
2 locks held by getty/5608:
 #0: ffff88814df690a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036bb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222

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
CPU: 0 UID: 0 PID: 5911 Comm: kworker/0:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue:  0x0 (wg-crypt-wg0)
RIP: 0010:schedule_debug kernel/sched/core.c:5917 [inline]
RIP: 0010:__schedule+0x1b2/0x5de0 kernel/sched/core.c:6838
Code: 80 3c 02 00 0f 85 1f 53 00 00 48 8b 85 10 ff ff ff 4c 8b 68 20 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 <0f> 85 ec 52 00 00 49 81 7d 00 9d 6e ac 57 0f 85 24 53 00 00 48 8b
RSP: 0018:ffffc900041efbc8 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8b94c176
RDX: 1ffff9200083d000 RSI: ffffffff8c162980 RDI: ffff88802740c8a0
RBP: ffffc900041efd80 R08: 0000000000000000 R09: fffffbfff2156a52
R10: ffffffff90ab5297 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900041e8000 R14: ffff8880b843a300 R15: ffff888033d59840
FS:  0000000000000000(0000) GS:ffff8881246b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555588e15c8 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 worker_thread+0x2e5/0xf10 kernel/workqueue.c:3415
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         b320789d Linux 6.17-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16446242580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127a4662580000


