Return-Path: <linux-kernel+bounces-848332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACDBCD713
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8B5C4FE84D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576492F3C3B;
	Fri, 10 Oct 2025 14:14:35 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032436124
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105674; cv=none; b=ga6X38bKezQ0yo4Lq3LFFlXZ7bIvlaf379AMMNgEIfREi1rgVbY9yprG3Y26ruaypd3RaUiUz0J/WZcXXxrB9gWpXoKkG7L6bZpcOUATiLAeqMwaSaRaQYxL/10NLvg8JJ/b9B1LYELj0ACIcsEH+Y7hwVD7l1Autsx2R0JaYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105674; c=relaxed/simple;
	bh=3CBUjkHoKcDc4eae55hRVsYNApO8T+juvhSKWISdee4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hicE5Esgu7NNbosPbtdeMGItkZ0SNfTWHQJZN4cO+uwmAhKAX8y/s+0E5DytPaBctoOst+r1WGB1FAxUw5qI4kJrKFAuWDYZo/dE1IYWZoxp26pePPwa2GXISmIwoNxZR8dF1s5WDKVDwGzqCzHiueWvGTwvShTCOjtYeW6dZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-927f4207211so675467339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105672; x=1760710472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKGXAfrOMFC7mG6muRH4oijoMxv8/UaK6fNUmCFKTss=;
        b=CjblkQHvg3lQ/dpSm3ynUz0HICv/O+NS0oay7mY1kVhI4rEJcJUHu6InwjZArVNx0k
         O53GMATLu+Vrdr28oYZzi3vHHCuNlAyC26E0Cwb+CIgdszM/bdgUjJ0pxbb3mg6QW8dJ
         BP6bfoM5MKp/bwk/eMDG6Bjv6ILnxKePqbQwe3GmdJmWz1dckWnKqZhahbqiWMuTJG40
         VzgIqSWu8XZDyyvBsf7K/GbxxLigwUYy8hmMLuGq42tX8aylK9iGdiUwT6gwSKpn4QuJ
         xHCdU+XVkC7VRQOcF2JeoiNzCVsiX5OXHTaZSCfVL+Wb3SmixKffCoJgk6Qq09mcAcaa
         fVAw==
X-Forwarded-Encrypted: i=1; AJvYcCWrHaWjg1cj980uup3NeDqipHN5b5DMD6fd18SiLXL93A+XK+Ed0Cg2hvtZyKTJl5PIBopfR73CJNVzXhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2WkiJdb1bDhGYHupRVpsruydqr8xKEpqAs7sN6EVaPhVuzr+
	hr8oZF1XpYrmWEbIWO9B7Ku96oVkDl2LTUk5k8rZYQ95056nB2Hn2ROhrowI7+b3zXJmYjSxjI4
	V+ln20br85z04SyZGPlyS9UUQN9eblV0C78VZrh+tuOkkMr32CWMpg6j3VNQ=
X-Google-Smtp-Source: AGHT+IFBolmOV5XO5EECQRO9AtwRA+bEfr0qnIjPY8MikU+Yo9KfP2cwapuBWug4BqaaorD1vZE9KCezqDgxlZdn1OAI2yXRGzne
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b0e:b0:912:5455:f0b0 with SMTP id
 ca18e2360f4ac-93bd188eab3mr1442867339f.9.1760105672224; Fri, 10 Oct 2025
 07:14:32 -0700 (PDT)
Date: Fri, 10 Oct 2025 07:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e914c8.050a0220.1186a4.000a.GAE@google.com>
Subject: [syzbot] [kernel?] KMSAN: uninit-value in psi_task_change
From: syzbot <syzbot+6a41c3d25697203c245a@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b0d551bcc05 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1539392f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50fb29d81ff5a3df
dashboard link: https://syzkaller.appspot.com/bug?extid=6a41c3d25697203c245a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90b0fb888152/disk-9b0d551b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1120c646f284/vmlinux-9b0d551b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df9bbfa8cbe6/bzImage-9b0d551b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a41c3d25697203c245a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in kernfs_ino include/linux/kernfs.h:368 [inline]
BUG: KMSAN: uninit-value in cgroup_ino include/linux/cgroup.h:590 [inline]
BUG: KMSAN: uninit-value in cgroup_psi include/linux/psi.h:37 [inline]
BUG: KMSAN: uninit-value in task_psi_group kernel/sched/psi.c:889 [inline]
BUG: KMSAN: uninit-value in psi_task_change+0x4ba/0x710 kernel/sched/psi.c:921
 kernfs_ino include/linux/kernfs.h:368 [inline]
 cgroup_ino include/linux/cgroup.h:590 [inline]
 cgroup_psi include/linux/psi.h:37 [inline]
 task_psi_group kernel/sched/psi.c:889 [inline]
 psi_task_change+0x4ba/0x710 kernel/sched/psi.c:921
 psi_enqueue kernel/sched/stats.h:166 [inline]
 enqueue_task+0x32d/0x390 kernel/sched/core.c:2094
 activate_task kernel/sched/core.c:2134 [inline]
 ttwu_do_activate+0x1dd/0x9d0 kernel/sched/core.c:3706
 ttwu_queue kernel/sched/core.c:3969 [inline]
 try_to_wake_up+0xf83/0x1f50 kernel/sched/core.c:4293
 wake_up_process+0x2a/0x40 kernel/sched/core.c:4424
 hrtimer_wakeup+0x85/0xd0 kernel/time/hrtimer.c:2013
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x559/0xd80 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x456/0xb80 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0xa7/0x420 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0x7f/0x90 arch/x86/kernel/apic/apic.c:1052
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 finish_task_switch+0x184/0x920 kernel/sched/core.c:5193
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x2331/0x7790 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x17d/0x3c0 kernel/sched/core.c:7026
 exit_to_user_mode_loop+0x6c/0x370 kernel/entry/common.c:31
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x1e3/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __netns_tracker_alloc include/net/net_namespace.h:362 [inline]
 sk_alloc+0x5de/0x8a0 net/core/sock.c:2311
 __netlink_create net/netlink/af_netlink.c:628 [inline]
 __netlink_kernel_create+0x19b/0xcc0 net/netlink/af_netlink.c:2020
 netlink_kernel_create include/linux/netlink.h:62 [inline]
 rtnetlink_net_init+0x6b/0x110 net/core/rtnetlink.c:7038
 ops_init+0x2b3/0x9f0 net/core/net_namespace.c:137
 __register_pernet_operations net/core/net_namespace.c:1314 [inline]
 register_pernet_operations+0x649/0xfa0 net/core/net_namespace.c:1391
 register_pernet_subsys+0x5b/0xa0 net/core/net_namespace.c:1432
 rtnetlink_init+0x29/0xa0 net/core/rtnetlink.c:7093
 netlink_proto_init+0x1f8/0x280 net/netlink/af_netlink.c:2948
 do_one_initcall+0x237/0xb60 init/main.c:1283
 do_initcall_level+0x157/0x2e0 init/main.c:1345
 do_initcalls+0x176/0x310 init/main.c:1361
 do_basic_setup+0x1d/0x30 init/main.c:1380
 kernel_init_freeable+0x275/0x4a0 init/main.c:1593
 kernel_init+0x2f/0x5e0 init/main.c:1483
 ret_from_fork+0x233/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

CPU: 0 UID: 0 PID: 31572 Comm: syz.3.9106 Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
=====================================================


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

