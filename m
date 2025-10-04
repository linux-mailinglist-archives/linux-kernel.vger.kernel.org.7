Return-Path: <linux-kernel+bounces-841954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF201BB89BF
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 07:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263E919C6CE8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD8F1487D1;
	Sat,  4 Oct 2025 05:30:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED82F85B
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759555831; cv=none; b=WOIYGO2bKK+XCkh42ytYYN2Ma40doVqn0jJbXkkj8JXriSmvcdR7w8J79TuRmpWdH6C/Rg7PoHZjmRg9D0cRX3TFgmznegzmzaHAEmkuxf72mO32y9ZgupbKnWLm9947tT8HhGj2T7AwyPLBsIoS6CoE/+oKD5j+TGdmpb2ualY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759555831; c=relaxed/simple;
	bh=vUP4vyKV7WmEQv2+G4+ByZXIZeF4fvlnkNaQAig1TOE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s7eVIZkKR4ZZHtz8uFelD3tCDvJhgPky5mtYcoaAvQ6nQ5WlhVToggMij9HgA4euGLOnRzC1Y8Ie/Q9sGX8Ygxy4R3V/QvodmnCwDFLkkbjiHI9Tux3Dtej6elL65WTb59rrpLFyd+9uXB4iERQJtw7dvEbY/ixh2j0wG8QFkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-937ce715b90so537778839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 22:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759555828; x=1760160628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8PB09wtpb2P2qDuAOr3MiLC4+ZG7AiaPdqkUT/LLR4=;
        b=ZJ6rgT3Kn67zS0GYRGpmMcxBwphRfQwourZksmC3Tq0yaJQSnn+ClrSRtiEv2mcyCl
         ihxjifRA/jiEjt5hu3itfGSY99A0zDUDIQ7Kqf19ItK7MNKMoKAsdHutnqEszwhVFFR1
         Brb3u1Hbup11oE+16vckMxjh9jYDcHs/U+wA4QibnEEhiX5YMzxEyP9jCn5UyB3SNnNM
         y9kH6BtIar1qcySUJJCHX5SCa8N4BbnPH/lnv6jk0u4Qg6rX1js15+9MWwEtqsnSLhDC
         vimbeU4xpCz42djKJmIenjEJKcAvy5U2Ik5Tvehke/yGXmHDuDfSMyMPLZAHBLNS0c+t
         qB1w==
X-Forwarded-Encrypted: i=1; AJvYcCV0LRi5Xz+VEgOYx0lUu0vL5QpHRiYfcLVd9/oppmqOBrKftln5+iBF2qCTOgLOp8ROMIjT3Gk4zHlwudQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTY+IEVxvKC8RXDnQlr4NvRIoHYxufUjoEE0T/PaFoFfU7bUTs
	KWEVAxpdZjXxvvbr65tmzimzvTNecaBBvgCDXbQlUgm/unDSN8bkX548gkP7amOtz1YQ43fBn9L
	6HGO+BryIHniOFmVxQh0JAyVFrEGCld8as0Jz3O9PQsClIxlLhr+lfXAeC+M=
X-Google-Smtp-Source: AGHT+IHwXNI/vkHvUYZtAbzvLG3T99hjQIyCpHCnYZoDtvwmBr4E0zD9MEhrFB59GCgNKuRTvrFDoOHEdv6spLeykXQOAgAtfdBT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:425:849c:52fa with SMTP id
 e9e14a558f8ab-42d8b24ad5bmr100936185ab.15.1759555828166; Fri, 03 Oct 2025
 22:30:28 -0700 (PDT)
Date: Fri, 03 Oct 2025 22:30:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e0b0f4.050a0220.396d9c.066c.GAE@google.com>
Subject: [syzbot] [afs?] KASAN: slab-use-after-free Read in
 afs_dynroot_readdir (2)
From: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b0d551bcc05 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e8304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3affc19c35df22d7
dashboard link: https://syzkaller.appspot.com/bug?extid=ae8ad52680705c162471
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17856a7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a05214580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b8223b2d807/disk-9b0d551b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2ad54c21240/vmlinux-9b0d551b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/702d27fd0804/bzImage-9b0d551b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir_cells fs/afs/dynroot.c:296 [inline]
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir+0x94e/0xb70 fs/afs/dynroot.c:352
Read of size 4 at addr ffff888076fbe148 by task syz.0.8268/15038

CPU: 1 UID: 0 PID: 15038 Comm: syz.0.8268 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 afs_dynroot_readdir_cells fs/afs/dynroot.c:296 [inline]
 afs_dynroot_readdir+0x94e/0xb70 fs/afs/dynroot.c:352
 iterate_dir+0x296/0xaf0 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64 fs/readdir.c:396 [inline]
 __x64_sys_getdents64+0x13c/0x2c0 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f085598eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff49e8bd28 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f0855be5fa0 RCX: 00007f085598eec9
RDX: 0000000000000055 RSI: 00002000000007c0 RDI: 0000000000000003
RBP: 00007f0855a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0855be5fa0 R14: 00007f0855be5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 15036:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 afs_alloc_cell fs/afs/cell.c:137 [inline]
 afs_lookup_cell+0x61d/0x1680 fs/afs/cell.c:265
 afs_dynroot_lookup_cell fs/afs/dynroot.c:111 [inline]
 afs_dynroot_lookup+0x2e2/0xa90 fs/afs/dynroot.c:159
 __lookup_slow+0x251/0x460 fs/namei.c:1816
 lookup_slow fs/namei.c:1833 [inline]
 walk_component+0x353/0x5b0 fs/namei.c:2151
 lookup_last fs/namei.c:2652 [inline]
 path_lookupat+0x142/0x6d0 fs/namei.c:2676
 filename_lookup+0x224/0x5f0 fs/namei.c:2705
 do_linkat+0x14c/0x5a0 fs/namei.c:4991
 __do_sys_link fs/namei.c:5045 [inline]
 __se_sys_link fs/namei.c:5043 [inline]
 __x64_sys_link+0x7d/0xa0 fs/namei.c:5043
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15038:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2514 [inline]
 slab_free mm/slub.c:6566 [inline]
 kfree+0x2b8/0x6d0 mm/slub.c:6773
 afs_cell_destroy+0x21c/0x310 fs/afs/cell.c:525
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x799/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3123
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 insert_work+0x36/0x230 kernel/workqueue.c:2186
 __queue_work+0x97e/0x1160 kernel/workqueue.c:2341
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:669 [inline]
 afs_put_cell.part.0+0x1ab/0x240 fs/afs/cell.c:570
 afs_put_cell fs/afs/cell.c:558 [inline]
 afs_manage_cell_work+0x6de/0x1940 fs/afs/cell.c:860
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888076fbe000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 328 bytes inside of
 freed 1024-byte region [ffff888076fbe000, ffff888076fbe400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76fb8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b026dc0 ffffea0000b9c200 dead000000000002
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b026dc0 ffffea0000b9c200 dead000000000002
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001dbee01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 49, tgid 49 (kworker/u8:3), ts 178491208774, free_ts 178478998089
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3030 [inline]
 allocate_slab mm/slub.c:3203 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3257
 ___slab_alloc+0xdc4/0x1ae0 mm/slub.c:4627
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4746
 __slab_alloc_node mm/slub.c:4822 [inline]
 slab_alloc_node mm/slub.c:5233 [inline]
 __do_kmalloc_node mm/slub.c:5602 [inline]
 __kmalloc_noprof+0x501/0x880 mm/slub.c:5615
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 neigh_alloc net/core/neighbour.c:522 [inline]
 ___neigh_create+0x14e6/0x28c0 net/core/neighbour.c:656
 ip6_finish_output2+0x11aa/0x1cf0 net/ipv6/ip6_output.c:128
 __ip6_finish_output+0x3cd/0x1010 net/ipv6/ip6_output.c:209
 ip6_finish_output net/ipv6/ip6_output.c:220 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x253/0x710 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:464 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xa85/0x1f50 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xc6/0x140 net/ipv6/ndisc.c:670
 addrconf_dad_work+0xbc9/0x14e0 net/ipv6/addrconf.c:4282
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
page last free pid 5848 tgid 5848 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4946 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 kmem_cache_alloc_noprof+0x250/0x6e0 mm/slub.c:5252
 getname_flags.part.0+0x4c/0x550 fs/namei.c:146
 getname_flags+0x93/0xf0 include/linux/audit.h:345
 getname include/linux/fs.h:2916 [inline]
 do_sys_openat2+0xb8/0x1d0 fs/open.c:1431
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888076fbe000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076fbe080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888076fbe100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888076fbe180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076fbe200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

