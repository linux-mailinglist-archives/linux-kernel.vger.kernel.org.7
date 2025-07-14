Return-Path: <linux-kernel+bounces-730503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847ADB045A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6AA4A7498
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE263263F52;
	Mon, 14 Jul 2025 16:38:36 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85502263F4A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511116; cv=none; b=oDq7kHjmWOz+Q67/ZqACSHrYNTY0XvUNEmo0O9GHWypyxdFpi191YbUu497UPJh1FIRdXMMLlwSlJIm1lNkzbmCxxX91Q3snQ5DlGZ+3+Um6St5sGDg4rmM/huOUD9GfP00c8fJY0ICpWRmF+fDxUKwaPQ/goQzWMuUpXoqDhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511116; c=relaxed/simple;
	bh=zBcoPsPVLXUVDmBKtl9p8Vx+6vuSy7PSVLfQjMQGkck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rhrvR3Crk1FRhxRD0k7JpeSaSOdAL67eeEUKJgKuOoq2Xh/WravYPQ7SsWcsyZT2n5c1jxXF2SqwC556CiexG78UTYnOWQXCMxDgN5FoL21SZ46/wjQYN9C/vKtAolHxQZ4zRzBQtbTCFL2joPslap6h2lmOJ7khnypFwjZ3RWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87313ccba79so894536639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511113; x=1753115913;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vECSHC5HZApOKK3p2sozzKgFWuRc6UShB6Spwxs7Ok=;
        b=dZbIP1Bd1FYjRDLKZDshXAbPCKvf/2nkD2VKxQ+oyB1wk9/P2c2M8B/BwEXWgRSXFV
         fuz+jtTDCjs0R8wPqyqKzKT3c2jK+rm9OfRwfFbLu+wUWE/WAhye6bJ3IhOM2nnbbqQ4
         wRpMCMSooCGtlUk+z+x9GqRS97mKLkGdvd62/0S47OIx6npKzgnloorFGznWc8+cqtvp
         ENv/Sj6748moScDQsEAiiH4gRrp62wgaFRuyCklby3xQq9NDphJo3scAE4oZkmjL2h+k
         EGrfGyIl77RONq0L4g5osrAxPcwGpUOP5MrQc6NKPMK0KxpIPYeGMLTLujd8o/ONynHC
         CGHA==
X-Forwarded-Encrypted: i=1; AJvYcCWC8sdHqvMleFyGSD0wc+Xa89A8Xw+eYdBOlNeR6UIXdP5yKiEOwEH27hLhP/yss7/r4fHXutpa3hMHmb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGS4RYiYxcXlW8z8RmKqCcxUPF2MPQGSC6oUR1/t1n29fiKXQv
	U1Srjw7c7TPftC4glUqTEOT04AK/4fbjuWEgy2T6FkDvrqRpxbqf/vbf31Ls1mZ2GEi76SIwslR
	pivup9Cooi4Y7c75K+GttIOm4Cp+5ewdpXACmudfaDX90V5N5E4PUkyVQt/c=
X-Google-Smtp-Source: AGHT+IGxv3OKeAhsNMGG3ZcxHHqsJgQMLneAUR/N4UE0K0dxGV3pqhz/YTgQNtSoCHuX7519tj9SUygrQSglFclpzxXQ6Y1SP5Qt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b0d:b0:876:8bf2:e4d2 with SMTP id
 ca18e2360f4ac-879787a2806mr1578319039f.2.1752511113633; Mon, 14 Jul 2025
 09:38:33 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:38:33 -0700
In-Reply-To: <6871f94b.a00a0220.26a83e.0070.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68753289.a70a0220.18f9d4.0003.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
From: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, shakeel.butt@linux.dev, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15cfb0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9e2082003f81ff
dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1003b18c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11437d82580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/69e6cc49d526/disk-0be23810.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71d1bab88eaa/vmlinux-0be23810.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a516dc7bb0d/bzImage-0be23810.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc6-next-20250714-syzkaller #0 Not tainted
------------------------------------------------------
syz.2.103/6308 is trying to acquire lock:
ffff88807d33bde0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
ffff88807d33bde0 (&mm->mmap_lock){++++}-{4:4}, at: lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
ffff88807d33bde0 (&mm->mmap_lock){++++}-{4:4}, at: lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264

but task is already holding lock:
ffff8880338c6948 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (vm_lock){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __vma_enter_locked+0x182/0x380 mm/mmap_lock.c:63
       __vma_start_write+0x1e/0x120 mm/mmap_lock.c:87
       vma_start_write include/linux/mmap_lock.h:267 [inline]
       mprotect_fixup+0x571/0x9b0 mm/mprotect.c:670
       setup_arg_pages+0x53a/0xaa0 fs/exec.c:670
       load_elf_binary+0xb9f/0x2730 fs/binfmt_elf.c:1013
       search_binary_handler fs/exec.c:1670 [inline]
       exec_binprm fs/exec.c:1702 [inline]
       bprm_execve+0x999/0x1450 fs/exec.c:1754
       kernel_execve+0x8f0/0x9f0 fs/exec.c:1920
       try_to_run_init_process+0x13/0x60 init/main.c:1397
       kernel_init+0xad/0x1d0 init/main.c:1525
       ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1562
       mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
       lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
       lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
       get_next_vma fs/proc/task_mmu.c:182 [inline]
       query_vma_find_by_addr fs/proc/task_mmu.c:512 [inline]
       query_matching_vma+0x319/0x5c0 fs/proc/task_mmu.c:544
       do_procmap_query fs/proc/task_mmu.c:629 [inline]
       procfs_procmap_ioctl+0x3f9/0xd50 fs/proc/task_mmu.c:747
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:598 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(vm_lock);
                               lock(&mm->mmap_lock);
                               lock(vm_lock);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz.2.103/6308:
 #0: ffff8880338c6948 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220

stack backtrace:
CPU: 0 UID: 0 PID: 6308 Comm: syz.2.103 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1562
 mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
 lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
 lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
 get_next_vma fs/proc/task_mmu.c:182 [inline]
 query_vma_find_by_addr fs/proc/task_mmu.c:512 [inline]
 query_matching_vma+0x319/0x5c0 fs/proc/task_mmu.c:544
 do_procmap_query fs/proc/task_mmu.c:629 [inline]
 procfs_procmap_ioctl+0x3f9/0xd50 fs/proc/task_mmu.c:747
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa51ab8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa51b99b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa51adb5fa0 RCX: 00007fa51ab8e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
RBP: 00007fa51ac10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa51adb5fa0 R15: 00007ffdecbd3a88
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

