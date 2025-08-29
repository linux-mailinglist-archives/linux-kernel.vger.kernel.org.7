Return-Path: <linux-kernel+bounces-792468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED4B3C450
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736DA1CC14DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262862765D0;
	Fri, 29 Aug 2025 21:46:39 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130581B87C0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503998; cv=none; b=Xe2XfGhqYUaHEjBqZebjhtopgoXyIaBtky1W8r4ywUj2NBgixxEhEiA9AVGVWqS1pzG4PSA/2AbTdwKHwQErTQbgc0YYm7EsudpboxhoS7s9qWX1mXTb1IATOZuD9bmxKYgfzwJOl9eTdOi/BqhckoO/IoOk7ilHh87N/CAXaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503998; c=relaxed/simple;
	bh=hKWDvRqmQr3ZQflFF1omTQ1oekC7H1hjYm0m35k8ex8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iMNJrD17FLBzPi4UDuKbqDtmcStqNPZ/MlIJpKHAmpHE/gU5vDQn+0pF4AgQzNO3OQQzM4p+ZpbnPrBGJXcyfqFN/2GbcLN79OJp+r/iDDjVhfnJ848DTRsTl/hHqlbUCPaHZRUNTvgSXkztzX16TyyAPrJdqbthpPU2OvChCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f1ebcf0863so27103515ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756503996; x=1757108796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ7K9ruquIqemeNU1LnUs5tXuMs3y+0vYUtTi6EIPrM=;
        b=N6uMnUyRGeidErK9fiMoLhzPbefXjSp8Jei74cTLKbVVaOl7M46QwbP6FRJYw6EFXN
         EqSiXAk+tElELF52wXywgywm5iS1kJ2bxOk73QY/VwWdCSo+8R0OXugPzVDTDLj4elA1
         4Gwhkee+DQOwCn9lIvpZEdi5p4lGBu2FN5j97FjxxCY4BEqgPPvbvNKLPL1elrwGj+LY
         ku/FDfN6+g9bl0Rt2OAA0aZLRNvpmMnig278oPqttHClat6o9lsQADAtgNMXeiTiosdr
         zuN2oA/reAwLHC1DEASZ75gNTT3qhVZLmIwqqQmEPOpcUlRybLWVSAt1+Uju4efaM25H
         R5lw==
X-Forwarded-Encrypted: i=1; AJvYcCUWbE6UX1IP9UdxBynScm0BWCik2q/dqbEAYYE7E+JSAdTZ+ldAnXWnFfSbmadsimXGQDAai2WYNCZa/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4CY36U0sEK1KBae8fe1Vjv7Y4z8t13vQcxL1PKc8kj6R9myi
	tMeC1zLzLrOEkyl3WsR52Lby8Y4pkgcK9PGq5vmCBF2KtpFFFMKOeUHeqIjsWdVkHuAYvygyFQR
	LYeeAr/gXjPdw72M9vMlHYGFB/Uu0AyjilosIZrdD9nj7r1dnTd9KKv9UqPo=
X-Google-Smtp-Source: AGHT+IHK4VqJQn9TVZ+z7ck1sVNEKNeueQCg+P477ryERP25b6Kd6zjZuzVaqbGTlBHplAk2f94ESIynjjo3aJnHtC72FpBtrc7u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198e:b0:3f0:a48b:151b with SMTP id
 e9e14a558f8ab-3f4026c300bmr2368905ab.31.1756503996107; Fri, 29 Aug 2025
 14:46:36 -0700 (PDT)
Date: Fri, 29 Aug 2025 14:46:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b21fbc.a70a0220.f8cc2.00fd.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in worker_attach_to_pool (3)
From: syzbot <syzbot+a50479d6d26ffd27e13b@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b237f190eb3 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a96ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=a50479d6d26ffd27e13b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12397862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b11c42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d469fb7e3a4/disk-1b237f19.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4114df4f6a8b/vmlinux-1b237f19.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa16b8bb6a18/bzImage-1b237f19.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a50479d6d26ffd27e13b@syzkaller.appspotmail.com

INFO: task kworker/1:0:24 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:26792 pid:24    tgid:24    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (mld)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x81b/0x1060 kernel/locking/mutex.c:760
 worker_attach_to_pool+0x27/0x420 kernel/workqueue.c:2676
 create_worker+0x2a9/0x7e0 kernel/workqueue.c:2818
 maybe_create_worker kernel/workqueue.c:3061 [inline]
 manage_workers kernel/workqueue.c:3113 [inline]
 worker_thread+0x9dd/0xf10 kernel/workqueue.c:3375
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:7:6151 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:31320 pid:6151  tgid:6151  ppid:2      task_flags:0x4208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 kthread+0x236/0x780 kernel/kthread.c:451
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:7:6152 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:7     state:D stack:31320 pid:6152  tgid:6152  ppid:2      task_flags:0x4208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961


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

