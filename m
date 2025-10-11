Return-Path: <linux-kernel+bounces-849051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D651BCF151
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2E4B34D196
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774022F74E;
	Sat, 11 Oct 2025 07:41:27 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6E1D63FB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168486; cv=none; b=YHnz/+AP6m6FWLOK8KGrKepc66xvJM215hem8J2r/M+ge9R3HF2po7GzjPPcHhL8yG/T+nRpEEk7UMiYx4Oa74c2F+9STkUEJKK+xRsGZ1DSLmrdQW7TESGrYkA+pSRJYno/jOBbxGtvbdljKd1/C+nN53CcDUQAC2FUyo1UqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168486; c=relaxed/simple;
	bh=pMAjfqcp2hLedn/bsekOK2W0WAWHeDvvIQcaKymX7QA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LLjgnVoLTFvOTnlQ/e5ktYJhBFiEhNhodPcf49P8FpiadHTq8tzM15KD1Bqc+Re/9YwSq6GNIoZnA0AMGbHoysCW+pRqFkwHJ9RC1/VdfAn7g5raTYtxgrVlOON9B/zGfqAkiPuhrabLwWBwLLkzeHQdvqzqz1hSXtabDHKTDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9143e8a4c5eso1865776239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760168484; x=1760773284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWuIqc/0zJGOLb+8dYLjY02do3cnq49EH2FPnh9oElY=;
        b=F+HiFCRWhVKCkDDqZR3g+8mZubKQx08azIJ3+YxkD5P0ul5qIkSEwaIM838vNGyVZi
         yg4+FYvTZVrfCIvkoGdSpARLmyYUiaLphvlrjux5ye73VIjQxTyIWPUOwUmDgGExCQVU
         s4zIGWFRgWtC91Nnm/ZdWeEtgmCle+ZH9xvLFJObTxKAPaMUFufuDf0NLfmYKBWYU/Mf
         JLOgn3lW7BGBq1uSPZoKSR0notj+JqZqfFYlL5rX7lgGWEydofVmlhYYLgGg0NZcGsrz
         KtM2RMNl/BIaYnjUh1BI+ubqRvIGQ2dJIocb8BQ/NXRHMqgDhc3Yy6x50THZ+0uyuDQG
         6xDw==
X-Forwarded-Encrypted: i=1; AJvYcCW99fUxqxMIoAs8HiZZkQ+Fm+zWbPvHoBIAoElwemi3IBEMXDgAnJBVINU8wd8hW2aLKiBaID6NNxY6ycM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OmaGcQ3zl6cChkWmHzZHyjWUvoKMxWHu6PcSA+AFxlFuBWcf
	Sx7pGKoCEHxQuBTwKM/wYVdVndOAaY12VIkGN+5IllSIF+W0NuipM1/vibDCT07pEeqYAMI7idC
	jyEzzZuU4Kyx+IxKFOFzI6CBAA6/2AWkSak5FuILNUc1l2P1g2DIMYjhzLhE=
X-Google-Smtp-Source: AGHT+IEaHgOk+hcnpLNjCLvzHAVDmi8xOnlZJWvJ4LF4EeGkOu9Z/a3C/IvUMn+OQHpDUGzgp3Os72pjRQUmulOZjdXBXC33px3X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c264:0:b0:42e:452f:5321 with SMTP id
 e9e14a558f8ab-42f8735a25amr170283275ab.9.1760168484125; Sat, 11 Oct 2025
 00:41:24 -0700 (PDT)
Date: Sat, 11 Oct 2025 00:41:24 -0700
In-Reply-To: <681a1770.050a0220.a19a9.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea0a24.050a0220.91a22.01ca.GAE@google.com>
Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in
 inet_rtm_newaddr (2)
From: syzbot <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    18a7e218cfcd Merge tag 'net-6.18-rc1' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12504dcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ab7fa743df0ec1
dashboard link: https://syzkaller.appspot.com/bug?extid=51cd74c5dfeafd65e488
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d2a542580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142149e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a01e6dce97e/disk-18a7e218.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5e1b7e41427f/vmlinux-18a7e218.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69b558601209/bzImage-18a7e218.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com

sched: DL replenish lagged too much
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (2 GPs behind) idle=7754/1/0x4000000000000000 softirq=15464/15465 fqs=1
rcu: 	(detected by 1, t=10502 jiffies, g=11321, q=371 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5948 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:rb_insert_color_cached include/linux/rbtree.h:113 [inline]
RIP: 0010:rb_add_cached include/linux/rbtree.h:183 [inline]
RIP: 0010:timerqueue_add+0x1a8/0x200 lib/timerqueue.c:40
Code: e7 31 f6 e8 6a 0c de f6 42 80 3c 2b 00 74 08 4c 89 f7 e8 7b 0a de f6 4d 89 26 4d 8d 7e 08 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 <74> 08 4c 89 ff e8 5e 0a de f6 4d 89 27 4d 85 e4 40 0f 95 c5 eb 07
RSP: 0018:ffffc90000007cf0 EFLAGS: 00000046
RAX: 1ffff110170c4f83 RBX: 1ffff110170c4f82 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88805de72358
RBP: 0000000000000000 R08: ffff88805de72357 R09: 0000000000000000
R10: ffff88805de72340 R11: ffffed100bbce46b R12: ffff88805de72340
R13: dffffc0000000000 R14: ffff8880b8627c10 R15: ffff8880b8627c18
FS:  000055557c657500(0000) GS:ffff888125d0f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000600 CR3: 000000002ee76000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1794 [inline]
 __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:pv_vcpu_is_preempted arch/x86/include/asm/paravirt.h:579 [inline]
RIP: 0010:vcpu_is_preempted arch/x86/include/asm/qspinlock.h:63 [inline]
RIP: 0010:owner_on_cpu include/linux/sched.h:2282 [inline]
RIP: 0010:mutex_spin_on_owner+0x189/0x360 kernel/locking/mutex.c:361
Code: b6 04 30 84 c0 0f 85 59 01 00 00 48 8b 44 24 08 8b 18 48 8b 44 24 48 42 80 3c 30 00 74 0c 48 c7 c7 90 8c fa 8d e8 a7 cd 88 00 <48> 83 3d ff 27 5e 0c 00 0f 84 b9 01 00 00 48 89 df e8 41 e0 d5 ff
RSP: 0018:ffffc900034c7428 EFLAGS: 00000246
RAX: 1ffffffff1bf5192 RBX: 0000000000000001 RCX: ffffffff819c6588
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8f4df8a0
RBP: 1ffffffff1e9bf14 R08: ffffffff8f4df8a7 R09: 1ffffffff1e9bf14
R10: dffffc0000000000 R11: fffffbfff1e9bf15 R12: ffffffff8f4df8a0
R13: ffffffff8f4df8f0 R14: dffffc0000000000 R15: ffff8880267a9e40
 mutex_optimistic_spin kernel/locking/mutex.c:464 [inline]
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x311/0x1350 kernel/locking/mutex.c:760
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faade790d5c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffdd2e3b670 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007faadf514620 RCX: 00007faade790d5c
RDX: 0000000000000028 RSI: 00007faadf514670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdd2e3b6c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007faadf514670 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffies! g11321 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=4286
rcu: rcu_preempt kthread starved for 10500 jiffies! g11321 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27224 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
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


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

