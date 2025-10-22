Return-Path: <linux-kernel+bounces-864249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB6BFA46C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9375D5672A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664F224AEF;
	Wed, 22 Oct 2025 06:43:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2725784B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115387; cv=none; b=Iwi7PoyGLLcqrSPMu4yHavVeKZMy+xi1NIHl/pKUUGzReTExgxeBS7He5x1ipIoxemeYAJoAZu5iAO3aC1X2+CDTX/9OI/tDk2VZJq9jA9SXeOmzYhzqU68KNLkqfutm9860KMgbIG3DyS6SECyESwaex9jrjdq/AKCuCYIwDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115387; c=relaxed/simple;
	bh=Cs5uRKcLH36bbZtjClNr6B5h4TcTOC28qet7ItDs7WQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QOwz0Muc4CLyxfAj3R7mebkvQOwFx2Fpa2Z08kyAD+KPyCK8zQlx8lrLzwARjfO65wx4SNmZelp/TQsCXm3p5Ys3W3fxEhBZxk25BtAHeGTqPWIp53eQQSkHKKhbo7b/vWCo2Vs61wXmXSoJLEHh0FmuYM+wv6YpeJ8XmGpH/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d777219bso325745ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115383; x=1761720183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6F1d1KJBdRl2XtToXUNHa3Gv0JycQx1EF9vGALo/ig=;
        b=f+s+1MIrsOEvX6wFCe7mromGgUQoKZZOBySs4QIa/n4z1QZ4GdDJM5EXhIjjupwKlQ
         hjp8Ra+IEs1iQpJm2uMl9+9kO4bp4BN9zRAUW8fYSLCvOoV9nOrz6fuQghJzh1cTMegY
         u2It9FgzKaKt6kuJ572eR8IN/y2/1OT9WVssgolvfk1q3qw2Y6rL2Uf8Zexp6DmvaD9P
         2SNUS9pRdia58G8QtsNvn5uSEurtnnBKbttkKlY6PEmkOnlxhFKgjCTuYdnY/afS41YN
         AlekLzJsnkrWMscpRzTSwgx4YhSUD2Rqf9l1N1PYUKGt+PU3LHLD9oSYabqLoQcAn0U5
         WZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigEeSUoFRXWixTxwG8lVraPppAO6XJw+sY2KThDUJJc5bDn9KdDtDCsCW1zsBnnTUYTetsIcuGprdQOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/PC1IJtzVVdnbBmAJV6qK0/I6/byt401ny6fKDV2DdVh8PQX
	BwyO5mRUCId0DQHEfj1ZSgyOCUCFgFzCbKGsyIIpTPUcPSY0/N2ReVNt65OKc2V8bj6Ars/Fhj5
	z7A9nYzgeXLPxEXZZMrRRun61GhXiLQv5iqOMiauWUP6302VNDiOznbCvso4=
X-Google-Smtp-Source: AGHT+IGW9LZQWs4mpsCrOiVroU1bT9Gjv5AIOTHEnDUygGJmrdZ6PKnVYAQYuZExj1EENZBYQSSupY1mYll+E/EG/OHJOSa6vPf7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:430:ab63:69d6 with SMTP id
 e9e14a558f8ab-430c527dc00mr249329975ab.21.1761115383298; Tue, 21 Oct 2025
 23:43:03 -0700 (PDT)
Date: Tue, 21 Oct 2025 23:43:03 -0700
In-Reply-To: <20251022060120.15257-1-ankitkhushwaha.linux@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f87cf7.050a0220.346f24.0038.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: rcu detected stall in ext4_file_mmap_prepare
From: syzbot <syzbot+fc241a3fa60015afb3d1@syzkaller.appspotmail.com>
To: ankitkhushwaha.linux@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in NF_HOOK

sched: DL replenish lagged too much
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=0e34/1/0x4000000000000000 softirq=20725/20726 fqs=298
rcu: 	(detected by 1, t=10505 jiffies, g=15545, q=130 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:mark_usage kernel/locking/lockdep.c:4628 [inline]
RIP: 0010:__lock_acquire+0x606/0xd20 kernel/locking/lockdep.c:5191
Code: e3 51 df 0d 00 0f 84 1a 05 00 00 83 7c 24 0c 00 0f 84 a9 00 00 00 41 8b 46 20 66 85 c0 0f 88 8d 00 00 00 65 8b 0d 26 0f cf 10 <a9> 00 00 03 00 74 38 85 c9 74 1d 48 8b 3c 24 4c 89 f6 ba 01 00 00
RSP: 0018:ffffc900000060d0 EFLAGS: 00000006
RAX: 00000000000c6000 RBX: 000000000000000a RCX: 0000000000000001
RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffff8881416f9e40
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8493a78a
R10: ffffc900000062b0 R11: fffff52000000c58 R12: 0000000000000002
R13: 0000000000000002 R14: ffff8881416fab00 R15: ffff8881416fab20
FS:  0000000000000000(0000) GS:ffff888125f5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9479fc5f98 CR3: 0000000075ecc000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 debug_object_deactivate+0x9a/0x250 lib/debugobjects.c:873
 debug_hrtimer_deactivate kernel/time/hrtimer.c:443 [inline]
 debug_deactivate+0x1d/0x200 kernel/time/hrtimer.c:483
 __run_hrtimer kernel/time/hrtimer.c:1745 [inline]
 __hrtimer_run_queues+0x2b0/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1052
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:ip6_ignore_linkdown include/net/addrconf.h:448 [inline]
RIP: 0010:find_match+0x13b/0xc90 net/ipv6/route.c:780
Code: 00 fc ff df 48 85 db 0f 84 12 0a 00 00 48 81 c3 58 06 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 3f 0a 00 00 8b 1b <31> ff 89 de e8 7c 4f c4 f7 85 db 74 45 e8 33 4b c4 f7 43 0f b6 04
RSP: 0018:ffffc900000066c0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8881416f9e40
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff110081da099 R08: ffffc900000069c0 R09: ffffc900000069d0
R10: ffffc90000006820 R11: fffff52000000d06 R12: dffffc0000000000
R13: 0000000000000003 R14: 1ffff110081da09b R15: ffff888040ed04df
 __find_rr_leaf+0x23a/0x6d0 net/ipv6/route.c:868
 find_rr_leaf net/ipv6/route.c:889 [inline]
 rt6_select net/ipv6/route.c:933 [inline]
 fib6_table_lookup+0x39f/0xa80 net/ipv6/route.c:2233
 ip6_pol_route+0x222/0x1180 net/ipv6/route.c:2269
 pol_lookup_func include/net/ip6_fib.h:617 [inline]
 fib6_rule_lookup+0x52f/0x6f0 net/ipv6/fib6_rules.c:120
 ip6_route_input_lookup net/ipv6/route.c:2338 [inline]
 ip6_route_input+0x6de/0xad0 net/ipv6/route.c:2641
 ip6_rcv_finish+0x141/0x2e0 net/ipv6/ip6_input.c:77
 ip_sabotage_in+0x1e1/0x270 net/bridge/br_netfilter_hooks.c:990
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x206/0x3a0 include/linux/netfilter.h:316
 __netif_receive_skb_one_core net/core/dev.c:6126 [inline]
 __netif_receive_skb+0xd3/0x380 net/core/dev.c:6239
 netif_receive_skb_internal net/core/dev.c:6325 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6384
 NF_HOOK+0xa0/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh+0x3c6/0x4a0 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x999/0xd60 net/bridge/br_netfilter_ipv6.c:-1
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x37e/0x6b0 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x982/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:6013
 __netif_receive_skb_one_core net/core/dev.c:6124 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6239
 process_backlog+0x60e/0x14f0 net/core/dev.c:6591
 __napi_poll+0xc7/0x360 net/core/dev.c:7641
 napi_poll net/core/dev.c:7704 [inline]
 net_rx_action+0x5f7/0xdf0 net/core/dev.c:7831
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 do_softirq+0xec/0x180 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:936 [inline]
 __dev_queue_xmit+0x1bfb/0x3740 net/core/dev.c:4837
 neigh_output include/net/neighbour.h:547 [inline]
 ip6_finish_output2+0xfb3/0x1480 net/ipv6/ip6_output.c:136
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xbce/0x1510 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xcb/0x150 net/ipv6/ndisc.c:670
 addrconf_dad_work+0xaae/0x14b0 net/ipv6/addrconf.c:4282
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 9015 jiffies! g15545 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27128 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5254 [inline]
 __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
 __schedule_loop kernel/sched/core.c:6944 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6959
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 6326 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xd33/0x12d0 kernel/smp.c:877
Code: 45 8b 2c 24 44 89 ee 83 e6 01 31 ff e8 56 70 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 01 6c 0b 00 eb 38 f3 90 <42> 0f b6 04 2b 84 c0 75 11 41 f7 04 24 01 00 00 00 74 1e e8 e5 6b
RSP: 0018:ffffc90003457340 EFLAGS: 00000293
RAX: ffffffff81b4709b RBX: 1ffff110170c8439 RCX: ffff88807dd58000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900034574c0 R08: ffffffff8f7c9f77 R09: 1ffffffff1ef93ee
R10: dffffc0000000000 R11: fffffbfff1ef93ef R12: ffff8880b86421c8
R13: dffffc0000000000 R14: ffff8880b873b1c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88812605b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000600 CR3: 000000000dd38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1043
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1381 [inline]
 flush_tlb_mm_range+0x6b1/0x12d0 arch/x86/mm/tlb.c:1471
 tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:490 [inline]
 tlb_flush_mmu+0x1a7/0x680 mm/mmu_gather.c:403
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 free_ldt_pgtables+0x17b/0x320 arch/x86/kernel/ldt.c:411
 arch_exit_mmap arch/x86/include/asm/mmu_context.h:234 [inline]
 exit_mmap+0x174/0xb40 mm/mmap.c:1263
 __mmput+0x118/0x430 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9479184dd3
Code: Unable to access opcode bytes at 0x7f9479184da9.
RSP: 002b:00007ffee8c31198 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 00000000000018b9 RCX: 00007f9479184dd3
RDX: 0000000040000000 RSI: 00007ffee8c311ac RDI: 00000000ffffffff
RBP: 00007ffee8c311ac R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffee8c31230
R13: 00007ffee8c31238 R14: 0000000000000009 R15: 0000000000000000
 </TASK>


Tested on:

commit:         aaa9c355 Add linux-next specific files for 20251022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141353e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4db31502c80669bd
dashboard link: https://syzkaller.appspot.com/bug?extid=fc241a3fa60015afb3d1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c77c58580000


