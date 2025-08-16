Return-Path: <linux-kernel+bounces-771660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9292AB28A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEB0AC25A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DB19004E;
	Sat, 16 Aug 2025 03:07:37 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DC199931
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313657; cv=none; b=tpfMBpW52mxNO8a3Ya61y48U+JeKE7DfL82zqnWOvSUUIKj9IL4ftCE0DaO4ibrorF5Z9H2A+GafAzFVxoRzkgG3CFQJjbq7zPcy2MY9rXT1jtJpCTsZJpQUyM3kPPsGeJQ5Cfipt8CH/BlGMuGZ4PSsnsdEG1MqVvQJRAjnjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313657; c=relaxed/simple;
	bh=V1ATMUNa7pMKDITSeqWY+VNk5t+0qXH1EE76ax+fnAs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qHePM5vgyNi3EqKrCoGXbCG2xs8GvkmmIBEruYZMiy/zl9hWfWA7GiPiGtJFiVCJBTjcUzzcdH8NbrrEE6ZuXP3qeolNu6qZl9qOWasTIRNgLlTo1yyL5QhaUMBkOcQsQszdjt4eAvsRUtGnQkXPaqHxg8F+ji7uBcT60ogjaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e57004f324so63396785ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755313654; x=1755918454;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbJrwQqnxTd9suFAwa+07SGJkIdeKTaxYA/qCVH7DCE=;
        b=B5FRpMjOUXBB8UNyfIa+W92gzzL66luj9b48l0M+96K0oy3jPWCWqrt5KXOG4YdmQy
         l7FyM/fEly8RuMSoF6iNSM4ZRQ37sVymC2udR0AP+DnyiS2e7MsziZSxj4HuX/wI9Q2h
         crL55homgvIY9xocL/mUSLXnivVm6WFsRTWuL1jVcOyN8DCjmllhpWDRP96Tyqe164IJ
         F7rKQcru/FRfusmUH718R1x4GOlVnvNMO31Q+kkpuowdsGtJ6fb2nxZuivT98rWr9kBF
         z32WXL0PnW02aBoqac+pT6MniBJqmM6i33MET18/u1tENDziRAE1RNhvdLFK50Gd5h1k
         8vpw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5FysX9IoifSW0/SHrL7V2rNAUgI9F1Kf8+CjH5gRyrJEHn3DDNnOYHYOfbxQeg1ydQPFXV+brtiXc9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAmE+cwCVa+qanO1TeUT73aU62t+VQC5hskxd3uB8eA3JCnr+
	E7vQWo2Y3xzb1syljmOhXs9VWKrelu3Wzg+FLz/pFWpNFMrj9YXoqeGOUc519rLutvRHsiPvd9V
	cF5L8cSTEDvOQuWkREHHre6f6Fs9UToWIts1qo1rinCbLuDLfC71GVptUMc4=
X-Google-Smtp-Source: AGHT+IEMr6aX5/qH77PNtn5OMVUJTUSGl8SfXqFhmLUVyYSLa+aoyLnhaPlewkWddpSYKwm0x/U0UnoDPnbTEX8MqxyAOxoGcF0t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3601:b0:3e5:4002:e822 with SMTP id
 e9e14a558f8ab-3e5838063d7mr31825865ab.12.1755313654503; Fri, 15 Aug 2025
 20:07:34 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:07:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ff5f6.050a0220.e29e5.0032.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
From: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ef65a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a99842580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17108da2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68e3ffeee4c1/disk-931e46dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3cc40de4a0c3/vmlinux-931e46dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aed3e4f6a518/bzImage-931e46dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com

usbtmc 1-1:16.0: invalid notification: 33
usbtmc 1-1:16.0: invalid notification: 36
usbtmc 1-1:16.0: invalid notification: 8
==================================================================
BUG: KASAN: slab-out-of-bounds in usbtmc_interrupt+0x4c7/0x690 drivers/usb/class/usbtmc.c:2313
Read of size 1 at addr ffff8880291a69a1 by task swapper/1/0

CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 53 e8 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 1a 25 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 01516c1b89febd00 RBX: ffffffff8196d368 RCX: 01516c1b89febd00
RDX: 0000000000000001 RSI: ffffffff8c04d960 RDI: ffffffff8196d368
RBP: ffffc90000197f20 R08: ffff8880b8732f9b R09: 1ffff110170e65f3
R10: dffffc0000000000 R11: ffffed10170e65f4 R12: ffffffff8fe4db30
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff11003a55b40
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
 </TASK>

Allocated by task 44:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:913 [inline]
 usbtmc_probe+0xa3a/0x1a60 drivers/usb/class/usbtmc.c:2456
 usb_probe_interface+0x665/0xc30 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3689
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9e0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:831
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1031
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3689
 usb_new_device+0xa39/0x16f0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2958/0x4a20 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880291a69a0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff8880291a69a0, ffff8880291a69a1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x291a6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a841500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 16852153284, free_ts 0
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
 __kmalloc_node_track_caller_noprof+0x2f8/0x4e0 mm/slub.c:4384
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 __kernfs_new_node+0x9c/0x7e0 fs/kernfs/dir.c:633
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:713
 kernfs_create_dir_ns+0x44/0x130 fs/kernfs/dir.c:1083
 sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x59f/0xb40 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x155/0x220 lib/kobject.c:426
 device_add+0x408/0xb50 drivers/base/core.c:3627
 usb_create_ep_devs+0x12c/0x230 drivers/usb/core/endpoint.c:170
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880291a6880: 04 fc fc fc 04 fc fc fc 06 fc fc fc 04 fc fc fc
 ffff8880291a6900: 06 fc fc fc 06 fc fc fc fa fc fc fc fa fc fc fc
>ffff8880291a6980: fa fc fc fc 01 fc fc fc 00 fc fc fc 00 fc fc fc
                               ^
 ffff8880291a6a00: 00 fc fc fc 06 fc fc fc 06 fc fc fc 06 fc fc fc
 ffff8880291a6a80: 07 fc fc fc 06 fc fc fc 06 fc fc fc 06 fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	e8 02 00 cc cc       	call   0xcccc0008
   6:	cc                   	int3
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	f3 0f 1e fa          	endbr64
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d 33 1a 25 00 	verw   0x251a33(%rip)        # 0x251a57
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

