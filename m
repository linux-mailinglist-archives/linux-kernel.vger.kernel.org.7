Return-Path: <linux-kernel+bounces-865800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B6BFE131
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2CCC4E5630
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A833509F;
	Wed, 22 Oct 2025 19:44:10 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AA2FD699
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162249; cv=none; b=qoCwGOe2QHs1rustWtL6vkalAaMuS6FS8u7D+WlyDkBxRNn9cUhtSG6s+WX2CTJ8PlUnCwAn5z1dSdj8TJzPRcnZ0fvEkgw8ZOyxYqBYsejEPZ0GWYLIOvwkTP3mpQj6oRBcASHngdRwWMNPghcRS0GmkP6XsI1AtkJ+EUZtsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162249; c=relaxed/simple;
	bh=H4SutNHS2nQIB25Pw/03TH2gY2xAk4hcf/bAlHKCLkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jeE1RMuW6pskrhhHS0YySZFs5BXatCuhqQA03blJqYI0r/1f7GuMf3HTaHXpByhlf2WmCTgiU/mfBYjUZdzF/HDQdc4GzG4aJ7bYfijf0NRUypnxce5dd8s/PRiNUJY8pZzf5zboEmg+RLvTO39a5Bwso+UihdP34dk6Xtl/SYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-925332ba890so1956870939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162247; x=1761767047;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcUvUogpi5ZKETT+aftgFAbN3epGEWlzZfQOyYhNSRU=;
        b=sj03XC6bmLX7ddR8gZrgdJJj7GTC0Vq0D+3lWK+zpHTyyVgI3UQ9+1V1vt9A6yxEGN
         oAuuleFfAwxrPKQy6vjKwTvbo4PtOWfwCWPDL4Pqs47+9W+536K7WGTYXafUN53HLXbW
         U6YJYoK5RvxDLfjCocMxIJxYIjlyGW1Qibv8AiLbYTe6glmvsqtArOgVcAEUvvxWn8VK
         uCsh9ogzqlvznIBFybAGqtdIMljYl3+z1yg2vnWGRGKBZTVgrZ4WSZCtZhFdRadz6xTL
         X3Mk34gCK5v9fvfP8INsjjy5vS5eNiwHMwuQforuQEOqfw+DryeSfRwsLquDTNZFRJAJ
         yB8g==
X-Forwarded-Encrypted: i=1; AJvYcCWNZcOWpB11R7UHEJfbFesqSi+x73bdnAml4Jss1hjLkW4MgzqsUsAsqPogt6dlMPkUGQvI16Lzn2EZjek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45Lde7iB8/YsYC3E/cKfHlEXIewwiTNK2q6F1fFmtKBiUVy3b
	A8dYSyh2/e0GVuqhGMSOnhx36eb0XJSClO5BNGrsLz/Wh0PLFASYMOJVQX01NOpCD/cNw5SrlcC
	OI0T3c4WfTQVxqHGyDJ8pGYzc0x5yB8Ggm1g0L/u9a1yS14X5x4/5a4rPuvA=
X-Google-Smtp-Source: AGHT+IFgjsubU0hCuRALzGFsESnO28C2mbQywPUd34LONZE6cK+ISUBZkx8Q553fi0lhN7TfR+4lCVuN8NpfMNB0X6jANIHAum/r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:471c:b0:431:d763:193b with SMTP id
 e9e14a558f8ab-431d7631a2cmr30660325ab.24.1761162247206; Wed, 22 Oct 2025
 12:44:07 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:44:07 -0700
In-Reply-To: <20251022150456.SU9Z4%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f93407.050a0220.346f24.0061.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ocfs2_fault

loop0: detected capacity change from 0 to 32768
ocfs2: Mounting device (7,0) on (node local, slot 0) with writeback data mode.
==================================================================
BUG: KASAN: slab-use-after-free in ocfs2_fault+0xd3/0x400 fs/ocfs2/mmap.c:41
Read of size 8 at addr ffff888031bb5698 by task syz.0.125/7346

CPU: 1 UID: 0 PID: 7346 Comm: syz.0.125 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
RIP: 0033:0x7f32fa7deba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32f9e46038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f32faa25fa0 RCX: 00007f32fa7deba9
RDX: 00000000027ffff7 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007f32fa861e19 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000004012011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f32faa26038 R14: 00007f32faa25fa0 R15: 00007ffdc02e8c68
 </TASK>

Allocated by task 7346:
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

The buggy address belongs to the object at ffff888031bb5640
 which belongs to the cache vm_area_struct of size 256
The buggy address is located 88 bytes inside of
 freed 256-byte region [ffff888031bb5640, ffff888031bb5740)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x31bb5
memcg:ffff88801f744601
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff888019ebbb40 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000000f5000000 ffff88801f744601
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6425, tgid 6425 (syz-executor), ts 226564199612, free_ts 226474808802
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
page last free pid 28 tgid 28 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2906
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core kernel/rcu/tree.c:2861 [inline]
 rcu_cpu_kthread+0xbf6/0x1b50 kernel/rcu/tree.c:2949
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888031bb5580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031bb5600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888031bb5680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888031bb5700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888031bb5780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=112b2d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d43734580000


