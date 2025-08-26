Return-Path: <linux-kernel+bounces-787142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD8B371E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EC336628D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B833680B4;
	Tue, 26 Aug 2025 18:03:41 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29957322C70
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231420; cv=none; b=Z+VfXtXjJcDJMGgD7BX8nwfGnYe0M+MIwtMNCgqJpmyaouDEIT1HrKB0s+sM/uGd3UJD/8BszloXsO2N+Rl97Me27zPP798HI+nvMH2ltWxj2HKXtMCb5O1l1QODN4SOE9Gw18YfwqzV6p6LEv/tR76GS8PLl9lTC6EGX/DOSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231420; c=relaxed/simple;
	bh=9Fd/OGAbNTjvQVsCC770Cymc9rBqjfYkhbkSQm0cn5w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nq+HlASyQsWky2+apKgXRbiktaOuVo1ratINzy++jwvqru9EhbgUjQpXxDO8wdYAYH/TQ9QcbPTM9hmqo7gLwnsoNQGI56CAaDCwcUVyGhycNafjhP6m5WK9g3b7unjW17rCMB28RnB+qEuwXsakP5lba4vBWy3zvSUQ7mfvobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886e2e808d0so203766239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231418; x=1756836218;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jee1SPohgLWvDGFphulqzmgE+y+1pMrI8cs2Wryp8LI=;
        b=DzdssP07eppFh1RixJppPn0TvEjYGeRbYTe+Dz+Hl6iLygSoV/Hrw+w4rQz75oGHRi
         VB6+cDwydD03Tdg5OclO9HTs9TKxNp0/CefXWhJNfplxkHLGc05NiTSaWMGD6Lg7MmAg
         PEQ9vK08/T/qstQmnhdtMuRivpfsGOkwbLyyMMuYS415D1aB4V4b9pFZRkVlndegLcL+
         eE6ssqm9k7aFA8IhLTDhrrGfUGYwex/UJngizmemPlQrtzntWFwEnER1H4Kdt/te1uoY
         owADW4sHfCa+6CkRJZEmklmdVSzYo4bUvNifryZ3qsHI43h2Y9LsbbDYadZhg8p+ZnSV
         lIug==
X-Forwarded-Encrypted: i=1; AJvYcCV4SiTS4iu2pFFSrlp3MgvwU3JGVycd0roWolbQCGj/DUTvgNwC+krfwCPqBFqZRmTLJpwY12UosZdfB8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sQWZSOP1PJnbLfB2ejQ/fecK6Zp3p9VhxaJyQc7BgFv0rSib
	rVk/OgcvuSMxo5O8LRIjX2SjGhvErMRhKxpWsgw1C6GWKRusmxNL7qR6LoRGHbkEUtEGtIHWx3Z
	Lf0OPY2WXKNTVhJUS1KrV32sA/e16tMpUX3D42ud372J8U5hpFfBWmELdn+g=
X-Google-Smtp-Source: AGHT+IHM/4UQBgBxVmC3OCA6lszfoFadB711vNP2kTRVMK/pKoDB1iqhG9SN5miGqY7xLnxk8K2+Xkr0y3OgsVzWrsCGxE9uSgzq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:3e5:4631:54a5 with SMTP id
 e9e14a558f8ab-3e921f3be05mr272322575ab.18.1756231418094; Tue, 26 Aug 2025
 11:03:38 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:03:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68adf6fa.a70a0220.3cafd4.0000.GAE@google.com>
Subject: [syzbot] [net?] WARNING in est_timer
From: syzbot <syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1056cef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=72db9ee39db57c3fecc5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a4b062580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/096739d8f0ec/disk-8d245acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83a21aa9b978/vmlinux-8d245acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e7f165a3b29/bzImage-8d245acc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 29 at ./include/linux/seqlock.h:221 __seqprop_assert include/linux/seqlock.h:221 [inline]
WARNING: CPU: 1 PID: 29 at ./include/linux/seqlock.h:221 est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
RIP: 0010:est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
Code: ff c7 42 80 3c 23 00 74 08 4c 89 f7 e8 6d 3b 41 f9 4d 89 3e 42 80 3c 23 00 0f 85 54 ff ff ff e9 57 ff ff ff e8 45 05 e2 f8 90 <0f> 0b 90 e9 63 fd ff ff 44 89 e1 80 e1 07 38 c1 0f 8c 65 fa ff ff
RSP: 0018:ffffc90000a3f7a0 EFLAGS: 00010246
RAX: ffffffff88dc56fb RBX: 0000000000000001 RCX: ffff88801caf1dc0
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: ffffc90000a3f8b0 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: fffff52000147f0a R12: 0000000000000008
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88814a58d468
FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc221f97d60 CR3: 00000000320ec000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

