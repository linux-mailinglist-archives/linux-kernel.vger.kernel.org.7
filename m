Return-Path: <linux-kernel+bounces-771545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70148B2889D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAB41C87EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3552C3768;
	Fri, 15 Aug 2025 23:05:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C531922FB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299132; cv=none; b=M2BUc0z/Il+vE38dl6VWG7QYFuCpPeaKMr7mzsFB7DdnhAlmLl0cFnGIGSqEfHU3tlbKxI/c25LXxpxl+FXr3xoXqXEYrVG0OWBjU8yMY4ufmtUYmKnODbLhQT0E9tIouep11JfgpYlOi6qjQT7sMF/pRSGNLJy8lfiFIVO8RqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299132; c=relaxed/simple;
	bh=/X8DqUF2/LE7RQjhD3LaXwdN8foltjkuhcl6+3fuwvM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hw9qopSe0BjqZUlzddi2u7h2wYRsHKnGAnwVC3JHxMq65wKvrRkDjibFjsuWtsTeJJ2a/ESm2yCFqTfUibAdkORGrE9dCQGjctIhT9Qk2zdriXTWTGp075FPR5qgdtaK4HDOcGXUDzMBmdZcHS5YoUxdZdvr8g3PpKopdgIaiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e57006bfddso29873715ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755299130; x=1755903930;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gv8M7dhIVXVmfcY2J7/xyK3vXGRzPFZACwUj8PXJCZ8=;
        b=p2NwdkLIqUYSoB1fDtgLE6sua1EvcrCUvJFKVMY1As+3Z85fHQ7gIggrP0N66sE6ao
         0TJmr7HRKWLGzHpgvcsBe84i1/PeTX2yRRG+XG1pvIR6VTU4/XIq8MZyzGsYCpETM36W
         mYSqH2WPDzruEQ3RKWd+p8GBc0+ERlSbrXMfnPYqDPSxWKSWx0pxyhihwz1BJn+e0xVQ
         NwEdal8k5yvL8lh1EURKmVDtxrxUh3Vrvl0lePrD6lyqudpIH0wCLOfw/otai1Nfwlpa
         WvX72T8cLq7Y39nu6N1Ndq7ZbBC+te8NqKoLVzdhmyhnSBA4W2ZduH88P1LXH9iH1kRD
         0RBw==
X-Forwarded-Encrypted: i=1; AJvYcCU4kxHfgRwSpS+2G2PHdiQRtZDlWF5inVJu98uwIPLzFk+PyVpl+8YL+APHQo3wfez5P0/kzwsZ+9M4QJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhV0FwGw43WkwKeIr9d4KUMwMtdpH9pCIyii4h4QANEycuhbX
	kjQzafXx4II1am1BKYySVYwbkO7e5ZufGDG79LPZvxmdKvAcscOutpI9iLgs2u21OfvKw3olPEa
	Kx6EE7eyllpnDz8icLDPMQhHb6xdBuTr4MVSlXpjJcU/w8/r5GspxAajdkLk=
X-Google-Smtp-Source: AGHT+IErXOt/leY/6gFcl+4z6s1+eMktvDZ+QPNiNZlFjx5ny7uw9yb6jp8P6dtiqRpLf8TQipoogC508XFLbHT1Sb+PT7ppE+ht
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:3e5:5937:e559 with SMTP id
 e9e14a558f8ab-3e57e7d810fmr54553755ab.2.1755299130080; Fri, 15 Aug 2025
 16:05:30 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689fbd3a.050a0220.e29e5.002a.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in task_mm_cid_work (3)
From: syzbot <syzbot+57f0d1e060c788fece6f@syzkaller.appspotmail.com>
To: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	luto@kernel.org, peterz@infradead.org, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15afc842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63ca1d84387f368
dashboard link: https://syzkaller.appspot.com/bug?extid=57f0d1e060c788fece6f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156f69a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ae13f77c322/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/998762a6b132/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9fc6a40b39e7/bzImage-8f5ae30d.xz

The issue was bisected to:

commit 7220e8f4d4eec0b2f682eef45e2d36c092738413
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Mar 27 14:44:39 2025 +0000

    net: lapbether: use netdev_lockdep_set_classes() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b1d842580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b1d842580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57f0d1e060c788fece6f@syzkaller.appspotmail.com
Fixes: 7220e8f4d4ee ("net: lapbether: use netdev_lockdep_set_classes() helper")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5974/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=9577, q=872 ncpus=2)
task:syz-executor    state:R  running task     stack:23704 pid:5974  tgid:5974  ppid:5972   task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:preempt_schedule_notrace+0x77/0xe0 kernel/sched/core.c:7244
Code: 08 25 ff ff ff 7f 83 f8 01 74 29 bf 01 00 00 00 e8 6e 9b ff ff 65 ff 0d 07 bb 41 08 80 3b 00 75 5d 48 8b 45 00 a8 08 75 ca 5b <5d> 41 5c 41 5d c3 cc cc cc cc 4c 8b 64 24 20 4c 89 e7 e8 52 80 03
RSP: 0018:ffffc900043cfcf8 EFLAGS: 00000246
RAX: 0000000000004000 RBX: ffff8880b84332a8 RCX: ffffffff8188c8df
RDX: 0000000000000000 RSI: fffff52000879f7f RDI: ffffffff8df5de60
RBP: ffff88802baba440 R08: 0000000000000000 R09: fffffbfff21566b2
R10: ffffffff90ab3597 R11: 0000000000000000 R12: ffffffff812c75c6
R13: ffff88802baba440 R14: ffff8880751e8ac0 R15: ffff8880b843a300
 preempt_schedule_notrace_thunk+0x16/0x30 arch/x86/entry/thunk.S:13
 rcu_is_watching+0x8e/0xc0 kernel/rcu/tree.c:752
 rcu_read_lock include/linux/rcupdate.h:842 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 sched_mm_cid_remote_clear_old kernel/sched/core.c:10757 [inline]
 task_mm_cid_work+0x5e4/0x900 kernel/sched/core.c:10817
 task_work_run+0x150/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c699c14a5
RSP: 002b:00007fff893915b0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: 0000000000000000 RBX: 0000000000000015 RCX: 00007f2c699c14a5
RDX: 00007fff893915f0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fff8939165c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000001388
R13: 00000000000927c0 R14: 000000000002319a R15: 00007fff893916b0
 </TASK>
rcu: rcu_preempt kthread starved for 2846 jiffies! g9577 f0x0 RCU_GP_INIT(4) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29128 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rcu_gp_init+0x8a0/0x1640 kernel/rcu/tree.c:1804
Code: 38 d0 7c 08 84 d2 0f 85 28 09 00 00 44 8b 25 eb b4 09 0f 45 85 e4 0f 85 62 07 00 00 48 c7 c7 00 c0 5c 8e e8 e2 44 f4 09 31 c0 <48> ba 00 00 00 00 00 fc ff df 4c 8b 7c 24 18 49 01 d7 49 c7 07 00
RSP: 0018:ffffc90000157cd0 EFLAGS: 00000246
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8de29c00 RDI: ffff88801e2e0a80
RBP: ffffffff8e5cc500 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90ab3597 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880b853b300 R14: ffffed1003c5c08e R15: ffffffff8e5cc558
 rcu_gp_kthread+0xb6/0x380 kernel/rcu/tree.c:2275
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 6019 Comm: kworker/R-wg-cr Not tainted 6.17.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue:  0x0 (wg-crypt-wg1)
RIP: 0010:finish_task_switch.isra.0+0x22a/0xc10 kernel/sched/core.c:5225
Code: fb 09 00 00 44 8b 05 69 5c 22 0f 45 85 c0 0f 85 be 01 00 00 4c 89 e7 e8 a4 f6 ff ff e8 bf 6e 3a 00 fb 65 48 8b 1d fe 24 4d 12 <48> 8d bb 18 16 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90003fafa38 EFLAGS: 00000206
RAX: 0000000000163dc5 RBX: ffff88807c7b0000 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffff8de4f0f5 RDI: ffffffff8c162400
RBP: ffffc90003fafa80 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90ab3597 R11: 0000000000000000 R12: ffff8880b843a300
R13: ffff88807aa0c880 R14: ffff8880b843a300 R15: ffff8880b843b170
FS:  0000000000000000(0000) GS:ffff8881246bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000058 CR3: 000000005ac58000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x1198/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__list_del include/linux/list.h:196 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:218 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:213 [inline]
RIP: 0010:list_del include/linux/list.h:229 [inline]
RIP: 0010:detach_worker+0x105/0x200 kernel/workqueue.c:2716
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fc 00 00 00 48 89 ea 49 89 6e 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <0f> 85 c3 00 00 00 4c 89 75 00 e8 0c 48 39 00 4c 89 e2 48 b8 00 00
RSP: 0018:ffffc90003fafd20 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff888079609100 RCX: ffffffff81824a7d
RDX: 1ffff110066d208c RSI: ffffffff81824a8b RDI: ffff8880b84395c0
RBP: ffff888033690460 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888079609160
R13: ffff888079609168 R14: ffff8880b84395b8 R15: 0000000000000000
 worker_detach_from_pool kernel/workqueue.c:2735 [inline]
 rescuer_thread+0x841/0xea0 kernel/workqueue.c:3529
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

