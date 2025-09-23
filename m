Return-Path: <linux-kernel+bounces-828121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F97EB93FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE7D18A61E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671026A0EB;
	Tue, 23 Sep 2025 02:22:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A1266B66
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594126; cv=none; b=CSh4609sMJAYkXUEEe52aZm0nfS2+9DWjzAzyVtIV2GkMCDs+X6Y4rdeLhiYVCXGK+zb7y107u+mZuYtrnTaatzzMP6LJfQM0DzDsAQBmqq9qi8O5DTt2nex7Hdf/jHKNPu46q/ForlkmLn9ll4ddUaF29CY0u9cCVJR6N58xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594126; c=relaxed/simple;
	bh=Z8aUsHRMVbnWAW+8mh3S9aKszO7VIGYji4vWsrDehJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pi5E5a8FSPHaDgN5aXDpKCM/TESVt+H0klMiAkU4ThvYjwo+niWemgy4jBcdb2JESv+s6NThvayKMFGivwIpDmOhTF41wHcp5fW4/b8X0ANOpnWOHUNeMVocOGyqPX5kn1Qab2veNHAezxa8HyO3BDuL8cB0Gk3OHIeSWDFmrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42408b5749aso86396735ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758594124; x=1759198924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06lkVlDDQfGhZ6/srfffhOT5YyoQjEeL3ho/ZVuyAHY=;
        b=xQJXeK4YYR7a3PSvdz7lW/gpty4qTRrX7BMpUdq8R8T94xIb6zINPJqC586upeORpS
         UZL7PXCeGqLH9u1TbtsOhy7fhE2uFS94mOAFBRtjdVKQqXUkN9o3qAqIO06PAxD0bfTX
         ekM/uo5F1TKWDy/+TvWudZw5kMG56PV7liOL/IctoiL1bk1/d2b2Mbes/rmrQzguJX2b
         lhollKuemX7onKxfSuGnVsxOdVEL5ACu5c4ZUNuKi+jLMRuDwce5Sh8I/MZ28En3Fq7q
         PHy+XvPqn+63syE32d3L4DjWID6bUAaF3qigUID+ugaNaHJlR2hZBPh9I5uY5m7snaks
         g+yw==
X-Forwarded-Encrypted: i=1; AJvYcCXR8mDitrTiRyhTE/EMVJyfDHJhWn6G+pAvGCeL58eem04m4XX4ezaYwxFR6hn98q0kOG3LtJSo87YJM6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHT117TslevoKz/AuXApK00OrvlQJJNIzl520cEkYMuc8BJub
	U5eHHkeyHyqOBgEelx1T6f8ERyY3LpukdDIrZRr2TG6i7DCt3958PDgcFtoRzXqTsoPgwC9BrhY
	MtTb+PTfNKsvLhPWC75w5Gl+uDfDp1caSHwIM8RGOCLnzOriN/ZZ4AwYGSBs=
X-Google-Smtp-Source: AGHT+IFH0leAWLWjMMtmma9mFw3w9YMa8e78Ba84vjqi/I5xJ85w5V33lgYGvu+xfcQ9j79Z9RJNqfU/PE+CMgOJd+Xv7GELQ6o4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:425:70ad:799e with SMTP id
 e9e14a558f8ab-42582315dcemr17036405ab.10.1758594123859; Mon, 22 Sep 2025
 19:22:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:22:03 -0700
In-Reply-To: <20250923004810.7419-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2044b.a70a0220.1b52b.000a.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
From: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in snd_usbmidi_in_urb_complete

==================================================================
BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
Write of size 1 at addr ffff88805cb67943 by task kworker/u8:7/1159

CPU: 1 UID: 0 PID: 1159 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: netns cleanup_net
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
 __usb_hcd_giveback_urb+0x38b/0x610 drivers/usb/core/hcd.c:1661
 usb_hcd_giveback_urb+0x39b/0x450 drivers/usb/core/hcd.c:1745
 dummy_timer+0x1814/0x3a30 drivers/usb/gadget/udc/dummy_hcd.c:1995
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x202/0xad0 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1842
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x9a2/0xc60 kernel/printk/printk.c:3227
Code: 00 e8 b2 d3 28 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 30 e8 20 00 48 85 db 0f 85 55 01 00 00 e8 b2 ec 20 00 fb 4c 89 e0 <48> c1 e8 03 42 80 3c 38 00 0f 84 11 ff ff ff 4c 89 e7 e8 67 5f 86
RSP: 0018:ffffc900038ff550 EFLAGS: 00000293
RAX: ffffffff8f2f1698 RBX: 0000000000000000 RCX: ffffffff819ab010
RDX: ffff888028051e00 RSI: ffffffff819ab01e RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 615f6e616d746162 R12: ffffffff8f2f1698
R13: ffffffff8f2f1640 R14: ffffc900038ff5e0 R15: dffffc0000000000
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 _printk+0xc7/0x100 kernel/printk/printk.c:2475
 batadv_hardif_disable_interface+0x2b2/0xe70 net/batman-adv/hard-interface.c:826
 batadv_meshif_destroy_netlink+0x79/0x150 net/batman-adv/mesh-interface.c:1106
 default_device_exit_batch+0x769/0xaf0 net/core/dev.c:12728
 ops_exit_list net/core/net_namespace.c:204 [inline]
 ops_undo_list+0x363/0xab0 net/core/net_namespace.c:251
 cleanup_net+0x408/0x890 net/core/net_namespace.c:682
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6562:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 snd_usbmidi_in_endpoint_create+0x8c/0xa70 sound/usb/midi.c:1345
 snd_usbmidi_create_endpoints_midiman+0x4c4/0xaf0 sound/usb/midi.c:2372
 __snd_usbmidi_create+0x14a4/0x1e90 sound/usb/midi.c:2655
 snd_usb_midi_v2_create+0x1ad/0x42d0 sound/usb/midi2.c:1178
 snd_usb_create_quirk+0xad/0x140 sound/usb/quirks.c:541
 usb_audio_probe+0x7f7/0x3cf0 sound/usb/card.c:976
 usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6562:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4894
 snd_usbmidi_free sound/usb/midi.c:1539 [inline]
 snd_usbmidi_rawmidi_free+0xb3/0x130 sound/usb/midi.c:1600
 snd_rawmidi_free.part.0+0x398/0x560 sound/core/rawmidi.c:1934
 snd_rawmidi_free sound/core/rawmidi.c:1923 [inline]
 snd_rawmidi_dev_free+0x3e/0x60 sound/core/rawmidi.c:1945
 __snd_device_free+0x1a7/0x410 sound/core/device.c:76
 snd_device_free_all+0xf3/0x220 sound/core/device.c:233
 snd_card_do_free sound/core/init.c:587 [inline]
 release_card_device+0x77/0x1d0 sound/core/init.c:153
 device_release+0xa4/0x240 drivers/base/core.c:2565
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3797
 snd_card_free_when_closed sound/core/init.c:618 [inline]
 snd_card_free_when_closed sound/core/init.c:612 [inline]
 snd_card_free+0x11a/0x190 sound/core/init.c:650
 usb_audio_probe+0x1507/0x3cf0 sound/usb/card.c:1034
 usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88805cb67800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 323 bytes inside of
 freed 512-byte region [ffff88805cb67800, ffff88805cb67a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88805cb65400 pfn:0x5cb64
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b841c80 ffffea0001cc1910 ffffea0000c27910
raw: ffff88805cb65400 000000000010000a 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801b841c80 ffffea0001cc1910 ffffea0000c27910
head: ffff88805cb65400 000000000010000a 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea000172d901 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6539, tgid 6539 (kworker/1:8), ts 490477154046, free_ts 189435416717
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab mm/slub.c:2660 [inline]
 new_slab+0x247/0x330 mm/slub.c:2714
 ___slab_alloc+0xcf2/0x1750 mm/slub.c:3901
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3992
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 device_private_init drivers/base/core.c:3534 [inline]
 device_add+0xccc/0x1aa0 drivers/base/core.c:3585
 snd_register_device+0x328/0x4d0 sound/core/sound.c:278
 snd_ctl_dev_register+0x77/0x1b0 sound/core/control.c:2296
 __snd_device_register sound/core/device.c:149 [inline]
 snd_device_register_all+0x10f/0x1b0 sound/core/device.c:197
 snd_card_register+0x106/0x7c0 sound/core/init.c:893
 try_to_register_card+0x1d7/0x370 sound/usb/card.c:856
 usb_audio_probe+0xe96/0x3cf0 sound/usb/card.c:1025
 usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
page last free pid 6554 tgid 6553 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 __kmalloc_cache_noprof+0x1f1/0x3e0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 dev_new drivers/usb/gadget/legacy/raw_gadget.c:192 [inline]
 raw_open+0x8b/0x500 drivers/usb/gadget/legacy/raw_gadget.c:434
 misc_open+0x35d/0x420 drivers/char/misc.c:161
 chrdev_open+0x234/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x982/0x1530 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4046
 do_filp_open+0x20b/0x470 fs/namei.c:4073
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805cb67800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805cb67880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805cb67900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88805cb67980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805cb67a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	00 e8                	add    %ch,%al
   2:	b2 d3                	mov    $0xd3,%dl
   4:	28 00                	sub    %al,(%rax)
   6:	9c                   	pushf
   7:	5b                   	pop    %rbx
   8:	81 e3 00 02 00 00    	and    $0x200,%ebx
   e:	31 ff                	xor    %edi,%edi
  10:	48 89 de             	mov    %rbx,%rsi
  13:	e8 30 e8 20 00       	call   0x20e848
  18:	48 85 db             	test   %rbx,%rbx
  1b:	0f 85 55 01 00 00    	jne    0x176
  21:	e8 b2 ec 20 00       	call   0x20ecd8
  26:	fb                   	sti
  27:	4c 89 e0             	mov    %r12,%rax
* 2a:	48 c1 e8 03          	shr    $0x3,%rax <-- trapping instruction
  2e:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  33:	0f 84 11 ff ff ff    	je     0xffffff4a
  39:	4c 89 e7             	mov    %r12,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	67 5f                	addr32 pop %rdi
  3f:	86                   	.byte 0x86


Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176338e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fad712580000


