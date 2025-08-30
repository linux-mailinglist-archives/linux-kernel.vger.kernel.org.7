Return-Path: <linux-kernel+bounces-792682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA4AB3C78B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A35826B1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EAB25A2C3;
	Sat, 30 Aug 2025 03:03:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242346F06B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756522987; cv=none; b=chH4H6CMUzpbqrIJEu3QBSAEBx13QL7hDmW4OIqagaLoN4BkIl4ma8A0M2CTVebiv0/+SyenjBEEAdN80t34KFTDxNV4e+yZC2PsuFnleoNJK/FxWg2gOh/iM5kGwLGF/4Xnk+URe6xFDf4p2kp59vOg6K+pl/m8NHPfVShwRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756522987; c=relaxed/simple;
	bh=+xWXUXb2F584KaDlAB/QkQb/NkoZ+2wwvbauqbihPKQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yi1pkw0UYL70jraRorrq7DreafZX+wYo3abLo7auXjPnILU/5moxB7pA+axTadiJnSMi3O7zThZeiA2o/PGCUKHok94cMGn3qillRaVsJIYwtddXN8T7ndxGtNSNwVvLcQ1fdb7pneF1YPk37kbtTC5qPbdGrs2XUeg3krgAyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ed0ba44c8fso32458255ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756522985; x=1757127785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHQEpGqFkvxwu8Uv/g7zCnBjm1+Wez0oY4H7G674t98=;
        b=aa1AYd3vsGZt04EcfE1QrkJIgL9fy9AWy9rEvYPSdq8ZMHHCg8KM35v8/cHWsnW0dk
         0BB/wdLazXuaKhpl8uvuX/mick8G3xD1oJ22cmrnvKfn6y1N6KODJjDv5e1QTUmdjSYd
         FGdRaDMGmAgGfQaXWBCx5aW7cE3tS+h+zWHYWg0r71CgX1oSJWDNOd00khGuOfev0ivT
         a8gtPMDwUPkZ3WRqjyE5Djk1RkM/l02FRm4mWV1HmPblfpVmmIBBCnhzAxU1yb6rf1Zb
         7B5SDKDjSyaX54Q0srQvaCROJ+AgZlU/0SiY9oQu6CX9rdCF/dTIlaHnc3wh+IeYd8aX
         m83Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC9ITR4iCO3hESeOMGnQXC3UcatFCCsBLIWU6RUiU9be+caz1Yb4BaERG1DH5DdsV1kj6614onc8E1ZiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+tjpUIBB7oPXQtzhEzuKMMaPlxoMG0Xy+WOh////eTpz0Gr/
	2l0E3Go3x5mI5TGezg9KzwligFeD5S7LcNiircyZrMWW1YondgTioCpSjw4qyBxvWKI+fPfqzxO
	ibEmIlclqUoqAs1uMaeTyb7sMXjWcv2In2YbjKBiGVIBtmq8x49jcI9jh+Wk=
X-Google-Smtp-Source: AGHT+IEhRZOQ/7O4PLMbB/vSO+4iXYkbFhvOW6jP0wd6O0PjNTT2nP5rg5UAC03X0DaceIkOKgP9HB726OkFNMsNBBixu3ZGEkLG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3ec:6e58:beb5 with SMTP id
 e9e14a558f8ab-3f3ffda2ecamr21128805ab.3.1756522985190; Fri, 29 Aug 2025
 20:03:05 -0700 (PDT)
Date: Fri, 29 Aug 2025 20:03:05 -0700
In-Reply-To: <20250830004549.6070-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b269e9.a00a0220.1337b0.001f.GAE@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
From: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __snd_pcm_lib_xfer

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.46/6843 is trying to acquire lock:
ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168

but task is already holding lock:
ffff88814ccb7150 (&group->lock#2){+.+.}-{3:3}, at: __snd_pcm_lib_xfer+0x386/0x1ce0 sound/core/pcm_lib.c:2319

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&group->lock#2){+.+.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:44 [inline]
       _snd_pcm_stream_lock_irqsave+0x7c/0xa0 sound/core/pcm_native.c:171
       class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:682 [inline]
       snd_pcm_period_elapsed+0x1e/0x80 sound/core/pcm_lib.c:1938
       dummy_hrtimer_callback+0x80/0x180 sound/drivers/dummy.c:386
       __run_hrtimer kernel/time/hrtimer.c:1763 [inline]
       __hrtimer_run_queues+0x590/0xda0 kernel/time/hrtimer.c:1829
       hrtimer_run_softirq+0x1a3/0x2e0 kernel/time/hrtimer.c:1847
       handle_softirqs+0x22c/0x710 kernel/softirq.c:579
       __do_softirq kernel/softirq.c:613 [inline]
       run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
       smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
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
       vfs_write+0x287/0xb40 fs/read_write.c:684
       ksys_write+0x14b/0x260 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&group->lock#2);
                               lock((softirq_ctrl.lock));
                               lock(&group->lock#2);
  lock((softirq_ctrl.lock));

 *** DEADLOCK ***

2 locks held by syz.0.46/6843:
 #0: ffff88814ccb7150 (&group->lock#2){+.+.}-{3:3}, at: __snd_pcm_lib_xfer+0x386/0x1ce0 sound/core/pcm_lib.c:2319
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #1: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57

stack backtrace:
CPU: 0 UID: 0 PID: 6843 Comm: syz.0.46 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
 vfs_write+0x287/0xb40 fs/read_write.c:684
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9528fcebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f952863e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f95291f5fa0 RCX: 00007f9528fcebe9
RDX: 000000000000fc36 RSI: 0000200000000500 RDI: 0000000000000003
RBP: 00007f9529051e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f95291f6038 R14: 00007f95291f5fa0 R15: 00007ffe192e0268
 </TASK>


Tested on:

commit:         11e7861d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d8d634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=10b4363fb0f46527f3f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b7fef0580000


