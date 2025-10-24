Return-Path: <linux-kernel+bounces-869017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABFC06B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B876B35C82F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE3231D74B;
	Fri, 24 Oct 2025 14:35:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933831AF0A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316504; cv=none; b=iHaj1Ub5fBkAmkO3YAF9QvekQWGZFW3Oe78P1u8w/kGJpGrIh59ATfRvyrrtXMvWhbmYlkz7QuHu/4kQcl/5sFaY7d3YW0x9yBTDTE6LyndyeEegNZotS9fLVSxRnnR1z0/Jq9PAMWfWmikstIzCOSr8N+4GkmS6acnV3sCeZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316504; c=relaxed/simple;
	bh=GDciDKtoJPc0ltif3fKkVL3czkB0Ba3j11e3y9caVzk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QhinKCSefAAmgwHehw1trT/eKtJ5d2PlOCgEGYmpjeefx0RbqMQs/r5+59ArtbnfTHl2p9P/whAhDSDs8gGGf5FtTdoqOotvwHa82kU7b+RFCM0ZjJVR/HHnA+AoFdrB8L57XFgPbrZi8h1W4wXvsM3aLlOacDxKausBs3iguWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d082fc3dso67737335ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316502; x=1761921302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPo9ycw284d7tqD/4hGucpjKq+yUndpcrtbyQrnh+6s=;
        b=KTiQajhIldnDOKM0loIn/VbwquszjRiieuel+l5gqAsXFVCGYrdbEcjDOvs65Ae/Sy
         DrEYMqMTwx9DPLaAXimb7QhHJr/aBIMyegVf1Jla1NeZTnBJm2PmLUkgepVeClgjJN4A
         wfQN8Hs26hkR88BXSkfNO7EUW55LXl77tbv4+hzh39GLyt6a0oMgdQFTamhRzkvc/1Sq
         zqrY5ROcOeMRZ3WSRQ/OBLUkXq7VkLP6G0o1Nlsxpu68r9iMS9sVJHkkwSr7UZsQCH28
         J0Sr91kUgeEByyjk+yxmlrH1rIjix0Ovz5rx0MIzBjZvxQTIkb6zPhx9+9Y6cKnzyYuh
         YDjA==
X-Forwarded-Encrypted: i=1; AJvYcCWnlyElC7dQ2g1w6CXxS+8eM1SHvukc04KoUTlSyUDAKxCiyOVaWZta4O5MJBRuc3Kohrf/Dea5UQIiaaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAT7HVjy6xaIr1tXQR1VF9rwYG5/ffP16AA3ZkdIqrVEDyFkPH
	eVS+UE1/nTj7iRyWFHEV9Y1IxupFxrrXFSr99O2uJzv3M6SPpZFVAe76oEh3lm92SDqGk2ijHxT
	7eSp64yne9gWKeIN3Tr7YEr7KAcwxzEBY8zhgWNNXcM0YM4aE6gs80Ef6D+0=
X-Google-Smtp-Source: AGHT+IFyFrw2RzKfAyXRJHySj9Omv6qwj9BsnwdQF7JAS2MZizsnkwEHkORqVTzWCXQxLvZClQxF3bMgtaqXpRVeHNpIPtA3CUSF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2508:b0:430:a65c:a833 with SMTP id
 e9e14a558f8ab-431ebf86680mr32560705ab.31.1761316502160; Fri, 24 Oct 2025
 07:35:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:35:02 -0700
In-Reply-To: <20251024071535.JI8ba%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb8e96.050a0220.346f24.00ff.GAE@google.com>
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
BUG: KASAN: slab-use-after-free in ocfs2_fault+0xd7/0x400 fs/ocfs2/mmap.c:41
Read of size 8 at addr ffff88802638e620 by task syz.2.337/9121

CPU: 0 UID: 0 PID: 9121 Comm: syz.2.337 Not tainted syzkaller #0
Hardware [  406.389655][ T9121] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x18a/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:481
 kasan_report+0x118/0x150 mm/kasan/report.c:594
 ocfs2_fault+0xd7/0x400 fs/ocfs2/mmap.c:41
 __do_fault+0x138/0x390 mm/memory.c:4881
 do_read_fault mm/memory.c:5301 [inline]
 do_fault mm/memory.c:5435 [inline]
 do_pte_missing mm/memory.c:3964 [inline]
 handle_pte_fault mm/memory.c:5770 [inline]
 __handle_mm_fault mm/memory.c:5913 [inline]
 handle_mm_fault+0x21f4/0x3270 mm/memory.c:6081
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0x1657/0x2a10 mm/gup.c:1497
 populate_vma_page_range+0x26c/0x340 mm/gup.c:1935
 __mm_populate+0x24d/0x380 mm/gup.c:2038
 mm_populate include/linux/mm.h:3432 [inline]
 vm_mmap_pgoff+0x2b0/0x3c0 mm/util.c:593
 ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:546
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf1ad9eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdf1a40e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fdf1afe5fa0 RCX: 00007fdf1ad9eba9
RDX: 00000000027ffff7 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007fdf1ae21e19 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000004012011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdf1afe6038 R14: 00007fdf1afe5fa0 R15: 00007ffe194a9b38
 </TASK>

Allocated by task 9121:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4135 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 kmem_cache_alloc_noprof+0x136/0x290 mm/slub.c:4191
 vm_area_alloc+0x24/0x1b0 kernel/fork.c:473
 __mmap_region mm/mmap.c:1440 [inline]
 mmap_region+0xc8f/0x1da0 mm/mmap.c:1619
 do_mmap+0xa88/0x10b0 mm/mmap.c:500
 vm_mmap_pgoff+0x1d0/0x3c0 mm/util.c:588
 ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:546
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 30:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4638 [inline]
 kmem_cache_free+0x1ab/0x530 mm/slub.c:4740
 rcu_do_batch kernel/rcu/tree.c:2575 [inline]
 rcu_core kernel/rcu/tree.c:2831 [inline]
 rcu_cpu_kthread+0xc0d/0x1b20 kernel/rcu/tree.c:2919
 smpboot_thread_fn+0x51a/0xa00 kernel/smpboot.c:164
 kthread+0x2c3/0x360 kernel/kthread.c:389
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:152
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3098 [inline]
 call_rcu+0x158/0x920 kernel/rcu/tree.c:3202
 remove_vma mm/vma.c:336 [inline]
 vms_complete_munmap_vmas+0x62b/0x8a0 mm/vma.c:1176
 do_vmi_align_munmap+0x395/0x460 mm/vma.c:1369
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1417
 __vm_munmap+0x19b/0x360 mm/mmap.c:1639
 __do_sys_munmap mm/mmap.c:1656 [inline]
 __se_sys_munmap mm/mmap.c:1653 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1653
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802638e5a0
 which belongs to the cache vm_area_struct of size 176
The buggy address is located 128 bytes inside of
 freed 176-byte region [ffff88802638e5a0, ffff88802638e650)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2638e
memcg:ffff888030a95001
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff888140421b40 ffffea0000c5ff80 dead000000000006
raw: 0000000000000000 0000000000110011 00000001f5000000 ffff888030a95001
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6751, tgid 6751 (dhcpcd-run-hook), ts 202156256238, free_ts 202150795162
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x246/0x2a0 mm/page_alloc.c:1554
 prep_new_page mm/page_alloc.c:1562 [inline]
 get_page_from_freelist+0x2005/0x20a0 mm/page_alloc.c:3507
 __alloc_pages_noprof+0x1e4/0x490 mm/page_alloc.c:4793
 alloc_pages_mpol_noprof+0xd3/0x270 mm/mempolicy.c:2269
 alloc_slab_page+0x5d/0x110 mm/slub.c:2450
 allocate_slab+0x5d/0x2c0 mm/slub.c:2620
 new_slab mm/slub.c:2674 [inline]
 ___slab_alloc+0x8d8/0xe10 mm/slub.c:3867
 __slab_alloc mm/slub.c:3958 [inline]
 __slab_alloc_node mm/slub.c:4011 [inline]
 slab_alloc_node mm/slub.c:4172 [inline]
 kmem_cache_alloc_noprof+0xd0/0x290 mm/slub.c:4191
 vm_area_dup+0x27/0x260 kernel/fork.c:488
 dup_mmap kernel/fork.c:695 [inline]
 dup_mm kernel/fork.c:1696 [inline]
 copy_mm+0xaea/0x1e50 kernel/fork.c:1748
 copy_process+0x16c9/0x3a70 kernel/fork.c:2398
 kernel_clone+0x22b/0x880 kernel/fork.c:2810
 __do_sys_clone kernel/fork.c:2953 [inline]
 __se_sys_clone kernel/fork.c:2937 [inline]
 __x64_sys_clone+0x18c/0x1f0 kernel/fork.c:2937
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6762 tgid 6762 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1123 [inline]
 free_unref_folios+0xc96/0x1500 mm/page_alloc.c:2735
 folios_put_refs+0x5f4/0x6f0 mm/swap.c:996
 free_pages_and_swap_cache+0x4c4/0x530 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:465
 exit_mmap+0x40e/0xae0 mm/mmap.c:1952
 __mmput+0xcb/0x360 kernel/fork.c:1354
 exit_mm+0x1db/0x2c0 kernel/exit.c:571
 do_exit+0x883/0x2630 kernel/exit.c:935
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1089
 __do_sys_exit_group kernel/exit.c:1100 [inline]
 __se_sys_exit_group kernel/exit.c:1098 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1098
 x64_sys_call+0x212b/0x2130 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802638e500: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88802638e580: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
>ffff88802638e600: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
                               ^
 ffff88802638e680: fc fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802638e700: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=13b363cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154eae7c580000


