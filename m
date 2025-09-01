Return-Path: <linux-kernel+bounces-793627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43634B3D63E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F48176262
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5A1E5B71;
	Mon,  1 Sep 2025 01:14:38 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105C34CDD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689278; cv=none; b=NQik1MXmSy1vE5jXnSFDL+HY+iPuHetACQkpeK0ecuZ1R7Nl7SAooAR/F2fBP0i85jnYktFJ6iF9B5C03NSV6eypN3OuJlmiS/SlYHFLiR0vIIPpMLYqpD+wpQyJ+VKiHepDO1inXIR91NrUWF5CGkvVUGGEAXghYKGOD2tFG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689278; c=relaxed/simple;
	bh=wGnSLMZaFezFU7zx5VXAoGtIo7B2IWqstY6jXklPGRo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=moHuWh/FmYVz3ooEY4gGCOsKpd0p4X4BcmaKMiBDtNk2I2xNiT7xi+fk4+WD4/JZrv4KucHn+xDymDUs4utk7DSUi/8CgHaIVY3M9Mla/VTM5hDPGVnMh0bFq9fVBexopfJboXTiyxoJaDyeEiNRvVFvLEV+iNb5Y5zQZmWvHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3f2a2b1357cso70842845ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 18:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756689275; x=1757294075;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRDISHPcnvYCw538zs45yNx3LhdCKIvieoV/R0p+ymE=;
        b=S28dLdfuNYzlIDxe4B4XNI8cT4zBCNxDuUbi/d5z0oUA01WqP4waVxZPpE7ZQUwefs
         Cu9rpg8/5Q4qsigrHympdWlcm6lf3+tpk4ttVbQoCJuPAOhXYFWj5BiwBKbK+2+mlzv7
         h9sxwyzppHzBV9JOiZd7iV8dgRTAKp1b/R6CDqVZ7IpUdxT8Lg0I4luP5de0f6NNd1IO
         xYY1bgZlJxUkZc6H6k6ET7wDYBgNc+Yp4GzUVWTFGH0hktfQfKMOj5MCJ212LoeNrvgY
         G219AS3OEmRdG4QjZbY8ejLq4L6udK7BWab9Tn8XDKWqFMjqJEgoVXmNDWLKt1WXjxLx
         7IVg==
X-Forwarded-Encrypted: i=1; AJvYcCUj2esdO2TuIkmdW+BIyWpXH8gAIN5/eCeNEOu4dmLKPybr1XwD1gHx9Lbx111Ls+eA1QodCAAb8Lk0ZSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJAb+fUa8LsZl2nYHS+LPJAb/hhCNT52ac+lWmK3UcS/je/Cj
	PVRCNUitxjlwwwxRBY0XrpSEzJxVVhJYkpgWT1gfSqogW7dBJ5W99Ig2wz/UwbzkO+VAiTz9vOv
	O/o3c3Cg9/iJK3SmGLVUQ2FHeFq130ijDJiutDUbvIOIrB2VQeDNmXTWfcDA=
X-Google-Smtp-Source: AGHT+IGjoVkKy1PXvhx4JzTvKB4O5wWhvCeMZOvmDHMB2CNVTRoHX6zcsmjpAdoFQhhzU1nbJrZ4Ovba/OKLiiC5JENg1KIG2Pgi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a45:b0:3ee:7c7a:c89c with SMTP id
 e9e14a558f8ab-3f40085fa09mr136295675ab.14.1756689275689; Sun, 31 Aug 2025
 18:14:35 -0700 (PDT)
Date: Sun, 31 Aug 2025 18:14:35 -0700
In-Reply-To: <672f1c3a.050a0220.138bd5.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b4f37b.a00a0220.1337b0.003d.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in schedule_timeout (7)
From: syzbot <syzbot+8926d1b522e7194a4b3e@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, 
	frederic@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b0a1f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=8926d1b522e7194a4b3e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cf5a62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b0a1f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8926d1b522e7194a4b3e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=8469, q=411 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10503 (4294959250-4294948747), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10504 jiffies! g8469 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26728 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7288
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:timer_destroy_on_stack+0x4/0x20 kernel/time/timer.c:822
Code: 80 e1 07 80 c1 03 38 c1 7c b4 e8 f7 63 76 00 eb ad 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <53> 48 89 fb e8 43 b9 12 00 48 89 df 48 c7 c6 60 e2 ac 8b 5b e9 c3
RSP: 0018:ffffc90000157a38 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000000ffffb78c RCX: ffff88801d29da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90000157a60
RBP: ffffc90000157b30 R08: ffffffff8fe52d37 R09: 1ffffffff1fca5a6
R10: dffffc0000000000 R11: fffffbfff1fca5a7 R12: 1ffff9200002af48
R13: 1ffffffff1c42240 R14: ffffc90000157a60 R15: dffffc0000000000
 schedule_timeout+0x13b/0x270 kernel/time/sleep_timeout.c:103
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 6118 Comm: syz.1.31 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__local_bh_disable_ip+0x44/0x190 kernel/softirq.c:329
Code: 89 f3 65 48 8b 05 4c b6 5f 11 48 89 44 24 68 49 bf 00 00 00 00 00 fc ff df 48 c7 04 24 b3 8a b5 41 48 c7 44 24 08 5d 5b ce 8d <48> c7 44 24 10 b0 09 86 81 49 89 e4 49 c1 ec 03 48 b8 f1 f1 f1 f1
RSP: 0018:ffffc90003597c80 EFLAGS: 00000282
RAX: 63bb6213f70ec600 RBX: 0000000000000200 RCX: ffff88807d190000
RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffff81699312
RBP: ffffc90003597d30 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff520006b2fc6 R12: ffff88807d191940
R13: ffff88807d19002c R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007fe55f3cd6c0(0000) GS:ffff8881257c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000058 CR3: 00000000741c6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 local_bh_disable include/linux/bottom_half.h:20 [inline]
 fpregs_lock arch/x86/include/asm/fpu/api.h:69 [inline]
 fpu__clear_user_states+0x90/0x350 arch/x86/kernel/fpu/core.c:813
 handle_signal arch/x86/kernel/signal.c:310 [inline]
 arch_do_signal_or_restart+0x452/0x750 arch/x86/kernel/signal.c:339
 exit_to_user_mode_loop+0x75/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe55e5b7320
Code: 83 c0 16 83 e0 f7 74 12 50 48 8d 3d 4a 3e 08 00 e8 f5 8f f8 ff 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <83> ff 21 74 0b c3 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 f3 48
RSP: 002b:00007fe55f3ccb38 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000000 RBX: 00007fe55e7c5fa8 RCX: 00007fe55e58ebe9
RDX: 00007fe55f3ccb40 RSI: 00007fe55f3ccc70 RDI: 0000000000000021
RBP: 00007fe55e7c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe55e7c6038 R14: 00007ffe9f8ccd20 R15: 00007ffe9f8cce08
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

