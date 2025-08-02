Return-Path: <linux-kernel+bounces-754171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF0B18F41
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EAFAA16CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286E237172;
	Sat,  2 Aug 2025 15:45:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8222B8A5
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754149505; cv=none; b=f5yrpTkNPizq/fsXXYQ3a3MrY0PgDM9TvRrKywDbPnCvHvsjWOx3X8HM0BCSrlaPvkA5jwXpg4KZtani7VBfkpWDJArKWEcjAEhXlFFXylNTzl5PZL390l7t/WtUJUpAC/MSHSYCnccPaS3HZHkMEftpqVAh0vk1TG2BYT/P/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754149505; c=relaxed/simple;
	bh=McKpaqsKHNvRe+ENShlhyw6dN6q5xb0xU0qSqA7SWwM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pwfSmzvtcUjh9T1m6P4v/T0ETxsJ78b2lw6aWAi1UKBhHVX3CPEnH/phsWkgoEpyVx9zxqqHdLDtBOffexPAR+TCLz8O7ovtr9wUU+r7b/UkBCB1DXXRLfm1Rh14sscwVPAqWb0J1JcMdG/K0exDRFg4lR6KHj3GX4PKTFWt2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e2c230d55dso26470895ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754149503; x=1754754303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qxyTBBt9giwfkzcyWF6FPJ7xzNuBgTj+FuEB5DJcys=;
        b=H1gOBiRybyPrVg4JraPdpA1If+PJx26IMsnOeAXLWLfk8aShN5HhUoC4Peic1flFMH
         t67aHs9Wqp4qTYTsnpJmEybVB/CWdTv4Xwd6QL5hNB1jHnr+E6zN/Tq3E6eWFfkY5869
         T4uuE6Ay40Y5fbI04dnJep8GrNuIu4PrPJJ8FRudiL2mxjA9ptxob78iP7DDCrBWHT16
         Kn6aKLP4Do2qC9s3Urz1mJ9GfqHe7viSbY9MgFtf8y4lUARcAxJCIeRpNYNZQi1cyKIK
         p7V1P27AA7JC8c0qFYAi9mOtNXCDMN++j/6HMBLYcfjxi2RqKf8WVe8btqtO8RqR4vb/
         RqkQ==
X-Gm-Message-State: AOJu0Yyx0IjESL949rJZDN2l8xcfGW7+MpGH7/hEN/l2xM404hDyG9Fu
	NlYQ4vP8biRsFEWQ+W+nOq2jiFpRZXooYCfRecrey+TYacWBfC4nag0Nk1qvGddZjMyuk7vqMYI
	sAda1v0Ke4vFE3MBG/w40CmspIZ/jSwvsLnqJXTHKGYDtONnt+yDemfeEl/g=
X-Google-Smtp-Source: AGHT+IE9K9sVfPR9/F+fl5nKYkSr9GmzLdw7TmXWTbihJf+V5SKy20yvEL5H6p24zuvbDTJnK9z1JN/CUkQwTohL93O70yS+KgDY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:3dd:f476:8be8 with SMTP id
 e9e14a558f8ab-3e4162bc67fmr54080865ab.3.1754149503221; Sat, 02 Aug 2025
 08:45:03 -0700 (PDT)
Date: Sat, 02 Aug 2025 08:45:03 -0700
In-Reply-To: <CALkFLL+Lcs=wiD11AxJGt9zQ0k3Lo23ppJ2yRbW3qLV7ZOi7+A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e327f.a70a0220.249f57.0003.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ujwal.kundur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in del_gendisk

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-ga6923c06a3b2-dirty #0 Not tainted
------------------------------------------------------
kworker/u8:2/36 is trying to acquire lock:
ffff888025106188 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xf0/0x180 block/genhd.c:823

but task is already holding lock:
ffff8880251060d8 (&set->tag_list_lock){+.+.}-{4:4}, at: del_gendisk+0xe8/0x180 block/genhd.c:822

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&set->tag_list_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1360 kernel/locking/mutex.c:760
       blk_mq_sysfs_register+0x196/0x530 block/blk-mq-sysfs.c:232
       blk_register_queue+0xf2/0x400 block/blk-sysfs.c:884
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfc/0x480 block/genhd.c:597
       <kernel::block::mq::gen_disk::GenDiskBuilder>::build::<rnull::NullBlkDevice> rust/kernel/block/mq/gen_disk.rs:160 [inline]
       <rnull::NullBlkModule as kernel::InPlaceModule>::init::{closure#0} drivers/block/rnull.rs:49 [inline]
       <rnull::NullBlkModule as kernel::InPlaceModule>::init+0x8ee/0xc00 drivers/block/rnull.rs:46
       rnull::__module_init::__module_init::__init drivers/block/rnull.rs:27 [inline]
       __rnull_mod_init+0x1a/0x70 drivers/block/rnull.rs:27
       do_one_initcall+0x233/0x820 init/main.c:1269
       do_initcall_level+0x104/0x190 init/main.c:1331
       do_initcalls+0x59/0xa0 init/main.c:1347
       kernel_init_freeable+0x334/0x4a0 init/main.c:1579
       kernel_init+0x1d/0x1d0 init/main.c:1469
       ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&set->update_nr_hwq_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1522
       del_gendisk+0xf0/0x180 block/genhd.c:823
       nbd_dev_remove drivers/block/nbd.c:268 [inline]
       nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:284
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
       kthread+0x711/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&set->tag_list_lock);
                               lock(&set->update_nr_hwq_lock);
                               lock(&set->tag_list_lock);
  rlock(&set->update_nr_hwq_lock);

 *** DEADLOCK ***

3 locks held by kworker/u8:2/36:
 #0: ffff888025c60148 ((wq_completion)nbd-del){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888025c60148 ((wq_completion)nbd-del){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000ac7bc0 ((work_completion)(&nbd->remove_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000ac7bc0 ((work_completion)(&nbd->remove_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff8880251060d8 (&set->tag_list_lock){+.+.}-{4:4}, at: del_gendisk+0xe8/0x180 block/genhd.c:822

stack backtrace:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.16.0-syzkaller-ga6923c06a3b2-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: nbd-del nbd_dev_remove_work
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
 down_read+0x46/0x2e0 kernel/locking/rwsem.c:1522
 del_gendisk+0xf0/0x180 block/genhd.c:823
 nbd_dev_remove drivers/block/nbd.c:268 [inline]
 nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:284
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         a6923c06 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1346dcf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18eb6d916c138763
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11010aa2580000


