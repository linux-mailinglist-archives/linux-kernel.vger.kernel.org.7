Return-Path: <linux-kernel+bounces-738950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBFB0BF74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9830D179573
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656B2853EE;
	Mon, 21 Jul 2025 08:54:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0411798F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088045; cv=none; b=eASxQJwCCJdL1zqtnFu9OOQjjkXnXDyOrAH4Ce9m7wei/te571jUTFG6yeqz3p+CLaplGJCTH0LjEC3gIJ85kBen5GDrA/ut2Znsd/gWZZuBRTJvkrwj9FZHmxvNN492uJ7hPe9akcMmdtaUI/uHGOlTUChzQQ/FL1ufQlxyh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088045; c=relaxed/simple;
	bh=Y1CFewEQ2pp4ssm+KGh+VlHd+V5xUXFR/2NzQKv5+R4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nnydVGX8vZUan921r6s8UzJmA4I03OvtrTroPrfk8euj6jndM4fQVNIgWflnttdgZIBvx/fxPwdd+0h7vyaZyWRuTgAmMb8Kct3PeHigAv3ubrom1jmKj3hWzKqidA5x5uiRf+60r4/15lp9J5x1jyl1XBJp81sLcObkGIxPlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8760733a107so459604539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753088042; x=1753692842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFk0vnsOjVJJwB6fgeHJsp9xTOMyXJhFILgTfAKT/fE=;
        b=B2gERhB321P5jgHO3ueJM1+LEwC9D7iY3KKrPI88H54z2pIc/BRVpsMV+M1Xz+1/xj
         6Qzmbk4AhcZz/6l2g+lOcuc5KmqL3y801oBBmlcHw7K8F2VHFeYDDoqgqhZMp8qAxYVl
         ikhX1VsfhF7chNrtYMSM3SG0T8h78kyAWNFLYfgJH9QMtMVKpXd81O4VsCSawt4HY29S
         oYUkIuM/qdUgV2FP4w8pIippGeN+qibNSDJxLyO3AH7IYpzklgASOTxNpzXrrjpkbkp7
         +PJxvjD3eNUj2ZDxbm9gVvZaV3Emy+TnQvlIoyk1x/O4o40ArDXNcnMKjkYHIr+IWYdW
         Q0VA==
X-Forwarded-Encrypted: i=1; AJvYcCX70rlS77vKR3L5398ut4MPcaIOsS9FjRLNgVSVRKZXTMfFoV3eQ/iCOUim8MADCpcjbPOk5A2KGWcXr7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EA70YKnG0erfoGgbPdQeh4XFafjSkbQb+pRz/kIShygjhcmR
	brk+MqPU9jvuombPW/8u/3udfbf7FV61QxC6gAtDnF7QCvEqH9YjUHnec4tIDzwOhD2Xh8aZFtv
	WzVRG5o/LYIYh0RgFZo+EIv2+d5SFdbwUw0WWYlrn2vhE1upAFL96KpPnHWU=
X-Google-Smtp-Source: AGHT+IG6sZyPocFqjIMhPTCerDVbWmx3DykSB8XogAPhzQ6O6cPF21A7egBZJAb/OcK6TUE+MweKNdNC7IRb7HELtWVNEPRswzgA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c8a:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-87c0f046bf2mr1342401639f.6.1753088042497; Mon, 21 Jul 2025
 01:54:02 -0700 (PDT)
Date: Mon, 21 Jul 2025 01:54:02 -0700
In-Reply-To: <20250721073815.2673-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e002a.a70a0220.693ce.00e8.GAE@google.com>
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in
 devtmpfsd (3)
From: syzbot <syzbot+5583f599fe40b819b3e7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in worker_thread

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
 P5957/2:b.el

rcu: 	(detected by 0, t=10502 jiffies, g=18161, q=3025 ncpus=2)
task:kworker/1:5     state:R
  running task     stack:25704 pid:5957  tgid:5957  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: mld mld_dad_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6786
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7109
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:307
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_current arch/x86/include/asm/current.h:25 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:216
Code: 8b 3d 14 d3 fb 0b 48 89 de 5b e9 93 b9 58 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 08 80 a0 92 65 8b 15 f8 4e e0 10 81 e2 00 01 ff 00
RSP: 0018:ffffc90003f0f478 EFLAGS: 00000202

RAX: ffffffff8a3aff12 RBX: 1ffff920007e1e9c RCX: 0000000000000000
RDX: ffff88807d4cbc00 RSI: 0000000000000004 RDI: 0000000000000003
RBP: ffffc90003f0f5a0 R08: ffff88807d4cbc00 R09: 0000000000000004
R10: 0000000000000003 R11: ffffffff8a3afc80 R12: ffffc90003f0f660
R13: ffff888026b59dc0 R14: dffffc0000000000 R15: 0000000000000004
 ip6table_mangle_hook+0x292/0x6c0 net/ipv6/netfilter/ip6table_mangle.c:73
 nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook+0x217/0x380 include/linux/netfilter.h:272
 NF_HOOK_COND include/linux/netfilter.h:305 [inline]
 ip6_output+0x27d/0x3e0 net/ipv6/ip6_output.c:247
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:317
 mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1868
 mld_dad_work+0x45/0x520 net/ipv6/mcast.c:2308
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 3335 jiffies! g18161 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:27128 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2256
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 6854 Comm: syz.0.16 Not tainted 6.16.0-rc7-syzkaller-g89be9a83ccf1-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0xf69/0x12d0 kernel/smp.c:885
Code: 00 45 8b 2f 44 89 ee 83 e6 01 31 ff e8 c0 78 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 6b 74 0b 00 eb 37 f3 90 <43> 0f b6 04 2c 84 c0 75 10 41 f7 07 01 00 00 00 74 1e e8 50 74 0b
RSP: 0018:ffffc90003c47360 EFLAGS: 00000293

RAX: ffffffff81b4bcd0 RBX: ffff8880b863b1c0 RCX: ffff888029e95a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003c474c0 R08: ffffffff8fa1faf7 R09: 1ffffffff1f43f5e
R10: dffffc0000000000 R11: fffffbfff1f43f5f R12: 1ffff110170e7f5d
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880b873fae8
FS:  0000000000000000(0000) GS:ffff888125c18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce0d3ddd58 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x6b1/0x12c0 arch/x86/mm/tlb.c:1451
 tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:490 [inline]
 tlb_flush_mmu+0x1a7/0x680 mm/mmu_gather.c:403
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 free_ldt_pgtables+0x17b/0x320 arch/x86/kernel/ldt.c:411
 arch_exit_mmap arch/x86/include/asm/mmu_context.h:234 [inline]
 exit_mmap+0x17c/0xb50 mm/mmap.c:1270
 __mmput+0x118/0x420 kernel/fork.c:1121
 exit_mm+0x1da/0x2c0 kernel/exit.c:581
 do_exit+0x648/0x22e0 kernel/exit.c:952
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f982ed8e929
Code: Unable to access opcode bytes at 0x7f982ed8e8ff.
RSP: 002b:00007f982fbef0e8 EFLAGS: 00000246
 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f982efb6088 RCX: 00007f982ed8e929
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f982efb6088
RBP: 00007f982efb6080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f982efb608c
R13: 0000000000000000 R14: 00007ffc8d99a7a0 R15: 00007ffc8d99a888
 </TASK>


Tested on:

commit:         89be9a83 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150f7f98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=5583f599fe40b819b3e7
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155c338c580000


