Return-Path: <linux-kernel+bounces-834932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFABA5DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F8B4C4BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532302D4B52;
	Sat, 27 Sep 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3GGyg+T"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657D1A267
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758969373; cv=none; b=iIj/pqtuyS+Qgn+8anCiZX2eYCVAo7gJgx8ENG0Ye8gzE8PGgCAiNZoDFaiqtARasFik7STAG8UAX2f1iZK4EWm4I31ehJT267Mz2OLzYylDHJfLhsglEurtX3RSy2cBahs5U0W4Qk7otiLKMoOcAnJ4svDlIDetmeBNn/ijUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758969373; c=relaxed/simple;
	bh=ed/KKNVvHkaK1hotCpnsX5Xk4LyidKOrKdrFsxez66Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnRrRvIqYT6fWZjEpx7Kj9uzy3GJq95/iGBWC/HryZHvyDqNkp9P2EXZf4fJYTONoqm8W+mNjz/ix3QbTm9Ize6QE81KBHaRvDZdwp96gRyqGotfiSRxEtGeEPJQJxgIORlGUm8CfZ3egfCybtSDEK76IzTIldEUqyRlrhuhi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3GGyg+T; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b555b0fb839so2216375a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758969371; x=1759574171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4Sc+1QcgxWj5M5Phr594WwHcvG0NTjw8ZrDoC0chPA=;
        b=c3GGyg+TjpD+Vjn5+a5vcuwTBQPwgZJDI8nvHs1hoRY19mra6g3ZnKKe00t+w/v04H
         V6oG5NZkOe6KEQcpTmbjeYSD5eXagTGc6B7c41dKZs8ZrkhjEz4IiNEaff3SjrNoTvhx
         sp0Q6efyMrk5nAhqT2BsFanbbwkZ96/OEMOsiZMNfk9Qch0CTw498H0+Misl4VjcUhuF
         NyZVBtxI1iUpqGFlPdUEZLQq3MTZP0+ijJgP1Ox1mKG5P/Ps8p/iIaJzsU8RpbJ62vId
         6LrwIogBvJJ44uXgi5iX2ExvpZQrENOdveZ8zvXAgS1P1cqHEb3h1jxMPX2+ANsDpk1W
         AZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758969371; x=1759574171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4Sc+1QcgxWj5M5Phr594WwHcvG0NTjw8ZrDoC0chPA=;
        b=II/PWzq4Lmdz0ZcBA+QCyCoCeQwIHUhoX1+I0mF0VuR6Z55ecLvX3gCWRgKGpe/Et/
         b81vUTOXo0uxeok+J8K4nQohQw35vz9Qay83i11ihxBE53IB+pMF1Slpmy1QhmFCVbAE
         l+pTzsmsy2/8HJsBkFv/JGn/Llx7viMJpjgN8hntGZBt7RJonueP0edvHwu8M0rySUFA
         a9ra19gmsZ4ECW7wPTWAUbX/ZeyR67OetaP8RMe3VQx89zKLUAR1gHmGpJ325gotUmMw
         8Ou9BSD7Ey+3SeTF5eGmWeFS8js1it41KHYzL5/eEE0ggEbBZz+/VZ4dHRH2LWi7rYH5
         AWNA==
X-Forwarded-Encrypted: i=1; AJvYcCWN0OTnpIe7a+gxl6zb0rmgzh62ZhlkqJd8A2m91tvOYlh6UKVCGMQGirtGBlmOWXTy/meF9flEMXDb9Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+p9HrCPWkMLcAMnQydpWgxRaffV4zcWLdCtBUA9Wt6R/ODPRk
	tESJ2hR8wsgq6sZ6Ww4VwNFqvNQA8yQ4nVfU1mSHiYIV20CZqnk/4V4vaylGRp5012ztPbZllnv
	DSoSSnClveEFcckz3R+G+YUWUmom9e0M=
X-Gm-Gg: ASbGncvFc/Nsbjv6uFq4xidRcBNUMjXVcrv4YY295LbMdRZfD69kBnGPagV3khwEhkU
	z5HCGdUiccexiPanIhrx4E+hN+ZcJCY3JT57JzrseWgPhQMJRhVMjXiqDWFJ4ublYIMGMFeogh4
	ByKXshe3xR/pGBHL0THWfTMkBod8cqHKhs9piUFIBFzhhW/eNQ67Xg9Asn7dMu/VH7btRZg+7FB
	1EMndjOJA==
X-Google-Smtp-Source: AGHT+IHKsqrsv8pEQfu7HOTr3dmeDTaKxxMiEx0sgQhxBiURsrUezF6DM1r105RHo1dxzHsxu7bHdjL2K/jXRd9SVEU=
X-Received: by 2002:a17:903:2c0d:b0:250:5ff5:3f4b with SMTP id
 d9443c01a7336-27ed4a3e0afmr128893015ad.15.1758969370491; Sat, 27 Sep 2025
 03:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927091931.7691-1-hdanton@sina.com> <68d7b657.a70a0220.10c4b.000e.GAE@google.com>
In-Reply-To: <68d7b657.a70a0220.10c4b.000e.GAE@google.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 27 Sep 2025 19:36:07 +0900
X-Gm-Features: AS18NWBcuxTuInOl1bB8BewO7tBylx9N3fjayD-OEf0O_2WjfkzFVG8vfn6ly1A
Message-ID: <CAO9qdTGH5eMQTesCKVjLU7-kMg4uGC_6DGxP+YOP63yp=07HdQ@mail.gmail.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
To: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
Cc: clemens@ladisch.de, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: slab-use-after-free Write in snd_usbmidi_in_urb_complete
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
> Write of size 1 at addr ffff888074717943 by task kworker/1:3/5866
>

Wow, the UAF bug still occurs?

But... this UAF seems to be a problem with how midi handles urb rather
than a problem with my patch.

Is there something wrong with the way snd_usbmidi_in_urb_complete() is
implemented?

> CPU: 1 UID: 0 PID: 5866 Comm: kworker/1:3 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
>  __usb_hcd_giveback_urb+0x38b/0x610 drivers/usb/core/hcd.c:1661
>  usb_hcd_giveback_urb+0x39b/0x450 drivers/usb/core/hcd.c:1745
>  dummy_timer+0x1814/0x3a30 drivers/usb/gadget/udc/dummy_hcd.c:1995
>  __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
>  __hrtimer_run_queues+0x202/0xad0 kernel/time/hrtimer.c:1825
>  hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1842
>  handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
>  __do_softirq kernel/softirq.c:613 [inline]
>  invoke_softirq kernel/softirq.c:453 [inline]
>  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
>  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:lock_acquire+0x62/0x350 kernel/locking/lockdep.c:5872
> Code: f9 3e 12 83 f8 07 0f 87 bc 02 00 00 89 c0 48 0f a3 05 c2 d8 13 0f 0f 82 74 02 00 00 8b 35 5a 0a 14 0f 85 f6 0f 85 8d 00 00 00 <48> 8b 44 24 30 65 48 2b 05 19 f9 3e 12 0f 85 c7 02 00 00 48 83 c4
> RSP: 0018:ffffc9000213f6a8 EFLAGS: 00000206
> RAX: 0000000000000046 RBX: ffffffff8e5c16a0 RCX: 000000004089a3e6
> RDX: 0000000000000000 RSI: ffffffff8de2c268 RDI: ffffffff8c163a00
> RBP: 0000000000000002 R08: b04c8ca6f5f73b8b R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
>  kernfs_root+0x34/0x2a0 fs/kernfs/kernfs-internal.h:75
>  __kernfs_remove+0x302/0x8a0 fs/kernfs/dir.c:1519
>  kernfs_remove_by_name_ns+0x68/0x110 fs/kernfs/dir.c:1717
>  kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
>  remove_files+0x96/0x1c0 fs/sysfs/group.c:28
>  sysfs_remove_group+0x8b/0x180 fs/sysfs/group.c:322
>  sysfs_remove_groups fs/sysfs/group.c:346 [inline]
>  sysfs_remove_groups+0x60/0xa0 fs/sysfs/group.c:338
>  device_remove_groups drivers/base/core.c:2843 [inline]
>  device_remove_attrs+0x192/0x290 drivers/base/core.c:2973
>  device_del+0x38e/0x9f0 drivers/base/core.c:3877
>  usb_disconnect+0x5bf/0x9c0 drivers/usb/core/hub.c:2375
>  hub_port_connect drivers/usb/core/hub.c:5406 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
>  port_event drivers/usb/core/hub.c:5870 [inline]
>  hub_event+0x1c81/0x4fe0 drivers/usb/core/hub.c:5952
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> Allocated by task 9:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  snd_usbmidi_in_endpoint_create+0x8c/0xa70 sound/usb/midi.c:1342
>  snd_usbmidi_create_endpoints_midiman+0x4c4/0xaf0 sound/usb/midi.c:2364
>  __snd_usbmidi_create+0x14a4/0x1e90 sound/usb/midi.c:2647
>  snd_usb_midi_v2_create+0x1ad/0x42d0 sound/usb/midi2.c:1178
>  snd_usb_create_quirk+0xad/0x140 sound/usb/quirks.c:541
>  usb_audio_probe+0x7f7/0x3cf0 sound/usb/card.c:976
>  usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x241/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
>  __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
>  bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
>  bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>  device_add+0x1148/0x1aa0 drivers/base/core.c:3689
>  usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
>  usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
>  usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x241/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
>  __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
>  bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
>  bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>  device_add+0x1148/0x1aa0 drivers/base/core.c:3689
>  usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
>  hub_port_connect drivers/usb/core/hub.c:5566 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
>  port_event drivers/usb/core/hub.c:5870 [inline]
>  hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Freed by task 9:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:243 [inline]
>  __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2422 [inline]
>  slab_free mm/slub.c:4695 [inline]
>  kfree+0x2b4/0x4d0 mm/slub.c:4894
>  snd_usbmidi_free sound/usb/midi.c:1532 [inline]
>  snd_usbmidi_rawmidi_free+0xbd/0x130 sound/usb/midi.c:1592
>  snd_rawmidi_free.part.0+0x398/0x560 sound/core/rawmidi.c:1934
>  snd_rawmidi_free sound/core/rawmidi.c:1923 [inline]
>  snd_rawmidi_dev_free+0x3e/0x60 sound/core/rawmidi.c:1945
>  __snd_device_free+0x1a7/0x410 sound/core/device.c:76
>  snd_device_free_all+0xf3/0x220 sound/core/device.c:233
>  snd_card_do_free sound/core/init.c:587 [inline]
>  release_card_device+0x77/0x1d0 sound/core/init.c:153
>  device_release+0xa4/0x240 drivers/base/core.c:2565
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1e7/0x5a0 lib/kobject.c:737
>  put_device+0x1f/0x30 drivers/base/core.c:3797
>  snd_card_free_when_closed sound/core/init.c:618 [inline]
>  snd_card_free_when_closed sound/core/init.c:612 [inline]
>  snd_card_free+0x11a/0x190 sound/core/init.c:650
>  usb_audio_probe+0x1507/0x3cf0 sound/usb/card.c:1034
>  usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x241/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
>  __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
>  bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
>  bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>  device_add+0x1148/0x1aa0 drivers/base/core.c:3689
>  usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
>  usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
>  usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x241/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
>  __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
>  bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
>  bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>  device_add+0x1148/0x1aa0 drivers/base/core.c:3689
>  usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
>  hub_port_connect drivers/usb/core/hub.c:5566 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
>  port_event drivers/usb/core/hub.c:5870 [inline]
>  hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> The buggy address belongs to the object at ffff888074717800
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 323 bytes inside of
>  freed 512-byte region [ffff888074717800, ffff888074717a00)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x74714
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b841c80 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
> head: 00fff00000000040 ffff88801b841c80 dead000000000100 dead000000000122
> head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
> head: 00fff00000000002 ffffea0001d1c501 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10, tgid 10 (kworker/0:1), ts 289964868636, free_ts 191685793183
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
>  prep_new_page mm/page_alloc.c:1859 [inline]
>  get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
>  __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
>  alloc_slab_page mm/slub.c:2492 [inline]
>  allocate_slab mm/slub.c:2660 [inline]
>  new_slab+0x247/0x330 mm/slub.c:2714
>  ___slab_alloc+0xcf2/0x1750 mm/slub.c:3901
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3992
>  __slab_alloc_node mm/slub.c:4067 [inline]
>  slab_alloc_node mm/slub.c:4228 [inline]
>  __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4402
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  device_private_init drivers/base/core.c:3534 [inline]
>  device_add+0xccc/0x1aa0 drivers/base/core.c:3585
>  usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
>  usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
>  usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x241/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
>  __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
> page last free pid 6777 tgid 6777 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1395 [inline]
>  __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4191 [inline]
>  slab_alloc_node mm/slub.c:4240 [inline]
>  kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4247
>  getname_flags.part.0+0x4c/0x550 fs/namei.c:146
>  getname_flags+0x93/0xf0 include/linux/audit.h:322
>  do_readlinkat+0xb4/0x3a0 fs/stat.c:575
>  __do_sys_readlink fs/stat.c:613 [inline]
>  __se_sys_readlink fs/stat.c:610 [inline]
>  __x64_sys_readlink+0x78/0xc0 fs/stat.c:610
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888074717800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888074717880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888074717900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                            ^
>  ffff888074717980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888074717a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> ----------------
> Code disassembly (best guess):
>    0:   f9                      stc
>    1:   3e 12 83 f8 07 0f 87    ds adc -0x78f0f808(%rbx),%al
>    8:   bc 02 00 00 89          mov    $0x89000002,%esp
>    d:   c0 48 0f a3             rorb   $0xa3,0xf(%rax)
>   11:   05 c2 d8 13 0f          add    $0xf13d8c2,%eax
>   16:   0f 82 74 02 00 00       jb     0x290
>   1c:   8b 35 5a 0a 14 0f       mov    0xf140a5a(%rip),%esi        # 0xf140a7c
>   22:   85 f6                   test   %esi,%esi
>   24:   0f 85 8d 00 00 00       jne    0xb7
> * 2a:   48 8b 44 24 30          mov    0x30(%rsp),%rax <-- trapping instruction
>   2f:   65 48 2b 05 19 f9 3e    sub    %gs:0x123ef919(%rip),%rax        # 0x123ef950
>   36:   12
>   37:   0f 85 c7 02 00 00       jne    0x304
>   3d:   48                      rex.W
>   3e:   83                      .byte 0x83
>   3f:   c4                      .byte 0xc4
>
>
> Tested on:
>
> commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13bb3d34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
> dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17773142580000
>

