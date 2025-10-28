Return-Path: <linux-kernel+bounces-874849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BBC173C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A07188B212
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2498369988;
	Tue, 28 Oct 2025 22:52:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8628D8E8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691926; cv=none; b=CGaF9BZSyrAlTDxQezOmr2jzKrcyYQIMUCiORguNtRSuOKhZ7Js1RBg/Wfs03cPWqH+bkX/9WRT2yaHUSdN4apzWgTePVktzEtb3x+77ek5RkSJCQReqQyMN+bLwta1puHIHWRpNV1ce+cLdtL+E0Wqro0gZE7z1z+s5Xt6mTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691926; c=relaxed/simple;
	bh=0EiPr9qY33JGFLgUUszoVMVtW9DmFyfKaNTbap28uME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s/1KlogCG1C6bge8MQXnLqSntmcOM9WFZ6jAHifdcXdr9yMzxLpcyG5R+f6bSf/tsVPt9fkIdTfRrW0DogYosxPFvD94C6REO491A6sClAyNrFdd3zMTOzFFM6mt1qxMqf4VBAsC75L9Fn9yZ9HfMIBNNjDplPgJa44y+Gn1boU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430da49fcbbso84918355ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691923; x=1762296723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0B3IQXQ+Oc9uwRnSdvAw+JGE82qlD/S/GeirPI0xEU=;
        b=YvoH89BkJs1++9M0D6HXd1ihsDe4GD8cS2OmkNT/FUlhzHbMS7xRZmzI2MDPJuj2I2
         xbwAQ7YoD6Ysc2kPYEjzdcLoXHmvX3akc983IGk9vwa+ruGlowAo5490/8GBOaj44Il2
         PVZw8XpOdn1250y4/Tx0F0hY2WwblNCyKczLLh1W9g+1/5iCi2Qp78u6RL/0wUt5yQxH
         OFnuSYy6XsKwQh6u4SrADriVJRZncUahuw4wzb2Y6lteMi7qcb+omqSLxQIo0KPg5RGV
         AJQMRFEslIfwRS1NXKYjE3xwac4yFPzlwoL0bTRNxlPxUjCGZCheF99Aj9jDJuNQCwBM
         mURw==
X-Forwarded-Encrypted: i=1; AJvYcCUgMfAf5YolnQhPVOf5lSxb/i073DzyJEvcNMdtQr3mp33tKuQUkreqEa5+I2W1H4G5x8RZFlKLoNyDVRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmkKz5RwgZXUmlt+ltEO66Y3ClEVQbJAu2fRuF+HtAGg70CzV
	0QcLNfxYVqquQ8tDk9TbzPzaqnmRF8V1r9FkpSF0iG62ZmafI7l9r7ak11KKpep5pTjeXvK7FaX
	ohZjlkqhi3Nr2agnApfrE6/NBkMDP7iR3xaJnkSu9QO5UvVHWCFPHflFJtI8=
X-Google-Smtp-Source: AGHT+IHqzwx8AiyiWbF2tZSwvX0TDMjvrwfI+e58wcwzn3fj88BABb03pRKVVq6gJ4xJluTVDoP79HoQPn9F54kmwdshU9rMzYdF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3984:b0:430:b6a3:53ae with SMTP id
 e9e14a558f8ab-432f9074b3amr11931555ab.30.1761691923546; Tue, 28 Oct 2025
 15:52:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:52:03 -0700
In-Reply-To: <20251028182304.-64lK%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69014913.050a0220.32483.01df.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ocfs2_fault

==================================================================
BUG: KASAN: slab-use-after-free in ocfs2_fault+0xd7/0x400 fs/ocfs2/mmap.c:41
Read of size 8 at addr ffff888054c78440 by task syz.1.256/8713

CPU: 1 UID: 0 PID: 8713 Comm: syz.1.256 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
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
RIP: 0033:0x7fb45472eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb453d9e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fb454975fa0 RCX: 00007fb45472eba9
RDX: 00000000027ffff7 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007fb4547b1e19 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000004012011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb454976038 R14: 00007fb454975fa0 R15: 00007ffe6cca0598
 </TASK>

Allocated by task 8713:
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

The buggy address belongs to the object at ffff888054c783c0
 which belongs to the cache vm_area_struct of size 176
The buggy address is located 128 bytes inside of
 freed 176-byte region [ffff888054c783c0, ffff888054c78470)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x54c78
memcg:ffff888031e55b01
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff888140421b40 ffffea0000afe780 dead000000000004
raw: 0000000000000000 0000000000110011 00000001f5000000 ffff888031e55b01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7145, tgid 7145 (sed), ts 235039312136, free_ts 234962721176
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
 __split_vma+0x1be/0xab0 mm/vma.c:383
 split_vma mm/vma.c:466 [inline]
 vma_modify+0x1575/0x1980 mm/vma.c:1464
 vma_modify_flags+0x1f0/0x240 mm/vma.c:1482
 mprotect_fixup+0x3ff/0xa30 mm/mprotect.c:664
 do_mprotect_pkey+0x801/0xc30 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
page last free pid 7128 tgid 7127 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1123 [inline]
 free_unref_page+0x9e1/0xb80 mm/page_alloc.c:2688
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x112/0x1d0 mm/mmu_gather.c:468
 vms_clear_ptes+0x421/0x530 mm/vma.c:1118
 vms_complete_munmap_vmas+0x20a/0x8a0 mm/vma.c:1160
 do_vmi_align_munmap+0x395/0x460 mm/vma.c:1369
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1417
 __vm_munmap+0x19b/0x360 mm/mmap.c:1639
 __do_sys_munmap mm/mmap.c:1656 [inline]
 __se_sys_munmap mm/mmap.c:1653 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1653
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888054c78300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888054c78380: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888054c78400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                           ^
 ffff888054c78480: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
 ffff888054c78500: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17258fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bd5e7c580000


