Return-Path: <linux-kernel+bounces-819519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F8B5A1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3418932740F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D112E6CA2;
	Tue, 16 Sep 2025 20:09:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1E2DE1E3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053375; cv=none; b=qbvIuk2crPkwMLtfs7uKr5AV0M2WRkwHG81LlwMGvdR22qYe+CXZI1wXQa1+bL+RveTZGLZNYLgTSAe2sMwUeAmZvmol3ngQnbdtYE3xCiNJx2ynETtnzdiMJEFlSkuqWSeeh/rdsgZRln95Qm+wISwBkJWdt84sPoGJnrgK/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053375; c=relaxed/simple;
	bh=u81C7l24p6m9RRAeUcVhW7OZ1BEOJR8bzN6FLw280Hc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MuU97RdDTc+ntFu/2x5p7HkFe4TojbCS2XqOjzh+ofQV64zS80FneeZHnfiFN829ijlyd8vHKgw7KeRbIDJ365cXzyLhYCfmtRLS3rVETt5d3CeAoCCxTiIivgnUL7HlgD5/ezvtAFqjE0DXXj+yGufKZNYXgitbMSY53UMUmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42407a5686fso33663355ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053373; x=1758658173;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gEscd1JYUqCKMWnwvZXmV9UPmp/sc/vJW4dEvvLDQs=;
        b=ZJX8BHJ2EVwxTB/t7O+A+6gsZJFkmVhRuZxIbtTkMpPxK+JONa1q2GOT2LkOtOZQrY
         O9S9Oy7CpXVsZBLjtbl5s96IPDM9SnWIMpWM9lTA7a8rpxayvD7ASDQwQWLgMPtIoyXi
         NZ35Vo4TM0D+RbLNx5Ihnr8RM7kePhf5yeXaiVEweI2yfH2JBXVYJjIJlP7gOi0Y9ro6
         GTCODrDVVS7oj8Yuh+Rl2J+t00Tx7Lyrg78xEEPgD+LPb4llMYjVWWPqMAq0AQdg79o8
         9+nlukFNRdckaG8hjy55/p7WJINwe/pKIy61NJUlBPcpgze1XQLYvRE3aOvkyxjP2tp/
         APiQ==
X-Gm-Message-State: AOJu0YzvwqbxgKjVdnnRb9rcAjFrI+xxSUh4g+LO5RSWI4jPI4KwD0ps
	+7WXcLeuJxrCsCRqvH8PFu0RSr22V/ey2fVi5h1fuw0SbwCowvHGJxLWXl3TvTUK9swMeDz8q5/
	3y3bYfyaDPG0bJ0Y/FW8l6G9kWwdymweiu+jpG2yePGXFT34QuoT2iGZNo9dZFg==
X-Google-Smtp-Source: AGHT+IGia2WTOtuwzY034iisV4TalC7SMh5DUILDq91DBDH6hIC0iwN4O0xDL5El7xhrwmN5JujwRFoRBvp3SK4X8btdi7OH6Mal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:424:13d9:f6c8 with SMTP id
 e9e14a558f8ab-42413d9fa50mr25313635ab.9.1758053372725; Tue, 16 Sep 2025
 13:09:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:09:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9c3fc.050a0220.3c6139.0e67.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in acct
From: syzbot <syzbot+514e8c53d21c55ef664b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c22f62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9134e501f17b95a4
dashboard link: https://syzkaller.appspot.com/bug?extid=514e8c53d21c55ef664b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10222f62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109f4e42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/872439e79d04/disk-590b221e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09ebcfd707c1/vmlinux-590b221e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3417bc549df/bzImage-590b221e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+514e8c53d21c55ef664b@syzkaller.appspotmail.com

INFO: task syz.3.20:6136 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.20        state:D stack:25352 pid:6136  tgid:6136  ppid:6012   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6964
 __schedule_loop kernel/sched/core.c:7046 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7061
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7118
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 __do_sys_acct kernel/acct.c:301 [inline]
 __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee8a38eba9
RSP: 002b:00007ffd45f06b98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00007fee8a5d5fa0 RCX: 00007fee8a38eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000180
RBP: 00007fee8a411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fee8a5d5fa0 R14: 00007fee8a5d5fa0 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e53c820 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e53c820 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e53c820 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:4/65:
3 locks held by kworker/0:2/984:
 #0: ffff88801a871548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88801a871548 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffff8880b8624008 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
 #2: ffff888078ee4fe0 (&r->consumer_lock#2){+.+.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff888078ee4fe0 (&r->consumer_lock#2){+.+.}-{3:3}, at: ptr_ring_consume_bh include/linux/ptr_ring.h:365 [inline]
 #2: ffff888078ee4fe0 (&r->consumer_lock#2){+.+.}-{3:3}, at: wg_packet_decrypt_worker+0x87a/0xd10 drivers/net/wireguard/receive.c:499
2 locks held by getty/5627:
 #0: ffff88802fefb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000331e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz.2.19/6135:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.3.20/6136:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.1.18/6137:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.0.17/6138:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
3 locks held by kworker/u8:8/6235:
1 lock held by syz.7.24/6244:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.4.21/6245:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.5.22/6247:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.6.23/6248:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.1.28/6342:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.0.27/6343:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.8.25/6344:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.9.26/6345:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.2.29/6423:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.3.30/6436:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.4.31/6446:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.5.32/6447:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.6.33/6503:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.7.34/6541:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.8.36/6547:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.1.35/6548:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.9.37/6577:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.0.38/6639:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.2.39/6645:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.3.40/6646:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.4.41/6673:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.5.42/6726:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.7.44/6755:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
1 lock held by syz.6.43/6756:
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __do_sys_acct kernel/acct.c:301 [inline]
 #0: ffffffff8e56f748 (acct_on_mutex){+.+.}-{4:4}, at: __se_sys_acct+0xb5/0x8d0 kernel/acct.c:293
3 locks held by syz-executor/6758:
 #0: ffffffff8f0c4220 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8f0c4220 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8f0c4220 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f955108 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f955108 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f955108 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4056
 #2: ffffffff8e5422b8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #2: ffffffff8e5422b8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:957

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: bat_events batadv_nc_worker
RIP: 0010:rcu_lock_release include/linux/rcupdate.h:341 [inline]
RIP: 0010:rcu_read_unlock include/linux/rcupdate.h:871 [inline]
RIP: 0010:batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
RIP: 0010:batadv_nc_worker+0x27d/0x610 net/batman-adv/network-coding.c:719
Code: 8b 5c 24 08 eb 24 e8 62 e5 66 f6 c6 05 1f fe 75 04 01 48 c7 c7 80 09 d9 8c be 66 03 00 00 48 c7 c2 20 0a d9 8c e8 b3 b0 44 f6 <48> c7 c7 20 c8 53 8e 4c 89 ee e8 94 96 44 f6 e8 0f 3a 4e f6 48 8b
RSP: 0018:ffffc90000ba7a00 EFLAGS: 00000293
RAX: ffffffff8b5925c1 RBX: ffff88807608ca80 RCX: ffff8880222d0000
RDX: 0000000000000000 RSI: ffffffff8c0503e0 RDI: ffffffff8c0503a0
RBP: fffffffffffffe38 R08: 0000000000000000 R09: ffffffff8b592482
R10: dffffc0000000000 R11: ffffffff8b5923b0 R12: dffffc0000000000
R13: ffffffff8b592482 R14: ffff888031244d80 R15: 00000000000000ef
FS:  0000000000000000(0000) GS:ffff8881258a7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e77575e9c CR3: 0000000079c3e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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

