Return-Path: <linux-kernel+bounces-653538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D1ABBB01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F55D170958
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730927467F;
	Mon, 19 May 2025 10:23:36 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FC267B95
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650215; cv=none; b=P4lcWhp/mkRl0a+Sm8oQhqeVRxEyKii1LhPxfxoDWrxeQ9yW4HuejvEJKRl51ZezWN62o3RUuIwwRWmddYuuNM11BnjkTesCKeskHiG2OZK3j7wdV03mOJfmm4qXdLoU9PQXzZfATM6+ddVZW1+CKiOzJWPZIaYOCvdQGeTrSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650215; c=relaxed/simple;
	bh=a3poDyu099H20zIKeUc2Wte/TPmQSewyK4TZpzRVHh8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q18d+VZahXmlIb181Ltv4Y6aSFcMO2iIDbPIpQso67R4aqqlV1o8+uKwDCgW64Ftl/UQXTHgwA9BmwR6FDgYOVqGZNOoRGiWibzl6E26f6gRt5/gk65kRGR7m5adnjA+0YVjUSZkcqcqsAK3uvbOnARnoGrEJLViuFnlFKE8I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b53875729so786148039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 03:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650213; x=1748255013;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MA37pZ/op9Ha0rSmA64oogOPFfiGOjv0VANlHlc1aXA=;
        b=lwukZhuFPDdALVrY9Nn/krwnRtvWYgoA/iCI9+KVFInTviRzFDeeak2lCtSkkYBI9S
         lErSkUlGe0cEOtw1hkb7XI6jCl/34Bn8R/oOLM/7KiW7ai3OjCgUtwMDGdUv15tJB5ZS
         bulQvAbaNmwLORLyKM7u85A56hrW8GSdOtnZk2fvB4hPVQNT3fLlXO+BTfhFkSGbilO1
         ZVPHneJJHnKzB/tuNsx7TXmqR17M7TeJqPAKCDV8imA1n9riHU3c3eRFih0iooQ0Qty0
         30M/egyETCZIomWWf6Vci7vXeVXD2ob4pF+NqL/T7ndB9fg+kMy1O3YZDm3REd44dKsa
         KxYA==
X-Gm-Message-State: AOJu0YyP5MpcxM0CNM77ryHEAhGwwYRewyCAuN1QRMk3rwHv9a7LP4s0
	W2N5BEKbf2syqlYPSxi5mHnEzpiBCZwnPOr6aUyUGbkKChaKqCVEk06UdEBhTuvysb5/3AEvLox
	pKtQ6nyGPF5AWiAMsgy31L9IoCdyeY/8Bee8nhRo4FzMG/o3tFMrv61BAuY/SMg==
X-Google-Smtp-Source: AGHT+IH70G033nYzaVUeACGubIk1ZHu+oZgr7ZeWruX7jzhts8TiD5EAyCzMtsn2dRFv0RO1NuaQ4M/hnnixN0a4gZeZtwkUbEhu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3805:b0:86a:93b:ce96 with SMTP id
 ca18e2360f4ac-86a2316ecedmr1570579539f.1.1747650213163; Mon, 19 May 2025
 03:23:33 -0700 (PDT)
Date: Mon, 19 May 2025 03:23:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682b06a5.a70a0220.3849cf.00b3.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 thread_group_cputime (2)
From: syzbot <syzbot+531502bbbe51d2f769f4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    546bce579204 Merge tag 'tpmdd-next-6.15-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134f9af4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc44e21a0b824ef8
dashboard link: https://syzkaller.appspot.com/bug?extid=531502bbbe51d2f769f4
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb62cd2c4a93/disk-546bce57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a96e55101d0e/vmlinux-546bce57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efe5c6d25417/bzImage-546bce57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+531502bbbe51d2f769f4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in thread_group_cputime+0x2cd/0x7d0 kernel/sched/cputime.c:339
Read of size 8 at addr ffff88802a4e0920 by task syz.0.5798/29685

CPU: 1 UID: 0 PID: 29685 Comm: syz.0.5798 Not tainted 6.15.0-rc6-syzkaller-00093-g546bce579204 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 thread_group_cputime+0x2cd/0x7d0 kernel/sched/cputime.c:339
 thread_group_cputime_adjusted+0x55/0x230 kernel/sched/cputime.c:637
 getrusage+0x1246/0x14e0 kernel/sys.c:1869
 io_uring_show_fdinfo+0xb73/0x1780 io_uring/fdinfo.c:197
 seq_show+0x5e3/0x750 fs/proc/fd.c:68
 seq_read_iter+0x4e7/0xe10 fs/seq_file.c:230
 seq_read+0x2e2/0x3d0 fs/seq_file.c:162
 vfs_read+0x1fd/0x980 fs/read_write.c:568
 ksys_read+0x145/0x250 fs/read_write.c:713
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f307658e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30743f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f30767b6160 RCX: 00007f307658e969
RDX: 0000000000002020 RSI: 00002000000020c0 RDI: 0000000000000004
RBP: 00007f3076610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f30767b6160 R15: 00007f30768dfa28
 </TASK>

Allocated by task 29680:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4248
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct+0x52/0x860 kernel/fork.c:1128
 copy_process+0x544/0x3b80 kernel/fork.c:2259
 create_io_thread+0xef/0x150 kernel/fork.c:2792
 io_sq_offload_create+0xa7c/0x1180 io_uring/sqpoll.c:481
 io_uring_create+0x60d/0xb60 io_uring/io_uring.c:3739
 io_uring_setup io_uring/io_uring.c:3822 [inline]
 __do_sys_io_uring_setup io_uring/io_uring.c:3856 [inline]
 __se_sys_io_uring_setup+0x264/0x270 io_uring/io_uring.c:3847
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x192/0x3f0 mm/slub.c:4744
 put_task_struct include/linux/sched/task.h:145 [inline]
 delayed_put_task_struct+0x11f/0x2f0 kernel/exit.c:225
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2824
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3082 [inline]
 call_rcu+0x142/0x990 kernel/rcu/tree.c:3202
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0x16ea/0x4cd0 kernel/sched/core.c:6767
 schedule_idle+0x52/0x90 kernel/sched/core.c:6886
 do_idle+0x4ad/0x510 kernel/sched/idle.c:353
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:423
 rest_init+0x2de/0x300 init/main.c:743
 start_kernel+0x470/0x4f0 init/main.c:1099
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:513
 x86_64_start_kernel+0x66/0x70 arch/x86/kernel/head64.c:494
 common_startup_64+0x13e/0x147

The buggy address belongs to the object at ffff88802a4e0000
 which belongs to the cache task_struct of size 7424
The buggy address is located 2336 bytes inside of
 freed 7424-byte region [ffff88802a4e0000, ffff88802a4e1d00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a4e0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888068fb9b81
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88814042a500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff888068fb9b81
head: 00fff00000000040 ffff88814042a500 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 ffff888068fb9b81
head: 00fff00000000003 ffffea0000a93801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1084, tgid 1084 (kworker/u8:5), ts 11132598185, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4970
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2618
 new_slab mm/slub.c:2672 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3858
 __slab_alloc mm/slub.c:3948 [inline]
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 kmem_cache_alloc_node_noprof+0x280/0x3c0 mm/slub.c:4248
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct+0x52/0x860 kernel/fork.c:1128
 copy_process+0x544/0x3b80 kernel/fork.c:2259
 kernel_clone+0x21e/0x870 kernel/fork.c:2844
 user_mode_thread+0xdd/0x140 kernel/fork.c:2922
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802a4e0800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a4e0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a4e0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802a4e0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a4e0a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

