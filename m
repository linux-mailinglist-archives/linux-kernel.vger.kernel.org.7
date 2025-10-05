Return-Path: <linux-kernel+bounces-842503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5600ABBCDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82C3C4E642E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9FA2367AE;
	Sun,  5 Oct 2025 23:30:28 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EBC8E6
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707027; cv=none; b=r5nUUzMNCWF1ezFyqYd607dkm8OHz8K0+6kkZamWP5tiRNbYtzet9L3ysIpXhzB6pET25NK/2WoQvQiiSh2DbDVHPpVWzutqaYxJVlt0jz96cMQUMKSBAIblE2R8ngrar/Fy+RrVmFIz+iCDoK9LHNrRj7PRQY9kmZWJry82bn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707027; c=relaxed/simple;
	bh=ffHnMTp1YQxSjeS+8n3or0dpMupn405resC6I6g28Bs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jFlnPF3ER6DK0ASFJ9vPEpsJZ2/qXa2cAI+6S6Zt5XBwNpaTsYFl42PLSDUb4LPpl3N6LguKdRB2HnbFfHs+T9kMSjqchL+uEtivNr6omvGZt8On4BJiV3mzcEO2WmhoR8Uh1AQRsz+y+8CqHYT2Bh8hCrhkJCiAaPW4eCzRFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42f65c920dcso33629995ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707025; x=1760311825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g3gR6KOixvAYo5IoM5AoVWuNhUSMQ3N1FqnI7fFi34=;
        b=KYXhy9lQRC6Jm7kXLbVjpckufg3NaPHevjEKwZgLua/z36XKT2LhvE1vtC1xeZDsve
         0W2Nzgqa/ngT1gnaLSg8ePu2xmGmkvxBInrhbcd/FSf3bh/rwJ+iyeBhT0/eH4OEvccS
         4ddF5ea7MAZRznS8q92y9T9sS39RIa98ofj8HM1PEl5suKk7qjwnkLRJVrZ7n4OrLNI+
         TiTeEF4rUY+B6mgwRxWz2LjRo98E881wXZgC5qrTUtevffulhZmGn8t7z4eJsJyJw1X7
         WluzYYYuGOZP0MI9U1KKh35/8B1jdB8kyv6InC40bmgnO3W8rFvTqmFCZFp4j3n3DgGL
         0hbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOt2mv7IuoNTOkE1mRdRybhPK5CyiMDe8vo13wKkvAbDoYnthVWxtzMIS5SUBqC7fuRvouQqXFQaIo8Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEX3T2hrk3AowULEKKtdC5Z+QjDXhk+1NZJ6Fh8n+DwBWQC/us
	puMCTOyEC1OvhhTXCM34ZponeEw2wZuRxlO1Lg0rAv54gDQDzZLeQuIo9RZcnEqGvC7HrYRcQm+
	e8/y59oNU9bw+bZDsBVausSTiEco0h4+MX1xZTtd3EGfiSGDAfwO2gZNfzzY=
X-Google-Smtp-Source: AGHT+IHY52iFOsiZxkj07cZFnpFxMBhlQFGdcuBR1QZ5j2tbnICqgDJ7B7NvOApqlXVGfRjXVFsX5q/aoY3BHdXHovk/RrP+B4+V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:42e:2c30:285d with SMTP id
 e9e14a558f8ab-42e7acd28e4mr152065235ab.6.1759707024768; Sun, 05 Oct 2025
 16:30:24 -0700 (PDT)
Date: Sun, 05 Oct 2025 16:30:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e2ff90.050a0220.2c17c1.0038.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in __cpa_addr
From: syzbot <syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, kas@kernel.org, 
	kevin.brodsky@arm.com, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, riel@surriel.com, rppt@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, wei.liu@kernel.org, 
	x86@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d104e3d17f7b Merge tag 'cxl-for-6.18' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c1d334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc69e404f541b2c8
dashboard link: https://syzkaller.appspot.com/bug?extid=afec6555eef563c66c97
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1420585b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15455ee2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a74b5722a024/disk-d104e3d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f30801cac4ea/vmlinux-d104e3d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b4de16badcd/bzImage-d104e3d1.xz

The issue was bisected to:

commit 86e6815b316ec0ea8c4bb3c16a033219a52b6060
Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date:   Fri Jun 6 17:10:35 2025 +0000

    x86/mm: Change cpa_flush() to call flush_kernel_range() directly

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bbb942580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=147bb942580000
console output: https://syzkaller.appspot.com/x/log.txt?x=107bb942580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com
Fixes: 86e6815b316e ("x86/mm: Change cpa_flush() to call flush_kernel_range() directly")

==================================================================
BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c:309 [inline]
BUG: KASAN: slab-out-of-bounds in __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/set_memory.c:306
Read of size 8 at addr ffff88801f75e8f8 by task syz.0.17/5978

CPU: 0 UID: 0 PID: 5978 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 __cpa_addr arch/x86/mm/pat/set_memory.c:309 [inline]
 __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/set_memory.c:306
 cpa_flush+0x28b/0x8a0 arch/x86/mm/pat/set_memory.c:449
 change_page_attr_set_clr+0x34e/0x4a0 arch/x86/mm/pat/set_memory.c:2115
 cpa_set_pages_array arch/x86/mm/pat/set_memory.c:2137 [inline]
 _set_pages_array+0x1ab/0x2c0 arch/x86/mm/pat/set_memory.c:2521
 drm_gem_shmem_get_pages_locked+0x384/0x490 drivers/gpu/drm/drm_gem_shmem_helper.c:214
 drm_gem_shmem_mmap drivers/gpu/drm/drm_gem_shmem_helper.c:646 [inline]
 drm_gem_shmem_mmap+0xc9/0x550 drivers/gpu/drm/drm_gem_shmem_helper.c:620
 drm_gem_mmap_obj+0x1b5/0x560 drivers/gpu/drm/drm_gem.c:1167
 drm_gem_mmap+0x40b/0x620 drivers/gpu/drm/drm_gem.c:1245
 vfs_mmap include/linux/fs.h:2404 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2413 [inline]
 __mmap_new_vma mm/vma.c:2476 [inline]
 __mmap_region+0x1306/0x27a0 mm/vma.c:2670
 mmap_region+0x1ab/0x3f0 mm/vma.c:2740
 do_mmap+0xa3e/0x1210 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:604
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f825658eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcee652688 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f82567e5fa0 RCX: 00007f825658eec9
RDX: 0000000000000004 RSI: 0000000000004000 RDI: 0000200000001000
RBP: 00007f8256611f91 R08: 0000000000000003 R09: 0000000100000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f82567e5fa0 R14: 00007f82567e5fa0 R15: 0000000000000006
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88801f75fc00 pfn:0x1f75c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f8(unknown)
raw: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
raw: ffff88801f75fc00 0000000000000000 00000000f8000000 0000000000000000
head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
head: ffff88801f75fc00 0000000000000000 00000000f8000000 0000000000000000
head: 00fff00000000002 ffffea00007dd701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x428c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_COMP), pid 5978, tgid 5978 (syz.0.17), ts 72327313076, free_ts 72326414796
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 ___kmalloc_large_node+0xed/0x160 mm/slub.c:5544
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:5575
 __do_kmalloc_node mm/slub.c:5591 [inline]
 __kvmalloc_node_noprof.cold+0xf/0x66 mm/slub.c:7036
 kvmalloc_array_node_noprof include/linux/slab.h:1122 [inline]
 drm_gem_get_pages+0x144/0xa10 drivers/gpu/drm/drm_gem.c:647
 drm_gem_shmem_get_pages_locked+0x1e6/0x490 drivers/gpu/drm/drm_gem_shmem_helper.c:200
 drm_gem_shmem_mmap drivers/gpu/drm/drm_gem_shmem_helper.c:646 [inline]
 drm_gem_shmem_mmap+0xc9/0x550 drivers/gpu/drm/drm_gem_shmem_helper.c:620
 drm_gem_mmap_obj+0x1b5/0x560 drivers/gpu/drm/drm_gem.c:1167
 drm_gem_mmap+0x40b/0x620 drivers/gpu/drm/drm_gem.c:1245
 vfs_mmap include/linux/fs.h:2404 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2413 [inline]
 __mmap_new_vma mm/vma.c:2476 [inline]
 __mmap_region+0x1306/0x27a0 mm/vma.c:2670
 mmap_region+0x1ab/0x3f0 mm/vma.c:2740
 do_mmap+0xa3e/0x1210 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
page last free pid 5978 tgid 5978 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 stack_depot_save_flags+0x352/0x9c0 lib/stackdepot.c:727
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5603 [inline]
 __kmalloc_node_noprof+0x347/0x8a0 mm/slub.c:5609
 kmalloc_array_node_noprof include/linux/slab.h:1075 [inline]
 alloc_slab_obj_exts+0x3a/0xd0 mm/slub.c:2115
 __memcg_slab_post_alloc_hook+0x251/0x940 mm/memcontrol.c:3172
 memcg_slab_post_alloc_hook mm/slub.c:2313 [inline]
 slab_post_alloc_hook mm/slub.c:4957 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 kmem_cache_alloc_noprof+0x550/0x6e0 mm/slub.c:5252
 anon_vma_chain_alloc mm/rmap.c:141 [inline]
 anon_vma_clone+0xd8/0x5c0 mm/rmap.c:287
 __split_vma+0x65e/0x1070 mm/vma.c:535
 vms_gather_munmap_vmas+0x1cb/0x1340 mm/vma.c:1359
 __mmap_prepare mm/vma.c:2359 [inline]
 __mmap_region+0x434/0x27a0 mm/vma.c:2652
 mmap_region+0x1ab/0x3f0 mm/vma.c:2740
 do_mmap+0xa3e/0x1210 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:580

Memory state around the buggy address:
 ffff88801f75e780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801f75e800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801f75e880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
                                                                ^
 ffff88801f75e900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88801f75e980: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
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

