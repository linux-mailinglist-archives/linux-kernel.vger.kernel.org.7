Return-Path: <linux-kernel+bounces-786560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB7B35C96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3723B66DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7462BE653;
	Tue, 26 Aug 2025 11:34:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1C2135B8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208047; cv=none; b=otMXN6dxjRuXmF41ryHp91lyAK6oSdtSaqqc4QUe5dghGHI1sywYgsRaoL7uts3vcgm+/vuJK9URdssOppRzYQWKovL/eUsqpPWBkNxAn0MZLwhMcZ1Kb/cabL50udtIPKIb0/0QHPNuijQrz4joWbeSRXTMTAq1pwRh1BEa0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208047; c=relaxed/simple;
	bh=w/ScZhrb7vv1SXZYqp5jvRNCSMsKR8gwrZrZUNlK/rQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rZr7EFN5Pnce2LGLccxbYzAxCe9LtSYxlsDfVbt7mLOUvutLmcpuj8u1NIr1HSanpPWrJR2ETfFGB/nwMAx7Tc0Kjnyxv2EVsZWQ7JW2MbC6q663/d0AMrGs4k0yC8+9divaHRnkec+WhH3UU/j0JTz/5flNY5afPtjMDrhOkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ec58544f79so60739135ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756208044; x=1756812844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bydyu6okUI7gg2XGRo1n53i2dD45HPrzEKAlgwMGK1g=;
        b=G8mKDASkwoskEdPDq8WELAdi6bNxiBv2AkWrSlI+YgyW7h+n67VjegWy8azJjzSV7z
         j+PY2nAQiY0CCysnj3t8kDtBZFU35ctTwPsRqcs6wN/X6C/TmaVVGHjuwZ1mU7/1wwVM
         2KSzF12DBoYWt4cnwkozIN/JoHg3O/lbpxJNDh7p7id5AMzhUSHKW6ufBTEGF/CPUTxa
         B8i2ZOu8p2AcbJhvOkTFsS5O5BK3zIGXlnatD2zbD6cJ5ixnNfZVN77pLPsa9kbAuUjO
         /Fpe2HYlJ4WFHeEOQEZ+29IzGejxQMCM95ejlmISfIwQnUrvOY1yOs/c3G/ctU9OddHa
         c8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWuvZ7yxOlag9M+47y2zmeDdaBufVZd0KCbtlytBupjlFehuDiLWOQn/Ky/Y9OZe9kgYyr2my00rjcn/zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQeRjrcUOIx8ac865cQ57fLXc69/C5DV9/GUdzB+lc3KGyydY
	xzFZOr/soSUAPHWvIUTtsjb1vzPBa9/NwsfUBIqZvf7gzZ5EzgKFQkcljxnYeHveKcjU4vmsbLh
	09+90fOfsHqhpxJkRtUv0CuL5IlHSVBcb3UbqvHyqnRIK4xrcNO/7EspdBPs=
X-Google-Smtp-Source: AGHT+IEcCwTQR57K4aC2h0L5BWc7iXtsROTJJG2QX/M4BEWXPz6w3ieI1k/AYM1n5l7nymyzsEuMw5Ubt4Ld9dsFIwUb9ygCau+u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:3ed:4f7a:9065 with SMTP id
 e9e14a558f8ab-3ed4f7a9383mr74462245ab.28.1756208044515; Tue, 26 Aug 2025
 04:34:04 -0700 (PDT)
Date: Tue, 26 Aug 2025 04:34:04 -0700
In-Reply-To: <tencent_4D33BD9E141B044B6F1BD425FEBA00BB1D08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad9bac.050a0220.37038e.00bf.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in __xfrm_state_delete

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:980 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:560 [inline]
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x666/0xca0 net/xfrm/xfrm_state.c:830
Write of size 8 at addr ffff888042050ce8 by task kworker/u8:4/74

CPU: 1 UID: 0 PID: 74 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __hlist_del include/linux/list.h:980 [inline]
 hlist_del_rcu include/linux/rculist.h:560 [inline]
 __xfrm_state_delete+0x666/0xca0 net/xfrm/xfrm_state.c:830
 xfrm_state_delete net/xfrm/xfrm_state.c:856 [inline]
 xfrm_state_flush+0x497/0x7d0 net/xfrm/xfrm_state.c:940
 xfrm6_tunnel_net_exit+0x3c/0x100 net/ipv6/xfrm6_tunnel.c:337
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1834
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2354
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 xfrm_state_free net/xfrm/xfrm_state.c:591 [inline]
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:618 [inline]
 xfrm_state_gc_task+0x52d/0x6b0 net/xfrm/xfrm_state.c:634
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888042050cc0
 which belongs to the cache xfrm_state of size 928
The buggy address is located 40 bytes inside of
 freed 928-byte region [ffff888042050cc0, ffff888042051060)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42050
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88802229adc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88802229adc0 dead000000000122 0000000000000000
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001081401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7523, tgid 7522 (syz.0.524), ts 112083797676, free_ts 111991511473
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1834
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2354
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 49 tgid 49 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 stack_depot_save_flags+0x436/0x860 lib/stackdepot.c:727
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x4f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 mempool_alloc_noprof+0x1a4/0x510 mm/mempool.c:406
 bio_alloc_bioset+0x241/0x1110 block/bio.c:555
 bio_alloc_clone block/bio.c:866 [inline]
 bio_split+0x110/0x4a0 block/bio.c:1687
 bio_submit_split+0x96/0x5e0 block/blk-merge.c:115
 __bio_split_to_limits block/blk.h:402 [inline]
 blk_mq_submit_bio+0x166a/0x2520 block/blk-mq.c:3164
 __submit_bio+0x207/0x5a0 block/blk-core.c:635
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x505/0xb50 block/blk-core.c:751
 ext4_io_submit+0xe0/0x150 fs/ext4/page-io.c:404
 ext4_do_writepages+0xbba/0x4610 fs/ext4/inode.c:2881
 ext4_writepages+0x205/0x350 fs/ext4/inode.c:3025
 do_writepages+0x32e/0x550 mm/page-writeback.c:2634

Memory state around the buggy address:
 ffff888042050b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888042050c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888042050c80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff888042050d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888042050d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         3c149179 ibmvnic: Increase max subcrq indirect entries..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fae462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e79c42580000


