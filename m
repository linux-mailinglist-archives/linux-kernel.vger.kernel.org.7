Return-Path: <linux-kernel+bounces-772326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF0B29145
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414731B267C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 03:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA971C862E;
	Sun, 17 Aug 2025 03:19:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F1F9D6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755400745; cv=none; b=q/NZbT1q0az7lk/ExYAv3UYZwZq+ZO6yAAbrYdnPsAOUfhAOxzZxaROuRfofrUWcsm3nLjJt1v/lf49tNqlc86Wp6CQfK5oy02ig3CXqdpgjyQQqZ8l6SWpidP1sXoGRyMwa9z6PUKbo+3ijr2Z8dby3tbzVvFtQd+azLk7fgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755400745; c=relaxed/simple;
	bh=0IUnLTWPImc4qbuhgHB+2DyL+do8OrM3uCnKMavppUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KpRDm4QQFqHZ+PCry2gPQ0j3THHSWzOwL+CCUCGBJSsRnIFHi4Hvrv8ogkELEiSXJZ4yu9pzJBo6p87CYVuGSsl3FbWIFGvqp2piKNUNZVhG2Mb0Tut7u539LLOYhbFlzt4YDAznlADi2cWSJZYTJV5jTBViE8OXF/4TwlusfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e665183fa3so22799545ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 20:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755400743; x=1756005543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiQ5CBtnxZiQ3THSOG+M9ocvGsEBu+3yxF05bjXfDrQ=;
        b=PRnERBV9Biq3EvAbvJuNOxI16FeC/LyiOOwq7x3jOdvaR3B2hdM7kgLDes9Po3dTcD
         9P7zrfh1Wm1ZQQOWVxRhq4eNBMSpw26WiXyxWknWuuCzCGk5HxjIu+8vK8KPkHqomllv
         Yom/KhZkVvhAjR8MeDWfMq65Mf7qMkP0veaw6kvCZK2bXLwBVL2XiskjEVXzlA9v08M1
         6v/RL3iIB41jAjCJ8KDDZMPngi82ifpQ7OCFa5DuF1/iN15EHlAIEc2Ru6jFRKWmJ+Z8
         M/NT2bHDY1xlLzQMOMToOnm0cnBCv3+9sWMU4BeW/Uwi/ebQkwjdx8D0Z8Sr5womw3M3
         U8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqVfMRkZDBh7bbcYKS6Kvm9J+y7W2kSPaDMZHtzQp0ffcQy4OWoryagscdmi2t4N83OF64kEqWzNijGBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFR4H+tEVcygh0cn/GUBqC4vGC65LjhO3x3FDt6LzoUGOVMCo+
	0LA1dI66D3h8bDGX5FxHcY3eKLUxc1dDrnkxXVAkGq3rcsHpUoDpw4Rh9lVasM3teHL85c3nC8b
	GAyuHVUiEpZerSHHVj9wNYiDEgbOO1XmWxVP+VYVbpCEO4NKHn+WGNK5VuUI=
X-Google-Smtp-Source: AGHT+IGUeqqXH7JnJl0XnXlgubaYKaZmkIQ2UiMnzIVX2xoGWnIZU4fRi6S0kQn3mnuQ4B0SZr04qmGCKBFaDSYF+gnFu9nsshr9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3e3:fd25:f6a with SMTP id
 e9e14a558f8ab-3e57e8ad57dmr134647105ab.11.1755400742813; Sat, 16 Aug 2025
 20:19:02 -0700 (PDT)
Date: Sat, 16 Aug 2025 20:19:02 -0700
In-Reply-To: <20250817024904.4820-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a14a26.050a0220.e29e5.0053.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
From: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in usbtmc_interrupt

usbtmc 1-1:16.0: invalid notification: 73
usbtmc 1-1:16.0: invalid notification: 33
usbtmc 1-1:16.0: invalid notification: 36
usbtmc 1-1:16.0: invalid notification: 8
==================================================================
BUG: KASAN: slab-out-of-bounds in usbtmc_interrupt+0x4c7/0x690 drivers/usb/class/usbtmc.c:2313
Read of size 1 at addr ffff88801eac7cc1 by task kworker/u9:2/5912

CPU: 1 UID: 0 PID: 5912 Comm: kworker/u9:2 Not tainted 6.17.0-rc1-next-20250815-syzkaller-g1357b2649c02-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: hci0 hci_cmd_timeout
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 usbtmc_interrupt+0x4c7/0x690 drivers/usb/class/usbtmc.c:2313
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
RIP: 0010:console_flush_all+0x7f7/0xc40 kernel/printk/printk.c:3227
Code: 48 21 c3 0f 85 e9 01 00 00 e8 35 43 1f 00 48 8b 5c 24 20 4d 85 f6 75 07 e8 26 43 1f 00 eb 06 e8 1f 43 1f 00 fb 48 8b 44 24 28 <42> 80 3c 20 00 74 08 48 89 df e8 fa c0 82 00 48 8b 1b 48 8b 44 24
RSP: 0018:ffffc90004047500 EFLAGS: 00000293
RAX: 1ffffffff1db912f RBX: ffffffff8edc8978 RCX: ffff88802edc9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004047650 R08: ffffffff8fe4e137 R09: 1ffffffff1fc9c26
R10: dffffc0000000000 R11: fffffbfff1fc9c27 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000200 R15: ffffffff8edc8920
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 bt_err+0x10b/0x160 net/bluetooth/lib.c:296
 hci_cmd_timeout+0xff/0x1e0 net/bluetooth/hci_core.c:1473
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5979:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:913 [inline]
 usbtmc_probe+0xa3a/0x1a60 drivers/usb/class/usbtmc.c:2457
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

The buggy address belongs to the object at ffff88801eac7cc0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff88801eac7cc0, ffff88801eac7cc1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eac7
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a841500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 2652454751, free_ts 0
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
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:913 [inline]
 kzalloc_noprof include/linux/slab.h:1043 [inline]
 lsm_blob_alloc security/security.c:690 [inline]
 lsm_superblock_alloc security/security.c:901 [inline]
 security_sb_alloc+0x48/0x330 security/security.c:1448
 alloc_super+0x20c/0x970 fs/super.c:347
 sget_fc+0x329/0xa40 fs/super.c:761
 vfs_get_super fs/super.c:1320 [inline]
 get_tree_single+0x2f/0x150 fs/super.c:1352
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
 fc_mount fs/namespace.c:1250 [inline]
 vfs_kern_mount+0xbe/0x160 fs/namespace.c:1289
 simple_pin_fs+0xe1/0x160 fs/libfs.c:1082
 securityfs_create_dentry+0x1bf/0x4d0 security/inode.c:123
 securityfs_create_file security/inode.c:206 [inline]
 securityfs_init+0xae/0xc0 security/inode.c:346
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801eac7b80: 06 fc fc fc fa fc fc fc 00 fc fc fc 06 fc fc fc
 ffff88801eac7c00: 06 fc fc fc 00 fc fc fc 06 fc fc fc 00 fc fc fc
>ffff88801eac7c80: 00 fc fc fc 00 fc fc fc 01 fc fc fc 06 fc fc fc
                                           ^
 ffff88801eac7d00: 00 fc fc fc 06 fc fc fc 00 fc fc fc 00 fc fc fc
 ffff88801eac7d80: fa fc fc fc 06 fc fc fc fa fc fc fc 06 fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	48 21 c3             	and    %rax,%rbx
   3:	0f 85 e9 01 00 00    	jne    0x1f2
   9:	e8 35 43 1f 00       	call   0x1f4343
   e:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  13:	4d 85 f6             	test   %r14,%r14
  16:	75 07                	jne    0x1f
  18:	e8 26 43 1f 00       	call   0x1f4343
  1d:	eb 06                	jmp    0x25
  1f:	e8 1f 43 1f 00       	call   0x1f4343
  24:	fb                   	sti
  25:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 fa c0 82 00       	call   0x82c133
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e70ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6401f805169ac8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107b4442580000


