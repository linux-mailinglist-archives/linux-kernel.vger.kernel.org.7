Return-Path: <linux-kernel+bounces-781088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5FB30D73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B9E1CC8722
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0B28CF47;
	Fri, 22 Aug 2025 04:15:42 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BC72623
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836141; cv=none; b=i5mYVAUoV31z4uVNqPsRVIOkxPQDSBcWyhGpcB8NZcLHi9Z7unJmGeo6xCpU+ClVdfoeVudufbsz/sbjXB97sFGAUK23xoGpMrspVOyn4BmvwJO5jq5gtHMrw2lnKBVzgVTVICJ9mP6MAODYaxgOAgULgTSo2+oE9CkDJ8J7DSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836141; c=relaxed/simple;
	bh=uKruYYyOFQwGB7jerIDtbk4zLS2dfbbI/FW7fvLQlWk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nr4UBe0/VHLtxmQlYR0Bv+aAM1YEjv9flZOmMGAiPSAQs6zHRiagMFoHiDUbFLzijDnhXc+geQMN5PGOXfkELIqbt6NlSEysS1Y193BQve8s2Ax46AHwxQ13MH19ilEMmKEdMdvB45oSTvCTElj/UPka2Xp1L56u5eFGGI/xkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432e1ea71so415721939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836137; x=1756440937;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sooom7ibB6unsgJsOQuQIZ+XDG9A4vkYGL93HbGK11g=;
        b=BUvhj4Ur86X6vlGq+BzGz7BuNaiAFW7VVAFUCUtp+eJNp12A9MxUr3UDdnm+1lApP4
         Bkx9Z2nvite8NWdBfDg3SzJL7Nw12l2ddzHDoytpJHl9SadGwl1w5PSWigHynwtUDEW6
         Bgic66d+KNxgBNV9Kvg8hiuzFx57zZewtSiGFzo1fC7Xe1zSJ7fuqb7S2f4elglqDNnx
         OVuxtGZNXi6yXomSrnhn3W5gVdUbcjbGCVve4uC/6yyYD0PvpqQHI81WLWMQflD9lq66
         K8gDVuUt73jgCoB7KX1qZXVCszEx2aNGmghX2gPlzYtuKlGMWhYnqZbDDBZlrZcetF7U
         CTQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Hts92CYz9IrQIZknDVyzMJ/gIhQlLM99TIhQ8dcPeMGIdTntoipZK0wsvg8jyJ9WxoT09rZ4E+OZjSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdsjmWw/25W5NnkhAdHjD56I5VK29YOdTAyAV4/HxNWho7q4I
	7BRGrL2vWZ6Nc1cmxpQahkqJshzaCvOvMtN1pZQJAFFXY1/f7amoBhAse6zwmbSyupd81ok/jqe
	9qWH/vzKrnacyC/5C9DQL0f+bNrlZgCelbPWf48WukmaDgmIyF6gpyukHk1M=
X-Google-Smtp-Source: AGHT+IFLt8oqegHL1llaZsphwgFhR/m3ZmVVOqcSlwLrRY9am2eDr3bHXwav1B9UaCHpDJqGAZ07P9ENGR7R6XP1azYIwak5JhI+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:3e5:3ef0:b0e5 with SMTP id
 e9e14a558f8ab-3e9201f3b84mr31115545ab.7.1755836137084; Thu, 21 Aug 2025
 21:15:37 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:15:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7eee9.a00a0220.33401d.0168.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_munmap (2)
From: syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136dfba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=142508fb116c212f
dashboard link: https://syzkaller.appspot.com/bug?extid=8785aaf121cfb2141e0d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107a43bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24fd400c6842/disk-be48bcf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59146305635d/vmlinux-be48bcf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3e5f65cbcc8/bzImage-be48bcf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6029/1:b..l P1208/1:b..l P6031/3:b..l P6030/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=6285, q=421 ncpus=2)
task:dhcpcd          state:R  running task     stack:28896 pid:6030  tgid:6030  ppid:5513   task_flags:0x400040 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:unwind_next_frame+0xfe7/0x20a0 arch/x86/kernel/unwind_orc.c:664
Code: 85 80 0c 00 00 49 89 6d 40 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 56 10 00 00 <41> 39 5d 00 0f 84 10 06 00 00 bd 01 00 00 00 e9 de f3 ff ff 48 b8
RSP: 0018:ffffc90003cdf6a8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90003ce0000
RDX: 1ffff9200079bee3 RSI: ffffc90003cdfa70 RDI: ffffc90003cdf758
RBP: ffffc90003cdfae0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc90003cdf718 R11: 00000000000121e6 R12: ffffc90003cdf768
R13: ffffc90003cdf718 R14: ffffc90003cdfa80 R15: ffffc90003cdf74c
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 slab_free_hook mm/slub.c:2378 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x15a/0x4d0 mm/slub.c:4782
 vms_complete_munmap_vmas+0x573/0x970 mm/vma.c:1293
 do_vmi_align_munmap+0x43b/0x7d0 mm/vma.c:1536
 do_vmi_munmap+0x204/0x3e0 mm/vma.c:1584
 __vm_munmap+0x19a/0x390 mm/vma.c:3155
 __do_sys_munmap mm/mmap.c:1080 [inline]
 __se_sys_munmap mm/mmap.c:1077 [inline]
 __x64_sys_munmap+0x59/0x80 mm/mmap.c:1077
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb13ec2f2e7
RSP: 002b:00007fffe10fae78 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000562bd1443510 RCX: 00007fb13ec2f2e7
RDX: 0000000000000002 RSI: 0000000000004028 RDI: 00007fb13ea1b000
RBP: 00007fffe10faf80 R08: 0000562bd1432470 R09: 0000000000000001
R10: 00007fffe10fadb0 R11: 0000000000000206 R12: 00007fffe10faea0
R13: 00007fb13ec42000 R14: 0000562bd1443510 R15: 0000000000000000
 </TASK>
task:syz-executor    state:R  running task     stack:27632 pid:6031  tgid:6031  ppid:5870   task_flags:0x400000 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:7145
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 filemap_map_pages+0xe15/0x1670 mm/filemap.c:3791
 do_fault_around mm/memory.c:5531 [inline]
 do_read_fault mm/memory.c:5564 [inline]
 do_fault mm/memory.c:5707 [inline]
 do_pte_missing+0xe39/0x3ba0 mm/memory.c:4234
 handle_pte_fault mm/memory.c:6052 [inline]
 __handle_mm_fault+0x152a/0x2a50 mm/memory.c:6195
 handle_mm_fault+0x589/0xd10 mm/memory.c:6364
 do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f54cd7177c7
RSP: 002b:00007fffb79a5b40 EFLAGS: 00010246
RAX: 00007f54ce525000 RBX: 0000000000000000 RCX: 0000000000000064
RDX: 00007fffb79a5de9 RSI: 0000000000000002 RDI: 00007fffb79a5dd8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 00007fffb79a5c48 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:kworker/0:3     state:R  running task     stack:25368 pid:1208  tgid:1208  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events_power_efficient gc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:write_comp_data+0x0/0x90 kernel/kcov.c:240
Code: 48 8b 05 db b4 1a 12 48 8b 80 30 16 00 00 e9 97 05 db 09 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <49> 89 d2 49 89 f8 49 89 f1 65 48 8b 15 a7 b4 1a 12 65 8b 05 b8 b4
RSP: 0018:ffffc9000441fb50 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000040000 RCX: ffffffff89ba2a52
RDX: 0000000000040000 RSI: 0000000000000433 RDI: 0000000000000004
RBP: ffffffff9b2c41ec R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff9b030610 R12: ffff888031800000
R13: 0000000000000433 R14: dffffc0000000000 R15: 0000000000001770
 gc_worker+0x342/0x16e0 net/netfilter/nf_conntrack_core.c:1549
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:dhcpcd          state:R  running task     stack:26072 pid:6029  tgid:6029  ppid:5513   task_flags:0x400040 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x7e/0xf0 arch/x86/kernel/unwind_orc.c:102
Code: ea 3f 48 c1 fe 02 48 01 f2 48 d1 fa 48 8d 5c 95 00 48 89 da 48 c1 ea 03 0f b6 34 0a 48 89 da 83 e2 07 83 c2 03 40 38 f2 7c 05 <40> 84 f6 75 4b 48 63 13 48 01 da 49 39 d5 73 af 4c 8d 63 fc 49 39
RSP: 0018:ffffc90003337648 EFLAGS: 00000202
RAX: ffffffff914e0dd8 RBX: ffffffff90c5215c RCX: dffffc0000000000
RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffffffff90c52148
RBP: ffffffff90c52148 R08: ffffffff914e0e1a R09: 0000000000000000
R10: ffffc900033376f8 R11: 0000000000011271 R12: ffffffff90c52170
R13: ffffffff82127173 R14: ffffffff90c52148 R15: ffffffff90c52148
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x2ec/0x20a0 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2369 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x142/0x4d0 mm/slub.c:4782
 vms_complete_munmap_vmas+0x573/0x970 mm/vma.c:1293
 do_vmi_align_munmap+0x43b/0x7d0 mm/vma.c:1536
 do_vmi_munmap+0x204/0x3e0 mm/vma.c:1584
 __vm_munmap+0x19a/0x390 mm/vma.c:3155
 __do_sys_munmap mm/mmap.c:1080 [inline]
 __se_sys_munmap mm/mmap.c:1077 [inline]
 __x64_sys_munmap+0x59/0x80 mm/mmap.c:1077
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb13ec2f2e7
RSP: 002b:00007fffe10fae78 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000562bd1443f00 RCX: 00007fb13ec2f2e7
RDX: 0000000000000001 RSI: 000000000002f6d0 RDI: 00007fb13e9c1000
RBP: 00007fffe10faf80 R08: 00000000000004f0 R09: 0000000000000002
R10: 00007fffe10fadb0 R11: 0000000000000202 R12: 00007fffe10faec0
R13: 00007fb13ec42000 R14: 0000562bd1443f00 R15: 0000000000000000
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

