Return-Path: <linux-kernel+bounces-844385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A31BC1C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748D719A2FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF52E0B6A;
	Tue,  7 Oct 2025 14:44:28 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA47165F16
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848268; cv=none; b=OKEESthgj1JLhQmjURP8ZvoqrnkAThmI3o2LMK51ABOC2+bfkK4tiwNkc2Bcb/i5osDfhdx+KL4cztCBlNJYRVAK2rThgkmVGFIlOaHb+QCQo5lTjFq8UVXXgS1LaVyHx/LUYjZ5Paa8CvUNwMQ/AN2BVYephDx5TwlBoIlw8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848268; c=relaxed/simple;
	bh=LwPpGxzScFRcg3XVdfbKtAr8o94TlL4hxVRRerjq+rY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jL6/xbMmLMO/6UZjWcDX1tH8pHEaqpK04UIEbaKFShnXs4dJAg/FnqKGEZIKvShLmDDGFZpm4TL+9ddJwz/Il3bdi6+p+JHJQjTxfIs5ryxba5SErtTcgkwzWblpWiIMwuqbKgpJ9xyw6A23W/zV/i42Wx3cDcJFFGRVn7R30FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-429278a11f7so69363445ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848265; x=1760453065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=852yue/k/+d3NKePkJBKXnuBdI9UsXbCNpDa9Jxdlc4=;
        b=oX4/Ft7TvM13pw0g/MYqGJ1bEludlUlVpo/sEh7wm1+5fWiPFLjecOy8WUkqcwTuyA
         CuLuYBnjmtzAu836OiZcsZvrobsHJ1lXNjuRcvQhgF/WCjgchoiGQoGew3cuRS36h3pq
         ZxNlj9aAhFiQGqEBIv5jAlegihR6e/8Oh1I+6ZOlAevW9LV3YDxJyVz7fZqvsPkiYZbz
         XTxI7Ehib9HHliNxVWiB+BX9f1H7Mn7Hqlhenpf0k5OLxC4xiRFc59SHKYgeXT7Z0vFa
         aI49D9cdafYihen7/yleLhChKiTWZ56nCisadtSiK5vbKFUh12fhEgVSUeaJ+YLoRv4i
         ifSA==
X-Forwarded-Encrypted: i=1; AJvYcCV23SPd7gKj14Z/3fjdByFYnBfwNCRLTUdfQVv/eajyjOjEp3SPZZr+3kzjfC9NIZWpl0Ssnqyeqj0kfLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//8sag8+9X4r7LrV9XJCmH5Mr5NaLzlijQvPdDn0NjcH8eW7n
	uQYTJgdPoTFpREGCRopSkDokpg8CuXgVCvPDIhCX2uMHO6s/yzlM7OPHWArm05osQHNwsOwZuuw
	dlHrsZbnj7GID3eyk3yn6tkYi4qKumMcgotJKZhlqF2DXZLUlmQIIZBrkeOM=
X-Google-Smtp-Source: AGHT+IG4Ep9AXRZ18LqmCL/aPbrN7b+54LhMymMi7C06PW4vINpObsgv1//J+2r+KYwx/ZYzEalvlnxBH3uH//QMskT34Ma5qPvO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c02:b0:424:6c8e:617f with SMTP id
 e9e14a558f8ab-42e7ad18b7bmr228241415ab.8.1759848265576; Tue, 07 Oct 2025
 07:44:25 -0700 (PDT)
Date: Tue, 07 Oct 2025 07:44:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e52749.a00a0220.298cc0.047b.GAE@google.com>
Subject: [syzbot] [bfs?] possible deadlock in bfs_evict_inode
From: syzbot <syzbot+a12845fa0e9f51f7a601@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccb4d203fe4 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11239ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0e74def2d38a839
dashboard link: https://syzkaller.appspot.com/bug?extid=a12845fa0e9f51f7a601
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2ccb4d20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/749f87aeac3d/vmlinux-2ccb4d20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c8888fbaabd/bzImage-2ccb4d20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a12845fa0e9f51f7a601@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/72 is trying to acquire lock:
ffff888042915ad8 (&info->bfs_lock){+.+.}-{4:4}, at: bfs_evict_inode+0x274/0x510 fs/bfs/inode.c:183

but task is already holding lock:
ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4897 [inline]
       slab_alloc_node mm/slub.c:5221 [inline]
       kmem_cache_alloc_lru_noprof+0x4a/0x6d0 mm/slub.c:5264
       bfs_alloc_inode+0x28/0x40 fs/bfs/inode.c:240
       alloc_inode+0x67/0x1b0 fs/inode.c:346
       iget_locked+0x106/0x580 fs/inode.c:1445
       bfs_iget+0x28/0xaa0 fs/bfs/inode.c:42
       bfs_lookup+0x150/0x1d0 fs/bfs/dir.c:141
       lookup_one_qstr_excl+0x12e/0x360 fs/namei.c:1705
       do_renameat2+0x3dd/0xa50 fs/namei.c:5317
       __do_sys_rename fs/namei.c:5411 [inline]
       __se_sys_rename fs/namei.c:5409 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5409
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&info->bfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       bfs_evict_inode+0x274/0x510 fs/bfs/inode.c:183
       evict+0x501/0x9c0 fs/inode.c:810
       __dentry_kill+0x209/0x660 fs/dcache.c:669
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1114
       shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141
       prune_dcache_sb+0x10e/0x180 fs/dcache.c:1222
       super_cache_scan+0x369/0x4b0 fs/super.c:222
       do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
       shrink_slab_memcg mm/shrinker.c:550 [inline]
       shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
       shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
       shrink_many mm/vmscan.c:5016 [inline]
       lru_gen_shrink_node mm/vmscan.c:5094 [inline]
       shrink_node+0x315d/0x3780 mm/vmscan.c:6081
       kswapd_shrink_node mm/vmscan.c:6941 [inline]
       balance_pgdat mm/vmscan.c:7124 [inline]
       kswapd+0x147c/0x2800 mm/vmscan.c:7389
       kthread+0x70e/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&info->bfs_lock);
                               lock(fs_reclaim);
  lock(&info->bfs_lock);

 *** DEADLOCK ***

2 locks held by kswapd0/72:
 #0: ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
 #0: ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389
 #1: ffff888010fbc0e0 (&type->s_umount_key#51){++++}-{4:4}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff888010fbc0e0 (&type->s_umount_key#51){++++}-{4:4}, at: super_cache_scan+0x91/0x4b0 fs/super.c:197

stack backtrace:
CPU: 0 UID: 0 PID: 72 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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
 __mutex_lock_common kernel/locking/mutex.c:598 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
 bfs_evict_inode+0x274/0x510 fs/bfs/inode.c:183
 evict+0x501/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1114
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141
 prune_dcache_sb+0x10e/0x180 fs/dcache.c:1222
 super_cache_scan+0x369/0x4b0 fs/super.c:222
 do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x315d/0x3780 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat mm/vmscan.c:7124 [inline]
 kswapd+0x147c/0x2800 mm/vmscan.c:7389
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

