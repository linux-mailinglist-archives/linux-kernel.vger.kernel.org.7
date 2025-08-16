Return-Path: <linux-kernel+bounces-771659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9772B28A23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC2C7BAA38
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF919F130;
	Sat, 16 Aug 2025 03:07:37 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AE1519B4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313656; cv=none; b=uL5CwyFvSzgR67ofKXNVjMduwj2iWv4H8GjxA1TJ4Isr1+DlofRWVbGfqH5roTNxiblfrlZFTRKyttw+BDNIgO3hSE8Dll/Hh+G1b0nmK1JnqjGwb3BLP04UR6+nD/O4CVELdQWw2dxGkR6VaG7MwSyYXagtUTNkHo/Rj9HDxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313656; c=relaxed/simple;
	bh=pRVFIV3TJ23nyiDRrtjxtLK9GH2Fvg8SKVHheIUhTSE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i/YrAgmnIuj1CGp0W0XqYhBX1FnyLZOD6MrokD4n82n1ATwnbR/XwJd6it6t4AGHHdvwkumy2TgzmfF4KciWbK0BJvNzIgw6NXA1Bic4371/3cnbJqzqEn8PmB6OY2QpUxRv+w3VroDPyTP3Arj4tdRrbrBITKKIqx71hvWesdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e57003d5f3so68315175ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755313654; x=1755918454;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kw8F5Lzqp6COSqt4H6pn9waIodi7atpwNgik3Fo2NQI=;
        b=aHdLotbbVh1HbSoq0x2Z81+dtBP76g8Uqk+UnkDzpxTRXMCybZEfqHyenZDaBG8yLR
         uWO42JS0HZHT1NQsZkt8qvVbYYuNND67NCF8l48die4I2AuMf/CjNLYoSoALgABZNC5h
         /AoOdCLCpPA3ZLY00V9KP3tXmz3LoNcz3ad5wJlS2rgPGTRH5jz8nheVLZ2N6TwI39Nd
         imJBxDxieSAl2XLy8ysSmou/7inZbkiY2fXqgnbz8lWpnOtQDzIXKqHxsvrqGwSn/y1W
         zru5W/BBW4Zz/6XZvHhaPB7ArezEbfKWY9atgPajSso+XQIFKWDlEK2iyMZtaViw+yS0
         erDA==
X-Forwarded-Encrypted: i=1; AJvYcCXquDrvnCk2l2P2Awex8bNlMw/cwP2uHVd24Y3PCEUM4mV1Xx+o7yqVN4rBvg602l/7e9wQEzRKK9KobX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEEYwcCSK08kZdyhipDbwq9bvCU+cJeyDsQe1bt0Vv1zOcXAj
	3M8pJroWs5Big4VD57EbZxD3b5MIMd0bYFo9BsA7lFfIv6FDHdhdgUu5Nw9eBv4/I3NTRaXzIvK
	XidGpgyP996CAyGAL/FD3FuVirBPpteTaRd2n/o2EZjEFafL3Go2mN/KgW0U=
X-Google-Smtp-Source: AGHT+IELHELCACuSMkAg+/pbcECBh6w0FeDIvzCihrg/KTP+X0M6Mipk713ay9G+x3YicfP5e/sL4nR0H7/afhAKAt3iAvixxBny
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:3e5:4715:ebdc with SMTP id
 e9e14a558f8ab-3e57e8244damr79813405ab.8.1755313654082; Fri, 15 Aug 2025
 20:07:34 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:07:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ff5f6.050a0220.e29e5.0030.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in mremap
From: syzbot <syzbot+4e221abf50259362f4f4@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a66af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
dashboard link: https://syzkaller.appspot.com/bug?extid=4e221abf50259362f4f4
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fb3c34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173c2dbc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68e3ffeee4c1/disk-931e46dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3cc40de4a0c3/vmlinux-931e46dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aed3e4f6a518/bzImage-931e46dc.xz

The issue was bisected to:

commit d50dabff4d1f2c815b2faf184f5d6db40596e2cc
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Sun Aug 3 11:11:22 2025 +0000

    mm/mremap: catch invalid multi VMA moves earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fadda2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15fadda2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11fadda2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e221abf50259362f4f4@syzkaller.appspotmail.com
Fixes: d50dabff4d1f ("mm/mremap: catch invalid multi VMA moves earlier")

==================================================================
BUG: KASAN: slab-use-after-free in vma_multi_allowed mm/mremap.c:1623 [inline]
BUG: KASAN: slab-use-after-free in remap_move mm/mremap.c:1884 [inline]
BUG: KASAN: slab-use-after-free in do_mremap mm/mremap.c:1923 [inline]
BUG: KASAN: slab-use-after-free in __do_sys_mremap mm/mremap.c:1987 [inline]
BUG: KASAN: slab-use-after-free in __se_sys_mremap+0xb33/0x1150 mm/mremap.c:1955
Read of size 8 at addr ffff888074738558 by task syz.0.59/6077

CPU: 1 UID: 0 PID: 6077 Comm: syz.0.59 Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 vma_multi_allowed mm/mremap.c:1623 [inline]
 remap_move mm/mremap.c:1884 [inline]
 do_mremap mm/mremap.c:1923 [inline]
 __do_sys_mremap mm/mremap.c:1987 [inline]
 __se_sys_mremap+0xb33/0x1150 mm/mremap.c:1955
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7fd678ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff51cbeae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007f7fd69b5fa0 RCX: 00007f7fd678ebe9
RDX: 0000000000002000 RSI: 0000000000002000 RDI: 0000200000041000
RBP: 00007f7fd6811e19 R08: 00002000004c3000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7fd69b5fa0 R14: 00007f7fd69b5fa0 R15: 0000000000000005
 </TASK>

Allocated by task 5972:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:339 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:365
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 vm_area_dup+0x2b/0x680 mm/vma_init.c:122
 dup_mmap+0x90c/0x1ac0 mm/mmap.c:1780
 dup_mm kernel/fork.c:1485 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1537
 copy_process+0x1706/0x3c00 kernel/fork.c:2175
 kernel_clone+0x21e/0x840 kernel/fork.c:2605
 __do_sys_clone kernel/fork.c:2748 [inline]
 __se_sys_clone kernel/fork.c:2732 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2732
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 2999:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free_after_rcu_debug+0x129/0x2a0 mm/slub.c:4730
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x318/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:559
 slab_free_hook mm/slub.c:2378 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x2f6/0x400 mm/slub.c:4782
 remove_vma mm/vma.c:468 [inline]
 vms_complete_munmap_vmas+0x626/0x8a0 mm/vma.c:1293
 do_vmi_align_munmap+0x358/0x420 mm/vma.c:1536
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
 do_munmap+0xe1/0x140 mm/mmap.c:1068
 mremap_to+0x2df/0x7a0 mm/mremap.c:1372
 remap_move mm/mremap.c:1879 [inline]
 do_mremap mm/mremap.c:1923 [inline]
 __do_sys_mremap mm/mremap.c:1987 [inline]
 __se_sys_mremap+0xadf/0x1150 mm/mremap.c:1955
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888074738500
 which belongs to the cache vm_area_struct of size 256
The buggy address is located 88 bytes inside of
 freed 256-byte region [ffff888074738500, ffff888074738600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x74738
memcg:ffff888030d7f981
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801bed5b40 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000c000c 00000000f5000000 ffff888030d7f981
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5248, tgid 5248 (udevd), ts 24347982328, free_ts 24338159697
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
 vm_area_dup+0x2b/0x680 mm/vma_init.c:122
 dup_mmap+0x90c/0x1ac0 mm/mmap.c:1780
 dup_mm kernel/fork.c:1485 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1537
 copy_process+0x1706/0x3c00 kernel/fork.c:2175
 kernel_clone+0x21e/0x840 kernel/fork.c:2605
 __do_sys_clone kernel/fork.c:2748 [inline]
 __se_sys_clone kernel/fork.c:2732 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2732
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 23 tgid 23 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 pagetable_free include/linux/mm.h:2917 [inline]
 pagetable_dtor_free include/linux/mm.h:3015 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888074738400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888074738480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888074738500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888074738580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888074738600: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

