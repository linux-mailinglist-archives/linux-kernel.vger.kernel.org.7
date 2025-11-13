Return-Path: <linux-kernel+bounces-898644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04692C55A50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7953E3B1D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B062FC880;
	Thu, 13 Nov 2025 04:26:31 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8F2C2356
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007991; cv=none; b=oZ8AO3b3g6g6yvDgv5pr5z0Zf8at/Uy28odsj57RPeeAydJV7NHL3fyBzthpqCHl60qhgF/T5YFcwl6/s7vhJB/yFLE+JXecjurzwL0t14Hh830hwpHukFyzvSMyYK1fxIrM9az9bkPGdwsmaaShA71B//3nuB5ps7S53qHg8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007991; c=relaxed/simple;
	bh=zwwzQTtkZoHfbYa4iRU3GSF71L0tgx0FKgsrB5HB93s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=njB+CunqX+kKfUnIjFWRqg1lWPWTwv1BEh68Xtbw+RenZlbKqeo2xNoPVm03wyFhRjSzlxi2tmAwQrX9TOSUjE9iye9ZBj4X4pIN1jNsS/4cXH0+rwrAK92e/nvh9FkYLJtRUsrGS9bIcKVe8lCjv/IE74UWhyNwezUcEUcMuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-948bf83a707so48820839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007989; x=1763612789;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0Rx6L1+w26eDoBTECfkHB2YqAHqLGAXj0nMqUi2dAE=;
        b=BQSQd1BgHbOOLMBHVbmXBEUNvEXWMSXg3Fwk+7bQJnyA+VnOQ3slD4xdobert/CNSU
         KBgustDaZ+bKBcPm0dUqQj2IV4H4rQKO7YgPxShzF6/WZ7iqD6v+e09Aci0y4y8Hx46u
         K/cKjtqdGF+4wMy8GGJBuOpuVbIF1kEGxl49MXunB+T/Fq5E/SbIsq8BQMygchL3IJ39
         3c9PF3dTI3AYs0AD3/yGrCJDiqe/IFDHI8cnJR1WfviwN8kRfq2FAInPYAxWrCNBHZKM
         MI4m8YG0MfCOFxJ1vGjicUFlm+JaZxsxEqJRYd0AOXkL5ZOvE8YdO9Riz5/xtzfwqCJv
         lroA==
X-Forwarded-Encrypted: i=1; AJvYcCUh+Rggnb/VG9YG4wjgCLnlwjLocPVNbrwDAcdMM9ZfpzkP135jQzpUNnWA0znpKwCCbdCWHvPzimNNubs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXVMA/7m8njAyAoPV0t0mMSSc1CP1AeQ/ZbsKcyCGrDVZUgzA
	Ip0iDTQ96xMit5NzuLr1QR2+pZIBr/+LnyPJHzQBfFxOD5hi2YbZFUGfRyu92rwgINqpScifQox
	gaw4j2XSoNNjBPkXnuev/ZljQei88XD5868FRvIGboH1IQJF7W19vQoRknac=
X-Google-Smtp-Source: AGHT+IFGP2aGge1aNspOUN0DVQ6Or2ZF+OJQTIpDjuXGfsu5Oc9Delqy3Vs+nB0n3JH4PkDi0bC1Yo64NrX6Grh75Uier9/jJGbW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1606:b0:433:30e0:6f68 with SMTP id
 e9e14a558f8ab-43473dcf8ebmr59135945ab.24.1763007988927; Wed, 12 Nov 2025
 20:26:28 -0800 (PST)
Date: Wed, 12 Nov 2025 20:26:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69155df4.a70a0220.3124cb.0017.GAE@google.com>
Subject: [syzbot] [kernel?] memory leak in do_timer_create
From: syzbot <syzbot+9c47ad18f978d4394986@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24172e0d7990 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165417cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=9c47ad18f978d4394986
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15004914580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ea6b42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ded911fa4408/disk-24172e0d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1f3e61cb784/vmlinux-24172e0d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b92fd0e25cb7/bzImage-24172e0d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c47ad18f978d4394986@syzkaller.appspotmail.com

2025/11/12 09:47:51 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888108465800 (size 384):
  comm "syz.0.17", pid 6100, jiffies 4294944668
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1025e73e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    alloc_posix_timer kernel/time/posix-timers.c:429 [inline]
    do_timer_create+0xe0/0x800 kernel/time/posix-timers.c:478
    __do_sys_timer_create kernel/time/posix-timers.c:584 [inline]
    __se_sys_timer_create kernel/time/posix-timers.c:573 [inline]
    __x64_sys_timer_create+0xdb/0xf0 kernel/time/posix-timers.c:573
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881084a0000 (size 384):
  comm "syz.0.18", pid 6104, jiffies 4294944670
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 63c47fd0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    alloc_posix_timer kernel/time/posix-timers.c:429 [inline]
    do_timer_create+0xe0/0x800 kernel/time/posix-timers.c:478
    __do_sys_timer_create kernel/time/posix-timers.c:584 [inline]
    __se_sys_timer_create kernel/time/posix-timers.c:573 [inline]
    __x64_sys_timer_create+0xdb/0xf0 kernel/time/posix-timers.c:573
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881084a0180 (size 384):
  comm "syz.0.19", pid 6107, jiffies 4294944671
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d769495f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    alloc_posix_timer kernel/time/posix-timers.c:429 [inline]
    do_timer_create+0xe0/0x800 kernel/time/posix-timers.c:478
    __do_sys_timer_create kernel/time/posix-timers.c:584 [inline]
    __se_sys_timer_create kernel/time/posix-timers.c:573 [inline]
    __x64_sys_timer_create+0xdb/0xf0 kernel/time/posix-timers.c:573
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888108464600 (size 384):
  comm "syz.0.20", pid 6127, jiffies 4294945201
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a3c907e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    alloc_posix_timer kernel/time/posix-timers.c:429 [inline]
    do_timer_create+0xe0/0x800 kernel/time/posix-timers.c:478
    __do_sys_timer_create kernel/time/posix-timers.c:584 [inline]
    __se_sys_timer_create kernel/time/posix-timers.c:573 [inline]
    __x64_sys_timer_create+0xdb/0xf0 kernel/time/posix-timers.c:573
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881084a0300 (size 384):
  comm "syz.0.21", pid 6128, jiffies 4294945201
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc bb0da4da):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    alloc_posix_timer kernel/time/posix-timers.c:429 [inline]
    do_timer_create+0xe0/0x800 kernel/time/posix-timers.c:478
    __do_sys_timer_create kernel/time/posix-timers.c:584 [inline]
    __se_sys_timer_create kernel/time/posix-timers.c:573 [inline]
    __x64_sys_timer_create+0xdb/0xf0 kernel/time/posix-timers.c:573
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

