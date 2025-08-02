Return-Path: <linux-kernel+bounces-753950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D80B18A86
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794A97AA2C8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765118DF80;
	Sat,  2 Aug 2025 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="vvERVQmn"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FF185B67
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754103571; cv=none; b=BtRbiCTyGMdVxveBwJz3cx/VGawlxpMCrteB77w26T8LwTqlVVBAKKJXU7clpNNx2ltK2D55/wLNTXtqup4rkcllED2ujAcpYgETnBecjOsE55qNdwXUwLnOnkchRsk31V6R0XjXAsKDc+2o7GQbm2FqIFMDWhAX6MA7Nbzfjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754103571; c=relaxed/simple;
	bh=hQFSNUG7Mlc1PyowN/WACGYbNwCnZJ8ZppesueYXL7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlI54evj69NBRGAysrzQ7i6MOIqHCG7TjIlIZmh1ihXUT33bFNAedWz5U7hI4XhFOJz2QWW9OlJXO6GAqX32vIjoMBip7BO1zb5Bn+7xWb7IdVazz7USwB6kNNVyqMZnqVZJIygOCEOFHr7sLbkSDz7qGq9cZ3+rrfOPEmVH4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=vvERVQmn; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754103568;
	bh=UBbbSHDxSNopaB6c8TsMYzhCmRPCZHeIoj2AWcaNomM=;
	h=From:Subject:Date:Message-ID;
	b=vvERVQmnuk8zqOUqLsbPS4wSxvbWUVLjFTkMLGYmGrLlkX7dtO9OX3VlDhn+8ClTo
	 TkfGDdHGXiUWGK+ofIJjZNBG9Lxi9D+z4R7TZouzd9+5vrdqkkyevZprN+CU2sJvLr
	 8VIogzkUTuYxfh0yYg1ZX5EjcLgVaMJff28ttEHE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 688D7EE1000007BD; Sat, 2 Aug 2025 10:58:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4157166816222
X-SMAIL-UIID: D5674290A3F741FB8B2C2F109FB90ECC-20250802-105843-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+95069c82577357ff89d8@syzkaller.appspotmail.com>
Cc: Aleksandr Nogikh <nogikh@google.com>,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] upstream test error: BUG: sleeping function called from invalid context in kcov_remote_start
Date: Sat,  2 Aug 2025 10:58:30 +0800
Message-ID: <20250802025832.3683-1-hdanton@sina.com>
In-Reply-To: <688cf3e0.a00a0220.26d0e1.0074.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 01 Aug 2025 10:05:36 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    89748acdf226 Merge tag 'drm-next-2025-08-01' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164a9cf0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caba3b7d5edc3bd1
> dashboard link: https://syzkaller.appspot.com/bug?extid=95069c82577357ff89d8
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7d6418d10fb8/disk-89748acd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4608f748b818/vmlinux-89748acd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/92e2adcd74de/bzImage-89748acd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+95069c82577357ff89d8@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
> preempt_count: 0, expected: 0
> RCU nest depth: 2, expected: 2
> 7 locks held by ksoftirqd/1/30:
>  #0: ffffffff8d64a6a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
>  #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
>  #2: ffffffff8d7a8b00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #2: ffffffff8d7a8b00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #2: ffffffff8d7a8b00 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
>  #2: ffffffff8d7a8b00 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
>  #3: ffffffff8d7a8b00 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
>  #4: ffff88801989a138 ((wq_completion)events_bh){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
>  #4: ffff88801989a138 ((wq_completion)events_bh){+...}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
>  #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
>  #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
>  #6: ffff8880b8928b50 ((lock)#3){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  #6: ffff8880b8928b50 ((lock)#3){+.+.}-{3:3}, at: kcov_remote_start+0x92/0x460 kernel/kcov.c:865
> irq event stamp: 58091
> hardirqs last  enabled at (58090): [<ffffffff8af459c5>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (58090): [<ffffffff8af459c5>] _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
> hardirqs last disabled at (58091): [<ffffffff86a72b95>] kcov_remote_start_usb_softirq include/linux/kcov.h:88 [inline]
> hardirqs last disabled at (58091): [<ffffffff86a72b95>] __usb_hcd_giveback_urb+0x3f5/0x710 drivers/usb/core/hcd.c:1662
> softirqs last  enabled at (58074): [<ffffffff8184ff9e>] ksoftirqd_run_end kernel/softirq.c:282 [inline]
> softirqs last  enabled at (58074): [<ffffffff8184ff9e>] run_ksoftirqd+0xce/0x210 kernel/softirq.c:969
> softirqs last disabled at (58082): [<ffffffff818e7aff>] smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
> CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT_{RT,(full)} 

When was RT turned on in syzbot tests, and for what?

> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
>  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>  rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
>  spin_lock include/linux/spinlock_rt.h:44 [inline]
>  kcov_remote_start+0x92/0x460 kernel/kcov.c:865
>  kcov_remote_start_usb include/linux/kcov.h:55 [inline]
>  kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
>  __usb_hcd_giveback_urb+0x427/0x710 drivers/usb/core/hcd.c:1662
>  usb_giveback_urb_bh+0x296/0x420 drivers/usb/core/hcd.c:1697
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
>  bh_worker+0x2b1/0x600 kernel/workqueue.c:3579
>  tasklet_action+0xc/0x70 kernel/softirq.c:854
>  handle_softirqs+0x22f/0x710 kernel/softirq.c:579
>  run_ksoftirqd+0xac/0x210 kernel/softirq.c:968
>  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

