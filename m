Return-Path: <linux-kernel+bounces-792313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D758B3C293
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DB65858E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F0345749;
	Fri, 29 Aug 2025 18:38:39 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC9341ACA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492718; cv=none; b=G9j3FB7IR9Arvbl7ACQ7nSbIBG4S/vmar0k4TIkNjI16lmO5OAGZPjrRVaepKoQxrFdOOXPrOwL9mqOhZY7HJL/DikdJ4UqkoGyCvIhx9dMMmbe2+3KGaa9zUn8ZRi/l38FdW45h7iCOhTQeQ9e2KvSbzK5Z2703JdGUtaN522s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492718; c=relaxed/simple;
	bh=OfUB/67JDHrbHFb22OnUeyYH/uNgHdYyRgex7vcvqdo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FExqNxWPAERdsV2sRS/XmJ3fZVWEUnfDcxTg2GFd7Z1lvA6Ag3xhdB4lAvJsZPOEMmoqmwOomYqkvsdrjtv8vZiT2lmlvi0gzJZaHEHM/N+5ZYiskJsrOyxTyKX2tYe4keymGbfB2UiO6c05Zq9MC+hZo/bqzF203zalAUJZXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f0c32654afso25118515ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492716; x=1757097516;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHBiohU/IfnNy2/jJyGGyYEu33yWuNinuwBomxj9yEQ=;
        b=w7H84oyGYNmE5ppcCgL/6B/+tBactNVtZ6lJHO/OfT7lNkJLf7qxnmLnptjF1LToFM
         XAkt5G39FTvrWm7RHiSrcN9ioPWw8CKHMp/YNtGKpY+D5wZtVQwTJUrsaNlNiNgCJGEF
         PN573bGHR2wztCkOZ9W4C1en19sknLk7LWS/6Vz0QDmepgQTY08HrEc9govfWXm7zUzF
         Nr0rC8qbJFhcbhga8u79MNRPNWylvhaRePr2u4oUmhe2/d68iop/w1kKx/u4llZgI3rt
         VaakUpnOHYKZnyh3ChJNMP4LGYZ/Q2UqNPBSrjiFsLOjWt0NgrVBLHaLulLOL7oVASTK
         y6YQ==
X-Gm-Message-State: AOJu0YxyxTyebNpjg1UqUnXHZusY0t+nBKOOtW/ZXZ7cteL5XUEJPbmY
	zKQWoFoLNKgKC0Z8f9XCpjg8E0/qSmjyusLNXv9knhsfGKYoVgK19+3zrKCQA6WAeBAVJGXAoXu
	xQCvGWduBkVZpuGvCqHBoNB7gBh1ZaU7lco2rcxMlw0Ns/kmbCatcADZFJaXspw==
X-Google-Smtp-Source: AGHT+IFGv+wpZE1GHk3unJetyIUwzS3tvVpwcmglg5i9LgXXoOGGyIx73gWWeXKx+Mv25meuzgRc0/Fwv9KBRvV2VvFPq9ztgYxx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c3:b0:3f3:1321:1ed5 with SMTP id
 e9e14a558f8ab-3f3d15af642mr4662815ab.0.1756492715908; Fri, 29 Aug 2025
 11:38:35 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:38:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
Subject: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
From: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17333fbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=10b4363fb0f46527f3f3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e9262580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ed0242580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdf0bbb7922b/disk-07d9df80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1975bf771ed/vmlinux-07d9df80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/942416e1bedd/bzImage-07d9df80.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.48/6160 is trying to acquire lock:
ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
ffff8880b8923d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168

but task is already holding lock:
ffff88802f930150 (&group->lock#2){+.+.}-{3:3}, at: __snd_pcm_lib_xfer+0x386/0x1ce0 sound/core/pcm_lib.c:2319

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&group->lock#2){+.+.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:44 [inline]
       _snd_pcm_stream_lock_irqsave+0x7c/0xa0 sound/core/pcm_native.c:171
       class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:682 [inline]
       snd_pcm_period_elapsed+0x1e/0x80 sound/core/pcm_lib.c:1938
       dummy_hrtimer_callback+0x80/0x180 sound/drivers/dummy.c:386
       __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
       __hrtimer_run_queues+0x54f/0xd40 kernel/time/hrtimer.c:1825
       hrtimer_run_softirq+0x1a3/0x2e0 kernel/time/hrtimer.c:1842
       handle_softirqs+0x22c/0x710 kernel/softirq.c:579
       __do_softirq kernel/softirq.c:613 [inline]
       run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
       smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&base->softirq_expiry_lock){+...}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:44 [inline]
       hrtimer_cpu_base_lock_expiry kernel/time/hrtimer.c:1383 [inline]
       hrtimer_run_softirq+0x7c/0x2e0 kernel/time/hrtimer.c:1838
       handle_softirqs+0x22c/0x710 kernel/softirq.c:579
       __do_softirq kernel/softirq.c:613 [inline]
       run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
       smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((softirq_ctrl.lock)){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
       __local_bh_enable_ip+0x10c/0x270 kernel/softirq.c:228
       hrtimer_cancel+0x39/0x60 kernel/time/hrtimer.c:1491
       dummy_hrtimer_stop+0xcf/0x100 sound/drivers/dummy.c:410
       snd_pcm_do_stop+0x12a/0x1c0 sound/core/pcm_native.c:1525
       snd_pcm_action_single sound/core/pcm_native.c:1305 [inline]
       snd_pcm_action+0xe4/0x240 sound/core/pcm_native.c:1388
       __snd_pcm_xrun+0x27f/0x7c0 sound/core/pcm_lib.c:180
       snd_pcm_update_state+0x342/0x430 sound/core/pcm_lib.c:224
       snd_pcm_update_hw_ptr0+0x10b2/0x1b00 sound/core/pcm_lib.c:493
       snd_pcm_update_hw_ptr sound/core/pcm_lib.c:499 [inline]
       __snd_pcm_lib_xfer+0x510/0x1ce0 sound/core/pcm_lib.c:2326
       snd_pcm_oss_write3+0x1bc/0x320 sound/core/oss/pcm_oss.c:1241
       snd_pcm_plug_write_transfer+0x2cb/0x4c0 sound/core/oss/pcm_plugin.c:630
       snd_pcm_oss_write2 sound/core/oss/pcm_oss.c:1373 [inline]
       snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1439 [inline]
       snd_pcm_oss_write+0xba2/0x11a0 sound/core/oss/pcm_oss.c:2795
       vfs_write+0x284/0xb40 fs/read_write.c:684
       ksys_write+0x14b/0x260 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (softirq_ctrl.lock) --> &base->softirq_expiry_lock --> &group->lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&group->lock#2);
                               lock(&base->softirq_expiry_lock);
                               lock(&group->lock#2);
  lock((softirq_ctrl.lock));

 *** DEADLOCK ***

2 locks held by syz.0.48/6160:
 #0: ffff88802f930150 (&group->lock#2){+.+.}-{3:3}, at: __snd_pcm_lib_xfer+0x386/0x1ce0 sound/core/pcm_lib.c:2319
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57

stack backtrace:
CPU: 1 UID: 0 PID: 6160 Comm: syz.0.48 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
 __lock_release kernel/locking/lockdep.c:5574 [inline]
 lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
 __local_bh_enable_ip+0x10c/0x270 kernel/softirq.c:228
 hrtimer_cancel+0x39/0x60 kernel/time/hrtimer.c:1491
 dummy_hrtimer_stop+0xcf/0x100 sound/drivers/dummy.c:410
 snd_pcm_do_stop+0x12a/0x1c0 sound/core/pcm_native.c:1525
 snd_pcm_action_single sound/core/pcm_native.c:1305 [inline]
 snd_pcm_action+0xe4/0x240 sound/core/pcm_native.c:1388
 __snd_pcm_xrun+0x27f/0x7c0 sound/core/pcm_lib.c:180
 snd_pcm_update_state+0x342/0x430 sound/core/pcm_lib.c:224
 snd_pcm_update_hw_ptr0+0x10b2/0x1b00 sound/core/pcm_lib.c:493
 snd_pcm_update_hw_ptr sound/core/pcm_lib.c:499 [inline]
 __snd_pcm_lib_xfer+0x510/0x1ce0 sound/core/pcm_lib.c:2326
 snd_pcm_oss_write3+0x1bc/0x320 sound/core/oss/pcm_oss.c:1241
 snd_pcm_plug_write_transfer+0x2cb/0x4c0 sound/core/oss/pcm_plugin.c:630
 snd_pcm_oss_write2 sound/core/oss/pcm_oss.c:1373 [inline]
 snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1439 [inline]
 snd_pcm_oss_write+0xba2/0x11a0 sound/core/oss/pcm_oss.c:2795
 vfs_write+0x284/0xb40 fs/read_write.c:684
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e7a70ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe73a3cd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0e7a935fa0 RCX: 00007f0e7a70ebe9
RDX: 000000000000fc36 RSI: 0000200000000500 RDI: 0000000000000003
RBP: 00007f0e7a791e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0e7a935fa0 R14: 00007f0e7a935fa0 R15: 0000000000000003
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

