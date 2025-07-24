Return-Path: <linux-kernel+bounces-743501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E8B0FF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35D5189E23D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFA1DF98D;
	Thu, 24 Jul 2025 03:56:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC641E7C1B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329366; cv=none; b=mrkC5Ga/ZvZhXPzdhgfI0m59zG2g/cvJY5xRC8Ce6lhkkKFbB1e/Gq5FCWvCp6Ugj42UAbl8e65hfb2ynPS2Zavdu/K5gdfmwfJGKc0rd4lomcuqaAl8XsyyLO6i/QSoEYh+7rJejznvaDW/PDDhhSpBxs+xLcTqZbGVQwREBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329366; c=relaxed/simple;
	bh=xr8cQglWM9SBBbwV3kKtk4sXNxDACWEld761hoiIU2k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=olNul8rgMokB1s6U34AMnsQe/Iq//0dTH/jlEPdI1wOEXG1YVlypAB9Dpf2zmO55pXj1tpGW3zkbeQvdRGtCfzOHATbIo+IN/v+TZKMwld20hnST7CnX8zA+1StnOBSYwpvLmWVv4DILGYwQDzof7Hnmxuv8MDiDyHDBVKUM9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c13b0a7ffso122399339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329363; x=1753934163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQfd/0jegkA2XNZl003KtnVPbXaJTp2Iz3mwoXEr0Mc=;
        b=fjcG9sHyMnUZZFys0ifrKWYItw0N1LT5ldZ1Rh5U7xxxg8RHGj/5d5BmbEyu0aUftl
         3dLmFI9qh6SACWkNvksGumX2jH3W3OBpsG+ryq2PWvjIDoQYu5Ui5UsQLYcnJwEl7JDM
         Bjw0r+IWw4zDfDICeHu858GkosIQ+7yFjalwTSxumgB6xo5KoMaR7Puc0RQB0exe3Usr
         tbKBMrRr7A6/YVPP2Uhf1bUiH6CcBe8nOis8Rmi4iTJ/XeTLQGevnMmQUHe4fJWyhXik
         VuTWkgAsjYRNc/vMFS08+6pZnZqzEabTxvS4wQeVjfWtuIaaFuL/7idQ3Uvq+lgkr4nR
         G6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIwpQYej3qwAQOGagj0b61QnPuRBorC+sKUnLMMdbFaiu/zQmwdH0+zakz3j/UnjRovXvSeHjek/MBQDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw744APQHATtIDGwJpwXaFzBN9duPULHQ6/fAinufoFsOl1dysI
	O1wGryn2555/WKa/N/qotQweGK68mxPZ0SruROs1pkknnyijs8G4iaFct4+kMhHTY/oa2stq+lu
	eljgPgXHdWO0iQhraFrMkpA0UUhv3FtxeBapJWxaAeOfJb+aKiWzrKdFi/aM=
X-Google-Smtp-Source: AGHT+IHjBJUldBlJ0hJqjLLykK5/B2AoSop24Rw1oMRnQ6nOel+jzocNaIISgP35VBqlvrn/stPvvnLfKb2d4zAqX4k+uqu8AAwM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b90:b0:87c:32eb:2a2a with SMTP id
 ca18e2360f4ac-87c650625d9mr1013299139f.13.1753329363271; Wed, 23 Jul 2025
 20:56:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 20:56:03 -0700
In-Reply-To: <20250724033449.2927-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881aed3.a00a0220.2f88df.000b.GAE@google.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in lockref_get

wlan1: send auth to aa:09:b7:99:c0:d7 (try 2/3)
wlan1: send auth to aa:09:b7:99:c0:d7 (try 3/3)
wlan1: authentication with aa:09:b7:99:c0:d7 timed out
==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
Read of size 1 at addr ffff888042ff76d8 by task kworker/u4:0/12

CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:557
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5845
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 lockref_get+0x15/0x60 lib/lockref.c:50
 dget include/linux/dcache.h:345 [inline]
 simple_recursive_removal+0x35/0x690 fs/libfs.c:611
 debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:805
 ieee80211_sta_debugfs_remove+0x8e/0xc0 net/mac80211/debugfs_sta.c:1285
 __sta_info_destroy_part2+0x352/0x450 net/mac80211/sta_info.c:1501
 __sta_info_destroy net/mac80211/sta_info.c:1517 [inline]
 sta_info_destroy_addr+0xf5/0x140 net/mac80211/sta_info.c:1529
 ieee80211_destroy_auth_data+0x12d/0x260 net/mac80211/mlme.c:4597
 ieee80211_sta_work+0x11cf/0x3600 net/mac80211/mlme.c:8310
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5867:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_lru_noprof+0x1c6/0x3d0 mm/slub.c:4216
 __d_alloc+0x31/0x6f0 fs/dcache.c:1690
 d_alloc fs/dcache.c:1769 [inline]
 d_alloc_parallel+0xe0/0x14e0 fs/dcache.c:2533
 __lookup_slow+0x116/0x3d0 fs/namei.c:1802
 start_creating+0x22e/0x3c0 fs/debugfs/inode.c:391
 debugfs_create_dir+0x28/0x420 fs/debugfs/inode.c:586
 ieee80211_sta_debugfs_add+0x12c/0x850 net/mac80211/debugfs_sta.c:1254
 sta_info_insert_finish net/mac80211/sta_info.c:892 [inline]
 sta_info_insert_rcu+0xfac/0x1940 net/mac80211/sta_info.c:960
 sta_info_insert+0x16/0xc0 net/mac80211/sta_info.c:965
 ieee80211_prep_connection+0x10cd/0x1600 net/mac80211/mlme.c:8854
 ieee80211_mgd_auth+0xee3/0x1770 net/mac80211/mlme.c:9119
 rdev_auth net/wireless/rdev-ops.h:486 [inline]
 cfg80211_mlme_auth+0x632/0x9c0 net/wireless/mlme.c:291
 cfg80211_conn_do_work+0x501/0xd10 net/wireless/sme.c:183
 cfg80211_sme_connect net/wireless/sme.c:626 [inline]
 cfg80211_connect+0x1862/0x21a0 net/wireless/sme.c:1525
 nl80211_connect+0x17bc/0x1cd0 net/wireless/nl80211.c:12303
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4745
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3094 [inline]
 call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3214
 __dentry_kill+0x4d2/0x660 fs/dcache.c:688
 dput+0x19f/0x2b0 fs/dcache.c:911
 find_next_child+0x1e5/0x250 fs/libfs.c:603
 simple_recursive_removal+0xf4/0x690 fs/libfs.c:619
 debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:805
 ieee80211_debugfs_remove_netdev net/mac80211/debugfs_netdev.c:1021 [inline]
 ieee80211_debugfs_recreate_netdev+0xbf/0x1460 net/mac80211/debugfs_netdev.c:1034
 drv_remove_interface+0x1fa/0x590 net/mac80211/driver-ops.c:125
 _ieee80211_change_mac net/mac80211/iface.c:277 [inline]
 ieee80211_change_mac+0x912/0x12c0 net/mac80211/iface.c:309
 netif_set_mac_address+0x2f9/0x4c0 net/core/dev.c:9688
 do_setlink+0x88c/0x41c0 net/core/rtnetlink.c:3093
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888042ff7608
 which belongs to the cache dentry of size 312
The buggy address is located 208 bytes inside of
 freed 312-byte region [ffff888042ff7608, ffff888042ff7740)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42ff6
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88803440e501
ksm flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888030413780 ffffea00010c1d00 dead000000000003
raw: 0000000000000000 0000000000150015 00000000f5000000 ffff88803440e501
head: 04fff00000000040 ffff888030413780 ffffea00010c1d00 dead000000000003
head: 0000000000000000 0000000000150015 00000000f5000000 ffff88803440e501
head: 04fff00000000001 ffffea00010bfd81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4744, tgid 4744 (udevd), ts 37683151774, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 kmem_cache_alloc_lru_noprof+0x288/0x3d0 mm/slub.c:4216
 __d_alloc+0x31/0x6f0 fs/dcache.c:1690
 d_alloc fs/dcache.c:1769 [inline]
 d_alloc_parallel+0xe0/0x14e0 fs/dcache.c:2533
 lookup_open fs/namei.c:3639 [inline]
 open_last_lookups fs/namei.c:3816 [inline]
 path_openat+0xa3b/0x3830 fs/namei.c:4052
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888042ff7580: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
 ffff888042ff7600: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888042ff7680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888042ff7700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888042ff7780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1357dfd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c140a2580000


