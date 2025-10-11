Return-Path: <linux-kernel+bounces-849330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9ABCFD7B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6282A3BE2E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3E242D8A;
	Sat, 11 Oct 2025 23:13:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42A4A32
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760224415; cv=none; b=rkzaoWbK6avIs4spMlERgpvmM+Zna/ama7mzAeTE3MBzgNLXwMzQ6RCfDHIC73mrKi1cg22iR4CzJo+ydLW1GDEM0HH2eAFl+wrTiA/nLCM6OOvOOf4hLvaSMKCCMm95G296u25clMxuNHGkqkxRqZXljJuAvwpH3qRx+uzo7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760224415; c=relaxed/simple;
	bh=ZZIw75GVRCbdTSw7sfAHCGwTNHyhhowv4tjwq0myoJg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AJr/zp7lvT0WUiNNFzz4tcseGGds6tfELELiqUQqaMZHFC+mhMKJdGFDlt7svqZT+VlvKJcXjygZhfgo+xm/IKawUl8K+hhXiJ1h4KDtilM3yU/qA7ZUtDvu/CyRqD7O6kubXBiYS5+8KTxmvnd+5tmvsSuALp9zQ775D8oui80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e3c387a3bso6302039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760224412; x=1760829212;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hcb0IvGwyDF+zKQ4OnPf3nn2N6zm9YGR4E3ICRLLHWI=;
        b=sBY6r4sD3P4HIu8SMf8R4Jbzw+evGhw1Aj5uaS2qvG+fljIT204T21xP+xq8DGQO8g
         Ja6oytg5Qr3kUBerNW6xIaHp2wMRefeTNSJVJalWSL0xdbEbB4QKZXHnbR/gcAbPrgaQ
         x4Z32q2GmZTWi1cH06NASZ9WJ2Feut6oD5ta7zaUj+zQ8yKDrP0WSMibKehT3Hknvzcx
         GbE6WfLU0n0HQ4m8cW19bpvhSfpy2qHdXoNtDEMmYzYWRE7Q8GCWsztNJ2r9wjb7aJ08
         rU6NfD37SXAGivR1jp3Ud5AKBQ4lOae2Xz+MiGSydffFZUMNbWqpYsgAKr8IVkZ9+rd7
         ZWKA==
X-Forwarded-Encrypted: i=1; AJvYcCViPoWZjqH9K28KSasSsz5wBUVBI20S4y7HDuV3BNpv7bp+S4gy9Txd2PcCdodXbeSB/HRLayMGAHr4CbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQKI+6KglYCL/sTnoc8dTrVcnUjzIvPOy+mOQnDzG3O3UMfpo
	iVrCXaQevgXbgnTwlo2l8AzkQjNWypAh1nmlPmlu8aKlwaQtaYk8T25NHqqGjTuncbtwrxCKSr6
	466m9/TWhrVqCeRcmyqDuAKmS69/L3+q40hIyxZhZrMiamuasIbYId3IhB70=
X-Google-Smtp-Source: AGHT+IGlax2PylLVRjOgYwpJPGlmlM0UhfuvBdd6TdQAodSSpA3ieGaIBNVWNI0oihkGWTcco1DfyUJBIv3CQxw1bSpzX/rhxG8b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:42d:8695:12f with SMTP id
 e9e14a558f8ab-42f873fd81cmr182003055ab.23.1760224411799; Sat, 11 Oct 2025
 16:13:31 -0700 (PDT)
Date: Sat, 11 Oct 2025 16:13:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68eae49b.050a0220.ac43.0001.GAE@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_do_truncate_blocks
From: syzbot <syzbot+14b90e1156b9f6fc1266@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c746c3b51698 Merge tag 'for-6.18-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bb7334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1486b135ff0ff9b
dashboard link: https://syzkaller.appspot.com/bug?extid=14b90e1156b9f6fc1266
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c746c3b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8de5aa0a3f80/vmlinux-c746c3b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/797705bd8ae3/bzImage-c746c3b5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14b90e1156b9f6fc1266@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/73 is trying to acquire lock:
ffff888032fb03b0 (&sbi->cp_rwsem){.+.+}-{4:4}, at: f2fs_down_read fs/f2fs/f2fs.h:2278 [inline]
ffff888032fb03b0 (&sbi->cp_rwsem){.+.+}-{4:4}, at: f2fs_lock_op fs/f2fs/f2fs.h:2357 [inline]
ffff888032fb03b0 (&sbi->cp_rwsem){.+.+}-{4:4}, at: f2fs_do_truncate_blocks+0x21c/0x10c0 fs/f2fs/file.c:791

but task is already holding lock:
ffff888011840610 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x8d9/0x1b60 fs/f2fs/inode.c:890

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (sb_internal#2){.+.+}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_intwrite+0x4d/0x1c0 include/linux/fs.h:2099
       f2fs_evict_inode+0x8d9/0x1b60 fs/f2fs/inode.c:890
       evict+0x504/0x9c0 fs/inode.c:810
       f2fs_evict_inode+0x1dc/0x1b60 fs/f2fs/inode.c:853
       evict+0x504/0x9c0 fs/inode.c:810
       dispose_list fs/inode.c:852 [inline]
       prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
       super_cache_scan+0x39b/0x4b0 fs/super.c:224
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
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       prepare_alloc_pages+0x153/0x610 mm/page_alloc.c:4951
       __alloc_frozen_pages_noprof+0x123/0x370 mm/page_alloc.c:5172
       alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
       alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
       alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
       folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2517
       filemap_alloc_folio_noprof+0xdf/0x470 mm/filemap.c:1020
       do_read_cache_folio+0x2da/0x590 mm/filemap.c:3986
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       f2fs_commit_super+0x277/0x5e0 fs/f2fs/super.c:4479
       f2fs_record_errors fs/f2fs/super.c:4573 [inline]
       f2fs_handle_error+0x183/0x240 fs/f2fs/super.c:4585
       lookup_all_xattrs fs/f2fs/xattr.c:371 [inline]
       f2fs_getxattr+0x92f/0xe70 fs/f2fs/xattr.c:533
       __vfs_getxattr+0x3f1/0x430 fs/xattr.c:423
       cap_inode_need_killpriv+0x45/0x60 security/commoncap.c:331
       security_inode_need_killpriv+0x89/0x270 security/security.c:2707
       dentry_needs_remove_privs+0x8d/0x100 fs/inode.c:2213
       do_truncate+0xfe/0x220 fs/open.c:57
       handle_truncate fs/namei.c:3596 [inline]
       do_open fs/namei.c:3979 [inline]
       path_openat+0x306c/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sbi->sb_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       f2fs_down_write fs/f2fs/f2fs.h:2294 [inline]
       f2fs_record_errors fs/f2fs/super.c:4568 [inline]
       f2fs_handle_error+0xde/0x240 fs/f2fs/super.c:4585
       f2fs_check_nid_range fs/f2fs/node.c:44 [inline]
       __get_node_folio+0xff6/0x14f0 fs/f2fs/node.c:1548
       f2fs_get_node_folio fs/f2fs/node.c:1597 [inline]
       f2fs_get_dnode_of_data+0xab4/0x1cf0 fs/f2fs/node.c:879
       __replace_atomic_write_block+0x152/0x14a0 fs/f2fs/segment.c:234
       __f2fs_commit_atomic_write fs/f2fs/segment.c:355 [inline]
       f2fs_commit_atomic_write+0x93a/0x1930 fs/f2fs/segment.c:412
       f2fs_ioc_commit_atomic_write fs/f2fs/file.c:2380 [inline]
       __f2fs_ioctl+0x3f31/0xb5b0 fs/f2fs/file.c:4624
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->cp_rwsem){.+.+}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       f2fs_down_read fs/f2fs/f2fs.h:2278 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2357 [inline]
       f2fs_do_truncate_blocks+0x21c/0x10c0 fs/f2fs/file.c:791
       f2fs_truncate_blocks+0x10a/0x300 fs/f2fs/file.c:867
       f2fs_truncate+0x489/0x7c0 fs/f2fs/file.c:925
       f2fs_evict_inode+0x9f2/0x1b60 fs/f2fs/inode.c:897
       evict+0x504/0x9c0 fs/inode.c:810
       f2fs_evict_inode+0x1dc/0x1b60 fs/f2fs/inode.c:853
       evict+0x504/0x9c0 fs/inode.c:810
       dispose_list fs/inode.c:852 [inline]
       prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
       super_cache_scan+0x39b/0x4b0 fs/super.c:224
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
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &sbi->cp_rwsem --> fs_reclaim --> sb_internal#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal#2);
                               lock(fs_reclaim);
                               lock(sb_internal#2);
  rlock(&sbi->cp_rwsem);

 *** DEADLOCK ***

3 locks held by kswapd0/73:
 #0: ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
 #0: ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389
 #1: ffff8880118400e0 (&type->s_umount_key#50){.+.+}-{4:4}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880118400e0 (&type->s_umount_key#50){.+.+}-{4:4}, at: super_cache_scan+0x91/0x4b0 fs/super.c:197
 #2: ffff888011840610 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x8d9/0x1b60 fs/f2fs/inode.c:890

stack backtrace:
CPU: 0 UID: 0 PID: 73 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
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
 down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
 f2fs_down_read fs/f2fs/f2fs.h:2278 [inline]
 f2fs_lock_op fs/f2fs/f2fs.h:2357 [inline]
 f2fs_do_truncate_blocks+0x21c/0x10c0 fs/f2fs/file.c:791
 f2fs_truncate_blocks+0x10a/0x300 fs/f2fs/file.c:867
 f2fs_truncate+0x489/0x7c0 fs/f2fs/file.c:925
 f2fs_evict_inode+0x9f2/0x1b60 fs/f2fs/inode.c:897
 evict+0x504/0x9c0 fs/inode.c:810
 f2fs_evict_inode+0x1dc/0x1b60 fs/f2fs/inode.c:853
 evict+0x504/0x9c0 fs/inode.c:810
 dispose_list fs/inode.c:852 [inline]
 prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
 super_cache_scan+0x39b/0x4b0 fs/super.c:224
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
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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

