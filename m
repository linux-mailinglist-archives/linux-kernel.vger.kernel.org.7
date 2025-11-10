Return-Path: <linux-kernel+bounces-893479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A70C4786D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33D33B4E47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C525C6F9;
	Mon, 10 Nov 2025 15:19:20 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC12475CE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787960; cv=none; b=IwzTBXfXWo+NAD+0bdBEoeFxVbgtUKNc5/RYuJo9MSIaAi6e/wHl+TjwWUWDE7G1oRK/dYBsU4xhtHFHEMbXGR0V64NBXr1vXlDBq1+BCmSGeWUCJ1iIv1ZOiC1qhHmmU4zlfKTrj7DaXvyqSagieOKsyxJhTzxfwY5udb9yUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787960; c=relaxed/simple;
	bh=c1DO/0QTjCGAhqXJ6RVRv00rey+X7TfUveEq6Q4CklQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=uZ/mBWJuOwT3z9TK/ds9CotHKk4LtCAWlK7VtIp5XLsHMRtAQRexTwx6v5ws+IYnC2XtY+UhvBzru4VZf/wf5WYRDDd9nd59/27aZ5I/orCFYhAm/FV5QsyAlk92m4a4M2QOqP+xfEZ5EjE39qxEIMMbuX4xLTkT9CNeajXWOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43328dcdac1so100205905ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787957; x=1763392757;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ2NWlZ546cks4M6j4DNqCc2vYjUuH0vrlSlhM9Y2K8=;
        b=IoepdFHXFl0+grD8RwGqQQ3Vqa37MZih2UXwK9sFaLWAesZqHgbQGjItYCl4vrTF9J
         UF1NPvpXJo7ZwcLxfuQtzlMikY3ITtIVuNTG+f2LQ9BWLaEhvBTnM6RsxUHiUIRPbs0Q
         XOtgSRj2fh1JM2bB2x5kba7kQH8Q0+oAnwCa/dAXU1suY5ZTr//XTKcBiWncFmasJsha
         oV2QKI7EAgANtQgY3cOcTAZM6969KB4INrRrBWZDHAy0w7BjGjB8VNgVuTVZbzaU/0be
         zBj0DhFIp0+bPqp1N9zGOsmZkm+5yGixwaTSOWJydZiy9/QbSL+ATMx0/zxLqn/4dV1L
         QYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUd47NHJI3dHM56ucbI+hywYYly4uO5CHsVYfY5dg0sUXhB5n3ORKafGMDqVUi686Mb9l5NhA5tKAYZn1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nvYIvfaA9w7msx1b40bfDeu8j5zJptcTLoVcHqRZ1s4M6Dat
	YisOMWyiRCZltwQCS2CsmV5lNue4yxBrqd78Xb1Lo2d4NxwrvFwq8U02sSH3zRn6SF/rQaoiDLQ
	uZurU8twflsixUNKT5WcsRm08yRvGGBU8pz6B4QfvkS2vKae9Ef3DuuKCQ2o=
X-Google-Smtp-Source: AGHT+IFT43QlM8pcln8U+Eww+O0zzAExm6XXgPQBWfT6KRG7VIkvfXjO0jztElePth8ZM3wp+BZTjgkncLB2kVRNvkTts8Hag2iy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cccd:0:b0:433:7310:f5bf with SMTP id
 e9e14a558f8ab-4337310f94amr69754165ab.22.1762787957532; Mon, 10 Nov 2025
 07:19:17 -0800 (PST)
Date: Mon, 10 Nov 2025 07:19:17 -0800
In-Reply-To: <20251110111553.88384-1-lance.yang@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69120275.a70a0220.22f260.00f7.GAE@google.com>
Subject: [syzbot ci] Re: mm/hugetlb: fix possible deadlocks in hugetlb VMA
 unmap paths
From: syzbot ci <syzbot+ci4b465da2e9479793@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, lance.yang@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	osalvador@suse.de, syzbot@lists.linux.dev, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] mm/hugetlb: fix possible deadlocks in hugetlb VMA unmap paths
https://lore.kernel.org/all/20251110111553.88384-1-lance.yang@linux.dev
* [PATCH v2 1/1] mm/hugetlb: fix possible deadlocks in hugetlb VMA unmap paths

and found the following issue:
possible deadlock in unmap_vmas

Full report is available here:
https://ci.syzbot.org/series/3106300b-af9f-40dc-985b-33cb937712aa

***

possible deadlock in unmap_vmas

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/089d8dad-bc85-4724-8a79-2ad934becf17/config
C repro:   https://ci.syzbot.org/findings/3dded3f6-aef2-4f4c-9dba-b23214df5e12/c_repro
syz repro: https://ci.syzbot.org/findings/3dded3f6-aef2-4f4c-9dba-b23214df5e12/syz_repro

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/5963 is trying to acquire lock:
ffff88816cbda8e8 (&resv_map->rw_sema){+.+.}-{4:4}, at: hugetlb_zap_begin include/linux/hugetlb.h:257 [inline]
ffff88816cbda8e8 (&resv_map->rw_sema){+.+.}-{4:4}, at: unmap_vmas+0x23d/0x580 mm/memory.c:2098

but task is already holding lock:
ffff888172c80418 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: i_mmap_lock_write include/linux/fs.h:548 [inline]
ffff888172c80418 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: __hugetlb_zap_begin+0x2aa/0x3a0 mm/hugetlb.c:5331

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       i_mmap_lock_write include/linux/fs.h:548 [inline]
       hugetlb_change_protection+0x56a/0x18c0 mm/hugetlb.c:6439
       change_protection+0x386/0x38c0 mm/mprotect.c:655
       mprotect_fixup+0x6fe/0x9c0 mm/mprotect.c:774
       do_mprotect_pkey+0x8c5/0xcd0 mm/mprotect.c:930
       __do_sys_mprotect mm/mprotect.c:951 [inline]
       __se_sys_mprotect mm/mprotect.c:948 [inline]
       __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:948
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&resv_map->rw_sema){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       hugetlb_zap_begin include/linux/hugetlb.h:257 [inline]
       unmap_vmas+0x23d/0x580 mm/memory.c:2098
       exit_mmap+0x23e/0xb30 mm/mmap.c:1277
       __mmput+0x118/0x430 kernel/fork.c:1133
       exit_mm+0x1da/0x2c0 kernel/exit.c:582
       do_exit+0x648/0x2300 kernel/exit.c:954
       do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
       __do_sys_exit_group kernel/exit.c:1118 [inline]
       __se_sys_exit_group kernel/exit.c:1116 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
       x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hugetlbfs_i_mmap_rwsem_key);
                               lock(&resv_map->rw_sema);
                               lock(&hugetlbfs_i_mmap_rwsem_key);
  lock(&resv_map->rw_sema);

 *** DEADLOCK ***

2 locks held by syz.0.17/5963:
 #0: ffff88810e0f8ca0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:365 [inline]
 #0: ffff88810e0f8ca0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x126/0xb30 mm/mmap.c:1262
 #1: ffff888172c80418 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: i_mmap_lock_write include/linux/fs.h:548 [inline]
 #1: ffff888172c80418 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: __hugetlb_zap_begin+0x2aa/0x3a0 mm/hugetlb.c:5331

stack backtrace:
CPU: 1 UID: 0 PID: 5963 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 hugetlb_zap_begin include/linux/hugetlb.h:257 [inline]
 unmap_vmas+0x23d/0x580 mm/memory.c:2098
 exit_mmap+0x23e/0xb30 mm/mmap.c:1277
 __mmput+0x118/0x430 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6bb058efc9
Code: Unable to access opcode bytes at 0x7f6bb058ef9f.
RSP: 002b:00007ffedbb6b2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6bb058efc9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 00000002dbb6b3ef R09: 00007f6bb07b1280
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6bb07b1280 R14: 0000000000000003 R15: 00007ffedbb6b3b0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

