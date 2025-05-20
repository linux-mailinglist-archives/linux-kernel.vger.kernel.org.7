Return-Path: <linux-kernel+bounces-655629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857AABD8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBE61636B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648812B63;
	Tue, 20 May 2025 13:09:37 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F122D4DE
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746577; cv=none; b=PZltGnYqcz6pwLPmf1csT1N5G2IK5ifnRdEoSwzNKW1nA7z7BzFOcG7GbmeXXZaz0Zc1uZQiVM6B2C+lSLUHP0s9dG4IsUl0ulC5uNar26kBSbZuvpZPCzevYnLXwRnBXHnqLYRNL+E2WyoLchwm83mCHvUeBolOe0gmkVkMQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746577; c=relaxed/simple;
	bh=yE2VMoyKDDvN1vIvHAeKgmt3IL1qfs8+Ctmhtbp1xwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aoiX73StxtKjEGuWyUHGzVD2NZa3J0duNAEXa/1GVBPaAGC/N3j6q6lZDfIysRv6Opj7WXjC9joaw7+8P/jfRYoL4KL4zMJQwo9/SPUBMgmMWsk5Z0vVQRGdYTfeLXWhZ0CH/G7vZrfUROkRLEah1ZvVemah4pms3yvLynnXlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85b3888569bso529096339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 06:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746574; x=1748351374;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk05nQ0iOxmI8cXODP6xrixhTxgB12ZNkFvEosrJEiM=;
        b=KV77Kz616HgGLPlwF+EkVngwSRJnVEAtnlfw0iwa9zP3lENoQbsJeLyG/P0Pdc3Fth
         E6hCdQpZSg1Y4lbj75TOyHg7P7z3sJMZzw/3QVoVM5pFvHLoPRTOjH96/57rzMIXAnBV
         zNgBcV8EidAw36Fdg7OIJ1h14KGqMuuKBbmcQjoac1Wk2jg9VH/SkXjIU3u2umixTawB
         4VhzSuEzozDS/m/m8s3yTDEw86ktrXOTsOWoHmdXVIYHsX0kk1AjR++zDlG8s1K6rOPF
         cvbxJGsBoc/dTJc6T+wCKKP14VDwu4oZeENASneKD8LMTUOxRzA8496bHG6k/2VVORCq
         i8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4DytXNymzUTKgUWHSQNWssaWuvgH+76ptPyyShNeFxGjIhVYjqwnitOzMoOzD8I8qtc0qMOkw56YK6FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+WiYCdQ5TKzK3w1vytVOeA04fYQF7sez0XutQ2AzGSj0SvtY
	BfB7/8c8xXAhsNJSqVKexCJWoyyFXeyfOgZUcM0LQmCLPfm53l0QueBMnVmsYan72Jer6bcy1Ss
	s8sWkmblmJqRBINZCXhDZbHp9d/kAr1jh6rHJvsPxa9ygTgp1DmDzv1Vn83s=
X-Google-Smtp-Source: AGHT+IGZzEJRQn8wLrC+XkULIfOuIAK97foravFuUt8WHkY2mASB4wC8DBWA6k7SGZkeGocaA1sZ8yJ025SJAgbLcIM4KFhDNpBo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a81:b0:867:973:f2cb with SMTP id
 ca18e2360f4ac-86a23840913mr2338605039f.7.1747746573879; Tue, 20 May 2025
 06:09:33 -0700 (PDT)
Date: Tue, 20 May 2025 06:09:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682c7f0d.a00a0220.29bc26.027d.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in team_change_rx_flags
From: syzbot <syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jiri@resnulli.us, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    239af1970bcb llc: fix data loss when reading from a socket..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1485bf68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3f0e807ec5d1268
dashboard link: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1285bf68580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f752d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da0ff1b4efb0/disk-239af197.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be3cf5250e1a/vmlinux-239af197.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19abc9680c68/bzImage-239af197.xz

The issue was bisected to:

commit 6b1d3c5f675cc794a015138b115afff172fb4c58
Author: Stanislav Fomichev <stfomichev@gmail.com>
Date:   Wed May 14 22:03:19 2025 +0000

    team: grab team lock during team_change_rx_flags

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1148de70580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1348de70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1548de70580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Fixes: 6b1d3c5f675c ("team: grab team lock during team_change_rx_flags")

team0: entered promiscuous mode
team_slave_0: entered promiscuous mode
team_slave_1: entered promiscuous mode
team0 (unregistering): left promiscuous mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5831, name: syz-executor316
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syz-executor316/5831:
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: packet_notifier+0x78/0xa60 net/packet/af_packet.c:4240
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor316 Not tainted 6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8818
 __mutex_lock_common kernel/locking/mutex.c:578 [inline]
 __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 packet_dev_mc net/packet/af_packet.c:3698 [inline]
 packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
 packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
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
RIP: 0033:0x7fa537a5c859
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93fbcb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa537a5c859
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fa537aaa47d R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa537aaa3e5
R13: 0000000000000001 R14: 00007fff93fbcbd0 R15: 0000000000000003
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 Tainted: G        W          
-----------------------------
syz-executor316/5831 is trying to lock:
ffff888076094e00 (team->team_lock_key){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
other info that might help us debug this:
context-{5:5}
2 locks held by syz-executor316/5831:
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: packet_notifier+0x78/0xa60 net/packet/af_packet.c:4240
stack backtrace:
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor316 Tainted: G        W           6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 PREEMPT(full) 
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
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 packet_dev_mc net/packet/af_packet.c:3698 [inline]
 packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
 packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
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
RIP: 0033:0x7fa537a5c859
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93fbcb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa537a5c859
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fa537aaa47d R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa537aaa3e5
R13: 0000000000000001 R14: 00007fff93fbcbd0 R15: 0000000000000003
 </TASK>
team_slave_0: left promiscuous mode
team_slave_1: left promiscuous mode
team0 (unregistering): Port device team_slave_0 removed
team0 (unregistering): Port device team_slave_1 removed


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

