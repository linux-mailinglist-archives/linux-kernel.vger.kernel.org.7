Return-Path: <linux-kernel+bounces-757359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FEFB1C138
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB11166C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAC219A67;
	Wed,  6 Aug 2025 07:22:34 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4550218E96
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464953; cv=none; b=ZgsDbPmzgWOy92Ur8vka8Z01pMiTSU9u7QAzLlrlEC6B46+b8Ge1z652RHmVmpGRq6ruxLqQkQF1nDcEAq9mlHn6SHzm4ZvUlYMijpJmMMi6lX+/i+WMRaKG0IOSkuNAB6TKHl64zQW3KoZoY0Ax+SUMWpO4rNxECd1+Fz3jK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464953; c=relaxed/simple;
	bh=8EwCBWq6TMu88xLB2xo9mtQHf9bifwStyCNQQucpPb0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UEWfErrFPO1GM6mQg4AghNUt5AzQMMUrTKA5ziEpqsfDpGF7x9AKb+vUnG4Y0hI4GG3HA/1CKkMnO8SVvADktfrz9AObZg9ARHaCVKfUJFYukzrZQ1wfikn7KhgeKkKo0q8GFdNDMkcxYxPD5KOVGjH8jJdDtL27QopowRqPcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-881814e7585so604992339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464951; x=1755069751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6+Yg9qPp7j+/sF3OFX8I25r14vNmBi74wSMgr6ETKc=;
        b=nAeTMgGypj7+08EDejh7e41itqerm8iUud4M0/3iwImxL7ZGPV7nIVqUZGjOM0N7T1
         poVol/Xkqx0kMLysrp3wv3iqtAbxTnPMVabYf89YD59KVFUfhRMC2I0VJieE8W5FZJzB
         dUNQ/gzWDRQjzJOMrGKc4Ptlcu6bYqu55zs5SPzWZcRtF3Ej5LVlWGiFrnkacuugajHi
         m8RraDfG3WsjRKyUbtz+iPFf8igKuppFM06LsMcoW9Aj+7PsRF49sDABZY+TIiR/cGJ2
         98Y1LgRV0Fg9R9g97/tZbYRMJNG5hr2KNNbsAijFh14cge1iVBDzcgf+CR7RwaAV9SxC
         oP8A==
X-Forwarded-Encrypted: i=1; AJvYcCVEQv5ev5M5rycIqtpCRak49p7q4xzVLiu0/wcqH9EaudOVmFsQZKSPi78zn7y+N2AZ1RfYSHPkiNAFxzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UF8VmxmV9ZJdt0owwtGU3aSkFPwLS6oaGZyi7/X3TwgBAXv6
	1d/Jsgd0wjoZditkxJ3qdO/DorAPTs47OKy9NsQnSYH7vJcHDluOpFVT7dHPGE4l5f40JR+kXRy
	3S/XXRSVW3Rg9mcOfHcWewIKbEeddDak445v5NV5WoKPfzxdzaKqupsn9OaY=
X-Google-Smtp-Source: AGHT+IGYYOxPoW216V6PpajYImRA+JVVeiy47i4otVAQvcHunUtPhO8n0fzZTR/fYZTlYzeqVMLnC6/JdmK4RfL2pu0BK+E3VwT1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1508:b0:87c:1a21:4d17 with SMTP id
 ca18e2360f4ac-8819f2dc2a6mr293248939f.1.1754464950788; Wed, 06 Aug 2025
 00:22:30 -0700 (PDT)
Date: Wed, 06 Aug 2025 00:22:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689302b6.a70a0220.7865.0001.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_add_one
From: syzbot <syzbot+f50d605480fdec503770@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0905809b38bd Merge tag 'parisc-for-6.17-rc1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0d834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=f50d605480fdec503770
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6a9516ee098/disk-0905809b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/504f0d60e0d0/vmlinux-0905809b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd8bac1abc9e/bzImage-0905809b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f50d605480fdec503770@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-10910-g0905809b38bd #0 Tainted: G        W          
------------------------------------------------------
syz.4.82/6450 is trying to acquire lock:
ffff88801988c238 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791

but task is already holding lock:
ffff88805753eea8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x41b/0xca0 fs/btrfs/transaction.c:296

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       join_transaction+0x1a4/0xca0 fs/btrfs/transaction.c:321
       start_transaction+0x6b6/0x1620 fs/btrfs/transaction.c:705
       btrfs_ioctl_subvol_setflags+0x461/0x820 fs/btrfs/ioctl.c:1419
       btrfs_ioctl+0x93d/0xd00 fs/btrfs/ioctl.c:5240
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:598 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (btrfs_trans_num_writers){++++}-{0:0}:
       reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
       percpu_up_read include/linux/percpu-rwsem.h:112 [inline]
       __sb_end_write include/linux/fs.h:1793 [inline]
       sb_end_intwrite+0x26/0x1c0 include/linux/fs.h:1910
       __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1076
       btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6230
       inode_update_time fs/inode.c:2075 [inline]
       touch_atime+0x2f6/0x6d0 fs/inode.c:2148
       file_accessed include/linux/fs.h:2663 [inline]
       btrfs_file_mmap_prepare+0xde/0x150 fs/btrfs/file.c:2050
       vfs_mmap_prepare include/linux/fs.h:2294 [inline]
       call_mmap_prepare mm/vma.c:2585 [inline]
       __mmap_region mm/vma.c:2653 [inline]
       mmap_region+0xb49/0x20a0 mm/vma.c:2739
       do_mmap+0xc23/0x10c0 mm/mmap.c:558
       vm_mmap_pgoff+0x2a9/0x4d0 mm/util.c:580
       ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:604
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read_killable+0x9d/0x220 kernel/locking/rwsem.c:1545
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:432
       get_mmap_lock_carefully mm/mmap_lock.c:290 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:341
       do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1359
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       filldir64+0x2c7/0x690 fs/readdir.c:-1
       dir_emit include/linux/fs.h:3958 [inline]
       kernfs_fop_readdir+0x537/0x870 fs/kernfs/dir.c:1910
       iterate_dir+0x3a5/0x580 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:410 [inline]
       __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1575
       kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1093
       sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x5a5/0xb50 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_add+0x155/0x220 lib/kobject.c:426
       btrfs_sysfs_add_block_group_type+0x244/0x6b0 fs/btrfs/sysfs.c:1904
       btrfs_create_pending_block_groups+0xb8f/0x1780 fs/btrfs/block-group.c:2811
       __btrfs_end_transaction+0x140/0x640 fs/btrfs/transaction.c:1071
       btrfs_inc_block_group_ro+0x641/0x6f0 fs/btrfs/block-group.c:3085
       btrfs_relocate_block_group+0x29d/0xba0 fs/btrfs/relocation.c:3931
       btrfs_relocate_chunk+0x12f/0x5d0 fs/btrfs/volumes.c:3446
       __btrfs_balance+0x186f/0x23f0 fs/btrfs/volumes.c:4222
       btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4599
       btrfs_ioctl_balance+0x3d6/0x610 fs/btrfs/ioctl.c:3577
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:598 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &root->kernfs_rwsem --> btrfs_trans_num_writers --> btrfs_trans_num_extwriters

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs_trans_num_extwriters);
                               lock(btrfs_trans_num_writers);
                               lock(btrfs_trans_num_extwriters);
  lock(&root->kernfs_rwsem);

 *** DEADLOCK ***

5 locks held by syz.4.82/6450:
 #0: ffff888038e56488 (sb_writers#22){.+.+}-{0:0}, at: mnt_want_write_file+0x63/0x210 fs/namespace.c:601
 #1: ffff88805753e9e0 (&fs_info->reclaim_bgs_lock){+.+.}-{4:4}, at: __btrfs_balance+0x3fd/0x23f0 fs/btrfs/volumes.c:4127
 #2: ffff888038e56778 (sb_internal#6){.+.+}-{0:0}, at: btrfs_inc_block_group_ro+0x171/0x6f0 fs/btrfs/block-group.c:3000
 #3: ffff88805753ee80 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x41b/0xca0 fs/btrfs/transaction.c:296
 #4: ffff88805753eea8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x41b/0xca0 fs/btrfs/transaction.c:296

stack backtrace:
CPU: 0 UID: 0 PID: 6450 Comm: syz.4.82 Tainted: G        W           6.16.0-syzkaller-10910-g0905809b38bd #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1575
 kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
 kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1093
 sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x5a5/0xb50 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x155/0x220 lib/kobject.c:426
 btrfs_sysfs_add_block_group_type+0x244/0x6b0 fs/btrfs/sysfs.c:1904
 btrfs_create_pending_block_groups+0xb8f/0x1780 fs/btrfs/block-group.c:2811
 __btrfs_end_transaction+0x140/0x640 fs/btrfs/transaction.c:1071
 btrfs_inc_block_group_ro+0x641/0x6f0 fs/btrfs/block-group.c:3085
 btrfs_relocate_block_group+0x29d/0xba0 fs/btrfs/relocation.c:3931
 btrfs_relocate_chunk+0x12f/0x5d0 fs/btrfs/volumes.c:3446
 __btrfs_balance+0x186f/0x23f0 fs/btrfs/volumes.c:4222
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4599
 btrfs_ioctl_balance+0x3d6/0x610 fs/btrfs/ioctl.c:3577
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f80efdbeb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f80edc26038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f80effe5fa0 RCX: 00007f80efdbeb69
RDX: 0000200000000780 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f80efe41df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f80effe5fa0 R15: 00007fff616668e8
 </TASK>
BTRFS info (device loop4): relocating block group 1048576 flags system
BTRFS info (device loop4): balance: ended with status: 0


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

