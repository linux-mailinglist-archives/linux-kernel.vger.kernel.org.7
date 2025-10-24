Return-Path: <linux-kernel+bounces-867974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C73C040B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB673B6F47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF71C5D59;
	Fri, 24 Oct 2025 01:49:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E524B28
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270549; cv=none; b=jEy7Z7nCvSXYioX1D2ibFeq3Eo2TH5OgeDHClBJPklw5wJQQOzwG3enJA+30lZZAjGepZjrda8jkZAoEXN+N66aBNnfYBuW6RVsJEOdr0m3mbNC8KsphYu9gHV583Zn07RUTg8iLch/Uvg9IucCCwDsvckuxgCXWWliIvh2lV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270549; c=relaxed/simple;
	bh=egWONB+Q9woZ5GHpkV5xtTo1YNtpNqtK+b6mcu4XsDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KZsgL+MXlZxTJE+Q3lSyG3lQZniRZNmwgnG6JODwoFu4JtSygFSrIA2j9zhlLkBvUwENHV42Ric0mDykglfGpy00To3eEm2O06znRDkrcFyK8+liKGhOspWFPh+O2ZfjmL+U6YvICu76DRvFI5l5ADXtiINOGpyiEMslsV/eD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e8db8badeso162758639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270544; x=1761875344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2En65YS+uGCs830ApQ+MZXgMX+DVb/d3oDp1knOVt8=;
        b=LsmLJ0SUzpIdaSvGqB71C6EGojW5Sg9mXUIuIfv3mJTFKneDmfXASMFN91qXvjAk4n
         KfJ6ReUIDDWi5qysGtWQq0XpoJhU/JNo6qlNswUTVAqh5IM8XQWnWbYGF65ZtTgkaRNN
         rfelqkkis5eNADCZttIb50ybo4F+cLCZl51/m8HLdYI3PfmPBCT+LLIMVdCep2GKVBKD
         443F7D3qHTYSpY48i6topDJb5OnZJlqFSr2d3eVCKaa/IkmV2Wf5ybrjq3WV8OH5GTyt
         RSSNKXdMoV7fjZ0hGpgzWUp/Q5HhD3f9LNDRpmKFCSSL/x6M8szgEeGa6cUHGMxJfqni
         6Skw==
X-Forwarded-Encrypted: i=1; AJvYcCX2y+qJpoxBaVeF/NvY83b9ObwpSCBGOE4iaNfPB8/uE3YqaxvxKfGlKCeKT8sP4V+r7nH/BsobCqPKQDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDmj6WcctAIV2ga+08+0pBQxW0eN/DAB3ABiuI5/jO8RkPemV
	ApTjOW3otYPney/y5Difsm3ZdvvQoPxEd4D7vfgRCMD5+Y/P6Ep1/t9hGvGFI52Vp59p1mFw87g
	6aMMZ/lYP5v2KGMxf6KqbsGoF4l6T7Ttkrit3wGL221rLRlHepeFhy5Rq660=
X-Google-Smtp-Source: AGHT+IEUnJnNCMANUAcMmLgFG4Vc7eKcUcCpL3CQjp1OrL0XuqGqfVNAu8VdYdORCXhzpx1rVzgRbGka+JGENVWhERP0gFAJXKTm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:42f:94fd:318f with SMTP id
 e9e14a558f8ab-430c521f9e2mr347494925ab.9.1761270544628; Thu, 23 Oct 2025
 18:49:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:49:04 -0700
In-Reply-To: <CAHxJ8O90xfWT+5st_bkmg39pVsewvchf46ZPCzSzHHcbPUY-iA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fadb10.050a0220.346f24.008b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in l2cap_conn_del

(syz-executor,6305,1):ocfs2_read_locked_inode:597 ERROR: status = -117
(syz-executor,6305,1):ocfs2_validate_inode_block:1465 ERROR: Invalid dinode #17057: i_mode is zero!
(syz-executor,6305,1):ocfs2_read_locked_inode:597 ERROR: status = -117
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor/6305 is trying to acquire lock:
ffff88802ed7c040 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
ffff88802ed7c040 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
ffff88802ed7c040 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4179 [inline]
ffff88802ed7c040 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: __flush_work+0xd2/0xbc0 kernel/workqueue.c:4237

but task is already holding lock:
ffff88802ed7c338 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x70/0x680 net/bluetooth/l2cap_core.c:1762

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock#2){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x17d/0x12e0 kernel/locking/mutex.c:760
       l2cap_info_timeout+0x60/0xa0 net/bluetooth/l2cap_core.c:1668
       process_one_work kernel/workqueue.c:3263 [inline]
       process_scheduled_works+0xa55/0x16b0 kernel/workqueue.c:3346
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       touch_work_lockdep_map kernel/workqueue.c:3951 [inline]
       start_flush_work kernel/workqueue.c:4205 [inline]
       __flush_work+0x6b8/0xbc0 kernel/workqueue.c:4237
       __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4393
       l2cap_conn_del+0x4f0/0x680 net/bluetooth/l2cap_core.c:1796
       hci_disconn_cfm include/net/bluetooth/hci_core.h:2121 [inline]
       hci_conn_hash_flush+0x10d/0x230 net/bluetooth/hci_conn.c:2602
       hci_dev_close_sync+0xa0a/0x11b0 net/bluetooth/hci_sync.c:5303
       hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
       hci_unregister_dev+0x21a/0x510 net/bluetooth/hci_core.c:2715
       vhci_release+0x152/0x1a0 drivers/bluetooth/hci_vhci.c:690
       __fput+0x44c/0xa70 fs/file_table.c:468
       task_work_run+0x1d4/0x260 kernel/task_work.c:227
       exit_task_work include/linux/task_work.h:40 [inline]
       do_exit+0x6b5/0x2300 kernel/exit.c:966
       do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
       __do_sys_exit_group kernel/exit.c:1118 [inline]
       __se_sys_exit_group kernel/exit.c:1116 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
       x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&conn->lock#2);
                               lock((work_completion)(&(&conn->info_timer)->work));
                               lock(&conn->lock#2);
  lock((work_completion)(&(&conn->info_timer)->work));

 *** DEADLOCK ***

5 locks held by syz-executor/6305:
 #0: ffff888026654dc8 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:499 [inline]
 #0: ffff888026654dc8 (&hdev->req_lock){+.+.}-{4:4}, at: hci_unregister_dev+0x212/0x510 net/bluetooth/hci_core.c:2715
 #1: ffff8880266540b8 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5b3/0x11b0 net/bluetooth/hci_sync.c:5291
 #2: ffffffff8f1f8ca8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:2118 [inline]
 #2: ffffffff8f1f8ca8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flush+0xa1/0x230 net/bluetooth/hci_conn.c:2602
 #3: ffff88802ed7c338 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x70/0x680 net/bluetooth/l2cap_core.c:1762
 #4: ffffffff8dd3cc20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8dd3cc20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #4: ffffffff8dd3cc20 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4179 [inline]
 #4: ffffffff8dd3cc20 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xd2/0xbc0 kernel/workqueue.c:4237

stack backtrace:
CPU: 0 UID: 0 PID: 6305 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
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
 touch_work_lockdep_map kernel/workqueue.c:3951 [inline]
 start_flush_work kernel/workqueue.c:4205 [inline]
 __flush_work+0x6b8/0xbc0 kernel/workqueue.c:4237
 __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4393
 l2cap_conn_del+0x4f0/0x680 net/bluetooth/l2cap_core.c:1796
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2121 [inline]
 hci_conn_hash_flush+0x10d/0x230 net/bluetooth/hci_conn.c:2602
 hci_dev_close_sync+0xa0a/0x11b0 net/bluetooth/hci_sync.c:5303
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_unregister_dev+0x21a/0x510 net/bluetooth/hci_core.c:2715
 vhci_release+0x152/0x1a0 drivers/bluetooth/hci_vhci.c:690
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7814385d29
Code: Unable to access opcode bytes at 0x7f7814385cff.
RSP: 002b:00007ffc212d6318 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7814401919 RCX: 00007f7814385d29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 000000000000000d R08: 00007ffc212d40b6 R09: 00007ffc212d75d0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc212d75d0
R13: 00007f78144018f4 R14: 00007ffc212d8690 R15: 0000000000000001
 </TASK>


Tested on:

commit:         6fab32bb MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178fb734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1361c614580000


