Return-Path: <linux-kernel+bounces-834938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FDBA5E08
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65942A70EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2302DAFC7;
	Sat, 27 Sep 2025 10:55:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E62DAFA1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758970505; cv=none; b=S/eD3Ozd6SkAXKBcHxfoQECk2nWeOntjBcsyeznedqEGGKMum2jW5C5bYEQqn5ZnXhP71RyMGp4dFbn5MZcJScCpzxhJw86iNIpc5af86/XlvpIPUiYZZy/QdjhjRiJ/cYCBda8jkW/opqMZAPty1qJFq392xD6kOW5nCy5WMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758970505; c=relaxed/simple;
	bh=oXO9XDbyDZKopICA7aQuVGmSUHXoSvVkS0M/dbGuzsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Os952X1gQOVP82CZ7hL5mc+1VYwHSa3MBBb5UV2zIMfzKQKs198ljPLdaV9ofX56PgI3uOqzbVKD6qH6TYrPXf94Y0R2BCtPMVApMwyD+I/+yu6yPmXh1BdZJUNdkRxT/fS92kOKtgDIAF4xPC0zHO/yW2BIJa0Ux92g5BWQk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso24631605ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758970502; x=1759575302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2K+tVU5FMx+175Hx0g+Yfn/64/CVwp9ZJV98Q/H8q0=;
        b=ShPU9iYCPs5ek/9Q8vNyI2Bun2kj+pvs8D1HC+aj2FFH1Vb0idLz1QDLDF7QNgi9Mp
         kUgofL4dRkLoIq5UJSL945KJAHlnD4Or1khtFnOvst/+OO7Iw0J9ueR5Obf58DDNTGIu
         nltDHEUCntEIBuT4ckQjxhajZ48HFk9eYngvcXqmyVTVKW9Fe7VKjwwmcvDl24nDLKJR
         BbgykKrkKRajGlWcIzmdDj4UBnV9ZxWxsD2mcX6RhBUANJmPhUlednU5YmA1l6ghXtPn
         s//qvt2ehwTnArgbUJy8l+L5wVppbJmNbEtj4iueWB1RSgULQ8XPJAIJROhshJnxMr1h
         cVEg==
X-Forwarded-Encrypted: i=1; AJvYcCW/zHExHhUX+cyEM1dEhSTOIAO7AJZshCWQ7HJ3mj8T0XnaS0TVGLOkEo5/PRWEqnr66qvq0aqjmIrwhTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaHFSYfMe27BvPQrTYsQ90h7FOXywlPUkQiwlCRivFDTa/M2ta
	etj29eSVKu39Jiwi5griHRkQFrlpTb5Zb0raks7mHJbMfg0qdUgfFUMFZ/cHpPQHVK86yL3LdMk
	nfZcctPdPJcUh/3mErKHtKFiSiMDX5WJohWgWec3xO11lWGibuhgMhFWnAos=
X-Google-Smtp-Source: AGHT+IFoGaQu2VPAvL0j7hy265yCT3OV0GSsxdn2lOv3GLu1LYMlY5RHRXGWUs7mkSqviTgOZ6CDdsRKjjD+f25Oyl5ySdz5dVa+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c87:b0:425:8c47:1404 with SMTP id
 e9e14a558f8ab-425955b0a66mr76223605ab.7.1758970501836; Sat, 27 Sep 2025
 03:55:01 -0700 (PDT)
Date: Sat, 27 Sep 2025 03:55:01 -0700
In-Reply-To: <87tt0o9ojm.wl-tiwai@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d7c285.050a0220.25d7ab.030b.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
From: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
To: aha310510@gmail.com, clemens@ladisch.de, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in snd_usbmidi_in_urb_complete

==================================================================
BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x368/0x410 sound/usb/midi.c:243
Read of size 8 at addr ffff88805ccd6800 by task kworker/1:1/43

CPU: 1 UID: 0 PID: 43 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 snd_usbmidi_in_urb_complete+0x368/0x410 sound/usb/midi.c:243
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
Code: 00 e8 a2 d3 28 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 20 e8 20 00 48 85 db 0f 85 55 01 00 00 e8 a2 ec 20 00 fb 4c 89 e0 <48> c1 e8 03 42 80 3c 38 00 0f 84 11 ff ff ff 4c 89 e7 e8 77 5f 86
RSP: 0018:ffffc90000b37428 EFLAGS: 00000293
RAX: ffffffff8f2f1658 RBX: 0000000000000000 RCX: ffffffff819aad70
RDX: ffff88801eab5a00 RSI: ffffffff819aad7e RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8f2f1658
R13: ffffffff8f2f1600 R14: ffffc90000b374b8 R15: dffffc0000000000
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 dev_vprintk_emit drivers/base/core.c:4914 [inline]
 dev_printk_emit+0xfa/0x140 drivers/base/core.c:4925
 __dev_printk+0xf5/0x270 drivers/base/core.c:4937
 _dev_info+0xe4/0x120 drivers/base/core.c:4983
 announce_device drivers/usb/core/hub.c:2407 [inline]
 usb_new_device+0x7d6/0x1a60 drivers/usb/core/hub.c:2675
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
 </TASK>

Allocated by task 6486:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 snd_usbmidi_in_endpoint_create+0x8c/0xa70 sound/usb/midi.c:1349
 snd_usbmidi_create_endpoints_midiman+0x4c4/0xaf0 sound/usb/midi.c:2371
 __snd_usbmidi_create+0x14a4/0x1e90 sound/usb/midi.c:2654
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

Freed by task 6486:
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
 snd_usbmidi_rawmidi_free+0xbd/0x130 sound/usb/midi.c:1599
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

The buggy address belongs to the object at ffff88805ccd6800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 freed 512-byte region [ffff88805ccd6800, ffff88805ccd6a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5ccd4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b841c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b841c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001733501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6287, tgid 6287 (syz-executor), ts 181369771590, free_ts 181363057805
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
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 fib6_info_alloc+0x40/0x160 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x14c/0x870 net/ipv6/route.c:3811
 ip6_route_add.part.0+0x22/0x1d0 net/ipv6/route.c:3940
 ip6_route_add+0x45/0x60 net/ipv6/route.c:3937
 addrconf_prefix_route+0x2fd/0x510 net/ipv6/addrconf.c:2488
 fixup_permanent_addr net/ipv6/addrconf.c:3598 [inline]
 addrconf_permanent_addr net/ipv6/addrconf.c:3622 [inline]
 addrconf_notify+0x12c6/0x19e0 net/ipv6/addrconf.c:3694
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2229
page last free pid 5524 tgid 5524 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 skb_kfree_head net/core/skbuff.c:1047 [inline]
 skb_free_head+0x114/0x210 net/core/skbuff.c:1059
 skb_release_data+0x795/0x9e0 net/core/skbuff.c:1086
 skb_release_all net/core/skbuff.c:1151 [inline]
 __kfree_skb net/core/skbuff.c:1165 [inline]
 consume_skb net/core/skbuff.c:1397 [inline]
 consume_skb+0xbf/0x100 net/core/skbuff.c:1391
 __unix_dgram_recvmsg+0x779/0xc30 net/unix/af_unix.c:2683
 unix_dgram_recvmsg net/unix/af_unix.c:2700 [inline]
 unix_seqpacket_recvmsg+0x11c/0x170 net/unix/af_unix.c:2567
 sock_recvmsg_nosec net/socket.c:1065 [inline]
 sock_recvmsg+0x1f9/0x250 net/socket.c:1087
 sock_read_iter+0x2b9/0x3b0 net/socket.c:1157
 do_iter_readv_writev+0x743/0x9e0 fs/read_write.c:825
 vfs_readv+0x4cb/0x8b0 fs/read_write.c:1018
 do_readv+0x28c/0x340 fs/read_write.c:1080
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805ccd6700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805ccd6780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805ccd6800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88805ccd6880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805ccd6900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x351/0x410 sound/usb/midi.c:243
Read of size 1 at addr ffff88802378d230 by task kworker/1:1/43

CPU: 1 UID: 0 PID: 43 Comm: kworker/1:1 Tainted: G    B               syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 snd_usbmidi_in_urb_complete+0x351/0x410 sound/usb/midi.c:243
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
Code: 00 e8 a2 d3 28 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 20 e8 20 00 48 85 db 0f 85 55 01 00 00 e8 a2 ec 20 00 fb 4c 89 e0 <48> c1 e8 03 42 80 3c 38 00 0f 84 11 ff ff ff 4c 89 e7 e8 77 5f 86
RSP: 0018:ffffc90000b37428 EFLAGS: 00000293
RAX: ffffffff8f2f1658 RBX: 0000000000000000 RCX: ffffffff819aad70
RDX: ffff88801eab5a00 RSI: ffffffff819aad7e RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8f2f1658
R13: ffffffff8f2f1600 R14: ffffc90000b374b8 R15: dffffc0000000000
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 dev_vprintk_emit drivers/base/core.c:4914 [inline]
 dev_printk_emit+0xfa/0x140 drivers/base/core.c:4925
 __dev_printk+0xf5/0x270 drivers/base/core.c:4937
 _dev_info+0xe4/0x120 drivers/base/core.c:4983
 announce_device drivers/usb/core/hub.c:2407 [inline]
 usb_new_device+0x7d6/0x1a60 drivers/usb/core/hub.c:2675
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
 </TASK>

Allocated by task 6486:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __snd_usbmidi_create+0xe4/0x1e90 sound/usb/midi.c:2534
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

Freed by task 6486:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4894
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

The buggy address belongs to the object at ffff88802378d000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 560 bytes inside of
 freed 1024-byte region [ffff88802378d000, ffff88802378d400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23788
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b841dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b841dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea00008de201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5602, tgid 5602 (start-stop-daem), ts 71829928370, free_ts 71793603330
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
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_init_log+0x1385/0x2140 security/tomoyo/audit.c:275
 tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xec2/0x20b0 security/tomoyo/domain.c:888
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12e/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x1b9/0x1e0 security/security.c:1302
 search_binary_handler fs/exec.c:1660 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve fs/exec.c:1754 [inline]
 bprm_execve+0x81a/0x1640 fs/exec.c:1730
 do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1860
page last free pid 5600 tgid 5600 stack trace:
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
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4247
 vm_area_alloc+0x1f/0x160 mm/vma_init.c:31
 __mmap_new_vma mm/vma.c:2461 [inline]
 __mmap_region+0xf90/0x27b0 mm/vma.c:2669
 mmap_region+0x1ab/0x3f0 mm/vma.c:2739
 do_mmap+0xa3e/0x1210 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:604
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802378d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802378d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802378d200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802378d280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802378d300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x3e1/0x410 sound/usb/midi.c:254
Write of size 1 at addr ffff88805ccd6943 by task kworker/1:1/43

CPU: 1 UID: 0 PID: 43 Comm: kworker/1:1 Tainted: G    B               syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 snd_usbmidi_in_urb_complete+0x3e1/0x410 sound/usb/midi.c:254
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
Code: 00 e8 a2 d3 28 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 20 e8 20 00 48 85 db 0f 85 55 01 00 00 e8 a2 ec 20 00 fb 4c 89 e0 <48> c1 e8 03 42 80 3c 38 00 0f 84 11 ff ff ff 4c 89 e7 e8 77 5f 86
RSP: 0018:ffffc90000b37428 EFLAGS: 00000293
RAX: ffffffff8f2f1658 RBX: 0000000000000000 RCX: ffffffff819aad70
RDX: ffff88801eab5a00 RSI: ffffffff819aad7e RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8f2f1658
R13: ffffffff8f2f1600 R14: ffffc90000b374b8 R15: dffffc0000000000
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 dev_vprintk_emit drivers/base/core.c:4914 [inline]
 dev_printk_emit+0xfa/0x140 drivers/base/core.c:4925
 __dev_printk+0xf5/0x270 drivers/base/core.c:4937
 _dev_info+0xe4/0x120 drivers/base/core.c:4983
 announce_device drivers/usb/core/hub.c:2407 [inline]
 usb_new_device+0x7d6/0x1a60 drivers/usb/core/hub.c:2675
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
 </TASK>

Allocated by task 6486:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 snd_usbmidi_in_endpoint_create+0x8c/0xa70 sound/usb/midi.c:1349
 snd_usbmidi_create_endpoints_midiman+0x4c4/0xaf0 sound/usb/midi.c:2371
 __snd_usbmidi_create+0x14a4/0x1e90 sound/usb/midi.c:2654
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

Freed by task 6486:
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
 snd_usbmidi_rawmidi_free+0xbd/0x130 sound/usb/midi.c:1599
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

The buggy address belongs to the object at ffff88805ccd6800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 323 bytes inside of
 freed 512-byte region [ffff88805ccd6800, ffff88805ccd6a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5ccd4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b841c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b841c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001733501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6287, tgid 6287 (syz-executor), ts 181369771590, free_ts 181363057805
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
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 fib6_info_alloc+0x40/0x160 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x14c/0x870 net/ipv6/route.c:3811
 ip6_route_add.part.0+0x22/0x1d0 net/ipv6/route.c:3940
 ip6_route_add+0x45/0x60 net/ipv6/route.c:3937
 addrconf_prefix_route+0x2fd/0x510 net/ipv6/addrconf.c:2488
 fixup_permanent_addr net/ipv6/addrconf.c:3598 [inline]
 addrconf_permanent_addr net/ipv6/addrconf.c:3622 [inline]
 addrconf_notify+0x12c6/0x19e0 net/ipv6/addrconf.c:3694
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2229
page last free pid 5524 tgid 5524 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 skb_kfree_head net/core/skbuff.c:1047 [inline]
 skb_free_head+0x114/0x210 net/core/skbuff.c:1059
 skb_release_data+0x795/0x9e0 net/core/skbuff.c:1086
 skb_release_all net/core/skbuff.c:1151 [inline]
 __kfree_skb net/core/skbuff.c:1165 [inline]
 consume_skb net/core/skbuff.c:1397 [inline]
 consume_skb+0xbf/0x100 net/core/skbuff.c:1391
 __unix_dgram_recvmsg+0x779/0xc30 net/unix/af_unix.c:2683
 unix_dgram_recvmsg net/unix/af_unix.c:2700 [inline]
 unix_seqpacket_recvmsg+0x11c/0x170 net/unix/af_unix.c:2567
 sock_recvmsg_nosec net/socket.c:1065 [inline]
 sock_recvmsg+0x1f9/0x250 net/socket.c:1087
 sock_read_iter+0x2b9/0x3b0 net/socket.c:1157
 do_iter_readv_writev+0x743/0x9e0 fs/read_write.c:825
 vfs_readv+0x4cb/0x8b0 fs/read_write.c:1018
 do_readv+0x28c/0x340 fs/read_write.c:1080
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805ccd6800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805ccd6880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805ccd6900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88805ccd6980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805ccd6a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	00 e8                	add    %ch,%al
   2:	a2 d3 28 00 9c 5b 81 	movabs %al,0xe3815b9c0028d3
   9:	e3 00
   b:	02 00                	add    (%rax),%al
   d:	00 31                	add    %dh,(%rcx)
   f:	ff 48 89             	decl   -0x77(%rax)
  12:	de e8                	fsubrp %st,%st(0)
  14:	20 e8                	and    %ch,%al
  16:	20 00                	and    %al,(%rax)
  18:	48 85 db             	test   %rbx,%rbx
  1b:	0f 85 55 01 00 00    	jne    0x176
  21:	e8 a2 ec 20 00       	call   0x20ecc8
  26:	fb                   	sti
  27:	4c 89 e0             	mov    %r12,%rax
* 2a:	48 c1 e8 03          	shr    $0x3,%rax <-- trapping instruction
  2e:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  33:	0f 84 11 ff ff ff    	je     0xffffff4a
  39:	4c 89 e7             	mov    %r12,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	77 5f                	ja     0x9e
  3f:	86                   	.byte 0x86


Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102f3d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175302e2580000


