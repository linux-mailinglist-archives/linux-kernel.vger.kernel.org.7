Return-Path: <linux-kernel+bounces-754479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EAAB194CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7BB3B4EF2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BF1DB958;
	Sun,  3 Aug 2025 18:20:34 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95311A0BFD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754245233; cv=none; b=TKVMWwhhMlgj+XOWc6ipZ1uXaJ27f79DAV9tdySorJcLeJwe/KxdOgzIltbdyfwZ9ZR1J8RZipB6+F/0NHaX41g4YaidNwkIOeYTBexmoxgBRmwpHZJm0zAUbsbHkeWjiRFHmNu7ITc56w8IWMtnfRQUuERKTpDELgr8B9mt1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754245233; c=relaxed/simple;
	bh=NjjVo3lWZzu8pGRMNj93L0tybbl5TltHD0egOYfdCQo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M8KJQTegznSIstQ7mH0NgranSJbWquh9oR2siQo3WZKcc1ipne9V1b2l5bF90tIzrAwpTe80BWlLdaKjDE6FCjkQIYrZPucv4ow4BBzN5pE/6WBt6212loMFtPU2SP08OTz60EB0ZWvntk6qEMgLm+bIxDvypjqoehHM1wbndVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-881855cd566so4158939f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 11:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754245231; x=1754850031;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGNWppTo5YZzyltnum5m/mtHptC81GgrgQ89+dFnk60=;
        b=MnyC4YpqOjc4eb2NkdEXgKhAAF90H+P/Gr2Mu7hqUjweZgRaTvAErRKAfuOMrapsQn
         x2k7LOGMaGOJBPOxR2i48Ern2EC9sGc5wnru9LvMPebgi3cusgbdWbM/8Lx7H3SCBO+H
         bLwD+ilzkCtbruBSnA+QlXQD81IcvwK6a2rQoPweh1SNsjqysBQ/a/jABT6wk3CSG0G2
         EyzZL8ZEWR6XsnbPLcZojQOl0yakfAXH+IcPmlGmnicjMiYJX8GB4FH4jLxPVBrOzfjn
         3YkxOwPm458xuyjb2E/AHTjPOWU9ADoB0QIfRsDNpEF6XQFQukN1+zjLIKtvGVjRw6xO
         KBFw==
X-Forwarded-Encrypted: i=1; AJvYcCXsDaVHrdVe2kRAzjqocdA6CnywXpfpdX59USr55rNG1CR/t6294n3tHYbrP0H7KRA+y00isza+KByE+Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/AGwk84YuLXxzqqthuPeqYPKhcAM1+shBsr61XEkrQOm5sx8
	nf4Y8ahP2ORfXBDSVrXsfcN43m8Zg/RLteCqui4HUTlB4WwZKekwtKA+L/7+8gqDNY6npATr/mo
	stKHqp7raJwKZG+CXXUXbVoF8Vr87UYIxiWXz2n7bQl0kUM0QeA9gdq8MzSI=
X-Google-Smtp-Source: AGHT+IEE+d3/OmO1kJZBGH685TlEbaME/y+31MbEM7I9PkI87JkptKndiWDN2q9+WWTBrAXRIBw/H7S/+3Z74JeXq9KI5558VFwI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260e:b0:3df:4ad5:3a71 with SMTP id
 e9e14a558f8ab-3e416191e61mr118995105ab.11.1754245230972; Sun, 03 Aug 2025
 11:20:30 -0700 (PDT)
Date: Sun, 03 Aug 2025 11:20:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688fa86e.050a0220.1fc43d.0005.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in vfs_coredump (2)
From: syzbot <syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d086c886ceb9 Add linux-next specific files for 20250718
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=127b0ca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69896dd7b8c4e81e
dashboard link: https://syzkaller.appspot.com/bug?extid=6ed94e81a1492fe1d512
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dbcca2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13238834580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54504fbc2437/disk-d086c886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b427b00abffe/vmlinux-d086c886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a87731b006b/bzImage-d086c886.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com

INFO: task syz-executor104:5856 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc6-next-20250718-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor104 state:D stack:26808 pid:5856  tgid:5854  ppid:5853   task_flags:0x400640 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5351 [inline]
 __schedule+0x1737/0x4d30 kernel/sched/core.c:6954
 __schedule_loop kernel/sched/core.c:7036 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7051
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x3da/0x710 kernel/sched/completion.c:121
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:269
 coredump_wait fs/coredump.c:534 [inline]
 vfs_coredump+0x8c2/0x2ab0 fs/coredump.c:1128
 get_signal+0x1109/0x1340 kernel/signal.c:3019
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bc88c77a9
RSP: 002b:00007f7bc885f198 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 00000000000000ca RBX: 00007f7bc89513f8 RCX: 00007f7bc88c77a9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f7bc89513fc
RBP: 00007f7bc89513f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7bc891e0c4
R13: 000000000000006e R14: 00002000000003c0 R15: 00002000000001c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e53d8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e53d8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e53d8a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
2 locks held by getty/5611:
 #0: ffff88814d1c60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036cc2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc6-next-20250718-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.16.0-rc6-next-20250718-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: d3 e8 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 13 ba 28 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c2
RAX: eba1d665c07d2f00 RBX: ffffffff8196da38 RCX: eba1d665c07d2f00
RDX: 0000000000000001 RSI: ffffffff8dc6a0fe RDI: ffffffff8c04d400
RBP: ffffc90000197f20 R08: ffff8880b8732f5b R09: 1ffff110170e65eb
R10: dffffc0000000000 R11: ffffed10170e65ec R12: ffffffff8fe3cf30
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff11003a55b40
FS:  0000000000000000(0000) GS:ffff8881258ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563b2a68e168 CR3: 000000000e338000 CR4: 00000000003526f0
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

