Return-Path: <linux-kernel+bounces-803998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79FB4688B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637D83BA0E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A6320C00B;
	Sat,  6 Sep 2025 03:05:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E93A8F7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757127935; cv=none; b=QX6xYoEu49zdHK7zv/6XvvogmqX8qC4Jyw3U50UogSbVkXuJFZvzk/dH+TJ2XNxO+rUTBfpDVCy6Z189UKtZNEX3A8vKvzFhmHi+4VT2B+GWIJuk5KPy6CqjaiJzC2e2lIBeWkbSv0s5clZ2a5psgCur1BJSvlc0qwDamR/ODTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757127935; c=relaxed/simple;
	bh=C12BQ1mBTGOfaChTL3jWDaCBmmizy3I6SkjnCoKNQXk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k+WjDwINQVeITj4IKdXHATvheifTZRCK2nnJmvdtXtVAxO00RzXGGaT47ecwyD4wrj/INGmm4X7BTtSTjgceumR1DDjCkcI3Entdbg6vAo0loe3vgUHLVM/btRotZWSMfBKfuoxbJAQOhcOMpJy5nXT0CkODZHpRgypRB6y3RL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3f2b8187ec9so67257195ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757127931; x=1757732731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhbeaXnx83Fb2lfzAWcOqLQld5cNabOaz6o4t5ofhkY=;
        b=avu/0DzK78H6F062EjUkXoiGzPQ92wSZjWvz7ezX0XFRC8mEqOstPHWk6LELd5jqqT
         /vgMRcR8lCPj8jx4lsAeNbs4D/TDoOHnsZJ+sKqZkvJil0eQm2CJzIOOM4AEsUjAImT3
         XfhsciGB3PWRepv7gePVd6oKjgFcdNxLo4SxO0eHolQLqv49Wca1zTgdIl2TZHiiPti8
         u5REt4iF/8wZAG06jDKP9nKbAKrqMFnDKDf4e7X4yw17egk+wlexUc3rbclAxnGlb+Tb
         K+NcRaFnp3Rxw+yEZLx3zYB5ThnajHjgmihMUqm3rWUIH8uic+v6hAqru37I7+NNY8rI
         RJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2VZs7G6tyPAi6gO3GkBOcipdZg/oW/Of6MZjIZC8tZ1QGaCLl8dWZNHN3wQhYeDr2YBxBsPk9Ryoav7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9N0bP/ttsPkgJA1XWV9kVbIgwEOThTFdI2691L/R23dDdyLs
	4J76e8RLt08i1nvsn1xbXwMKUw1QwtoTCuqcJ45BGIc626Q9lHLCkKT0ER1k3nunVx2+jdF0+nZ
	ZFK60Q5Zh4b1y2xGcYA5R57pzXz1W9s83EkFtAwuWmYaHCDv9FHTsyQlXM/c=
X-Google-Smtp-Source: AGHT+IHbLSjCSpzMa1FxgbReZpAP0Xo4NYYl3cezd64zahz4WtpKwVLFOU20wOS1n20JLubTlkCny/zOU5yqSvW5GxCYCiY1+Ej0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:3f0:1ad0:2c17 with SMTP id
 e9e14a558f8ab-3fd8981ee41mr16611315ab.23.1757127931615; Fri, 05 Sep 2025
 20:05:31 -0700 (PDT)
Date: Fri, 05 Sep 2025 20:05:31 -0700
In-Reply-To: <68a68107.050a0220.1f0557.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bba4fb.050a0220.192772.01a4.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] [mm?] INFO: rcu detected stall in hub_event (2)
From: syzbot <syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c8ed9b5c02a5 Merge tag 'drm-fixes-2025-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bd5312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e32962580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/692cc72cb948/disk-c8ed9b5c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b6b3b9063a8/vmlinux-c8ed9b5c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1e4adfb8df2/bzImage-c8ed9b5c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6120/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=10197, q=29931 ncpus=2)
task:kworker/0:6     state:R  running task    
 stack:24872 pid:6120  tgid:6120  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:kernfs_root+0x189/0x2a0 fs/kernfs/kernfs-internal.h:76
Code: ff 48 c7 c2 c0 58 c3 8b be 4a 03 00 00 48 c7 c7 20 59 c3 8b c6 05 d9 b6 32 0e 01 e8 a1 9c 36 ff e9 c9 fe ff ff e8 67 b2 5a ff <e8> e2 ec 3e ff 31 ff 41 89 c4 89 c6 e8 96 ad 5a ff 45 85 e4 0f 85
RSP: 0018:ffffc900039cebe0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88805d1fd0f0 RCX: ffffffff8260dac6
RDX: ffff88807be50000 RSI: ffffffff8260dbc9 RDI: 0000000000000005
RBP: ffff888074793960 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: 00000000000041ed R14: 00000000000041ed R15: 0000000000000000
 kernfs_new_node+0x11f/0x1e0 fs/kernfs/dir.c:713
 kernfs_create_dir_ns+0x4c/0x1a0 fs/kernfs/dir.c:1083
 sysfs_create_dir_ns+0x13a/0x2b0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x2c4/0x9b0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x16e/0x240 lib/kobject.c:426
 device_add+0x288/0x1aa0 drivers/base/core.c:3627
 cdev_device_add+0xc2/0x1e0 fs/char_dev.c:556
 evdev_connect+0x3a4/0x4c0 drivers/input/evdev.c:1383
 input_attach_handler.isra.0+0x176/0x250 drivers/input/input.c:993
 input_register_device+0xab9/0x1180 drivers/input/input.c:2412
 usb_probe+0x10b2/0x17c0 drivers/input/misc/yealink.c:928
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
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:291
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
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 2845 jiffies! g10197 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:27784 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xb00 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x270/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound toggle_allocation_gate

RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 66 cf 55 00 48 89 df 5b e9 ed 56 5b 00 be 03 00 00 00 5b e9 82 fd 27 03 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 34 24 65 48 8b 15 d8 11 1b 12 65 8b 05 e9 11 1b
RSP: 0018:ffffc90000ac7880 EFLAGS: 00000202

RAX: 0000000000000000 RBX: ffff8880b8442000 RCX: ffffffff81af8ea1
RDX: ffff8881436fa440 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffed1017088401 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881247b6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f829e1729a0 CR3: 000000000e380000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 native_pause arch/x86/include/asm/vdso/processor.h:13 [inline]
 cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
 csd_lock_wait kernel/smp.c:342 [inline]
 smp_call_function_many_cond+0xdfb/0x1600 kernel/smp.c:877
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1044
 on_each_cpu include/linux/smp.h:71 [inline]
 smp_text_poke_sync_each_cpu arch/x86/kernel/alternative.c:2653 [inline]
 smp_text_poke_batch_finish+0x27b/0xdb0 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x376/0x550 kernel/jump_label.c:919
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate mm/kfence/core.c:850 [inline]
 toggle_allocation_gate+0xfa/0x280 mm/kfence/core.c:842
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - usb_submit_urb failed -19
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

