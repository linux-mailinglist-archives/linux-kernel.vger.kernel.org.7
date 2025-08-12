Return-Path: <linux-kernel+bounces-764397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 233BAB2228D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5B188A852
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35DA2E7BB3;
	Tue, 12 Aug 2025 09:11:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF929A30D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989867; cv=none; b=jQzrsocC8h8aNPs1RHZceGOhZBstITkDAau/jV5mkJyjvr2RW2w3MC9XbwkBT6j5rkE4EK/vM0Ye49q4cATKY2ou/Dmbu78ApxHUSrLA2d3OEOQKTQe72bcc67HgJpUPRtPcxSLV917baJVoMMmFn2w76x/1L+WkSwipnbwxdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989867; c=relaxed/simple;
	bh=ifv0zE5sxtvySkgzaTrelNEntX41ue4og3c8GVEqjvs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JqoKripKAOMSErAR7x/BC63fCMtziBBUcrFn/nKP8q9aBIMQYaJIA+GqcAvWi5o1cCOyURvEyGwjx9Z96yldj+dZ5iguhCWQa3OmvRP8ApdfRI0BYiVeDcFK/DPmDz0VL9Okbu6jLlqKkVTS2M2EuvshxeVXF36Q95GNt4F2U/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8841d3db1a3so65504839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989865; x=1755594665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yFgxmKKb3laQ7ssR3WOV7mdgu6uKit/3Ca+1xtElyU=;
        b=VRuCpNSK6dVN+NDKg5m1Osgefo0/oguEKQwAY1GEyo0HoiQM9m23M1zk24rtM8Zkop
         TBHrP/8NXLSsPF6EqGIELMVYRxf/c8bZyJMuClBkKSuAOWgK/jTf7ZdTVcQSCPjJ3hwF
         UjO/rPmfjsjAIZ1EQjdBseu91w7Jah0ZgJ9M9YU4wLTFZBJBfHSVJCORqa8K6CvJSw4P
         Dzx9mrn2zz8zWTxcJu3HPKx5DcTXlPDcvZDbVUNFeaXfETTH+BQ1INhc5Xw+y5kyvEil
         C1w4dAYKLH49Hmx647K9LiMmjwV0AuT14DVD190v9vKU7VCrdpP/qdJXxF8GFl876yOJ
         pEkg==
X-Forwarded-Encrypted: i=1; AJvYcCXS7bBXuLDlqg3lS8F1i51FFyUQhBvB7HBA/gzuJar56s2Sm6bDrnX+E7T/q9d6Pqd1aJclbjO9w78SBms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyxflbgdFgk90uJUN9jxVqspwzYohJuUoz7Pr8Itv8Kz5H255
	sj/ZoIZ9kTSdQ0+xcIkkcPgJRi8mDIowc5oaXBzmNGNIkRJLrtohsRVwSPML3gM30XFlXkBMvUH
	KqNS1jJt0Rks131B3XJKi1BI7E0ARPVpFBj3gycVzeRMj9vdKoAyQ3rSCn9s=
X-Google-Smtp-Source: AGHT+IEP++bBMseOHg3qA8a/6gD7KuXQe+xF77hV+xWycvxAXJS1ph1c6NNGzvYiUE2MJAFfmDo1RXFqG3vH+ymCL+4VbD/duBhG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:e703:0:b0:876:1c5e:8c50 with SMTP id
 ca18e2360f4ac-8841beab0b8mr399095739f.7.1754989864760; Tue, 12 Aug 2025
 02:11:04 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:11:04 -0700
In-Reply-To: <d4f0bd47-06b1-4841-924d-607386e733d4@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b0528.050a0220.51d73.00aa.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in cmp_bss

==================================================================
BUG: KASAN: slab-use-after-free in cmp_bss+0xd4d/0xe80 net/wireless/scan.c:1504
Read of size 4 at addr ffff888000e6e898 by task kworker/u4:0/12

CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498-dirty #0 PREEMPT(full) 
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
 __cfg80211_bss_update+0xd6/0x2140 net/wireless/scan.c:1982
 cfg80211_inform_single_bss_data+0xba9/0x1ac0 net/wireless/scan.c:2377
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3236
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3327
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

Allocated by task 3109:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 cfg80211_inform_single_bss_data+0x905/0x1ac0 net/wireless/scan.c:2353
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3236
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3327
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

Freed by task 3109:
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
 kvfree_rcu_drain_ready mm/slab_common.c:1699 [inline]
 kfree_rcu_monitor+0x211/0x2a0 mm/slab_common.c:1772
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
 cfg80211_update_known_bss+0x9e8/0x13d0 net/wireless/scan.c:1921
 cfg80211_update_assoc_bss_entry+0x4ba/0x6a0 net/wireless/scan.c:3456
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

The buggy address belongs to the object at ffff888000e6e880
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888000e6e880, ffff888000e6e8e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe6e
flags: 0x7ff00000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 007ff00000000000 ffff88801a441280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 3109, tgid 3109 (kworker/u4:11), ts 107292613223, free_ts 31900007900
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_slab_page mm/slub.c:2489 [inline]
 allocate_slab+0x65/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_node_noprof+0x2fd/0x4e0 mm/slub.c:4371
 kmalloc_array_node_noprof include/linux/slab.h:1020 [inline]
 alloc_slab_obj_exts mm/slub.c:2028 [inline]
 account_slab mm/slub.c:2614 [inline]
 allocate_slab+0x16a/0x370 mm/slub.c:2674
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
 dst_alloc+0x105/0x170 net/core/dst.c:89
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x420 net/ipv6/route.c:3324
 mld_sendpack+0x678/0xd80 net/ipv6/mcast.c:1849
 ipv6_mc_dad_complete+0x88/0x410 net/ipv6/mcast.c:2284
 addrconf_dad_completed+0x6d5/0xd60 net/ipv6/addrconf.c:4340
 addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
page last free pid 4756 tgid 4756 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff888000e6e780: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff888000e6e800: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff888000e6e880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888000e6e900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888000e6e980: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10c54af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ffe5a2580000


