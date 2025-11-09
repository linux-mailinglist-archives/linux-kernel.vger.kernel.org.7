Return-Path: <linux-kernel+bounces-892123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (unknown [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E1C44647
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF86F4E28FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13C23183A;
	Sun,  9 Nov 2025 19:37:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D91F4C96
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717028; cv=none; b=A6mXm30ge8k8+p2aYaGzT2eA1hD0y+EIwlkYqyepfX9v8cEXP+iMsXdkciDjMY0hSIEPdI4TMAG5zAjvHdEpNH8c4KXq5PMvxX4G9Wq1np69UvBvtKJTpLGBaepTikiJ7t8NuUHmnQEIDg/9YL5M8mi4SkeTt4DJ89yyn+dFB+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717028; c=relaxed/simple;
	bh=UfYfGMa3UdDyJjqRebIxH3RIgn+9lCgJsgmNqnRAERU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZCDe5YAVDhtHWlcXxJkt/KOYlI/8EOmt2sN1vJPSxD3Zp0PtUj+8h3CHckWZTV5bMDqZZ5/tEdLwMXc0qzanx1/2GW9LvFNicGTUMxn5/Pm/hCQaINfeFKRFKD8GXLLiy0G02hJFXG1qwNFwB52JD4V79lbtNJmR+SEBzWs1yY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-948610ae935so190397839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 11:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762717023; x=1763321823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsXBDvRPlJEspKmfedhkCnS4oygq2vYrsW8vCl92Jyc=;
        b=Tpx34d+FyJ0XR2K94/HAMyVK6FtUh56UV9MP5Zu4YEyMszH4XwWJSVgrvQUws3pw2P
         31UuPjQJeCPkLjynBFDuh8PpPE2xRBoec53I+fVzSNoon9kaowYkPztXUK3wUJMqpWSM
         MSHzvTwLU0vp/eSq/GTZQrlsqQax2gRkZZHVZ/L8AHeT8T1WwtZVnwhkLDL8qjPZzHDu
         oLXiQOCREf3aNL/1jXWZiwqxSP2EhRn450dLaLifaAj9hSgPsCKRhuZvplCMyb4bUnpU
         dgTo76+kduRrBsD4jYDJEqyO9pjDCxhabolqJSjplJwtOfaFB9IByLhb5CqNgjypNsrv
         5lHg==
X-Gm-Message-State: AOJu0YyYVr4NQRgZUoZVt9eD+4mNMyoMz8ZFg0nRGs0qBOz6ZF7ldwFR
	BKMUXY3NCMe0PNQuko87yUDqhEIpDa3DDFxkEJ5O5QYQ+GK+WVKgDS1Yji4p5hFenipbzDzxB2m
	ItgDTnomv5O7rrCq8y8Ja326ZcsR+EuPzpJ1kqywU++8rK5l906ZqJ2rDrbo=
X-Google-Smtp-Source: AGHT+IFIcuSmgVEAEkX3VbeV/93HPlDjbGotYbKsFkCQm+F2l/RGizHT56XKs4eN8Az4qae04xkWF+nZ1jlC1GGznrP+V06GiMSE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6412:b0:948:3d23:529e with SMTP id
 ca18e2360f4ac-94895f9a893mr889218539f.4.1762717023450; Sun, 09 Nov 2025
 11:37:03 -0800 (PST)
Date: Sun, 09 Nov 2025 11:37:03 -0800
In-Reply-To: <CAHjv_asZ2DhnOf8CV8FFi5oBQ-zEvHLt6zHocM8SavZB-C3cLw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910ed5f.a70a0220.22f260.00c1.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ipgre_header

skbuff: skb_under_panic: text:ffffffff89db8e37 len:1318440572 put:1318440500 head:ffff88805841d040 data:ffff888009ac02cc tail:0x108 end:0x180 dev:team0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:212!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 54 Comm: kworker/u4:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 20 10 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 be 96 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000101f2f8 EFLAGS: 00010282
RAX: 0000000000000097 RBX: dffffc0000000000 RCX: 0329d406b208d700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc9000101f007 R09: 1ffff92000203e00
R10: dffffc0000000000 R11: fffff52000203e01 R12: ffff88805434e290
R13: ffff88805841d040 R14: ffff888009ac02cc R15: 0000000000000108
FS:  0000000000000000(0000) GS:ffff88808d75f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555771e9588 CR3: 0000000059800000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 skb_under_panic net/core/skbuff.c:222 [inline]
 skb_push+0xc3/0xe0 net/core/skbuff.c:2602
 ipgre_header+0x67/0x290 net/ipv4/ip_gre.c:895
 dev_hard_header include/linux/netdevice.h:3419 [inline]
 neigh_connected_output+0x286/0x460 net/core/neighbour.c:1619
 neigh_output include/net/neighbour.h:547 [inline]
 ip6_finish_output2+0xfb3/0x1480 net/ipv6/ip6_output.c:136
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:220
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xbce/0x1510 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xcb/0x150 net/ipv6/ndisc.c:670
 addrconf_dad_work+0xaae/0x14b0 net/ipv6/addrconf.c:4282
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 20 10 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 be 96 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000101f2f8 EFLAGS: 00010282
RAX: 0000000000000097 RBX: dffffc0000000000 RCX: 0329d406b208d700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc9000101f007 R09: 1ffff92000203e00
R10: dffffc0000000000 R11: fffff52000203e01 R12: ffff88805434e290
R13: ffff88805841d040 R14: ffff888009ac02cc R15: 0000000000000108
FS:  0000000000000000(0000) GS:ffff88808d75f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033


Tested on:

commit:         f850568e Merge tag 'i2c-for-6.18-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15634b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486aa0235ebabcac
dashboard link: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

