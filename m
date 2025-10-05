Return-Path: <linux-kernel+bounces-842211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D34BB93D9
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 05:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137643BDC99
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 03:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4B187346;
	Sun,  5 Oct 2025 03:37:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7F63B9
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759635426; cv=none; b=caZB0uhr6Tu0xFhPZMuja/V0XizeDfcDaEQa5CKt0uuYWBVnxzvBT+JBqEUx+7BfFUzYqW1QsVUSZ2Xrdmn/0psglHvLEJUR5r4ojsDTgSnoHlj0Dr7jl95RJK4iP8rSg/p9CYuC/WPr7xc5YcZvvCxFXQT1M/rxIKygi2zOquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759635426; c=relaxed/simple;
	bh=D6HAbIdzqkvbuNcY2ua0osN6I9MdFISQrvPH6AyIdzM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=og6XRZBwIhFo33cbAtpXGlJtVCse2kxJruP0ffdM7Y7WmH1tPPIBbnHyn/G690Ywndj8tmo4PXKEe4a9YLbY+uObPF3yWn71HNDRtpKDc/6AHrwNEqmf+hTaQmEHT/OtnbZ3ZmfTLl9aTbYlFrnGuNHJ0bHyxzQ/2tMqe6ivPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8875a8663d0so413501739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 20:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759635423; x=1760240223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKlrXU4BHX9WRWuF8Cfm8jaqA9QlHDFzIlk69LCiOr8=;
        b=D23f4XmVKCkcbg31L6CaQsWuKfd7XXxfbT5SW1YzlO4C/l9BXdNOPqZeSs0rhVNHh5
         plvqTKJ/9uN1BQRBQfbNb7HKOmvxdHeDFj1eL2Nq4MgCV6brfV3UczwH90v4meq3Xu4Z
         icg745q9PQJhY7V2xmdJ/KMZL5UKsnfb0NX/gISPjwUYWBgkPD3OBnqWjAxAQFjgHHYU
         bQFubY1nL3KXAjdBmGcLHcXiaBKmh8J/6saIXfD3Jtiees2AKAuuqSYabk52/SSSTm8j
         O0/L7ilpx08hvhcWgzUigMNZl7kneienNY0zTdtQmB4ufrTS6RZZQhSA1LRxYvGxwpW3
         +V5A==
X-Forwarded-Encrypted: i=1; AJvYcCXGCsaI0iZ2Wxyk3m4LRzj86fZNl+KHqqmzHtmMVosyHxuqtJ6rDNWatoBm3QemnhOCvn+CqAZtNkEbH7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfXjF5sy6aCAmVpuhz3isrVP4GOGFRuuanj+f7I3N/VvIgUf4
	dr/ZHdWZvWDESHYXpfeCyRdGh+W3nNnvIfC2u+3dsNAbabbgRNTx+UAXJ7iQ/tuniBbH5g3Yo/E
	bckzePw6A9+WBLxq699si7NqDEkdMpdDGaoEvF/ws+3xc9/G1zBKVN9u3AdA=
X-Google-Smtp-Source: AGHT+IExp7mv4Zm46/AQQ+E8XMoYAsRJ/WLfDCAJE2KiRZM0UXEc7FpMspWtPehSZcZ8HbC8oGgwHOmb7+lev46EECZkIueiM/rJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c1a:b0:929:68d0:d977 with SMTP id
 ca18e2360f4ac-93b96b5f8cfmr792037139f.17.1759635423250; Sat, 04 Oct 2025
 20:37:03 -0700 (PDT)
Date: Sat, 04 Oct 2025 20:37:03 -0700
In-Reply-To: <20251004225256.8119-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e1e7df.a00a0220.102ee.0125.GAE@google.com>
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in
 afs_dynroot_readdir (2)
From: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in afs_dynroot_readdir

==================================================================
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir_cells fs/afs/dynroot.c:299 [inline]
BUG: KASAN: slab-use-after-free in afs_dynroot_readdir+0x106f/0x12e0 fs/afs/dynroot.c:363
Read of size 4 at addr ffff88803504a148 by task syz.0.404/7214

CPU: 1 UID: 0 PID: 7214 Comm: syz.0.404 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 afs_dynroot_readdir_cells fs/afs/dynroot.c:299 [inline]
 afs_dynroot_readdir+0x106f/0x12e0 fs/afs/dynroot.c:363
 iterate_dir+0x293/0xaf0 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64 fs/readdir.c:396 [inline]
 __x64_sys_getdents64+0x13c/0x2c0 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f820038eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f820115a038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f82005e5fa0 RCX: 00007f820038eec9
RDX: 0000000000000055 RSI: 00002000000007c0 RDI: 0000000000000003
RBP: 00007f8200411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f82005e6038 R14: 00007f82005e5fa0 R15: 00007ffd74cb1208
 </TASK>

Allocated by task 7208:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 afs_alloc_cell fs/afs/cell.c:137 [inline]
 afs_lookup_cell+0x61d/0x1680 fs/afs/cell.c:265
 afs_dynroot_lookup_cell fs/afs/dynroot.c:111 [inline]
 afs_dynroot_lookup+0x3d8/0xd60 fs/afs/dynroot.c:159
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

Freed by task 0:
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
 afs_cell_destroy+0x1e2/0x2c0 fs/afs/cell.c:524
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
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 insert_work+0x36/0x230 kernel/workqueue.c:2186
 __queue_work+0x97e/0x1160 kernel/workqueue.c:2341
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:669 [inline]
 afs_unuse_cell+0x259/0x2e0 fs/afs/cell.c:621
 __dentry_kill+0x23e/0x600 fs/dcache.c:674
 dput.part.0+0x4b1/0x9b0 fs/dcache.c:911
 dput+0x1f/0x30 fs/dcache.c:901
 path_put fs/namei.c:626 [inline]
 do_linkat+0x320/0x5a0 fs/namei.c:5028
 __do_sys_link fs/namei.c:5045 [inline]
 __se_sys_link fs/namei.c:5043 [inline]
 __x64_sys_link+0x7d/0xa0 fs/namei.c:5043
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803504a000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 328 bytes inside of
 freed 1024-byte region [ffff88803504a000, ffff88803504a400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x35048
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b026dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b026dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000d41201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 3527, tgid 3527 (kworker/u8:9), ts 87582678068, free_ts 87538643162
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
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3263
page last free pid 5935 tgid 5935 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 discard_slab mm/slub.c:3301 [inline]
 __put_partials+0x130/0x170 mm/slub.c:3848
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4946 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 kmem_cache_alloc_node_noprof+0x28a/0x770 mm/slub.c:5297
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1383 [inline]
 netlink_alloc_large_skb+0x69/0x140 net/netlink/af_netlink.c:1186
 netlink_sendmsg+0x698/0xdd0 net/netlink/af_netlink.c:1871
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x4a0/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803504a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803504a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803504a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88803504a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803504a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         6093a688 Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171a15cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f142ebe84501b0b
dashboard link: https://syzkaller.appspot.com/bug?extid=ae8ad52680705c162471
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1485c458580000


