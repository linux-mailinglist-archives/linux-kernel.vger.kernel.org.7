Return-Path: <linux-kernel+bounces-731178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E7B05079
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BA31AA6B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880926E705;
	Tue, 15 Jul 2025 04:51:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC8EEC8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555066; cv=none; b=XbKremEouim3Fq478rBgACHgwQ7vuhk8BEKK9p42RvnltYvd7INXy9sOG11xu5ZFum8ibcYo5SWnXWeenzSPdrT6T7cdUWL07mmwLzBLxdvc3UAIBz61fFWOx//Iq5sxNjCpIsPUvPmmi3r7f7FZ8WiVxrRJAITq5ZEEJnHavu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555066; c=relaxed/simple;
	bh=HdpeQU21GtlZqejR47+8DhX4amPbnurw4bQZkbU/uCw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SWq0tw+MQ/Si3IdwI6cIWcfDxULjuUlAjQJxq+T91bkhI0mepmMAG3z96CdDFiDVIu8adyAZsUe5kq+mZ8VcaimXk7RRxZhfgMPE7eiqy7hXTwqfgUdSpugBeCEAE5HDWq3H4GrIrF4hCtAckSwSTgv6fYLHjsCI8JkNrN3j4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87313ccba79so995168739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555064; x=1753159864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHeu+3orOwi+ubwOPtHxJ9gzLNAypJfsvAIbSPDN9E4=;
        b=UTGOLoBufppSrddUw2I6sf5K8/4wi2R5JTGzLrdno7JC737YcjFEdP0rnjo8xIZvUW
         DErwNi/OOrP3wjn3THjT2SKlfNqZNTQH7WZFgzC1FFb6Mt/Zmeiuz8M6+J1uCh0gbrON
         PDixKfB2MsZv5WbHxXDMLlmoyQ7wQ1VJdk5fN1WgSVMUb9I4vec4lzYunYuSh2lxzGqu
         r9AtUZscyh/2qoHmQZMLVgBG3yD+AiQl8HLQnfEZrK52Fi5DGpgBDA58Hz28nknhEdn4
         npbS4HFAEnCPOv7ZpxSXOxbHxVQ/ihOgY+o/PjrOfEdfZkqi4T4y8PqV3cBc9uhd9WO9
         2Jzg==
X-Forwarded-Encrypted: i=1; AJvYcCVk+d0tQdCqRdNAXslBAhStqmeQaQm4fbdBuJrI3CCoaTU6dhC2F9gxJSkh4J1EhMkgmAMeO6kR7SkziJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLg3Ep7NKARuzw56pX/2lyAwyVAz6TOAYCUTyQuMxd2kjYl3m
	zXSX2r4xWGfrZ+nsa5vycCavayQXFRgUq5eVbzDSQaFD/wMik6qyGfOrIqfOnMDucJFJB+ld1l8
	uiGfYYnLY0QoS+kLj4TMb7k1Lfnn2fWPTzGTUuqCDqd7PanrRl+OrtkO4Uzc=
X-Google-Smtp-Source: AGHT+IEpVFrMSFOwtHKa9ClD+zhYIdTP82sWWac+jKMsjyEj61nLgfigYgs6dJIeg47uRNtLx3o3D4cPpA7XpB7+sO65o1VnFHvd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3e93:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-879787bcf13mr1749679739f.4.1752555064048; Mon, 14 Jul 2025
 21:51:04 -0700 (PDT)
Date: Mon, 14 Jul 2025 21:51:04 -0700
In-Reply-To: <20250715042959.2087-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875de38.a00a0220.3af5df.0000.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read
 in hci_uart_write_work
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_uart_write_work

==================================================================
BUG: KASAN: slab-use-after-free in hci_uart_write_work+0x31b/0x580 drivers/bluetooth/hci_ldisc.c:166
Read of size 8 at addr ffff888054b5ed58 by task kworker/0:7/6055

CPU: 0 UID: 0 PID: 6055 Comm: kworker/0:7 Not tainted 6.16.0-rc6-syzkaller-g155a3c003e55-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events hci_uart_write_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hci_uart_write_work+0x31b/0x580 drivers/bluetooth/hci_ldisc.c:166
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6055:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 h5_prepare_pkt+0x184/0x530 drivers/bluetooth/hci_h5.c:702
 h5_dequeue+0x197/0x790 drivers/bluetooth/hci_h5.c:761
 hci_uart_dequeue drivers/bluetooth/hci_ldisc.c:105 [inline]
 hci_uart_write_work+0x29a/0x580 drivers/bluetooth/hci_ldisc.c:162
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888054b5ec80
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 216 bytes inside of
 freed 240-byte region [ffff888054b5ec80, ffff888054b5ed70)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888054b5e140 pfn:0x54b5e
flags: 0x4fff00000000200(workingset|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000200 ffff8880304efb40 ffffea0001253bd0 ffffea00016134d0
raw: ffff888054b5e140 00000000000c000a 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 3020, tgid 3020 (kworker/u4:11), ts 227043981111, free_ts 226252562525
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
 kmem_cache_alloc_node_noprof+0x280/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x29a/0xb80 drivers/net/netdevsim/dev.c:851
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 pagetable_free include/linux/mm.h:2884 [inline]
 pagetable_dtor_free include/linux/mm.h:2982 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888054b5ec00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff888054b5ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888054b5ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                    ^
 ffff888054b5ed80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888054b5ee00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         155a3c00 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2f0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=fde6bd779f78e6e0992e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c90382580000


