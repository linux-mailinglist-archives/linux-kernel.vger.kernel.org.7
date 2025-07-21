Return-Path: <linux-kernel+bounces-738518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1054B0B98A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593183BA151
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3232CCC1;
	Mon, 21 Jul 2025 00:21:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED23C30
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057265; cv=none; b=ktNV6zfU5mUcP+l6QUgrlGkGocJcQC/cgizaFbu6JrhxhNVO9qKGaqQmdNmI3BvS8ND24OfOu+lCZXCvvCj/9CLIRzqDV0AzG0FDMG+WwsfTLy1JyezR4OVxYyTvwEiIdhmDOAF5dDEFkzrGESO3C+luLxIDapKeI0Mp/1cVCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057265; c=relaxed/simple;
	bh=AFlnBFMUXxsdlELzSUQJdk8bdzyRQTWDe27WZ8SUVbM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IvlUdny/uezniGUGJaZVT1zogCwNcYLizkrMftK3kq85B/FBy+190UbTlZoHMz+6fRd7Dpufb4D88jtYYCNVJfYlFoUNMuhAoq09llswuSmntB/zNp2NQ4qLWw9f1Ce8GBd7ZOuvYuRR+qfVEOID7P1+YmlHP1KgLJbH/PCehLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c1cc3c42aso366286139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057262; x=1753662062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylmwKQtIl0UjXX5QmwT+RkWCbcYoaOpF6Ul1ye5iKf8=;
        b=cmumEtJuHYzgmuZAHFiwnbRxoWrTAWxnEySyeHNVHg+yZUooouAMEDT2jWGqciPwBb
         4Oc9ISOkyg1wBns6Y/ElrOBdjq8cpInPFSpMjD6vZ5nEgp8DbiCpGaiPYkwbiWCukFYh
         BA10Mhz6guHbgTpJ192nssMkNFdCbPqU7Q9mravoqSrHnoHf4lmMDNIkmPT753MtR5Hj
         0cXNTamL19JrUrRSSCpI6GvZTRN+7kXUHSpU32pmKA+I4CzUMgeirKxw0+fjFs3LDERF
         hLlIB88cgCScuFh6TWHv8GLxcHMKr6Dp0Sksf8OHALK7brFWLQSYhELPnmVt7GClUQqH
         gTmA==
X-Forwarded-Encrypted: i=1; AJvYcCWKJPjsoFta6ymlW5hU33rkC0Hq3XZZAdTS8tfhXEI2eMWS5yh91UhYR2OYHiXWKxeI4gGoH+NvXUmMNfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysmAd0FiwziRsnhhikyCjhqbb+LrNuwKV19tkoahpluxkqXVMS
	7Cq7JP8kXbfhJmZJ3+lESDa84ZN8bA+FZUT/GAdfvQoFiF5eHbcyTUwjDznMFV+kcRFpoZI69En
	wt7lDfXIE8H04CS2Y5ye72Sat9fYQhPswUPh1RNhQbRNPxn1yqc0L+OaIsUw=
X-Google-Smtp-Source: AGHT+IHBFhBXmNWS2eykjVi54I9UX4os3u2ZuYZYHHWfaA+Y7QKGawGa+kchrxpSopX728/ZX3L0Y1wqA9tmCbQAzUD1Cw9qNdXY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2486:b0:3e2:8b05:c4ee with SMTP id
 e9e14a558f8ab-3e28b05c714mr175050285ab.8.1753057262539; Sun, 20 Jul 2025
 17:21:02 -0700 (PDT)
Date: Sun, 20 Jul 2025 17:21:02 -0700
In-Reply-To: <20250720233037.2567-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d87ee.a70a0220.693ce.00d9.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_iop_getattr
From: syzbot <syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in kernfs_iop_getattr

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc7-syzkaller-g89be9a83ccf1 #0 Not tainted
------------------------------------------------------
syz.0.16/6627 is trying to acquire lock:
ffff88801c6f4a20 (&root->kernfs_iattr_rwsem){++++}-{4:4}, at: kernfs_iop_getattr+0x9c/0xf0 fs/kernfs/inode.c:191

but task is already holding lock:
ffff888026446278 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x175/0x290 block/blk-mq.c:4396
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4443
       loop_add+0x49e/0xb70 drivers/block/loop.c:2012
       loop_init+0x164/0x270 drivers/block/loop.c:2247
       do_one_initcall+0x120/0x6e0 init/main.c:1274
       do_initcall_level init/main.c:1336 [inline]
       do_initcalls init/main.c:1352 [inline]
       do_basic_setup init/main.c:1371 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1584
       kernel_init+0x1c/0x2b0 init/main.c:1474
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4045 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4059
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4099 [inline]
       slab_alloc_node mm/slub.c:4177 [inline]
       kmem_cache_alloc_noprof+0x53/0x3b0 mm/slub.c:4204
       __kernfs_iattrs+0xbc/0x3f0 fs/kernfs/inode.c:37
       kernfs_iattrs fs/kernfs/inode.c:60 [inline]
       __kernfs_setattr+0x4d/0x3c0 fs/kernfs/inode.c:73
       kernfs_iop_setattr+0xda/0x120 fs/kernfs/inode.c:127
       notify_change+0x6a9/0x1230 fs/attr.c:552
       do_truncate+0x1d7/0x230 fs/open.c:68
       handle_truncate fs/namei.c:3517 [inline]
       do_open fs/namei.c:3900 [inline]
       path_openat+0x2678/0x2cb0 fs/namei.c:4055
       do_filp_open+0x20b/0x470 fs/namei.c:4082
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (iattr_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       __kernfs_iattrs+0x2b/0x3f0 fs/kernfs/inode.c:32
       kernfs_iattrs fs/kernfs/inode.c:60 [inline]
       __kernfs_setattr+0x4d/0x3c0 fs/kernfs/inode.c:73
       kernfs_iop_setattr+0xda/0x120 fs/kernfs/inode.c:127
       notify_change+0x6a9/0x1230 fs/attr.c:552
       do_truncate+0x1d7/0x230 fs/open.c:68
       handle_truncate fs/namei.c:3517 [inline]
       do_open fs/namei.c:3900 [inline]
       path_openat+0x2678/0x2cb0 fs/namei.c:4055
       do_filp_open+0x20b/0x470 fs/namei.c:4082
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_iattr_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       down_read+0x9b/0x480 kernel/locking/rwsem.c:1524
       kernfs_iop_getattr+0x9c/0xf0 fs/kernfs/inode.c:191
       vfs_getattr_nosec+0x2ac/0x430 fs/stat.c:213
       vfs_getattr+0x4a/0x60 fs/stat.c:262
       loop_query_min_dio_size.isra.0+0x117/0x250 drivers/block/loop.c:455
       loop_assign_backing_file drivers/block/loop.c:508 [inline]
       loop_change_fd drivers/block/loop.c:586 [inline]
       lo_ioctl+0x1d2e/0x2760 drivers/block/loop.c:1515
       blkdev_ioctl+0x277/0x6d0 block/ioctl.c:704
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &root->kernfs_iattr_rwsem --> fs_reclaim --> &q->q_usage_counter(io)#24

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#24);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#24);
  rlock(&root->kernfs_iattr_rwsem);

 *** DEADLOCK ***

3 locks held by syz.0.16/6627:
 #0: ffff88814277b400 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_global_lock_killable+0x30/0xb0 drivers/block/loop.c:118
 #1: ffff888026446278 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205
 #2: ffff8880264462b0 (&q->q_usage_counter(queue)#20){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205

stack backtrace:
CPU: 1 UID: 0 PID: 6627 Comm: syz.0.16 Not tainted 6.16.0-rc7-syzkaller-g89be9a83ccf1 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 down_read+0x9b/0x480 kernel/locking/rwsem.c:1524
 kernfs_iop_getattr+0x9c/0xf0 fs/kernfs/inode.c:191
 vfs_getattr_nosec+0x2ac/0x430 fs/stat.c:213
 vfs_getattr+0x4a/0x60 fs/stat.c:262
 loop_query_min_dio_size.isra.0+0x117/0x250 drivers/block/loop.c:455
 loop_assign_backing_file drivers/block/loop.c:508 [inline]
 loop_change_fd drivers/block/loop.c:586 [inline]
 lo_ioctl+0x1d2e/0x2760 drivers/block/loop.c:1515
 blkdev_ioctl+0x277/0x6d0 block/ioctl.c:704
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ba538e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9ba6276038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9ba55b6080 RCX: 00007f9ba538e9a9
RDX: 0000000000000004 RSI: 0000000000004c06 RDI: 0000000000000003
RBP: 00007f9ba5410d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f9ba55b6080 R15: 00007ffc5d44de88
 </TASK>


Tested on:

commit:         89be9a83 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145f638c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

