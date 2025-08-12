Return-Path: <linux-kernel+bounces-763787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B9B21A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D1E680FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793732D5C6B;
	Tue, 12 Aug 2025 01:39:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C72D46DD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754962744; cv=none; b=B5BLnJgaVbajybK3mdIvx1YlJXyDFf0u/98x1wLXHdPt1HYh/0P8Tcav2VoPzIIeAS8NC7pV8ZohI+VzoXLE1922AsCtU12ihQmEkxTM0DWVgrk1oRL/D5aJ7zTmsyXdjzwGK95nTWRpEM5pbKET6y03gZ1354xqDJIugFqGkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754962744; c=relaxed/simple;
	bh=CsjKnMJ/qFt5tufzb3AT2e1pchkP9Pt6hhWTE9HB/14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CjKaT7ArmTxj4ppQJmhKNheZSXbqG4qMv8osWZoH5B/3P+iw4CXseEzKcjI0Pr3e6eMkC4eqs2aqSOt7j5J5WEzGCQTpexaSt/Le3QwcTqBv7pWOHcPHnHCnZN2P2fi0I+FtFNCnZGKFOQS1Z+/7ym1T660mNyG4gMrU9CfV0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881855cd566so532385539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754962742; x=1755567542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5lXy7thN5ZmZYyoAsgrN5dUMn2rvEp+q9w8/IRLTL0=;
        b=PgIU5Q1ConZ0rPQXitCoq7FdjPF4/OzvI3D8vw3VbloxhpFr2533yx5vjwQoC7LeLK
         Y3OiR/Z3biWzBWPWxxD1jXm9YvVJgLrKAWGESgEjydXUYqcWVDc14nI2tSOX+EcV8mV9
         F0JDp9yCBlavnWkFdp/16FivLBZnKmX+aYJEeE0OXz55jPeCe1sg9gXMstoTnZMo38jr
         OM2TQxx/dl7pqpxhBz/zmkc5mcctAu9U21+bD048P7jQOCASMrimWN4oINTotlzBTRWm
         lGFYpLQN7x/RBicJ+SUD9tLTxUuN8J+MSJMF1SDLrlOXB7V7g1sqgaBrJIvufwHbhooY
         zGzA==
X-Forwarded-Encrypted: i=1; AJvYcCX9wDE4w8yyFkMkBRnBnmkB1wiYQNSZjvZyRgAuIIiE/KqHedI2ZwyVElGb6exQpP5izL5NrRzLAvfGuMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkguep/n9BUtp45eHns4sit2/gVj7JIyc4lOq7eOn50rmkFREF
	R85sbDGVSZcZhzUp1xdIVgLepfSneFnJ7o1lYWAE/3yia/IMX8q0ngkAaQX2nWivPsCOYHc9ATw
	YiLzUGQz7y9l1FpLWL8DzhHOEn9IenlcmSiu8rmDdFP/LOhZqYOyqCTspg/Q=
X-Google-Smtp-Source: AGHT+IGFSC3wvt7tuwfeMa6Jx/ohByzvzLOAuXdw3jcLVdAa0zUvfyHHPxqawESsRyAibwnTxoHOP2d1GuLm0y9OyykjwVLTxuu2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:e708:0:b0:87c:1542:8abc with SMTP id
 ca18e2360f4ac-883f11d2eeemr2362052839f.4.1754962742291; Mon, 11 Aug 2025
 18:39:02 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:39:02 -0700
In-Reply-To: <tencent_9292DCC668099DAEC36EDE0CA4A7EE46DB06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689a9b36.050a0220.51d73.00a6.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in cmp_bss

==================================================================
BUG: KASAN: slab-use-after-free in cmp_bss+0xd4d/0xe80 net/wireless/scan.c:1504
Read of size 4 at addr ffff888011bc6498 by task kworker/u4:4/68

CPU: 0 UID: 0 PID: 68 Comm: kworker/u4:4 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 cmp_bss+0xd4d/0xe80 net/wireless/scan.c:1504
 rb_find_bss net/wireless/scan.c:1693 [inline]
 __cfg80211_bss_update+0xdb/0x2120 net/wireless/scan.c:1981
 cfg80211_inform_single_bss_data+0xba9/0x1ac0 net/wireless/scan.c:2376
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3235
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3326
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info+0x176/0x280 net/mac80211/mlme.c:6564
 ieee80211_rx_mgmt_probe_resp net/mac80211/mlme.c:6607 [inline]
 ieee80211_sta_rx_queued_mgmt+0x1294/0x4470 net/mac80211/mlme.c:8089
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 3037:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 cfg80211_inform_single_bss_data+0x905/0x1ac0 net/wireless/scan.c:2352
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3235
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3326
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info+0x176/0x280 net/mac80211/mlme.c:6564
 ieee80211_rx_mgmt_beacon+0x197d/0x2cd0 net/mac80211/mlme.c:7513
 ieee80211_sta_rx_queued_mgmt+0x4ed/0x4470 net/mac80211/mlme.c:8085
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 68:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free_freelist_hook mm/slub.c:2446 [inline]
 slab_free_bulk mm/slub.c:4704 [inline]
 kmem_cache_free_bulk+0x2d1/0x520 mm/slub.c:5283
 kfree_bulk include/linux/slab.h:794 [inline]
 kvfree_rcu_bulk+0xe5/0x1f0 mm/slab_common.c:1516
 kfree_rcu_work+0xed/0x170 mm/slab_common.c:1594
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 kvfree_call_rcu+0xbb/0x410 mm/slab_common.c:1962
 cfg80211_update_known_bss+0x450/0x1360 net/wireless/scan.c:1919
 cfg80211_update_assoc_bss_entry+0x4ba/0x6a0 net/wireless/scan.c:3455
 cfg80211_ch_switch_notify+0x3c1/0x780 net/wireless/nl80211.c:20398
 ieee80211_sta_process_chanswitch+0xad4/0x2870 net/mac80211/mlme.c:-1
 ieee80211_rx_mgmt_beacon+0x19c7/0x2cd0 net/mac80211/mlme.c:7515
 ieee80211_sta_rx_queued_mgmt+0x4ed/0x4470 net/mac80211/mlme.c:8085
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888011bc6480
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888011bc6480, ffff888011bc64e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11bc6
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a441280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5352, tgid 5352 (syz-executor), ts 90139132069, free_ts 87371171593
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_pages_slowpath+0x2fe/0xce0 mm/page_alloc.c:4679
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5161
 alloc_slab_page mm/slub.c:2489 [inline]
 allocate_slab+0x65/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __kmalloc_cache_node_noprof+0x29a/0x3d0 mm/slub.c:4404
 kmalloc_node_noprof include/linux/slab.h:928 [inline]
 alloc_node_nr_active kernel/workqueue.c:4872 [inline]
 __alloc_workqueue+0x6a4/0x1b70 kernel/workqueue.c:5726
 alloc_workqueue_noprof+0xd4/0x210 kernel/workqueue.c:5786
 tipc_crypto_start+0xd8/0x640 net/tipc/crypto.c:1481
 tipc_init_net+0x213/0x330 net/tipc/core.c:72
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:136
 setup_net+0x10c/0x320 net/core/net_namespace.c:438
 copy_net_ns+0x31b/0x4d0 net/core/net_namespace.c:570
 create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888011bc6380: 00 00 00 00 00 00 00 00 00 00 00 01 fc fc fc fc
 ffff888011bc6400: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff888011bc6480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888011bc6500: 00 00 00 00 00 00 00 00 00 00 00 01 fc fc fc fc
 ffff888011bc6580: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
==================================================================


Tested on:

commit:         8f5ae30d Linux 6.17-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134c2842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14944af0580000


