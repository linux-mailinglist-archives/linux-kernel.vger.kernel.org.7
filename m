Return-Path: <linux-kernel+bounces-775562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC101B2C0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519833ADFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664032BF26;
	Tue, 19 Aug 2025 11:34:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6930F813
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603273; cv=none; b=Xt9UOBu4PLOBcKfb5f4FfB4QssRWmut+avIl1co19a2xvsCZ1bOrjqVXJFlNJ1osBII1jzELJMKJYboBIpovuOKid3HPuMMoNuV8JXtu0is6LOcrp1ytVdpLCuTueMPsccXobdSXV4ty/uChFoOzEm9Qb+y3YO/7WJ1QmJ4KrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603273; c=relaxed/simple;
	bh=s2MBFJzpPhvlRnGvA/BJet4bPRd6NHDODBxjbCduCVM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WNWWxoRHVDMzLQclnu1IxfQoABQ4mCdVibv3bl4DPA+IvP6K4UMxpwUYUD7CHEMjnQPJHbpuT3FV6tWsPdvPoX6ILxL/zy1kISuiNpGHeBHqgUSKySNfeRAo5dBuyNTxpDTc9plICvyzoWgjdSOvHgG352x3ksLMjHX5po3YuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e56feb2b0dso152727175ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603271; x=1756208071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQqhnYu4An1mbjMr1NPuYBDEzbsYRF7mrQm9T/V8e68=;
        b=QXQ5AH/MxrzkSi33Z5thyEMksWzy+j83bfFHhEUsVFLldjpf0iy2/zv93H45OBk54X
         AxMXJobJYSQciGmBk23wPrlaP7t+pV3EqmFOdQR72KcBtzJ4GXPbQGC7X94HsCX3URzz
         2igY1Qy1LrPtcan3+r3BZH0Kix6NlZD79ioUsfB09qV7XKQwYb2SNDWzyaqakxyNCNAB
         +5YrZW8tEQjWZdQUudd9tbIdKR6/+O/PfW/j6D/RscH8UQEdysNT6Y0oXKiZpMFqcFAM
         KE1Ije7kudIpYxNJ/kk6LE60lItU4U/WYxJB04tlQj80Fi2GNVrO4Kjvpxov1f8tzhVd
         LKrw==
X-Forwarded-Encrypted: i=1; AJvYcCVYwx6iahftP3SmtO55qn7hpPmsRsBh0x9QVW2qWcEq+PxAR4pu3vkq8A8onk1AflskTCnZtIWrrtycPp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/AQf8lkh1elwhLgFxOp+aM0+RHG9hMXQT7xh7i57f5CAKDNx
	qzwk21M4ybMA8THgIKYsv/IepiZHJfH5AEHE4umT5qH28l00KK9Q3+2fmBPIyxVe2yRVRRUAqf7
	wfirHJzkvfzaaidSYfdRY5DXJanZAlUngpVM83Zw59Woy4ryYTMlJbkF1cmo=
X-Google-Smtp-Source: AGHT+IFPZ9s4QE212qqOfj7ksFDTbRLNt9k7+5JQw4p8beDhrYDS9jqz8nTNe1rJI1pO22462JGDpV/sqS5DSVKS/Ehrj6JVQWx8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0b:0:b0:3e5:4bc5:539a with SMTP id
 e9e14a558f8ab-3e676661f94mr39481215ab.19.1755603270912; Tue, 19 Aug 2025
 04:34:30 -0700 (PDT)
Date: Tue, 19 Aug 2025 04:34:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a46146.050a0220.e29e5.00c2.GAE@google.com>
Subject: [syzbot] [ocfs2?] general protection fault in ocfs2_evict_inode (2)
From: syzbot <syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99bade344cfa Merge tag 'rust-fixes-6.17' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10197af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f81850843b877ed
dashboard link: https://syzkaller.appspot.com/bug?extid=47d8cb2f2cc1517e515a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a3c442580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167c2ba2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-99bade34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01ac0e47f59c/vmlinux-99bade34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/000350d2833d/bzImage-99bade34.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eefdb34f2c0f/mount_2.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=15a3c442580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com

ocfs2: Unmounting device (7,0) on (node local)
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 5449 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller-00214-g99bade344cfa #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_clear_inode fs/ocfs2/inode.c:1284 [inline]
RIP: 0010:ocfs2_evict_inode+0x2d05/0x40e0 fs/ocfs2/inode.c:1296
Code: 02 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 dc db 83 fe 4d 01 f4 48 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 bc db 83 fe 48 8b 3b 49 81 c7 88
RSP: 0018:ffffc90002a6f340 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff8880006e2440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002a6fa70 R08: ffff8880438230b7 R09: 1ffff11008704616
R10: dffffc0000000000 R11: ffffed1008704617 R12: fffff5200054de78
R13: ffff888043823360 R14: dffffc0000000000 R15: ffff888043823338
FS:  000055556e79a500(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ac55909c0 CR3: 0000000042abb000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 evict+0x501/0x9c0 fs/inode.c:810
 __ocfs2_free_slot_info fs/ocfs2/slot_map.c:307 [inline]
 ocfs2_free_slot_info+0x79/0x260 fs/ocfs2/slot_map.c:443
 ocfs2_delete_osb+0x58/0x170 fs/ocfs2/super.c:2450
 ocfs2_dismount_volume+0x57a/0x8d0 fs/ocfs2/super.c:1884
 generic_shutdown_super+0x132/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1766
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1378
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4544b8ff17
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc0cacaac8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f4544c11c05 RCX: 00007f4544b8ff17
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc0cacab80
RBP: 00007ffc0cacab80 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc0cacbc10
R13: 00007f4544c11c05 R14: 0000000000013b93 R15: 00007ffc0cacbc50
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_clear_inode fs/ocfs2/inode.c:1284 [inline]
RIP: 0010:ocfs2_evict_inode+0x2d05/0x40e0 fs/ocfs2/inode.c:1296
Code: 02 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 dc db 83 fe 4d 01 f4 48 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 bc db 83 fe 48 8b 3b 49 81 c7 88
RSP: 0018:ffffc90002a6f340 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff8880006e2440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002a6fa70 R08: ffff8880438230b7 R09: 1ffff11008704616
R10: dffffc0000000000 R11: ffffed1008704617 R12: fffff5200054de78
R13: ffff888043823360 R14: dffffc0000000000 R15: ffff888043823338
FS:  000055556e79a500(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ac5c9f000 CR3: 0000000042abb000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	02 00                	add    (%rax),%al
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	d8 48 c1             	fmuls  -0x3f(%rax)
   8:	e8 03 42 80 3c       	call   0x3c804210
   d:	30 00                	xor    %al,(%rax)
   f:	74 08                	je     0x19
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 dc db 83 fe       	call   0xfe83dbf5
  19:	4d 01 f4             	add    %r14,%r12
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 08          	add    $0x8,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 bc db 83 fe       	call   0xfe83dbf5
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	49                   	rex.WB
  3d:	81                   	.byte 0x81
  3e:	c7                   	(bad)
  3f:	88                   	.byte 0x88


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

