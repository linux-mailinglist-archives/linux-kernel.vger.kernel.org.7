Return-Path: <linux-kernel+bounces-754448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9169B19465
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497E17A403E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C131A0728;
	Sun,  3 Aug 2025 15:34:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14D4502A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235270; cv=none; b=m69SLbQzhlwmfUXyD6bx5bUE09tmHL/bW9Eay8T0UXP8D/GcWLHJTsl+7oXpWxPvmD1iBMUHENnUhThUh21cyi9K8gS5PdZUeDOi2oCt7YqbVWEpiUkMXGbuCZ9dfSvHJ1p1T+0hXwObzGH6FDQ5UtSM9qayM9MLLk0iVSSW/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235270; c=relaxed/simple;
	bh=46N/pKDKAcHr9zqNDB6HReSl46lfJ3yKQBsNVjqW9SU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E38niQ4aR5zMiN+u6xraRQGXL+nWFd7DM7wHhRd5JpsA5jf839dykzrgq2Rv6K1NgWUZzVlxoYcoI+Ruqy9Jam1beYl+FO7fgeHaFVgThDuUa0+DFK7/Go5xTg9fRcK2YpEc75CteXPzhF91l3YN/KOE+XNyMVV4a7ObhLe1RqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e410d87893so22822225ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 08:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754235268; x=1754840068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTZ/RhsRyb20eaUIJ9RFTGO4E6tm+Hj8zMh5fORKd8A=;
        b=Y+m+w9zgwIm+vwScgyL8We6jcEbN1OJdVP7L6In2c+27Mct3nP/lbtzamPcxla/amo
         hE3TYxo1cbgOhh63MelseCleyDwDoLRFpYLbbJ6nFpq7AT0JgQpsoSS4PBk5jTKNpnOI
         aOhSz/3Y4ZfiEqyhZxvbBP03wmUZPhCHGRXZoUjX69kWUu6+HE8+H2P/1h662QHJHjBh
         /ojubYK8IV61+zmQMivK7eOsu+e6SJBdIqPmWrG7ki1FxWTgndkM+cam359becc/hRgY
         vr4ujbKc3aOCJJxq804uFhO4DS4RYfKjTwo5HDGDGwrQ0ncreRIkIrj/mvTmOIESdY1G
         7gxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAfBHX8j9374EECn4za0oy3ey4ortK1hKLLbswVZX9cJhrFdR7BWFq2Q6Q0JNbj7HjbJBk44EfAK/EReY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+J+bNvf6Zov4zXj4Y51+e+rIxoS5AzEoSXLexoJw5TXzg97W
	6T3W5HMRK2XVGbyiVCuGEH5huHs3l3TS0dQnFFvxgPdDo2Rlblw4aom2IuyqIWrTv+3fccIxjst
	JI1+vpgPy+kztBtuhfetvXrwRrL6CbtwHg/n7eNORpTRvKTRf7bFoNguqUXw=
X-Google-Smtp-Source: AGHT+IG8WOPLQa07jShWGdMZdRh78T9Yxe2MKYVY2gCtPfM/KiGrbMzn2dmZWr6Ypm25tA7wwLR03axv8w8LkXP6kEYEdnbSd/Y8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c:b0:3e3:f81b:7a1e with SMTP id
 e9e14a558f8ab-3e41611ba0bmr136444005ab.6.1754235267771; Sun, 03 Aug 2025
 08:34:27 -0700 (PDT)
Date: Sun, 03 Aug 2025 08:34:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688f8183.050a0220.13f73d.0002.GAE@google.com>
Subject: [syzbot] [usb?] BUG: sleeping function called from invalid context in kcov_remote_start
From: syzbot <syzbot+13149748d17d82b13f66@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b290aae788e Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177e0f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46544c44676816
dashboard link: https://syzkaller.appspot.com/bug?extid=13149748d17d82b13f66
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a42db01cad91/disk-4b290aae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32f0fca549e2/vmlinux-4b290aae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4b9f4fa04d4/bzImage-4b290aae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13149748d17d82b13f66@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 2
7 locks held by ksoftirqd/1/30:
 #0: ffffffff8d64a580 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
 #3: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #6: ffff8880b8928b78 ((lock)#3){....}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #6: ffff8880b8928b78 ((lock)#3){....}-{3:3}, at: kcov_remote_start+0x92/0x460 kernel/kcov.c:865
irq event stamp: 3767
hardirqs last  enabled at (3766): [<ffffffff8af19435>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (3766): [<ffffffff8af19435>] _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
hardirqs last disabled at (3767): [<ffffffff86a3fdb5>] kcov_remote_start_usb_softirq include/linux/kcov.h:88 [inline]
hardirqs last disabled at (3767): [<ffffffff86a3fdb5>] __usb_hcd_giveback_urb+0x3f5/0x710 drivers/usb/core/hcd.c:1662
softirqs last  enabled at (3752): [<ffffffff81850eae>] ksoftirqd_run_end kernel/softirq.c:282 [inline]
softirqs last  enabled at (3752): [<ffffffff81850eae>] run_ksoftirqd+0xce/0x210 kernel/softirq.c:969
softirqs last disabled at (3758): [<ffffffff818e8d62>] smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Not tainted 6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8950
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 kcov_remote_start+0x92/0x460 kernel/kcov.c:865
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
 __usb_hcd_giveback_urb+0x427/0x710 drivers/usb/core/hcd.c:1662
 usb_giveback_urb_bh+0x296/0x420 drivers/usb/core/hcd.c:1697
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3581
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 2
7 locks held by ksoftirqd/1/30:
 #0: ffffffff8d64a580 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
 #3: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: kcov_remote_start+0x92/0x460 kernel/kcov.c:865
irq event stamp: 10365
hardirqs last  enabled at (10364): [<ffffffff8af19435>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (10364): [<ffffffff8af19435>] _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
hardirqs last disabled at (10365): [<ffffffff86a3fdb5>] kcov_remote_start_usb_softirq include/linux/kcov.h:88 [inline]
hardirqs last disabled at (10365): [<ffffffff86a3fdb5>] __usb_hcd_giveback_urb+0x3f5/0x710 drivers/usb/core/hcd.c:1662
softirqs last  enabled at (10350): [<ffffffff81850eae>] ksoftirqd_run_end kernel/softirq.c:282 [inline]
softirqs last  enabled at (10350): [<ffffffff81850eae>] run_ksoftirqd+0xce/0x210 kernel/softirq.c:969
softirqs last disabled at (10356): [<ffffffff818e8d62>] smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8950
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 kcov_remote_start+0x92/0x460 kernel/kcov.c:865
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
 __usb_hcd_giveback_urb+0x427/0x710 drivers/usb/core/hcd.c:1662
 usb_giveback_urb_bh+0x296/0x420 drivers/usb/core/hcd.c:1697
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3581
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 2
7 locks held by ksoftirqd/1/30:
 #0: ffffffff8d64a580 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
 #3: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: kcov_remote_start+0x92/0x460 kernel/kcov.c:865
irq event stamp: 15439
hardirqs last  enabled at (15438): [<ffffffff8af19435>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (15438): [<ffffffff8af19435>] _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
hardirqs last disabled at (15439): [<ffffffff86a3fdb5>] kcov_remote_start_usb_softirq include/linux/kcov.h:88 [inline]
hardirqs last disabled at (15439): [<ffffffff86a3fdb5>] __usb_hcd_giveback_urb+0x3f5/0x710 drivers/usb/core/hcd.c:1662
softirqs last  enabled at (15424): [<ffffffff81850eae>] ksoftirqd_run_end kernel/softirq.c:282 [inline]
softirqs last  enabled at (15424): [<ffffffff81850eae>] run_ksoftirqd+0xce/0x210 kernel/softirq.c:969
softirqs last disabled at (15430): [<ffffffff818e8d62>] smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8950
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 kcov_remote_start+0x92/0x460 kernel/kcov.c:865
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
 __usb_hcd_giveback_urb+0x427/0x710 drivers/usb/core/hcd.c:1662
 usb_giveback_urb_bh+0x296/0x420 drivers/usb/core/hcd.c:1697
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3581
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 2
7 locks held by ksoftirqd/1/30:
 #0: ffffffff8d64a580 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
 #3: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: kcov_remote_start+0x92/0x460 kernel/kcov.c:865
irq event stamp: 25001
hardirqs last  enabled at (25000): [<ffffffff8af19435>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (25000): [<ffffffff8af19435>] _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
hardirqs last disabled at (25001): [<ffffffff86a3fdb5>] kcov_remote_start_usb_softirq include/linux/kcov.h:88 [inline]
hardirqs last disabled at (25001): [<ffffffff86a3fdb5>] __usb_hcd_giveback_urb+0x3f5/0x710 drivers/usb/core/hcd.c:1662
softirqs last  enabled at (24986): [<ffffffff81850eae>] ksoftirqd_run_end kernel/softirq.c:282 [inline]
softirqs last  enabled at (24986): [<ffffffff81850eae>] run_ksoftirqd+0xce/0x210 kernel/softirq.c:969
softirqs last disabled at (24992): [<ffffffff818e8d62>] smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8950
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 kcov_remote_start+0x92/0x460 kernel/kcov.c:865
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
 __usb_hcd_giveback_urb+0x427/0x710 drivers/usb/core/hcd.c:1662
 usb_giveback_urb_bh+0x296/0x420 drivers/usb/core/hcd.c:1697
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3581
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 2
7 locks held by ksoftirqd/1/30:
 #0: ffffffff8d64a580 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
 #3: ffffffff8d7aa040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #4: ffff888019899d38 ((wq_completion)events_bh){+...}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #5: ffffc90000a4fa00 ((work_completion)(&bh->bh)){+...}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #6: ffff8880b8928b78 ((lock)#3){+.+.}-{3:3}, at: kcov_remote_start+0x92/0x460 kernel/kcov.c:865
irq event stamp: 34711
hardirqs last  enabled at (34710): [<ffffffff8af19435>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (34710): [<ffffffff8af19435>] _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
hardirqs last disabled at (34711): [<ffffffff86a3fdb5>] kcov_remote_start_usb_softirq include/linux/kcov.h:88 [inline]
hardirqs last disabled at (34711): [<ffffffff86a3fdb5>] __usb_hcd_giveback_urb+0x3f5/0x710 drivers/usb/core/hcd.c:1662
softirqs last  enabled at (34696): [<ffffffff81850eae>] ksoftirqd_run_end kernel/softirq.c:282 [inline]
softirqs last  enabled at (34696): [<ffffffff81850eae>] run_ksoftirqd+0xce/0x210 kernel/softirq.c:969
softirqs last disabled at (34702): [<ffffffff818e8d62>] smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8950
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 kcov_remote_start+0x92/0x460 kernel/kcov.c:865
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
 __usb_hcd_giveback_urb+0x427/0x710 drivers/usb/core/hcd.c:1662
 usb_giveback_urb_bh+0x296/0x420 drivers/usb/core/hcd.c:1697
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3581
 tasklet_action+0xc/0x70 kernel/softirq.c:854
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:968
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

