Return-Path: <linux-kernel+bounces-772352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4DB291A9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E493482104
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529BA20485B;
	Sun, 17 Aug 2025 05:30:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422420296A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408606; cv=none; b=BoMUHrO5pcjmGhT+9NCdx6+UQnXXK2ZPZeQ4mAdQ9+UCGlt07d6sZJatFjyvsaUIWwqpJsifGC2+ylmdjJ4z7Up3paLhajQ8/u55P/mHIMdu/KF2VgBJmG0kaY1CA5PeI3Cfeh3vdnBg6rpAjEUfjHFuP19neUXauecroiZXJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408606; c=relaxed/simple;
	bh=Cre6GPdPokQqUzWStxnpKSEnwFJPT3CaS1pqQAXEi6k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jrtgpNRl8JEAJKFwA0DyBJW/NyGPRFwsR848GYasqdmawliuecmsZOhWL8IkYmqGBoTYdlfUXdH3XWaP0TCYLv73NXi6F3e+gAjuujEFGKQubazXMMC/VEjszVsIZAPgYJaitt/Ago9Ld6lgia/KrRNexcymcgvz0YR3NpPMHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e6649d783bso23359965ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408603; x=1756013403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3xGLULe/5RmlRQ564WpHedq78YQhskAjRuOM8UBXvU=;
        b=Fg8WFuAu2NadwwHT+VSNBo1k2bQDQOPNrAK5JqvNLwX8tn8o1mmEauy2xPRTsXzV8/
         0HAKi7gqpjZtRD1kggYEAJnSz3lYnNGgzaqt9HllxeUiBpxtlvS18ZMECERpIBIFkmuh
         cNz9Mb0cQ1ohBrtL79EYIHEDwn0AJlV44/wQlPPGhSG13SV+IfdeCBuYwlRW03Q+MFOX
         sghIGqrpMeNCHw26o3MR4S13OdXcEPFDU9j5i7EwyZjyiliJEIV1tigeVH+pGXP+EVzE
         m1HlBr003tE13p8zqTkOGVvlkB2oC+ftipwNyrMhaUGP1bltzIRMtw/ZnFBK4uuDDiVA
         dDcw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLdLsL1JHhdk+S/S3XOuyEogIv+fVcNQRX27iWO6mgISQfzppTZywe5jis11r7+PLu51QmB+34Dw9S7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O2t3j3Bq1iUhshp6X1oIGCXmaZTd861tgUp51wWDk5Dt7W92
	RRBJIJfHR4zKrv7TivDYVI6lmX56IRcK7lqk3YQ8nAXLscessaxxLwnN50afQ0l6HjcsFrjmZL7
	GjYtCCE2jEFbYMZi6KcmSUTRoW/EMZ91SQjm+Web9Jl0F04Fw6wumCoTw/s0=
X-Google-Smtp-Source: AGHT+IF79Sfpw+ObteQXfCmx6qtEymjSqfrZu1EQRp5Ek8RuWqYTVhcMEBFh/Uq1kGDleK3XKUM5CcIv49Cc1w3UPQGd4LsInkqC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:3e5:4869:fdd3 with SMTP id
 e9e14a558f8ab-3e57e7fda0dmr130410555ab.7.1755408603336; Sat, 16 Aug 2025
 22:30:03 -0700 (PDT)
Date: Sat, 16 Aug 2025 22:30:03 -0700
In-Reply-To: <20250817050056.4876-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a168db.050a0220.e29e5.005b.GAE@google.com>
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
BUG: KASAN: slab-out-of-bounds in usbtmc_interrupt+0x560/0x720 drivers/usb/class/usbtmc.c:2314
Read of size 1 at addr ffff8880328ca261 by task swapper/1/0

CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc1-next-20250815-syzkaller-g1357b2649c02-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: d3 e7 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 ea 24 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 9a4dc4a4e698df00 RBX: ffffffff8196d418 RCX: 9a4dc4a4e698df00
RDX: 0000000000000001 RSI: ffffffff8c04da60 RDI: ffffffff8196d418
RBP: ffffc90000197f20 R08: ffff8880b8732f9b R09: 1ffff110170e65f3
R10: dffffc0000000000 R11: ffffed10170e65f4 R12: ffffffff8fe4e130
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff11003ad8b40
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
 </TASK>

Allocated by task 921:
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

The buggy address belongs to the object at ffff8880328ca260
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff8880328ca260, ffff8880328ca261)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x328ca
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a841500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5215, tgid 5215 (init), ts 19330584896, free_ts 18340276944
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
 ima_write_template_field_data+0x47/0x490 security/integrity/ima/ima_template_lib.c:55
 ima_eventname_init_common+0x1e0/0x240 security/integrity/ima/ima_template_lib.c:522
 ima_alloc_init_template+0x30d/0x6f0 security/integrity/ima/ima_api.c:70
 ima_store_measurement+0x1b7/0x640 security/integrity/ima/ima_api.c:376
 process_measurement+0x11eb/0x1a40 security/integrity/ima/ima_main.c:413
 ima_bprm_check+0xfd/0x200 security/integrity/ima/ima_main.c:580
 security_bprm_check+0xd9/0x270 security/security.c:1341
 search_binary_handler fs/exec.c:1660 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve+0x8ee/0x1450 fs/exec.c:1754
 do_execveat_common+0x510/0x6a0 fs/exec.c:1860
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 kasan_depopulate_vmalloc_pte+0x74/0xa0 mm/kasan/shadow.c:472
 apply_to_pte_range mm/memory.c:3143 [inline]
 apply_to_pmd_range mm/memory.c:3187 [inline]
 apply_to_pud_range mm/memory.c:3223 [inline]
 apply_to_p4d_range mm/memory.c:3259 [inline]
 __apply_to_page_range+0xb92/0x1380 mm/memory.c:3295
 kasan_release_vmalloc+0xa2/0xd0 mm/kasan/shadow.c:593
 kasan_release_vmalloc_node mm/vmalloc.c:2249 [inline]
 purge_vmap_node+0x214/0x8f0 mm/vmalloc.c:2266
 __purge_vmap_area_lazy+0x7a4/0xb40 mm/vmalloc.c:2356
 _vm_unmap_aliases+0x70f/0x7b0 mm/vmalloc.c:2951
 change_page_attr_set_clr+0x305/0xeb0 arch/x86/mm/pat/set_memory.c:2088
 change_page_attr_set arch/x86/mm/pat/set_memory.c:2129 [inline]
 set_memory_nx+0xd6/0x110 arch/x86/mm/pat/set_memory.c:2318
 free_init_pages arch/x86/mm/init.c:933 [inline]
 free_kernel_image_pages+0x85/0x100 arch/x86/mm/init.c:952
 kernel_init+0x31/0x1d0 init/main.c:1490
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880328ca100: fa fc fc fc fa fc fc fc 06 fc fc fc 06 fc fc fc
 ffff8880328ca180: 00 fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
>ffff8880328ca200: fa fc fc fc 00 fc fc fc fa fc fc fc 01 fc fc fc
                                                       ^
 ffff8880328ca280: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff8880328ca300: fa fc fc fc fa fc fc fc 04 fc fc fc fa fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	d3 e7                	shl    %cl,%edi
   2:	02 00                	add    (%rax),%al
   4:	cc                   	int3
   5:	cc                   	int3
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
  1d:	0f 00 2d 33 ea 24 00 	verw   0x24ea33(%rip)        # 0x24ea57
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


Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12aa73a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6401f805169ac8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a2e234580000


