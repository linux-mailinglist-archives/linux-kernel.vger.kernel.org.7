Return-Path: <linux-kernel+bounces-781087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C6B30D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E768153A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F228B7DA;
	Fri, 22 Aug 2025 04:15:40 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45814A09C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836140; cv=none; b=Irqmnv7Xi7etM7gYE31UUXJYEy1bCH9YdAS2M330LJ4Td3wVwT4/HsuUIezXQnVmqyDxQWoLpi27+TzGwjflkFkPdklEIzluJ62KrK7ylIA1B2QM/f4idlCYnpO9HjIsIxS77qYU9B8NHX6Bcc5i+VB3TC43bbtg59R5w6BwS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836140; c=relaxed/simple;
	bh=0UtnbgypcIHLPgtMaR5WhF9g0lMwCV+mw4VvcC0iq80=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fe8H7xK0MBHAqrfqUz1kKzsccjQKCfLzKA7E9H3D/aZjFN7kcR4xSKMlzKjq8aH03i8CVDmOK7Mx8K6hCwMxtELVG/cQJnKGTF+k+7LU7tyeG+YK1hnHe6UIp5MuJq0HBK/JgZqYLg8OX4GR5lW6qiqq+0CIzHLqzl7QpfJkdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e7172dea48so36235785ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836137; x=1756440937;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7GDzN9ltNSpi4Er69lRfMFSau6qxZQyGvXnyF0Dip8=;
        b=CTFMMLd7lNFcTJkaXaoDoxoaIUTbL8gPvhA1JGJuePxkACGJwQgKN5LMExlhGAqaem
         zQIvok1pjWT3xQT3irlgz78mA4ci+1B/O/CMyagpTriIgA2b2O8EIRLUs2ydRDr5i//O
         Rr+HyfFJbXPrvp0FWhYeYm6oJpBP37tcjOh3dFmoY1rcKQ9Bivjhwyoz4vHUXfpvbhcZ
         4ZjDl5/LHDN8P7yp8o1BC/LrqpGzPof5KbIZJyJ3s1W2dzU2WXrcpKpYkf4jLVP6DgcU
         fewV9rHiUtEFqDMwTi6IzxYlDfp2fxnn5ivJHQDmJiO9bFqWVZVzJea7Apm5bpy2L8nY
         YJFw==
X-Forwarded-Encrypted: i=1; AJvYcCUT8umJiGqmlTpv4bthvSqWcmsVqrUDCjJ1hA9Q3pBxQ/2uhE5g+MUX2+gTJpIOQXlJtjjbona4EbhgkfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RYKy+/QqmiBdq57QieWzulLtkXjaVkjj+6KnXp7O7TXAiOIH
	nOPFmb6OlnCxGCLrI01WdoGoHdPkXF36GnKuwXQxcqElyBwOLk0bByZMvVAz0fQ/UxUuTQ5GT/4
	e/4tS2JboTTujueFMgGu8AWDWvfheAyPRXblpGUNa8wDNAy7mlwRryKKKPcs=
X-Google-Smtp-Source: AGHT+IGABAXaqi53Nfp6ROVfQxgeolkrnbkzi9bbO0pFT6AcqaLdGU87jtbNgeEjSGjDFJwiWK+XH5ny/obmIEbKYxpBJs7QmYDI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2303:b0:3e5:42ec:1372 with SMTP id
 e9e14a558f8ab-3e9223161c7mr35472125ab.19.1755836136845; Thu, 21 Aug 2025
 21:15:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:15:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7eee8.a00a0220.33401d.0167.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in bch2_mark_pagecache_reserved (3)
From: syzbot <syzbot+baf59efef8862c9ba260@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d561baae505 Merge tag 'x86_urgent_for_v6.17_rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1241eba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=baf59efef8862c9ba260
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172f1ba2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a79234580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/595e1e4d6418/disk-8d561baa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab14cc587702/vmlinux-8d561baa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/368a3a55dcfb/bzImage-8d561baa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d90b312697dc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baf59efef8862c9ba260@syzkaller.appspotmail.com

INFO: task syz.0.17:6129 blocked for more than 143 seconds.
      Tainted: G        W           6.17.0-rc1-syzkaller-00224-g8d561baae505 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:24520 pid:6129  tgid:6105  ppid:5963   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b5/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1133 [inline]
 bch2_mark_pagecache_reserved+0x33d/0xbb0 fs/bcachefs/fs-io-pagecache.c:314
 __bchfs_fallocate+0x1284/0x1870 fs/bcachefs/fs-io.c:733
 bchfs_fallocate+0x33f/0x680 fs/bcachefs/fs-io.c:789
 bch2_fallocate_dispatch+0x28d/0x410 fs/bcachefs/fs-io.c:836
 vfs_fallocate+0x672/0x7f0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f72068bebe9
RSP: 002b:00007f7205f05038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f7206ae6090 RCX: 00007f72068bebe9
RDX: 0000000000000005 RSI: 0000000000000001 RDI: 0000000000000007
RBP: 00007f7206941e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000007fff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7206ae6128 R14: 00007f7206ae6090 R15: 00007ffc00c97a38
 </TASK>
INFO: task syz.0.17:6130 blocked for more than 143 seconds.
      Tainted: G        W           6.17.0-rc1-syzkaller-00224-g8d561baae505 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:26872 pid:6130  tgid:6105  ppid:5963   task_flags:0x440040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 __bch2_two_state_lock+0x1ea/0x370 fs/bcachefs/two_state_shared_lock.c:7
 bch2_two_state_lock fs/bcachefs/two_state_shared_lock.h:55 [inline]
 bch2_readahead+0x94f/0x1100 fs/bcachefs/fs-io-buffered.c:296
 read_pages+0x177/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x2d3/0x740 mm/readahead.c:264
 filemap_get_pages+0x443/0x1df0 mm/filemap.c:2603
 filemap_splice_read+0x587/0xc60 mm/filemap.c:2991
 do_splice_read fs/splice.c:979 [inline]
 splice_direct_to_actor+0x4b1/0xcd0 fs/splice.c:1083
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x187/0x270 fs/splice.c:1227
 do_sendfile+0x4ec/0x7f0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f72068bebe9
RSP: 002b:00007f7205ee4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f7206ae6180 RCX: 00007f72068bebe9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f7206941e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000100001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7206ae6218 R14: 00007f7206ae6180 R15: 00007ffc00c97a38
 </TASK>
INFO: task syz.3.35:6346 blocked for more than 143 seconds.
      Tainted: G        W           6.17.0-rc1-syzkaller-00224-g8d561baae505 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.35        state:D stack:24520 pid:6346  tgid:6305  ppid:5970   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b5/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1133 [inline]
 bch2_mark_pagecache_reserved+0x33d/0xbb0 fs/bcachefs/fs-io-pagecache.c:314
 __bchfs_fallocate+0x1284/0x1870 fs/bcachefs/fs-io.c:733
 bchfs_fallocate+0x33f/0x680 fs/bcachefs/fs-io.c:789
 bch2_fallocate_dispatch+0x28d/0x410 fs/bcachefs/fs-io.c:836
 vfs_fallocate+0x672/0x7f0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f556c76ebe9
RSP: 002b:00007f556bdb5038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f556c996090 RCX: 00007f556c76ebe9
RDX: 0000000000000005 RSI: 0000000000000001 RDI: 0000000000000007
RBP: 00007f556c7f1e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000007fff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f556c996128 R14: 00007f556c996090 R15: 00007ffe84a319a8
 </TASK>
INFO: task syz.3.35:6347 blocked for more than 143 seconds.
      Tainted: G        W           6.17.0-rc1-syzkaller-00224-g8d561baae505 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.35        state:D stack:27160 pid:6347  tgid:6305  ppid:5970   task_flags:0x440040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 __bch2_two_state_lock+0x1ea/0x370 fs/bcachefs/two_state_shared_lock.c:7
 bch2_two_state_lock fs/bcachefs/two_state_shared_lock.h:55 [inline]
 bch2_readahead+0x94f/0x1100 fs/bcachefs/fs-io-buffered.c:296
 read_pages+0x177/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x2d3/0x740 mm/readahead.c:264
 filemap_get_pages+0x443/0x1df0 mm/filemap.c:2603
 filemap_splice_read+0x587/0xc60 mm/filemap.c:2991
 do_splice_read fs/splice.c:979 [inline]
 splice_direct_to_actor+0x4b1/0xcd0 fs/splice.c:1083
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x187/0x270 fs/splice.c:1227
 do_sendfile+0x4ec/0x7f0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f556c76ebe9
RSP: 002b:00007f556bd94038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f556c996180 RCX: 00007f556c76ebe9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f556c7f1e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000100001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f556c996218 R14: 00007f556c996180 R15: 00007ffe84a319a8
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 38 Comm: khungtaskd Tainted: G        W           6.17.0-rc1-syzkaller-00224-g8d561baae505 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 17 Comm: pr/legacy Tainted: G        W           6.17.0-rc1-syzkaller-00224-g8d561baae505 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:400
Code: e8 ce d8 7f fc 44 89 f9 d3 e3 49 83 ee 80 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 cf 0b df fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f c3 cc cc cc cc cc 44 89 f9 80 e1 07
RSP: 0018:ffffc90000167890 EFLAGS: 00000202
RAX: 1ffffffff3274800 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff993a4810 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff853e8220 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff993a4580 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f814fde4000 CR3: 000000005b504000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1aa/0x2f0 drivers/tty/serial/8250/8250_port.c:1984
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3288 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3329 [inline]
 serial8250_console_write+0x1341/0x1b40 drivers/tty/serial/8250/8250_port.c:3396
 console_emit_next_record kernel/printk/printk.c:3118 [inline]
 console_flush_all+0x695/0xcd0 kernel/printk/printk.c:3226
 __console_flush_and_unlock+0xa4/0x240 kernel/printk/printk.c:3285
 legacy_kthread_func+0x13b/0x1a0 kernel/printk/printk.c:3638
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
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

