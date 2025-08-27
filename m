Return-Path: <linux-kernel+bounces-788022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A1FB37EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8020C1BA339D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A428506C;
	Wed, 27 Aug 2025 09:31:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341B278768
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287065; cv=none; b=Unuvdp3OJtXeDl7StrXC0rkZms1kFMsjatcmWyaZfHZj35m4jOWdGgfofk8mtxcSLfaG3eHM4SvuhoxKb1k1yp97pde9g7Cm6XajSHwIqv2+HJkn8T4f14G+SqN+OHuex7+PVbODu2JOckpy05EQzARh+DclRl6gQxMhhaU7nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287065; c=relaxed/simple;
	bh=W8TtU/zXTLVzgfz22JfszRPsL8n/zBNtOYgCj7XJENg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i6hQXm38c+86UeADZ3y6C1cFU/ky+YfdnzATRlTBg3p6u+5wmHEcjbpUlsrLNCNvbHdnkU7pn3385wEa7Gw60IrWe/xCV/3Yo9u6r1Hc9MbqJDUmZt61kqusBMPfmtlQ+HjWsLdUz7AYYUMZEf9ZGLdeSOPow+dg73lgk0HfiUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-886b489984cso1574009639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287063; x=1756891863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prjsY4CkzqQ1cfw+ombVM3HQjd03dY1CLKca1VAQqoY=;
        b=pqyYF0p3gGHgTq/BIpOCHzuGJcTLxRvPMo3GURsUSvN7GiSWSD/E+X/oHeHJpZK2wm
         Bhyj44roGP+ZkA91lvWW4GYF5cn2XVUIQFeYYCtJEEYge2oUgpy5L03rMAevJyZj1Iif
         AkIBnVYZSyQI453wYeIb0AAwXaDxMuU+M92+1u+mnZUdx5+/jDmK7tpJys/XDoTLIoVn
         BNVe5EoVtvzoXnMfBacU36WARkz+L1X1JWOnLr7JIJ9Wkz5pSYN5qcYsU7dx0BFnMzs2
         EODsa9RP5JgTw1bqnaANlNh++lHkrB0dLJ2csh19RXJaaRL6smZeSb42ic20UDfiDA/r
         JyXA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Dfa7XUrMGtrSeeuNvQf3RyMb3HAeMqFyIrKHLEj1fyPLh684wkJV3liD8ckoSYPYNWu62sfe4/O5VeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7njXVl7FJ2HtyDM7ioduNgwZU5yx+bIDuM8C2iY/Tbj/oTzX
	obWp7vkiz5R9Fy/B6IZ7NKMVOnQWMvBwwRXmudR/Apo40mUuJJziROIoE5GKZTNKYxzwQkWMRsb
	N3cxhxjoPRe7bGVnXERrD0kzaAZ3jsLYPFXL9TkNlcMltQa9YVFsuKVOTyVo=
X-Google-Smtp-Source: AGHT+IEQXLutPve9mFOWmIxq7RQaz2mz0KWjVang1R7THyeYHv8cGEq3Tq00PJQh0CmazDzpPMNJp5mDHNBSa35X/TRFxYw4DceS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:3ee:7c7a:c89c with SMTP id
 e9e14a558f8ab-3ee7c7acbedmr77922485ab.14.1756287062909; Wed, 27 Aug 2025
 02:31:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 02:31:02 -0700
In-Reply-To: <20250827083923.5840-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aed056.a70a0220.3cafd4.0018.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in xfrm_state_flush

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in xfrm_state_kern include/net/xfrm.h:1534 [inline]
BUG: KASAN: slab-use-after-free in xfrm_state_flush+0x2e8/0x770 net/xfrm/xfrm_state.c:935
Read of size 4 at addr ffff88805b356418 by task kworker/u8:4/59

CPU: 0 UID: 0 PID: 59 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 xfrm_state_kern include/net/xfrm.h:1534 [inline]
 xfrm_state_flush+0x2e8/0x770 net/xfrm/xfrm_state.c:935
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

Allocated by task 7705:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:734
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1840
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2360
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

Freed by task 10:
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
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:619 [inline]
 xfrm_state_gc_task+0x549/0x6d0 net/xfrm/xfrm_state.c:635
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88805b356200
 which belongs to the cache xfrm_state of size 936
The buggy address is located 536 bytes inside of
 freed 936-byte region [ffff88805b356200, ffff88805b3565a8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5b354
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888144e94500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888144e94500 dead000000000122 0000000000000000
head: 0000000000000000 00000000800f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea00016cd501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7675, tgid 7674 (syz.0.601), ts 110112755349, free_ts 102648833516
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
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:734
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1840
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2360
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 6809 tgid 6809 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2753 [inline]
 __put_partials+0x156/0x1a0 mm/slub.c:3218
 put_cpu_partial+0x17c/0x250 mm/slub.c:3293
 __slab_free+0x2d5/0x3c0 mm/slub.c:4550
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 security_inode_init_security+0x107/0x3f0 security/security.c:1829
 shmem_symlink+0xd9/0x510 mm/shmem.c:4163
 vfs_symlink+0x143/0x2f0 fs/namei.c:4730
 do_symlinkat+0x1b1/0x3f0 fs/namei.c:4756
 __do_sys_symlinkat fs/namei.c:4772 [inline]
 __se_sys_symlinkat fs/namei.c:4769 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4769
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805b356300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805b356380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805b356400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88805b356480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805b356500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17406c62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1399a462580000


