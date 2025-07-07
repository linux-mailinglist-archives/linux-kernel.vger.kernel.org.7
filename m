Return-Path: <linux-kernel+bounces-719154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE311AFAA7D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 06:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAA51898AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C825A340;
	Mon,  7 Jul 2025 04:05:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F17155A25
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751861130; cv=none; b=Zt9C6mozEgAuVMzn6rutfdujpxGsbcP/W4y7npnuO48wDmExnAFMOSE9tHK7zPTbDSXbVIKXDZgPluQ0wMZXyIOI4W18sCPmiAftZDjAFQ3VU8He7WcmEFWPFYeRXGSBv88IYpX8Qguv+a0zq+RuZbw0HDW3m7SANixLBDIqxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751861130; c=relaxed/simple;
	bh=rjveDWq8KK4qBmmxeeVFa/DZwtPwsbJHz/rfwsr2Czc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wa1kuR3PvE1mUs5UniI7wTvnVyfoOVT75wNsTrMmyu4t+VFSGUECOfEvtnAkC9tQfGR1YZ/Kpj2I4K5FyI7cYf6p5Pj2K7XD1BNmDHDHp9pqDM35F0p8KnzolqqccWcCaJPwL7eDQKESn2gd+EPL7l/6qqXe69chPOF6v7q9n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso78942465ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jul 2025 21:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751861128; x=1752465928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9b8S7StRcDEyA/i2VOLC6sUORM9/5D6WMK6E3dsUzFI=;
        b=MT5k7mY4J5vd9uOt2Kv4egAZ0oJ28ArkFqqkkK3qUR89V2cRevkC6sCieC6B33uq9I
         HDYD0pthAv2U3VKHBmX70oSJ2RM/9RDIiHRuPXoF2C6/uxNFTyuCNJ92Ec9zkd2+y5Lx
         ZawHU1OUacAUH9QgeKsJsj4wzG2QL54NAzmyfU+L2JQDiJ9589V9GNe/kQ3yW9elyyeO
         8ypQ1i4ohF120zUws3kPQKvp7aYmhdczbkQcu6s5PSM5Crt8qwpHW0JoBl+xjLOMXEse
         eTzL66xIzGYY6ggj9weH3HX3WwAIMOldrY+RjmJDnaze2kLly+dqhuPBsz4QN4AGEfHh
         Mm3A==
X-Forwarded-Encrypted: i=1; AJvYcCXzaV8FWfrXm4jlAq61tx90qBWo+FJTLJfBSwrvGsOHQgmyT1td7n8rbCcF2IAfCQMGVApjWBWaWplkl1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccYlV49r+K31vq7eFeAhaCpeh33ZsbI2bq7hQsfTM0EQ0DvXr
	bh11i6UnsRJDyUH7I2XpVR15L2VF72FqbxOQ/i9pMzbvwb/3BE31ixG+akicEUY/ClPRYHrYHLH
	x1u5Mm/X7WGiBqE9AXtKdGbhf/9wLRWq9XwINXEiEscV6XIBFO2BC+XFJpZE=
X-Google-Smtp-Source: AGHT+IG/n50KMMd7az6lAoy7v0ro9etKvox8cULsC7KPL4nLbBKmaieAK/iV2hmGn1xFGJLotJ0po1+l5bZuJYEmxxAuysonM2H6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318c:b0:3dd:f3e1:2899 with SMTP id
 e9e14a558f8ab-3e13ee85590mr79215175ab.2.1751861127927; Sun, 06 Jul 2025
 21:05:27 -0700 (PDT)
Date: Sun, 06 Jul 2025 21:05:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686b4787.a00a0220.c7b3.0073.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_alloc_anno_list
From: syzbot <syzbot+c6fca020ebd279c7412a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8b98f34ce1d8 net: ipv6: Fix spelling mistake
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d2b770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efe4e8ed5014b310
dashboard link: https://syzkaller.appspot.com/bug?extid=c6fca020ebd279c7412a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad0c8f9a1a48/disk-8b98f34c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a8aacec88f6/vmlinux-8b98f34c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a86c0c1690c/bzImage-8b98f34c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6fca020ebd279c7412a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7141 at net/mptcp/pm.c:353 mptcp_pm_alloc_anno_list+0x329/0x390 net/mptcp/pm.c:353
Modules linked in:
CPU: 0 UID: 0 PID: 7141 Comm: syz.3.339 Not tainted 6.16.0-rc3-syzkaller-00985-g8b98f34ce1d8 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:mptcp_pm_alloc_anno_list+0x329/0x390 net/mptcp/pm.c:353
Code: b0 01 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 8c 26 15 00 cc e8 56 b2 6a f6 90 0f 0b 90 e9 8b fd ff ff e8 48 b2 6a f6 90 <0f> 0b 90 31 c0 eb d1 48 c7 c1 30 69 a1 8f 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000b5a6db8 EFLAGS: 00010287
RAX: ffffffff8b559c28 RBX: ffff88807a3f9700 RCX: 0000000000080000
RDX: ffffc9000cbdd000 RSI: 000000000000318f RDI: 0000000000003190
RBP: 0000000000000000 R08: 00000000000a0002 R09: 0000000000000000
R10: 0000000000000000 R11: aa1414acffff0000 R12: ffff88814632f000
R13: ffff88807d852040 R14: dffffc0000000000 R15: ffff88807a3fa181
FS:  00007fb6c8df66c0(0000) GS:ffff888125c48000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb6c8df4fb8 CR3: 00000000339a2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_pm_create_subflow_or_signal_addr+0x1448/0x1c30 net/mptcp/pm_kernel.c:318
 mptcp_nl_add_subflow_or_signal_addr net/mptcp/pm_kernel.c:760 [inline]
 mptcp_pm_nl_add_addr_doit+0xe66/0x1460 net/mptcp/pm_kernel.c:840
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
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
RIP: 0033:0x7fb6caf8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb6c8df6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb6cb1b5fa0 RCX: 00007fb6caf8e929
RDX: 0000000002000000 RSI: 0000200000000400 RDI: 000000000000000d
RBP: 00007fb6cb010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb6cb1b5fa0 R15: 00007ffe35e566e8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

