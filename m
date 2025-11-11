Return-Path: <linux-kernel+bounces-896125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650ACC4FB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0633B8F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E033D6E2;
	Tue, 11 Nov 2025 20:25:32 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC533D6D5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892731; cv=none; b=ZON1oHeZTRgCheMIwTnTN3IbcIAjpLGYhRcpmR8okvcv2+zMOtfPnjV1bJMc4K+4+dS8UEJRZR/y2lZhq5w4tjqv2CCh1kEjr54hcKLIZD52KNRyLT1gm12pyi+hych7/ZPBumqcKajMLYaQ9u4Qwy/wGn5hHrfD6p1PSZ/IfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892731; c=relaxed/simple;
	bh=G21k23XPzM7ZfXXWaoVqydqXPou23iahOffp0woaw4w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lZ5HDnKNDL5R6db5K+3Z5LesEv/eBdsnO9ezZ7EbnvA7iiReh4D2oXCsfbMQTSXoW872nRr7rVw/nPj6FX6NP2wsyvhwOdQkNp0nNwfiRxug/dRk16qPOAsaJ7hmrv34SKhgzlTYiWtzdDBma3azw917kp6NnxtFU2VbfGTlua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-433689014feso1417385ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762892729; x=1763497529;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJkFoSRs8okndB0NF+WpPovtnW03gk5UHbHwEREFNng=;
        b=ATUQBkROIXxSu6j5+JfIQn+bR7RXD2ZlsMfU3s2OLtL0j1WlnUheZ7331s2Rl/GX02
         HAy84kgjInoK2QSVthT2hnhPdjRfEBVVPmBy4LB8U/wEKc6x3wxhWm7RbJGuRPe9Wu3L
         hCtdo+8GFOeB6ozbtLNq8Q4/5dv6feIzZ3vcwRzzt1KklCe5kG5SvAYTYTjOjZmassPa
         SUBc9eQL6aPJdvHC7+EPFO3I5fj4XiC4dQ/8u1Azv/pPyCH7tkBUnCQrAHVey8SotupL
         H7QAIhI5Bc6kYCcZA3B6SsAkN7A68LsMoUyQZA5q0SBmq+wVhjcbsvM/dWZcwYxSpP1B
         BPJw==
X-Forwarded-Encrypted: i=1; AJvYcCXxISS7gEf4Y5lemnnNLe/vgFNe7H1vtBdtd1zPcdXZ+YoO4qFUS/s1MQ51iqvV4lrForoIuBDA7x1GWWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPCjDJM6T++VixZ7IsLcMzeZGtzpmFiVr4z13uSSFWzI1Ritl
	PTqKmHgw731KL8Abf3GTZiIoNpgwdkHXWQ3wEHQQ4FMiUycjuQjuihCijTfCBN0p+CaP1JqeoPH
	Wxf21xeNs4ejNoVKjTI+nNxVv+5zksFJc2I7pHoYM/iH/zXxNook5wZTVxCI=
X-Google-Smtp-Source: AGHT+IE57QnP1Vs+yJMpX9ldQWcn5HAda5L26waD+epriwGTu5HuGfk0y33jAEuhEL/M3mr1UhZ6/3KppppFA4yr6gR+Z3oG1zU+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:370e:b0:433:7885:6105 with SMTP id
 e9e14a558f8ab-43473d6b887mr6996185ab.15.1762892729015; Tue, 11 Nov 2025
 12:25:29 -0800 (PST)
Date: Tue, 11 Nov 2025 12:25:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69139bb9.a70a0220.22f260.014b.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in __rt_mutex_slowlock_locked
From: syzbot <syzbot+60f8f8d9d0a992e59f1a@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136e9114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=60f8f8d9d0a992e59f1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f1bc58f2850/disk-4a0c9b33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4d546567b38/vmlinux-4a0c9b33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4618744dea2b/bzImage-4a0c9b33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60f8f8d9d0a992e59f1a@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 32768
Oops: general protection fault, probably for non-canonical address 0xdffffc00e0000153: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000700000a98-0x0000000700000a9f]
CPU: 0 UID: 0 PID: 13777 Comm: syz.2.923 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90004b4f2f0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffffffff8ac3ee8e RCX: 8a8d6ce156f8e600
RDX: 0000000000000000 RSI: ffffffff8ac3ee8e RDI: 00000000e0000153
RBP: ffffffff819ba5a3 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100a608c91 R12: 0000000000000000
R13: 0000000700000a98 R14: 0000000700000a98 R15: 0000000000000001
FS:  00007f6cb050e6c0(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31923ffc CR3: 0000000068aae000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:579
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 task_blocks_on_rt_mutex kernel/locking/rtmutex.c:1265 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1719 [inline]
 __rt_mutex_slowlock_locked+0x1223/0x25e0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xb5/0x160 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14f/0x750 kernel/locking/rwbase_rt.c:244
 i_mmap_lock_write include/linux/fs.h:548 [inline]
 vma_link_file mm/vma.c:1781 [inline]
 __mmap_new_vma mm/vma.c:2499 [inline]
 __mmap_region mm/vma.c:2670 [inline]
 mmap_region+0x1bf4/0x20f0 mm/vma.c:2740
 do_mmap+0xc23/0x10c0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a9/0x4d0 mm/util.c:581
 ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cb22af6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6cb050e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f6cb2505fa0 RCX: 00007f6cb22af6c9
RDX: 00000000027ffff7 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007f6cb2331f91 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000004012011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6cb2506038 R14: 00007f6cb2505fa0 R15: 00007ffebcf391b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90004b4f2f0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffffffff8ac3ee8e RCX: 8a8d6ce156f8e600
RDX: 0000000000000000 RSI: ffffffff8ac3ee8e RDI: 00000000e0000153
RBP: ffffffff819ba5a3 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100a608c91 R12: 0000000000000000
R13: 0000000700000a98 R14: 0000000700000a98 R15: 0000000000000001
FS:  00007f6cb050e6c0(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31923ffc CR3: 0000000068aae000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	c3                   	ret
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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

