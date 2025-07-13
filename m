Return-Path: <linux-kernel+bounces-728911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE3B02EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C66189AA07
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688E19F419;
	Sun, 13 Jul 2025 06:23:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709226FC3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752387785; cv=none; b=d4awlV/J9pUT6ruVRDv5mPSSl7TZEi/9bNAwujlpEpt6JBnKBnyDXHLXpvPe+Z3C+dLncQOLgNlS9CI9mIrhqzU3gu94hhpFJW9u4TQzPL1NkrXIFx7skhbVwmt2RHGYPg5Wu8iHhZCxd9pBEpo6bUaj5Ukpfy+02tsFNvELGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752387785; c=relaxed/simple;
	bh=CQNhjxXC34WRCpbhGsz+ANwNmSMFJocUdmvEkpNiZW0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XKRaX2hkYRs0UpCMUJ7vpR/3wAOcDoWjLASNZ2Ym7PM5JmBHarofx9uel9cg8rT7Ql5Escvj+vM+EA+UUe1LM5AgRFKFaK8W7SZZKBU+NSKqD0RV1ptd6QbXEvrIO5CpapAnI6wlk8IA0706BejBjlPA9NhKwFb3yuO5BcMH5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df393bf5f2so33296735ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752387782; x=1752992582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJa8eqyZucIEkUNd17IMPq+0MIZHEL1aO2u/+//0rkM=;
        b=uzJIZYcYiK23uy3cRgeGYtVqsCtXLziGNnL0GkLk+4o4IVWUrV6YJKATVcsPBMl2nw
         YT5N1Wg/zL4EHuXiUDCM273Vjl4XcEhbJIDPe9r0CyV5ehXDaoF7B2sKWGiNOPn5EAFr
         DBOBmAh226rQ1f1w0vrF2KtwOsBiH2W567QYiTeJZv2USz/yhfMQJIJsvzkPDv3s6dds
         hxOHhgyhu/kMrzIMVZcr9lWyE4WQuZvKRQOEOHU8jOrOJD+0OWtfkz8dUik6HVP2Ovvj
         hGBfuCddQC/4ciuSjO4fGhFlLChSRnTLUlZzs3ve1ae9argo3uRP08JCLsZxoytwHzCs
         rMvw==
X-Forwarded-Encrypted: i=1; AJvYcCXQyyl4GsSJl0kq8Xk2ngcNksA8SzVUjfbPCK4ZYp82ChZF6f+Bc8vNPzWcuBPikzJj0ktxV1e9o20Uoh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydwtpr3uhPaV1t8w9Oj9+nAHhynDTCUS74UDeoP+55c7AeCoDe
	P95n6UJqoBFJtSrJ/lVmiul6JkJXEwGQNw/irIb/Mgo3pKkwyo0FZJs3/1WmtwjoMXNWlgU735G
	6E5vZsXcLV31aFj79jwsuJDLktPGt+an29lRyuNmZHxJJsIxI7mdgTgbw6ds=
X-Google-Smtp-Source: AGHT+IHk4gEGZRhCuwIC1DsEwWofRQ6vLcnCa+uWYW1beRha/M3Vxdp9md7QZHT/3DphXLkCwLm6ihEj1wxkbyP501rXWR1NARPX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b:b0:3df:4159:8fe5 with SMTP id
 e9e14a558f8ab-3e253272d56mr91195725ab.4.1752387782518; Sat, 12 Jul 2025
 23:23:02 -0700 (PDT)
Date: Sat, 12 Jul 2025 23:23:02 -0700
In-Reply-To: <20250713051026.3829-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687350c6.a70a0220.3b380f.0024.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: spinlock bad magic in cipso_v4_sock_setattr

BUG: spinlock bad magic on CPU#1, syz.0.16/7437
 lock: 0xffff0000c5c00580, .magic: ffff8000, .owner: <none>/-1, .owner_cpu: -1
CPU: 1 UID: 0 PID: 7437 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 spin_dump+0x104/0x1ec kernel/locking/spinlock_debug.c:70
 spin_bug kernel/locking/spinlock_debug.c:78 [inline]
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x1c4/0x2cc kernel/locking/spinlock_debug.c:115
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x50/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 cipso_v4_sock_setattr+0x134/0x404 net/ipv4/cipso_ipv4.c:1903
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.h:68:9
index 8773 is out of range for type 'unsigned long[8]'
CPU: 1 UID: 0 PID: 7437 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 ubsan_epilogue+0x14/0x48 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xd0/0xfc lib/ubsan.c:455
 decode_tail kernel/locking/qspinlock.h:68 [inline]
 queued_spin_lock_slowpath+0x9f4/0xaec kernel/locking/qspinlock.c:285
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x2a8/0x2cc kernel/locking/spinlock_debug.c:116
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x50/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 cipso_v4_sock_setattr+0x134/0x404 net/ipv4/cipso_ipv4.c:1903
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
---[ end trace ]---
==================================================================
BUG: KASAN: use-after-free in queued_spin_lock_slowpath+0x854/0xaec kernel/locking/qspinlock.c:288
Write of size 8 at addr ffff00011ec59800 by task syz.0.16/7437

CPU: 1 UID: 0 PID: 7437 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x254 mm/kasan/report.c:408
 print_report+0x68/0x84 mm/kasan/report.c:521
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 __asan_report_store8_noabort+0x20/0x2c mm/kasan/report_generic.c:386
 queued_spin_lock_slowpath+0x854/0xaec kernel/locking/qspinlock.c:288
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x2a8/0x2cc kernel/locking/spinlock_debug.c:116
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x50/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 cipso_v4_sock_setattr+0x134/0x404 net/ipv4/cipso_ipv4.c:1903
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15ec59
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 fffffdffc47b1648 fffffdffc47b1648 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00011ec59700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff00011ec59780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff00011ec59800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff00011ec59880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff00011ec59900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11c207d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13054e8c580000


