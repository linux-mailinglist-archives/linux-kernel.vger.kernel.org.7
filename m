Return-Path: <linux-kernel+bounces-787585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB3B37849
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572ED1B251B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5D52882DD;
	Wed, 27 Aug 2025 02:44:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3D277C93
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262645; cv=none; b=QgrUxSkJM3bUpzLag29ARBPunrso+NQ2qo8N3H6fxgkFMkMA2ZmvTc/Jo1Hl+1JYEhFf3vbmEMvGsBAJWWKbncDdHemNvTE7rwUdSeH/iodPEHwfnX4xgjRTHtmJpYpFeoh8RoBRd/3DBZ8km0bEgb80nrZEQs2V98GkTaDRvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262645; c=relaxed/simple;
	bh=4W61xe7d8ppxXDAmFhTyiUCPGm66AEOpv/XQJhawoVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RpvXh6OTjRk2zqkrVqN32nLbYWXjnxlNpg8c20/w9DkdDYc5dRy3evobBVNWmIWuA1ea3vofVJvaGcPOT9czOD+BHKf0K47vf9dx40XiaBHpLvQSn5EL2+OvB+iW8u6Nmrw7tExD3q/0KRzmzJWR61AwlvRPbOQL63Tso5krVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432ccc4f9so1453715839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756262643; x=1756867443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rusYBlZTlHJ48pN4+JhzpB3VEgzpuBI89tsiubMjRE=;
        b=TyYx94YPxyEC4LXSnS10hBU8G3HelC84RHiStmkAy5foUhQ4EekkgxOOdA+TSAJFjZ
         ThiFdZWz5vE7mHGl2cpYERPhS6K5M+yn/FBD7/bjiVxl1ZTasGxFvc1y91CPLq4RiI+g
         4Bhq/Gf1TuFKRbzNqOEu1wiSHtI67AhmqsivYPkjuevh4i5qs+B7f9oirMQvl0xkNJNe
         7qPYN0j/cGWyGFCc2VxnZbtkv1w45C+ExtzmnBGvuCq3fStxRJua+9rS8fokJ8keORtS
         uu+1Q4csXerUQZaQOFhvZAMh3R3DB/bNn1lH/Q7h1SE5U+T39oPaf99/HspSJuImBakf
         cEOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZiHaEaFhB7QII06E287PykaxyA7JkMgRE32NfVeh8YkkoJnc90HM1I3NnAC+cgwyPSeS0z9AAGV7sKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSb2b3dprMg4vH/W6ioK0yUpoHpHc7bfl8eqNy/3Ieffxgx8rf
	XGAhC0FUikC2ExUL75MvywOKJXzCYID3esuTOEr6FnPyv41aF0tmX2bUSVv0G170HjbF4VOGe51
	S/jed5/u9unx6EkJXCIBLturH0Q8VTxUEcUv9maLTP+LNJbfR/egdWwrN2OA=
X-Google-Smtp-Source: AGHT+IELSXy6LHi5edC9Depegbw2IQSzZqzVOEZq7U48KcmfNh8ecS30tBTqZJ+FAUzKUIiK7TKfvI8tvewg3OfYm1/vL6y0rCj/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3309:b0:3eb:1211:8738 with SMTP id
 e9e14a558f8ab-3eb121187c5mr158733865ab.21.1756262643127; Tue, 26 Aug 2025
 19:44:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:44:03 -0700
In-Reply-To: <20250827004037.5728-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ae70f3.a70a0220.3cafd4.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in __xfrm_state_delete

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:980 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:560 [inline]
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x76e/0xde0 net/xfrm/xfrm_state.c:837
Write of size 8 at addr ffff8880627eb768 by task kworker/u8:3/49

CPU: 0 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
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
 __xfrm_state_delete+0x76e/0xde0 net/xfrm/xfrm_state.c:837
 xfrm_state_delete net/xfrm/xfrm_state.c:863 [inline]
 xfrm_state_flush+0x44a/0x750 net/xfrm/xfrm_state.c:946
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

Allocated by task 10050:
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

Freed by task 6028:
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

The buggy address belongs to the object at ffff8880627eb740
 which belongs to the cache xfrm_state of size 936
The buggy address is located 40 bytes inside of
 freed 936-byte region [ffff8880627eb740, ffff8880627ebae8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x627e8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b3c9280 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b3c9280 dead000000000100 dead000000000122
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea000189fa01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 8688, tgid 8687 (syz.0.1073), ts 121523868095, free_ts 121487674016
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
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 8685 tgid 8685 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __slab_free+0x303/0x3c0 mm/slub.c:4591
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2918 [inline]
 __do_sys_symlinkat fs/namei.c:4772 [inline]
 __se_sys_symlinkat fs/namei.c:4769 [inline]
 __x64_sys_symlinkat+0x7a/0xb0 fs/namei.c:4769
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880627eb600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880627eb680: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff8880627eb700: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff8880627eb780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880627eb800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14fa9ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137977bc580000


