Return-Path: <linux-kernel+bounces-786513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17432B35AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB52F7C1879
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D72BE620;
	Tue, 26 Aug 2025 11:11:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4020B7EE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206667; cv=none; b=VxBQWp9wQ3c7ViFWWwFNbTvD35jqhLkgjQ+ep9PyvhHIAuwf/XIlKtKg3vu54778ZKtuuVwhb0pFu5YyQ6zTycWo5EtDP49fgZ227zN6naLgbNQuiD5kk83VWZ5OYwAW76j06rFvrAPo4DU7yIw2zMQuyDy5CnupuVx4TlZAx+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206667; c=relaxed/simple;
	bh=YyS7QbW8GX9QaYqySg5CNnbatbKAuPJDwcybjfO4MsM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uaH87xwlVoC1nMHB0LM/67ksWLgx11xvHXkwy7XsNO2UwVmgabzo5edSv9hjjPloD66OHvFYS754DmXaEYqENRMi4r9FOJnqJtoRF0YGjtxvyMsqY1sj5IAvlgrCjTvMgqUweWd6NhFpY2ICXe8rmQiQPFLbMBwk/K3mgKRjC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3eab737b99cso28195605ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206664; x=1756811464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YkBKOKtBKlBLJ4FQY/fY++A8VjTEJzruEdGiVF99eg=;
        b=fejJXfOEFJs0Q+elAt9iWp+coLOQliZBTTOMMLaN4zv5xrA81GVpvAFVx5Z9g6Yas+
         0oBlJTy3tFEfF17nEPGbFrjJ4Pny+0wXsXFD/AsZJ5ITYxPIPgAzHsdtHpd9Ld4L0C8C
         6CxGh7BZ7Rd0Qqx+a9qWdd6Snf99JTTmd0xOXuqWJwejxB4A5mEqz7fUlrxm7WuW0doJ
         icUZsI6EAgcxJOGGtx0FpSo5Mijf77Qyn2btXvRqUsYVDWcGMMTvOvKjP/ZIuvdmtPe7
         onCcihZPUCDC/UXFbxkv/QNd3kfh7EESc7MxzN6SJb83hMKts6C6sOD0HP1bP1wGf3wT
         71YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaUVMSuAuS2lOs3gN4XdBD6d4dy0O3mEdNNooLvzGQCQkIRKjfnsr0Ru/f+5gFTGR/1QINPnzCNJom1EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6Wz2eE5UqrZzG1jo49hAeyt48agOm254ZGg+57DpzZa+8Ol7
	f67qEC3uEwssH8SN+lQhBSdtxqj6M4bkQuIE6mtOucxeKi84HnEfmIorJS14Z9EFsFnOmhOzATW
	IRHCSQ1dfjB50UnPAFV+7M9JYpAD/jzn2dYMn1ljKZMfpxD3lTLmSSKhJppE=
X-Google-Smtp-Source: AGHT+IGh9gGjbVpBQ2cZDeFRtW1RQM8kkTEkce5pScldvjdDLDA24GPAOVr6SFpPDibkcjMNTKEyi+MOIIKVYsy784+DDNVFwbol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3e9:e4ca:4aa8 with SMTP id
 e9e14a558f8ab-3e9e4ca4fe2mr193860395ab.25.1756206664216; Tue, 26 Aug 2025
 04:11:04 -0700 (PDT)
Date: Tue, 26 Aug 2025 04:11:04 -0700
In-Reply-To: <20250826073149.5659-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad9648.050a0220.37038e.00bd.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in xfrm_alloc_spi

==================================================================
BUG: KASAN: slab-use-after-free in xfrm_state_lookup_spi_proto net/xfrm/xfrm_state.c:1714 [inline]
BUG: KASAN: slab-use-after-free in xfrm_alloc_spi+0x570/0xf30 net/xfrm/xfrm_state.c:2595
Read of size 4 at addr ffff88807bb0cd84 by task syz-executor246/14912

CPU: 0 UID: 0 PID: 14912 Comm: syz-executor246 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 xfrm_state_lookup_spi_proto net/xfrm/xfrm_state.c:1714 [inline]
 xfrm_alloc_spi+0x570/0xf30 net/xfrm/xfrm_state.c:2595
 xfrm_alloc_userspi+0x70b/0xc90 net/xfrm/xfrm_user.c:1873
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
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
RIP: 0033:0x7f06f4e4ba79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8ce44c18 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f06f4e4ba79
RDX: 0000000000000000 RSI: 0000200000000440 RDI: 0000000000000003
RBP: 000000000007a151 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8ce44c2c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 12219:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:737
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1839
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2359
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
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

Freed by task 43:
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
 xfrm_state_gc_task+0x53b/0x6d0 net/xfrm/xfrm_state.c:637
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807bb0ccc0
 which belongs to the cache xfrm_state of size 928
The buggy address is located 196 bytes inside of
 freed 928-byte region [ffff88807bb0ccc0, ffff88807bb0d060)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bb0c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888140aa6640 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888140aa6640 dead000000000122 0000000000000000
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001eec301 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 12205, tgid 12205 (syz-executor246), ts 469927494442, free_ts 450521370354
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
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:737
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1839
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2359
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 10426 tgid 10426 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __folio_put+0x21b/0x2c0 mm/swap.c:112
 page_to_skb+0x738/0x930 drivers/net/virtio_net.c:941
 receive_mergeable drivers/net/virtio_net.c:2496 [inline]
 receive_buf+0x45f/0x15e0 drivers/net/virtio_net.c:2634
 virtnet_receive_packets drivers/net/virtio_net.c:2992 [inline]
 virtnet_receive drivers/net/virtio_net.c:3016 [inline]
 virtnet_poll+0x1fbc/0x2d80 drivers/net/virtio_net.c:3110
 __napi_poll+0xc7/0x360 net/core/dev.c:7506
 napi_poll net/core/dev.c:7569 [inline]
 net_rx_action+0x707/0xe30 net/core/dev.c:7696
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 xfrm_alloc_spi+0xae6/0xf30 net/xfrm/xfrm_state.c:2620
 xfrm_alloc_userspi+0x70b/0xc90 net/xfrm/xfrm_user.c:1873
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346

Memory state around the buggy address:
 ffff88807bb0cc80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88807bb0cd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807bb0cd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807bb0ce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bb0ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         3c149179 ibmvnic: Increase max subcrq indirect entries..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d9f862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130deef0580000


