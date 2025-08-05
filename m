Return-Path: <linux-kernel+bounces-755859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87554B1AC97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 05:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA21800DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6F78F2E;
	Tue,  5 Aug 2025 03:02:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B7EACE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754362927; cv=none; b=ePmScQERP2dzkJH88V7+nX49eWOUqeLHaylfbu3KrE/eDfto9fR5dkIcSzUxRPm9j8IK+MSF1hhnimay1/ylvdnmxGykfD0JfGOn0BFWAk+NEoNmVancmafJZNXx2COcPRlKBvzGXT94LWFV5QfEueU+fLgTT6W6N+SnaCYfjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754362927; c=relaxed/simple;
	bh=8yANoLAFam5mWIzCaU4l1vZ+pYLD486doLVLLlpizYU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G88GH25/joB/4jEBxxna8WXj4EjTMm1pVdVtaIS5UYM1ezWXYHsEt2bizbmn51HfB3swU9W7RsQ5fjlp02DKEZV1FV9eYl74kiXuTtcPgsiC18jlyZlvdcBKXcrfYbKz7EKDtIn0hFUhPb2iY84HfVLNhETIPrUkmSy88A2AlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e40058db50so50105185ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 20:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754362924; x=1754967724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8X0AKsHLCxhaz1sF5vyqSNJVobGZ9fFxtjodMTSTws=;
        b=OxeWZoXEOEOFzjBt3ZFOF+Cq5VUCTiNaE+aTvJQr+A2nvfL5n4Zo7hpsAitsUI2oTG
         uOSsm7Z+ujQDd5M31YgKY4Ww31G5NraHXCysShsYjnqcRaGOU2tD6Em79QIpCX9v0n5x
         lNI4zVnbQ/twW+JFQLUdATBpnvq0+G2eUwq5fYQOqTlFrtDCGKuF5dhBjjv8IacppGAu
         EaDjkqhNIQbezVsw5dhYtax1+UE/m2A8mUN+AKehVG7Zo3p69MUvjoKIPOVPC8QOQ2cp
         /wBeUrdLKmkuk7wpaDeQheMCi5Q7B0fY6id79gojLJqXXqjlEGpvz6emVGO1IViJyaIl
         hmaA==
X-Forwarded-Encrypted: i=1; AJvYcCUiSDeL19P/5fs10S173cp45qoOPx404w/+9zid4Ril1egycZQSnHKpqnQDS2UGZHEACUJUYOLIgd4Fjzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TA36fK3kutQsLNtD63GspNttf+7rfC8Hf6DRMXxtWed2lOjx
	nUtRGbuqqOd8+5Bl/zTk4vKwlQ8gAL99fpDgq8F/k2tsPWhaWEZGy6qDy31CAYLVtsEhE2ctWy3
	yv1sxD2QSplWpg+3Y2RM6BASAYOcdHjzc/2l9S70l8eF4vMqXSM6VeGqCCSQ=
X-Google-Smtp-Source: AGHT+IHmJmKQJv6nJ22qRx0TXRV7Gu4zuKnb+2wHKnrV8Lxx+ELq4d9cuzUU7/SBvjZnOONM4rdliX1RHwyLfKFSIUPoA2RGJ24h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2707:b0:3e3:f9fa:2c8b with SMTP id
 e9e14a558f8ab-3e41610837bmr195095725ab.8.1754362924680; Mon, 04 Aug 2025
 20:02:04 -0700 (PDT)
Date: Mon, 04 Aug 2025 20:02:04 -0700
In-Reply-To: <20250805022753.3917-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6891742c.050a0220.7f033.001a.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
From: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in kernfs_remove

======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-g7e161a991ea7-dirty #0 Not tainted
------------------------------------------------------
syz.0.17/6594 is trying to acquire lock:
ffff88801b2ff988 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549

but task is already holding lock:
ffff88814371d8f8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4400 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4447
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1943
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2680
       do_one_initcall+0x233/0x820 init/main.c:1269
       do_initcall_level+0x104/0x190 init/main.c:1331
       do_initcalls+0x59/0xa0 init/main.c:1347
       kernel_init_freeable+0x334/0x4b0 init/main.c:1579
       kernel_init+0x1d/0x1d0 init/main.c:1469
       ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4248
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4131 [inline]
       slab_alloc_node mm/slub.c:4209 [inline]
       kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4248
       alloc_inode+0xb8/0x1b0 fs/inode.c:348
       iget_locked+0xf0/0x570 fs/inode.c:1438
       kernfs_get_inode+0x4f/0x780 fs/kernfs/inode.c:253
       kernfs_iop_lookup+0x1f6/0x320 fs/kernfs/dir.c:1236
       __lookup_slow+0x297/0x3d0 fs/namei.c:1808
       lookup_slow+0x53/0x70 fs/namei.c:1825
       walk_component fs/namei.c:2129 [inline]
       link_path_walk+0x935/0xea0 fs/namei.c:2497
       path_lookupat+0x97/0x430 fs/namei.c:2653
       filename_lookup+0x212/0x570 fs/namei.c:2683
       user_path_at+0x3a/0x60 fs/namei.c:3127
       do_mount fs/namespace.c:4130 [inline]
       __do_sys_mount fs/namespace.c:4344 [inline]
       __se_sys_mount+0x2d3/0x410 fs/namespace.c:4321
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549
       __kobject_del+0xe1/0x300 lib/kobject.c:604
       kobject_del+0x45/0x60 lib/kobject.c:627
       elv_unregister_queue block/elevator.c:502 [inline]
       elevator_change_done+0xf2/0x470 block/elevator.c:643
       elevator_set_none+0x42/0xb0 block/elevator.c:757
       blk_mq_elv_switch_none block/blk-mq.c:5022 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5063 [inline]
       blk_mq_update_nr_hw_queues+0x68f/0x1890 block/blk-mq.c:5113
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2228
       genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
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

other info that might help us debug this:

Chain exists of:
  &root->kernfs_rwsem --> fs_reclaim --> &q->q_usage_counter(io)#49

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#49);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#49);
  lock(&root->kernfs_rwsem);

 *** DEADLOCK ***

6 locks held by syz.0.17/6594:
 #0: ffffffff8f5836f0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f583508 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f583508 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f583508 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 #2: ffff8881437d8988 (&set->update_nr_hwq_lock){++++}-{4:4}, at: blk_mq_update_nr_hw_queues+0xa6/0x1890 block/blk-mq.c:5111
 #3: ffff8881437d88d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xb9/0x1890 block/blk-mq.c:5112
 #4: ffff88814371d8f8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
 #5: ffff88814371d930 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478

stack backtrace:
CPU: 1 UID: 0 PID: 6594 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-g7e161a991ea7-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549
 __kobject_del+0xe1/0x300 lib/kobject.c:604
 kobject_del+0x45/0x60 lib/kobject.c:627
 elv_unregister_queue block/elevator.c:502 [inline]
 elevator_change_done+0xf2/0x470 block/elevator.c:643
 elevator_set_none+0x42/0xb0 block/elevator.c:757
 blk_mq_elv_switch_none block/blk-mq.c:5022 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:5063 [inline]
 blk_mq_update_nr_hw_queues+0x68f/0x1890 block/blk-mq.c:5113
 nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
 nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2228
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
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
RIP: 0033:0x7ff1bbb8eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff1bc9f8038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff1bbdb5fa0 RCX: 00007ff1bbb8eb69
RDX: 0000000020000000 RSI: 0000200000001ac0 RDI: 0000000000000004
RBP: 00007ff1bbc11df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff1bbdb5fa0 R15: 00007fffc10118f8
 </TASK>
nbd0: detected capacity change from 0 to 127


Tested on:

commit:         7e161a99 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe06a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b1651a67dd046ce
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122942f0580000


