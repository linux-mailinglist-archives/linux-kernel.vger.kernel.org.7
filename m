Return-Path: <linux-kernel+bounces-738612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99525B0BB04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EAB189564A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305B1C3C14;
	Mon, 21 Jul 2025 02:53:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A71632DF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066388; cv=none; b=K3vgL6SY1zOezFMFVCNYH5eR01q3fzDtzxu7xaLW3TsWXvjzRBO7iapvMGEUsVpaofE4/PfYkSxwm1q8m6HfqLNq7lM7B+F2UScTWX9UB4xAhnq4Nfw2ApkfMoImjTKcYIDHZuTpKvYkheXik2WatuIHWo2cMt43I2VPSPSFDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066388; c=relaxed/simple;
	bh=S02ZbZHXIWQ/XQ0AvZvndXOWOqPJ90nnaCVZqqX9kC4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h3hDu1jvJkFlrx+HF/8BZG01z59bGhyYVrVVj8/1jKQgqEXjimeUNoLNaHDFlD1Pia4JihBfwbF6BX6hTXx9CdjWJE2gjJb8B1CFjvzR199WrrjXFMS/YHM70GkcGoV0PE4YEdNxjrjGFcbXp+gKEIbnUunez7s/KykXbYwJvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso89346255ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753066385; x=1753671185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E98xvxZjB2KTFjkZTTvQ7qr6qiZtxBGSfN2bP8jJWXw=;
        b=B6mHysXTcpx1zMEGiNH0OHEu0ssQParRgMYsNifIjJz4qNEUvK6a8Snw+xE+VX6KLI
         u8lE26aP6vUKAoIgfrYYlyT27IZ/eC90JtVU14gIt9wKfJbhaqG9kNQNyzzYS0HXmski
         WysxrLjA/fej/b7EMgGr/FF4hWphD+ZYEZEgpLhgyaoD1XSHm4qMV8jQQTgM7EJs5YRA
         n5sD6XYDM0asiTSMLz0lhxq6RHE6K8YGbpXiXPVLd03TLN0yWHTZreTZVY9UMMH/tt8b
         PaNt7kSjUGMZ0U11tX01hNxB6ZDSw05+blhGD7u9lWC20I7WrRijOFpowKBXHYu2Qbrl
         OziA==
X-Forwarded-Encrypted: i=1; AJvYcCWtF+FpZclHCPcqj5UiW4W2s5axNJVKN6ICSRRM4z0zuPmeVMkw6EfAxZoh02Wio+OmbaM2DBbyfdA5GsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZK9j5wenP/zXtbQYQhREwEnyifFkH/53yyHEkktJ2j34XEMh
	4v21xMNA+39mDHaPEcy5v//L6PVHKDSRAd2oqrv6ll1vlrIt53j7OrhiU58mfChQkGw63YA/xov
	4eIyjOmeFP+8dGmAhR1Lwlvg6PsnodP7MP3i2g1Ou6ya7JR5HbegpD0uSSCM=
X-Google-Smtp-Source: AGHT+IGkmLmYsnBjfcgjcakMeSNqqoGsZjtJtDOHsbtjZvDl5j5u2yUXCOu5G3tdnl9Kw7imLRCg6zn8LZYPh6cmShA0oHIDIBqN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2308:b0:3e2:9fa7:a60a with SMTP id
 e9e14a558f8ab-3e29fb6e97emr88107355ab.3.1753066384777; Sun, 20 Jul 2025
 19:53:04 -0700 (PDT)
Date: Sun, 20 Jul 2025 19:53:04 -0700
In-Reply-To: <20250721023103.2628-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687dab90.a70a0220.693ce.00dc.GAE@google.com>
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
 P1583/2:b..l

rcu: 	(detected by 0, t=10503 jiffies, g=17525, q=2531 ncpus=2)
task:kworker/1:2     state:R
  running task     stack:24872 pid:1583  tgid:1583  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: mld mld_ifc_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6786
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7109
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:307
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5875
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 6b 44 02 11 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc900053ef238 EFLAGS: 00000206

RAX: 00a7868fc370bc00 RBX: 0000000000000000 RCX: 00a7868fc370bc00
RDX: 0000000000000000 RSI: ffffffff8db87282 RDI: ffffffff8be29ec0
RBP: ffffffff8172aae5 R08: 0000000000000000 R09: ffffffff8172aae5
R10: ffffc900053ef3f8 R11: ffffffff81acfe40 R12: 0000000000000002
R13: ffffffff8e13f0e0 R14: 0000000000000000 R15: 0000000000000246
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
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 dst_alloc+0x105/0x170 net/core/dst.c:89
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x420 net/ipv6/route.c:3324
 mld_sendpack+0x678/0xd80 net/ipv6/mcast.c:1857
 mld_send_cr net/ipv6/mcast.c:2169 [inline]
 mld_ifc_work+0x835/0xde0 net/ipv6/mcast.c:2702
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 3495 jiffies! g17525 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:26792 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
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
CPU: 0 UID: 0 PID: 6673 Comm: dhcpcd-run-hook Not tainted 6.16.0-rc7-syzkaller-g89be9a83ccf1 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0xf69/0x12d0 kernel/smp.c:885
Code: 00 45 8b 2f 44 89 ee 83 e6 01 31 ff e8 c0 78 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 6b 74 0b 00 eb 37 f3 90 <43> 0f b6 04 2c 84 c0 75 10 41 f7 07 01 00 00 00 74 1e e8 50 74 0b
RSP: 0000:ffffc90003faf560 EFLAGS: 00000293

RAX: ffffffff81b4bcb0 RBX: ffff8880b863b1c0 RCX: ffff888026c01e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003faf6c0 R08: ffffffff8fa1faf7 R09: 1ffffffff1f43f5e
R10: dffffc0000000000 R11: fffffbfff1f43f5f R12: 1ffff110170e7f5d
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880b873fae8
FS:  00007f6e34ee0c80(0000) GS:ffff888125c18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00202a000 CR3: 0000000029e28000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x6b1/0x12c0 arch/x86/mm/tlb.c:1451
 dup_mmap+0x15a0/0x1ac0 mm/mmap.c:1877
 dup_mm kernel/fork.c:1477 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1529
 copy_process+0x16d3/0x3b80 kernel/fork.c:2169
 kernel_clone+0x21e/0x870 kernel/fork.c:2599
 __do_sys_clone kernel/fork.c:2742 [inline]
 __se_sys_clone kernel/fork.c:2726 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2726
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e3507a636
Code: 89 df e8 6d e8 f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffdd4454400 EFLAGS: 00000246
 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffdd4454408 RCX: 00007f6e3507a636
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 000055e0d3c6bc30 R08: 0000000000000000 R09: 0000000000000030
R10: 00007f6e34ee0f50 R11: 0000000000000246 R12: 000055e0d3c79290
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


Tested on:

commit:         89be9a83 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16dc0fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=5583f599fe40b819b3e7
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

