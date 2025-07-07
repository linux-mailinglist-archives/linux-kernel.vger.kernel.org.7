Return-Path: <linux-kernel+bounces-720385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E1AFBAE7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3956B164671
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5106F264A7C;
	Mon,  7 Jul 2025 18:41:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F221A23B5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913666; cv=none; b=bQFlhCsRNY9nA8/PMzqgCbpxCEa1xEcIbYDG8bqL+364+Vtt5GhpvcEnQIjBAtjNmtUyDWzkqPGYZpny5xUQRifsN4PmP7KL0jnBXKM7K+65gw14gH08tFiN9gevFQS6RLvOZDd3d1n1TMQ5F+9N7O6R0ivqJm4FcbqCv/dgLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913666; c=relaxed/simple;
	bh=ES1za4vqzXm21bRDBaoW/P/pJuUWZ+y0PujhqniQa+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yp2zZVNvDTVWjQg47zpgdpClLL4LtMKoSJReKTBoabwQwJtmYPc6+fYd2qy4qAjOWui1gcHpCcvRzJs/5mpqMrh4iwJ+ZS0KRqMcj4VOjGZmhXGbO3p1DCFHXkFlXLnq7WJW3SFeu7fVBuLOVfs3f7B6ugZS5wUVmgEtoJIe5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86f4f032308so686834339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913664; x=1752518464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZunGBWy8hi4y27QyRXGUyh3DWNFQQ7fVgEuFtuxcto=;
        b=NqRwSM2b689Dkv1b5Yid/RQ3PEwRkyOKNctM0NREE76jBfI1Kz1mRp1rDQPZCgqZoU
         /ozNbWRuapU9q6fs6Hbt9tlOTRo/X15Ue+UioVT/RgWVn57XKaCNVgmGucDfgDwIj237
         /qlTbnMoEOHW9oPFpT748fTy2J8qH7UxQrAt8ykAtfvI1eTbiXMIClyM8xWuU5FzfBvk
         LtHzfZ96J7uuPthczgJ+wJxILF+bWKT/Pl3puvmi0Ymuo74ooqyRzL0ItYcQfwkfIJRQ
         VuK/d43Z+rMQ98gkpBT8cWtDIKeupnXzbR8Hv2rWY8VTouNQpTzY8fpytdPu0UGbkbYF
         86Ng==
X-Forwarded-Encrypted: i=1; AJvYcCULl+ZzxbTDvDkDARxpjGQ6K5mXW4rpuE+Z26IvvvfZHiu2go/vSoxCSDHWzq5LuTSjlU+H70YnOqolJgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL81+C0kenikGsoHSb5U0VPGNUfcsvjLwbgkrSxyHUDX0f51fK
	paie2djorKlsQ4j8kKKaPVxV6GtFjh03hCam7XX94aVD+bKNgu7oNfF2VoC+DgKcrKagSWjFvhS
	xlWxu8laQptRh9cVJ2wCV8uV+VNW8qSXbS0I1GyR1oD+pGwbJi9SKR5Be+6Q=
X-Google-Smtp-Source: AGHT+IHwKFgWDQCWFP7CzRt0fx6hJ7/7e54E5UmRcEeQJJ5fo9CxpcV4p9rt/sZG7WA7CO+M6PlPvzWXuMhnbtBGFZIcHfAsph6Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3895:b0:86c:e686:ca29 with SMTP id
 ca18e2360f4ac-8794b4478d6mr17329039f.2.1751913664093; Mon, 07 Jul 2025
 11:41:04 -0700 (PDT)
Date: Mon, 07 Jul 2025 11:41:04 -0700
In-Reply-To: <5de04492-01d3-4b2c-b3f4-8c2237dfed6a@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c14c0.a00a0220.6237c.0000.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in mon_copy_to_buff
From: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	manas18244@iiitd.ac.in, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in mon_copy_to_buff

microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
usbhid 1-1:0.0: count 0 reportnum 0 buf[0] 0
==================================================================
BUG: KASAN: slab-out-of-bounds in mon_copy_to_buff+0xc2/0x170 drivers/usb/mon/mon_bin.c:252
Read of size 3904 at addr ffff8880222d53c1 by task kworker/1:2/3689

CPU: 1 UID: 0 PID: 3689 Comm: kworker/1:2 Not tainted 6.16.0-rc5-syzkaller-dirty #0 PREEMPT(full) 
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
 usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:929 [inline]
 usbhid_raw_request+0x29a/0x710 drivers/hid/usbhid/hid-core.c:1300
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
 usbhid_probe+0xd38/0x13f0 drivers/hid/usbhid/hid-core.c:1436
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

Allocated by task 3689:
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
 usbhid_probe+0xd38/0x13f0 drivers/hid/usbhid/hid-core.c:1436
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

The buggy address belongs to the object at ffff8880222d53c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes inside of
 allocated 7-byte region [ffff8880222d53c0, ffff8880222d53c7)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x222d5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b841500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 2690993754, free_ts 0
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
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4347
 __kmemdup_nul mm/util.c:63 [inline]
 kstrdup+0x53/0x100 mm/util.c:83
 kstrdup_const+0x63/0x80 mm/util.c:103
 __kernfs_new_node+0x9b/0x8e0 fs/kernfs/dir.c:633
 kernfs_new_node+0x13c/0x1e0 fs/kernfs/dir.c:713
 kernfs_create_link+0xcc/0x240 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x90/0x140 fs/sysfs/symlink.c:44
 sysfs_do_create_link fs/sysfs/symlink.c:80 [inline]
 sysfs_create_link+0x61/0xc0 fs/sysfs/symlink.c:92
 device_add_class_symlinks drivers/base/core.c:3451 [inline]
 device_add+0x62c/0x1a70 drivers/base/core.c:3643
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880222d5280: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff8880222d5300: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
>ffff8880222d5380: fa fc fc fc 00 fc fc fc 07 fc fc fc 00 fc fc fc
                                           ^
 ffff8880222d5400: 00 fc fc fc 00 fc fc fc 00 fc fc fc 00 fc fc fc
 ffff8880222d5480: 00 fc fc fc 00 fc fc fc 00 fc fc fc 00 fc fc fc
==================================================================


Tested on:

commit:         d7b8f8e2 Linux 6.16-rc5
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=10c82bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51185bd4f40ad44
dashboard link: https://syzkaller.appspot.com/bug?extid=8258d5439c49d4c35f43
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1553428c580000


