Return-Path: <linux-kernel+bounces-731384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1273B0538C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF79F1AA5929
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BD270552;
	Tue, 15 Jul 2025 07:45:35 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC42747B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565534; cv=none; b=sDlrn9gbiiRQvgu6HeLkkv8F2dxCDbu4lBbn9EzR+A1Du8PAbGa/HhirePAoebr5rZCqe0fh8RD83wlD7/FbiescG2bUgDyzscVW3Gag3OID0C29PfkAOmyiqtQ7RbT9sDKAssgz1AGBftlyKooYUV75bW9SKknMIBgLeaWrPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565534; c=relaxed/simple;
	bh=5r4cAbfbudL6K1XRCzgC/5ejezMmgZ99mWj5bb+ThAg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lAZZv2rg0PXQi7gHEsL62jPLWZEyEdciNlcIG85orbMj+UvC6AVa2ZhliOqTDsuAD9t0+HQ7cLr+IBKbW2SObd/aH2B+Bg+gVkX9ohtYch4cHWLLbDHtHprbWgxy1Gi6/OLgsKsrb5qafH6VIlstd1xzlnE4ziyowQksXL5a8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so946946539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752565532; x=1753170332;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJcDxNdksfokdJf2O0K2cNXP/0MZixzEwZMVOab1/Oc=;
        b=p3dpvJnzzsYw2UuOkGZB0WdYWqRZNRUXxUtNNPVYC+w6aZd7gEKqAZFZXzjdzpa5/n
         lVF8y/paCbowuk0cO4+8/cfdnHgNYh7R0W2EjkGcuX/HJHgEdb3v0QjIlmyjhvjc+i/p
         xYEZQqY78yyOp579mXPBETb2s91iEGzhExluGCHFUgxqbz0JOnyVXO0d8UftaVQ7h8kS
         0Q8sYp/U6DRTT5hxdNMFCwCAe/+cYswpT1XIcsdiEeT8Wsh0ZBg58c3xPfo21iEKC58m
         OefRazknPCnZmI/t8MniyaLLnpiyOdCdz4FR1Whn2mwTl5HW6jLPcw9cEto7E7wagbIs
         /PGA==
X-Forwarded-Encrypted: i=1; AJvYcCXYBiKkHk7wWdB9A+7OqqDQ6tsMRDbzM6qRA0yNBqIlCXLDFVi+vgm+JtZ9pfLp3Uw9jWOKQR81WXBEpjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJPjpFuEwLQ0J4EOZdHzFOhozO5HZQxHeOoux4flYSgJBhCac
	sbW0mbBZ4cVwdddBzQI8nuX7hC7aDxoVQiYWsFjGmzB48DWJRbXBP8i1hcW1OveYDRRNOuQYZ/8
	GehacKf5k7nRSnzgAGR+0u3AuKx7/CJX72OG0PwWo1SjpiMKsZswQN6NS7AU=
X-Google-Smtp-Source: AGHT+IH1gUo0BpFJUVoIAsN7ut0nNXM99gr16Ed7clqdTYu36NI2YrsgZTQqLpshyWg7Akpr/UR1TE4mX+0Ce+GFYPoIuThNZpLu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:3df:4b77:28d6 with SMTP id
 e9e14a558f8ab-3e25334e8camr185235805ab.21.1752565532235; Tue, 15 Jul 2025
 00:45:32 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:45:32 -0700
In-Reply-To: <6867a7e6.a00a0220.c7b3.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6876071c.050a0220.158d12.0001.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_issue_checkpoint (2)
From: syzbot <syzbot+8a7eea50810efde15b0a@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, chao@kernel.org, frederic@kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1409f0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
dashboard link: https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106af18c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a88382580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e5d1c6cac7f/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14a88382580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a7eea50810efde15b0a@syzkaller.appspotmail.com

INFO: task syz-executor288:5860 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc6-next-20250714-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor288 state:D stack:24648 pid:5860  tgid:5860  ppid:5859   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5314 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6697
 __schedule_loop kernel/sched/core.c:6775 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6790
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
 f2fs_issue_checkpoint+0x376/0x570 fs/f2fs/checkpoint.c:-1
 f2fs_do_sync_file+0x869/0x1860 fs/f2fs/file.c:346
 generic_write_sync include/linux/fs.h:3038 [inline]
 f2fs_file_write_iter+0x74d/0x2410 fs/f2fs/file.c:5252
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b43976b19
RSP: 002b:00007ffee8c2a118 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 0000200000000040 RCX: 00007f9b43976b19
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 0031656c69662f2e R08: 0000555559c514c0 R09: 0000555559c514c0
R10: 0000000000000e7c R11: 0000000000000246 R12: 00007ffee8c2a140
R13: 00007ffee8c2a368 R14: 431bde82d7b634db R15: 00007f9b439bf03b
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13eca0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13eca0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13eca0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
3 locks held by kworker/u8:6/1102:
 #0: ffff8881404f4948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #0: ffff8881404f4948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3322
 #1: ffffc90003c6fbc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3215 [inline]
 #1: ffffc90003c6fbc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3322
 #2: ffff8880292d40e0 (&type->s_umount_key#42){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:563
2 locks held by getty/5605:
 #0: ffff88803009b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz-executor288/5860:
 #0: ffff8880292d4428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3103 [inline]
 #0: ffff8880292d4428 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
2 locks held by f2fs_ckpt-7:0/5861:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:491
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5861 Comm: f2fs_ckpt-7:0 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:xa_entry include/linux/xarray.h:1226 [inline]
RIP: 0010:xas_reload+0x19a/0x470 include/linux/xarray.h:1630
Code: ff e8 ba 15 7f 09 89 c5 31 ff 89 c6 e8 1f a4 c7 ff 85 ed 0f 84 14 01 00 00 e8 d2 9f c7 ff e9 5a 02 00 00 e8 c8 9f c7 ff eb 1d <e8> 31 53 ad ff 89 c5 31 ff 89 c6 e8 f6 a3 c7 ff 85 ed 0f 84 27 01
RSP: 0018:ffffc9000414f528 EFLAGS: 00000246
RAX: ffffffff81f82547 RBX: ffffea0001c272c0 RCX: 0000000000000000
RDX: ffff8880792bbc00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffea0001c272f7 R09: 1ffffd4000384e5e
R10: dffffc0000000000 R11: fffff94000384e5f R12: ffff888075e30240
R13: 1ffff92000829eb0 R14: ffffc9000414f580 R15: ffff888025979e40
FS:  0000000000000000(0000) GS:ffff888125bed000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe4c0415fb3 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 filemap_get_entry+0x1c4/0x2f0 mm/filemap.c:1884
 __filemap_get_folio+0x68/0xaf0 mm/filemap.c:1916
 f2fs_grab_cache_folio+0x2b/0x380 fs/f2fs/f2fs.h:2870
 __get_node_folio+0x194/0x1410 fs/f2fs/node.c:1505
 f2fs_update_inode_page+0x82/0x190 fs/f2fs/inode.c:766
 f2fs_sync_inode_meta fs/f2fs/checkpoint.c:1156 [inline]
 block_operations fs/f2fs/checkpoint.c:1263 [inline]
 f2fs_write_checkpoint+0xb6e/0x1df0 fs/f2fs/checkpoint.c:1638
 __write_checkpoint_sync fs/f2fs/checkpoint.c:1756 [inline]
 __checkpoint_and_complete_reqs+0xd9/0x3b0 fs/f2fs/checkpoint.c:1775
 issue_checkpoint_thread+0xd9/0x260 fs/f2fs/checkpoint.c:1806
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

