Return-Path: <linux-kernel+bounces-720088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400FAFB6E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9BE1AA7466
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C22E1C4E;
	Mon,  7 Jul 2025 15:05:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FB2E1C4B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900730; cv=none; b=Oc2mkGBXvD15er6vNRMH+g82hUr4TdoPTZyt0WaR4PpnbSBq1qa4RW5suI+QS1mA5NrcEJtx2MZJLt5kLvlHbYixG+HRGQFUVtO2oOPnCZD5LrY0VQHicwUBuZbS59wZ+s4ghhEkNbeBtAQnE/yjXrWRxKqoab+zjHJFbfPyFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900730; c=relaxed/simple;
	bh=tLsEvmpTEPZ7Au+JKedPt8SHI/CTNLdgOImtudHZkNc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SkVHIQKOYeG7Pu97kSWty5BmWvRQt8J7T7SdlxXzuaXOwNnEqFLLa7Izq/Bbhbvr7buDcBcshYqYEZ/GgtQoqfZtc59DN4eWcLlhvxa2SIedjx2etPdEYFt+QPYh6cTmcAesRBoxj0sFarVqbfmW7KiCoLRHUi1BLeRO4i2nCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e0574d6a99so38285525ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900728; x=1752505528;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNK9KFPckXoa55Cd3vuOw1L+hneZ7XqFUJyiYXLlMo4=;
        b=maFp3jn15k1NxwvqAQYYAhOYCyzb34B0KnprI4gm+STW5y//rApsYD3ybmMMNRDbJq
         z0syn+dymeDWP3IfYVoBllr/wWYg4k9subPZD26grF0MMYPWcE1hT91mwh6uRjMeHJHV
         /u61ufrhL6P5XCzbMpqFGiWAZX4qPKUfp7f7ufetRzw/BublLV/zKCVAucRvZXznqAt7
         z8CsBSARk0OitLmowvyIK1kwAAIU4jSUToxdhKEB2hWNkk7mzLhnkA5bQNs1xg5XS6Pn
         y/NLQqVlv9+kkbq0ruDzkCd4ns/1j4lmyuYesGoZQDkSCmaU9M3Vvm9fBFl6SbYzDfDb
         ndNA==
X-Forwarded-Encrypted: i=1; AJvYcCUrZHQ2igtLCNWbQX7yYux7gURT/1r6iftKyw/ZjUt+664xJyxtanmHcG0ZqeUv7S0WQePRbiNJ3L2Vgt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1xU0pLSYhU9wgL9KsahtDs34fmEh/0zjYqeOD980S390X6xy
	JEkV4GObbY8Sqcfi8iglTZ75XXTCUBKtZhh/1+TBYoDZA61154OjXJF1/lLObfsNHm/P8fYL2Nv
	c9nvuOY7adCkln1OeoftyziytJwpbwFVfCav2WMTWl/sri6Jf6lDNX62OCd8=
X-Google-Smtp-Source: AGHT+IFWPfN1QvdHixA3oOfUrmekFjgZBZ7s0/ZGhIqfW68BYn0kzzhRyjGj3aL+9Pl2Pa0raddeMGzPLxcsndHdS32vTxV+NhGN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:3df:3464:ab86 with SMTP id
 e9e14a558f8ab-3e13ee94da1mr85042135ab.9.1751900727622; Mon, 07 Jul 2025
 08:05:27 -0700 (PDT)
Date: Mon, 07 Jul 2025 08:05:27 -0700
In-Reply-To: <686bb229.a00a0220.c7b3.0081.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686be237.a70a0220.29fe6c.0b0c.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in mon_copy_to_buff
From: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e89582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51185bd4f40ad44
dashboard link: https://syzkaller.appspot.com/bug?extid=8258d5439c49d4c35f43
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b3cbd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b19f70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f933e0e4a6c5/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a82be954c91b/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66dbc3de1264/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com

microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
==================================================================
BUG: KASAN: slab-out-of-bounds in mon_copy_to_buff+0xc2/0x170 drivers/usb/mon/mon_bin.c:252
Read of size 3904 at addr ffff8880216bc6e1 by task kworker/0:2/1204

CPU: 0 UID: 0 PID: 1204 Comm: kworker/0:2 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 mon_copy_to_buff+0xc2/0x170 drivers/usb/mon/mon_bin.c:252
 mon_bin_get_data drivers/usb/mon/mon_bin.c:420 [inline]
 mon_bin_event+0x1071/0x2050 drivers/usb/mon/mon_bin.c:606
 mon_bus_submit+0xcf/0x140 drivers/usb/mon/mon_main.c:89
 usbmon_urb_submit include/linux/usb/hcd.h:724 [inline]
 usb_hcd_submit_urb+0x12d/0x1c60 drivers/usb/core/hcd.c:1518
 usb_submit_urb+0x87c/0x1790 drivers/usb/core/urb.c:581
 usb_start_wait_urb+0x104/0x4b0 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x326/0x4a0 drivers/usb/core/message.c:154
 usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:928 [inline]
 usbhid_raw_request+0x58f/0x700 drivers/hid/usbhid/hid-core.c:1299
 __hid_request+0x296/0x3c0 drivers/hid/hid-core.c:1989
 hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1950 [inline]
 hidinput_connect+0x1ada/0x2bd0 drivers/hid/hid-input.c:2327
 hid_connect+0x13f3/0x1a60 drivers/hid/hid-core.c:2239
 hid_hw_start drivers/hid/hid-core.c:2354 [inline]
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2345
 ms_probe+0x195/0x500 drivers/hid/hid-microsoft.c:391
 __hid_device_probe drivers/hid/hid-core.c:2724 [inline]
 hid_device_probe+0x360/0x720 drivers/hid/hid-core.c:2761
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 hid_add_device+0x373/0xa60 drivers/hid/hid-core.c:2907
 usbhid_probe+0xd38/0x13f0 drivers/hid/usbhid/hid-core.c:1435
 usb_probe_interface+0x303/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_new_device+0xd07/0x1a20 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2eb7/0x4fa0 drivers/usb/core/hub.c:5948
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 1204:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4340
 __hid_request+0x2c/0x3c0 drivers/hid/hid-core.c:1980
 hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1950 [inline]
 hidinput_connect+0x1ada/0x2bd0 drivers/hid/hid-input.c:2327
 hid_connect+0x13f3/0x1a60 drivers/hid/hid-core.c:2239
 hid_hw_start drivers/hid/hid-core.c:2354 [inline]
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2345
 ms_probe+0x195/0x500 drivers/hid/hid-microsoft.c:391
 __hid_device_probe drivers/hid/hid-core.c:2724 [inline]
 hid_device_probe+0x360/0x720 drivers/hid/hid-core.c:2761
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 hid_add_device+0x373/0xa60 drivers/hid/hid-core.c:2907
 usbhid_probe+0xd38/0x13f0 drivers/hid/usbhid/hid-core.c:1435
 usb_probe_interface+0x303/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_new_device+0xd07/0x1a20 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2eb7/0x4fa0 drivers/usb/core/hub.c:5948
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880216bc6e0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes inside of
 allocated 7-byte region [ffff8880216bc6e0, ffff8880216bc6e7)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x216bc
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b841500 ffffea00009fbac0 dead000000000002
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 2412854036, free_ts 2374376433
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 acpi_ns_internalize_name+0x144/0x220 drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked+0x163/0x310 drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x4c/0x70 drivers/acpi/acpica/nsutils.c:726
 acpi_get_handle+0x105/0x270 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x7a/0xc0 drivers/acpi/utils.c:672
 acpi_show_attr drivers/acpi/device_sysfs.c:560 [inline]
 acpi_attr_is_visible+0x435/0x540 drivers/acpi/device_sysfs.c:588
 create_files fs/sysfs/group.c:65 [inline]
 internal_create_group+0x501/0xf30 fs/sysfs/group.c:183
 internal_create_groups+0x9d/0x150 fs/sysfs/group.c:223
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 __kmem_cache_do_shrink+0x30b/0x380 mm/slub.c:6137
 acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1605
 acpi_purge_cached_objects+0x86/0x100 drivers/acpi/acpica/utxface.c:239
 acpi_initialize_objects+0x47/0xa0 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init drivers/acpi/bus.c:1367 [inline]
 acpi_init+0x168/0xb60 drivers/acpi/bus.c:1456
 do_one_initcall+0x120/0x6e0 init/main.c:1274
 do_initcall_level init/main.c:1336 [inline]
 do_initcalls init/main.c:1352 [inline]
 do_basic_setup init/main.c:1371 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1584
 kernel_init+0x1c/0x2b0 init/main.c:1474
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880216bc580: fa fc fc fc fa fc fc fc 00 fc fc fc fa fc fc fc
 ffff8880216bc600: 00 fc fc fc 00 fc fc fc fa fc fc fc 00 fc fc fc
>ffff8880216bc680: fa fc fc fc fa fc fc fc 00 fc fc fc 07 fc fc fc
                                                       ^
 ffff8880216bc700: 00 fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff8880216bc780: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

