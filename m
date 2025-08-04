Return-Path: <linux-kernel+bounces-755541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A460B1A833
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827B016CA7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFC528A72A;
	Mon,  4 Aug 2025 16:51:32 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2D221FA0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326291; cv=none; b=DGV+BmkquQww8v2MrARKIVRylFaNn98fg6i2/PbeD5XJ6JKkB7bGZxq4tesASVHw1jlJDD/S6Ot9i9AL49bx97L3h1YXt4k5On7WmoOVnxw3sBGreRT4+Zeen7UrdA8dafanhy2IhNslk/7eSYfaDVTMeTaqHoMvPONsLeI0q3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326291; c=relaxed/simple;
	bh=Bn33jBXxpWfWRllfCJra5+TUT89vsBbx9wXN3S8f6+c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dX2W3PVDsrxbXTrlpwEzcQIsOii2uGY5mEC9g/wJa2pls9ic4SAZn45t1EhFt3Y5DIyrLjG2mJAxhgdqpA3QtoPezMACBDyttNcf4ZCj9zWSsywcA+nLm1QbAZVeR6nJPjQB2ovZeJHdacyIZvYdPYDHsGx3CYGFRZzr8DQLtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88177d99827so152788939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326289; x=1754931089;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+SWqhnRSwH3R1CzBxQyfEv4bNSSoW82skBpvyoxCSc=;
        b=bF5EPMntqJ0RiRHFfpVp+sDCXTDL5UgVAQwEQWvx12hN1z81NfJBL3lfIIleiixYzQ
         yqx0CJaeLfIwdmFhyL1kOhW+97QiQBRuLt+qzTNEq9szApNtS3UALeI24XxthxZHClKh
         66eiLYeEear2gB93VtLwanfnfe9QFPpcf7YRgBxDLSfBIoV9tETwvWZ5vRrGJO2EXTsj
         jS3R4DtrMxioFNye1VV+HMIChwxyPEzi2NdBqhmi0Kdjv73MIpKMIGDIv7OGKygwkXzX
         LWO4AbDklQsQLEAPeZTOZqhDlYCeM6s7yP6MehST2HkEzJt+BKzzUmYdrCqQ9ZFoXwpq
         SdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfXuD0+VZpTVTmcw/zj6VH9i5EL7f1UY55znZFJ8yCGCLwIw3mpiVFG06pLBQjxv7/zMT48I/Oqk/38Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+iB8EOpAmon04mzDBFTIzLmQZg0dM1L3azTbOcM81krEGfTr
	RoGZ9HRA7PXf/l+M5nNk6qcHKDE4/9BF+COv030pEqqotmgd0+kv+ujDHLhZNDe8KaXvDfmu1Hf
	Zn1YIdXvUWti4Hio6xc/tDOVEZVfkb1f01y1+yl6YhODoWfeEGtyeMyKl9CQ=
X-Google-Smtp-Source: AGHT+IH04Bq8MVGpwIUoBtycOOr7vPMxx24HVA0oKBXHAheqzKXH3rbQlrqpS7k9as0bBK2jRst+SxKgq4Sy8a4NND7+3pAMIAuf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26ca:b0:87c:1d65:3aeb with SMTP id
 ca18e2360f4ac-88168318805mr2137993739f.2.1754326288731; Mon, 04 Aug 2025
 09:51:28 -0700 (PDT)
Date: Mon, 04 Aug 2025 09:51:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890e510.050a0220.1fc43d.000e.GAE@google.com>
Subject: [syzbot] [mm?] [gfs2?] KASAN: slab-use-after-free Read in lru_add (2)
From: syzbot <syzbot+8921d5debffa05b33b27@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baohua@kernel.org, bhe@redhat.com, 
	chrisl@kernel.org, gfs2@lists.linux.dev, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	shikemeng@huaweicloud.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5c5a10f0be96 Add linux-next specific files for 20250804
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ce82f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=8921d5debffa05b33b27
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e0c042580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce82f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb2134de7be8/disk-5c5a10f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe8a36605e0c/vmlinux-5c5a10f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12df22603d55/bzImage-5c5a10f0.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/9e49622389fe/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14ce82f0580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/c35702228966/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12e0c042580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8921d5debffa05b33b27@syzkaller.appspotmail.com

R10: 0000000000200001 R11: 0000000000000246 R12: 0000200000000400
R13: 00007ffd8687be00 R14: 00000000000125bb R15: 0000200000000180
 </TASK>
gfs2: fsid=norecovery.s: Error checking journal for spectator mount.
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:270 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable mm/internal.h:499 [inline]
BUG: KASAN: slab-use-after-free in lru_add+0x25f/0xd80 mm/swap.c:136
Read of size 8 at addr ffff88807e517898 by task syz-executor240/5932

CPU: 0 UID: 0 PID: 5932 Comm: syz-executor240 Not tainted 6.16.0-next-20250804-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:270 [inline]
 folio_evictable mm/internal.h:499 [inline]
 lru_add+0x25f/0xd80 mm/swap.c:136
 folio_batch_move_lru+0x21b/0x3a0 mm/swap.c:168
 lru_add_drain_cpu+0x119/0x880 mm/swap.c:647
 lru_add_drain+0x122/0x3e0 mm/swap.c:735
 __folio_batch_release+0x48/0x90 mm/swap.c:1054
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x49e/0x14b0 mm/shmem.c:1157
 shmem_truncate_range mm/shmem.c:1269 [inline]
 shmem_evict_inode+0x272/0xa70 mm/shmem.c:1397
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 ptrace_notify+0x281/0x2c0 kernel/signal.c:2520
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x1d0 kernel/entry/syscall-common.c:111
 syscall_exit_to_user_mode_work include/linux/entry-common.h:173 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2ad/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f575cc3f840
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d 41 d8 09 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffd8687bd78 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f575cc3f840
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007ffd8687be00 R09: 00007ffd8687be00
R10: 0000000000000000 R11: 0000000000000202 R12: 0000200000000400
R13: 00007ffd8687be00 R14: 00000000000125bb R15: 0000200000000180
 </TASK>

Allocated by task 5932:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 gfs2_glock_get+0x263/0xec0 fs/gfs2/glock.c:1182
 gfs2_inode_lookup+0x215/0xb10 fs/gfs2/inode.c:135
 gfs2_dir_search+0x168/0x220 fs/gfs2/dir.c:1665
 gfs2_lookupi+0x3d9/0x5a0 fs/gfs2/inode.c:340
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:574 [inline]
 init_journal+0x54a/0x2260 fs/gfs2/ops_fstype.c:716
 init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
 gfs2_fill_super+0x1923/0x20d0 fs/gfs2/ops_fstype.c:1253
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3123 [inline]
 call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3243
 __gfs2_glock_free+0xb44/0xc90 fs/gfs2/glock.c:172
 gfs2_glock_free+0x3c/0xa0 fs/gfs2/glock.c:178
 gfs2_glock_put_eventually fs/gfs2/super.c:1183 [inline]
 gfs2_evict_inode+0xae7/0x1000 fs/gfs2/super.c:1458
 evict+0x504/0x9c0 fs/inode.c:810
 gfs2_jindex_free+0x39c/0x440 fs/gfs2/super.c:79
 init_journal+0x8f1/0x2260 fs/gfs2/ops_fstype.c:833
 init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
 gfs2_fill_super+0x1923/0x20d0 fs/gfs2/ops_fstype.c:1253
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xcd2/0xfb0 kernel/workqueue.c:2339
 queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2559
 queue_delayed_work include/linux/workqueue.h:684 [inline]
 gfs2_glock_queue_work fs/gfs2/glock.c:250 [inline]
 do_xmote+0xce0/0x1260 fs/gfs2/glock.c:838
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1095
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807e5174d0
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 968 bytes inside of
 freed 1224-byte region [ffff88807e5174d0, ffff88807e517998)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e514
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888140b3b500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888140b3b500 dead000000000122 0000000000000000
head: 0000000000000000 00000000800c000c 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001f94501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5927, tgid 5927 (syz-executor240), ts 116383259321, free_ts 115796234787
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
 gfs2_glock_get+0x263/0xec0 fs/gfs2/glock.c:1182
 gfs2_inode_lookup+0x215/0xb10 fs/gfs2/inode.c:135
 gfs2_dir_search+0x168/0x220 fs/gfs2/dir.c:1665
 gfs2_lookupi+0x3d9/0x5a0 fs/gfs2/inode.c:340
 gfs2_lookup_meta+0xa7/0x170 fs/gfs2/inode.c:280
 init_statfs fs/gfs2/ops_fstype.c:617 [inline]
 init_journal+0x10cd/0x2260 fs/gfs2/ops_fstype.c:783
 init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
 gfs2_fill_super+0x1923/0x20d0 fs/gfs2/ops_fstype.c:1253
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
page last free pid 5868 tgid 5868 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __slab_free+0x303/0x3c0 mm/slub.c:4591
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2918 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807e517780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e517800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807e517880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88807e517900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e517980: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

