Return-Path: <linux-kernel+bounces-778829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44208B2EBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C711CC0CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0A2D6639;
	Thu, 21 Aug 2025 03:10:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0543D76
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745833; cv=none; b=OLA0hcDiuevuF3b4G3rVnU7BMwIbMpUMuR6lPXZjaFDjcJMzAfV6m6KPNYKrMkJTHXpYX6ruR1ZpT9/Y+uuXAGHZJidX2KBF40+SlGXUUnXTV1JsUC1PesR4SztF01sjl6GJSOld67Hy+1pmuxMgAikqeFzio9mtNd9s9KFU+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745833; c=relaxed/simple;
	bh=hT72nufqCmVWtV8hkhAkV70YBpgS9piBH+ZkrGk9xEg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PjFIF7+GI671efcU0FQCJyX0Rl2KHlp1/RrzutH9Z0qa98GFkwb47PCcD9HG7+7TxhA01y6tCcW/pcMJvch8w0amLsF7QxA4ycTEBULiPcPNyDIZcfA2VeRA0Ly0o2plj2cDnUaroqmaksYEACQIAX/WM+l2heC4KUs4j5fcJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e67fa671beso5219255ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745831; x=1756350631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2TkSh0oWm1yzX3q/7Wu1wD7ClTaGjDasGuUAyNwNdE=;
        b=T4ZqwodWz58ES6kY48+91/U9uQTmu0Y0hEP6fD9Y3515LkFx6mh70DqMSSIejcSq+z
         WXU4oMusT8dDeTIEd/aJBJG621RxfIMM7Q4dbwGSHH/tIu5by4uum9b9GWZ2ceUNsOVb
         NR6E2+WnXiHKQy+kSIMYkXcrZHnAqyX+/RYEerTntYGUbcqNmSCSeAAzjz4JbrRXhMEE
         acPef3lOFeqyJjSdeWgGkXceW74JJoUTD4suN8sYQEE/sJxnIlxQukxOQ/jdocqOEGau
         BzEp976CbZUrzmHkwvbKNHSnsS3AvdBgOGe6qYgkfYDOLzOKtO9f79KEamqzzcLRm5Bd
         oHTw==
X-Forwarded-Encrypted: i=1; AJvYcCX/VctenaGCG/IuPJq8aGQgQnwKg/P4oBYILSxJm+1aM73MTbuLnTRVdi0XJg0S1WgC5wXBn2ed4Sa0Ci8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+pl6eRrdAjWf0KQwx17k2bYN8svluqQWIjrYY2UEy/pFAwe3
	3KQ9YLJv5Q5oturXe/WU6N4h68SHeqMLH7Ig8kPNYayWQeYyHbpM5RNIrQ/j7AecgW++3bHosfK
	rl+MGpemDiYVXtQRZyVMoz/NNUtr/ROhxuuSzkX0sbKwcQArtLUp8/flu/54=
X-Google-Smtp-Source: AGHT+IHJBx+pHXtqdXW2m7y4tfiioh4VHwENWS66uPISpek5YUtvXCyaOq581Tq3aRHa35gt4fxGdgBGRjyBUe5+v6OnZG4SE3fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168b:b0:3e5:738c:3f3a with SMTP id
 e9e14a558f8ab-3e6d7865148mr15392445ab.21.1755745831301; Wed, 20 Aug 2025
 20:10:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:10:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a68e27.050a0220.1a3988.0002.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_truncate_hole (2)
From: syzbot <syzbot+b9c7ffd609c3f09416ab@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90d970cade8e Merge tag 'ata-ata-6.17-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118fb3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f81850843b877ed
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c7ffd609c3f09416ab
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-90d970ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/746014c1cf11/vmlinux-90d970ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f69411b895d/bzImage-90d970ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9c7ffd609c3f09416ab@syzkaller.appspotmail.com

 </TASK>
F2FS-fs (loop0): access invalid blkaddr:1818846767
CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __f2fs_is_valid_blkaddr+0xe52/0x14f0 fs/f2fs/checkpoint.c:213
 f2fs_truncate_data_blocks_range+0x790/0x1390 fs/f2fs/file.c:674
 f2fs_truncate_hole+0x3f2/0x6c0 fs/f2fs/file.c:1245
 f2fs_punch_hole+0x2db/0x330 fs/f2fs/file.c:1306
 f2fs_fallocate+0x546/0x990 fs/f2fs/file.c:2018
 vfs_fallocate+0x666/0x7e0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e65f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1e66dd1038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1e661b6090 RCX: 00007f1e65f8ebe9
RDX: 0000000000000003 RSI: 0000000000000003 RDI: 000000000000000a
RBP: 00007f1e66011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000404042bbe R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1e661b6128 R14: 00007f1e661b6090 R15: 00007ffe98c9dc98
 </TASK>
F2FS-fs (loop0): Inconsistent error blkaddr:12389, sit bitmap:0
CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __is_bitmap_valid fs/f2fs/checkpoint.c:168 [inline]
 __f2fs_is_valid_blkaddr+0xd84/0x14f0 fs/f2fs/checkpoint.c:216
 f2fs_truncate_data_blocks_range+0x790/0x1390 fs/f2fs/file.c:674
 f2fs_truncate_hole+0x3f2/0x6c0 fs/f2fs/file.c:1245
 f2fs_punch_hole+0x2db/0x330 fs/f2fs/file.c:1306
 f2fs_fallocate+0x546/0x990 fs/f2fs/file.c:2018
 vfs_fallocate+0x666/0x7e0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e65f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1e66dd1038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1e661b6090 RCX: 00007f1e65f8ebe9
RDX: 0000000000000003 RSI: 0000000000000003 RDI: 000000000000000a
RBP: 00007f1e66011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000404042bbe R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1e661b6128 R14: 00007f1e661b6090 R15: 00007ffe98c9dc98
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/f2fs/file.c:1243!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:f2fs_truncate_hole+0x69e/0x6c0 fs/f2fs/file.c:1243
Code: 75 1d 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 55 7b 7d 07 cc e8 af fa be fd eb a4 e8 58 96 7a 07 e8 a3 fa be fd 90 <0f> 0b e8 9b fa be fd 4c 89 ef 48 c7 c6 20 8c d1 8b e8 cc 3b 27 fd
RSP: 0018:ffffc9000eddfbe0 EFLAGS: 00010287
RAX: ffffffff8400c09d RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e523000 RSI: 0000000000072bb6 RDI: 0000000000072bb7
RBP: ffffc9000eddfd18 R08: ffff8880433a2887 R09: 1ffff11008674510
R10: dffffc0000000000 R11: ffffed1008674511 R12: 0000000000000360
R13: ffffffffffffffff R14: 0000000000404042 R15: 00000000000006c0
FS:  00007f1e66dd16c0(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e65fec470 CR3: 000000003f147000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 f2fs_punch_hole+0x2db/0x330 fs/f2fs/file.c:1306
 f2fs_fallocate+0x546/0x990 fs/f2fs/file.c:2018
 vfs_fallocate+0x666/0x7e0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e65f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1e66dd1038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1e661b6090 RCX: 00007f1e65f8ebe9
RDX: 0000000000000003 RSI: 0000000000000003 RDI: 000000000000000a
RBP: 00007f1e66011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000404042bbe R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1e661b6128 R14: 00007f1e661b6090 R15: 00007ffe98c9dc98
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_truncate_hole+0x69e/0x6c0 fs/f2fs/file.c:1243
Code: 75 1d 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 55 7b 7d 07 cc e8 af fa be fd eb a4 e8 58 96 7a 07 e8 a3 fa be fd 90 <0f> 0b e8 9b fa be fd 4c 89 ef 48 c7 c6 20 8c d1 8b e8 cc 3b 27 fd
RSP: 0018:ffffc9000eddfbe0 EFLAGS: 00010287
RAX: ffffffff8400c09d RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e523000 RSI: 0000000000072bb6 RDI: 0000000000072bb7
RBP: ffffc9000eddfd18 R08: ffff8880433a2887 R09: 1ffff11008674510
R10: dffffc0000000000 R11: ffffed1008674511 R12: 0000000000000360
R13: ffffffffffffffff R14: 0000000000404042 R15: 00000000000006c0
FS:  00007f1e66dd16c0(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e65fec470 CR3: 000000003f147000 CR4: 0000000000352ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

