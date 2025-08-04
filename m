Return-Path: <linux-kernel+bounces-755538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D51B1A82B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331BD16C51C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BE25CC73;
	Mon,  4 Aug 2025 16:50:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BB2192F4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326232; cv=none; b=hhY9X09Zp/TTnx71Jh4pAQCnQcgnExw8Izd6hVfsZyvN6Ob5eIeVr3m9NRPFVvzSuwgNphtAzS3/Z2eMvbeGssa+L94nuIjcZ1sx/t1Z0qdp0E1KB3NwfPcVIi0xK/HPjMgKpKQNi5bGdYAP8dO3XwP4Oedao4E6oZJNPwYlk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326232; c=relaxed/simple;
	bh=+SeitRU6Koh2Ir5Yw2NKQm7kiJcbNziS5uR0v6rTTHQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MwgbX3xsAjQhPwQvq8sLEHKwiVzwX2gsCi/A9kjUse5bJ3fQvJq0SmPBxifIvj61FW0lFWTWkR7K0TqZq4dc3TCZaYGKm3qrztDct+rRKDK6U5XXFm9KiMxPzC5WDhm6paVHxFBSJPo6fq+kGmZikJrrhv1qzqDvbIEXa6njxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e3e6bd9e7eso34290625ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326230; x=1754931030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti6CGxZz6NFeBeQcYvU1jE2V6AZJEX4cpUWeG+578Rk=;
        b=migD0Mwj0RbhR6AoHAmvuXNFQIHS+6cG26xx/5i7UHSkXx1Lb+E9KdfdClxQSNUlB3
         5vfWspcDCSZ8YETXD6AlLbtQMRkHSDBEZ4fuVpBvF2r0jwDts5yWncUHBu32CiKbKZcp
         sAhSeh4IoMTM06tJZnHS88OZEg7hjpaW1QJaqWXfco+AWsvQrKRPAT02dPJtjkU07S2Z
         Zgf2m8AwUYRqLb5WCNrSAwjSWXAjNCe0iGN+w0LMfPc1ciIs34HwT00Li54wxFpKHNAU
         asZWVJQW5Ta6h/V5g7gxv7uSeM5jA47j5hCOY/lBubdcvefhX2auAu7KM2Tdmes4QCfL
         JwAw==
X-Forwarded-Encrypted: i=1; AJvYcCXu4avoKlsHBCawlt8rj17Ni2bZHsry+1iHUKHCs7vyuDKEsidpUtAPIcqly6q7xzJXhHTiKcsnMRMDyNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZ2ohvTM7rnkf4jxHy7oQXgMO/QMXZiKLeK/smz5AZm997+LE
	lCrR9xKJo0U2Xs7QcctUk2p/XTVbZ1hXEnpPKF2tAbbldTL/Dkj79wowC53Kvk65upv/zbUmJhp
	avpgq3Sug8kWlihghuqIlkwDHawB83UlYv7hF6brqVdY8HJ5iFKIORFqRbB0=
X-Google-Smtp-Source: AGHT+IG8vO6CfL57SnaPBS8V1+6wA/ErWdbhOgbpnROX4puVCB00B+tEOI4e4TK8wYrJeqZZ9OuecLXyGQeyhkSx+0U+X/C7vNlM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f0d:b0:3e3:fdd9:8972 with SMTP id
 e9e14a558f8ab-3e41615d9c0mr174349485ab.11.1754326229972; Mon, 04 Aug 2025
 09:50:29 -0700 (PDT)
Date: Mon, 04 Aug 2025 09:50:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890e4d5.050a0220.7f033.000d.GAE@google.com>
Subject: [syzbot] [comedi?] INFO: task hung in comedi_open
From: syzbot <syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84b92a499e7e Add linux-next specific files for 20250731
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c98042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebe1ab9de0458a0b
dashboard link: https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e5f834580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119a2aa2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9166103a92de/disk-84b92a49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3e30ff276de/vmlinux-84b92a49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/febfe91281d4/bzImage-84b92a49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com

INFO: task syz-executor352:5876 blocked for more than 143 seconds.
      Not tainted 6.16.0-next-20250731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor352 state:D stack:26008 pid:5876  tgid:5876  ppid:5875   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1360 kernel/locking/mutex.c:760
 comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2863
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab9116dc29
RSP: 002b:00007ffffb9ee4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fab9116dc29
RDX: 0000000000000400 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffffb9ee6c8 R14: 00007ffffb9ee4d0 R15: 00007ffffb9ee4c0
 </TASK>
INFO: task syz-executor352:5879 blocked for more than 143 seconds.
      Not tainted 6.16.0-next-20250731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor352 state:D stack:27816 pid:5879  tgid:5879  ppid:5877   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1360 kernel/locking/mutex.c:760
 comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2863
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab9116dc29
RSP: 002b:00007ffffb9ee4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fab9116dc29
RDX: 0000000000000400 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffffb9ee6c8 R14: 00007ffffb9ee4d0 R15: 00007ffffb9ee4c0
 </TASK>
INFO: task syz-executor352:5880 blocked for more than 144 seconds.
      Not tainted 6.16.0-next-20250731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor352 state:D stack:27704 pid:5880  tgid:5880  ppid:5878   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1360 kernel/locking/mutex.c:760
 comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2863
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab9116dc29
RSP: 002b:00007ffffb9ee4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fab9116dc29
RDX: 0000000000000400 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffffb9ee6c8 R14: 00007ffffb9ee4d0 R15: 00007ffffb9ee4c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e539f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e539f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e539f20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5610:
 #0: ffff8880304030a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor352/5874:
1 lock held by syz-executor352/5876:
 #0: ffff88814c5a48f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2863
1 lock held by syz-executor352/5879:
 #0: ffff88814c5a48f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2863
1 lock held by syz-executor352/5880:
 #0: ffff88814c5a48f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2863

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-next-20250731-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2995 Comm: kworker/u8:7 Not tainted 6.16.0-next-20250731-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4879 [inline]
RIP: 0010:__lock_acquire+0x50c/0xd20 kernel/locking/lockdep.c:5187
Code: 49 83 c7 28 41 89 c4 48 39 cb 0f 8d d6 00 00 00 48 83 fb 31 0f 83 92 00 00 00 41 8b 07 25 ff 1f 00 00 48 0f a3 05 04 7f 4b 12 <73> 10 48 69 c0 c8 00 00 00 48 8d 88 30 23 8a 93 eb 40 83 3d 6b 0e
RSP: 0018:ffffc9000b5574d8 EFLAGS: 00000007
RAX: 0000000000000003 RBX: 0000000000000002 RCX: 0000000000000005
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff88802f255a00
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff821029a9
R10: dffffc0000000000 R11: fffff94000010c31 R12: 00000000ffffff05
R13: 0000000000000001 R14: ffff88802f2565b8 R15: ffff88802f256560
FS:  0000000000000000(0000) GS:ffff88812590a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561e277c9168 CR3: 000000000e336000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 ___pte_offset_map+0x45/0x250 mm/pgtable-generic.c:286
 __pte_offset_map include/linux/mm.h:3037 [inline]
 __pte_offset_map_lock+0x46/0x210 mm/pgtable-generic.c:397
 get_locked_pte include/linux/mm.h:2745 [inline]
 __text_poke+0x2e6/0xa10 arch/x86/kernel/alternative.c:2504
 text_poke arch/x86/kernel/alternative.c:2589 [inline]
 smp_text_poke_batch_finish+0xd0f/0x1130 arch/x86/kernel/alternative.c:2978
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x250 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xad/0x240 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.133 msecs


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

