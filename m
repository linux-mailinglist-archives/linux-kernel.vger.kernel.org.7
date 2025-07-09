Return-Path: <linux-kernel+bounces-722582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE78AFDC96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915B51AA644D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52034137750;
	Wed,  9 Jul 2025 00:56:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42D15A8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022563; cv=none; b=aCXLekYjbt4AEd/ylDLoKTrDxuO4Kh/vJdnZ3A6zkcVPREVxxjWdpTlIzSibE3e4mn9O6u7mncZNUt3iG+/UgsvfBFxdTvD+WKfOO9RtvQNDfCcaMrY1P7r66+ajvANR9MlBIX3NiD7gSjVyg3UrBaqnJ+liWCxjSNUml9kHB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022563; c=relaxed/simple;
	bh=rDc4wNK9y/IXftWJP+66Kf/gK4h3EsDXkzGydn/ntL0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFlb+oRy8niRZI9L1Rrpjc1G5VRd672w/OCdvtO12txmzVa+B3QkIz+fM6Sky3yT6CimKB8CA87d6C+t13kU1klrp9VqrqU9q3xne8bK/V5DwKHeAVYOvtxJlmewCQX2AKa1ZyPCFznaajY+vDM15KfjR1BrYnw9riNqlldeqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86a5def8869so1026088839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 17:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022561; x=1752627361;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Amb6igKVFd73vOnV9mAjb+W2sAOaohtMrJMtaPqhrMM=;
        b=dsLaud+HkilFlEXGYPbYUal+nfvD3rvLD+zkv5jUBn/dLaJYYGfnW73iC4rvLqlOX8
         8Awl4/yDLWBQ1HxNaW9dy77RvnB4DhOPu6OAOV6ONwIAoZADiftFsotUqNTXUBoO7BNj
         zlYm6Jwz9bI1fkmL1AtZXoLhYvroAKjM5xL9MiQEY+0zJgnPF0FeKrVOKL/nMZ29g7nG
         jl+CRrMQKSbv//gkrydbK7LL228grE8Fh2nppVHJD+Ugh6eSY1G9VdOwLOnTJfODWlte
         1g48msgd6Ts9Exxt/3zNdX2yIZqqycrqxmeN6dVQsFa5rvZDC6lCr/EXmC1EYHpfRKQq
         2VIA==
X-Forwarded-Encrypted: i=1; AJvYcCWxe6ZBjwQwkxILvRvz70S/DpTnnGATcFvSHu3+YCKCsut5NMcuQC6QU3cCli3KxUVtnC8LHrm7rTLFBkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfPz6Nd5qDhez82XRgIZnfwXgFuv3zOcP0xfUwCt5yXeHCtqk
	fhpsFZPiWGTtXC0pm51EhCjaDOReExOGQGk+L/O/Rx2SXKKgMQHTzwL5cyudtM2Z11ncXWX9wEI
	D9lajWz59UcuTHcMFpN//mYpM90GVMn3iHk+K/2MTdRe1EUR/SDRXj8IYdwY=
X-Google-Smtp-Source: AGHT+IHab3/qQIL0MuHYGM774Bj3klN27JcVonGibhiGuc+LfRDD6pFbF7aVYz+wKiWwbQcz4uTQSuIvd94/o96I+hxw5QOBx1pk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c10:b0:875:b998:7ff7 with SMTP id
 ca18e2360f4ac-8795b0cd387mr93713239f.3.1752022561426; Tue, 08 Jul 2025
 17:56:01 -0700 (PDT)
Date: Tue, 08 Jul 2025 17:56:01 -0700
In-Reply-To: <20250709004125.3049-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dbe21.050a0220.1ffab7.0029.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
From: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in usbnet_probe

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 1117 Comm: kworker/1:2 Not tainted 6.16.0-rc4-syzkaller-00311-gd1b07cc0868f-dirty #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:init_status drivers/net/usb/usbnet.c:234 [inline]
RIP: 0010:usbnet_probe+0xf4e/0x2810 drivers/net/usb/usbnet.c:1818
Code: 48 c1 ea 03 80 3c 02 00 0f 85 a2 15 00 00 49 8b 87 20 0e 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d 78 02 48 89 f9 48 c1 e9 03 <0f> b6 14 11 48 89 f9 83 e1 07 38 ca 7f 08 84 d2 0f 85 f4 11 00 00
RSP: 0018:ffffc90001c2efa8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888114c4b000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff8491bef0 RDI: 0000000000000002
RBP: ffffffff87c293e0 R08: 0000000000000004 R09: 00000000000005dc
R10: 00000000000005dc R11: 0000000000000001 R12: ffffffff8492f590
R13: ffff888114c4a000 R14: ffff888107be40b4 R15: ffff888107be4000
FS:  0000000000000000(0000) GS:ffff888269262000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3205ffff CR3: 000000011fb4c000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 sierra_net_probe+0x1c/0xb0 drivers/net/usb/sierra_net.c:925
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
 hub_event+0x2f85/0x5030 drivers/usb/core/hub.c:5948
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:init_status drivers/net/usb/usbnet.c:234 [inline]
RIP: 0010:usbnet_probe+0xf4e/0x2810 drivers/net/usb/usbnet.c:1818
Code: 48 c1 ea 03 80 3c 02 00 0f 85 a2 15 00 00 49 8b 87 20 0e 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d 78 02 48 89 f9 48 c1 e9 03 <0f> b6 14 11 48 89 f9 83 e1 07 38 ca 7f 08 84 d2 0f 85 f4 11 00 00
RSP: 0018:ffffc90001c2efa8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888114c4b000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff8491bef0 RDI: 0000000000000002
RBP: ffffffff87c293e0 R08: 0000000000000004 R09: 00000000000005dc
R10: 00000000000005dc R11: 0000000000000001 R12: ffffffff8492f590
R13: ffff888114c4a000 R14: ffff888107be40b4 R15: ffff888107be4000
FS:  0000000000000000(0000) GS:ffff888269262000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3205ffff CR3: 0000000008ea4000 CR4: 00000000003506f0
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 a2 15 00 00    	jne    0x15b0
   e:	49 8b 87 20 0e 00 00 	mov    0xe20(%r15),%rax
  15:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  1c:	fc ff df
  1f:	48 8d 78 02          	lea    0x2(%rax),%rdi
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx <-- trapping instruction
  2e:	48 89 f9             	mov    %rdi,%rcx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	38 ca                	cmp    %cl,%dl
  36:	7f 08                	jg     0x40
  38:	84 d2                	test   %dl,%dl
  3a:	0f 85 f4 11 00 00    	jne    0x1234


Tested on:

commit:         d1b07cc0 arm64: dts: s32g: Add USB device tree informa..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=101c3582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
dashboard link: https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141bca8c580000


