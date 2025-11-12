Return-Path: <linux-kernel+bounces-896448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75CC50679
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2118907D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3B2C11E3;
	Wed, 12 Nov 2025 03:10:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EA199949
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762917028; cv=none; b=JH+l0msJrNmK1AXnpCtxF49qBu30pkDtER73CHC/VZ/+gPz65Hgs8w+h6bxnQrWitxtxKJSejJL/5kvc1Cbna/+24OlKl2XgBI2QPn1TKchRU6VNmeZmVPEqpTqoZqa0BaftIR+TsngntahVRclY6tWY0gNtv8raGuDv9IbFmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762917028; c=relaxed/simple;
	bh=1yBLDoLbOxSqxMKiLLyN4rs0mPZQi6wLwhmELiRzjEo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nvSGQ5zs/n0paeRm+VpZE5Z60o8/WI+czxj7JjRyBrjpMDG6TyoaX2WE9N8pLghjr2ltHBfA36OuIZhTSeB4Ljf2l2T55Cqw7/sRE81iKbOWDmKzUIdzqIjwS0LdL0z9/IpIZ5WUgKEtWGsjKfq8AWF+qmNTyWTII1h2YRN5SlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4337853ffbbso4284195ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762917025; x=1763521825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUqq4AabEh8zfoeiLurbE+wJEq0d0QUbzBApMQHVz/Y=;
        b=U7qjtnYzJOHdc9NWfJRSDKIAiWN4qGD7gdNUL1CrHho5k4/w+WXS+IvxOHrc2oCnx+
         z4s/zGRlHgPxLVH6JgKHMaqyGGxxpeUqi3BKotPzBYqnZMht+8FPpJx89rReZ4BpyYty
         JYmmy1NFkD4CaJAk+GaCw32adiKG/VoBDaTZoGCuYmzod5qWI9VE8uXSc3rUiix1ej5V
         iSXBmA3dr62YOse/lRY7cU6wU98UGEKwxgVNBwBy1v5qs3MqXTOCT/FoH/xLE8aDTpp1
         7lnhtzxtj83pZ8KZiJPM8WCV6pb9o19CVHLhB+Hbe7ylhbIQKH8U+WlJYXLO32CJt7WG
         IErg==
X-Gm-Message-State: AOJu0YzYwvAmhUjc3CLeYukeP9OgPY+/4aGnhb15Zg874fwuZ+olRdEf
	Xc+8DY5BOCFmx+YiRs5NeXSW1B8TcuvRktCRnvO8takLztLvvREKZEtUWZlNu3QQi8vn5IXEzjq
	j2TdlDAGLNg9GrpQeZ4DeKswI1gbvd31Bm/eLN79k5/w2oUd16wzDTy+kOmq1ow==
X-Google-Smtp-Source: AGHT+IFOoAlmaJ5xNDMG8C+QpxdQExOQnntaGkksKXeqFu7xftwACyE0J4tGnCAQW1JJUr93UuD579T7jWRaQ/V/G9ZS0E5QXirR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fea:b0:433:308c:19a6 with SMTP id
 e9e14a558f8ab-43473d3db8emr21426875ab.12.1762917025569; Tue, 11 Nov 2025
 19:10:25 -0800 (PST)
Date: Tue, 11 Nov 2025 19:10:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913faa1.050a0220.417c2.0002.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in delayed_free_pidns
From: syzbot <syzbot+6e23cdc6afc8366bbc9b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159bea58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2ebeee52bf052b8
dashboard link: https://syzkaller.appspot.com/bug?extid=6e23cdc6afc8366bbc9b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32b5c04a0baa/disk-9c0826a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9438206c142a/vmlinux-9c0826a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/129cd0208baa/bzImage-9c0826a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e23cdc6afc8366bbc9b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_common.h:255 [inline], CPU#1: syz-executor/6195
WARNING: ./include/linux/ns_common.h:255 at put_user_ns include/linux/user_namespace.h:189 [inline], CPU#1: syz-executor/6195
WARNING: ./include/linux/ns_common.h:255 at delayed_free_pidns+0x118/0x150 kernel/pid_namespace.c:145, CPU#1: syz-executor/6195
Modules linked in:
CPU: 1 UID: 0 PID: 6195 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_user_ns include/linux/user_namespace.h:189 [inline]
RIP: 0010:delayed_free_pidns+0x118/0x150 kernel/pid_namespace.c:145
Code: 85 ed 7e 2b e8 99 9f 03 00 48 83 c3 a8 48 8b 3d 5e be c7 17 48 89 de 5b 41 5c 41 5e 41 5f 5d e9 1e 1e 5f 00 e8 79 9f 03 00 90 <0f> 0b 90 eb b4 e8 6e 9f 03 00 4c 89 ff be 03 00 00 00 e8 01 fb d2
RSP: 0018:ffffc90000a08c50 EFLAGS: 00010246
RAX: ffffffff81bde0b7 RBX: ffff888027774868 RCX: ffff88802a460000
RDX: 0000000000000100 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffff888057190193 R09: 1ffff1100ae32032
R10: dffffc0000000000 R11: ffffed100ae32033 R12: dffffc0000000000
R13: ffffffff81a903d7 R14: ffff888057190000 R15: ffff888057190190
FS:  000055556a83f500(0000) GS:ffff888125fc2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555576bfc648 CR3: 0000000076f08000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 3a810b1eb6134bdc DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:626
 do_softirq+0xec/0x180 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1013 [inline]
 nsim_fib_event_nb+0xd71/0x1080 drivers/net/netdevsim/fib.c:1043
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:35
 call_fib_entry_notifiers+0x14b/0x1f0 net/ipv4/fib_trie.c:107
 fib_table_insert+0xcc1/0x1b80 net/ipv4/fib_trie.c:1370
 fib_magic+0x2c4/0x390 net/ipv4/fib_frontend.c:1134
 fib_add_ifaddr+0x144/0x5f0 net/ipv4/fib_frontend.c:1156
 fib_inetaddr_event+0x12e/0x190 net/ipv4/fib_frontend.c:1470
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
 __inet_insert_ifa+0xa13/0xbf0 net/ipv4/devinet.c:566
 inet_rtm_newaddr+0xf3a/0x18b0 net/ipv4/devinet.c:1001
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:746
 __sys_sendto+0x3bd/0x520 net/socket.c:2248
 __do_sys_sendto net/socket.c:2255 [inline]
 __se_sys_sendto net/socket.c:2251 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2251
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f88b319155c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffdba054b40 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f88b3f14620 RCX: 00007f88b319155c
RDX: 0000000000000028 RSI: 00007f88b3f14670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdba054b94 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f88b3f14670 R15: 0000000000000000
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

