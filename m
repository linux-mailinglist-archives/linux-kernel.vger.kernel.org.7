Return-Path: <linux-kernel+bounces-787991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DFB37E85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA5203497
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1B341646;
	Wed, 27 Aug 2025 09:14:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE5274B41
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286046; cv=none; b=VCBOpzIqGNocqb+MKF2M807+MyThGbm89/k2PjWQzDs9mfuz24jcKYYZt81KMWZJcd/5h97vVoL8gcMkh0dXh3LDAFcKkRDAlssQbI6eJBTSWbtHWpU5cuogsq3RNtnUgm0GxLx+EnYFtgIljKRb8h27WP793JHJv12fhpBmxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286046; c=relaxed/simple;
	bh=axK662Cl91N/Du8VjOS65GLZ3Mkwz+OwgXeZzdLMFbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LfPbGbKhaWs+yDsqJURq3nqigM04LvtW8w6k/sJuJfareMXX0eob2RM77y66MSFfbObNFZaNajeh83f1lt9M9j38ADTaY6KQp40OKYK2XG72TC6OAR5VBt+BUkQJjHMI/XzXK2rkvZTBXfgft6RR31FiLgXEzleVI0Es5bhn8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eb91f3f269so12305415ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286043; x=1756890843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCqRLXXDP7n0vd3/+onxLO31GZNxXlhdFlANft07Tew=;
        b=JxzHU+6FXYZST6A2iqvalvho2MbN7b9FjoC6DEiotIQhN1P+lc0mD3s3RyTrfd/CPc
         926vlRwfuIPeJgJ4vSacOKPK8pkVaMXESsrDcosSEybXmMY90L45kW9cjSkzUHfnDetD
         /q7iBzHh7Iu65nTzYm+uN1ROG/qzbkEfyvHFzxDpJYeWXkFCXC0yStBsx4mYz4s0aHxH
         xNMdY2uD6Z+rH6UjG6br6Mh/l3qCRDFAh6m+o7pvSsiuRg8b2zQGqckhjK2YzjBmx4yj
         q1Uk3Jtqa8GyvmuShh42P4K0aciTurnVQ/20wcc+2ZypdX5+mnPhD5NFnZKVhKGlngGg
         36lg==
X-Forwarded-Encrypted: i=1; AJvYcCXW5AyNi/kLWAnxQKUqIxVKyPLum2dfFbpbAD/EvZAs61jqwF9OEcxt0uSfH5Ya9/nekrw4k3POomKBedY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4qy80T7XRKcikQUSjRYw2MLdJPzKH0Wp8CZyh/ARmIsaWM7E
	pRv5T5z0gWt5N9H3Cq3eTyDU23ApYLdgzyrBsQl0HoYm9spAka73ke5n6Kcqrm6ddkVQafzoRVk
	7FceI7TG+LseJc3DbF55bKM+ceKhLrFNOLzAoAK0Q6DRgBPzIytzeE052/t0=
X-Google-Smtp-Source: AGHT+IFEIsxZjBI4WFcfL9g+dUFZXP+lAZmxhWhpOmrhCQyu4hxtsSmaGeRiOzdRCUqkbpU/a/7XMRvR7a06++MS/LyCCyNZsO9S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4519:b0:3e5:8113:35e1 with SMTP id
 e9e14a558f8ab-3ef088588a5mr66509105ab.4.1756286042982; Wed, 27 Aug 2025
 02:14:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 02:14:02 -0700
In-Reply-To: <tencent_D22CE56CB09408EBB2ED76CC3479F66C980A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aecc5a.a70a0220.3cafd4.0017.GAE@google.com>
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
Write of size 8 at addr ffff88805af9bba8 by task kworker/u8:6/1110

CPU: 0 UID: 0 PID: 1110 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
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
 xfrm_state_flush+0x45f/0x770 net/xfrm/xfrm_state.c:939
 xfrm6_tunnel_net_exit+0x3f/0x100 net/ipv6/xfrm6_tunnel.c:337
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

Allocated by task 7551:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1833
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2353
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
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:618 [inline]
 xfrm_state_gc_task+0x52d/0x6b0 net/xfrm/xfrm_state.c:634
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88805af9bb80
 which belongs to the cache xfrm_state of size 928
The buggy address is located 40 bytes inside of
 freed 928-byte region [ffff88805af9bb80, ffff88805af9bf20)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5af98
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b325140 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b325140 dead000000000122 0000000000000000
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea00016be601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7495, tgid 7494 (syz.0.502), ts 107639354526, free_ts 107636640273
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
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1833
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2353
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 6353 tgid 6353 stack trace:
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
 anon_vma_alloc mm/rmap.c:94 [inline]
 anon_vma_fork+0xde/0x500 mm/rmap.c:360
 dup_mmap+0x9eb/0x1ac0 mm/mmap.c:1797
 dup_mm kernel/fork.c:1485 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1537
 copy_process+0x1706/0x3c00 kernel/fork.c:2175
 kernel_clone+0x21e/0x840 kernel/fork.c:2605
 __do_sys_clone kernel/fork.c:2748 [inline]
 __se_sys_clone kernel/fork.c:2732 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2732
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805af9ba80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88805af9bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805af9bb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88805af9bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805af9bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a85ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17949462580000


