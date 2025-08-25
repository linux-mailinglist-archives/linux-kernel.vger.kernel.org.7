Return-Path: <linux-kernel+bounces-784881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF47B342E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5BC3B3CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB952F1FDB;
	Mon, 25 Aug 2025 14:13:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DA38FB9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131188; cv=none; b=no/R8ktS69vagPYszSID1Wojq6dkFh6cKzLsIOW7r2DN1B05q6sTru/rD1++9BPlOvztZQ7Kmc4JaJj9QzREyPFCKGHT+XiJ8P+iFtDpi5VSl5vdK+KuUi52g3gDL7w24gmEwgcsnPNDJkLUz2pynILEW8RDSLmgy/Hy2lD8zlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131188; c=relaxed/simple;
	bh=XObcHIBcAU4S2c2poKWxUz6eZFrO6qeztzCMaS8FWlw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J7czeG6p7vwC0BQN77Vmu6gjNbeNREqDtX7/XVVsbANQn1NckxN6KP7JtTlSlaSBrQfR2QdCRLa9kskyha9x7v1NvQTvTy02gjYpIbzxvkgH74Y/K7bE/ltQeuLuqBe/xBuGlPxPGrPPikS4JIeg8TKS+5oD+ycdNG13o2fFWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432cccc80so401323239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131185; x=1756735985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7KN8WemOuesAMMwft4TEfaVR0jm74Tz9aIluwkn0jI=;
        b=W+0wwFdaD0hzifvUvU0HS7RBVcb0kbGpXVxiI9cfK7q4Bd/Opf5eanFK6BXLWwx+pT
         6UdYFYGQxCBneZoxBEOuM38GcZE2YUWv1uXe2GBiG9wHuxAmtIINGIsgq2QA+gD+jsR6
         blt8uZLc6WJ5P4yWkYsmWDO7pn//Lim50WJixFaA4EfucWHmmMtlMj6Ah+BqFyjv8sAj
         OmkX+H6Uer8iUV8KctROrpRWQo4Vkzoq7CtSCoinwTGJ7YO/6d5kCSudsj7UkeY9+lE3
         TiODhTBVquwJDLCbXg776Cd4GKuvqCO/jGT9xBK0Pn2lxHHLzE4Sb5cRMw8FB30vWBla
         WzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB0KlvhMUGDgb22eZMXqr1FAm2a6UQ0MiA6TXgVnjNah0/sCTBUnAvWZfqoJSc6cMfylDHv9g8k9OhLz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqHTssMY6s247oOtJ/lYCt4G+kA08vkrI4cJwh0QPZ38pN0i2
	F/VaVCmE7UaxYIpzaMN2gn/d0VsW3jpbueEZnWlfZurq/xkCcqwuZvPGUZK9nQzAcFi5S07y3Bb
	gDEj0l93Qgc5Gdu86xv5UMR06rPCGgW0MMFg/ziUW/GVGMcxer330H3vxPko=
X-Google-Smtp-Source: AGHT+IHVXxDqEdI0rQZXXLcM/V54+dDQgsFpp95G6kAYiNWtpwaC/w+Ypp3MYDbdXQXVNy35UjMgfwjF0YFd401H5N7nlZVWl+oG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164d:b0:881:99eb:e212 with SMTP id
 ca18e2360f4ac-886bd1a7252mr1572851539f.9.1756131183916; Mon, 25 Aug 2025
 07:13:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 07:13:03 -0700
In-Reply-To: <20250825124438.5472-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac6f6f.050a0220.37038e.0092.GAE@google.com>
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
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x5ff/0xc80 net/xfrm/xfrm_state.c:836
Write of size 8 at addr ffff888077c659a8 by task kworker/u8:3/49

CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
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
 __xfrm_state_delete+0x5ff/0xc80 net/xfrm/xfrm_state.c:836
 xfrm_state_delete net/xfrm/xfrm_state.c:862 [inline]
 xfrm_state_flush+0x45f/0x770 net/xfrm/xfrm_state.c:945
 xfrm6_tunnel_net_exit+0x3c/0x100 net/ipv6/xfrm6_tunnel.c:337
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x497/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7549:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:735
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1839
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2359
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6519:
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
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:620 [inline]
 xfrm_state_gc_task+0x566/0x700 net/xfrm/xfrm_state.c:636
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888077c65980
 which belongs to the cache xfrm_state of size 928
The buggy address is located 40 bytes inside of
 freed 928-byte region [ffff888077c65980, ffff888077c65d20)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77c64
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b381280 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b381280 dead000000000122 0000000000000000
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001df1901 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7529, tgid 7528 (syz.0.521), ts 196999276626, free_ts 191028336513
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
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:735
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1839
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2359
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 6212 tgid 6212 stack trace:
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
 getname_maybe_null include/linux/fs.h:2925 [inline]
 vfs_fstatat+0x43/0x170 fs/stat.c:370
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888077c65880: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff888077c65900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888077c65980: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888077c65a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888077c65a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         b1c92cdf Merge branch 'net-wangxun-complete-ethtool-co..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=148baef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b26862580000


