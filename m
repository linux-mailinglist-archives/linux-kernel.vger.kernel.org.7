Return-Path: <linux-kernel+bounces-797331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52505B40EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA843B21BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5922E7F14;
	Tue,  2 Sep 2025 20:54:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987545C0B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846476; cv=none; b=c6yqemKSnJXLQHVubSemNfQTVpMncAVhq+/ESiRlfLRKnYeTR8oOyAV62ETaVE0ZQkxlRZ0uz+/FnD6xHWPekc9KzxqlJj7nQURpaTVu4jKjNcosytM7QYp1GkUE8vRxb+Nlz8Q5t/Lp326mf5lLqqLbr61nBSqn0lx5P3kSqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846476; c=relaxed/simple;
	bh=YT7nMZTKPHDpCidZxzgXqAT1sdYMSMsjCuyKf25fYg4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y9/+UzIqatSqNPf14ElCuRYWWcN34Y3zlbvx6G+8nkLFs4l7+1T6WjE4LjbIkg0/BrMo59AjUXInZxUVu/0DgE6JDQuIDTSU+8F7NcDYis/RiSZLFSX6aPEyipP/je3OPpWDk/eH/9SsE7hH9NIhOwz7GGUV2waP+g3hH1nfxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-887303f3030so530148239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846474; x=1757451274;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyA1c0vvPRYba5CtljDGbojAf44Bk2ftLX48sRAefow=;
        b=pf0kHbU4hjU84QmgwYINpEJylCn13eRj+nl0u2EzFsgg+AeoqExjmTcgcuuXHNV86E
         iJxzAJhJHvHnX/NJPmVHfJZRc6ooVQT+ZBLxgbW9boM+rcAUrqjgLMwqZ0GJVY8JhUzD
         vSPSzlsKAZAaVpZCQzbSb2EzeOKmFiO8MFgoGUgefaT9/5gd5TIBSLikjhPVKcguiqG1
         IhHeKXszALmiYkrpQPmt7WU4uAUI8aOVqMKoetpI257yLBAznko1+UtFUo+k8cJV7l5y
         /pQkPdSZQGqauNinxhMndwJLDpgzUR7YOGmPiC/dzCGCIusuRklLEMKeK837enfs5Zny
         3u4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4LmCcbT2LODfkBox2WDwgCgA131cU5921KaseEVxdFhMq+w25W9zFb4Qa0tdUxcyzGCMUVi+mgCJk+s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqsZ4U+BsBTCJZbLwACwU4ewK0ZUVBiPcicq9q7TRNRk7ddY3
	6GEoSyDj+hdRN+s6MgW8Tu99/9vdRZEtL+2r3uziH0peoNhgXxFv7CSQBfNo8UC9bXi46EURuG8
	Cx3gdC/ziuvZ8KFTQxMRkhnl5lSXpnE/7yQzET+jTWBbDGfRnWoPCqV1ktDA=
X-Google-Smtp-Source: AGHT+IHKxTZqwg1/94d7sdwXW7ZGv+KlLrn8t4M+kpFoeQRoZLDqK97tjuiF7+g3xLswo0AH9Xf4NjA6+8BferVE9gIDKvQOrS2W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26c2:b0:887:26b5:a581 with SMTP id
 ca18e2360f4ac-88726b5b5bemr257271839f.12.1756846473712; Tue, 02 Sep 2025
 13:54:33 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
Subject: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
From: syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>
To: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5c3b3264e585 Merge tag 'x86_urgent_for_v6.17_rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e1ae34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=034246a838a10d181e78
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f6a1f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37953b384dff/disk-5c3b3264.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df5cc1c4e51d/vmlinux-5c3b3264.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ed6195eae9f/bzImage-5c3b3264.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+034246a838a10d181e78@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000014b: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000a58-0x0000000000000a5f]
CPU: 1 UID: 0 PID: 6293 Comm: syz.0.60 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 d0 9f dc 08 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000157f7e0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffffffff8af9dfe7 RCX: e1dbfc1ee2ae4a00
RDX: 0000000000000000 RSI: ffffffff8af9dfe7 RDI: 000000000000014b
RBP: ffffffff81908477 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1e3a947 R12: 0000000000000000
R13: 0000000000000a58 R14: 0000000000000a58 R15: 0000000000000001
FS:  00007ff6ed61d6c0(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff6ed61cf40 CR3: 0000000027554000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:567
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
 try_to_wake_up+0x67/0x12b0 kernel/sched/core.c:4216
 requeue_pi_wake_futex+0x24b/0x2f0 kernel/futex/requeue.c:249
 futex_proxy_trylock_atomic kernel/futex/requeue.c:340 [inline]
 futex_requeue+0x135f/0x1870 kernel/futex/requeue.c:498
 do_futex+0x362/0x420 kernel/futex/syscalls.c:-1
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff6edfcebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff6ed61d038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007ff6ee206090 RCX: 00007ff6edfcebe9
RDX: 0000000000000001 RSI: 000000000000000c RDI: 000020000000cffc
RBP: 00007ff6ee051e19 R08: 0000200000048000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff6ee206128 R14: 00007ff6ee206090 R15: 00007ffd53c7a368
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 d0 9f dc 08 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000157f7e0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffffffff8af9dfe7 RCX: e1dbfc1ee2ae4a00
RDX: 0000000000000000 RSI: ffffffff8af9dfe7 RDI: 000000000000014b
RBP: ffffffff81908477 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1e3a947 R12: 0000000000000000
R13: 0000000000000a58 R14: 0000000000000a58 R15: 0000000000000001
FS:  00007ff6ed61d6c0(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff6ed61cf40 CR3: 0000000027554000 CR4: 00000000003526f0
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
  18:	66 0f 1f 00          	nopw   (%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	e9 d0 9f dc 08       	jmp    0x8dca008
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

