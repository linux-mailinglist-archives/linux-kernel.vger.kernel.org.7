Return-Path: <linux-kernel+bounces-772340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833FB29189
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD8D48537D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE881A3179;
	Sun, 17 Aug 2025 04:33:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516618B0F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755405185; cv=none; b=FtNy10Knd6Rybcow4HcBxms7jBIGpW3KaJ9H/QhkJAfKYFu1wSpprTO5DjXC8KmagwKlQiq2NQ/mKD0j1/9dWttxMbArZeQX4YHktymr8esbymEsGoyiXmNpoWaFIma0fSWWVxi+ph5dPOiwy5F5qFYdzIOv0bpaRFnI6SqsxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755405185; c=relaxed/simple;
	bh=Z1hhr/vKBseKw3oswXMh1Ld1b7j15ExPW7xMisz+Uso=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VhFVUGboRpIP/y+53BI2xDfOHhWSXjqbaKAR5OWmKnJ0M0YlIU7+bmJ0pYRUyyVJDmQMD/nMAkJZWI1aETfukhK56VvbR/8VCP1oqpY0GV3NDBHSBdekEI5FOn//d/7uaIcEA8teaGXJHxod6shnXHjhQPgf1w3qNOYXvivB/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432cb7627so313220639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 21:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755405183; x=1756009983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiN15vfpR+AChlkzsG7hJzaaorI82QK/ceQbXiB1rlI=;
        b=WXG4X03hwaom74FB7/UoQhDJgHYbMXdN1YJY9M/AkVX68Iu/cWocAQvVK+XlwUUADd
         m+0a/LffIVCFPpBQ94CuFaIqDA0A807D5llXBOaRxHOpkmlDKMqDPVNwCKRVZBEhG3Di
         yt5/3BJFYrPJ9vfe7oCZhJFH3oI8deUeUBkV9NyBiQXlTqMtYobXf8ARMtyQZGznoA+D
         xn5tjbuZtcWtbcZmNOL2fUXCiP0J1f1nb4YlHYgxesxA3zqpPEPSKIM8Myhqpmx8RM+k
         /i5gMUlZh1Soe7uaC10wWXW+JvolD1REJZf5TpJ3jiC0aBEAEBfl4575pJYT4do+U3A6
         OR3A==
X-Forwarded-Encrypted: i=1; AJvYcCVzs15afEAXNN3iZgALVAbFtiYbgPPhqkLfJv5yzyrP0USi8COxlbXZvnldfZ+irmjTLEshGRsG6kPFr7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/XIcVmKfVE8eWLMY8ndRswZCLRAaPz3Q7u9nIhKjsXBR/9xW
	EFA+5vQ6Dzr8TXUiK8qM8Qq7hXu4Uzj9gXZ/Ol+v/UkqisXHWfj7qsq7o3CMkaXLB1Fpxvyf6kP
	twoxKbqaOsLOj5+C8SvtmE6iyf599lkKxuehA0hQr2JT4QNVYWyUTFQUzEzU=
X-Google-Smtp-Source: AGHT+IGK+EAWE5m7Zu49M1346fu2kcPlupiKtS8W2pznat04xXxGcc3cmfYjkZ21O4SCX5M0PYzEwFqbSxhvyxdG6qn1+y/gmRM+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640e:b0:883:e1b3:19cc with SMTP id
 ca18e2360f4ac-8843e3912b9mr1675228939f.6.1755405182800; Sat, 16 Aug 2025
 21:33:02 -0700 (PDT)
Date: Sat, 16 Aug 2025 21:33:02 -0700
In-Reply-To: <20250817041202.4853-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a15b7e.050a0220.e29e5.005a.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
From: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in usbtmc_interrupt

usbtmc 1-1:16.0: invalid notification: 33
usbtmc 1-1:16.0: invalid notification: 36
usbtmc 1-1:16.0: invalid notification: 8
==================================================================
BUG: KASAN: slab-out-of-bounds in usbtmc_interrupt+0x560/0x720 drivers/usb/class/usbtmc.c:2314
Read of size 1 at addr ffff888028fb8ae1 by task kworker/1:0/24

CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted 6.17.0-rc1-next-20250815-syzkaller-g1357b2649c02-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events nsim_fib_event_work
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 usbtmc_interrupt+0x560/0x720 drivers/usb/class/usbtmc.c:2314
 __usb_hcd_giveback_urb+0x376/0x540 drivers/usb/core/hcd.c:1661
 dummy_timer+0x862/0x4550 drivers/usb/gadget/udc/dummy_hcd.c:1995
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x529/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rhashtable_insert_fast+0x1c/0xf70 include/linux/rhashtable.h:831
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec 20 01 00 00 <48> 89 74 24 30 49 89 fc 65 48 8b 05 54 a5 c3 0b 48 89 84 24 00 01
RSP: 0018:ffffc900001e7560 EFLAGS: 00000286
RAX: 0000000000000000 RBX: ffff888022357068 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888145eb4e20 RDI: ffff888022357068
RBP: ffffc900001e76a8 R08: 0001000000000000 R09: 00200000001c0000
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888022357000
R13: ffff888142fcb690 R14: ffffc900001e7840 R15: dffffc0000000000
 nsim_fib6_rt_add drivers/net/netdevsim/fib.c:686 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:759 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x2319/0x3180 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 981:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:913 [inline]
 usbtmc_probe+0xa3a/0x1ad0 drivers/usb/class/usbtmc.c:2467
 usb_probe_interface+0x665/0xc30 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3689
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3689
 usb_new_device+0xa39/0x16f0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2958/0x4a20 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888028fb8ae0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff888028fb8ae0, ffff888028fb8ae1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28fb8
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a841500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1213, tgid 1213 (kworker/0:2), ts 9601359196, free_ts 9100050588
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
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4391
 kmalloc_noprof include/linux/slab.h:909 [inline]
 usb_control_msg+0x73/0x3e0 drivers/usb/core/message.c:144
 get_port_status drivers/usb/core/hub.c:611 [inline]
 hub_ext_port_status+0x116/0x820 drivers/usb/core/hub.c:628
 usb_hub_port_status drivers/usb/core/hub.c:678 [inline]
 hub_activate+0x77d/0x1a70 drivers/usb/core/hub.c:1189
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 1213 tgid 1213 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 vfree+0x25a/0x400 mm/vmalloc.c:3434
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3353
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888028fb8980: 04 fc fc fc 06 fc fc fc fa fc fc fc 06 fc fc fc
 ffff888028fb8a00: 06 fc fc fc 06 fc fc fc 06 fc fc fc fa fc fc fc
>ffff888028fb8a80: 00 fc fc fc 00 fc fc fc 00 fc fc fc 01 fc fc fc
                                                       ^
 ffff888028fb8b00: 00 fc fc fc 00 fc fc fc 00 fc fc fc 00 fc fc fc
 ffff888028fb8b80: 00 fc fc fc 00 fc fc fc 00 fc fc fc 00 fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	f3 0f 1e fa          	endbr64
  12:	55                   	push   %rbp
  13:	48 89 e5             	mov    %rsp,%rbp
  16:	41 57                	push   %r15
  18:	41 56                	push   %r14
  1a:	41 55                	push   %r13
  1c:	41 54                	push   %r12
  1e:	53                   	push   %rbx
  1f:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  23:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
* 2a:	48 89 74 24 30       	mov    %rsi,0x30(%rsp) <-- trapping instruction
  2f:	49 89 fc             	mov    %rdi,%r12
  32:	65 48 8b 05 54 a5 c3 	mov    %gs:0xbc3a554(%rip),%rax        # 0xbc3a58e
  39:	0b
  3a:	48                   	rex.W
  3b:	89                   	.byte 0x89
  3c:	84 24 00             	test   %ah,(%rax,%rax,1)
  3f:	01                   	.byte 0x1


Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ff0ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6401f805169ac8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1419baf0580000


