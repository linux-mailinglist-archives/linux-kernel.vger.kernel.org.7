Return-Path: <linux-kernel+bounces-859799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FAFBEEA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F4E3A7445
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD64321D3DF;
	Sun, 19 Oct 2025 16:33:28 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383EF18DB1E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891608; cv=none; b=eeLXc4iVeuGhGCz2LI3aCuijtDCtTMS8r1Fae6REj0k84XwP+kFUnGEtmQC57RmPfmN+1F5wOurRIhQUntrNzeh4oNr1PT3h6glFNfmWJUmwMb01H0056XxPj/a45OJUPeUU0dQMQJBNhYpZazcpFinlaAO186RYP0Ye5WHuoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891608; c=relaxed/simple;
	bh=wCWcLokxFrmFReGjoodfEjIeDBURtrAW3emGcaCFWg4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u2MwXp6yuW0lfTHSkpYh8i2XKyj0Ejvo3gPS4gMOnGXWGZ57pUmY7HOpz2q7A2di80ApLM5G90y02unq1rB92Eq0jNGQ1Zb+ZXXm9Q5OLfmoEBGUU2UmBXA9POZ0kVhMVB+b/EWM5iBYvv8YUIKD5bKHF9OAp47o/n6amFDkQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e8d8d2617so100031039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760891605; x=1761496405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1KJv+qs0B3zFUnwQZzmbh8LwEH75DX7bWl4f+JRZJo=;
        b=ti9j88jlQWfJnRG1WlAxt6lXcNq2eX7sesLWSezF3SKLhZYoZb/QCy1BigO6YPGPaN
         tE3WCJ0rmZ85pI9WO5lXxYE8nndTtlM5S1wa00SKrcDDeIuNApZoSdz2Dkeb5dVrTooo
         lnopxbQaVBKcBO9ZWoKkXPBn8w0v4UOCkxnORTo1vphh/lvOL+3dYzqBYG+fozazZB3h
         2SDBEutHNlqd26k8hCDjVUSuybrsmNKTZpCdygSmwvOh/oJ0V0Y7AUdZcGGRmu5Mq7CJ
         0nVInuQsl8VrrPQkqCMnsHCKBnfclDF6fs8sHKWD7KpY3UP4N7a0jP+wTIclFNHz7s76
         cTUg==
X-Forwarded-Encrypted: i=1; AJvYcCUqVA3cEqx70/sTtNvb31EUMvA/QMiAtmnCBR2F8vrMs4tcgsftbc/PQy6Ff5QlOf3J3AyalodMaY/xIf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6vgLPgD79n7pciiT43x4PJw2b30Ja5pkV/eXg0W0Dixgm84h
	UtY1T6rTD3+0MZc1NohrdgJmjnH3Ec+OBAHUZVK17u3B5MQrVEzu2Rx4FQ8ELfYAQ94Gn13MUXr
	W13bqq663x4Ma5XBU9kWIH2vlqCtOJRcWQDIgb8lc8+VSXMh/nQgRhQL4hqQ=
X-Google-Smtp-Source: AGHT+IGWtxWfMIjo59vxUogdNmmue0hH0qpXZy2SrjTOgRA4LTI3gFddZQyHtUBz4zH8Ip3frHVqX21OFiMDn85fntdmaIvw2bDc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:5c2:b0:93e:8d3c:7ce1 with SMTP id
 ca18e2360f4ac-93e8d3c7f48mr658239339f.0.1760891605273; Sun, 19 Oct 2025
 09:33:25 -0700 (PDT)
Date: Sun, 19 Oct 2025 09:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f512d5.a70a0220.205af.0019.GAE@google.com>
Subject: [syzbot] [comedi?] inconsistent lock state in valid_state (6)
From: syzbot <syzbot+a0cafc3f8cfebb67a088@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, gregkh@linuxfoundation.org, 
	hsweeten@visionengravers.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    93f3bab4310d Add linux-next specific files for 20251017
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f3f5e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13d823f401f2bb44
dashboard link: https://syzkaller.appspot.com/bug?extid=a0cafc3f8cfebb67a088
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfa9b5bd373e/disk-93f3bab4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f36271412fd/vmlinux-93f3bab4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d9cdcb1778ab/bzImage-93f3bab4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0cafc3f8cfebb67a088@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
syzkaller #0 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
syz.6.2492/15234 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffffffff8b04aec8 ((&dev->delay)){+.?.}-{0:0}, at: kernfs_remove_by_name_ns+0x3d/0x130 fs/kernfs/dir.c:1712
{IN-SOFTIRQ-W} state was registered at:
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
  call_timer_fn+0xdb/0x5f0 kernel/time/timer.c:1744
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
  handle_softirqs+0x286/0x870 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  invoke_softirq kernel/softirq.c:496 [inline]
  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
  debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.c:320
  mt_slot lib/maple_tree.c:734 [inline]
  mas_slot lib/maple_tree.c:767 [inline]
  mt_validate_nulls lib/maple_tree.c:7122 [inline]
  mt_validate+0x3d7c/0x4390 lib/maple_tree.c:7177
  validate_mm+0xae/0x4a0 mm/vma.c:651
  __split_vma+0x8bd/0xa00 mm/vma.c:569
  vms_gather_munmap_vmas+0x2e2/0x12e0 mm/vma.c:1359
  __mmap_setup mm/vma.c:2375 [inline]
  __mmap_region mm/vma.c:2669 [inline]
  mmap_region+0x724/0x1c70 mm/vma.c:2764
  do_mmap+0xc45/0x10d0 mm/mmap.c:558
  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:581
  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 487
hardirqs last  enabled at (487): [<ffffffff82263c7d>] kasan_quarantine_put+0xdd/0x220 mm/kasan/quarantine.c:234
hardirqs last disabled at (486): [<ffffffff82263bdd>] kasan_quarantine_put+0x3d/0x220 mm/kasan/quarantine.c:207
softirqs last  enabled at (352): [<ffffffff81693698>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (352): [<ffffffff81693698>] fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
softirqs last  enabled at (352): [<ffffffff81693698>] kernel_fpu_end+0xc8/0x120 arch/x86/kernel/fpu/core.c:479
softirqs last disabled at (350): [<ffffffff816932da>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (350): [<ffffffff816932da>] fpregs_lock arch/x86/include/asm/fpu/api.h:69 [inline]
softirqs last disabled at (350): [<ffffffff816932da>] kernel_fpu_begin_mask+0xba/0x3a0 arch/x86/kernel/fpu/core.c:448

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((&dev->delay));
  <Interrupt>
    lock((&dev->delay));

 *** DEADLOCK ***

2 locks held by syz.6.2492/15234:
 #0: ffff88814c6558f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_unlocked_ioctl+0x13a/0x1020 drivers/comedi/comedi_fops.c:2166
 #1: ffff88814c655990 (&dev->attach_lock){++++}-{4:4}, at: do_devconfig_ioctl drivers/comedi/comedi_fops.c:841 [inline]
 #1: ffff88814c655990 (&dev->attach_lock){++++}-{4:4}, at: comedi_unlocked_ioctl+0x615/0x1020 drivers/comedi/comedi_fops.c:2178

stack backtrace:
CPU: 1 UID: 0 PID: 15234 Comm: syz.6.2492 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_usage_bug+0x297/0x2e0 kernel/locking/lockdep.c:4042
 valid_state+0xc3/0xf0 kernel/locking/lockdep.c:4056
 mark_lock_irq+0x36/0x390 kernel/locking/lockdep.c:4267
 mark_lock+0x11b/0x190 kernel/locking/lockdep.c:4753
 mark_usage kernel/locking/lockdep.c:-1 [inline]
 __lock_acquire+0x9e2/0xd20 kernel/locking/lockdep.c:5191
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 kernfs_remove_by_name_ns+0x3d/0x130 fs/kernfs/dir.c:1712
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x198/0x2f0 drivers/base/bus.c:743
 comedi_device_detach_locked+0x178/0x750 drivers/comedi/drivers.c:207
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:848 [inline]
 comedi_unlocked_ioctl+0xcde/0x1020 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f952678efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f95249cd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f95269e6090 RCX: 00007f952678efc9
RDX: 0000000000000000 RSI: 0000000040946400 RDI: 0000000000000007
RBP: 00007f9526811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f95269e6128 R14: 00007f95269e6090 R15: 00007fff0c18c5f8
 </TASK>
BUG: unable to handle page fault for address: ffffffff8b04ae58
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD df3d067 P4D df3d067 PUD df3e063 PMD b0001a1 
Oops: Oops: 0003 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 15234 Comm: syz.6.2492 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:arch_atomic64_try_cmpxchg arch/x86/include/asm/atomic64_64.h:101 [inline]
RIP: 0010:raw_atomic64_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4296 [inline]
RIP: 0010:raw_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:1482 [inline]
RIP: 0010:atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4458 [inline]
RIP: 0010:rwsem_write_trylock kernel/locking/rwsem.c:268 [inline]
RIP: 0010:__down_write_common kernel/locking/rwsem.c:1316 [inline]
RIP: 0010:__down_write kernel/locking/rwsem.c:1326 [inline]
RIP: 0010:down_write+0xd1/0x1f0 kernel/locking/rwsem.c:1591
Code: 24 20 00 00 00 00 48 89 df be 08 00 00 00 e8 06 1b dd f6 4c 89 f7 be 08 00 00 00 e8 f9 1a dd f6 48 8b 44 24 20 b9 01 00 00 00 <f0> 48 0f b1 0b 0f 85 c2 00 00 00 48 c7 c0 90 0b 9e 8f 48 c1 e8 03
RSP: 0018:ffffc9000bc379a0 EFLAGS: 00010256
RAX: 0000000000000000 RBX: ffffffff8b04ae58 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000bc379c0
RBP: ffffc9000bc37a28 R08: ffffc9000bc379c7 R09: 1ffff92001786f38
R10: dffffc0000000000 R11: fffff52001786f39 R12: 1ffff92001786f34
R13: dffffc0000000000 R14: ffffc9000bc379c0 R15: dffffc0000000000
FS:  00007f95249cd6c0(0000) GS:ffff888125e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8b04ae58 CR3: 0000000078bb2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kernfs_remove_by_name_ns+0x3d/0x130 fs/kernfs/dir.c:1712
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x198/0x2f0 drivers/base/bus.c:743
 comedi_device_detach_locked+0x178/0x750 drivers/comedi/drivers.c:207
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:848 [inline]
 comedi_unlocked_ioctl+0xcde/0x1020 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f952678efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f95249cd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f95269e6090 RCX: 00007f952678efc9
RDX: 0000000000000000 RSI: 0000000040946400 RDI: 0000000000000007
RBP: 00007f9526811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f95269e6128 R14: 00007f95269e6090 R15: 00007fff0c18c5f8
 </TASK>
Modules linked in:
CR2: ffffffff8b04ae58
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic64_try_cmpxchg arch/x86/include/asm/atomic64_64.h:101 [inline]
RIP: 0010:raw_atomic64_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4296 [inline]
RIP: 0010:raw_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:1482 [inline]
RIP: 0010:atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4458 [inline]
RIP: 0010:rwsem_write_trylock kernel/locking/rwsem.c:268 [inline]
RIP: 0010:__down_write_common kernel/locking/rwsem.c:1316 [inline]
RIP: 0010:__down_write kernel/locking/rwsem.c:1326 [inline]
RIP: 0010:down_write+0xd1/0x1f0 kernel/locking/rwsem.c:1591
Code: 24 20 00 00 00 00 48 89 df be 08 00 00 00 e8 06 1b dd f6 4c 89 f7 be 08 00 00 00 e8 f9 1a dd f6 48 8b 44 24 20 b9 01 00 00 00 <f0> 48 0f b1 0b 0f 85 c2 00 00 00 48 c7 c0 90 0b 9e 8f 48 c1 e8 03
RSP: 0018:ffffc9000bc379a0 EFLAGS: 00010256
RAX: 0000000000000000 RBX: ffffffff8b04ae58 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000bc379c0
RBP: ffffc9000bc37a28 R08: ffffc9000bc379c7 R09: 1ffff92001786f38
R10: dffffc0000000000 R11: fffff52001786f39 R12: 1ffff92001786f34
R13: dffffc0000000000 R14: ffffc9000bc379c0 R15: dffffc0000000000
FS:  00007f95249cd6c0(0000) GS:ffff888125e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8b04ae58 CR3: 0000000078bb2000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	24 20                	and    $0x20,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	48 89 df             	mov    %rbx,%rdi
   9:	be 08 00 00 00       	mov    $0x8,%esi
   e:	e8 06 1b dd f6       	call   0xf6dd1b19
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	be 08 00 00 00       	mov    $0x8,%esi
  1b:	e8 f9 1a dd f6       	call   0xf6dd1b19
  20:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  25:	b9 01 00 00 00       	mov    $0x1,%ecx
* 2a:	f0 48 0f b1 0b       	lock cmpxchg %rcx,(%rbx) <-- trapping instruction
  2f:	0f 85 c2 00 00 00    	jne    0xf7
  35:	48 c7 c0 90 0b 9e 8f 	mov    $0xffffffff8f9e0b90,%rax
  3c:	48 c1 e8 03          	shr    $0x3,%rax


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

