Return-Path: <linux-kernel+bounces-869595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B785C0845C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBBA1AA8100
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852B30CDA1;
	Fri, 24 Oct 2025 23:10:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8235B14E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347431; cv=none; b=lrN6X1VpmtWx+TeXd7sEo1DLSdF00dLXjlcmpqYysLlM6rQwcP2d566iw47ANmQNtABNK0Py44YMAJV2GjifrFYvoGfaktN68y8TuhjjHyuSqP+Zq0zuXCLt11MRhKH3/et/sbddzhNmyExW5YG2LT0cF308svO81WoL6P+Rg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347431; c=relaxed/simple;
	bh=S2lfKh+nymZf0zkhhxFKGQLtglOcg1QhU4VjgRdyexU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aLAW7uLsDNIX9xOCDS17InZa5kaRwcXTU5DkpAP2N+sX6nQyirT7xevPPf/LwN2YLV8qSdQOBr4/HRh5XxRm0spD4ozNKkbpkPOfh+7eaagD3QS7z9K5TezZuOXrz2EWBzXAnQUNZtQbhNnEsbwUjUdJuWYfrRZmQR+iU8tS/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-430ce62d138so34560135ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761347429; x=1761952229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biMt/P+KBmkSrn0hOc32Lxw4C5/svQcLWHP0okbKXeA=;
        b=sEXnfYynnWjeyJh+EsxZfv9JorPvx/AB4DuLLl0Nq3OjcYB9/Aq64Rf9DobPhaSy9i
         dkn24/QQ10Bj97WCA2nhicNaECNogwnZ4exq5ofRG3+HVqKzMGjb4paNNn85I+gHhfiQ
         fGD7+ou4OaeC7EgKhYYCw6EChLh73DTj7OWwlIbd3YefSTgivHjhcrMIzWuQiXKFHgnP
         3y0MmS0KpYsjxpbO5ymw5BeeHURXpeLo2QsaR8Fha8SU6eMfg/BEm57Fd8KfMUe3mphn
         nMoAGqzMXU6CeQqdXZQmcuDDxq06IkvaQcp/cE5LiGwCvHZ1zkNwQorTti6v18K3AhuA
         kvIA==
X-Forwarded-Encrypted: i=1; AJvYcCVBgPr422NPx0B51fEAKjyNQm0j47HsiZfIunHXFxCRw8etQv9Jl/SsKiAH6ZlrUiINkktlGXs2/YSWn00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1XRJm67NZ3y+dZDgVgj03N5cwJmRjqbA0x6YlM+c+3go6QHO
	5+hjBI5HIyHrQ4KGdQVZU2kzUwZpBxA9nHQjmUPD2O7IN9qXRUWVR/6d3Oxgp6B6E35WK3VERyP
	FXK4MWyBjsHI/NvGOW+hmX//BRgrZbL/FiDbqdmCpAHHTpQWsB5YDIcIzaaQ=
X-Google-Smtp-Source: AGHT+IGBL+v4cR6ExRLYCFwvkJUdLFYim5SE0XXsvMsuW2/IikXvag9O30gehAEoZ/NKZjKk79z/V9I8v1RgsRBPUmBbsAkWdDrV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2708:b0:430:adcb:b38d with SMTP id
 e9e14a558f8ab-430c528dbdbmr337793175ab.24.1761347429247; Fri, 24 Oct 2025
 16:10:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc0765.a00a0220.9662e.000d.GAE@google.com>
Subject: [syzbot] [jfs?] general protection fault in inode_set_ctime_current
From: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fab32bb6508 MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd2d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df98b4d1d5944c56
dashboard link: https://syzkaller.appspot.com/bug?extid=cd7590567cc388f064f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155a8be2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15078258580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6fab32bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b126dd4d891b/vmlinux-6fab32bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae26100863fd/bzImage-6fab32bb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6617e28639c8/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=125f8c92580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
Oops: general protection fault, probably for non-canonical address 0xe00e9c0e000c60d6: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00750070006306b0-0x00750070006306b7]
CPU: 0 UID: 0 PID: 5495 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:timestamp_truncate fs/inode.c:2732 [inline]
RIP: 0010:inode_set_ctime_current+0xcf/0xb40 fs/inode.c:2774
Code: d8 48 c1 e8 03 48 89 44 24 30 42 80 3c 20 00 74 08 48 89 df e8 e2 67 e7 ff 4c 8b 3b 49 8d bf 40 06 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 d6 07 00 00 48 89 5c 24 20 41 8b 87 40
RSP: 0018:ffffc90002b4f600 EFLAGS: 00010202
RAX: 000ea00e000c60d6 RBX: ffff88801c1ab220 RCX: ffff8880002b0000
RDX: 0000000000000000 RSI: 187182c674eb3579 RDI: 00750070006306b2
RBP: ffffc90002b4f6f0 R08: ffffffff8f7cf377 R09: 1ffffffff1ef9e6e
R10: dffffc0000000000 R11: fffffbfff1ef9e6f R12: dffffc0000000000
R13: ffff88801c1abe60 R14: ffffc90002b4f660 R15: 0075007000630072
FS:  000055557920a500(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31463fff CR3: 0000000011599000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 jfs_create+0x7f7/0xa80 fs/jfs/namei.c:152
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x14f4/0x3830 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f1c98efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9e448248 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3f1cbe5fa0 RCX: 00007f3f1c98efc9
RDX: 000000000000275a RSI: 0000200000000140 RDI: ffffffffffffff9c
RBP: 00007f3f1ca11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3f1cbe5fa0 R14: 00007f3f1cbe5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:timestamp_truncate fs/inode.c:2732 [inline]
RIP: 0010:inode_set_ctime_current+0xcf/0xb40 fs/inode.c:2774
Code: d8 48 c1 e8 03 48 89 44 24 30 42 80 3c 20 00 74 08 48 89 df e8 e2 67 e7 ff 4c 8b 3b 49 8d bf 40 06 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 d6 07 00 00 48 89 5c 24 20 41 8b 87 40
RSP: 0018:ffffc90002b4f600 EFLAGS: 00010202
RAX: 000ea00e000c60d6 RBX: ffff88801c1ab220 RCX: ffff8880002b0000
RDX: 0000000000000000 RSI: 187182c674eb3579 RDI: 00750070006306b2
RBP: ffffc90002b4f6f0 R08: ffffffff8f7cf377 R09: 1ffffffff1ef9e6e
R10: dffffc0000000000 R11: fffffbfff1ef9e6f R12: dffffc0000000000
R13: ffff88801c1abe60 R14: ffffc90002b4f660 R15: 0075007000630072
FS:  000055557920a500(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffabbbdc000 CR3: 0000000011599000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	d8 48 c1             	fmuls  -0x3f(%rax)
   3:	e8 03 48 89 44       	call   0x4489480b
   8:	24 30                	and    $0x30,%al
   a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   f:	74 08                	je     0x19
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 e2 67 e7 ff       	call   0xffe767fb
  19:	4c 8b 3b             	mov    (%rbx),%r15
  1c:	49 8d bf 40 06 00 00 	lea    0x640(%r15),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 d6 07 00 00    	jne    0x80d
  37:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
  3c:	41                   	rex.B
  3d:	8b                   	.byte 0x8b
  3e:	87                   	.byte 0x87
  3f:	40                   	rex


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

