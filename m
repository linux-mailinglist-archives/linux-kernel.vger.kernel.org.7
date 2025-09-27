Return-Path: <linux-kernel+bounces-834844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC7BA5A15
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B18325129
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF64283FD4;
	Sat, 27 Sep 2025 07:12:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179491D435F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957125; cv=none; b=tZx9wQ1MuQ40jHcpWjzJJJjyaJ3kfXcrb7T4MX50k8KZXh1nbvjvMMCVHN0igMRzh57s1k/yeFhzikj6mEA/IWewOPh4PnvrPwNRfkNMJgl0rojxheDSCShmUzsBxM2Eh8ptfEatMM7hPTZ83JEgDxCX1dfNfEBEQNMGfUYP2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957125; c=relaxed/simple;
	bh=ZS3+1DF2uLKPAi+8gRntxB5sXhRUSka1/0BzJTU/uN0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=irnTcguBwRvy34pb+DzQjki30hyVpxH1OXdI1ACEYD03ZWHXrLZBr287nJz3HZZe4H/Xkaa0zYMdqQ2gLeRSRFLieTSNBOmKI3AWaDaihTwSwKlbWPV5JzlV88x/ght5cSt3PFgL7M15qtS6QR3eWVLOWjsmCoYg43sWfYRyYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-429278a11f7so1027335ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758957122; x=1759561922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7B7/tNZPBMMQyrBZeeepzzCmP6tN/DUphen4yRWyarE=;
        b=hf2/jL4Q3s4OiJFqu/qVLdOgoTJHeJfrgGYN5G2VhqM+eg2GpXgpko6Nz9B0wkyv9G
         h1jWyC6k0ZHJ0kdh42+NNP78MUS98NcJEMUtrgS9gPjnJ/YtCD5V0UGxetBg+HYZowRp
         W14LZ8JH5WHzlEARrjDbCS0npsNVm//VX8Y4fNEhNw+mPxhk7mpRmq6p4H9BtFTz8Uud
         TYGUIwH0tgZwse8yFZuhGZCPiTx7uExAXi/1Fp0pddLBWEx4R+skSTmaXHnQECvOzWJe
         T6aWLudFlCU/daFtS7EMAcaZzSjIL0zwfyxhzteS/HZvYaK1gIoI+Bx8Exk6RfJ4cMwu
         fVLw==
X-Forwarded-Encrypted: i=1; AJvYcCUMF+BNx4vfdYNm08LbOpI8KZ67l2xC7BctF+5MwCcWn+JSKd2xg2Hfyn3JS842MEIkMwXYhQMDgRwT7us=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZaZQFlIiP/eBfO5wxq0sTf0U+3lRuUyTmFSBKBX0xCr0A3rF
	RHpgKWTj2Bl8ED573oZ3DILxPN5VUZ3eMiIjuYb2XR2LarEBOSnQj6BkS4ngH0y2AjK+ZBaqpIj
	zmxQO80ckg7N1pJi3Pwk125hzASrPCgjE1DXoffaNGNuit2+hllQFNmHoq/s=
X-Google-Smtp-Source: AGHT+IEfw+9aRZ17Baa4/NmONzCzWUcXnD0D0BdLxw9gC3uuR8Eiz1G1jpVtkg6T0lsEGriJeWPIZvcv5ASxx/UTjTh9d3jEuraf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:427:de6d:b6ed with SMTP id
 e9e14a558f8ab-427de6db7b3mr58362145ab.9.1758957122110; Sat, 27 Sep 2025
 00:12:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 00:12:02 -0700
In-Reply-To: <20250927065348.37852-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d78e42.a00a0220.102ee.000f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_seek_pagecache_hole (3)
From: syzbot <syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com>
To: =syzbot@syzkaller.appspotmail.com, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bch2_readahead

INFO: task syz.1.18:6662 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:17448 pid:6662  tgid:6661  ppid:6353   task_flags:0x440140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 __bch2_two_state_lock+0x1ea/0x370 fs/bcachefs/two_state_shared_lock.c:7
 bch2_two_state_lock fs/bcachefs/two_state_shared_lock.h:55 [inline]
 bch2_readahead+0x94f/0x1100 fs/bcachefs/fs-io-buffered.c:296
 read_pages+0x17a/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x63b/0x740 mm/readahead.c:297
 filemap_get_pages+0x443/0x1df0 mm/filemap.c:2603
 filemap_splice_read+0x587/0xc60 mm/filemap.c:2991
 do_splice_read fs/splice.c:982 [inline]
 splice_direct_to_actor+0x4b1/0xcd0 fs/splice.c:1086
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x187/0x270 fs/splice.c:1230
 vfs_copy_file_range+0xad7/0x1330 fs/read_write.c:1627
 __do_sys_copy_file_range fs/read_write.c:1677 [inline]
 __se_sys_copy_file_range+0x2fb/0x470 fs/read_write.c:1644
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1edf09eba9
RSP: 002b:00007f1ede706038 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
RAX: ffffffffffffffda RBX: 00007f1edf2e5fa0 RCX: 00007f1edf09eba9
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1edf121e19 R08: 0000000000000101 R09: 0000000000000000
R10: 00002000000000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1edf2e6038 R14: 00007f1edf2e5fa0 R15: 00007ffe266d1f08
 </TASK>
INFO: task syz.1.18:6705 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:21352 pid:6705  tgid:6661  ppid:6353   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b5/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1133 [inline]
 bch2_mark_pagecache_reserved+0x33d/0xbb0 fs/bcachefs/fs-io-pagecache.c:314
 __bchfs_fallocate+0x1447/0x1a40 fs/bcachefs/fs-io.c:739
 bchfs_fallocate+0x33f/0x680 fs/bcachefs/fs-io.c:795
 bch2_fallocate_dispatch+0x28d/0x410 fs/bcachefs/fs-io.c:842
 vfs_fallocate+0x672/0x7f0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1edf09eba9
RSP: 002b:00007f1ede6e5038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1edf2e6090 RCX: 00007f1edf09eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1edf121e19 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000001001ec R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1edf2e6128 R14: 00007f1edf2e6090 R15: 00007ffe266d1f08
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
 #0: ffff88814d3f5138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88814d3f5138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000127bc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000127bc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8ecd38b8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8ecd38b8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x119/0x15a0 net/ipv6/addrconf.c:4194
4 locks held by pr/legacy/17:
1 lock held by khungtaskd/38:
 #0: ffffffff8d9a8dc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d9a8dc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8d9a8dc0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
6 locks held by kworker/u8:8/1125:
 #0: ffff88806b921138 ((wq_completion)btree_update#86){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88806b921138 ((wq_completion)btree_update#86){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90004f97bc0 ((work_completion)(&c->btree_interior_update_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90004f97bc0 ((work_completion)(&c->btree_interior_update_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff888087204678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff888087204678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff888087204678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x7f3/0xd80 fs/bcachefs/btree_iter.c:3505
 #3: ffff888092b801b0 (bcachefs_btree){+.+.}-{0:0}, at: trans_set_locked fs/bcachefs/btree_locking.h:206 [inline]
 #3: ffff888092b801b0 (bcachefs_btree){+.+.}-{0:0}, at: bch2_trans_begin+0xbd8/0x2300 fs/bcachefs/btree_iter.c:3403
 #4: ffff88808726d068 (journal res){.+.+}-{0:0}, at: bch2_journal_res_get+0x6a9/0x8f0 fs/bcachefs/journal.h:406
 #5: ffff888087204d38 (&c->mark_lock){++++}-{0:0}, at: bch2_accounting_mem_insert+0x438/0xad0 fs/bcachefs/disk_accounting.c:407
4 locks held by kworker/u8:10/1163:
1 lock held by udevd/5207:
 #0: ffff888035b75218 (&ep->lock){++++}-{3:3}, at: write_lock_irq include/linux/rwlock_rt.h:104 [inline]
 #0: ffff888035b75218 (&ep->lock){++++}-{3:3}, at: ep_poll fs/eventpoll.c:2127 [inline]
 #0: ffff888035b75218 (&ep->lock){++++}-{3:3}, at: do_epoll_wait+0x84d/0xbb0 fs/eventpoll.c:2560
2 locks held by getty/5598:
 #0: ffff88823bf3a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e762e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1410 drivers/tty/n_tty.c:2222
3 locks held by udevd/6647:
1 lock held by syz.1.18/6662:
 #0: ffff888048f40b88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888048f40b88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
3 locks held by syz.1.18/6705:
 #0: ffff88805124c488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff88805124c488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888048f409b8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888048f409b8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff88805a804678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff88805a804678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff88805a804678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0xaf/0x220 fs/bcachefs/btree_iter.c:3299
7 locks held by udevd/6920:
3 locks held by syz.3.39/7150:
 #0: ffff888029276488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff888029276488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888048f46cb8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888048f46cb8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff888070304678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff888070304678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff888070304678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0xaf/0x220 fs/bcachefs/btree_iter.c:3299
1 lock held by syz.3.39/7153:
 #0: ffff888048f46e88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888048f46e88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
1 lock held by syz.2.43/7217:
 #0: ffff888048f42c88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888048f42c88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
3 locks held by syz.2.43/7266:
 #0: ffff888058224488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff888058224488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888048f42ab8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888048f42ab8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff88806fc04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff88806fc04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff88806fc04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0xaf/0x220 fs/bcachefs/btree_iter.c:3299
3 locks held by syz.0.47/7339:
 #0: ffff888030344488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff888030344488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888048f1c378 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888048f1c378 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff888070c04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff888070c04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff888070c04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x7f3/0xd80 fs/bcachefs/btree_iter.c:3505
1 lock held by syz.0.47/7340:
 #0: ffff888048f1c548 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888048f1c548 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
2 locks held by syz-executor/7412:
 #0: ffff888038c2a0d0 (&type->s_umount_key#54){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888038c2a0d0 (&type->s_umount_key#54){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888038c2a0d0 (&type->s_umount_key#54){++++}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:506
 #1: ffff888087200268 (&c->state_lock){+.+.}-{4:4}, at: __bch2_fs_stop+0xf8/0x900 fs/bcachefs/super.c:676
3 locks held by syz.4.63/7563:
 #0: ffff88802366a488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff88802366a488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888048f1ecb8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888048f1ecb8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff888087504678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff888087504678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff888087504678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0xaf/0x220 fs/bcachefs/btree_iter.c:3299
1 lock held by syz.4.63/7564:
 #0: ffff888048f1ee88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888048f1ee88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
3 locks held by syz.5.112/8299:
 #0: ffff888031282488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff888031282488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888049276478 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888049276478 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff8880a3c04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff8880a3c04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff8880a3c04678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x7f3/0xd80 fs/bcachefs/btree_iter.c:3505
1 lock held by syz.5.112/8302:
 #0: ffff888049276648 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888049276648 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
3 locks held by syz.6.119/8401:
 #0: ffff888079bc0488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff888079bc0488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff888048f1a278 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff888048f1a278 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff8880b2604678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff8880b2604678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff8880b2604678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x7f3/0xd80 fs/bcachefs/btree_iter.c:3505
1 lock held by syz.6.119/8402:
 #0: ffff888048f1a448 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff888048f1a448 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
3 locks held by syz.8.121/8421:
 #0: ffff88803d79e488 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3108 [inline]
 #0: ffff88803d79e488 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f9/0x7f0 fs/open.c:341
 #1: ffff88808e622ab8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff88808e622ab8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: bch2_fallocate_dispatch+0x111/0x410 fs/bcachefs/fs-io.c:833
 #2: ffff88809e104678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #2: ffff88809e104678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #2: ffff88809e104678 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0xaf/0x220 fs/bcachefs/btree_iter.c:3299
1 lock held by syz.8.121/8422:
 #0: ffff88808e622c88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #0: ffff88808e622c88 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0xf4/0x740 mm/readahead.c:228
1 lock held by syz-executor/8442:
 #0: ffffffff8ecd38b8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8ecd38b8 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x5b7/0xd20 net/ipv6/addrconf.c:5027
1 lock held by syz-executor/8511:
 #0: ffffffff8ecd38b8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8ecd38b8 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x5b7/0xd20 net/ipv6/addrconf.c:5027
2 locks held by syz-executor/8557:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 17 Comm: pr/legacy Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:400
Code: e8 0e 31 7f fc 44 89 f9 d3 e3 49 83 ee 80 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 9f 77 de fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f c3 cc cc cc cc cc 44 89 f9 80 e1 07
RSP: 0018:ffffc90000167890 EFLAGS: 00000202
RAX: 1ffffffff3275e00 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff993af890 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff853f3a60 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff993af600 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881269bb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8787af9000 CR3: 000000008cbbc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1aa/0x2f0 drivers/tty/serial/8250/8250_port.c:1984
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3288 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3311 [inline]
 serial8250_console_write+0x11bd/0x1b40 drivers/tty/serial/8250/8250_port.c:3396
 console_emit_next_record kernel/printk/printk.c:3118 [inline]
 console_flush_all+0x698/0xcd0 kernel/printk/printk.c:3226
 __console_flush_and_unlock+0xa4/0x240 kernel/printk/printk.c:3285
 legacy_kthread_func+0x13b/0x1a0 kernel/printk/printk.c:3638
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15493d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161d3142580000


