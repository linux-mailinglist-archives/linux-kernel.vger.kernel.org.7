Return-Path: <linux-kernel+bounces-764702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B11B22636
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C262A3EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038D2EF647;
	Tue, 12 Aug 2025 11:58:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665C1A9FB8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999884; cv=none; b=II2XOBIDQtsoA+Ymjx02siyu8O4iKmtTGzfdHxTkJB2oT77qLkkH2L6HiojvOelewTwU8y0Re//5g3zvuDzAl7lZlGDRoYURv15NcUIvgDve23o6OhuAJ4nLqNiJ5mYg7ywUkrmI+lADdQp3PjvIyVGwsbL+u1TctuIr43F0IK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999884; c=relaxed/simple;
	bh=l4MH3bgax6c2N8wDWffGZkCNG9/XE70fMAHCgWJydng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AbisP9Gqj8Sc4x3D9Z7LdCs0s3hhYiIweDWzQdeZagkBEuRliKbu/BjLwCBJHTa8JgvcI+N+aGXKXElfUMfmLXXyYDhBOuots93alf48f5zhICq6hiMuH9kAa+AxAhLi33A7HXHN7avQY/FMzaqOAUcRP7tgoHqhfrLfFELVwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88178b5ce20so1105978739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754999882; x=1755604682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xBppgRfD02o3SP6Q8wely3D2c+DYCB+GxxtuqCbTzc=;
        b=titXWJ6kRyyrP8MIcdYXtrp0uBoPRmb3eJFzeGQNKjt3lVhKSEfXqIoA/SwlZDRy9v
         nNGrV75MK5zxu/Y6xZ4dsWxn2fQG0Fc6AWS7/1Pd2JMMOYOQ6nAbf12B6ldjLXmGvd3l
         9YsQ2kYjP31xABm1JZKOQsQlSW3O9CLSXp2cAnyminQyZZy62/QvrjU2qjh3zPrhpWO3
         /QcuJ8FP1Fp/gXK7ybSkIlUSEyjr+n78UsdeZGT09XnLzOAoZJLeek1lk6Kr0XDsMRZH
         y0k8z9ZrD2dwzVrPYnxtUsp/gN4WzgZov9fV8lvphNbAg0xqV98d2ah8S16JpcV9YJak
         1jIA==
X-Forwarded-Encrypted: i=1; AJvYcCWztnDrCKapnzOUT5hQwzkzCVY0CL74oIdr1mv/syMPXxVH2OImqFclStX+8xNeyO0y8YGvTsw3A97bPaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykOxOm4nh2lqW/tSl8vO0cY2I6Cr44WR32nxGcJGuvh57ebMBD
	vEUeysF+lxOXkSTYgnNORZOZvDMOVKkW7DzFgzASOVd997WrJhEhHeuEEJvTI5KCYKMbaoE1YrE
	YrefQ7NmehUYygRJUdySwRBcHHs/nmeIBbo+roPpTET+Q+6MVLzN/8WtGuIw=
X-Google-Smtp-Source: AGHT+IGsIXGy75SpegN5DEtu4xJbZOBL8uYT2vTOK6FwE/Qm16HToBPU8/JtHhzGS0Mwlcyn0iJ46g7p8gmfi0wIHZ62bfWQ9SbJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164a:b0:883:ec00:e2e7 with SMTP id
 ca18e2360f4ac-8841bf1d0c8mr696999139f.14.1754999882122; Tue, 12 Aug 2025
 04:58:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 04:58:02 -0700
In-Reply-To: <20250812113518.4238-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b2c4a.050a0220.51d73.00ac.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in nsim_queue_free

BUG: unable to handle page fault for address: ffff88808d211020
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 1a201067 P4D 1a201067 PUD 0 
Oops: Oops: 0002 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6909 Comm: syz.5.346 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xdc/0x150 drivers/net/netdevsim/netdev.c:714
Code: 10 1d be 8d 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 9b 1a 0d fb 49 8b 07 48 8b 0c 24 <4a> 01 4c 28 20 4c 89 f7 be 00 02 00 00 e8 32 5a 6d fa 4c 89 e7 be
RSP: 0018:ffffc9000df2ede0 EFLAGS: 00010246
RAX: ffff88808d211000 RBX: ffff888033a85800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000000 R08: ffffffff8e1e6327 R09: 1ffffffff1c3cc64
R10: dffffc0000000000 R11: fffffbfff1c3cc65 R12: ffff888033a85a18
R13: 0000000000000000 R14: ffffffff87178be3 R15: ffffffff8dbe1d10
FS:  00007fd976a5a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88808d211020 CR3: 000000003f37a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nsim_queue_uninit drivers/net/netdevsim/netdev.c:996 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1052 [inline]
 nsim_create+0xbee/0xf20 drivers/net/netdevsim/netdev.c:1104
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd975b8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd976a5a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd975db5fa0 RCX: 00007fd975b8ebe9
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007fd975c11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd975db6038 R14: 00007fd975db5fa0 R15: 00007ffea085f7f8
 </TASK>
Modules linked in:
CR2: ffff88808d211020
---[ end trace 0000000000000000 ]---
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xdc/0x150 drivers/net/netdevsim/netdev.c:714
Code: 10 1d be 8d 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 9b 1a 0d fb 49 8b 07 48 8b 0c 24 <4a> 01 4c 28 20 4c 89 f7 be 00 02 00 00 e8 32 5a 6d fa 4c 89 e7 be
RSP: 0018:ffffc9000df2ede0 EFLAGS: 00010246
RAX: ffff88808d211000 RBX: ffff888033a85800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000000 R08: ffffffff8e1e6327 R09: 1ffffffff1c3cc64
R10: dffffc0000000000 R11: fffffbfff1c3cc65 R12: ffff888033a85a18
R13: 0000000000000000 R14: ffffffff87178be3 R15: ffffffff8dbe1d10
FS:  00007fd976a5a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88808d211020 CR3: 000000003f37a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	10 1d be 8d 4c 89    	adc    %bl,-0x76b37242(%rip)        # 0x894c8dc4
   6:	f8                   	clc
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  12:	fc ff df
  15:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  19:	74 08                	je     0x23
  1b:	4c 89 ff             	mov    %r15,%rdi
  1e:	e8 9b 1a 0d fb       	call   0xfb0d1abe
  23:	49 8b 07             	mov    (%r15),%rax
  26:	48 8b 0c 24          	mov    (%rsp),%rcx
* 2a:	4a 01 4c 28 20       	add    %rcx,0x20(%rax,%r13,1) <-- trapping instruction
  2f:	4c 89 f7             	mov    %r14,%rdi
  32:	be 00 02 00 00       	mov    $0x200,%esi
  37:	e8 32 5a 6d fa       	call   0xfa6d5a6e
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	be                   	.byte 0xbe


Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109135a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11104c34580000


