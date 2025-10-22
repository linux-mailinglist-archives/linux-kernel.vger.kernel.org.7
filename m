Return-Path: <linux-kernel+bounces-864038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A60BF9C69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1553518C70BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAC203706;
	Wed, 22 Oct 2025 03:00:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF84CB5B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102034; cv=none; b=KbIIWB0qOgI5/ATZTz9V3duqXLGTiyIs8Vf4sf1IQxKnZ4yJMbse8Pt4kQ1evJfbyFeYtNYQc2W9cPcq2WMgqcgkixDW2wGc/hk6gfK1UwcvFo0baqq/cxtuXH4UmyOgvnoI1yqF/6xtDaaQ0LMvOeqZ6GUDVr0eUogV9xnR+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102034; c=relaxed/simple;
	bh=ZVe/HQnc/gL5fxgkQDVKnn4GvmHlVyOIfaL02gi+R74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hL/zXdmDymtnFqy+ow+5x5cw/PgbKR75L1coBDKZbAT7nK/W6HttnQ//RNMpIEzGSJUleyT2f2K9mvUnezXka4EC/KjBkVkaE3aWMgtKKmC/X4jWUQXXZzsHZDRVEd5jfvgTBFrWzUHiZcAWdf3wgFoIyswbFhhCL10J6np8hRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-430ca900e35so187502845ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761102031; x=1761706831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieAViPf1Cjp8Yvqm3V8jZXNAgEwXfb8cCWdBiX+2hF4=;
        b=b8uOrTXkFuNOuQREQ6YCMczhBpGPy2xQ8Gv3ApC3cRk7wpUu6gvhJQ2X2kYPFunB8F
         xGUK3Jxa3/zsQ4l9Zf8eVEzf7Rz1CP1LPnagaNsxhDGbC8Q/n7sl03w/xF1Pqi76e4fa
         vvEdSR008lMsLqU2AOZDqUrSuo4KQJ2Doo2ImiEVIOAYnRm8wdUayk7uPJ7wrqhHQsxi
         xkOHCFMr2wYd3UJDTZMOLK/Ge4F1OcOeqjNuq6U5xN5twzOtKNn5SBu+mrKsEt36GbRD
         xedKgY0L9GmkSQgsl0Gj8eEyNOADwOq9G0qqfn/nWbHpo34o8cwVLxP/6fgYSd+P5w7P
         Q0DA==
X-Forwarded-Encrypted: i=1; AJvYcCX8kpE6PS8h7eT2cRAI9jYmCYtRrwk4SD+0mpnTx07rYwKO3mOk5KUVGDHbCRMNDKctoENlRooJ26WMhEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgtHFxhA1KTJhfKcayOJw5J8S8vSSyylOX+flpy/D/HlCKZZl
	YhwBYfhIyf+emAROLm23t0Kt9/sfUfxePtnkRo7QV2KpKsB6jUMeSJClcyFvCZ5zeKSdjIw7G4E
	sQaLW3BirN9qKADMtetub3AS3i1w7jrtUnOgLA3UTdTSBOpudyy9RQxgKYbE=
X-Google-Smtp-Source: AGHT+IGKMts0+aawtOa6cO6m6ONnPPPam6chhEtV+f5xZz2dI8X/Gi6Bp21k+KffzXFdsNr5Pj4lPO9atnDtOWSB8OKGTmESnGk8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2506:b0:430:ad76:a5d3 with SMTP id
 e9e14a558f8ab-430c522d94dmr300290875ab.11.1761102031674; Tue, 21 Oct 2025
 20:00:31 -0700 (PDT)
Date: Tue, 21 Oct 2025 20:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f848cf.a70a0220.3bf6c6.000e.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in shmem_file_write_iter (3)
From: syzbot <syzbot+f172d48953db0cf91855@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f406055cb18c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123fede2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f172d48953db0cf91855
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37fd0378c30b/disk-f406055c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f26ca5f11670/vmlinux-f406055c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/145dd878db42/bzImage-f406055c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f172d48953db0cf91855@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P9351/3:b..l P5822/1:b..l P9346/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=30189, q=343 ncpus=2)
task:syz.4.823       state:R  running task     stack:25608 pid:9346  tgid:9345  ppid:5831   task_flags:0x400040 flags:0x00080001
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7256
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:211
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 fb bc f3 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc900188bef98 EFLAGS: 00000206
RAX: 8c7b37c73e5bc200 RBX: 0000000000000000 RCX: 8c7b37c73e5bc200
RDX: 0000000000000000 RSI: ffffffff8d9d1f00 RDI: ffffffff8bc07de0
RBP: ffffffff8173cd25 R08: 0000000000000000 R09: ffffffff8173cd25
R10: dffffc0000000000 R11: ffffffff81ac6cd0 R12: 0000000000000002
R13: ffffffff8e13d2e0 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf5/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x8d/0x4a0 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2435
 shmem_alloc_folio mm/shmem.c:1871 [inline]
 shmem_alloc_and_add_folio+0x447/0xf60 mm/shmem.c:1910
 shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2533
 shmem_get_folio mm/shmem.c:2639 [inline]
 shmem_write_begin+0xf7/0x2b0 mm/shmem.c:3289
 generic_perform_write+0x2c5/0x900 mm/filemap.c:4242
 shmem_file_write_iter+0xf8/0x120 mm/shmem.c:3464
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32a238da7f
RSP: 002b:00007f32a31d6df0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007f32a238da7f
RDX: 0000000001000000 RSI: 00007f3298000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000004431
R10: 0000000000000002 R11: 0000000000000293 R12: 0000000000000003
R13: 00007f32a31d6ef0 R14: 00007f32a31d6eb0 R15: 00007f3298000000
 </TASK>
task:syz-executor    state:R  running task     stack:20904 pid:5822  tgid:5822  ppid:5817   task_flags:0x400140 flags:0x00080001
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 preempt_schedule_common+0x83/0xd0 kernel/sched/core.c:7113
 preempt_schedule+0xae/0xc0 kernel/sched/core.c:7137
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3f/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 copy_pte_range mm/memory.c:1329 [inline]
 copy_pmd_range+0x7630/0x7f00 mm/memory.c:1389
 copy_pud_range mm/memory.c:1426 [inline]
 copy_p4d_range mm/memory.c:1450 [inline]
 copy_page_range+0xc14/0x1270 mm/memory.c:1538
 dup_mmap+0xf4c/0x1b10 mm/mmap.c:1834
 dup_mm kernel/fork.c:1489 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1541
 copy_process+0x1706/0x3c00 kernel/fork.c:2181
 kernel_clone+0x21e/0x840 kernel/fork.c:2609
 __do_sys_clone kernel/fork.c:2750 [inline]
 __se_sys_clone kernel/fork.c:2734 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07d7f85713
RSP: 002b:00007ffca17e20f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f07d7f85713
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 0000555592a5e7d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 00000000000495e1 R15: 00007ffca17e2290
 </TASK>
task:syz.0.826       state:R  running task     stack:25624 pid:9351  tgid:9348  ppid:5832   task_flags:0x400040 flags:0x00080001
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 preempt_schedule_common+0x83/0xd0 kernel/sched/core.c:7113
 preempt_schedule+0xae/0xc0 kernel/sched/core.c:7137
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3f/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 filemap_map_pages+0x1621/0x1c60 mm/filemap.c:3858
 do_fault_around mm/memory.c:5656 [inline]
 do_read_fault mm/memory.c:5689 [inline]
 do_fault mm/memory.c:5832 [inline]
 do_pte_missing mm/memory.c:4361 [inline]
 handle_pte_fault mm/memory.c:6177 [inline]
 __handle_mm_fault+0x347e/0x5400 mm/memory.c:6318
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6487
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x165c/0x2a00 mm/gup.c:1428
 populate_vma_page_range+0x29f/0x3a0 mm/gup.c:1860
 __mm_populate+0x24c/0x380 mm/gup.c:1963
 mm_populate include/linux/mm.h:3471 [inline]
 vm_mmap_pgoff+0x387/0x4d0 mm/util.c:586
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa11f8efc9
RSP: 002b:00007faa12e69038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007faa121e6090 RCX: 00007faa11f8efc9
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 00007faa12011f91 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faa121e6128 R14: 00007faa121e6090 R15: 00007ffc1db85d48
 </TASK>
rcu: rcu_preempt kthread starved for 10330 jiffies! g30189 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27288 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 5e c3 c3 f5 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 b1 1b 00 f3 0f 1e fa fb f4 <e9> 33 c3 c3 f5 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 82b01eb804bc8c00 RBX: ffffffff8196bc07 RCX: 82b01eb804bc8c00
RDX: 0000000000000001 RSI: ffffffff8d7e8bf1 RDI: ffffffff8bc07de0
RBP: ffffc90000197f10 R08: ffff8880b8732fdb R09: 1ffff110170e65fb
R10: dffffc0000000000 R11: ffffed10170e65fc R12: ffffffff8f9e1e70
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff110038d5b58
FS:  0000000000000000(0000) GS:ffff888125e0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6547b7915e CR3: 00000000306ab000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e7/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
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

