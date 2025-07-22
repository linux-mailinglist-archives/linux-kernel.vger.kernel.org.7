Return-Path: <linux-kernel+bounces-740093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C511CB0CFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59AB6C2724
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4911E1D90DF;
	Tue, 22 Jul 2025 02:29:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEB2AE72
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151345; cv=none; b=ZoYDgaucRQnUrny3QqWVlmi2BDVeL7THoeO5pPQpD694xb0mtG2OPA0v/7J57SFeUlcec6qttiyLk4DTshP/qZvG6FuZqgJ1BuF7A7S10g0jZWbOGMgyZe4mj5Wt2asuXPzvpJjo+qIVy2ME8aRQbquKD3MxvAoPywY5y2qVmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151345; c=relaxed/simple;
	bh=vk+jzjM1xkc/EXIVHGml0buhb1FfUNGG8VgAcPH+JC4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EAi/7qA9SP76GKf0fvdEGCQZShKkS6cb3aVYZuJSpady5tCga8wKMhXN3NWl02VjSIGYJXQqezNVZdXeAf6dIOWxXajfiA3gn/RMMXcj6B/JpVhOQCl0LuQjqH7v6kH1FGRLJoXE6JbLEyfrGU+EpxpEQxZyhMhdIWw6jjAuPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86a5def8869so1137236839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753151343; x=1753756143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuTRKiCwEpwwNz3tUa+HTRPxNPx4xuRkAR4bPiNsF5A=;
        b=Pb1IzwjvlZiHwwsID4O1MBHd/Q+FOArQ0g0MkPQLVvSvLB03bWxdSeFlj5Z4vbVknz
         jPEdyb2zZeSAcC3u6qvnnuy2xjZzZBLkeHN+smKlnW65hA+aIYiWspJA8NT/roxbaxPV
         Mbm/am/iI1UbSkH0ZPBJEOTcj+ziDLM+7XHOOY+Bi88Z2Dx5RtFagWwamexVETuxp1mK
         Be43pU1ZjcoQS4PaYh0eb2Fw/I+T0iao2uXhA5NlVK7HvA12ONOVbliuFbUEyD+06vBT
         MqldbYb+3GfV54/5/BFHVQsnvuUXepLNuclz/FVyLbvWZWagbzIgIT3YT6RYm/VP0WLf
         sK0w==
X-Forwarded-Encrypted: i=1; AJvYcCXdOhNFXKZdSjEIgYpXOTQnuCUckUq4LIASL5+UT0j7VBG7i9LeD4nh0HKCCDc7hQoA1D99SBt5P08CLrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbNAiu/5nw7cYLNMMc7b8w1U7q8E6sdzFQkK88ytK2Ci/aXcq
	p6zNOBLPvhET6QBob5jszXQs0LwEhrmudtyTfxqU7HaQmgtBUTLjmBm5rncFp2ljwhSXd7lfHy9
	AZdjvudV6rLhQi4SgzNwJjux+xG+wFW/SBaROlrXbKFRirm75y/KBTBRfCT8=
X-Google-Smtp-Source: AGHT+IFMcADlFDetW9tz0XMf3SSVTRDNSHZV7tnBiaCIJCy7DOznGeKUx8O6nbE5n4IW+eJLuc07VIyRwUQU79BUVlEiwekahHks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:8711:0:b0:875:28e5:92e5 with SMTP id
 ca18e2360f4ac-879c2b244e6mr2614454639f.13.1753151343193; Mon, 21 Jul 2025
 19:29:03 -0700 (PDT)
Date: Mon, 21 Jul 2025 19:29:03 -0700
In-Reply-To: <kln7udczb7kmb5xjzddid6pgdzt3mv2sqn25wnoxp4hncb7taf@7aln53ikrgnv>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687ef76f.a70a0220.693ce.00f5.GAE@google.com>
Subject: Re: [syzbot] [bluetooth] KASAN: slab-use-after-free Read in hci_uart_write_work
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_uart_write_work

==================================================================
BUG: KASAN: slab-use-after-free in hci_uart_write_work+0x2ca/0x550 drivers/bluetooth/hci_ldisc.c:165
Read of size 8 at addr ffff888058e8c0d8 by task kworker/0:4/5440

CPU: 0 UID: 0 PID: 5440 Comm: kworker/0:4 Not tainted 6.15.0-rc6-syzkaller-01366-g0ba714749722 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events hci_uart_write_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 hci_uart_write_work+0x2ca/0x550 drivers/bluetooth/hci_ldisc.c:165
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5456:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4248
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1337 [inline]
 h5_prepare_pkt+0x184/0x530 drivers/bluetooth/hci_h5.c:702
 h5_dequeue+0x197/0x790 drivers/bluetooth/hci_h5.c:761
 hci_uart_dequeue drivers/bluetooth/hci_ldisc.c:107 [inline]
 hci_uart_write_work+0x247/0x550 drivers/bluetooth/hci_ldisc.c:161
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888058e8c000
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 216 bytes inside of
 freed 240-byte region [ffff888058e8c000, ffff888058e8c0f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58e8c
anon flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff888030afe8c0 0000000000000000 dead000000000001
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 13, tgid 13 (kworker/u4:1), ts 191152770378, free_ts 191108105126
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1714
 prep_new_page mm/page_alloc.c:1722 [inline]
 get_page_from_freelist+0x21e0/0x22c0 mm/page_alloc.c:3684
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4966
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2618
 new_slab mm/slub.c:2672 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3858
 __slab_alloc mm/slub.c:3948 [inline]
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 kmem_cache_alloc_node_noprof+0x280/0x3c0 mm/slub.c:4248
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1337 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x29a/0xb80 drivers/net/netdevsim/dev.c:851
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 6142 tgid 6140 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1258 [inline]
 __free_frozen_pages+0xc6e/0xe50 mm/page_alloc.c:2721
 vfree+0x1a6/0x330 mm/vmalloc.c:3384
 n_tty_close+0x159/0x1d0 drivers/tty/n_tty.c:1883
 tty_set_ldisc+0x33f/0x560 drivers/tty/tty_ldisc.c:557
 tty_ioctl+0xc38/0xde0 drivers/tty/tty_io.c:2738
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x220 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888058e8bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888058e8c000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888058e8c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                    ^
 ffff888058e8c100: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
 ffff888058e8c180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         0ba71474 Bluetooth: hci_event: Mask data status from L..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=119af722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1fa9d0bcb4675c74
dashboard link: https://syzkaller.appspot.com/bug?extid=fde6bd779f78e6e0992e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

