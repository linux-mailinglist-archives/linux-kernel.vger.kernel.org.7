Return-Path: <linux-kernel+bounces-723921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E6AFEC77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F99C5A6640
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63B2E6137;
	Wed,  9 Jul 2025 14:44:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5E2BD04
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072245; cv=none; b=XMzS+8XLNhTcvmylzEKVi1kn/Arm2y4+9zWL86pdLIy/cty1fb70wDd2azLdwrUEtf0/tu6r11PaAxtalcY2xQXvHlwR/yIrykOb5KJ1NfrHMFS2fQ8tBbrPDdGaq5ADWhzI+qwKB8xJYXW2mHM2tbfxB+lJII2SA17ZOGWvCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072245; c=relaxed/simple;
	bh=rCXaJFsS9+OOoSdp/UYkK15L1C5bHeh5m/0Rr0UrS14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ULEVHZpSvxdyDO0D7qGg6/0LtzX2YO+eG2H9Rdcu4zKrqKtXTZu3D6es602mAHVA9bJBCBDcTN/X21xlo7TsmsZtxAsP8XsbRhGYEArEGSYuQZstqh3nXYXzLYXaSke3aNHrPQjn6ZTJi21PTLxKB1sAtCDLEqoU9ktXX9nnidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-869e9667f58so39239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072242; x=1752677042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjJIbudkOk3PGBHSb25jwQO0Bgq30c5bCFc04i176mw=;
        b=xIbF1xmmFya9XfuBodmF9AJXCL7hHGtmx949qdiwgSSy2K4X37Y+wRdStDDtmD2d4z
         cwrINEJvVDBNRQ9mWQeQ3g9wsdo/mM9pzeteLp3z4CW98DVXfBmTtV6qBqLIzQAt53Ez
         hj67LiIPTFsfvTxmVKFHP3wShDgB4lSsLFHSFUe+Pz/pcu8UOji6TWGJxPNxTaKlb0/R
         0wENMJJzNYKtHuv27e7igRAyBWSEU0D1lDIPUsY3bCFkFr8Uo6cfkbkt6gvZg4mBxUY5
         z+uotRiT6BrcU7t6CzQkwdUeM/NIeIl+3Cyu2cFMPN0KCGuPNkQnzMUflzP1PXTHrPFi
         5QBw==
X-Gm-Message-State: AOJu0YwPZ9oDkbR7aTNzSrurQqdktkJC5hQ7yrKgdVPVcjW42sNocnT9
	KySiLs6sQE2SPS4OdYUNsvOZzw22+WIMCiIYNYu9ah4j6P5XjFcJLZfl7MX5PC4qvyNs7dVonG/
	0Bn2g9p5FF+JOkF0Y18NgS1VmDrJ3rlsPaxj5Mhf4UBgJT79O0tyCC0sOzvA=
X-Google-Smtp-Source: AGHT+IE7W27pio/pQsIslHhX1OxECXD89ds0+Obkrxs+8NxZ0r3ckTwbcF+LR8VylvqcZkbmK1kLqcXiT1QIcZGBPjrQSOAY76eY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd5:b0:876:b8a0:6a16 with SMTP id
 ca18e2360f4ac-8795b182052mr322896839f.13.1752072242473; Wed, 09 Jul 2025
 07:44:02 -0700 (PDT)
Date: Wed, 09 Jul 2025 07:44:02 -0700
In-Reply-To: <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686e8032.050a0220.385921.0006.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usbdev_ioctl

INFO: task syz.0.16:6824 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.16        state:D stack:26072 pid:6824  tgid:6823  ppid:6626   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x65d/0xc70 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:884 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2611 [inline]
 usbdev_ioctl+0x140/0x20c0 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e6ed8d169
RSP: 002b:00007f3e6fc82038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3e6efa5fa0 RCX: 00007f3e6ed8d169
RDX: 0000000000000000 RSI: 0000000041045508 RDI: 0000000000000003
RBP: 00007f3e6ee0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3e6efa5fa0 R15: 00007fff8d808c58
 </TASK>
INFO: task syz.0.16:6824 is blocked on a mutex likely owned by task kworker/1:3:980.
task:kworker/1:3     state:S stack:23144 pid:980   tgid:980   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3da/0x710 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 send_packet+0x63b/0xae0 drivers/media/rc/imon.c:649
 imon_init_rdev drivers/media/rc/imon.c:1988 [inline]
 imon_init_intf0 drivers/media/rc/imon.c:2277 [inline]
 imon_probe+0x1f7e/0x3410 drivers/media/rc/imon.c:2434
 usb_probe_interface+0x641/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0xa39/0x16c0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2941/0x4a00 drivers/usb/core/hub.c:5948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.2.18:6836 blocked for more than 146 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.18        state:D stack:27304 pid:6836  tgid:6835  ppid:6633   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x65d/0xc70 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:884 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2611 [inline]
 usbdev_ioctl+0x140/0x20c0 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc6a198d169
RSP: 002b:00007fc6a2819038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc6a1ba5fa0 RCX: 00007fc6a198d169
RDX: 0000000000000000 RSI: 0000000041045508 RDI: 0000000000000003
RBP: 00007fc6a1a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc6a1ba5fa0 R15: 00007ffca85e32a8
 </TASK>
INFO: task syz.2.18:6836 is blocked on a mutex likely owned by task kworker/1:3:980.
task:kworker/1:3     state:S stack:23144 pid:980   tgid:980   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3da/0x710 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 send_packet+0x63b/0xae0 drivers/media/rc/imon.c:649
 imon_init_rdev drivers/media/rc/imon.c:1988 [inline]
 imon_init_intf0 drivers/media/rc/imon.c:2277 [inline]
 imon_probe+0x1f7e/0x3410 drivers/media/rc/imon.c:2434
 usb_probe_interface+0x641/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0xa39/0x16c0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2941/0x4a00 drivers/usb/core/hub.c:5948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.3.19:6847 blocked for more than 147 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.19        state:D stack:28328 pid:6847  tgid:6846  ppid:6634   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x65d/0xc70 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:884 [inline]
 usbdev_open+0x16e/0x760 drivers/usb/core/devio.c:1054
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf3/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f221d98bad0
RSP: 002b:00007f221e739b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f221d98bad0
RDX: 0000000000000002 RSI: 00007f221e739c10 RDI: 00000000ffffff9c
RBP: 00007f221e739c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f221dba5fa0 R15: 00007fff3a314ce8
 </TASK>
INFO: task syz.3.19:6847 is blocked on a mutex likely owned by task kworker/1:3:980.
task:kworker/1:3     state:S stack:23144 pid:980   tgid:980   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3da/0x710 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 send_packet+0x63b/0xae0 drivers/media/rc/imon.c:649
 imon_init_rdev drivers/media/rc/imon.c:1988 [inline]
 imon_init_intf0 drivers/media/rc/imon.c:2277 [inline]
 imon_probe+0x1f7e/0x3410 drivers/media/rc/imon.c:2434
 usb_probe_interface+0x641/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0xa39/0x16c0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2941/0x4a00 drivers/usb/core/hub.c:5948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.1.17:6856 blocked for more than 149 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.17        state:D stack:28248 pid:6856  tgid:6854  ppid:6632   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x65d/0xc70 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:884 [inline]
 usbdev_open+0x16e/0x760 drivers/usb/core/devio.c:1054
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf3/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6bae78bad0
RSP: 002b:00007f6baf6d2b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6bae78bad0
RDX: 0000000000000002 RSI: 00007f6baf6d2c10 RDI: 00000000ffffff9c
RBP: 00007f6baf6d2c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6bae9a5fa0 R15: 00007ffcc18baff8
 </TASK>
INFO: task syz.1.17:6856 is blocked on a mutex likely owned by task kworker/1:3:980.
task:kworker/1:3     state:S stack:23144 pid:980   tgid:980   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3da/0x710 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 send_packet+0x63b/0xae0 drivers/media/rc/imon.c:649
 imon_init_rdev drivers/media/rc/imon.c:1988 [inline]
 imon_init_intf0 drivers/media/rc/imon.c:2277 [inline]
 imon_probe+0x1f7e/0x3410 drivers/media/rc/imon.c:2434
 usb_probe_interface+0x641/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0xa39/0x16c0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2941/0x4a00 drivers/usb/core/hub.c:5948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.4.20:6865 blocked for more than 151 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.20        state:D stack:28328 pid:6865  tgid:6864  ppid:6635   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x65d/0xc70 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:884 [inline]
 usbdev_open+0x16e/0x760 drivers/usb/core/devio.c:1054
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf3/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc69d8bad0
RSP: 002b:00007fdc6ab85b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fdc69d8bad0
RDX: 0000000000000002 RSI: 00007fdc6ab85c10 RDI: 00000000ffffff9c
RBP: 00007fdc6ab85c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fdc69fa5fa0 R15: 00007fffcbd9c4f8
 </TASK>
INFO: task syz.4.20:6865 is blocked on a mutex likely owned by task kworker/1:3:980.
task:kworker/1:3     state:S stack:23144 pid:980   tgid:980   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3da/0x710 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 send_packet+0x63b/0xae0 drivers/media/rc/imon.c:649
 imon_init_rdev drivers/media/rc/imon.c:1988 [inline]
 imon_init_intf0 drivers/media/rc/imon.c:2277 [inline]
 imon_probe+0x1f7e/0x3410 drivers/media/rc/imon.c:2434
 usb_probe_interface+0x641/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0xa39/0x16c0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2941/0x4a00 drivers/usb/core/hub.c:5948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:1/13:
6 locks held by kworker/1:0/24:


Tested on:

commit:         73392339 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f6b582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141c1a8c580000


