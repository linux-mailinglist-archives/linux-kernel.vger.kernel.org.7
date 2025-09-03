Return-Path: <linux-kernel+bounces-798061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BFFB41915
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0986C483930
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE152DF140;
	Wed,  3 Sep 2025 08:49:35 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62811DD877
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889374; cv=none; b=H0+w8Nru3rs2F96qZdSg+3s8bTZ1Se3BJzn7HYCDbX5WJvEtn8ATBW7SGn119nmgqiiKwCEEvGi6jRCBBEB6scEJm1/R+2m9A2xboj6+nAAHvuoBI8ts73ArWUEqI+yTuB8xboS5ap4SEDrA6GUKhynKNRvne/sT8LFZKYBBrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889374; c=relaxed/simple;
	bh=kqAZNROii/6czcHqnZv1qWhPrwzBNXGzh8L6Omf4E/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EAVl03mvI6unIzg8RWm/Egst/Lsm4DnWsbQGQoqAD2WsjJmzgvBrN0Am1ejkt0OovQ6SkxIEPK1E2YoHJLFAeIjeK8VhRmt/jt49wmPo3FJBAKsGSMB0H/VtGkKMZ9cTRgmsSqOkz+JGPQ9Jayyvt/ZrgH1rINYovjUcJaQ381w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8872d447b92so260288639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889372; x=1757494172;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f39PDclNjSLZoeFaDAPe+eLFmyCR0lWjHD3AHfO1gc4=;
        b=Y2WfiUcBqPr5Juy5ZUN4Pmn1mXd3c7OSn3dxk6D+w91QFSvDJ/+ACM4dlI4xAJJo/E
         MjZeIKmMWffR82wfijrceSspQQ57knbVx7dLW5/bfkfd0aLUWNVLbaLAYInvKvVeuuzk
         nX0jHsk/TavQwzH+lHubgc0pWAvANBf4iyYdu7pyIvIRC69ExaCb1RNfc7wymp3t6qwA
         IZTT3iMhbHbCz+fWc9J7NB/xrRfnGBU/Zk45ShQvGmdXzSsZD5BykfpU/+LHLgNMzJrx
         Bx2Ji98ygz0V5tWF6Ljjtie+Q6nPFCxxvl35Xi55bqQE5tdZH51Hm9qkznUaTxWe6Edu
         ajFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwh5ibGKx4LfqMFwUJoaQKhjRmNucTmQbVwCdYka8cSdXLH2azQzrpeZ6/HSsmijEPdmg75BUTr1dCjWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdsbI1ebdj1SB7gj/oX0FOrYvxPSnLHqECE1kHEFXKKYUyIyC
	tVqwo2DQzGo0XZHtmDi9YaSwva12yk9zwwBxP5QG/52eLD0yc58Y7Q/44KWbh2bJNm8JHxnHvKs
	1TKx/p6JDhEMZE4j2FTlJNCDMKMWDC2gHouJMIMImxCPtyE3Gf6Bm+fcpCgA=
X-Google-Smtp-Source: AGHT+IHUXY0Xqe/zb+5ihKOXs1mX2p/xd2VT1gjKPEKgTJGECWr5XYDd1dprt/JTu83a3cSpqFE+QlO85ntaf4nUfDw9S5IUHT12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b86:b0:887:16d5:5978 with SMTP id
 ca18e2360f4ac-8871f420c03mr2905570139f.6.1756889371878; Wed, 03 Sep 2025
 01:49:31 -0700 (PDT)
Date: Wed, 03 Sep 2025 01:49:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8011b.050a0220.3db4df.01e9.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in vmci_qp_broker_detach
From: syzbot <syzbot+68c586d577defab7485e@syzkaller.appspotmail.com>
To: arnd@arndb.de, bcm-kernel-feedback-list@broadcom.com, 
	bryan-bt.tan@broadcom.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vishnu.dasa@broadcom.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a3ca62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=68c586d577defab7485e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14975262580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68c586d577defab7485e@syzkaller.appspotmail.com

INFO: task syz.1.8150:15216 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.8150      state:D stack:27448 pid:15216 tgid:15216 ppid:13883  task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 vmci_qp_broker_detach+0x113/0xf10 drivers/misc/vmw_vmci/vmci_queue_pair.c:2095
 ctx_free_ctx drivers/misc/vmw_vmci/vmci_context.c:424 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put+0x603/0xbf0 drivers/misc/vmw_vmci/vmci_context.c:477
 vmci_ctx_enqueue_datagram+0x3ab/0x420 drivers/misc/vmw_vmci/vmci_context.c:340
 dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:276 [inline]
 vmci_datagram_dispatch+0x43f/0xc10 drivers/misc/vmw_vmci/vmci_datagram.c:340
 qp_notify_peer drivers/misc/vmw_vmci/vmci_queue_pair.c:1481 [inline]
 vmci_qp_broker_detach+0x8c8/0xf10 drivers/misc/vmw_vmci/vmci_queue_pair.c:2188
 ctx_free_ctx drivers/misc/vmw_vmci/vmci_context.c:424 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put+0x603/0xbf0 drivers/misc/vmw_vmci/vmci_context.c:477
 vmci_host_close+0x98/0x160 drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x449/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f68c378ebe9
RSP: 002b:00007ffe9f27e238 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000008c3bc RCX: 00007f68c378ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000099f27e52f
R10: 0000001b2f520000 R11: 0000000000000246 R12: 00007f68c39c5fac
R13: 00007f68c39c5fa0 R14: ffffffffffffffff R15: 0000000000000003
 </TASK>
INFO: task syz.2.8151:15217 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.8151      state:D stack:28360 pid:15217 tgid:15217 ppid:14709  task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 qp_broker_alloc+0x1a2/0x2330 drivers/misc/vmw_vmci/vmci_queue_pair.c:1731
 vmci_qp_broker_alloc+0x92/0xc0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1942
 vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:470 [inline]
 vmci_host_unlocked_ioctl+0x1262/0x2650 drivers/misc/vmw_vmci/vmci_host.c:934
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f34e798ebe9
RSP: 002b:00007ffcb7deb748 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f34e7bc5fa0 RCX: 00007f34e798ebe9
RDX: 0000200000000540 RSI: 00000000000007a8 RDI: 0000000000000005
RBP: 00007f34e7a11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f34e7bc5fa0 R14: 00007f34e7bc5fa0 R15: 0000000000000003
 </TASK>
INFO: task syz.3.8152:15218 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.8152      state:D stack:27176 pid:15218 tgid:15218 ppid:14309  task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 qp_broker_alloc+0x1a2/0x2330 drivers/misc/vmw_vmci/vmci_queue_pair.c:1731
 vmci_qp_broker_alloc+0x92/0xc0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1942
 vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:470 [inline]
 vmci_host_unlocked_ioctl+0x1262/0x2650 drivers/misc/vmw_vmci/vmci_host.c:934
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd21db8ebe9
RSP: 002b:00007ffef05a1128 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd21ddc5fa0 RCX: 00007fd21db8ebe9
RDX: 0000200000000540 RSI: 00000000000007a8 RDI: 0000000000000003
RBP: 00007fd21dc11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd21ddc5fa0 R14: 00007fd21ddc5fa0 R15: 0000000000000003
 </TASK>
INFO: task syz.0.8114:15287 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.8114      state:D stack:27336 pid:15287 tgid:15287 ppid:15178  task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 qp_broker_alloc+0x1a2/0x2330 drivers/misc/vmw_vmci/vmci_queue_pair.c:1731
 vmci_qp_broker_alloc+0x92/0xc0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1942
 vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:470 [inline]
 vmci_host_unlocked_ioctl+0x1262/0x2650 drivers/misc/vmw_vmci/vmci_host.c:934
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f874118ebe9
RSP: 002b:00007ffc65512958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f87413c5fa0 RCX: 00007f874118ebe9
RDX: 0000200000000540 RSI: 00000000000007a8 RDI: 0000000000000003
RBP: 00007f8741211e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f87413c5fa0 R14: 00007f87413c5fa0 R15: 0000000000000003
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 83 0f 22 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8e207d80 EFLAGS: 000002c2
RAX: 2609b6a075c24000 RBX: ffffffff8197ac78 RCX: 2609b6a075c24000
RDX: 0000000000000001 RSI: ffffffff8c04e5e0 RDI: ffffffff8197ac78
RBP: ffffffff8e207ea8 R08: ffff8880b8632f9b R09: 1ffff110170c65f3
R10: dffffc0000000000 R11: ffffed10170c65f4 R12: ffffffff8fe52d30
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1c52a38
FS:  0000000000000000(0000) GS:ffff8881257c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbef4cf7d60 CR3: 000000000e338000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 rest_init+0x2de/0x300 init/main.c:756
 start_kernel+0x3a9/0x410 init/main.c:1109
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
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

