Return-Path: <linux-kernel+bounces-797109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B7B40BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC218808F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233A340DA0;
	Tue,  2 Sep 2025 17:24:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C83342C9D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833873; cv=none; b=q82qaQfaFx92YghstNEjfP48cV4SsJm0frJ9cynOikkJv8b1XBFnjvnMGEV81oScvaMgMnffhyIblAsksh79uABC0wjOJT25ahO9bIROhc+YhENbCc8Pn2Zuy6l40HXWPsnxdkGFb9QBGIcFwNIUd6LpdV0tlRW0Ncn1ClvTOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833873; c=relaxed/simple;
	bh=1ZZqFbNw/49Gug/s2W/vtYY7n2F4KFxPrpOt6Bf1xyw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qjx19KEf4Iyp+2XNmqP6QciuF2Lo1yL/PqoFLIfVQsiu5lvUEfqJUm2fe/L+jHHnUq5MCQ9mtpvI3y3jsbRqshO4gGdWXdLtALriO3UEjUpJScjN+p++c/kdWo7RqKoJSv0Gm3A3Dh90514AQP5lbHv6NiiyQNqECQTOBEdNdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8870b07643bso488069239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833871; x=1757438671;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPP45SA+l96CUh2c18VDkNcHfjDugr+GGGq2m1pNyw0=;
        b=HR1Wb0lAY8Xwt9fiLEOVRqs98MJWqGiqHVo6Zf47fDSXbiw8K13v3UVaCUKFynG6MN
         Ihfl9RNonAXNnx597O74IBGOWT3G4TAyr5hAf1C6qVFMB7SfwS9eUTIdf5iTJvD6XHnU
         T6xM7VMF6IvTefTaVzFnkL/xY6Nv9CmXGaWREyq127rEj9rIAOB5Anm2oYLy2/eLT1QZ
         GvrI9hc+45yIFNfD3UBQjJzCzLFurzcKudS+Mgh44WZsZQAJArAuRuLlOTlkIHO2EYzK
         gS9CbIwB+/YDDayidn8MFrtLtD/QxtMG7rS9reK55psdxc7wTRXc8alUWYdbRmHfLpJQ
         lsDw==
X-Forwarded-Encrypted: i=1; AJvYcCUOV9XX+yc6+BEKUcdRJGciFzV9CAt9uh0s1GODbJta0NUeLdSzU1Li8IdfBkmP0vCdz4E6nzI5tsS5Iw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMkSAkrKSkMDdjz0Ou4/EmcjPaf/LJ40yaOlwjRfH0utpiBMO
	Nrxt59XlC5w0vgsnJcU7PNU6byhQMUBOOpjUqeXitscFUGFySwlrc2pbGoFraX/+5MjstMViCSF
	7lZqcSTPEr1NPTxndlBN9hUHTmY8qi355RpcQ9rElMa6IP4YIzmImkVx70wU=
X-Google-Smtp-Source: AGHT+IFV5H1Fgh3t9Ch95MsLrxeQgVcDnvnLwFQWyFLZD+7A55UCkqpzNbOb/0bAc/B3lUb9xV7mDA4YWg1dL71pPqMCIJdrXAkJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:3f0:ac23:ea93 with SMTP id
 e9e14a558f8ab-3f4026c2863mr250677045ab.29.1756833870850; Tue, 02 Sep 2025
 10:24:30 -0700 (PDT)
Date: Tue, 02 Sep 2025 10:24:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b7284e.050a0220.3db4df.01d6.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in ext4_read_bh
From: syzbot <syzbot+18edb60ce92acd5b4674@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a46662580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=18edb60ce92acd5b4674
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a46662580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1399da62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18edb60ce92acd5b4674@syzkaller.appspotmail.com

INFO: task syz.0.17:6042 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:24456 pid:6042  tgid:6042  ppid:5993   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x80/0xd0 kernel/sched/core.c:7903
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit+0xb6/0x310 kernel/sched/wait_bit.c:52
 out_of_line_wait_on_bit+0x123/0x170 kernel/sched/wait_bit.c:67
 wait_on_buffer include/linux/buffer_head.h:420 [inline]
 ext4_read_bh+0x20d/0x260 fs/ext4/super.c:207
 ext4_read_bh_lock fs/ext4/super.c:220 [inline]
 __ext4_sb_bread_gfp+0x1c9/0x210 fs/ext4/super.c:242
 ext4_sb_bread_unmovable fs/ext4/super.c:265 [inline]
 ext4_load_super fs/ext4/super.c:5063 [inline]
 __ext4_fill_super fs/ext4/super.c:5267 [inline]
 ext4_fill_super+0x802/0x6090 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
 do_mount fs/namespace.c:4138 [inline]
 __do_sys_mount fs/namespace.c:4349 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4326
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f733498ebe9
RSP: 002b:00007ffe0adbf068 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f7334bc5fa0 RCX: 00007f733498ebe9
RDX: 0000200000000000 RSI: 0000200000000040 RDI: 0000200000000100
RBP: 00007f7334a11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7334bc5fa0 R14: 00007f7334bc5fa0 R15: 0000000000000005
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 83 0f 22 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c2
RAX: a34074f8f13bed00 RBX: ffffffff8197ac78 RCX: a34074f8f13bed00
RDX: 0000000000000001 RSI: ffffffff8c04e5e0 RDI: ffffffff8197ac78
RBP: ffffc90000197f10 R08: ffff8880b8732f9b R09: 1ffff110170e65f3
R10: dffffc0000000000 R11: ffffed10170e65f4 R12: ffffffff8fe52d30
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff11003a55b40
FS:  0000000000000000(0000) GS:ffff8881258c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056389163e5d0 CR3: 00000000754ec000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
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

