Return-Path: <linux-kernel+bounces-825879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44ECB8D073
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941E91B254A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091326B97D;
	Sat, 20 Sep 2025 20:09:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AD231A55
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398945; cv=none; b=WtQKV84NHKQxotDVo575LcgEAdtr7uLF72NWyM6pau8MhHNF8jZJPfweI/T12ySjU/7/E8AVtxT0oHyp3njDYevtacBElK8A7uA6VHKUNb9/ceXKksvxMBGnh2KsTg5bz8EhpDxBNQltsgc2ZvZlULaFSFA0tv11JeMwyirNcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398945; c=relaxed/simple;
	bh=4pXvrm+PF2ghRpyriygu1W4ypkOD4HhsPq576Ao2mK8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Iil4lEoPEVFqZ6VmUq58LYbkfX0KdbwQEv2Qx5KL4tGkUV0cQ7/bZail7lelH4L2kRr3tVHyG0thpnXjFoJHZAr6ilY1QKMKz2R13DObd6wIA8j9dKjvnmdNQU5epZUjpD2wG3/W+mxjDPx3dDqrJoLTB9Sc0YESk+2fr5iOpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870219dce3so333934939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758398943; x=1759003743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDYZ+gjPSArHw1YZRYW3nR+t1dIqfbHWWgKScrDbMvU=;
        b=BV6u8i2hy2O0/+ddR5GYeKtE+B3lDTOt88yMf0/Nn9oKTTNUyZZXRqmBe9XzL7bRrq
         +J3FvxferA6OC3/1Coy+H2O0sWdE2eWrCIh/MObrqbZNeUoYTwqcP/1rpPYBAsJBi5nc
         +sPgAq8HzNtkxjlZ/tD7q28VfenxWgnEF/W0+5v9QaCELJBDsr0ZXtkbne9GM9ZJCfhg
         FT2K+nMd56jJN2nocs/GPEDKRtHcLTjrLKEyXakmcbqgoT6bSLn6U4v5ASw+mkBfDZHz
         AnPyUXnwSvWOnpL9lHSs9IL16OeXSJM0L8XjHS3zIvjdYr5ZxTYrFrzQ0HYSD7pmKCuh
         VV/w==
X-Forwarded-Encrypted: i=1; AJvYcCV77CzVO6pAwv/Env+an7G4qJaPsMy7zfHiAt7kvDTYrkA57OfQk91I/+gikV8/jW4MgLi0lZs2d+6NqIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4tlljQS41VnB9BYS5r5Kd4anqdKy8zVYwehFnEHK7OdZCjpt
	T8n/L1M5k+/76u/jkQmxVby+h5J6foE/5UePTijOaMh13JhsIBojkFLO9DnSFmho/Q2IfOFNk8K
	bOihhEaKmyMcKBaoukzj6P6behsEPdAKbt+2HeqmjuBothtuISKrmiUH/qZE=
X-Google-Smtp-Source: AGHT+IEiz0LUpKQSB2gpIEvpFhuQ3nFQUP3fxevc/0o8aYkEpfUZleEZzhAygl/spzx/cGj+0lpCEWaOt5bR5uJmz7N78spPBpdc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258a:b0:424:3b83:4f5f with SMTP id
 e9e14a558f8ab-4248190bbd3mr106740565ab.8.1758398943353; Sat, 20 Sep 2025
 13:09:03 -0700 (PDT)
Date: Sat, 20 Sep 2025 13:09:03 -0700
In-Reply-To: <CAL4kbRPcgyZtXEGuiAR+dpiqfsawnwyKovtKy_vWEgowF+HDMQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf09df.050a0220.13cd81.0022.GAE@google.com>
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
From: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __alloc_skb

------------[ cut here ]------------
kmalloc_reserve: request size 4294965248 exceeds KMALLOC_MAX_SIZE (4194304)
WARNING: net/core/skbuff.c:598 at kmalloc_reserve+0x2df/0x2f0 net/core/skbuff.c:596, CPU#1: dhcpcd/5527
Modules linked in:
CPU: 1 UID: 0 PID: 5527 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:kmalloc_reserve+0x2df/0x2f0 net/core/skbuff.c:596
Code: ff e8 b5 75 54 f8 c6 05 18 35 63 06 01 90 b9 00 00 40 00 48 c7 c7 60 2e b4 8c 48 c7 c6 d4 5d c3 8d 4c 89 ea e8 22 e7 17 f8 90 <0f> 0b 90 90 45 31 e4 e9 37 ff ff ff 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90000a089b0 EFLAGS: 00010246
RAX: 40535143de383200 RBX: dffffc0000000001 RCX: ffff88802f97bc80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90000a089fc R08: ffff8880b8724293 R09: 1ffff110170e4852
R10: dffffc0000000000 R11: ffffed10170e4853 R12: 00000000fffff6c0
R13: 00000000fffff800 R14: 0000000000020820 R15: 1ffff9200014113f
FS:  00007fc29b83c740(0000) GS:ffff8881258a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc1fdb0168 CR3: 0000000033cd0000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:677
 __netdev_alloc_skb+0x108/0x970 net/core/skbuff.c:741
 rx_submit+0x100/0xab0 drivers/net/usb/usbnet.c:-1
 rx_alloc_submit+0xa6/0x140 drivers/net/usb/usbnet.c:1538
 usbnet_bh+0x9a5/0xd70 drivers/net/usb/usbnet.c:1607
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3607
 tasklet_action+0xc/0x70 kernel/softirq.c:952
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 do_softirq+0xec/0x180 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:450
 __dev_open+0x694/0x880 net/core/dev.c:1690
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9630
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9693
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1199
 inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0xdc/0x300 net/socket.c:1241
 sock_ioctl+0x576/0x790 net/socket.c:1362
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc29b93c378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007ffd8c8eaa48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 00007fc29b93c378
RDX: 00007ffd8c8fac40 RSI: 0000000000008914 RDI: 0000000000000016
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8c90ade0
R13: 00007fc29b83c6c8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16561534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144b60e2580000


