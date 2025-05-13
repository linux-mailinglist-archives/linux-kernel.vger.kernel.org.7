Return-Path: <linux-kernel+bounces-645233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC6AB4A98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 06:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2CC462CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 04:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68E1DED4C;
	Tue, 13 May 2025 04:37:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892061AF0CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111055; cv=none; b=qtNqRuc8vJHEY885yY0T3OsOdCqo6ly+WmZF1E+iYKoHPy6wU74+iNkDhLhLmezKfim/ZsriQ5KKs9Nsdh4pKFZDgC6rUp/kXkIRb9pTbZDy7Dv6lRg48dHy5X0GO9uacNH9rSrPz9jTsmiYpf0gno+d9F51SpsWO5JBf4ap/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111055; c=relaxed/simple;
	bh=QKhxlMJf9DwcDasJT9MxJxi2H37PpU+ef3sypRqtMlM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R9/8gjS3PE6T3qzosKlyb3uZX+8QyGRG4chGqZXLreNVNCU9Qn6R2SQgasMQdp3dSJv5+1zw5/U8mlErRxa4N7JFLLjOruvvKDY9yVg9zizRSHKpSWs1cVJm8yOlla3nHmDUq/6GxsK67OHlg7dZsg4ysAVbi0JduvpB8flcQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3da6f284ca5so109436225ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 21:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747111052; x=1747715852;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HerpZjjRvJPDZiVjyr+jH4mDrVVxRA8dJ6nQxvYN7yQ=;
        b=ZxIyULwxg491msrpog+8wqt7EQ1UpdbQK/czsE7IDt8xsrhMeqncNlWTwdN0mNr2x7
         BxtPfLyJAlBQmrSKd/Rg6NLcFuRFXgUxXF0CWIjIXDk9XGKUOmeyA8TzX8hmgqeD5RTq
         QwLp8pvg2cDuGYpCn09DfyKTfWToubhtCUoIo4WHxef6e+hx2gBsOA5zlOPFtphekDKY
         qqzBQyOxnAXWC6lpolRxyjt+G27+EuZlz++rxlY/OkLhiQsfY6KErXoUzXKrfka99uhJ
         MoKFDUtUwVN3lZBpRPfGrV99s3E8NfPEomS6JkZ019uczmJS1fKFcdfoLe28B6bAcJ/E
         rFXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0cvBv0XXBEnggviHL0UmNB0MXNHY5q2Q40DxdljRnhbPyqqmlfLAtnhZUxlXg+PkRl0bW8W3KQo4HkE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xtRpoirZXA+kqgTUP7v9qaSmfjMGlrGHiG2WNmTgFFvPcqAW
	lXIWEQ5qvKhW0nHsfbnNXU1eksltoRDyoWOExnLxn4Tz9HeDlPDTXS5Oh/4/IlB8qzRrYjlTR2L
	aqwlJpC4SsGIPxEMPbHpuVeqZqNr9TVsoD8TntuSQnLPjq6lhzqgbP7Y=
X-Google-Smtp-Source: AGHT+IF4tMY+pPPj6hdS7OW+dMmVK6vEG6jfSwPOLSBcQ3udOfnpkmA8nbX+dGOeGEv0p/v5mup1L6s21CbnZQZEymE3icvtBWWE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3d8:20f0:4006 with SMTP id
 e9e14a558f8ab-3da7e1e60a7mr156472475ab.4.1747111041909; Mon, 12 May 2025
 21:37:21 -0700 (PDT)
Date: Mon, 12 May 2025 21:37:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6822cc81.050a0220.f2294.00e8.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in dev_set_promiscuity
From: syzbot <syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82f2b0b97b36 Linux 6.15-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173c62f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4dff0626333635
dashboard link: https://syzkaller.appspot.com/bug?extid=53485086a41dbb43270a
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/900b6a747850/disk-82f2b0b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d41ddb74da5/vmlinux-82f2b0b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb555785f64f/bzImage-82f2b0b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com

team0 (unregistering): left promiscuous mode
team_slave_0: left promiscuous mode
team_slave_1: left promiscuous mode
bond0: left promiscuous mode
bond_slave_0: left promiscuous mode
bond_slave_1: left promiscuous mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 14644, name: syz.2.10383
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syz.2.10383/14644:
 #0: ffffffff8f2f6d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2f6d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f2f6d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
 #1: ffffffff8df3d860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3d860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3d860 (rcu_read_lock){....}-{1:3}, at: team_change_rx_flags+0x29/0x330 drivers/net/team/team_core.c:1781
CPU: 1 UID: 0 PID: 14644 Comm: syz.2.10383 Not tainted 6.15.0-rc6-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8818
 __mutex_lock_common kernel/locking/mutex.c:578 [inline]
 __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
 netdev_lock include/linux/netdevice.h:2751 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:285
 bond_set_promiscuity drivers/net/bonding/bond_main.c:922 [inline]
 bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4732
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 team_change_rx_flags+0x1b3/0x330 drivers/net/team/team_core.c:1785
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 hsr_del_port+0x25e/0x2d0 net/hsr/hsr_slave.c:233
 hsr_netdev_notify+0x827/0xb60 net/hsr/hsr_main.c:104
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11970
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a8538e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a8298f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8a855b6320 RCX: 00007f8a8538e969
RDX: 0000000000000000 RSI: 0000200000000200 RDI: 0000000000000008
RBP: 00007f8a85410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f8a855b6320 R15: 00007f8a856dfa28
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.15.0-rc6-syzkaller #0 Tainted: G        W          
-----------------------------
syz.2.10383/14644 is trying to lock:
ffff88805b68cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
ffff88805b68cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88805b68cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:285
other info that might help us debug this:
context-{5:5}
2 locks held by syz.2.10383/14644:
 #0: ffffffff8f2f6d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2f6d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f2f6d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
 #1: ffffffff8df3d860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3d860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3d860 (rcu_read_lock){....}-{1:3}, at: team_change_rx_flags+0x29/0x330 drivers/net/team/team_core.c:1781
stack backtrace:
CPU: 1 UID: 0 PID: 14644 Comm: syz.2.10383 Tainted: G        W           6.15.0-rc6-syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4831 [inline]
 check_wait_context kernel/locking/lockdep.c:4903 [inline]
 __lock_acquire+0xbcf/0xd20 kernel/locking/lockdep.c:5185
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
 netdev_lock include/linux/netdevice.h:2751 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:285
 bond_set_promiscuity drivers/net/bonding/bond_main.c:922 [inline]
 bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4732
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 team_change_rx_flags+0x1b3/0x330 drivers/net/team/team_core.c:1785
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 hsr_del_port+0x25e/0x2d0 net/hsr/hsr_slave.c:233
 hsr_netdev_notify+0x827/0xb60 net/hsr/hsr_main.c:104
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11970
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a8538e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a8298f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8a855b6320 RCX: 00007f8a8538e969
RDX: 0000000000000000 RSI: 0000200000000200 RDI: 0000000000000008
RBP: 00007f8a85410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f8a855b6320 R15: 00007f8a856dfa28
 </TASK>
netdevsim netdevsim2 netdevsim0: left promiscuous mode
team0 (unregistering): Port device team_slave_0 removed
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device bond0 removed


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

