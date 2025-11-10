Return-Path: <linux-kernel+bounces-893239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D359BC46E19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDABC4EB930
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFD3112C9;
	Mon, 10 Nov 2025 13:26:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567923C516
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781169; cv=none; b=rp802Nh4+HGFxw/KHZSpBMysUK9Pzi8xuwR8afMRNDhpdOQX533xpfMccfKnT55zt3hBNOHd9eqWjg1yzUIkxn/ilkyRWgfTd1KH7pZwfcq7Vx6toKj3RRfuySu1zt4F0gJO2mMzblD+fgodYYJ+wZIWTpIXLZVs4m+HMLrEowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781169; c=relaxed/simple;
	bh=jpl820u4xqEQj21r7/Sd5I5iNARlE8jFb9U2ve07v9M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=svdg9IIyMZfZT2hkUPRV8Jbl3dTJLaSVI8Ynt+I8zovdRnR4wHjbFd7FYfssjGu+UQptpKnF6BAdvcIj5p33wtTCPY3IfNuzqBASKy5vhYGabrf1wKKWCno5NO+062yoiHO+MwZp2xWmCeGuKs7+Bvj8weYyl/5nxNZWNGTinLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43322fcfae7so31924735ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781163; x=1763385963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWPmA5ByIN83KuFF/M88/3sCZ3J8qGVXvwhWHs5b6FM=;
        b=kkX4NRk7yC3DDg3bPOJTNFQ13CMC3x5Dd/8mCeBKNkAo3PifcAmeGu3PFZ24SxRsoM
         NevqwSwr9ttx9lxM/PXlbbqyI2prPR+8P6wT8/l8WW6HyXRfDmj7HXBe/ljSt3/Q+EUL
         bZaVp1Yk9ock+JenOyf0kFPOkAfW9zD1MCV1BCWy4aPlUXBRkBVTvA2Ir32EOeuvKxGZ
         OQTtSGUsJKWwaQ+XeIZEvP9aoO//14DS/LNHj5SAmgtW+/wgbQaRaxLq3Lg7XgLuVfgN
         ayGO9MJ+nChllC2YnTjSa5IJnzbHPHZdjXrO8iVMIkF6ImpkdGPDTw+0F5TyegLJHlfs
         W3KA==
X-Forwarded-Encrypted: i=1; AJvYcCUVNOO7FKbSWjDF6J4cX3BX/eKgDH/ge1nNrYbViDx6vfZjREZuzdSWkze2bFhMv8wn7uL5p2YxqcRE1g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwWrP9Bph0wTP+qc0ei3o/GBuTPl3PLEaYi0aQn2+moxm2Ktb
	SxaYfvyo4qRsBzoWa+yH7cXSmj78OtRqq0jjmVISiMtlxDt6QVSMObZKedFENOpmeT7ApKNrVIz
	d6+FgvO4Dzn25OsU9r4R1yzq/X5hQn/Ckt3U7OJV3lPr7rLRCOJxc6HxaeP4=
X-Google-Smtp-Source: AGHT+IHEBHHTbl3rMlqtHSV862xM3/mejMXKb60CexxEsFCWZPkZtQke4OvkTJP5pUjmPQByJvcgc+xhplSzVNLU7c9VpDantu1d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e91:b0:433:7a5f:9437 with SMTP id
 e9e14a558f8ab-4337a5f94bemr57767005ab.1.1762781163553; Mon, 10 Nov 2025
 05:26:03 -0800 (PST)
Date: Mon, 10 Nov 2025 05:26:03 -0800
In-Reply-To: <tencent_86ACA44F17673776A6C75364C3720966E305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911e7eb.a70a0220.22f260.00f2.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in lbmIOWait

loop1: detected capacity change from 0 to 32768
=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz.1.18/6461 is trying to release lock (jfsLCacheLock) at:
[<ffffffff833d0e04>] spin_unlock_irqrestore include/linux/spinlock_rt.h:122 [inline]
[<ffffffff833d0e04>] lbmIOWait+0x1d4/0x610 fs/jfs/jfs_logmgr.c:2150
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.1.18/6461:
 #0: ffff888027e480d0 (&type->s_umount_key#53/1){+.+.}-{4:4}, at: alloc_super+0x1ba/0x9a0 fs/super.c:344

stack backtrace:
CPU: 1 UID: 0 PID: 6461 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5537 [inline]
 lock_release+0x269/0x3e0 kernel/locking/lockdep.c:5889
 rt_spin_unlock+0x29/0x200 kernel/locking/spinlock_rt.c:80
 spin_unlock_irqrestore include/linux/spinlock_rt.h:122 [inline]
 lbmIOWait+0x1d4/0x610 fs/jfs/jfs_logmgr.c:2150
 lmLogInit+0xeb1/0x1a00 fs/jfs/jfs_logmgr.c:1372
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b7cee0e6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b7c545e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0b7c545ef0 RCX: 00007f0b7cee0e6a
RDX: 0000200000000400 RSI: 0000200000000380 RDI: 00007f0b7c545eb0
RBP: 0000200000000400 R08: 00007f0b7c545ef0 R09: 000000000001c802
R10: 000000000001c802 R11: 0000000000000246 R12: 0000200000000380
R13: 00007f0b7c545eb0 R14: 0000000000005f74 R15: 0000200000002740
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6461 at ./include/linux/sched.h:2353 __migrate_enable include/linux/sched.h:2353 [inline]
WARNING: CPU: 1 PID: 6461 at ./include/linux/sched.h:2353 migrate_enable include/linux/sched.h:2417 [inline]
WARNING: CPU: 1 PID: 6461 at ./include/linux/sched.h:2353 rt_spin_unlock+0x174/0x200 kernel/locking/spinlock_rt.c:81
Modules linked in:
CPU: 1 UID: 0 PID: 6461 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__migrate_enable include/linux/sched.h:2353 [inline]
RIP: 0010:migrate_enable include/linux/sched.h:2417 [inline]
RIP: 0010:rt_spin_unlock+0x174/0x200 kernel/locking/spinlock_rt.c:81
Code: 8d 35 00 00 00 00 48 c7 c7 40 a8 5a 8d e8 e4 36 d9 f6 e8 af f1 e2 f6 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9d 00 00 00 90 <0f> 0b 90 eb 8d e8 32 4c cd f6 e9 1b ff ff ff 44 89 f1 80 e1 07 fe
RSP: 0018:ffffc900041f7708 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8d9dfb40 RCX: ecc696ffabe70d00
RDX: 0000000000000000 RSI: ffffffff8cf64ad6 RDI: ffffffff8b3ddd60
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1a90bc0 R12: 1ffff11004a2e090
R13: ffff888025170000 R14: ffff888025170480 R15: dffffc0000000000
FS:  00007f0b7c5466c0(0000) GS:ffff888126ef7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51a5c94000 CR3: 000000005514c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 spin_unlock_irqrestore include/linux/spinlock_rt.h:122 [inline]
 lbmIOWait+0x1d4/0x610 fs/jfs/jfs_logmgr.c:2150
 lmLogInit+0xeb1/0x1a00 fs/jfs/jfs_logmgr.c:1372
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b7cee0e6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b7c545e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0b7c545ef0 RCX: 00007f0b7cee0e6a
RDX: 0000200000000400 RSI: 0000200000000380 RDI: 00007f0b7c545eb0
RBP: 0000200000000400 R08: 00007f0b7c545ef0 R09: 000000000001c802
R10: 000000000001c802 R11: 0000000000000246 R12: 0000200000000380
R13: 00007f0b7c545eb0 R14: 0000000000005f74 R15: 0000200000002740
 </TASK>


Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134a30b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a4b412580000


