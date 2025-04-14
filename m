Return-Path: <linux-kernel+bounces-602049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F87A875D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 04:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D3A3B1F03
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF61953BB;
	Mon, 14 Apr 2025 02:14:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053718DF80
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596872; cv=none; b=g2eEn+OJoPKBObaCbOw5/idCF/aHPlLTicpBbAK1gehOrbI6wrInBDetWiiiAdz+7MRxAmVw58iCyrm+bIDlXx+X5TPVixQStNGjIhFr3eJPjNf6Wsv3322lTcNVx5p6EVOCMae4WoRH/d/wa9TjeRqZU7K5+7fXS3H88teh8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596872; c=relaxed/simple;
	bh=ZTMJ5fBL1jAa7eGpNLjsBHReZAQRzmGLRrwSqR+2HFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q9w63+TOYnfs4teu9199L5zTX7QjRpa7oxfP+twFDlRxVWYXLEEDStkE3/qIF0mVZYUAk0T0tfyP8BqYIWz6v65bONwMaVCLW2jmc749tjxcKKAhpjwFtURmWq3jl5/hLt7oYXWnI9jhg9lT7dAa/yUUXknMBY5och+MFCh9Wwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d4578fbaf4so75639555ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 19:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744596870; x=1745201670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktSa8+/EtzSIWWhYOXPZP3Up0UOv8c3CxbcGpNsWxIA=;
        b=sbSVhCmZIlQFLCjHg9TMypepvCIjw/Z2Iq0fNRb3uoeSValRZEiH07M9QzZWWWps5P
         xWJ2ZEvfQLt6mv55syK3OIf91e89aP0JEk8SfHpIuUv4d/mPyesbWjQN0hI370JUIa4R
         q+0LEtdq+3pmjQ60eBs3TTk9u+0v7CfdagA7YgjHvMgAvWdzTTLHYnTx5qyFumZrF1xa
         UzRlR9NrrVClDHWpV4RpmGOIokXc4HIwVymTZtpc61rutdsjx5JoDDwrZIyVDZuARJlW
         KgLoU7GSb2/Nby9orY4FfGS06n4mxUic5uBHvI0X6puavc/pl1QYeUwJ3qX+5TSlQeGe
         ojyw==
X-Forwarded-Encrypted: i=1; AJvYcCWOo6wFRQIVSUfsS+BJ7+aNKV0xOmijd0VgIzkDJnlOV1q+l6OBY45JKNXJ8itYtBLEB03tI+zmYL5Ceao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/AYNgcb7zSej+NOB2pz9XAVBZU8G8Vzli6Q7wBFRyU43guVq
	A+XQZwV7UAxFdPXZRXys35cwkmm8n7ZD7e+L0fP/Wv3dJfljpsYN4UevyTAFHC+krQgOBXVNNl+
	HPku7xNAD3I9vpkjt6zjs9mipsBN5YGB41EaLzfrBnU9Lumv4lCPxlyY=
X-Google-Smtp-Source: AGHT+IEJrZg6hqF1ufdYAwrvBroFL4iR7AdZbtkxDq4KIcIyQiMuoBrp2BcWiJqdwZtjuPa6p9iK3vstTt7j07J//Q7pjcmVzDYQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3d5:8908:92d0 with SMTP id
 e9e14a558f8ab-3d7ec1eb8ccmr128970965ab.3.1744596869676; Sun, 13 Apr 2025
 19:14:29 -0700 (PDT)
Date: Sun, 13 Apr 2025 19:14:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fc6f85.050a0220.2970f9.039e.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in rtnl_create_link
From: syzbot <syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>
To: cratiu@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eaa517b77e63 ethtool: cmis_cdb: Fix incorrect read / write..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1541f23f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=de1c7d68a10e3f123bdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1429874c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353f74c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ff6a34dbd2f/disk-eaa517b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80dc0689a89b/vmlinux-eaa517b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/093b749f228d/bzImage-eaa517b7.xz

The issue was bisected to:

commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Fri Apr 4 16:11:22 2025 +0000

    net: hold instance lock during NETDEV_CHANGE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151db7e4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171db7e4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=131db7e4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com
Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")

netlink: 4 bytes leftover after parsing attributes in process `syz-executor402'.
netlink: 'syz-executor402': attribute type 15 has an invalid length.
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000055: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000002a8-0x00000000000002af]
CPU: 0 UID: 0 PID: 5841 Comm: syz-executor402 Not tainted 6.14.0-syzkaller-13348-geaa517b77e63 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
RIP: 0010:rtnl_create_link+0x6af/0xea0 net/core/rtnetlink.c:3680
Code: 24 20 42 80 3c 28 00 74 08 48 89 df e8 4a 3a 3b f8 4c 89 64 24 28 bd a8 02 00 00 48 89 5c 24 08 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 22 3a 3b f8 45 31 e4 48 83 7d 00
RSP: 0018:ffffc900040b6e70 EFLAGS: 00010206
RAX: 0000000000000055 RBX: ffff888035860008 RCX: ffff888030a01e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000002a8 R08: ffffffff89f245f9 R09: 1ffff92000816dfa
R10: dffffc0000000000 R11: fffff52000816dfb R12: ffff8880212e0080
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888035860000
FS:  000055556170f380(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007c1d2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtnl_newlink_create+0x2f2/0xcb0 net/core/rtnetlink.c:3826
 __rtnl_newlink net/core/rtnetlink.c:3953 [inline]
 rtnl_newlink+0x18b0/0x1fe0 net/core/rtnetlink.c:4068
 rtnetlink_rcv_msg+0x80f/0xd70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 ____sys_sendmsg+0x523/0x860 net/socket.c:2566
 ___sys_sendmsg net/socket.c:2620 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff3d9feac39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe861803d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff3d9feac39
RDX: 0000000004000000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000200000000110 R14: 0000200000000088 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
RIP: 0010:rtnl_create_link+0x6af/0xea0 net/core/rtnetlink.c:3680
Code: 24 20 42 80 3c 28 00 74 08 48 89 df e8 4a 3a 3b f8 4c 89 64 24 28 bd a8 02 00 00 48 89 5c 24 08 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 22 3a 3b f8 45 31 e4 48 83 7d 00
RSP: 0018:ffffc900040b6e70 EFLAGS: 00010206
RAX: 0000000000000055 RBX: ffff888035860008 RCX: ffff888030a01e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000002a8 R08: ffffffff89f245f9 R09: 1ffff92000816dfa
R10: dffffc0000000000 R11: fffff52000816dfb R12: ffff8880212e0080
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888035860000
FS:  000055556170f380(0000) GS:ffff888125096000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000140 CR3: 000000007c1d2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	24 20                	and    $0x20,%al
   2:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   7:	74 08                	je     0x11
   9:	48 89 df             	mov    %rbx,%rdi
   c:	e8 4a 3a 3b f8       	call   0xf83b3a5b
  11:	4c 89 64 24 28       	mov    %r12,0x28(%rsp)
  16:	bd a8 02 00 00       	mov    $0x2a8,%ebp
  1b:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
  20:	48 03 2b             	add    (%rbx),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 22 3a 3b f8       	call   0xf83b3a5b
  39:	45 31 e4             	xor    %r12d,%r12d
  3c:	48                   	rex.W
  3d:	83                   	.byte 0x83
  3e:	7d 00                	jge    0x40


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

