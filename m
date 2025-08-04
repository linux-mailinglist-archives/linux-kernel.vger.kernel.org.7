Return-Path: <linux-kernel+bounces-755280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A3B1A404
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25A57AA494
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E525A350;
	Mon,  4 Aug 2025 14:02:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95327A927
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316126; cv=none; b=JFMb69PtzkzyPIJr/Fw4ipE2lCLOhD42GwSii/yYtl0wWL/0snoG03gur8cmRUrhYcs70MtQztkPovOTyIdL7ssHafrJ58zf0ZRGpRKJnHu0yLERb926eagwltAGwJClTO7i0qMizsjE8+Z1KpbuRT74m45aYvqowdHLvaMi4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316126; c=relaxed/simple;
	bh=0NeSbLmYrBhK7yKNUrRG+2ZEmIIEPdp/xAKvWHykhWE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PER1FrXgeQgJ79SCzdHsfrjxFQvRP5Sl2JEQt2emfVuZtQV3km5cdeaYtxbqrQMkZPSwNU6awH8Fubu1VcUpXl8z5jR2I0weK0V0uyXufdOTVnR1Jjwt+e5Px6Qx94y0CuYh499f31F2VFfSrD+ZSLZdw6n/7dC5/rc6Tu78i1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3c9a3f22aso83113295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316123; x=1754920923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k22eDlmAAiBuWbmfsP/Ce1eXSkx0+tRVEYrw5kMn89g=;
        b=Mr1Ip/MOaJiPdflf2XtRh3svJS0XeTIctx9wC64kmXhz4Ix1YFmKXL5ludpO1KFqY0
         5zB71J1+DvyR2+q++dy2MCJjhqMlMRvG6RU85ckB9AnwsPvdMx38B137tC9yM5/jadZx
         xrjllQ8kCi5bOnSTxIhhdWrhSaR3n4H1aDT3B3djGB98PG0XYTqgHwpFpY+E08XjIFpO
         IlrXcMMe7m/mlJRwPPQqMRGG24jMZBY69HFjYQvSnTkuFNGxQnis9vZ13ja3pjtzdpo/
         Xlv1+EIxZ20zZ4a3WzFZgKXw7zILcGgTdvzK468XCjuMyU7/Cfyh8yTXbDf9e9qXTK8u
         j14A==
X-Gm-Message-State: AOJu0Yz8TPSWa2KqMwxqdce00MhgUyPjtGV8hE5nheicDFUzbE6D8lQj
	aRsFjx2PFr4n6XHcY+RGAojFwOk9EwvT8tDakdAiw+ukXO1EA64xQUfEzQJgXEJJGYiA7/k/mki
	OqJnTisuhZ3G48qkWx8b/rksgDfS+a9RXJkXnmZejkXSmdGTd3UfmHlDvU9A=
X-Google-Smtp-Source: AGHT+IHrkgEVBdxHaAYlcK2GSORTEi3AlIMQ4SkIWDEwCR7dhJMWdI2vz5/kw79o1jrzhCyQlxBGuuN7KiWBhvDDDnUBqAmmXu32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3e3:d1ef:83f9 with SMTP id
 e9e14a558f8ab-3e416116d3fmr185129485ab.6.1754316123582; Mon, 04 Aug 2025
 07:02:03 -0700 (PDT)
Date: Mon, 04 Aug 2025 07:02:03 -0700
In-Reply-To: <CAJuRXzCYr1t_hQ0t-B-OXVc-+Lg1f73PN5BMJEk-mzpB6FUpxA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890bd5b.050a0220.1fc43d.000c.GAE@google.com>
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
Read of size 256 at addr ffff888144ebb860 by task syz.0.17/6639

CPU: 0 UID: 0 PID: 6639 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT(full) 
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
 fbcon_init+0xd77/0x1900 drivers/video/fbdev/core/fbcon.c:1150
 visual_init+0x31d/0x620 drivers/tty/vt/vt.c:1019
 do_bind_con_driver.isra.0+0x57a/0xbf0 drivers/tty/vt/vt.c:3915
 vt_bind drivers/tty/vt/vt.c:4071 [inline]
 store_bind+0x61d/0x760 drivers/tty/vt/vt.c:4143
 dev_attr_store+0x55/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c4/0x1150 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f36be18e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f36bef23038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f36be3b5fa0 RCX: 00007f36be18e9a9
RDX: 0000000000000081 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f36be210d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f36be3b5fa0 R15: 00007ffe05ac9a98
 </TASK>

Allocated by task 1100:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_node_track_caller_noprof+0x221/0x510 mm/slub.c:4347
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:601
 __alloc_skb+0x166/0x380 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1788
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1899
 add_grec+0x112a/0x1680 net/ipv6/mcast.c:2037
 mld_send_initial_cr.part.0+0xe2/0x260 net/ipv6/mcast.c:2282
 mld_send_initial_cr include/linux/refcount.h:291 [inline]
 ipv6_mc_dad_complete+0x22c/0x2b0 net/ipv6/mcast.c:2293
 addrconf_dad_completed+0xd8a/0x10d0 net/ipv6/addrconf.c:4339
 addrconf_dad_work+0x84d/0x14e0 net/ipv6/addrconf.c:4267
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 1100:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 skb_kfree_head net/core/skbuff.c:1048 [inline]
 skb_free_head+0x114/0x210 net/core/skbuff.c:1060
 skb_release_data+0x776/0x9c0 net/core/skbuff.c:1087
 skb_release_all net/core/skbuff.c:1152 [inline]
 __kfree_skb net/core/skbuff.c:1166 [inline]
 sk_skb_reason_drop+0x129/0x1a0 net/core/skbuff.c:1204
 kfree_skb_reason include/linux/skbuff.h:1275 [inline]
 kfree_skb include/linux/skbuff.h:1284 [inline]
 ip_tunnel_xmit+0x8e0/0x37b0 net/ipv4/ip_tunnel.c:869
 __gre_xmit+0x8bb/0xc00 net/ipv4/ip_gre.c:488
 gre_tap_xmit+0x3b3/0x630 net/ipv4/ip_gre.c:776
 __netdev_start_xmit include/linux/netdevice.h:5215 [inline]
 netdev_start_xmit include/linux/netdevice.h:5224 [inline]
 xmit_one net/core/dev.c:3830 [inline]
 dev_hard_start_xmit+0x97/0x740 net/core/dev.c:3846
 sch_direct_xmit+0x1b2/0xcf0 net/sched/sch_generic.c:344
 __dev_xmit_skb net/core/dev.c:4102 [inline]
 __dev_queue_xmit+0x13c7/0x43e0 net/core/dev.c:4679
 dev_queue_xmit include/linux/netdevice.h:3355 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0xe98/0x2020 net/ipv6/ip6_output.c:141
 __ip6_finish_output+0x3cd/0xff0 net/ipv6/ip6_output.c:215
 ip6_finish_output net/ipv6/ip6_output.c:226 [inline]
 NF_HOOK_COND include/linux/netfilter.h:306 [inline]
 ip6_output+0x1f9/0x540 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:459 [inline]
 NF_HOOK include/linux/netfilter.h:317 [inline]
 NF_HOOK include/linux/netfilter.h:311 [inline]
 mld_sendpack+0x9e9/0x1220 net/ipv6/mcast.c:1868
 mld_send_initial_cr.part.0+0x1a1/0x260 net/ipv6/mcast.c:2285
 mld_send_initial_cr include/linux/refcount.h:291 [inline]
 ipv6_mc_dad_complete+0x22c/0x2b0 net/ipv6/mcast.c:2293
 addrconf_dad_completed+0xd8a/0x10d0 net/ipv6/addrconf.c:4339
 addrconf_dad_work+0x84d/0x14e0 net/ipv6/addrconf.c:4267
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888144ebb000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 96 bytes to the right of
 allocated 2048-byte region [ffff888144ebb000, ffff888144ebb800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x144eb8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88801b842000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88801b842000 0000000000000000 dead000000000001
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 057ff00000000003 ffffea000513ae01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 3818223817, free_ts 0
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
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 acpi_ds_create_walk_state+0x78/0x250 drivers/acpi/acpica/dswstate.c:518
 acpi_ps_execute_method+0x253/0xb30 drivers/acpi/acpica/psxface.c:134
 acpi_ns_evaluate+0x76c/0xca0 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xda/0x4a0 drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_STA+0x87/0x1a0 drivers/acpi/acpica/uteval.c:223
 acpi_ns_get_device_callback+0x23c/0x500 drivers/acpi/acpica/nsxfeval.c:723
 acpi_ns_walk_namespace+0x405/0x5b0 drivers/acpi/acpica/nswalk.c:233
 acpi_get_devices+0x137/0x160 drivers/acpi/acpica/nsxfeval.c:805
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888144ebb700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888144ebb780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888144ebb800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff888144ebb880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888144ebb900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10eb4042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb654b6c0c63cccc
dashboard link: https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

