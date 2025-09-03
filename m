Return-Path: <linux-kernel+bounces-799177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3DB4280C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2227E7B0680
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ADB4C92;
	Wed,  3 Sep 2025 17:36:35 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9A2D46BD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920994; cv=none; b=kPVf7GsWZLY1/g4vSHvS+lEr+sNI8dBVCV9SOmtaMrIEOxGZvmbo1XyCWTBxDwCYwxy0qHWlHBxLwjUGKNQHJVZ0P74IuidS5u5wsJumdQpkv8iMtQjWB+EfRllS0y8qFOeZRRkeyIkaHUwupoKAebjJ4lFYXhjXzMMl5fquc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920994; c=relaxed/simple;
	bh=ZRJxV8sf8s4t/r24QZrFdvcr0rnl+yVqWam1bgMjynk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QbYC9huyZfhw2wm1i8lnsETtBBaR/GWsUQZMqFlZRO+0eJckCWtnb2EtjzodQ+Rj2+AVqQlc/i/JjpUsIQV/adkYAGDeAYNyv1GuVwY0z1+fQ4uHYcUvoN4ifB5/SOaDVDIOV0KFZeClUcUvgkOpmQBjJvbXaJjcx0r1Xs0ETiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ed0f07fca2so1365575ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756920992; x=1757525792;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se8uSIQ/yecu8d7dwUSzE6UZTCl5fGObpAEqAgTZAnc=;
        b=Av9Py+xaqD1yTJN61U7KZmDtCbza4BTX9KWIYO7RZRIlMrlBpReQxHWazcIgj43h5l
         8SPOktcnw2TM0iEm6gEqPllyt8YNUGYHDRoz5yIGeFxOkbgTDrL/Y2h8xfpdeC6RoVZ6
         qIlP4f2hJH4d0pB4WoWNd1qUQ3nAN+lxl/oir1ERUq1dG8s6dzGW6F/msfWxsOQ/sF9D
         52AYbMCzr0OO5WovTmhm63S2O2rG2bP4wmOzk2bp8nFqfW7OcYFOau4mwWKZmPy6H3NZ
         GUdSPU2EKqhDvHQeqpRR4/knPKd5wt1nEJOELfaFzcaL7ue1FnQ3+r6x3hRguG9CrOwa
         NYLw==
X-Forwarded-Encrypted: i=1; AJvYcCWkj47f+nsFpLlVy7qnxErxzfp/s6YO4UEaHh/CENx+3jcRpMLCB9Su4JRCgNunwe560YYyj1IpMbmtVfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj32coCsYh93BrSNdvV+ftZdK5rk3PCiDzp4949wnMhx5CkCoT
	o6XYnofQmWbfhs8D5JSnGO/ekR+78SKPDFqq7fk4OBqNodSIB6K5WWxNl9D/dK3TZdEvabbvZWz
	TDcVgtDLmdVp0gdRKKeq2SkFv/E/KnuLJPaD4YD3uDt3R1RJxvuqyGGt5C4g=
X-Google-Smtp-Source: AGHT+IHJ1LQVEnu0pxOGU5poMWFg6Q3HYL7bZgPet+aY0jijRJ53M7VdKZPwxj2koNOqB69/1I4rSRuKRptMezxc1SbQNSjPJtvY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1809:b0:3f6:626d:6b50 with SMTP id
 e9e14a558f8ab-3f6626d6cadmr31529875ab.11.1756920991987; Wed, 03 Sep 2025
 10:36:31 -0700 (PDT)
Date: Wed, 03 Sep 2025 10:36:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b87c9f.050a0220.3db4df.01fa.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d50cf9f7cf2 Add linux-next specific files for 20250903
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1737aa42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75c8190df02c3a12
dashboard link: https://syzkaller.appspot.com/bug?extid=e34177f6091df113ef20
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17863e34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cace62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/507bf19223ad/disk-5d50cf9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/291d21d10813/vmlinux-5d50cf9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c70044ef19c4/bzImage-5d50cf9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c:309 [inline]
BUG: KASAN: slab-out-of-bounds in cpa_flush arch/x86/mm/pat/set_memory.c:449 [inline]
BUG: KASAN: slab-out-of-bounds in change_page_attr_set_clr+0x625/0xfc0 arch/x86/mm/pat/set_memory.c:2115
Read of size 8 at addr ffff8880307dca48 by task syz.0.17/6026

CPU: 0 UID: 0 PID: 6026 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __cpa_addr arch/x86/mm/pat/set_memory.c:309 [inline]
 cpa_flush arch/x86/mm/pat/set_memory.c:449 [inline]
 change_page_attr_set_clr+0x625/0xfc0 arch/x86/mm/pat/set_memory.c:2115
 cpa_set_pages_array arch/x86/mm/pat/set_memory.c:2137 [inline]
 _set_pages_array+0x145/0x270 arch/x86/mm/pat/set_memory.c:2521
 drm_gem_shmem_get_pages_locked+0x2d0/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:214
 drm_gem_shmem_mmap+0x193/0x460 drivers/gpu/drm/drm_gem_shmem_helper.c:646
 drm_gem_mmap_obj+0x18a/0x4e0 drivers/gpu/drm/drm_gem.c:1167
 drm_gem_mmap+0x384/0x640 drivers/gpu/drm/drm_gem.c:1245
 vfs_mmap include/linux/fs.h:2281 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2413 [inline]
 __mmap_new_vma mm/vma.c:2476 [inline]
 __mmap_region mm/vma.c:2669 [inline]
 mmap_region+0x18ab/0x20c0 mm/vma.c:2739
 do_mmap+0xc45/0x10d0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:580
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f16ecf8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3ff9fb58 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f16ed1c5fa0 RCX: 00007f16ecf8ebe9
RDX: 0000000000000004 RSI: 0000000000004000 RDI: 0000200000001000
RBP: 00007f16ed011e19 R08: 0000000000000003 R09: 0000000100000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f16ed1c5fa0 R14: 00007f16ed1c5fa0 R15: 0000000000000006
 </TASK>

Allocated by task 6026:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:5366 [inline]
 __kvmalloc_node_noprof+0x5cd/0x910 mm/slub.c:6527
 kvmalloc_array_node_noprof include/linux/slab.h:1118 [inline]
 drm_gem_get_pages+0x166/0xa20 drivers/gpu/drm/drm_gem.c:647
 drm_gem_shmem_get_pages_locked+0x201/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:200
 drm_gem_shmem_mmap+0x193/0x460 drivers/gpu/drm/drm_gem_shmem_helper.c:646
 drm_gem_mmap_obj+0x18a/0x4e0 drivers/gpu/drm/drm_gem.c:1167
 drm_gem_mmap+0x384/0x640 drivers/gpu/drm/drm_gem.c:1245
 vfs_mmap include/linux/fs.h:2281 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2413 [inline]
 __mmap_new_vma mm/vma.c:2476 [inline]
 __mmap_region mm/vma.c:2669 [inline]
 mmap_region+0x18ab/0x20c0 mm/vma.c:2739
 do_mmap+0xc45/0x10d0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:580
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880307dc800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes to the right of
 allocated 584-byte region [ffff8880307dc800, ffff8880307dca48)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a841dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a841dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000c1f601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 36, tgid 36 (kworker/u8:2), ts 106205622023, free_ts 105780713777
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3857
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5147
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2996 [inline]
 allocate_slab+0x8a/0x330 mm/slub.c:3164
 new_slab mm/slub.c:3218 [inline]
 ___slab_alloc+0xbd1/0x13f0 mm/slub.c:4420
 __slab_alloc+0x55/0xa0 mm/slub.c:4511
 __slab_alloc_node mm/slub.c:4586 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 __do_kmalloc_node mm/slub.c:5365 [inline]
 __kmalloc_noprof+0x471/0x7f0 mm/slub.c:5378
 kmalloc_noprof include/linux/slab.h:960 [inline]
 kzalloc_noprof include/linux/slab.h:1090 [inline]
 neigh_alloc net/core/neighbour.c:522 [inline]
 ___neigh_create+0x6d5/0x2260 net/core/neighbour.c:656
 ip6_finish_output2+0x1175/0x1480 net/ipv6/ip6_output.c:128
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xbce/0x1510 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xcb/0x150 net/ipv6/ndisc.c:670
 addrconf_dad_work+0xaae/0x14b0 net/ipv6/addrconf.c:4282
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
page last free pid 6021 tgid 6021 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2894
 __slab_free+0x2e7/0x390 mm/slub.c:5596
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4710 [inline]
 slab_alloc_node mm/slub.c:5008 [inline]
 kmem_cache_alloc_noprof+0x367/0x6e0 mm/slub.c:5015
 vm_area_dup+0x2b/0x680 mm/vma_init.c:123
 __split_vma+0x1a9/0xa00 mm/vma.c:515
 vms_gather_munmap_vmas+0x2ea/0x12f0 mm/vma.c:1359
 __mmap_prepare mm/vma.c:2359 [inline]
 __mmap_region mm/vma.c:2651 [inline]
 mmap_region+0x724/0x20c0 mm/vma.c:2739
 do_mmap+0xc45/0x10d0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:580
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307dc900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880307dc980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880307dca00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
                                              ^
 ffff8880307dca80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880307dcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

