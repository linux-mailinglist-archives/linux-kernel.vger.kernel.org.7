Return-Path: <linux-kernel+bounces-725584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA0B00116
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C64C7B8869
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66928D849;
	Thu, 10 Jul 2025 11:59:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32224DD1B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148745; cv=none; b=hohzJS6fSHlrY4dbCpKadWhYbB67opUp9sH6AZIdM4GMSssTtI2H0se8YGiyOdPkhS102/46E9KBG1lAUOaGKfmgIwHJcvizCfuXPadwlh9JB8qtD8f+nEPij2mit2YBn4+lP59glHsgRuzRFgCz9k20SZZkds4QVSilX30ICZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148745; c=relaxed/simple;
	bh=CQ1RrZv80pg4xVgU+w2Fk6UnKG/bifaJSGmmpX0/PqM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RSqmEt4ZAzfk2N2veUzdev1/yYwOLz8UyVk1UnFowSHpL6a9IPtuU8EJEBVCBcm5PvSICHbi9e1A8/3uNUWo09H/2Airfc8ErcLHSjDNfbyCgWQ4Gu5+L7xrt/SlxnQAEvCx2jah0Hq7w2eyKczFKtiTgJcWHAh/ug8/1Lq8GLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso155918839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148743; x=1752753543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+MtTEKN3uuEu/Pw/kFBjduqVFgqx6sd0+WtN/rGCco=;
        b=h7uS2ypWwB7fqWFMqJT2vRcIFktzEZLn06B90oEJSD/olHsWYe13/UzE24zanO7zTV
         3+WXTHv6fU0J5Yifvub3rCtSlkip1Egv+jIf7jyB4VA3/mpy04/9rVrHVHyul9c1uSak
         TXVho6hyhMofPLbLLfYSc0rbkF/qYVDzvZYRpXR5fKrq3cXZHBvozI3CpgFmhm8htKjB
         OrPCvPoz7Qz2ya8onXZvd4Y4emMj97e9yywNdB2hsv3fGJk3nu3yqP7w0ae7ePP0mHmR
         KQ0OnQBrfYxQSUBNgoQUlIU27qEpEKzZhSa4mJCoM82tLh5nNMoNNMkjUDH5EhscDSpv
         o0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWJVxKaW6B+dKm9t6ZcwrCgEOP8f40bvvfeQ2991yq8FOZSerRGjvTlHvrbiTicyNTYmBtgtkiRBWEpHRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjbxnM/XMQlmGTAMu4REVIi6GvnsYxepVDQsVnbGPCmciIa4Sx
	Eq8B3V1yFmwQuzA7wBbuqFsCirTlQHfEHbyL2Vi8OSMG5ifXoxt4O655uDvJ7QUsPLiueaJCnoG
	36lNJdeV+fdniR1ezocauJFWvxsuUF8ZmkG8jTJ41VWaJDDhDqiRg1FLk4E0=
X-Google-Smtp-Source: AGHT+IFO402OfJIPTmlN27dpNQyVhJeFFOiZUUde6AD306YTESVPTJBoAsA55ER0osAA45QfN5l34ipDw6kHl7qCkOr9W3zaF54B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cc:b0:86a:93c:f5fb with SMTP id
 ca18e2360f4ac-87968f57664mr238219439f.1.1752148742833; Thu, 10 Jul 2025
 04:59:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 04:59:02 -0700
In-Reply-To: <20250710110510.3162-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686fab06.a00a0220.26a83e.0011.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usbdev_ioctl

INFO: task syz.1.17:6837 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc4-syzkaller-00314-gb4b4dbfa96de-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.17        state:D stack:24088 pid:6837  tgid:6836  ppid:6635   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6935
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
RIP: 0033:0x7fddcf58d169
RSP: 002b:00007fddd03af038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fddcf7a5fa0 RCX: 00007fddcf58d169
RDX: 0000000000000000 RSI: 0000000041045508 RDI: 0000000000000003
RBP: 00007fddcf60e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fddcf7a5fa0 R15: 00007fff1a55f668
 </TASK>
INFO: task syz.1.17:6837 is blocked on a mutex likely owned by task kworker/1:4:5945.
task:kworker/1:4     state:S stack:22472 pid:5945  tgid:5945  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3d7/0x710 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 send_packet+0x63b/0xae0 drivers/media/rc/imon.c:649
 imon_init_rdev drivers/media/rc/imon.c:1990 [inline]
 imon_init_intf0 drivers/media/rc/imon.c:2279 [inline]
 imon_probe+0x1f7e/0x3410 drivers/media/rc/imon.c:2436
 usb_probe_interface+0x644/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537


Tested on:

commit:         b4b4dbfa media: stk1160: use usb_alloc_noncoherent/usb..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=170c9bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b49da22b2184ad70
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152f5a8c580000


