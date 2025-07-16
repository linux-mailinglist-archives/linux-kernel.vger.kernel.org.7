Return-Path: <linux-kernel+bounces-734049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F3B07C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A17D4A7E39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA49288532;
	Wed, 16 Jul 2025 17:55:39 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FA28850F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688538; cv=none; b=kuRRsuHPXPuMtytjx0yOskBH/tDghVtmfT+SZSFFmZfvd8qrzhJ4R+e2jyvB558TDmmu8Xa9Bdjeu++FfBdiS+RRt7URibswTVgIi+ZJSEZKr6yWMwzyFL4v5OabHnd0CLPqTk9asTckKbzX4UsV4ZsUr61Y3GhO0NgUX2unGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688538; c=relaxed/simple;
	bh=zxb+lP8Jro90/2cVStKsesMFvvQDSOMT6wdu1gqqffQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eyTguoqX7F1WXCCc34P6trLZ3iXBp7lGBxhlaU8iy573jXRsqKfRIfcAKO0w4JyD9c7H9y1rvKvMFBDinpEG60KnseffVMJ+//Z7evnUpCh3wj+nCM741dtcuSmqzdO2nriNIMY14NY5fhHRFvQGhpTeA1n2HMet1mtSeLNlWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-869e9667f58so17366539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752688536; x=1753293336;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMUDBWWPF2h1/3l5ftewK8cyL1mZeJp0T2KQcGOsj3M=;
        b=N5jFIwqTrXO7vQvjzwr+ZsR5xjcz9u0MBELWF/lwm2wie3qm9S4C60fgG5dhS6x4JW
         hXI/grwBXIr3tjrb3SY9BBCxJ0wtC5jV+AiopFhV/RRCBDIkxWi1zYaTX3dfZQAThcwi
         ka8R2ZT7ymJVzbFY39Yb1g8FSpnbIFyXuCAEGxRpIY2JqkXZb1QPmm/Xa0PwjvcOguLB
         VyXOUk7hXJbe31eKL2DNjeZD8gXJw6F5O92BSSe+dawrNaQBGpp1SFF9QfeGv5O4tSNO
         /nbOE3oSJv7D/p40WkS/G6BpJ8gyOmtecBxH+04JL99PxGhBu7/LHjAOAYLfKoAOayFP
         VTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9mrWuSYBiWm9B/JSUJHO204ly/MIP8XpAok1W6EQdZ9Ewz9Re4p0wQIniib+VusQsQxZyjCdxqZVI8nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nuEoTCN8CxCLbzmbpCCJ3KfQQ2fCW1VBV/FsNNowFHFUQ6BC
	wC/4TMSImm4/f4pUkUbRYqyRips26W0wGZSD8MJ3nom8Xcw1hCDiUZA1KyMo2V9Te2Kz7tYUB0h
	qQHDhoJWbfjsf2kiGqc7GEzLov0S8TxEl8dcxkmTLwa5vO6l7EaogS/CowQg=
X-Google-Smtp-Source: AGHT+IHuKJLw5wxetXXjfLia+nEOPNgdqnceoINgISSPQ4qCaiz+n/Daw+fD9QEkR5XZ//ISmGOicz/y3YrAFTfGp6/gFDVKnPTe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3887:b0:875:b493:a1d0 with SMTP id
 ca18e2360f4ac-879c282c2d8mr262050539f.3.1752688535710; Wed, 16 Jul 2025
 10:55:35 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:55:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot (2)
From: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a7d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ma_dead_node lib/maple_tree.c:575 [inline]
BUG: KASAN: slab-use-after-free in mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
BUG: KASAN: slab-use-after-free in mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
Read of size 8 at addr ffff8880755dc600 by task syz.0.656/6830

CPU: 1 UID: 0 PID: 6830 Comm: syz.0.656 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 ma_dead_node lib/maple_tree.c:575 [inline]
 mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
 mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
 mas_find+0xb0e/0xd30 lib/maple_tree.c:6062
 vma_find include/linux/mm.h:855 [inline]
 remap_move mm/mremap.c:1819 [inline]
 do_mremap mm/mremap.c:1904 [inline]
 __do_sys_mremap mm/mremap.c:1968 [inline]
 __se_sys_mremap+0xaff/0xef0 mm/mremap.c:1936
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4fecf8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93ea4718 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007f4fed1b5fa0 RCX: 00007f4fecf8e929
RDX: 0000000000600002 RSI: 0000000000600002 RDI: 0000200000000000
RBP: 00007f4fed010b39 R08: 0000200000a00000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4fed1b5fa0 R14: 00007f4fed1b5fa0 R15: 0000000000000005
 </TASK>

Allocated by task 6830:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 mt_alloc_one lib/maple_tree.c:176 [inline]
 mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
 mas_node_count_gfp lib/maple_tree.c:1337 [inline]
 mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
 vma_iter_prealloc mm/vma.h:463 [inline]
 __split_vma+0x2fa/0xa00 mm/vma.c:528
 vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
 __mmap_prepare mm/vma.c:2361 [inline]
 __mmap_region mm/vma.c:2653 [inline]
 mmap_region+0x724/0x20c0 mm/vma.c:2741
 do_mmap+0xc45/0x10d0 mm/mmap.c:561
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 rcu_do_batch kernel/rcu/tree.c:2584 [inline]
 rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2840
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3102 [inline]
 call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3222
 mas_wr_node_store lib/maple_tree.c:3893 [inline]
 mas_wr_store_entry+0x1f1b/0x25b0 lib/maple_tree.c:4104
 mas_store_prealloc+0xb00/0xf60 lib/maple_tree.c:5510
 vma_iter_store_new mm/vma.h:509 [inline]
 vma_complete+0x224/0xae0 mm/vma.c:354
 __split_vma+0x8a6/0xa00 mm/vma.c:568
 vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
 do_vmi_align_munmap+0x25d/0x420 mm/vma.c:1527
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
 do_munmap+0xe1/0x140 mm/mmap.c:1071
 mremap_to+0x304/0x7b0 mm/mremap.c:1367
 remap_move mm/mremap.c:1861 [inline]
 do_mremap mm/mremap.c:1904 [inline]
 __do_sys_mremap mm/mremap.c:1968 [inline]
 __se_sys_mremap+0xa0b/0xef0 mm/mremap.c:1936
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880755dc600
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes inside of
 freed 256-byte region [ffff8880755dc600, ffff8880755dc700)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x755dc
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0001d57701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6828, tgid 6828 (cmp), ts 120765032919, free_ts 112542256570
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
 mt_alloc_one lib/maple_tree.c:176 [inline]
 mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
 mas_node_count_gfp lib/maple_tree.c:1337 [inline]
 mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
 vma_iter_prealloc mm/vma.h:463 [inline]
 commit_merge+0x1fd/0x700 mm/vma.c:753
 vma_expand+0x40c/0x7e0 mm/vma.c:1158
 vma_merge_new_range+0x6a3/0x860 mm/vma.c:1095
 __mmap_region mm/vma.c:2666 [inline]
 mmap_region+0xd46/0x20c0 mm/vma.c:2741
 do_mmap+0xc45/0x10d0 mm/mmap.c:561
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
page last free pid 5955 tgid 5955 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __slab_free+0x303/0x3c0 mm/slub.c:4591
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2914 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880755dc500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880755dc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880755dc600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880755dc680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880755dc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

