Return-Path: <linux-kernel+bounces-699510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F225AE5B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 06:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C652F1BC0764
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B122259F;
	Tue, 24 Jun 2025 04:41:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42721DEFE6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750740090; cv=none; b=NiXDuiXVYfPSxvTBfI9zPSvD2GpHJVJH6LXzuT5L5gNjFbeyzEwu+z2fGICaySZWI0CUgnyVCbjpMwZhcKasLMc1w8i0m+bfCKTvkPPtJG7KGVa/6Jh4fdptWRy+numZs5WaVzLOIh5LnlPi5PnaWXK5duwgfaBAU6ZgCfsdXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750740090; c=relaxed/simple;
	bh=xSvv7ONdwRboDamFp2JY0Ol8TyfdkyjJs7vAbMZxWPI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CZTssk/yQaF+aEUFdlYingfHQdU7C16GGHSiXgAxuaIJ7eFocisY4IjEdpqRwy/E+wRBLW8aur7FpuXyi7mm123QpeHM5W9vJHkp2/4FjuFtdtOAeE6/9AhJmEUukWUBEyqd6QTnPW9u4KLiwXTS4nVF4OilACz12zKkKxJ1FAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso1471315ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 21:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750740088; x=1751344888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yenC/9GMSwdzBIwsasF1ah4y2F84abcjifv3wJaXSR4=;
        b=B4C7ObPn/YmnuVwN3m8g9iSx9IfBgvGyZNesUwYXG6iLtTr2faHBooiV9GkiZjXToh
         Fw5t+bXF3YsE8Czv8Fw2ACOmM9xrE5HixcJQ1bT2pP8v5YyItJGyeNuSEN4Tf/5li/8H
         6ku9tj4KuR8rUUv3mA9tOBilaQsuJLbn+/k+6gmtHjC5rJMc5ZJljSGtdlUUO8jjOqEv
         vF5vE1rOc/6S8qxE9rGqXektDzKc9jdjg7DGgUMqrgFQeay80t8RcJfD+6Gg20UfPGMt
         pq0e6mZl71yQtrpnHeHARhEK9rytI5BYf2mYZzqh9cIyYcPB4eKLUEjuj1tsRFgj/tIX
         Bo0w==
X-Forwarded-Encrypted: i=1; AJvYcCVJhRsqXVHkEiRypFe7zyb7we0ZY82xfk5Co2t27A4F3BKDyKTcbbOGbe7WS1j1H4EJhfnbSDgH8Suaekk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0VySsoGmoJd1ypNwQHqkoWW0cJMp92S2k7+hJR71lf7prAPU
	TLJccX0J4lqCqibvX4F+2iSog713dOgI3q0iKGd1uzu17BoQ/Df/mG3fAHyc9CjNDP7C5vCx0o6
	3SHX7yDpzsVpaQD8NFQQAKFOoA1IWdLHRnPXS2x6rMu5Pig+fK0Wx8tNjovM=
X-Google-Smtp-Source: AGHT+IETLjeI/x8GwhUVFXFmfmPQHqPDpYi1GGTA+t9fdtaMjicjJgVaHVeU3qHPXdbsIoFk4Oq2wWnhk84fuHUA8K3vF6i+SvhD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:3dd:fad4:7c61 with SMTP id
 e9e14a558f8ab-3de38c5eed6mr178893695ab.8.1750740087937; Mon, 23 Jun 2025
 21:41:27 -0700 (PDT)
Date: Mon, 23 Jun 2025 21:41:27 -0700
In-Reply-To: <68251338.a00a0220.104b28.0015.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685a2c77.a00a0220.2e5631.0054.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in vms_gather_munmap_vmas
From: syzbot <syzbot+701fc0fcde2b68c4bf59@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pasha.tatashin@soleen.com, pfalcato@suse.de, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    86731a2a651e Linux 6.16-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c41b0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
dashboard link: https://syzkaller.appspot.com/bug?extid=701fc0fcde2b68c4bf59
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e5e182580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4323a61a1fcd/disk-86731a2a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/646a4fb19be1/vmlinux-86731a2a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4235bfd16a36/bzImage-86731a2a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+701fc0fcde2b68c4bf59@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=095c/1/0x4000000000000000 softirq=18291/18292 fqs=1
rcu: 	(detected by 1, t=10504 jiffies, g=11509, q=2130 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6072 Comm: modprobe Not tainted 6.16.0-rc3-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__lock_acquire+0x80c/0xd20 kernel/locking/lockdep.c:-1
Code: d2 e9 c4 00 00 00 48 c7 c7 70 02 01 8e 48 89 de e8 39 98 51 03 eb c2 44 89 e0 25 ff 1f 00 00 41 c1 ec 03 41 81 e4 00 60 00 00 <41> 09 c4 4c 89 f9 48 c1 e9 20 89 ca c1 c2 04 41 29 cc 44 31 e2 44
RSP: 0018:ffffc90000007b30 EFLAGS: 00000046
RAX: 000000000000090a RBX: 0000000000000001 RCX: ffffffffffffffff
RDX: 00000000ffffc000 RSI: ffff88802f5fc718 RDI: ffff88802f5fbc00
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff897ed7f4
R10: dffffc0000000000 R11: ffffffff897ed730 R12: 0000000000000000
R13: ffff88802f5fc6f0 R14: ffff88802f5fc718 R15: ffffffffffffffff
FS:  0000000000000000(0000) GS:ffff888125c85000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5919b74e8 CR3: 0000000073704000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xc4/0xc90 net/sched/sch_taprio.c:924
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x529/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:26 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:109 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:127 [inline]
RIP: 0010:lock_acquire+0xcd/0x360 kernel/locking/lockdep.c:5867
Code: 0f 85 eb 00 00 00 65 48 8b 04 25 08 b0 99 92 83 b8 ec 0a 00 00 00 0f 85 d5 00 00 00 48 c7 44 24 30 00 00 00 00 9c 8f 44 24 30 <4c> 89 74 24 10 4d 89 fe 4c 8b 7c 24 30 fa 48 c7 c7 f0 21 98 8d e8
RSP: 0018:ffffc90003abecd8 EFLAGS: 00000246
RAX: ffff88802f5fbc00 RBX: 0000000000000000 RCX: 48d8de1ae89d0f00
RDX: 0000000000000000 RSI: ffffffff81728b12 RDI: 1ffffffff1c27dcc
RBP: ffffffff81728af5 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90003abee98 R11: ffffffff81ace5b0 R12: 0000000000000002
R13: ffffffff8e13ee60 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 kmem_cache_alloc_bulk_noprof+0x4e0/0x790 mm/slub.c:5374
 mt_alloc_bulk lib/maple_tree.c:181 [inline]
 mas_alloc_nodes+0x447/0x8e0 lib/maple_tree.c:1271
 mas_node_count_gfp lib/maple_tree.c:1331 [inline]
 mas_preallocate+0x39e/0x6b0 lib/maple_tree.c:5532
 vma_iter_prealloc mm/vma.h:463 [inline]
 __split_vma+0x2fa/0xa00 mm/vma.c:525
 vms_gather_munmap_vmas+0x4ab/0x12b0 mm/vma.c:1375
 __mmap_prepare mm/vma.c:2351 [inline]
 __mmap_region mm/vma.c:2607 [inline]
 mmap_region+0x678/0x1f30 mm/vma.c:2692
 do_mmap+0xc45/0x10d0 mm/mmap.c:561
 vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd5919e8242
Code: 08 00 04 00 00 eb e2 90 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 33 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e 5b 5d c3 0f 1f 00 c7 05 46 40 01 00 16 00
RSP: 002b:00007ffc896f1078 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fd591742000 RCX: 00007fd5919e8242
RDX: 0000000000000005 RSI: 000000000014e000 RDI: 00007fd591742000
RBP: 0000000000000812 R08: 0000000000000000 R09: 0000000000028000
R10: 0000000000000812 R11: 0000000000000206 R12: 00007ffc896f10c8
R13: 00007fd5919bc5f0 R14: 00007ffc896f18b0 R15: 00000fff912de212
 </TASK>
rcu: rcu_preempt kthread starved for 10500 jiffies! g11509 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27128 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2256
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 5190 Comm: udevd Not tainted 6.16.0-rc3-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0xf69/0x12d0 kernel/smp.c:885
Code: 00 45 8b 2f 44 89 ee 83 e6 01 31 ff e8 60 78 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 0b 74 0b 00 eb 37 f3 90 <43> 0f b6 04 2c 84 c0 75 10 41 f7 07 01 00 00 00 74 1e e8 f0 73 0b
RSP: 0018:ffffc900030a7580 EFLAGS: 00000293
RAX: ffffffff81b4d830 RBX: ffff8880b873b040 RCX: ffff88807c598000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900030a76e0 R08: ffffffff8f9fe0f7 R09: 1ffffffff1f3fc1e
R10: dffffc0000000000 R11: fffffbfff1f3fc1f R12: 1ffff110170c835d
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880b8641ae8
FS:  00007f8df5585880(0000) GS:ffff888125d85000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e81504cef0 CR3: 000000007c958000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x6b1/0x12c0 arch/x86/mm/tlb.c:1451
 dup_mmap+0x15a0/0x1ac0 mm/mmap.c:1877
 dup_mm kernel/fork.c:1477 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1529
 copy_process+0x1706/0x3c00 kernel/fork.c:2169
 kernel_clone+0x224/0x7f0 kernel/fork.c:2599
 __do_sys_clone kernel/fork.c:2742 [inline]
 __se_sys_clone kernel/fork.c:2726 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2726
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8df4ef1636
Code: 89 df e8 6d e8 f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffffac3e030 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffffac3e038 RCX: 00007f8df4ef1636
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 000055e814eac910 R08: 0000000000000000 R09: 000055e814eb4890
R10: 00007f8df5585b50 R11: 0000000000000246 R12: 00007ffffac3e3f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

