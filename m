Return-Path: <linux-kernel+bounces-581067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9FA75A14
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBD188AEF6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB231C5F25;
	Sun, 30 Mar 2025 12:26:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44128F9CB
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743337587; cv=none; b=XDw9YOAIQDUsQWF1aPI3UG3likCr2JKfO/gynrU06lOm1zDi7YPqFCzmi+R8xN4XCsMnCx3BvlBHxNNW0r2NpnDl1eMY7S4WPS6amfDiFcj6r9GKofvDD15fFBtKGFI+xtIB1gzE8mT67WxVXmPY7neV8++V2kNNPrvcInm/dnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743337587; c=relaxed/simple;
	bh=oa5609GjEbqbmZxv+Z5AcVoUV7XY33As93x5YIiVidA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=esI4FiiNLcFfwou78KLfwkgHnMgxqpGHY2riE2S46ChC2tCBVlUlZxH+VRJeRWQ2noMkEpzb4TvU+6jLzj0/WFYotiehWvwQ6qtJr6JTExO06vHssa4XAbhlhAoFVd6C+YyGnQKb6I6OLNgI3IHQdakq8uLRNwti5/uOuHpklYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d453d367a0so75172955ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 05:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743337584; x=1743942384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRFL0cukSSQZkgKtceLexvl+CCiDh5NZuVQfyWa81t4=;
        b=V2o070sbmuIf9YIZq0vgA6KHjxkdjBFLH37lr0Wv9xaHljpCVftCEbyOQ7urnZkr32
         UsLU7NH7O+QLDa3iT7GLVhQyRcN9NHeE+URh8UUFnmf00lY2yH0jEWtcW/u42QCTIGpk
         G0YaUpvFzdtF6EUgyFHczTRHShOpEVPAn3Fb8aIZH69X3UalhUSG0Gr537PZMtXLRufi
         suYHHuEg1vJR1hFHJoqXwdtjkZViqgpsF4ZnKmmNFE5ICcE+rPlGSqMWRUxzv72kWv/u
         2HUYTiGtlmFlMX4CZGsw0hagiVPW8hhQC/EFdUBu5HtmrxkdsxujTrVkMtPpHa1t8bBU
         1MZA==
X-Forwarded-Encrypted: i=1; AJvYcCWdLmACk4qVxaweBTILsLccVOIKaqp6gIQi/IHCOXJRu7D7lC8JK1oMKzx3B6nsHkxyu5djyE71MAXDiak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkgw+JpLkWKX4HybB41GXiWnloqvDrToM8c8wy1V09uFyYACZ0
	+XIYPusQ617bOegxFXyMoFrD6+AnnHQ5C/CQH+VkQUdpcm2SxL0v+yCxAcXOgj4HiJfkEpmpJfr
	Jwvhgn7XfMHny/OIXgaXQL7DyeOOtQjUDxiQWzxaTNyJBZ3Fn2/j0JzM=
X-Google-Smtp-Source: AGHT+IEB0JiiXjsCkQKPzqAuB+IRI8ElWDpaqWH3jVCHF4oQkxXqnHfCJU5nND944YkOIGF5TFD7tXz1sItquJ0KZZcTEiqdbZ1i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3d5e09e6086mr37517785ab.14.1743337584418; Sun, 30 Mar 2025
 05:26:24 -0700 (PDT)
Date: Sun, 30 Mar 2025 05:26:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e93870.050a0220.1547ec.00a5.GAE@google.com>
Subject: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_readdir
From: syzbot <syzbot+1aa62e6852a6ad1c7944@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e26c5e28ca5 Merge tag 'media/v6.15-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cea198580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=deb16a68b254ed74
dashboard link: https://syzkaller.appspot.com/bug?extid=1aa62e6852a6ad1c7944
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150b543f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1455aa4c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-1e26c5e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75d05b64ca52/vmlinux-1e26c5e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9f16a31d0fb/bzImage-1e26c5e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1aa62e6852a6ad1c7944@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir_cells fs/afs/dynroot.c:296 [inline]
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir+0xd20/0xf50 fs/afs/dynroot.c:352
Read of size 4 at addr ffff888032c50148 by task syz-executor403/16899

CPU: 0 UID: 0 PID: 16899 Comm: syz-executor403 Not tainted 6.14.0-syzkaller-02665-g1e26c5e28ca5 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 afs_dynroot_readdir_cells fs/afs/dynroot.c:296 [inline]
 afs_dynroot_readdir+0xd20/0xf50 fs/afs/dynroot.c:352
 iterate_dir+0x293/0xb40 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:322 [inline]
 __se_sys_getdents fs/readdir.c:308 [inline]
 __x64_sys_getdents+0x14d/0x2c0 fs/readdir.c:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f037b875499
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdbb88e7f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f037b875499
RDX: 00000000000000b8 RSI: 0000200000001fc0 RDI: 0000000000000005
RBP: 00002000000001c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdbb88e81c
R13: 00007ffdbb88e850 R14: 0000200000000808 R15: 0000200000000804
 </TASK>

Allocated by task 16883:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:902 [inline]
 kzalloc_noprof include/linux/slab.h:1036 [inline]
 afs_alloc_cell fs/afs/cell.c:137 [inline]
 afs_lookup_cell+0x61d/0x1680 fs/afs/cell.c:264
 afs_dynroot_lookup_cell fs/afs/dynroot.c:111 [inline]
 afs_dynroot_lookup+0x3d8/0xd60 fs/afs/dynroot.c:159
 __lookup_slow+0x24e/0x460 fs/namei.c:1807
 lookup_slow fs/namei.c:1824 [inline]
 walk_component+0x353/0x5b0 fs/namei.c:2128
 lookup_last fs/namei.c:2626 [inline]
 path_lookupat+0x17e/0x780 fs/namei.c:2650
 filename_lookup+0x224/0x5f0 fs/namei.c:2679
 user_path_at+0x3a/0x60 fs/namei.c:3085
 do_mount fs/namespace.c:4215 [inline]
 __do_sys_mount fs/namespace.c:4429 [inline]
 __se_sys_mount fs/namespace.c:4406 [inline]
 __x64_sys_mount+0x1fc/0x310 fs/namespace.c:4406
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2376 [inline]
 slab_free mm/slub.c:4633 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4832
 afs_cell_destroy+0x21c/0x310 fs/afs/cell.c:524
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0x799/0x14e0 kernel/rcu/tree.c:2824
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
 __call_rcu_common.constprop.0+0x9a/0x9f0 kernel/rcu/tree.c:3082
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c1/0xef0 kernel/workqueue.c:3400
 kthread+0x3a4/0x760 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x10f0 kernel/workqueue.c:2341
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:662 [inline]
 afs_put_cell.part.0+0x1ab/0x240 fs/afs/cell.c:569
 afs_put_cell fs/afs/cell.c:557 [inline]
 afs_manage_cell_work+0x6de/0x1940 fs/afs/cell.c:859
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c1/0xef0 kernel/workqueue.c:3400
 kthread+0x3a4/0x760 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888032c50000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 328 bytes inside of
 freed 1024-byte region [ffff888032c50000, ffff888032c50400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32c50
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b442dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b442dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000cb1401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5692, tgid 5692 (dhcpcd-run-hook), ts 22236164619, free_ts 21924635911
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x10c4/0x34c0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x223/0x24d0 mm/page_alloc.c:4740
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2446 [inline]
 allocate_slab mm/slub.c:2610 [inline]
 new_slab+0x23c/0x330 mm/slub.c:2663
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3849
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3939
 __slab_alloc_node mm/slub.c:4014 [inline]
 slab_alloc_node mm/slub.c:4175 [inline]
 __do_kmalloc_node mm/slub.c:4317 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4330
 kmalloc_noprof include/linux/slab.h:906 [inline]
 load_elf_phdrs+0x102/0x210 fs/binfmt_elf.c:532
 load_elf_binary+0x1fa/0x4f80 fs/binfmt_elf.c:860
 search_binary_handler fs/exec.c:1773 [inline]
 exec_binprm fs/exec.c:1805 [inline]
 bprm_execve fs/exec.c:1857 [inline]
 bprm_execve+0x8dd/0x1700 fs/exec.c:1833
 do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1964
 do_execve fs/exec.c:2038 [inline]
 __do_sys_execve fs/exec.c:2114 [inline]
 __se_sys_execve fs/exec.c:2109 [inline]
 __x64_sys_execve+0x8e/0xb0 fs/exec.c:2109
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5668 tgid 5668 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6d8/0xf40 mm/page_alloc.c:2660
 discard_slab mm/slub.c:2707 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3176
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4138 [inline]
 slab_alloc_node mm/slub.c:4187 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4194
 getname_flags.part.0+0x48/0x540 fs/namei.c:146
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 getname include/linux/fs.h:2844 [inline]
 getname_maybe_null include/linux/fs.h:2851 [inline]
 getname_maybe_null include/linux/fs.h:2848 [inline]
 vfs_fstatat+0xe1/0xf0 fs/stat.c:363
 __do_sys_newfstatat+0xa1/0x130 fs/stat.c:532
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888032c50000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888032c50080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888032c50100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888032c50180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888032c50200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

