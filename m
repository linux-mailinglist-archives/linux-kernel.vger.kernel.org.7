Return-Path: <linux-kernel+bounces-840888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E76BB5A94
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 950524E7772
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B618E20;
	Fri,  3 Oct 2025 00:16:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A92B9A7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450565; cv=none; b=sJNhOJRfQu42fyl2TCWzYZkEp3iiMguNKPcd0EsP3a/NWU/eoXIWvhl1WoIB7nMnc96L/2uvk3wQqyJZ9kZfWHB5M0m9domfgslARUixxlyLf5rhcaQJzy7pomiEAzVRoTu9BN3nqJYQlUeScWkaH1E7O1imddVKb0WkH1ILb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450565; c=relaxed/simple;
	bh=iEjTTZRI8/N/kAptNp8eNqAfFPLIwFHHuBevYx3EnNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VPjRsFlkLjS1xr8cXxoRWb6+JaELVhV/CGCEKiPxCL5HIU3Wbr4LW3lxfuMWuvUgQ8RSTjQ9w+seSc7Buj+ci8icq7VW3SVOqHEO1XV6wZbVCAsiJ5jQdAiHL+CMfhQAGLlCnFdNPxw9Wmceyb3yG2pol3uIRyCI2Os4semsWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42eaf43998bso1621615ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450562; x=1760055362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QndRoQcHkaTeXE8tT0BN2pI5hwjWyrxyxw5q5DxLrg=;
        b=Z3InlTAUMDCmV7Jr70p/YZSG8FMaLfjm+ucaZSSloITCFNiVQ758xDYN1QuBkIZQw8
         m90cQyBNrDinsZsVvqYvjSB5GvdbgoC/1BbPqYkbJs6w+Hzu424p1Yov8+fOMikcWx16
         UuvoheGpdEJ0UCLJr6KKrbxR9ta/D7oR99GGTcMFC9rzGhYmsLXdRUXvSxg0/yBIQAHN
         mBqyFfPe4ljynXi29yEXY7Tgq4DiFs8Bd7mQaR531X0XplxW2vBt6ZjN3HOn2vpgqXlJ
         0x2b7aZ2+1HKZNPKDFrzs4jAB9TZdXfxFofV4K+U/3NYZGhUK3JD7f3YfAl3vzW3JC9+
         52dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/PRnjEH6DgQFdIwBpJnSSXxPMvLPTa6ipFmcTcKQBMYyANz7kpWBdYBNx2Bc3+cVwB2ibHvbYFMsAotA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH73RajJx5hMaCYoBwBAgtnECWxqn34Ly4SGjlgJw4eXndmXa2
	F/aeSLOpR50t1H7hwSGJUUstD0WFnuCCmyHpYa7tNAGXnkEFycKxBeXY++tpquOQumDzFJoXjz7
	IcTaWYM0KNWt4ilkUfBZAH/2Yz2j8i2I86x9l8Frpvz6d9BVGO5P4qtYYGCc=
X-Google-Smtp-Source: AGHT+IFFPTZfwYUZtsIbvMFC9AiOZMf7ElS7dNc7kLJKDU2avUmgk2ErCYg36SZF0xrojCXXrWbodRVCLs6W/8yf3gkmGvfpAKY0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-42e7ad81922mr12280675ab.27.1759450562510; Thu, 02 Oct 2025
 17:16:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:16:02 -0700
In-Reply-To: <20251002235337.2398242-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df15c2.050a0220.2c17c1.0009.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ext4_search_dir

==================================================================
BUG: KASAN: slab-use-after-free in ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
Read of size 1 at addr ffff8880431675a2 by task syz.0.23/5968

CPU: 0 UID: 0 PID: 5968 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
 ext4_find_inline_entry+0x492/0x5f0 fs/ext4/inline.c:1621
 __ext4_find_entry+0x2fd/0x1f20 fs/ext4/namei.c:1542
 ext4_lookup_entry fs/ext4/namei.c:1703 [inline]
 ext4_lookup+0x13d/0x6c0 fs/ext4/namei.c:1771
 lookup_open fs/namei.c:3774 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x10fe/0x3830 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_creat fs/open.c:1528 [inline]
 __se_sys_creat fs/open.c:1522 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1522
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd45f8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd46dca038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fbd461e6180 RCX: 00007fbd45f8eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000100
RBP: 00007fbd46011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbd461e6218 R14: 00007fbd461e6180 R15: 00007ffcda6a16e8
 </TASK>

Allocated by task 5956:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:333 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:359
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4944 [inline]
 slab_alloc_node mm/slub.c:5243 [inline]
 kmem_cache_alloc_noprof+0x37b/0x720 mm/slub.c:5250
 alloc_empty_file+0x55/0x1d0 fs/file_table.c:237
 path_openat+0x107/0x3830 fs/namei.c:4120
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2512 [inline]
 slab_free_after_rcu_debug+0x12c/0x2a0 mm/slub.c:6622
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 slab_free_hook mm/slub.c:2473 [inline]
 slab_free mm/slub.c:6564 [inline]
 kmem_cache_free+0x4ac/0x6b0 mm/slub.c:6674
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 task_work_add+0xb1/0x420 kernel/task_work.c:65
 __fput_deferred+0x154/0x390 fs/file_table.c:529
 remove_vma+0xdf/0x130 mm/vma.c:466
 exit_mmap+0x537/0xb40 mm/mmap.c:1305
 __mmput+0x118/0x430 kernel/fork.c:1130
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:949
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888043167540
 which belongs to the cache filp of size 360
The buggy address is located 98 bytes inside of
 freed 360-byte region [ffff888043167540, ffff8880431676a8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43167
memcg:ffff888055e55d81
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801b2caa00 ffffea000106a200 dead000000000004
raw: 0000000000000000 0000000000090009 00000000f5000000 ffff888055e55d81
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5911, tgid 5911 (rm), ts 147988563881, free_ts 147968362581
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3028 [inline]
 allocate_slab+0x96/0x360 mm/slub.c:3201
 new_slab mm/slub.c:3255 [inline]
 ___slab_alloc+0xe75/0x1920 mm/slub.c:4625
 __slab_alloc+0x65/0x100 mm/slub.c:4744
 __slab_alloc_node mm/slub.c:4820 [inline]
 slab_alloc_node mm/slub.c:5231 [inline]
 kmem_cache_alloc_noprof+0x40d/0x720 mm/slub.c:5250
 alloc_empty_file+0x55/0x1d0 fs/file_table.c:237
 path_openat+0x107/0x3830 fs/namei.c:4120
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 pagetable_free include/linux/mm.h:2898 [inline]
 pagetable_dtor_free include/linux/mm.h:2996 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888043167480: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff888043167500: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888043167580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888043167600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043167680: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162265cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bc5f6d89013f5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d4a85b980000


