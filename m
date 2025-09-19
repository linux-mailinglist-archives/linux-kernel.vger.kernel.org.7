Return-Path: <linux-kernel+bounces-825032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436CB8AC27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF7189B13A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6AC2BE622;
	Fri, 19 Sep 2025 17:28:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71C155A30
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302884; cv=none; b=RrPORhBZPuJobf23MS6708cGjbfkAoYaE0VVFfWvmIG13+oqrW1m2mZSQ/kv07YK4q+3u1Xk2Su+xqUlD4ZiYCL9DsEKHvxIAvoepbketSCgj2RsFoeo5W5ZzR5pKXNiA0fqC+mtoGpXjrPHBivlR58p4wR41+pzPBcYlT5kBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302884; c=relaxed/simple;
	bh=aaEsskrYUf3yh/kMjPF+zXSD/HaRmP+x22S6BR9fgpI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MIpEsg7TbiZ8b7RBr7+vkQC3r91ZeRTnF0Rv1TS0eGaVaQK5nrlNuhT+66qvRREfQhgPcL17i0lnqlD+W1flaslWoKGKAQB94K4hi6Sew+xjkQjO3mrep5bEL8+fqK+GTVYm+C/k9uTEt50tybt111b9FOGrRi4+Q7kXFTzOn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42407a5686fso30946995ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758302882; x=1758907682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18gFfbxbc6u/YWplaPJAkcMgqVR6F1JLSLq0khpVAqk=;
        b=MzQtLPpOqdj9MFwOSad4c7RM1im88rK9zwFZqhuCoCPzG8MezxKRPK/AD1V0t6RShK
         b1DFH2WVVj6F7yw2QHcVWVL+OWw4eH3B/crf1RowkvQpEA5PbdOzT9VRtxsu7H7+965z
         tZpWV2d225a/57iHMWQWoPa+Q2ZTye2XB7bp4N/UkCZBE/s7ELkBEkEY3CE1OzUV272C
         Tg/pdgoXiEvMlyWGJWmld2SYbwUVLuQIwG231M7iRy66iYk3Bgaap96vA+3W9VHvQu2C
         RdaAIY7TWzyvpXl6NucWRLrTqqAUOHP/a5yKoiGd5xxu9kB8FfqzUhq03J77+yHAO3mW
         MEUg==
X-Forwarded-Encrypted: i=1; AJvYcCXJf96P1KqoeriNKbEyJEpv1Gn+2l0y/cn/T2J3Xg9a8PvxeiLWYhnKGB+Vd6Wp3WHx6y9kC+JrA+wruwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQp0x48b1gyEF+6j2GapE8mvb6fTRdUgtnOkFlZ50tDzsng0W
	QmvKbpKd/A+nPsBnV6ZgLRpynV3X1SOXfaKHmmWAIDBXavzmHvcHjxfG+3PjyD7M4dOEmjC+YBP
	Z+HnTE9gbvU/UmCEsTwGtxsnpmD00CMGErlRSijSXZJNzldvJJg8GlulG1iY=
X-Google-Smtp-Source: AGHT+IHEyVoXLGOuXC3jjAL0hKZTsqGt/nmMMdCOZJ7uh/pXEkBomIcYJSdvTko0auReDyzXb49a93nrpeHdjNYALt7GLdmsh1Z9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:424:8030:2f7c with SMTP id
 e9e14a558f8ab-424819748c7mr48231475ab.20.1758302882317; Fri, 19 Sep 2025
 10:28:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:28:02 -0700
In-Reply-To: <CAL4kbRPgrQO_QYOGBFGoPEG9OZet-LVSvGDT2+37-uiKRWh0ng@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd92a2.050a0220.13cd81.0006.GAE@google.com>
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
From: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __alloc_skb

------------[ cut here ]------------
WARNING: mm/page_alloc.c:5124 at __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5124, CPU#0: dhcpcd/5533
Modules linked in:
CPU: 0 UID: 0 PID: 5533 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5124
Code: 74 10 4c 89 e7 89 54 24 0c e8 f4 11 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 fe aa b7 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc90000007780 EFLAGS: 00010246
RAX: ffffc90000007700 RBX: 0000000000000014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900000077e8
RBP: ffffc90000007870 R08: ffffc900000077e7 R09: 0000000000000000
R10: ffffc900000077c0 R11: fffff52000000efd R12: 0000000000000000
R13: 1ffff92000000ef4 R14: 0000000000060820 R15: dffffc0000000000
FS:  00007f76a8485740(0000) GS:ffff8881257c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056268ae52138 CR3: 0000000032510000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:4306
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4337
 __do_kmalloc_node mm/slub.c:4353 [inline]
 __kmalloc_node_track_caller_noprof+0x34d/0x4a0 mm/slub.c:4384
 kmalloc_reserve+0x1b8/0x290 net/core/skbuff.c:608
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
 __netdev_alloc_skb+0x108/0x970 net/core/skbuff.c:733
 rx_submit+0x100/0xab0 drivers/net/usb/usbnet.c:-1
 rx_alloc_submit+0xa6/0x140 drivers/net/usb/usbnet.c:1538
 usbnet_bh+0x9a5/0xd70 drivers/net/usb/usbnet.c:1607
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3579
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 __dev_open+0x694/0x880 net/core/dev.c:1690
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9549
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9612
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1200
 inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0xd9/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76a8585378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007ffd0f936168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007f76a8585378
RDX: 00007ffd0f946360 RSI: 0000000000008914 RDI: 0000000000000012
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd0f956500
R13: 00007f76a84856c8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


Tested on:

commit:         7fa4d8dc Add linux-next specific files for 20250821
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=115a1858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53aaf18b1b202211
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

