Return-Path: <linux-kernel+bounces-850103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9EBD1E07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529493B46AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA52EA48B;
	Mon, 13 Oct 2025 07:51:33 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A22E7F14
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341892; cv=none; b=Vx0RMOfEo10Wkl9y1a3zEJ5jEP0ktoHWBGhI/5ZjnI78qsdjh5ryEXJA+1tqGpE6OnHL1KvorYzWxzc77zHvnQOFcUsCdBQrNt1WCdtAWYjRoDhEOIXRdchrVtWU7yniiJ8+69yu3lFU7kg/QXaYCiYtTu4DgUeYqu4eo+JJW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341892; c=relaxed/simple;
	bh=X9ceQgcSnelRUPty+/4AzhoxtRG8+59uauMOTKOYnfI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m/m/jCLFnL2TEpIUzIFOkES6lgqppnG71kaKnUZAsJuaFWxqoxmr4kaNuxGgkOsZeEgGSLM9XegT+yB7/XWTeKcboXk0jaxRM6/0OcXtxZhFQF8Tegoi+5Q6mUkU1EOVSNPiU8oDHN4KuPZVV72K/ajKhZ+5wAylWyTZP9Mzy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93e37fa67deso154124139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341890; x=1760946690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRT37qVlM5legiXX59icR0BLG47YnKdx9cridyyZbFA=;
        b=WkuKbXVnBQyZeqd78YISDCBPysK/kLT7bSTXBUfbwr80NniofD8J9AXBXxumMbUOuz
         Y9/XEXfkNSBxjXInU1MLdJFr8GPh74xcpMTklGGQ4ggigknl1FXBli31sYHWni1AIFNo
         e8r0ztT6+rochiJoNUfLLWfKOR7rL4S5jEvbUk9hw6oophYegZj4uzRGUMPuuyS5PooX
         0E4kQGQW7PNEJVk+0CxHgXr70n6oUIL0Fyr/0Y9ZWKnMbXgIDi4BcL+MVv/VKJfC+cpo
         cpErZH8+oWNjO27kdSEB3QhLmnof0jcuznxvm0XChegM6+Yqj03N7bAP+YRouOLI6F75
         V9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ3KYK+RXWMGFSbscRHjdCaylBn0bGw58XJxykZy98pOqms6F3LjPeT/CAqpMT/u8lKZX0ESC6A+N5V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSrpQxY8rMoJ9GG1+TXGLfobcFT3rIjCUpW9q7tCgTJWKC9ic
	fORSGL+eNRH8G/Do5UvGWTEXPFuwSTTuLWKiQ4iurkyW4NPklAJYpjPgyHgZO0ohMqOR8r4bE9/
	4K7ZN2vq/TWIzJChFzPymiEfaALY9kwXGf3W/Fw4gFOTt0xHtG5H+ObVtIMI=
X-Google-Smtp-Source: AGHT+IHEeSX0Ane9Za6Sc+5eBeRTADw4/dDhcYK08MerVwy+fHAcezaTgOBi9ngecWMAlVQIFdvGq8br2TCfbTlMTQUwdjQ1ayvq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b08:b0:93b:b799:460b with SMTP id
 ca18e2360f4ac-93bd1831b33mr2409935839f.3.1760341889912; Mon, 13 Oct 2025
 00:51:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 00:51:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecaf81.050a0220.91a22.01e1.GAE@google.com>
Subject: [syzbot] [gfs2?] possible deadlock in gfs2_trans_begin (2)
From: syzbot <syzbot+68c035f26b00b18d07d1@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cd5a0afbdf80 Merge tag 'mailbox-v6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d3852f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b213914b883d014
dashboard link: https://syzkaller.appspot.com/bug?extid=68c035f26b00b18d07d1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cd5a0afb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67f9eda6483e/vmlinux-cd5a0afb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5368c61451e5/bzImage-cd5a0afb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68c035f26b00b18d07d1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/78 is trying to acquire lock:
ffff8880332bc610 (sb_internal#2){.+.+}-{0:0}, at: gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118

but task is already holding lock:
ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
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
       __filemap_get_folio+0x3f2/0xaf0 mm/filemap.c:2012
       filemap_grab_folio include/linux/pagemap.h:838 [inline]
       gfs2_unstuff_dinode+0xe8/0x1320 fs/gfs2/bmap.c:162
       gfs2_iomap_begin_write fs/gfs2/bmap.c:1059 [inline]
       gfs2_iomap_begin+0x9a7/0x11c0 fs/gfs2/bmap.c:1133
       iomap_iter+0x534/0xde0 fs/iomap/iter.c:108
       iomap_file_buffered_write+0x207/0x9b0 fs/iomap/buffered-io.c:1070
       gfs2_file_buffered_write+0x4ed/0x880 fs/gfs2/file.c:1061
       gfs2_file_write_iter+0x94e/0x1100 fs/gfs2/file.c:1166
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c6/0xb30 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ip->i_rw_mutex){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       gfs2_unstuff_dinode+0x9d/0x1320 fs/gfs2/bmap.c:161
       gfs2_iomap_begin_write fs/gfs2/bmap.c:1059 [inline]
       gfs2_iomap_begin+0x9a7/0x11c0 fs/gfs2/bmap.c:1133
       iomap_iter+0x534/0xde0 fs/iomap/iter.c:108
       iomap_file_buffered_write+0x207/0x9b0 fs/iomap/buffered-io.c:1070
       gfs2_file_buffered_write+0x4ed/0x880 fs/gfs2/file.c:1061
       gfs2_file_write_iter+0x94e/0x1100 fs/gfs2/file.c:1166
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c6/0xb30 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sdp->sd_log_flush_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       __gfs2_trans_begin+0x515/0x890 fs/gfs2/trans.c:87
       gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
       alloc_dinode+0x1e7/0x550 fs/gfs2/inode.c:418
       gfs2_create_inode+0xbbc/0x1560 fs/gfs2/inode.c:807
       gfs2_atomic_open+0x116/0x200 fs/gfs2/inode.c:1387
       atomic_open fs/namei.c:3656 [inline]
       lookup_open fs/namei.c:3767 [inline]
       open_last_lookups fs/namei.c:3895 [inline]
       path_openat+0xf63/0x3830 fs/namei.c:4131
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_intwrite include/linux/fs.h:2099 [inline]
       __gfs2_trans_begin+0x42a/0x890 fs/gfs2/trans.c:76
       gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
       gfs2_dirty_inode+0x3cb/0x600 fs/gfs2/super.c:508
       __mark_inode_dirty+0x2ec/0xe10 fs/fs-writeback.c:2566
       mark_inode_dirty_sync include/linux/fs.h:2619 [inline]
       iput+0x381/0xc50 fs/inode.c:1947
       __dentry_kill+0x209/0x660 fs/dcache.c:669
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1114
       shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141
       prune_dcache_sb+0x10e/0x180 fs/dcache.c:1222
       super_cache_scan+0x369/0x4b0 fs/super.c:222
       do_shrink_slab+0x6ec/0x1110 mm/shrinker.c:437
       shrink_slab_memcg mm/shrinker.c:550 [inline]
       shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
       shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
       shrink_many mm/vmscan.c:5016 [inline]
       lru_gen_shrink_node mm/vmscan.c:5094 [inline]
       shrink_node+0x315d/0x3780 mm/vmscan.c:6081
       kswapd_shrink_node mm/vmscan.c:6941 [inline]
       balance_pgdat mm/vmscan.c:7124 [inline]
       kswapd+0x147c/0x2800 mm/vmscan.c:7389
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &ip->i_rw_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ip->i_rw_mutex);
                               lock(fs_reclaim);
  rlock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by kswapd0/78:
 #0: ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
 #0: ffffffff8e247a40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389
 #1: ffff8880332bc0e0 (&type->s_umount_key#50){.+.+}-{4:4}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880332bc0e0 (&type->s_umount_key#50){.+.+}-{4:4}, at: super_cache_scan+0x91/0x4b0 fs/super.c:197

stack backtrace:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
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
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1916 [inline]
 sb_start_intwrite include/linux/fs.h:2099 [inline]
 __gfs2_trans_begin+0x42a/0x890 fs/gfs2/trans.c:76
 gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
 gfs2_dirty_inode+0x3cb/0x600 fs/gfs2/super.c:508
 __mark_inode_dirty+0x2ec/0xe10 fs/fs-writeback.c:2566
 mark_inode_dirty_sync include/linux/fs.h:2619 [inline]
 iput+0x381/0xc50 fs/inode.c:1947
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1114
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141
 prune_dcache_sb+0x10e/0x180 fs/dcache.c:1222
 super_cache_scan+0x369/0x4b0 fs/super.c:222
 do_shrink_slab+0x6ec/0x1110 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x315d/0x3780 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat mm/vmscan.c:7124 [inline]
 kswapd+0x147c/0x2800 mm/vmscan.c:7389
 kthread+0x711/0x8a0 kernel/kthread.c:463
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

