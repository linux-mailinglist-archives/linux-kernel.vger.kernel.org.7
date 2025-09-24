Return-Path: <linux-kernel+bounces-829945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54489B984AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08492A1E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71222DFA7;
	Wed, 24 Sep 2025 05:35:39 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894691A9F92
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758692138; cv=none; b=J/XJzFc675O1QJIwbKCqkz18B/pOXISqmW927+8Z2vBjrIoD0PWOdsJGTwSFtcD17KVBVv69A8th32l2k9rWBksP7jO7V4vpWvpmMx7wFJ8PlVXz51PUZbcmtYJh3BFYo5g0V6ZX+BtvnHbbI8znllQHMSh0POqnjzvblN+BJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758692138; c=relaxed/simple;
	bh=eW2JdmipRzvrxsl5wBwsLl+RG6A0vPAVDtmAZKGbzOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MFZ2f+Z7zKkqEwT9scY4k/B2QfHgmyo5T4/W0Sw22LczDWxQBxh0xgPhXrA2clQLTrgrES4TbgFpfA8JQ/Nmn9y881/MC5l0V5LKXbGcMjerY1y5RKXpPMzn768dsUP/xIyIxtAfpeVYuHPHJAr8bqov7PIi3NrrV88h5yr21Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42571803464so62624055ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758692135; x=1759296935;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoIhc0Z3qOSxs+sQlNqcfGuNBxWQsU0VWj4ZQGBkHfI=;
        b=N3FEt/58gUfGN81xlVeXoFSQk9eazvGzQDNFqorMFVOGvGuCewYDsVFi4UjEXLJW9e
         6Lp3eBZkk2Uln6XVUV5ER3tcL6ef91kN3lzf2pTejZwdmlZL15EyewE9DYPQt+iNftfI
         VYCSCGvyJ9hmexj7eXRyWRFmTOn8TPfo5Hncylt4HW/KaEyu+JwsFP3ORi3jj3cHQMcy
         AJ2ApiSrke2Qr32pfQ+StDg9hnOtuUC1QirBwU6bCIsR3JFf0vsCIO5XDLWh5asbjjln
         MkJd4Zfl8aKaIgZmkEhK8W+mianSGeBs5SDHu+elkmXSErbYdTMzOljnS3gJd7JRu7EZ
         gvYA==
X-Forwarded-Encrypted: i=1; AJvYcCVZxmHZ0c3Dnf1TmYI24aj7SbVRCAkaY6WIGtx+m3qotsTjOTgaCpPDmsGpz2MURc/q1GcAhoABewtA6Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZiBn4BZBML54rk4orDFamhwKPaJmmeSsfM9T39sI46nxYBls
	UPKluw/axE74F3gryzEdqSjLjsny5UwEhMNKaHsAgqtMWMP0xFTsUbs7RwYwXtfcuVlYEUtfu1e
	YJgZm6E0pePMSr/j5hwqV6FFXQV183cvpYtfzHspV3AjmiCD7vjodzsimEQs=
X-Google-Smtp-Source: AGHT+IG8fcusR7jD9lXqMUPmoLfFyEWxM5q+/rWet7UO8ZALsocl4wJene4nb/u0ktow/tT44gp7gcoQl28h9KfDXABEjLr7gMIG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4416:10b0:425:8c47:13f6 with SMTP id
 e9e14a558f8ab-4258c47179fmr20715195ab.29.1758692135649; Tue, 23 Sep 2025
 22:35:35 -0700 (PDT)
Date: Tue, 23 Sep 2025 22:35:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d38327.a70a0220.1b52b.02be.GAE@google.com>
Subject: [syzbot] [sound?] KASAN: slab-use-after-free Read in
 snd_usbmidi_error_timer (2)
From: syzbot <syzbot+ce952c05d40571083fd6@syzkaller.appspotmail.com>
To: clemens@ladisch.de, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127fc142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=ce952c05d40571083fd6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f000e10907d9/disk-cec1e6e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8da77cc2298/vmlinux-cec1e6e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ad6164e7d28/bzImage-cec1e6e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce952c05d40571083fd6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in snd_usbmidi_error_timer+0x15d/0x660 sound/usb/midi.c:355
Read of size 4 at addr ffff8880310f9a10 by task syz.4.2001/13191

CPU: 0 UID: 0 PID: 13191 Comm: syz.4.2001 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 snd_usbmidi_error_timer+0x15d/0x660 sound/usb/midi.c:355
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
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
RIP: 0010:__sanitizer_cov_trace_pc+0x46/0x70 kernel/kcov.c:222
Code: ff 00 74 11 81 fa 00 01 00 00 75 35 83 b9 3c 16 00 00 00 74 2c 8b 91 18 16 00 00 83 fa 02 75 21 48 8b 91 20 16 00 00 48 8b 32 <48> 8d 7e 01 8b 89 1c 16 00 00 48 39 cf 73 08 48 89 3a 48 89 44 f2
RSP: 0018:ffffc90003007658 EFLAGS: 00000246
RAX: ffffffff8b72d1aa RBX: ffffc900030077c0 RCX: ffff88802acd3c00
RDX: ffffc9000d3ed000 RSI: 000000000007ffff RDI: ffffffff8be33f20
RBP: ffffc90003007790 R08: 0000000000000000 R09: ffffffff8b72d15c
R10: dffffc0000000000 R11: fffffbfff1f47507 R12: dffffc0000000000
R13: 1ffff92000600ed4 R14: 0000000000000001 R15: ffffc900030076c0
 rcu_read_lock include/linux/rcupdate.h:842 [inline]
 mt_find+0x1aa/0x5f0 lib/maple_tree.c:6931
 find_vma+0xe7/0x160 mm/mmap.c:909
 lock_mm_and_find_vma+0x5f/0x300 mm/mmap_lock.c:340
 do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1359
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x30/0x90 arch/x86/lib/copy_user_64.S:60
Code: 83 f9 08 73 25 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 e9 8d 0a 04 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 <48> 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08
RSP: 0018:ffffc90003007a18 EFLAGS: 00050206
RAX: 00007ffffffff001 RBX: 0000000000000038 RCX: 0000000000000038
RDX: 0000000000000001 RSI: 0000200000297000 RDI: ffffc90003007aa0
RBP: ffffc90003007c30 R08: ffffc90003007ad7 R09: 1ffff92000600f5a
R10: dffffc0000000000 R11: fffff52000600f5b R12: 0000000000000002
R13: dffffc0000000000 R14: ffffc90003007aa0 R15: 0000200000297000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:178 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 copy_msghdr_from_user net/socket.c:2544 [inline]
 recvmsg_copy_msghdr net/socket.c:2800 [inline]
 ___sys_recvmsg+0x12e/0x510 net/socket.c:2872
 do_recvmmsg+0x307/0x770 net/socket.c:2971
 __sys_recvmmsg net/socket.c:3045 [inline]
 __do_sys_recvmmsg net/socket.c:3068 [inline]
 __se_sys_recvmmsg net/socket.c:3061 [inline]
 __x64_sys_recvmmsg+0x190/0x240 net/socket.c:3061
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f873778eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f87359f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f87379e6090 RCX: 00007f873778eec9
RDX: 0000000000010106 RSI: 00002000000000c0 RDI: 0000000000000003
RBP: 00007f8737811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f87379e6128 R14: 00007f87379e6090 R15: 00007f8737b0fa28
 </TASK>

Allocated by task 5950:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 usb_alloc_urb+0x46/0x150 drivers/usb/core/urb.c:75
 snd_usbmidi_in_endpoint_create+0xb4/0xa30 sound/usb/midi.c:1348
 snd_usbmidi_create_endpoints_midiman sound/usb/midi.c:2363 [inline]
 __snd_usbmidi_create+0x2223/0x2a70 sound/usb/midi.c:2646
 snd_usb_midi_v2_create+0x43e6/0x4660 sound/usb/midi2.c:1178
 usb_audio_probe+0xb78/0x1e10 sound/usb/card.c:976
 usb_probe_interface+0x668/0xc30 drivers/usb/core/driver.c:396
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
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5950:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x18e/0x440 mm/slub.c:4894
 free_urb_and_buffer sound/usb/midi.c:1309 [inline]
 snd_usbmidi_in_endpoint_delete+0xde/0x680 sound/usb/midi.c:1322
 snd_usbmidi_free sound/usb/midi.c:1530 [inline]
 snd_usbmidi_rawmidi_free+0xae/0x160 sound/usb/midi.c:1591
 snd_rawmidi_free+0x3bc/0x410 sound/core/rawmidi.c:1934
 snd_rawmidi_dev_free+0x38/0x50 sound/core/rawmidi.c:1945
 __snd_device_free+0x1d2/0x2e0 sound/core/device.c:76
 snd_device_free_all+0xcf/0x180 sound/core/device.c:233
 snd_card_do_free sound/core/init.c:587 [inline]
 release_card_device+0x75/0x1b0 sound/core/init.c:153
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 snd_card_free_when_closed sound/core/init.c:618 [inline]
 snd_card_free+0x110/0x190 sound/core/init.c:650
 usb_audio_probe+0x193f/0x1e10 sound/usb/card.c:1034
 usb_probe_interface+0x668/0xc30 drivers/usb/core/driver.c:396
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
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880310f9a00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 freed 192-byte region [ffff8880310f9a00, ffff8880310f9ac0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x310f9
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a4413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 19362280210, free_ts 19332206122
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 call_usermodehelper_setup+0x8e/0x270 kernel/umh.c:362
 kobject_uevent_env+0x65c/0x8c0 lib/kobject_uevent.c:628
 kernel_add_sysfs_param+0xb1/0xe0 kernel/params.c:816
 param_sysfs_builtin+0x18a/0x230 kernel/params.c:851
 param_sysfs_builtin_init+0x23/0x30 kernel/params.c:987
 do_one_initcall+0x233/0x820 init/main.c:1269
 do_initcall_level+0x104/0x190 init/main.c:1331
 do_initcalls+0x59/0xa0 init/main.c:1347
 kernel_init_freeable+0x334/0x4b0 init/main.c:1579
page last free pid 980 tgid 980 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 vfree+0x25a/0x400 mm/vmalloc.c:3434
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3353
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880310f9900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880310f9980: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880310f9a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880310f9a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880310f9b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	ff 00                	incl   (%rax)
   2:	74 11                	je     0x15
   4:	81 fa 00 01 00 00    	cmp    $0x100,%edx
   a:	75 35                	jne    0x41
   c:	83 b9 3c 16 00 00 00 	cmpl   $0x0,0x163c(%rcx)
  13:	74 2c                	je     0x41
  15:	8b 91 18 16 00 00    	mov    0x1618(%rcx),%edx
  1b:	83 fa 02             	cmp    $0x2,%edx
  1e:	75 21                	jne    0x41
  20:	48 8b 91 20 16 00 00 	mov    0x1620(%rcx),%rdx
  27:	48 8b 32             	mov    (%rdx),%rsi
* 2a:	48 8d 7e 01          	lea    0x1(%rsi),%rdi <-- trapping instruction
  2e:	8b 89 1c 16 00 00    	mov    0x161c(%rcx),%ecx
  34:	48 39 cf             	cmp    %rcx,%rdi
  37:	73 08                	jae    0x41
  39:	48 89 3a             	mov    %rdi,(%rdx)
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	f2                   	repnz


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

