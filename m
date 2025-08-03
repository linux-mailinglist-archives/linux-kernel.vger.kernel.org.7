Return-Path: <linux-kernel+bounces-754549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7968B196C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0B97A14CF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A620102B;
	Sun,  3 Aug 2025 22:39:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCE1F582E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260746; cv=none; b=fImmqoJ0Gec2xephC/IuqLpI3CxvcBIPXYtV2XLtixejDkvtQ60IHfvsoGx3jmbpIp8b9RKpnC3eyv6RZiTmRxKplKTiNR5cjW412AjMxrJAqb1OJ480Dt4W+RtBkU+RCtaA5I8LUADWJWI2Q44m9SAnzuD3aJtKffGnAWnUeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260746; c=relaxed/simple;
	bh=hGq8dB/YNAJ8fAM+mPvM0zJle9FVfjm3hgGFIr4IX4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=icgryXqqF9X+jhO/2jbjYrBL1X5BM1Njr8vERR7nOF1ynM0Xd6CnI+Csy58oCx7ti0f8aHLcLO78q7ypM/AJ5XQ4c7Yi2BlyJg95xxfRJz0ER4+oN9ImL/D9DrGkm2E1OghtHVQC6Ijw+cea1lW8mkx5y09OVDQ+lWwqFgmHKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e40c0ffb1bso25697635ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754260743; x=1754865543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADX2ixe6vAG72P126izuYRQoOFn/Ph8+nPmn87A7OxY=;
        b=OnTliYLpg8mQAQj4oQBjxWvDH6vt/anSbUTKOF1yYnxtwmW3c3Poy65LPko2eBfSYD
         PURU3AjIgeE8aQk1tMgKtzyTdz4rsRdVk8ILNpzkHZXDXhIdib43Eb5ujq8LXgew2ikN
         NHzSHxZ+pkiGFKtu5RPJS9EMFMyzeHQp4OimcIv1VZW6WW9EPtmTJzsvCQNcVNCzH+Vi
         L8DkcgdfMaOiwNYOhtG5IFJX5fg5M+HN3bPnR1JdUD7wJXrlc2Fk7+tnVJmnHAq+8Ud0
         RhCRRHdh5bP6dKYWWpkO/Mtc7nC8y9Ccvs75VROYbBjVLQHJwQQg8k1k46lKYcKNtMRK
         abIA==
X-Gm-Message-State: AOJu0Yx9DU0zcqcrMLCHVk8kHr1Yh4iddxLbRXq+MUeV3bSC0ccq3f29
	rrfPx3axMI6mpSZB+IAhsI9gmdN4nvJfFRzLSccOJryvKZsIoPDAP+Z9OOwmbgHX9qovKfUgw8h
	puadVcQUTeKQctmxD6FEd7O3CRug5+kp9yPl0Q5NxlPtHna3OIFGXSP0bIw0=
X-Google-Smtp-Source: AGHT+IG9VS53TWDyoU+MyXpAERd8F1yqAOvFAYi7TxxhTGLWIQZ6YFsLIVfCpSAKGsxuZCXgKAZ74029sB/dO88/CAJndPTWqe2z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3e2:a40e:d29f with SMTP id
 e9e14a558f8ab-3e416129f34mr121249995ab.9.1754260743152; Sun, 03 Aug 2025
 15:39:03 -0700 (PDT)
Date: Sun, 03 Aug 2025 15:39:03 -0700
In-Reply-To: <CAJuRXzBmd-mViNReK64CozvMeUfF2AWtdNiDAz=hL0-AcGD7fw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688fe507.050a0220.1fc43d.0008.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
From: syzbot <syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sravankumarlpu@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in fbcon_prepare_logo

==================================================================
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:38 [inline]
BUG: KASAN: slab-out-of-bounds in fbcon_prepare_logo+0xa03/0xc70 drivers/video/fbdev/core/fbcon.c:618
Read of size 256 at addr ffff88802ad9b860 by task syz.0.17/6602

CPU: 0 UID: 0 PID: 6602 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-04405-g4b290aae788e-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 scr_memcpyw include/linux/vt_buffer.h:38 [inline]
 fbcon_prepare_logo+0xa03/0xc70 drivers/video/fbdev/core/fbcon.c:618
 fbcon_init+0x118d/0x1920 drivers/video/fbdev/core/fbcon.c:1150
 visual_init+0x320/0x620 drivers/tty/vt/vt.c:1019
 do_bind_con_driver.isra.0+0x57a/0xbf0 drivers/tty/vt/vt.c:3915
 vt_bind drivers/tty/vt/vt.c:4071 [inline]
 store_bind+0x61d/0x760 drivers/tty/vt/vt.c:4143
 dev_attr_store+0x58/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c4/0x1150 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f988878e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9889579038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f98889b5fa0 RCX: 00007f988878e9a9
RDX: 0000000000000081 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f9888810d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f98889b5fa0 R15: 00007ffc350333d8
 </TASK>

Allocated by task 6325:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2247
 sk_alloc+0x36/0xc20 net/core/sock.c:2303
 __netlink_create+0x5e/0x2c0 net/netlink/af_netlink.c:628
 __netlink_kernel_create+0xed/0x750 net/netlink/af_netlink.c:2020
 netlink_kernel_create include/linux/netlink.h:62 [inline]
 nl_fib_lookup_init net/ipv4/fib_frontend.c:1438 [inline]
 fib_net_init net/ipv4/fib_frontend.c:1644 [inline]
 fib_net_init+0x26d/0x3f0 net/ipv4/fib_frontend.c:1629
 ops_init+0x1df/0x5f0 net/core/net_namespace.c:138
 setup_net+0x1ff/0x510 net/core/net_namespace.c:442
 copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:574
 create_new_namespaces+0x3ea/0xa90 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:218
 ksys_unshare+0x45b/0xa40 kernel/fork.c:3124
 __do_sys_unshare kernel/fork.c:3195 [inline]
 __se_sys_unshare kernel/fork.c:3193 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3193
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6332:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 sk_prot_free net/core/sock.c:2286 [inline]
 __sk_destruct+0x740/0x980 net/core/sock.c:2381
 sk_destruct+0xc2/0xf0 net/core/sock.c:2409
 __sk_free+0xf4/0x3e0 net/core/sock.c:2420
 sk_free+0x6a/0x90 net/core/sock.c:2431
 deferred_put_nlk_sk+0xc9/0x110 net/netlink/af_netlink.c:716
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0x79c/0x14e0 kernel/rcu/tree.c:2832
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3094
 netlink_release+0x12f4/0x2020 net/netlink/af_netlink.c:798
 __sock_release net/socket.c:647 [inline]
 sock_release+0x8e/0x1d0 net/socket.c:675
 netlink_kernel_release+0x4e/0x60 net/netlink/af_netlink.c:2080
 nl_fib_lookup_exit net/ipv4/fib_frontend.c:1447 [inline]
 fib_net_exit+0x40/0x80 net/ipv4/fib_frontend.c:1668
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x2eb/0xab0 net/core/net_namespace.c:253
 cleanup_net+0x408/0x890 net/core/net_namespace.c:686
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802ad9b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 96 bytes to the right of
 allocated 2048-byte region [ffff88802ad9b000, ffff88802ad9b800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ad98
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842000 0000000000000000 dead000000000001
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000ab6601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5925, tgid 5925 (syz-executor), ts 92458486289, free_ts 63680726622
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 ops_init+0x77/0x5f0 net/core/net_namespace.c:128
 setup_net+0x1ff/0x510 net/core/net_namespace.c:442
 copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:574
 create_new_namespaces+0x3ea/0xa90 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:218
 ksys_unshare+0x45b/0xa40 kernel/fork.c:3124
 __do_sys_unshare kernel/fork.c:3195 [inline]
 __se_sys_unshare kernel/fork.c:3193 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3193
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
page last free pid 5666 tgid 5666 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4204
 getname_flags.part.0+0x4c/0x550 fs/namei.c:146
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 user_path_at+0x24/0x60 fs/namei.c:3126
 do_faccessat+0x139/0xba0 fs/open.c:493
 __do_sys_access fs/open.c:552 [inline]
 __se_sys_access fs/open.c:550 [inline]
 __x64_sys_access+0x5b/0x80 fs/open.c:550
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802ad9b700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ad9b780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802ad9b800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff88802ad9b880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ad9b900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=120c8042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb654b6c0c63cccc
dashboard link: https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16548042580000


