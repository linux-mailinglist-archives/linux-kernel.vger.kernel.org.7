Return-Path: <linux-kernel+bounces-860032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD5BEF2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D15314E7BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ADD26CE05;
	Mon, 20 Oct 2025 03:16:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3822083
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930166; cv=none; b=lZ6YSrdnwzt8w2khqCI5FvYt2jBJ59xZPKASSeZMshU9mntP6xUw+BaT4gvdlWIRSHNDoBuGr7bAdVjzroCLaQgX63sEUEz6lL7AFjigR6sSwGzVMU5M2oHFeuWWmq0PJUofDybDuAapmd2SzubQa8N172COUfNLRbMdBJtAVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930166; c=relaxed/simple;
	bh=g9TKGeQhUxIlOPlEuXHzpzDTdxiEO6XArSUQODFppgo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=szm1GGcnFwMFfcR98Zd0Rf8FBs/IpMhT/SOA14WHkjqFlP5rD7Y2tP9TRJ463XIjKvYBrZwA9d7Ke0Gi6XBMlaPE6VIwKFM+oCtOPdZ99mLg0w1EYMijT8Yy82Jx0OsywoI3tkv8hubhn6qr2xw1lVlgsDucQpQWMXGSxKavHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e85344382so619473639f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930164; x=1761534964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCBLHYs6iMUqUpPrztMtBA/nY1gLV8nFEOGj2Q0kA18=;
        b=fJQrWpeGY/33RS3hzRgPksqNGJb9xw+VTbt7Owoqe74sIRABWpUFsGDRtzLr9oTUev
         k0vrTmlX0On8OGH2rxZjiOq+4OHCJYqILIWWStrt4eVapmRJtWuD9RRxRRGlOJkpZZXT
         RvGoYIvtQsCTLfZ7nXkBrSgREqFjG/MNQ5RdgfyErW4AUVIqWSy5HMVmxwH1ACkwkwo2
         EB3i4MEnQAL65C4LScy0MjvGBDWTOVxgruvVNCBe93jIIFKaPXophEpH7CpaTcshE4Yq
         LWYWJfTqAnyOAgd4CL3BLPsjkYoLKXWG8d7vMpWVIjXNKXppPeDRM/N+AnnCt3C/95SR
         8dsw==
X-Gm-Message-State: AOJu0YzlTStD0QAxjbec00KmA41pzD3YFOC4//nkcPytERyYOCnW8AMY
	fbat0NR73qzwDO8DSlpYz7IMRkePNCqdrAR2ZVHnPjK0EhukbH1RPhbOQcCgzZ36zoGfazhs2Tz
	si7KvPpqjuujt54xIok1Bm+AkjUZaVc9e5KeOTiKyvdtefqCsNfjeLbCqE/0=
X-Google-Smtp-Source: AGHT+IGJ6EDtvQnPuD2/u93EXJa8E6sX2N/QSRc6c2lbdGXC0XhqIgbbu3FV9cGwYTqO/WrMT6JxhxoHEXX1zv0a6jxAW5ep85Cl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d1b:b0:93f:fca2:e548 with SMTP id
 ca18e2360f4ac-93ffca2eba6mr895663639f.8.1760930163925; Sun, 19 Oct 2025
 20:16:03 -0700 (PDT)
Date: Sun, 19 Oct 2025 20:16:03 -0700
In-Reply-To: <20251020025728.15250-1-ssranevjti@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5a973.a70a0220.205af.0024.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ssrane_b23@ee.vjti.ac.in, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in set_ipsecrequest

skbuff: skb_over_panic: text:ffffffff8a205d63 len:392 put:16 head:ffff88805b276a40 data:ffff88805b276a40 tail:0x188 end:0x180 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:212!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6444 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 60 0e 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 4e 50 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003c06b68 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: 05b0c7e83ffe1100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003c06867 R09: 1ffff92000780d0c
R10: dffffc0000000000 R11: fffff52000780d0d R12: ffff888078c92150
R13: ffff88805b276a40 R14: ffff88805b276a40 R15: 0000000000000188
FS:  00007f2bce8166c0(0000) GS:ffff888125d0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f90ed0682d0 CR3: 0000000069384000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_over_panic net/core/skbuff.c:217 [inline]
 skb_put+0x159/0x210 net/core/skbuff.c:2583
 skb_put_zero include/linux/skbuff.h:2788 [inline]
 set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532
 pfkey_send_migrate+0x11f2/0x1de0 net/key/af_key.c:3636
 km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2838
 xfrm_migrate+0x2020/0x2330 net/xfrm/xfrm_policy.c:4698
 xfrm_do_migrate+0x796/0x900 net/xfrm/xfrm_user.c:3144
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2bcd98eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2bce816038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2bcdbe5fa0 RCX: 00007f2bcd98eec9
RDX: 0000000000000000 RSI: 0000200000000380 RDI: 0000000000000004
RBP: 00007f2bcda11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2bcdbe6038 R14: 00007f2bcdbe5fa0 R15: 00007ffd8b27cbc8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 60 0e 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 4e 50 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003c06b68 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: 05b0c7e83ffe1100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003c06867 R09: 1ffff92000780d0c
R10: dffffc0000000000 R11: fffff52000780d0d R12: ffff888078c92150
R13: ffff88805b276a40 R14: ffff88805b276a40 R15: 0000000000000188
FS:  00007f2bce8166c0(0000) GS:ffff888125e0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001f40 CR3: 0000000069384000 CR4: 00000000003526f0


Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e10e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

