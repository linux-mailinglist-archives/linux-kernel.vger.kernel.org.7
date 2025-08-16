Return-Path: <linux-kernel+bounces-771661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA5B28A24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205431B61322
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391C1B040B;
	Sat, 16 Aug 2025 03:07:40 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6691A2C04
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313659; cv=none; b=uUngNcCpho00mw9phxbiKraMJP5U+tEaPvFIBwG8Ot+K2jKiF6zvg0d81IVOy+0Hv0w/Y0PMyEAGjVy5Ck8yFuhWXjIeNfk9PpGJ2qRWfWTyXn6Yrl0aaTmrG5WKAaHJnPFNPmNNoiy/46jsgMbhXAC73e0wVpiNAUOlk5jcpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313659; c=relaxed/simple;
	bh=NMNLC92TaXVI+PfIsfF5CYdHc+u93C3Sh390lhS2x34=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BDEXMhmyn3XgKmbgjJYxyVgsFcuLswZE+kAMzviFfO+ac5xTt97EpIyho54UkCn64KmLut5qjJ4zwSNYHlIcBL7Un1bKaV/7pjUennHRo93H4nI52WwC50U/W23xAijDBpKNFKMlHeej0asxzHd0HF77rOPmYn8T3hA99J+Gx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432e140b8so273191939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755313654; x=1755918454;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lG8WuLPQ+pj0uOEVU9tQRT//PZzxm7WIWBn1S6P8KSU=;
        b=mt9jXuIOmr+t9yCQPdIBH47foKp+3evMw3L4tJTsGOLL4E71HEfI8/RuMgcE6nLpPL
         ZEZML1z1w9ndqrr97Xa8AWcJ6FTHKOqnPI6XUQl5CqbWcSatOC3+eXLqAVYxsYtvSZ3h
         msxqC88iIYqTOHtxvLNEzfKgu+i25SP4E5sfZwaHgiavFsUb2sAU7UW0B0H2Vf33jy+C
         cF+iKCSYxDd8HL2iLcNdousidhAO8xessyFIEe4pZAAxvF8g0zZys+X+haevHrJaop6a
         UvD1bEHowdGxC+RHi3xvuqmxs+XbRbTxS8asotlnG5ctQhuYJ7Fw9OkJjRmZSumNZPFR
         uiJw==
X-Forwarded-Encrypted: i=1; AJvYcCWoO7ReDMNYrQsvsmLFeLn6MTJ0sqGAdn4Es+igs1IHaB0JD2007qKQmgofRW8bEbQcXNhVtZ//pOIjC9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKld+/de6sQHoGEGRo3yrKLqFKQ7jO8yCu+YkTTVggHTVFXXcm
	/xSM/nxF9M//B00dHxIedTi9i9+nyRh5VsyK3zg/93aKwu2SDpzn7+KlsmqbpyHcRCEWEOidSxQ
	+s8wzjD7cbbWP2B3dp8AJeis6ei0/pNt/NZeaM8ecl9bP5q/ENIxRSkVPWOc=
X-Google-Smtp-Source: AGHT+IF6Eu612j9YuidFHJAy8DlSvjwzWK+Vcj5MjBTOWeYq6DiFUDrYQWO+vH3PXj4N2l/jenwJOseVzHAyoY9DM1B2pKisz00o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3e5:42ec:1357 with SMTP id
 e9e14a558f8ab-3e57e7da221mr87690465ab.4.1755313654288; Fri, 15 Aug 2025
 20:07:34 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:07:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ff5f6.050a0220.e29e5.0031.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in bch2_direct_write (2)
From: syzbot <syzbot+d5daa7d9e8e8d49ec379@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee94b00c1a64 Merge tag 'block-6.17-20250815' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1586bdbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=d5daa7d9e8e8d49ec379
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bc53a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bc53a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3a276780499/disk-ee94b00c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d0179cf0059/vmlinux-ee94b00c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93f6f92d9369/bzImage-ee94b00c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/51d8a3d7de8c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5daa7d9e8e8d49ec379@syzkaller.appspotmail.com

INFO: task syz.3.29:6250 blocked for more than 143 seconds.
      Tainted: G        W           6.17.0-rc1-syzkaller-00165-gee94b00c1a64 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.29        state:D stack:15112 pid:6250  tgid:6249  ppid:5983   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1e04/0x25e0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xb5/0x160 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14f/0x750 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:869 [inline]
 bch2_direct_write+0x19b/0x2cf0 fs/bcachefs/fs-io-direct.c:613
 bch2_write_iter+0x192/0x2ba0 fs/bcachefs/fs-io-buffered.c:1064
 iter_file_splice_write+0x9cb/0x10b0 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x104/0x160 fs/splice.c:1158
 splice_direct_to_actor+0x5b3/0xcd0 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x187/0x270 fs/splice.c:1227
 do_sendfile+0x4ec/0x7f0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbe7bc8ebe9
RSP: 002b:00007fbe7b2f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fbe7beb5fa0 RCX: 00007fbe7bc8ebe9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fbe7bd11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020fffe82 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbe7beb6038 R14: 00007fbe7beb5fa0 R15: 00007ffe44413258
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Tainted: G        W           6.17.0-rc1-syzkaller-00165-gee94b00c1a64 #0 PREEMPT_{RT,(full)} 
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6508 Comm: syz-executor Tainted: G        W           6.17.0-rc1-syzkaller-00165-gee94b00c1a64 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
RIP: 0010:_raw_spin_lock_irqsave+0x96/0xf0 kernel/locking/spinlock.c:162
Code: 24 20 4c 8b 74 24 20 fa 41 f7 c6 00 02 00 00 74 05 e8 fe 83 cc f6 bf 01 00 00 00 e8 94 3c 96 f6 48 8d 7b 18 31 f6 31 d2 31 c9 <41> b8 01 00 00 00 45 31 c9 ff 75 08 e8 29 6f a2 f6 48 83 c4 08 48
RSP: 0018:ffffc900053179a0 EFLAGS: 00000046
RAX: 1ffff11004e13dc6 RBX: ffff8880b8941fc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880b8941fd8
RBP: ffffc90005317a30 R08: ffffffff8f1d3a37 R09: 1ffffffff1e3a746
R10: dffffc0000000000 R11: fffffbfff1e3a747 R12: dffffc0000000000
R13: ffff8880b8941fc0 R14: 0000000000000a02 R15: 1ffff92000a62f34
FS:  000055555c1f4500(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f320dbc7000 CR3: 00000000283f2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rt_mutex_slowunlock+0xb0/0x8a0 kernel/locking/rtmutex.c:1417
 spin_unlock include/linux/spinlock_rt.h:105 [inline]
 __free_frozen_pages+0x736/0xce0 mm/page_alloc.c:2924
 vfree+0x2ad/0x470 mm/vmalloc.c:3434
 bch2_fs_btree_write_buffer_exit+0x1ac/0x1e0 fs/bcachefs/btree_write_buffer.c:871
 __bch2_fs_free fs/bcachefs/super.c:615 [inline]
 bch2_fs_release+0x297/0x830 fs/bcachefs/super.c:667
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1378
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfa6f4ff17
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd6f17d858 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fcfa6fd1c05 RCX: 00007fcfa6f4ff17
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd6f17d910
RBP: 00007ffd6f17d910 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd6f17e9a0
R13: 00007fcfa6fd1c05 R14: 000000000005f3e5 R15: 00007ffd6f17e9e0
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

