Return-Path: <linux-kernel+bounces-759173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD8B1D994
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D50A3A5470
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC325A321;
	Thu,  7 Aug 2025 14:02:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CA198851
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575326; cv=none; b=qvHGPIAP4fFFBO+meLF8GNCbhLq3CZv+xDE6cDwms9Q5sFH9Su/G24SJE2CGsHapubDupxpUqN4rYj/mmm8xD16vSxWZofGcWlZwJUxvpyjGWRcy2pewYhHy/67WE4bjLHR4CExtaalqtIQHV8iT1RSVw1BcsHDbJBHGAN5ZYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575326; c=relaxed/simple;
	bh=vvxPnGbg9Fz8nzhdYB9Ic7+pZyzetO7zhz+JIIukGSo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y3ElV14hyqIFx1FgJ5HiTy/ma1IG2Aaks2EQMM1F9vL0QbQfhU+yPH2LBb9naEACNkWuxF5YajIYbrgsI7G1ZbHl3RQPUNhMobzsaWbDCRrDn52q1BdQoVWLDFPpNJsqaOZjN1jQv8ZA2ETjtzIKyPYcyXj0oUKFzidr0cr+RVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88170a3e085so101409839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754575323; x=1755180123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9ygDYw9yZW04feh7lRBSHiulDx8jc0GOGVn6BkmyZQ=;
        b=Tasyu3Az2SBNxEUAD4WzRppuNTQ7slQ0tbZ6+LS4824oJsHgA5zwaFHGkp1oOU23FO
         bN+zZRjdmTUDsV66OqS7CX/j1maoxSmyXZsBZqgKTkAzSfiH8PTVBiIKVlGnEoh/EOID
         qhUfuirz1EKj8nQCtlcmu00fYkjh+Pc5lf38xOh82Y13hEF8ts7edsv5ISTS4kPiiuG7
         41SznnjsmNdh6G4Rg32kcDeU/eDnVc99UgwwFyK9dFodzcwaTa+/6TLTVM71p2n8Iarq
         c4L9YN/lw1FqBVdWrH0sSSmMxFqHWTOHrE5fmxSSNf34PB8+43Wmu/ThQob7lmfsYbJc
         ILSw==
X-Forwarded-Encrypted: i=1; AJvYcCW9q4uSoVhK7Erj54g/XIrhJMwlO+JXrNDfkHRtNPsVQV+bvLUEFTdAZvUsN0zf6/DzbiXPUE/jtCJHfSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfR7/I5qGaKdoo2igIcc8T/jyhNO5eHxRBKHBOjf5Cb3FHnFLb
	wZTefyoVraHaVno26lurzTyr+3ZwDNfFchsJ6zmVydTX8vr01GWDpRnFblY+rY5a5mEVo/LbcTM
	1QsiGq1NOet/OsofAhfaLAZRux7kAQ32wAfHydOY2BaeMSQP0w3Zs+smjSmw=
X-Google-Smtp-Source: AGHT+IG8RuOgmswp6z6pMjsaq/gqED3RkfW27nEHC5YoeEye7pu5R4iVSuR6OcROCv2WsKeO0kLL7o/nMWD40YTBZOgv4zFnVEJ+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c86:b0:87c:1cc3:c0fa with SMTP id
 ca18e2360f4ac-8819f1a2e28mr1327517939f.0.1754575322917; Thu, 07 Aug 2025
 07:02:02 -0700 (PDT)
Date: Thu, 07 Aug 2025 07:02:02 -0700
In-Reply-To: <tencent_46A42583BA68BB6233C69EF11B674B7C1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6894b1da.050a0220.7f033.0047.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
From: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in kernfs_remove

======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-06619-gd942fe13f72b-dirty #0 Not tainted
------------------------------------------------------
syz.0.17/6667 is trying to acquire lock:
ffff88801b2ff188 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549

but task is already holding lock:
ffff888025244558 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478

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
       kernel_init_freeable+0x334/0x4a0 init/main.c:1579
       kernel_init+0x1d/0x1d0 init/main.c:1469
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4045 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4059
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4099 [inline]
       slab_alloc_node mm/slub.c:4177 [inline]
       kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4216
       alloc_inode+0xb8/0x1b0 fs/inode.c:348
       iget_locked+0xf0/0x570 fs/inode.c:1438
       kernfs_get_inode+0x4f/0x780 fs/kernfs/inode.c:253
       kernfs_fill_super fs/kernfs/mount.c:307 [inline]
       kernfs_get_tree+0x5a9/0x920 fs/kernfs/mount.c:391
       sysfs_get_tree+0x46/0x110 fs/sysfs/mount.c:31
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
       do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
       do_mount fs/namespace.c:4133 [inline]
       __do_sys_mount fs/namespace.c:4344 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4321
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1575
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
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
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

6 locks held by syz.0.17/6667:
 #0: ffffffff8f56e570 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f56e388 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f56e388 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f56e388 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 #2: ffff888025355188 (&set->update_nr_hwq_lock){++++}-{4:4}, at: blk_mq_update_nr_hw_queues+0xa6/0x1890 block/blk-mq.c:5111
 #3: ffff8880253550d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xb9/0x1890 block/blk-mq.c:5112
 #4: ffff888025244558 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
 #5: ffff888025244590 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478

stack backtrace:
CPU: 0 UID: 0 PID: 6667 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-06619-gd942fe13f72b-dirty #0 PREEMPT(full) 
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
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1575
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
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
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
RIP: 0033:0x7fc5bbd8eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc5bcbae038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc5bbfb5fa0 RCX: 00007fc5bbd8eb69
RDX: 0000000020000000 RSI: 0000200000001ac0 RDI: 0000000000000004
RBP: 00007fc5bbe11df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc5bbfb5fa0 R15: 00007ffebf29b2c8
 </TASK>
nbd0: detected capacity change from 0 to 127


Tested on:

commit:         d942fe13 net: ti: icssg-prueth: Fix skb handling for X..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1585e2f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=484535f4eb25fe17
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123ecea2580000


