Return-Path: <linux-kernel+bounces-865820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9FBFE1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20D83A6D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281D2F5A3B;
	Wed, 22 Oct 2025 20:03:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0932F3C0F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163387; cv=none; b=QjEz63BhOimnLEVT67XcUAGyr0z21NIE+Uu+wGkU5CbGNpGeOf2H09gtc+kFziTXjTRtAieEvVQzcLG3ISWh6PBrnPWRG2Mv6HlGYAwP0bDUo7AO+YoDYB0J1zrCZGmhF+ox2J6hn34xCMRRnSvCpwFQQ4ejL/tw3tZmFecalXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163387; c=relaxed/simple;
	bh=ePS0SaalvllTQ+RIgU7nFOq8i/BA4GxG/vufsWvKZZs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bgAvOe2nFHqGaLAQFAcWPOuoEt9M1g0WS7Wm2u6aDybF9KLetb7sEgj6EznI9Mvdnz6Dllvd9UnJVdBR756VnHprnNctBWBxjQS2cK5dKsToEJly9E8NRw8BLOQTflkZe91sGc2AW3sfz/twU/pvpMZSZbOpZ3rlNtg9ojMMGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c1cbd1f2so1063925ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163384; x=1761768184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywl6c7RBf5UvPq6ZEVhHPixWOU9SPzPna9TDR+VscsI=;
        b=I4c+WKJBwm+ZoKwpwAN6tGc7ORI3Ne+P8o4ghsyemQyGaW4KRR2M+95rLW3rWd9fDy
         oK6i3c98aNmlvnCJeyM4knErMk171f6s1wfakeiVrQhtYcJFg75YrTNyoy0e1HLA7qL9
         mH8EYOgkPaJElYGt2HnH7INlCu9Zr6h7Bc2Kov5xzCuSPiRqDIL2GJyenhVSUEcbhxnW
         HWvW15axPTpeQuUS9c5PCCAzNVS5aFHIaMDY4dj5BuW5F06s/RuSfI+18iT1SNA9oLrw
         Z5VdKusnvSvfsHqhYpzpRKYdVOKLDIsxkKqkch7jqPe7tuiJtczdO8ljjzIWMuEm3zhB
         pPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkPY7pNWbB1iuPs23SbXWahU9nw+slHUQ4zZD63X+AeVTqHxbB2BSxyUdf+qDhkFsvC7YQLDWgsm7p+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5LQth9I68tKTi/eRCAEjSTN77Gd7SPzvqSC9sXJDyokUVzuQ
	9v+3Li5g6hBpHFtvEdVbtj1UpcWVu/flQyRAtkQLQY1UYp6cJsQqmsBCYI94qc7hLgcV2BP1Noh
	5gg5IOihPlwqzHvKEEQtRBY/G7EqCzuHydJgzAyUJQJ0TMOMJS+WbvIv8I9c=
X-Google-Smtp-Source: AGHT+IHhB7RWI6a9acltJBagV87zeAQ6m3o3UuusbiwjrdmyJy3PvaI8x1fxUOL5viV/orJyZUGeb2Pw1mqbbzW+8RwV46VUuYO4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc5:b0:430:b6a3:53ae with SMTP id
 e9e14a558f8ab-430c5307332mr328828435ab.30.1761163384380; Wed, 22 Oct 2025
 13:03:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:03:04 -0700
In-Reply-To: <20251022161344.c0bRW%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f93878.a70a0220.3bf6c6.0026.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ocfs2_fault

ocfs2: Mounting device (7,2) on (node local, slot 0) with writeback data mode.
==================================================================
BUG: KASAN: slab-use-after-free in ocfs2_fault+0xd3/0x400 fs/ocfs2/mmap.c:41
Read of size 8 at addr ffff88803cc37698 by task syz.2.19/6809

CPU: 0 UID: 0 PID: 6809 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ocfs2_fault+0xd3/0x400 fs/ocfs2/mmap.c:41
 __do_fault+0x138/0x390 mm/memory.c:5280
 do_read_fault mm/memory.c:5698 [inline]
 do_fault mm/memory.c:5832 [inline]
 do_pte_missing mm/memory.c:4361 [inline]
 handle_pte_fault mm/memory.c:6177 [inline]
 __handle_mm_fault mm/memory.c:6318 [inline]
 handle_mm_fault+0x23c6/0x3400 mm/memory.c:6487
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x1685/0x2860 mm/gup.c:1428
 populate_vma_page_range+0x29f/0x3a0 mm/gup.c:1860
 __mm_populate+0x24c/0x380 mm/gup.c:1963
 mm_populate include/linux/mm.h:3471 [inline]
 vm_mmap_pgoff+0x38a/0x4d0 mm/util.c:586
 ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90113deba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9010a4e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f9011625fa0 RCX: 00007f90113deba9
RDX: 00000000027ffff7 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007f9011461e19 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000004012011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9011626038 R14: 00007f9011625fa0 R15: 00007ffc58dfa518
 </TASK>

Allocated by task 6809:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4962 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 kmem_cache_alloc_noprof+0x181/0x6b0 mm/slub.c:5279
 vm_area_alloc+0x24/0x140 mm/vma_init.c:32
 __mmap_new_vma mm/vma.c:2461 [inline]
 __mmap_region mm/vma.c:2670 [inline]
 mmap_region+0xdd8/0x20f0 mm/vma.c:2740
 do_mmap+0xc23/0x10c0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a9/0x4d0 mm/util.c:581
 ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 20:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2530 [inline]
 slab_free_after_rcu_debug+0x130/0x4e0 mm/slub.c:6677
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core kernel/rcu/tree.c:2861 [inline]
 rcu_cpu_kthread+0xbf6/0x1b50 kernel/rcu/tree.c:2949
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:559
 slab_free_hook mm/slub.c:2491 [inline]
 slab_free mm/slub.c:6619 [inline]
 kmem_cache_free+0x71f/0x910 mm/slub.c:6729
 remove_vma mm/vma.c:468 [inline]
 vms_complete_munmap_vmas+0x626/0x8a0 mm/vma.c:1293
 do_vmi_align_munmap+0x372/0x450 mm/vma.c:1536
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
 __vm_munmap+0x207/0x380 mm/vma.c:3156
 __do_sys_munmap mm/mmap.c:1080 [inline]
 __se_sys_munmap mm/mmap.c:1077 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1077
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803cc37640
 which belongs to the cache vm_area_struct of size 256
The buggy address is located 88 bytes inside of
 freed 256-byte region [ffff88803cc37640, ffff88803cc37740)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88803cc37280 pfn:0x3cc37
memcg:ffff888026bd2301
flags: 0x80000000000200(workingset|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000200 ffff888019ebbb40 ffffea0000a12c50 ffffea0000ca25d0
raw: ffff88803cc37280 00000000000c000a 00000000f5000000 ffff888026bd2301
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6101, tgid 6101 (dhcpcd-run-hook), ts 130860016193, free_ts 130849245295
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3046 [inline]
 allocate_slab+0x96/0x3a0 mm/slub.c:3219
 new_slab mm/slub.c:3273 [inline]
 ___slab_alloc+0xb12/0x13f0 mm/slub.c:4643
 __kmem_cache_alloc_bulk+0x1c0/0x5a0 mm/slub.c:7383
 refill_sheaf mm/slub.c:2624 [inline]
 __pcs_replace_empty_main+0x301/0x530 mm/slub.c:5032
 alloc_from_pcs mm/slub.c:5130 [inline]
 slab_alloc_node mm/slub.c:5257 [inline]
 kmem_cache_alloc_noprof+0x45e/0x6b0 mm/slub.c:5279
 vm_area_dup+0x2b/0x670 mm/vma_init.c:123
 dup_mmap+0x90a/0x1ae0 mm/mmap.c:1780
 dup_mm kernel/fork.c:1489 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1541
 copy_process+0x1704/0x3ae0 kernel/fork.c:2181
 kernel_clone+0x224/0x7c0 kernel/fork.c:2609
 __do_sys_clone kernel/fork.c:2750 [inline]
 __se_sys_clone kernel/fork.c:2734 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
page last free pid 6106 tgid 6106 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2906
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x112/0x1d0 mm/mmu_gather.c:500
 exit_mmap+0x444/0xb40 mm/mmap.c:1293
 __mmput+0xcb/0x3d0 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803cc37580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803cc37600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88803cc37680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88803cc37700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88803cc37780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c5ce7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12524614580000


