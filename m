Return-Path: <linux-kernel+bounces-726754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98664B010C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125491AA7EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D27082D;
	Fri, 11 Jul 2025 01:25:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3D3A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197105; cv=none; b=W9oJAaZqICUGt/IbdgBVmI+B1eZ3shaORB2fr588Oo6zIyPMRsJEsvfyT8OyKnFg0lqF3qsKGsNFAjcegbwKlBbNkmAT6p/H9jhn3p6BoK9rZOUkyWbN3893S6ZwWD5SQlv+xtxsQdCR4i4lA55wtvYXbIXIoFAiuTbiaX419TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197105; c=relaxed/simple;
	bh=7ZgT+wvQGdq1cEDPITP8OozQNP1JwnhD/oJcLEgIKHc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aV0C9B4fYX3jbW7YmAoPFK5Y2W787jLbiDxDWFF3vbDIdxWnGqWtPHy6WoOftWmeuJWLCu4ZaERwG+bFTOL/mPV+aeM4ULd6hzLmNbt9x5Hr/yXGSCcTj2tvfp1RzFnAs6kGhhzrCL/gTwKJPQMSbHrLNzG6c+JCyLr7g6b0J5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d126265baso155621639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752197103; x=1752801903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEGfLH7V8iQXTJSKtJnOw/tDBj6c4VC9ecbRrcWPZ5M=;
        b=U0oGg7Gga8cvoZ1tZf4YRVMshSUeyAghhPNCgIQ2a2LnO1TmeBO+KjQhtoG93EdI1Z
         SqlvyDZCC+IipEvp5Kkrnj49aJoLpe0TB59zNnmzLBgR9T9cQ130+hFoDHxLIYQGkFEn
         p4u7RGXGN1S9NE+UyaFswH2Xl14toiUkW/ZMbjEPBwKI9doVjxYPAequ/ki+jZFPmEbV
         ywWjRWd4CNQSKsmum/lc2OA0sbNvi9g5vO4gbYlc728ER/ZRihS9/1YNG5uSn66mcfYe
         sLM99KVIGgG20AfmzalgqEEewOHVGlHU658uhaVf2cQCAr8rcYCMMXnd7z5Tq9kFS2gJ
         y7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVzrFk+y+mR1vdDMX3yYNJTa3YMaoNTDPzwbx07AN5yOBGTY47eYzqZGTKLI0zpuC+s8+GbMUDZLktQpPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHufKjGny6PzMb+regjFd2Udzp+kGoYqVv3o3rs/V2Ri1GUIs7
	wC5MFUYnNkWlhOoZEYeqBkJZ6g1YkDfCwrIdVFBcqmxk1TG7PR9xL8joBHKcUkpeoQp+nyciW6X
	xfbEB0sB9PfNBX4xs/BekPyKd+eCOuqoFQSyQ5uCGdUCIeh+L8sKl2UeCRwk=
X-Google-Smtp-Source: AGHT+IExhZrTmLvlIYV6V/N7P9yWC4NFIUC9SCJmj5yIQksNYDdtog2XTX0IktS4oNl9PjfunZkVwrOt6xbr3F/ZjxXqz1kFd6rV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7401:b0:875:bbf0:8bf with SMTP id
 ca18e2360f4ac-87977f775d0mr228540439f.5.1752197103069; Thu, 10 Jul 2025
 18:25:03 -0700 (PDT)
Date: Thu, 10 Jul 2025 18:25:03 -0700
In-Reply-To: <20250711003220.3259-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687067ef.a00a0220.26a83e.002b.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in query_matching_vma

=====================================
WARNING: bad unlock balance detected!
6.16.0-rc5-next-20250710-syzkaller-08625-gb551c4e2a98a-dirty #0 Not tainted
-------------------------------------
syz.0.40/6692 is trying to release lock (vm_lock) at:
[<ffffffff825976c4>] get_next_vma fs/proc/task_mmu.c:181 [inline]
[<ffffffff825976c4>] query_vma_find_by_addr fs/proc/task_mmu.c:513 [inline]
[<ffffffff825976c4>] query_matching_vma+0x344/0x600 fs/proc/task_mmu.c:545
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.0.40/6692:
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: query_vma_find_by_addr fs/proc/task_mmu.c:511 [inline]
 #0: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: query_matching_vma+0x152/0x600 fs/proc/task_mmu.c:545

stack backtrace:
CPU: 1 UID: 0 PID: 6692 Comm: syz.0.40 Not tainted 6.16.0-rc5-next-20250710-syzkaller-08625-gb551c4e2a98a-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5301
 __lock_release kernel/locking/lockdep.c:5540 [inline]
 lock_release+0x269/0x3e0 kernel/locking/lockdep.c:5892
 vma_refcount_put include/linux/mmap_lock.h:141 [inline]
 vma_end_read include/linux/mmap_lock.h:237 [inline]
 unlock_vma+0x70/0x180 fs/proc/task_mmu.c:135
 get_next_vma fs/proc/task_mmu.c:181 [inline]
 query_vma_find_by_addr fs/proc/task_mmu.c:513 [inline]
 query_matching_vma+0x344/0x600 fs/proc/task_mmu.c:545
 do_procmap_query fs/proc/task_mmu.c:631 [inline]
 procfs_procmap_ioctl+0x3f9/0xd50 fs/proc/task_mmu.c:749
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c38b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c399b2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2c38db6080 RCX: 00007f2c38b8e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
RBP: 00007f2c38c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2c38db6080 R15: 00007fff905431d8
 </TASK>
------------[ cut here ]------------
WARNING: ./include/linux/mmap_lock.h:292 at vma_assert_attached include/linux/mmap_lock.h:292 [inline], CPU#0: syz.0.40/6692
WARNING: ./include/linux/mmap_lock.h:292 at vma_mark_detached+0x1fa/0x2d0 mm/mmap_lock.c:109, CPU#0: syz.0.40/6692
Modules linked in:
CPU: 0 UID: 0 PID: 6692 Comm: syz.0.40 Not tainted 6.16.0-rc5-next-20250710-syzkaller-08625-gb551c4e2a98a-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:vma_assert_attached include/linux/mmap_lock.h:292 [inline]
RIP: 0010:vma_mark_detached+0x1fa/0x2d0 mm/mmap_lock.c:109
Code: 48 8b 05 09 f2 9a 10 48 3b 44 24 08 0f 85 d0 00 00 00 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc e8 27 a8 b5 ff 90 <0f> 0b 90 e9 45 ff ff ff e8 19 a8 b5 ff 90 0f 0b 90 e9 92 fe ff ff
RSP: 0018:ffffc90003b6f7c0 EFLAGS: 00010293
RAX: ffffffff820a0e39 RBX: ffff88807904b280 RCX: ffff888033a68000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88807904b303 R09: 1ffff1100f209660
R10: dffffc0000000000 R11: ffffed100f209661 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88807904b300 R15: ffff888049f08c20
FS:  0000000000000000(0000) GS:ffff888125bd0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f93657ae7d0 CR3: 000000000df36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 exit_mmap+0x537/0xb50 mm/mmap.c:1307
 __mmput+0x118/0x420 kernel/fork.c:1120
 exit_mm+0x1da/0x2c0 kernel/exit.c:581
 do_exit+0x648/0x2300 kernel/exit.c:947
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c38b8e929
Code: Unable to access opcode bytes at 0x7f2c38b8e8ff.
RSP: 002b:00007f2c399b20e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f2c38db6088 RCX: 00007f2c38b8e929
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f2c38db6088
RBP: 00007f2c38db6080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2c38db608c
R13: 0000000000000000 R14: 00007fff905430f0 R15: 00007fff905431d8
 </TASK>


Tested on:

commit:         b551c4e2 Add linux-next specific files for 20250710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16fa20f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90b2e63e925474ab
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127d3a8c580000


