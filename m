Return-Path: <linux-kernel+bounces-893856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B1C4884A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26733AE2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92932A3FE;
	Mon, 10 Nov 2025 18:19:34 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F332939E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798773; cv=none; b=qqRj/39Z0w8s4KXI7GUZZd2hnyN/DEbsQc6HC5yLcvn38XzAmbqpDPggv1LGTHAf4ECkPVKZPepl4ibyEkg9BYq71cDNYyl4mMA6mVshh2FDoJpdNBNNLviZgtROvYAoFUjhfsSjBk9a6Dq7K4yCOv1kxskFcUN0YmFXDysAh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798773; c=relaxed/simple;
	bh=olKFaO/OI2/liOcPRH5LB4YfTWeqsev/dMmMcseUwUg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UAE9IIM8xoeHmhGyHfsyAGXtJR/ovbG7gN/cAP6Oqi0uxrJXF3GtKIUgdHhd2Ra90j3GbYGSa6Vk4p9/5GnXmthMHXjf12gZHMfLvS4rwkCcnalQQphqN+INRAlgqRPqIdeEuXoLAEF89Hj6cv0uFOQeNivkaJxsMTv/yI2oNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-948a2f950fcso145897839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798771; x=1763403571;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmE3j6LxMOU0XTkDOfjLYMmbajGt/pVI8XUPpcWT/4g=;
        b=YEnCtVls1cA6nUFqrF35IyytGvnSo7BrJSLnh1lqEftShRxTOSoiGPUiDiJEIqNypT
         9lOXrLHJvhXkJWDg4zkhLgB2PmMy8khrirBbzWLXLpiVej8BDQPWonXR6+QIp3jChLYb
         taBXQ2no7oXVxyONAp8Cg8nu6OX7x162zTjNlF9ma8bVTIVBS2eSUSpkHlIBt1iuNSCZ
         BJSEc1ik+ASJ8XNIa+69twn9Qky+eE1QmQaY89HHMQdlRQebh3hpI/syswvFCu6Oi9n1
         /8wV2zVvONTlmK+3RoOYaYG8GRheqYgzLtEp0WQcbesyoNSrYluLykodhZV+1I+g29TS
         bNag==
X-Forwarded-Encrypted: i=1; AJvYcCWuhHH9sU/sq3Hi/FoKrbyZyBmMMg2L5qcteuLXryAiq/E0yq6OxoelFOIKPZgSV515orUoTSFnV4waa5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZObI1N1hIIEAHRLsIf7klT1y1lb4DqyhEeUMhhKgd/ZeEWG6
	7sgNgfTBQjP5Yl+Hso9vsDjXJetJdnU7MCuFomW9bMJSkum8xQlzXQLklXiyhwneCEoGVqxYCNT
	ovJ/7phM7ZCTMFApCHpkcWndNT2SkYtRrjcjR42kJPWnyUeMA5cNTtPgcBdE=
X-Google-Smtp-Source: AGHT+IFwiJZ+Y0/N7OFBA8xydfNiDpVXBtb1ugetPqR0xN9WqGYlLs3Ju1g/vrlLJiU8dybpDGIc9JS1FMpgm4giDu5GF42keP1I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:433:4f6b:4ca with SMTP id
 e9e14a558f8ab-43367e487cdmr103026575ab.24.1762798771097; Mon, 10 Nov 2025
 10:19:31 -0800 (PST)
Date: Mon, 10 Nov 2025 10:19:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69122cb3.a70a0220.22f260.00ff.GAE@google.com>
Subject: [syzbot] [perf?] WARNING in perf_event_throttle_group
From: syzbot <syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e427054ae7bc Merge branch 'x86-fgraph-bpf-fix-orc-stack-un..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11f2cb42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=a945e9d15c8a49a7a7f0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128bea92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b5a412580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1ac942fc5fb/disk-e427054a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be05ef12ba31/vmlinux-e427054a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c75604292a15/bzImage-e427054a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7448 at kernel/events/core.c:2703 perf_event_throttle_group+0x375/0x3d0 kernel/events/core.c:2703
Modules linked in:
CPU: 1 UID: 0 PID: 7448 Comm: syz.0.1231 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:perf_event_throttle_group+0x375/0x3d0 kernel/events/core.c:2703
Code: 8a 32 00 e9 ec fe ff ff e8 38 d5 cc ff eb 05 e8 31 d5 cc ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 1c d5 cc ff 90 <0f> 0b 90 e9 54 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c c9
RSP: 0018:ffffc9000ca07490 EFLAGS: 00010293
RAX: ffffffff81f34174 RBX: ffff88806fddf6c0 RCX: ffff888026e3bc80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffffc9000ca07137 R09: 0000000000000000
R10: ffffc9000ca07120 R11: fffff52001940e27 R12: ffff88806fddf8d8
R13: dffffc0000000000 R14: ffff88806fddf8f8 R15: ffffffff8dff1598
FS:  0000555573ca6500(0000) GS:ffff88812623d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000040 CR3: 0000000028a98000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __perf_event_account_interrupt+0x23c/0x250 kernel/events/core.c:10180
 __perf_event_overflow+0x105/0xe40 kernel/events/core.c:10327
 perf_swevent_overflow kernel/events/core.c:10467 [inline]
 perf_swevent_event+0x530/0x5e0 kernel/events/core.c:10505
 perf_tp_event+0x4f6/0x1380 kernel/events/core.c:11012
 perf_trace_run_bpf_submit+0xee/0x170 kernel/events/core.c:10936
 do_perf_trace_lock_acquire include/trace/events/lock.h:24 [inline]
 perf_trace_lock_acquire+0x335/0x410 include/trace/events/lock.h:24
 __do_trace_lock_acquire include/trace/events/lock.h:24 [inline]
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x311/0x360 kernel/locking/lockdep.c:5831
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 futex_hash+0x5d/0x2d0 kernel/futex/core.c:308
 class_hb_constructor kernel/futex/futex.h:240 [inline]
 futex_wake+0x161/0x560 kernel/futex/waitwake.c:172
 do_futex+0x395/0x420 kernel/futex/syscalls.c:135
 __do_sys_futex kernel/futex/syscalls.c:207 [inline]
 __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:188
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdfcf98f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe276dac28 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fdfcfbe5fa8 RCX: 00007fdfcf98f6c9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fdfcfbe5fac
RBP: 0000000000000000 R08: 3fffffffffffffff R09: 0000000a276daf1f
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdfcfbe5fac
R13: 00007fdfcfbe5fa0 R14: 0000000000000843 R15: 0000000000000003
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

