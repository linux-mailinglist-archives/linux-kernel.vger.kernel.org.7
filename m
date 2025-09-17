Return-Path: <linux-kernel+bounces-821437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05262B813D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17B64E3797
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC72FDC5D;
	Wed, 17 Sep 2025 17:52:38 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BE2D3233
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131556; cv=none; b=RFHFfEHmGAz8foxPFQ4wEsygLaVl/UlLbccXZe4l51Z/UG/8jCzbKDx2rdgPGR/xwv1OhnothHwgcgleknZxQ+FqJd8tRWqo041knEn9wjn+/9R3yDwZeniLwXWbNrCdPKAs7Coklnw3namhOT4MFprEVfIGMdImNBygx5aGmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131556; c=relaxed/simple;
	bh=AbOAmoZiQlNcR17rU04NPZXPwr8zW1JuONUpSlLp3w8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HZ1YAJARkN7fg9dmS5OnZT6Sk9Nsc94jlMUGDjlXykUz3gvtLm1n7Aq3+X6ZBNrALQNQf3QqaUDuX41xeN4RzN8u7S4Ql0UobLWgtTXQLKEGQOLdvLSKtG9lOjthEx1zcblJc0EWbaK7Wa2L1UUADVwKbCuMjx5PFrce5D+eVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4240926dcd1so421725ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131551; x=1758736351;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKdkRqXOfqsbwonmuglVQhE0k2V9Y7oKPdzSUG2IaPM=;
        b=s7Ls/hbyvk3K9qNYPHoHJETViY7ADQsE+JIYZhyFrucZtFqyw9z2DPzAPM6HEwV3M9
         6II9lt1jXUFvlo8QBGd9TEUv0dku9yFxPh/AyqQll3zkEprw4jqM0VzvflJpoxmRiDH1
         9BOdtWIXzBALoUqiL4fimwRo9c2XcLD5jMCRx28O/kyPSXCx5YbCuiE+W1ZL6qpygMDo
         fAc7rfv6KMpp/Oh54yfX7a8uY/97r1/GIC/PLywusiQaUzkwFbo/SefREHh0ED4EhUxJ
         LEVDAb9UujGoefcN4/nckMgoadYpYKVG3GssOOQO16wNXeYHMSZkkdVP1dRbsmZHpyKL
         hpfg==
X-Forwarded-Encrypted: i=1; AJvYcCW/2jOqGz2sIIR0HoeBSW+w3Hn5kTI50s3bTqTUEDYMIe1PeCoeLiFyOvMsYQIOjOk2elxC+PfACxPstaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4aCMHzebqNxmBtEr3o+hNkvpK6ugpycoxx4ubkDtw3BZ6WXc
	yPKCCNgqEgaFfCCWbryYR2d8VVA8uhK65oga9/o+y7vDBnimCuwkj+6+Wtz8VXXGsAcB8q6/Hf8
	KGhaNBbjiu5ScY3JwPSKKwi8Ri+WzQEzSo92XooU0//5wsEhxdqRRavKVNkQ=
X-Google-Smtp-Source: AGHT+IHdOsDwqHjB6bQUG/kICQZd+7SskboIoBWqqN9f4kYkBgFRUHhRIXiAAUNj5YsGa0rjMnjtQpfuqpdRaUoBNVXYO/BJMNPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6f:b0:410:cae9:a083 with SMTP id
 e9e14a558f8ab-4241a4b998dmr44657175ab.3.1758131551065; Wed, 17 Sep 2025
 10:52:31 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:52:31 -0700
In-Reply-To: <68a68107.050a0220.1f0557.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68caf55f.050a0220.2ff435.0596.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] [mm?] INFO: rcu detected stall in hub_event (2)
From: syzbot <syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e28f62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126e9f62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178c4c7c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f191b2524020/disk-5aca7966.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5aa02ba0cba2/vmlinux-5aca7966.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9b04ddba61b/bzImage-5aca7966.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com

yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P976/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=9573, q=31864 ncpus=2)
task:kworker/0:2     state:R  running task     stack:23864 pid:976   tgid:976   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:deref_stack_reg arch/x86/kernel/unwind_orc.c:406 [inline]
RIP: 0010:unwind_next_frame+0x15f1/0x20a0 arch/x86/kernel/unwind_orc.c:648
Code: 0f 84 b5 ed ff ff 48 89 ef e8 0b e0 ff ff 49 8d 7d 40 48 89 fa 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <0f> 84 cb f9 ff ff e8 f4 f2 b6 00 e9 c1 f9 ff ff 48 b8 00 00 00 00
RSP: 0018:ffffc90003c7e6d8 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffc90003c80000
RDX: 1ffff9200078fcf1 RSI: ffffc90003c7f688 RDI: ffffc90003c7e788
RBP: ffff888022a87000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000051787 R12: ffffc90003c7e798
R13: ffffc90003c7e748 R14: ffffc90003c7f6b0 R15: ffffc90003c7e77c
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4247
 __kernfs_new_node+0xd2/0x8e0 fs/kernfs/dir.c:637
 kernfs_new_node+0x13c/0x1e0 fs/kernfs/dir.c:713
 __kernfs_create_file+0x53/0x350 fs/kernfs/file.c:1057
 sysfs_add_file_mode_ns+0x207/0x3c0 fs/sysfs/file.c:319
 sysfs_merge_group+0x1aa/0x340 fs/sysfs/group.c:376
 dpm_sysfs_add+0x237/0x280 drivers/base/power/sysfs.c:704
 device_add+0x9a6/0x1aa0 drivers/base/core.c:3649
 cdev_device_add+0xc2/0x1e0 fs/char_dev.c:556
 evdev_connect+0x3a4/0x4c0 drivers/input/evdev.c:1383
 input_attach_handler.isra.0+0x173/0x250 drivers/input/input.c:993
 input_register_device+0xab9/0x1180 drivers/input/input.c:2412
 usb_probe+0x10b2/0x17c0 drivers/input/misc/yealink.c:928
 usb_probe_interface+0x300/0xa40 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
sched: DL replenish lagged too much
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

