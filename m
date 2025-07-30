Return-Path: <linux-kernel+bounces-751401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E112B16929
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8447F1AA4105
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6E231852;
	Wed, 30 Jul 2025 22:55:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB81F8BA6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916133; cv=none; b=hyAPXl4bKkAshXBZGpJvUKzNmak7pQTNVMcJOzE+zx17qUJcGvno8SXtaUKCdvhsI7Q86M0mdlYzKQSsjrZazCGUWIcSVU3lxeqA9KgQNOvaofTxO/fKm3tAaktuVUAbe3pqgMGSj9JTjLPhUMRtTpm5j83raKyBQGENchS1Gh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916133; c=relaxed/simple;
	bh=UUDdlzL/fO4mUou6e/h2lp8GQTRUtt4gBB3NuVh9qp8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=guwFCGOmvM327VnJtO06mj/QaSidjti4KAfl+FEzzCn9CBGe/jKhKyRycA1TcXfQLVP7uvZLsyct8p3Wm5QY9LwndfeMV+SRAQcu4VNzkNvXmlDg1KNQKSfLLQe/B7K9uf7nmMHu4+9QO5G3/wY4XpDr6Y1wxB7gEvvoTRdpnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e277f04812so3527685ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753916131; x=1754520931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lqIO8c8gJjXdWuSugMRnvDZBMnicZ+DCnQIRPFI9JA=;
        b=Nom+mJs4wdA1B11cXuUL69Ylv3404HwWHBmYoivZMjyl31NPRraJWfMDRwJ/hIhPle
         rjA/lo2KCBaFi/C7OGJ3kOamWCRzaYqYi+FX+GMhd/MKDd+jEAhTLw1sP3/6WMActSnc
         tUCj2TGxlq3ori3BWF2q3lVoBKofiB5higLqJ1zyXjoQIuik9MMxV5VROBXmVZjZFvvm
         rwgx2zFA0fS1NCnEQKMzfBILL5g2kAn2or0wSQ97L3AFX4WPAuv8AO5qFSJqUUa36ZUE
         U02yo8xeY6eyMt4yxpFdYh6x8l1JrRR/wZyQVkgP9vt1Pij5y4z0coVipt/Mq0qP+aow
         /azA==
X-Forwarded-Encrypted: i=1; AJvYcCVCjD+52y+6ZFmleNVmiJv99KDS9UZsJGo1kUS+8qWnuMpvw1/HjHZIFhdmrjGPIx9BooGwFgrHx5wLOW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl5zMeF4M3qIo2SL3CQc0pHBD5C1bqPEW0D+1/recv642sfCC
	hbi2x6TmkoQjqEpU/atLrIt8gYAjOzC6h0uyCdlsUtBgUb3SlppikzIdKnDHbEZVw8IitXQ18D8
	modg/DKviKZEHJgBQybulJMWiDnpskJV6/7RtdW+OEA2DNq5fQ7y/Dhb0urU=
X-Google-Smtp-Source: AGHT+IHvv+SdtIF9GYRqOcel0L6gIZLToQDZ0/18Gzv3QUfsK8SLV2uxYDSBe35EHo5cX8RmdsJjx0AxolC7O8YCxA32j6x9VrY4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440c:20b0:3e3:d5f1:9019 with SMTP id
 e9e14a558f8ab-3e3f62a7e18mr58352905ab.16.1753916131209; Wed, 30 Jul 2025
 15:55:31 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:55:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688aa2e3.050a0220.5d226.0010.GAE@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in release_metapage (2)
From: syzbot <syzbot+5570e0eb2edddd308514@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b290aae788e Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11008f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46544c44676816
dashboard link: https://syzkaller.appspot.com/bug?extid=5570e0eb2edddd308514
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f389bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cfccf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a42db01cad91/disk-4b290aae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32f0fca549e2/vmlinux-4b290aae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4b9f4fa04d4/bzImage-4b290aae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bb7477fa5ad1/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=174fccf0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5570e0eb2edddd308514@syzkaller.appspotmail.com

INFO: task syz-executor220:5846 blocked for more than 143 seconds.
      Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor220 state:D stack:24584 pid:5846  tgid:5846  ppid:5845   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5351 [inline]
 __schedule+0x16b2/0x4ca0 kernel/sched/core.c:6954
 __schedule_loop kernel/sched/core.c:7036 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7051
 io_schedule+0x81/0xe0 kernel/sched/core.c:7896
 folio_wait_bit_common+0x6b5/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1141 [inline]
 release_metapage+0x103/0xab0 fs/jfs/jfs_metapage.c:868
 discard_metapage fs/jfs/jfs_metapage.h:88 [inline]
 __get_metapage+0x9a0/0xde0 fs/jfs/jfs_metapage.c:751
 jfs_readdir+0x1e01/0x3ae0 fs/jfs/jfs_dtree.c:3041
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:65
 iterate_dir+0x5bb/0x780 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7eda95cc19
RSP: 002b:00007ffd76156b48 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f7eda95cc19
RDX: 0000000000001000 RSI: 0000200000000f80 RDI: 0000000000000004
RBP: 0030656c69662f2e R08: 0000555576b714c0 R09: 0000555576b714c0
R10: 0000555576b714c0 R11: 0000000000000246 R12: 00002000000000c0
R13: 00007ffd76156d98 R14: 431bde82d7b634db R15: 00007f7eda9a503b
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/38:
 #0: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:11/1284:
 #0: ffff888019881138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888019881138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000517fbc0 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000517fbc0 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
2 locks held by getty/5572:
 #0: ffff88823bf7e8a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e9b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1410 drivers/tty/n_tty.c:2222
2 locks held by syz-executor220/5846:
 #0: ffff888031876728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x253/0x320 fs/file.c:1232
 #1: ffff888037f40f88 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: wrap_directory_iterator+0x5d/0xe0 fs/readdir.c:54

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:470
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 53 1b 1a 00 f3 0f 1e fa fb f4 <e9> c8 b2 03 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900001d7de0 EFLAGS: 000002c2
RAX: 795132a39e33c100 RBX: ffffffff819592e8 RCX: 795132a39e33c100
RDX: 0000000000000001 RSI: ffffffff8cff8d9d RDI: ffffffff8b61dd80
RBP: ffffc900001d7f20 R08: ffff8880b893339b R09: 1ffff11017126673
R10: dffffc0000000000 R11: ffffed1017126674 R12: ffffffff8efa15f0
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff11003855b28
FS:  0000000000000000(0000) GS:ffff888126c22000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055598a640168 CR3: 000000000d5a6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
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

