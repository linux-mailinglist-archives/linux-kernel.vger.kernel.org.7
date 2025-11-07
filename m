Return-Path: <linux-kernel+bounces-890039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6EC3F1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FA8188944F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AE26E6F0;
	Fri,  7 Nov 2025 09:21:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98391EE033
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507264; cv=none; b=UQyCSI+dcbAEFCqHP7CjYIsaZ8OuJehJh/bRCoryw1kSJeNswdVsaBpt3C7a3cqCeo2l9J/yc848uHG0qmIuAKufRUuobBgrxK6VeQ7SW4+M9+1cMBKs81FfCouUqT+Hqf/GTMkEBpAhht1uXy/YgAirb3Jrvm4bg7nVCPigq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507264; c=relaxed/simple;
	bh=pK7waILPARxcXz7rtyXj7yiSb3tmvpYR/ILHsidPIvM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SaoIZpLFfUZfCaakWdyFOcN1kt7lVRWHxhH4j+9b6//6vZ4+NYWs+bmahjQjVXC6L8gmeWT05pAXx+q7R5U65qPqT+ymSRkR3SP1WxOndC6AOAUxoBph+tID7SJz4Gm8OHxWTtXw3c2dtuDsQ10nCYPaMXPoTA7m/bb42I2RHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9484c2ac07cso41258139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507262; x=1763112062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBzaZiTF40i9kCKfIHVKyk6BmH3UvxrY9UMO8UA8Vc4=;
        b=Pa69/9AvZdbLNY269ZEH4OTM4UZO6MLviITfTwHEv1XZ0yLliCpaebiRT9hjJ2GO+z
         cbU3IFF/2maPENykRMDnmiLZCZLO7HvZJoN+h3YYqDJVlEQMRmeJHRQtCNcJ6LGjF0wY
         Np0gL0TdQaOERlFTkrbIHUMnavd4QPDUkM+3oAIhNG5+G8QWHR/i88kaPOdCARDYr49a
         O43ElFot1Xg3SaOHtVwO5Te+T15cJdTXTh2MgV++mqTWyYhX0pI/mFhamFoGXfCB24g7
         0/2xDbXvY2rVZgFKgn0N1fYeGqal3DkBfEfWgNna1YPrrNvj/jdNx5CwULGA0oGbOMIo
         iqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUDIQJTz7FuPg+djY1eTQbxdm26hWMRVlZGtsA/YhlzPTnZTvdG/lCu2e4vYWxSdnrtmreA1cEsU+FECGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XpqMu0froTNIVIN5zHy1wiGD8h+TDur2GGIBvvwZ1/fRpUpP
	+c1x9XIsa9j3sh/GyWcgSj1ooYk3nObZJzXoi0CTY1PleXJAbkO56g8NG9nZe/vzKIMysm6K/Bz
	0Hk9PT8cT20zTPxhsvJlDnhltShawYgT1JUrKcxawcVyi0/aQpkxQoCEDfmI=
X-Google-Smtp-Source: AGHT+IHGLAwHFHSGCw1ZqlWFhU2e1nkPgbz4KlSind5XkWscGKQ44OLznWywo773nHUb0ZLTLi5ZuqjmhQZpsDqyJ8/b7Ftx4nDD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:433:377:ab8 with SMTP id
 e9e14a558f8ab-4335f47ef1amr29709715ab.23.1762507262108; Fri, 07 Nov 2025
 01:21:02 -0800 (PST)
Date: Fri, 07 Nov 2025 01:21:02 -0800
In-Reply-To: <5715ad57-d676-ecde-1636-1634b49316d6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690db9fe.a70a0220.22f260.002f.GAE@google.com>
Subject: Re: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: hariconscious@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in tipc_buf_acquire

tipc: Started in network mode
tipc: Node identity 5e9377e8cc82, cluster identity 4711
tipc: tipc_buf_acquire
skbuff: skb_over_panic: text:ffffffff8fe53c01 len:76 put:76 head:0000000000000000 data:00000000000000d0 tail:0x11c end:0x0 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:212!
Oops: invalid opcode: 0000 [#1] SMP PTI
CPU: 0 UID: 0 PID: 6600 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:skb_panic+0x2d3/0x340 net/core/skbuff.c:212
Code: d0 44 8b 45 cc 4c 8b 8d 58 ff ff ff 41 52 ff b5 70 ff ff ff ff b5 68 ff ff ff ff b5 60 ff ff ff e8 d2 5d ee ff 48 83 c4 20 90 <0f> 0b e8 c6 8f 69 01 48 83 7d a0 00 0f 84 6a ff ff ff 48 8b 7d c0
RSP: 0018:ffff88801f8cf0e8 EFLAGS: 00010286
RAX: 0000000000000085 RBX: ffff88811718cda0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff88801f8cf1a0 R08: ffffea000000000f R09: 0000000000000000
R10: ffff888237c7e028 R11: ffff88823f278d40 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f26537fe6c0(0000) GS:ffff8881aaf8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2654574620 CR3: 0000000049ab8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_over_panic net/core/skbuff.c:217 [inline]
 skb_put+0x1f5/0x250 net/core/skbuff.c:2583
 tipc_buf_acquire+0x141/0x1b0 net/tipc/msg.c:77
 tipc_disc_create+0x12f/0x870 net/tipc/discover.c:359
 tipc_enable_bearer net/tipc/bearer.c:348 [inline]
 __tipc_nl_bearer_enable+0x1f61/0x2a00 net/tipc/bearer.c:1047
 __tipc_nl_compat_doit net/tipc/netlink_compat.c:371 [inline]
 tipc_nl_compat_doit+0x67b/0xa10 net/tipc/netlink_compat.c:393
 tipc_nl_compat_handle net/tipc/netlink_compat.c:-1 [inline]
 tipc_nl_compat_recv+0x1007/0x1670 net/tipc/netlink_compat.c:1321
 genl_family_rcv_msg_doit+0x338/0x3f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xacf/0xc10 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x54d/0x680 net/netlink/af_netlink.c:2552
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f265458eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26537fe038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f26547b5fa0 RCX: 00007f265458eb69
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000006
RBP: 00007f2654611df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f26547b5fa0 R15: 00007ffe744cefd8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x2d3/0x340 net/core/skbuff.c:212
Code: d0 44 8b 45 cc 4c 8b 8d 58 ff ff ff 41 52 ff b5 70 ff ff ff ff b5 68 ff ff ff ff b5 60 ff ff ff e8 d2 5d ee ff 48 83 c4 20 90 <0f> 0b e8 c6 8f 69 01 48 83 7d a0 00 0f 84 6a ff ff ff 48 8b 7d c0
RSP: 0018:ffff88801f8cf0e8 EFLAGS: 00010286
RAX: 0000000000000085 RBX: ffff88811718cda0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff88801f8cf1a0 R08: ffffea000000000f R09: 0000000000000000
R10: ffff888237c7e028 R11: ffff88823f278d40 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f26537fe6c0(0000) GS:ffff8881aaf8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2654574620 CR3: 0000000049ab8000 CR4: 00000000003526f0


Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a79084580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2901a6a99b67fbcc
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107a332f980000


