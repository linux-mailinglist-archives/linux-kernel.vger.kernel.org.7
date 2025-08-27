Return-Path: <linux-kernel+bounces-788112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C97B37FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D997B071A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032734AAFA;
	Wed, 27 Aug 2025 10:23:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D234A328
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290187; cv=none; b=P5Nyo1VFYI0OqIOBOTMIxCjGTNz75U87UMM+19y3SrBnUX7KeHQ//g3R3hbrqVPxS3o1WqHbux8gVXTQGQs90860ENeY65oL5ihmO0YjDEcgPGpUUfhUdCUTGyLr2PUXIiEr6vv0rLzWe18yYPOLOaKpEA2WDCKzvIJ2F9jL7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290187; c=relaxed/simple;
	bh=J7rGhw09vDgyEiU8qbvstf//Xtm9z8h5WbD5r784myI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=plt4ku3NVdJqkZnH321qz0QgKT4WBrxgy6j3VyJXlQ9HskHubBu51EJDGzWZhSSap0SLsqxaThD5tVPIj8U14lTn/qz+5FzolD8WL4pCXSAR3MBdX7rBhW5BwTzGsb88Lnkcbc7eVpDPwMYsDoobxF31n+PBPXc6S7/NOxGRBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3edfbb8d391so66266195ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290184; x=1756894984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px4dJWyT0BaxVpP0XcOyiIoceuyTCfC579eNjmd4yo0=;
        b=K0xxTBai7RYleV+q2AFKx6MZZb7SuAGPdtOvcj0rEeof1fLDI+mnpoRL/BLOf58WI5
         MK9Y3NjYgsTbyDMoo27wneAOqSkNCRAhOVT512AzDwe/DYVuu+3c64sDcKsZx2qw4uia
         H/P8/sY5J7Dgdwbngs6zaM2ytV3ln4IEcLahmVc9TijTtcE/bFNTfyttxyOxzGKwKx0l
         sePGY31rPzb+GWnV1DbNAhPlpo4gl/0boq6XtGomdU9FTkf4M1ZJDv7AEtGEI1/57lBi
         tRhY72cyXM0ATN5RRfe6oPt0LkdzbWK+sdJbUH4LCbUQnmmAH4rWsv9BAEaeLEGwG5FN
         c0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW5nPM0BheyHHLrRebY/jI/3JLebD/5AznxQxyuV3yda4V1s4PDEbf7y0np8SF5NNykEEnmY4xfSHcbMeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZ8xik96SKsjQlvEnoh3HEHS+uLyethDf98Xijydi9binniBx
	hDELd/Ku74QKFtq74aoE6GzmElsdFm8XhSobOhJkgkRr5sYGlKKp32OYxG8nPLYJjpZ7da52Ox1
	9cB9+apuSOHLy84YnGJHWH5JSZu9ojWfHNJ1/RhraWMaXvKWUQt+G8sLCPgg=
X-Google-Smtp-Source: AGHT+IEEAe6+Hj9q6k6X7SBDqGcoxq9ZQwegL3sXciGl6v5Lq9r0xtC7dA2hUdnpyobTTZuZQJAl8T8BPwXd/iF6iZ+Zhl3vI/4d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:3eb:5862:7cea with SMTP id
 e9e14a558f8ab-3eb586280a5mr112034935ab.15.1756290184308; Wed, 27 Aug 2025
 03:23:04 -0700 (PDT)
Date: Wed, 27 Aug 2025 03:23:04 -0700
In-Reply-To: <tencent_85C67489962ECA2EE44C9D67DE46C912F006@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aedc88.a70a0220.3cafd4.001b.GAE@google.com>
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
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x666/0xcd0 net/xfrm/xfrm_state.c:831
Write of size 8 at addr ffff8880285bd9a8 by task kworker/u8:7/3075

CPU: 1 UID: 0 PID: 3075 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full) 
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
 __xfrm_state_delete+0x666/0xcd0 net/xfrm/xfrm_state.c:831
 xfrm_state_delete net/xfrm/xfrm_state.c:858 [inline]
 xfrm_state_flush+0x487/0x7c0 net/xfrm/xfrm_state.c:942
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

Allocated by task 10077:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x320 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1836
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2356
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

Freed by task 24:
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

The buggy address belongs to the object at ffff8880285bd980
 which belongs to the cache xfrm_state of size 928
The buggy address is located 40 bytes inside of
 freed 928-byte region [ffff8880285bd980, ffff8880285bdd20)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x285bc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801fef0640 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801fef0640 dead000000000100 dead000000000122
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000a16f01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6998, tgid 6997 (syz.0.241), ts 106338851731, free_ts 105263132831
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
 xfrm_state_alloc+0x24/0x320 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1836
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2356
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 6867 tgid 6867 stack trace:
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
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x28b/0x550 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x2b3/0x4b0 security/tomoyo/file.c:831
 tomoyo_path_symlink+0xa3/0xe0 security/tomoyo/tomoyo.c:212
 security_path_symlink+0x177/0x380 security/security.c:1984
 do_symlinkat+0x107/0x3f0 fs/namei.c:4754
 __do_sys_symlinkat fs/namei.c:4772 [inline]
 __se_sys_symlinkat fs/namei.c:4769 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4769
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880285bd880: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff8880285bd900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880285bd980: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880285bda00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880285bda80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13069462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e03c42580000


