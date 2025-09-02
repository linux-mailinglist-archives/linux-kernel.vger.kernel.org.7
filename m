Return-Path: <linux-kernel+bounces-796520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93696B401F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2BE17F3D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA42D640A;
	Tue,  2 Sep 2025 13:00:39 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF492C21C9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818038; cv=none; b=RvJ4NKeVQI5I0In83Ids1tw1sFL8im+suSf57eyL3n2eDd7MWwMECBmU6fQ1E5c6MsSqdUEA7J93ukY10qgO8yUKLZX4T+Q2/5Ef0OiVVcKqWxU8Bak0IXb2wKrYgQ9SLaZfKunQ+bff48A83iQsIPxQN+KidKUCEWZQu9tieoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818038; c=relaxed/simple;
	bh=38r41/kAdAJ5px11/MsZo6cre3zuZozsChaiutvWtxs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b+s5XK+RgQ0nfo35/IdZl57XM3lrE0j6Ce7a+BM/NvuOyY90ARlrXoBSGSQ1MfvWge3hNegTp60hftLn9I5jZXyJNumcvn1VZv9caK/fsyFE7nuSKHnS9nioU+RI5Yl/oEBdBhaJBoYN7r1Ck2BwQgB3jJXPlqOZGcwJfhTKnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88709bc9a60so405491839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818036; x=1757422836;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jn8LMsoE+268wygzPr0oD5G8UOuM8VPHBk9q7DPG1+Y=;
        b=Ye9c+Er2LlepzPqLmDBWsDV50nLzYjar3mwCGd92+HkAGcVQHNzNAM9giE30sYxR+P
         NJa+nf83wUdI44WLpV62ybuoFrfMqqBjevRT/AcoapTMYnR0VUA459A3ugk9bMkbtpFO
         pp6ZOF9W4jEe+V9A0Q7Aqk2PHFNOsUwN/JYCdzfKgP5IsD/+RT0GSKd+VxvOi+seTndv
         lGG3P3uISsBpzVkQ9/Z+iwM3aoyQFGV8mU1oNCuMkPFm6iekwv6Rsc2AgNfdCb2ec/lP
         QapDKyfyg0z6IMpoGOEPjfx7PrPvKfd2UfSyxXq9L9fo5d+7uM+3Ri8izBJRKn9PbgAk
         XbXg==
X-Forwarded-Encrypted: i=1; AJvYcCXSRa/Tkwz9EKYcnAWn/vKVAKxeLs1uMYRRpW8c2Vqeedkl3IT4e8SPr/PE4qSpGAHQzX9fFRCGiDbIQNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1YVfwIifUTM52H96Am44laMkK4oHSiBLA5Or1B1HZKjtHKi5
	sXuldLctRSl7XvZR5W0QH79YcJbR+3Y/m7fvQmh/K4bfOJx1JAeLCTKulU8QbjLZLFHzYCMyBnu
	i+T09anrpuWxxH/u03o2WHoiiGXKQSjguBfqEt1c7AyL0myuLOdEN1gw0UTc=
X-Google-Smtp-Source: AGHT+IEhLKWtZDWr9haN7SW0W6MKD3WWqtaXV6kkAoeOk7b4hb3qoU/8rkT3L0tDuLyFxp4rKO2ejPf05hqLVs96Vbxroqwee60D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1989:b0:3f2:d8b9:e982 with SMTP id
 e9e14a558f8ab-3f4002863cemr208270265ab.8.1756818036381; Tue, 02 Sep 2025
 06:00:36 -0700 (PDT)
Date: Tue, 02 Sep 2025 06:00:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b6ea74.a70a0220.1c57d1.059a.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in try_to_wake_up (3)
From: syzbot <syzbot+9656cc66de78ef06f223@syzkaller.appspotmail.com>
To: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fb679c832b64 Merge tag 'efi-fixes-for-v6.17-1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d10e34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=9656cc66de78ef06f223
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166bea62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c4f545b9b8c/disk-fb679c83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a62451bb9286/vmlinux-fb679c83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae1daa9f76c2/bzImage-fb679c83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9656cc66de78ef06f223@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 6014 at kernel/locking/lockdep.c:238 hlock_class kernel/locking/lockdep.c:238 [inline]
WARNING: CPU: 0 PID: 6014 at kernel/locking/lockdep.c:238 check_wait_context kernel/locking/lockdep.c:4854 [inline]
WARNING: CPU: 0 PID: 6014 at kernel/locking/lockdep.c:238 __lock_acquire+0x379/0xd20 kernel/locking/lockdep.c:5187
Modules linked in:
CPU: 0 UID: 0 PID: 6014 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4854 [inline]
RIP: 0010:__lock_acquire+0x379/0xd20 kernel/locking/lockdep.c:5187
Code: eb 33 90 e8 c9 29 18 03 85 c0 74 22 83 3d 12 64 81 0d 00 75 19 90 48 c7 c7 ba 7b 21 8d 48 c7 c6 d1 69 11 8d e8 98 37 e7 ff 90 <0f> 0b 90 90 90 31 c0 48 8b 3c 24 0f b6 98 c4 00 00 00 41 8b 46 20
RSP: 0018:ffffc90003a67770 EFLAGS: 00010046
RAX: e21a353069bb2e00 RBX: ffff8880b883b530 RCX: ffff8880343a5940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000dfa R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017104863 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880343a6500 R15: ffff8880343a6460
FS:  00007f39a6a5d6c0(0000) GS:ffff8881268c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39a6a5cf98 CR3: 000000004302e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
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
RIP: 0033:0x7f39a740ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39a6a5d038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f39a7646090 RCX: 00007f39a740ebe9
RDX: 0000000000000001 RSI: 000000000000000c RDI: 000020000000cffc
RBP: 00007f39a7491e19 R08: 0000200000048000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f39a7646128 R14: 00007f39a7646090 R15: 00007ffd222b4528
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

