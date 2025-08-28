Return-Path: <linux-kernel+bounces-789190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7721B39217
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1951BA7D89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761C261B9A;
	Thu, 28 Aug 2025 03:08:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF261AAE17
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350487; cv=none; b=FIqWIWE2pO63B2Q2XyIndqvN9l5CLNQXnXG6xUWdz/Q3wrynP+vSiMumcxAxnyyVYFIgA16NOnN29ZDpzG5LpW2GyYlbGELX4eCnlQ3YsOiDaDpU0uXW5JwJ6/xqiHLegcmZSOnnvhbFfTxYLu66HUNYEh+KX/CZVO2yYOZQjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350487; c=relaxed/simple;
	bh=OBbafKjywxsHzUmzz7M30RIkaRAUiga+jtQnihqR7OM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LcOzppsuoVOGv52OCJL16p6VzerfJmwz/pMn/P16qJL5aaykbPeJqdITuThNDuae3KXfy9agVcJI6DeUvm7RqtssJznIQE0qIkI9+dumGrYCLk50mCm9WAJu6RxNUQHRVwU90KAqJ4vTwFsJeN+nkNbblH6hAcz1TNj4uN+5ea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed0ba44c8fso6612585ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756350484; x=1756955284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TXKpfxtZp9jkmD7us5ryt1CIrtYffoFxVz1qHqpMAQ=;
        b=QbPXtnR9bXeSNhMW2Wz3TtqITAodgbHWg6L4Q10KqXoLp64Hz+F6Kivc+qYCkVD/sO
         1SJzwv0aPWedZ+c41jN+vJnd3JIY0yDlKlfaf4QrgdLlTpgkKYtucf5qrOzhphhTJUPB
         1ECaK16nfSBxcp50SofehYGMy9M8q1gFyhwDogqsdZw2fyuqmTv/lYNKxIrWb/wI+7WY
         RKtmYptIOF67Ng2wnxPr4MqZLKyXJ7GAE7wNrZKrEKY/ONyD9TS6QiMPm3cVlKaWJBmz
         97eHZYhpnCv75e64Xl71mxFlksTvIU/tr2buXXMoD1OVgmYd1I4VtYHuw9Rclt467FIw
         Svhw==
X-Forwarded-Encrypted: i=1; AJvYcCVONUxIdRxh0qnUDLcSfvoJ1W0M0N2jGN7ThHLzOSaMYWOjWvxThQYKsjlt2AFwdpL+quOVRLNhUDF0xTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMbaK02R/ohw2y/E5TJJhfoP0G/ORkQ1Z0GkTOPpMqnQigWM+
	l5qzt2CH5CIOB0xRQPI0RtKNS2r3qK6SM4LjEBOe8Y35o21l/a2erv+URPljQ+C+rNzTqqO5kAu
	8znvdWrsc0KFGADhXdiZmjCMMIuzmsiosQKRccuFeGrDhtbPtb20Kv5dA1DA=
X-Google-Smtp-Source: AGHT+IEPuR8A0UA8gO/hIpyRFoadj9hlTadDGlYI1oxtjuED3HjI5ASMsvXdT2lctHcmObUwe+jaR4bFkEO4keiiAnwKaSSTSrKr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:3f1:f2:1a47 with SMTP id
 e9e14a558f8ab-3f100f21bb3mr32320155ab.31.1756350484705; Wed, 27 Aug 2025
 20:08:04 -0700 (PDT)
Date: Wed, 27 Aug 2025 20:08:04 -0700
In-Reply-To: <zfqc3duhgtcevsjaulyn23ckgg5oyuiyprruichcbthhqtknqa@vgfjpy6dyu7k>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68afc814.050a0220.8762d.0005.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_munmap (2)
From: syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5218/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=10417, q=327 ncpus=2)
task:udevd           state:R  running task     stack:26640 pid:5218  tgid:5218  ppid:1      task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:lock_acquire+0x30/0x350 kernel/locking/lockdep.c:5828
Code: 4d 89 cf 41 56 41 89 f6 41 55 41 89 d5 41 54 45 89 c4 55 89 cd 53 48 89 fb 48 83 ec 38 65 48 8b 05 0d 79 3e 12 48 89 44 24 30 <31> c0 66 90 65 8b 05 29 79 3e 12 83 f8 07 0f 87 bc 02 00 00 89 c0
RSP: 0018:ffffc90003d0f530 EFLAGS: 00000286
RAX: 4b548df46ee33600 RBX: ffffffff8e5c11e0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e5c11e0
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90003d0f618 R11: 00000000000135a3 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xd1/0x20a0 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4879
 tomoyo_realpath_from_path+0x19f/0x6e0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2377
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x121/0x3f0 fs/stat.c:356
 vfs_fstatat+0x7b/0xf0 fs/stat.c:375
 __do_sys_newfstatat+0x97/0x120 fs/stat.c:542
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47f6d11b0a
RSP: 002b:00007ffd84c35818 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 0000559b20c5e418 RCX: 00007f47f6d11b0a
RDX: 00007ffd84c35820 RSI: 0000559b20c4cef3 RDI: 00000000ffffff9c
RBP: 0000559b5aa6d668 R08: 00063d641a57c867 R09: 00007f47f7457000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd84c35820 R14: 0000000000000000 R15: 00063d641a57c867
 </TASK>
rcu: rcu_preempt kthread starved for 966 jiffies! g10417 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28936 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xb00 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x270/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6556 Comm: syz.1.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:36 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:139 [inline]
RIP: 0010:wrmsrq arch/x86/include/asm/msr.h:199 [inline]
RIP: 0010:native_apic_msr_write arch/x86/include/asm/apic.h:212 [inline]
RIP: 0010:native_apic_msr_write+0x28/0x40 arch/x86/include/asm/apic.h:206
Code: 90 90 f3 0f 1e fa 8d 87 30 ff ff ff 83 e0 ef 74 20 89 f8 83 e0 ef 83 f8 20 74 16 c1 ef 04 31 d2 89 f0 8d 8f 00 08 00 00 0f 30 <66> 90 c3 cc cc cc cc c3 cc cc cc cc 89 f6 31 d2 89 cf e9 b1 4d ae
RSP: 0018:ffffc900031479f0 EFLAGS: 00000046
RAX: 000000000000003e RBX: ffff8880b8523a00 RCX: 0000000000000838
RDX: 0000000000000000 RSI: 000000000000003e RDI: 0000000000000038
RBP: 000000000000003e R08: 0000000000000005 R09: 000000000000003f
R10: 0000000000000020 R11: ffffffff9b0d2580 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffed10170a4745
FS:  0000555558775500(0000) GS:ffff8881247bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00732e000 CR3: 0000000077210000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 apic_write arch/x86/include/asm/apic.h:405 [inline]
 lapic_next_event+0x10/0x20 arch/x86/kernel/apic/apic.c:416
 clockevents_program_min_delta+0x173/0x3a0 kernel/time/clockevents.c:248
 clockevents_program_event+0x2a6/0x380 kernel/time/clockevents.c:336
 tick_program_event+0xa9/0x140 kernel/time/tick-oneshot.c:44
 __hrtimer_reprogram kernel/time/hrtimer.c:685 [inline]
 __hrtimer_reprogram kernel/time/hrtimer.c:659 [inline]
 hrtimer_reprogram+0x27b/0x450 kernel/time/hrtimer.c:868
 hrtimer_start_range_ns+0x9d4/0xfc0 kernel/time/hrtimer.c:1330
 __posixtimer_deliver_signal kernel/time/posix-timers.c:322 [inline]
 posixtimer_deliver_signal+0x30d/0x6b0 kernel/time/posix-timers.c:348
 dequeue_signal+0x307/0x520 kernel/signal.c:660
 get_signal+0x602/0x26d0 kernel/signal.c:2914
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5114d8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc5e18098 EFLAGS: 00000246
RAX: fffffffffffffffc RBX: 00000000000231ee RCX: 00007f5114d8ebe9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f5114fb5fac
RBP: 0000000000000032 R08: 00007f5115bce000 R09: 00000012c5e1838f
R10: 00007ffcc5e18190 R11: 0000000000000246 R12: 00007f5114fb5fac
R13: 00007ffcc5e18190 R14: 0000000000023220 R15: 00007ffcc5e181b0
 </TASK>


Tested on:

commit:         a1617343 skip the validate_mm() for stall test
git tree:       git://git.infradead.org/users/jedix/linux-maple.git no_validate
console output: https://syzkaller.appspot.com/x/log.txt?x=13441fbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=8785aaf121cfb2141e0d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

