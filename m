Return-Path: <linux-kernel+bounces-870171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7DC0A198
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAA864E385C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F4823EAB0;
	Sun, 26 Oct 2025 01:13:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD21221D87
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761441211; cv=none; b=UPbNAN+YSYHEj/6jZorMwWD3ALK4KFvrTezKe9IFa1ljWDzaQHVh0/JDYmOE+sXOp6BT/HNj1UJYo4OXfABm3vSab6B/fvpZ8kBUK8ILqTbXVLUWTR5rtzB14SyGc7Hq8mV0hAWDqFTA9z2h6rvS4uWUHBUz1P1gAdzORaIbZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761441211; c=relaxed/simple;
	bh=yZNSZAaAP8XTL+7fHEKhij0JEuH1mWTASoGpNAaKT84=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vFBEqOCV4N6JJxdNkcbvaxEYsXUfToue57eI9hqybjmCXLLf10ZBO3ByiPLitInCays/xOwc9cqf2DD02EwjqMF0MZA4t5SBwsQHwBzeM1wdO0ruN/O1jBXSryt8qvA+QCJQoPPA77VzTaPVq0J/XD1sDItrSC72fqhAkVgDKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-431db4650b7so47647085ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761441208; x=1762046008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IZU6g05Z0PoHSaNTfoKrSsnvOT/w1h4LtDavdgSvoo=;
        b=aVyLDchZl1kbt9/oxtxeCHrZST1sQ61BgwT7qh3bf331iHd3Myx+zAnbuo2coNdCbl
         yx89qfIC2C3v47StqFIcQu1LFtjBcyjAMrYIkPaUH73GyhO3JgxVZ3q5CM0OHQYcWVqV
         mYVbpy5tizmSqKMxACduvpbXik++06baXzUBzJz4j9upr6I/kCzg7Bd8PFnvuyBObq5U
         R+YStdfo55Y47XOmYVeLtsna8AQm7B4RBdz8AqY5PSZF1cG6KbW/C17FKh0JdLf+3/0T
         ORybOMzFN0dSoVt6/vvZzAashI2nNb0PsSp3eQ/6TsFPhhlEZQHezWk+ET0WCpQe/Rqh
         lUBw==
X-Forwarded-Encrypted: i=1; AJvYcCXBKcR7RLR4re92rLUNsCzHqit1hyvtki1rprM3KX1iavxjIofc0HKm+A1gOg3Anj3Eso5OXHuaCU5sQ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8qH0pclLI8ZoNvIwdgC3K0MbI2D6udYgcZe6rpQ9+oePQ3fK
	vMk7AYmtj71Ob6IoHW32aUBUtnXqC9BNEwswbHsoL0IxSRWjQHOTPvv6m7USljITwQNsCjSTQpq
	TgbNxqMpBLej0gaadoTZTLEAB5TlygZvzinllWZQKmuziGjnBLlx/En6r8i4=
X-Google-Smtp-Source: AGHT+IEcnRmfHBgWT4pSOIIuD8IOq8QQrdqx1ILMOd1z6VsvEOhf4+6NU3uguKkPAWXWI0j0Wt6oCvSetTfSLWnaTD6Wlz/QpJa5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:430:ab63:69d6 with SMTP id
 e9e14a558f8ab-430c527dc00mr408584285ab.21.1761441208586; Sat, 25 Oct 2025
 18:13:28 -0700 (PDT)
Date: Sat, 25 Oct 2025 18:13:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fd75b8.050a0220.346f24.03e0.GAE@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in cgroup_kn_lock_live
From: syzbot <syzbot+77c195c2ab76e1dffd96@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    552c50713f27 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130b53e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94e79a41e05959dd
dashboard link: https://syzkaller.appspot.com/bug?extid=77c195c2ab76e1dffd96
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff21b83406f0/disk-552c5071.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca4d7185104e/vmlinux-552c5071.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69833d927f04/bzImage-552c5071.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77c195c2ab76e1dffd96@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G     U             
------------------------------------------------------
syz.5.6541/25846 is trying to acquire lock:
ffffffff8e41fd48 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
ffffffff8e41fd48 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1735

but task is already holding lock:
ffff888038fdd0c8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
ffff888038fdd0c8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: vfs_rmdir fs/namei.c:4537 [inline]
ffff888038fdd0c8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: vfs_rmdir+0xe9/0x690 fs/namei.c:4525

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&type->i_mutex_dir_key#6){++++}-{4:4}:
       down_read+0x9b/0x480 kernel/locking/rwsem.c:1537
       inode_lock_shared include/linux/fs.h:995 [inline]
       lookup_slow fs/namei.c:1832 [inline]
       walk_component+0x345/0x5b0 fs/namei.c:2151
       lookup_last fs/namei.c:2652 [inline]
       path_lookupat+0x142/0x6d0 fs/namei.c:2676
       filename_lookup+0x224/0x5f0 fs/namei.c:2705
       kern_path+0x35/0x50 fs/namei.c:2863
       lookup_bdev+0xd8/0x280 block/bdev.c:1205
       bdev_file_open_by_path+0x82/0x330 block/bdev.c:1078
       add_device drivers/mtd/devices/block2mtd.c:279 [inline]
       block2mtd_setup2+0x317/0xe10 drivers/mtd/devices/block2mtd.c:459
       block2mtd_setup+0xbd/0x110 drivers/mtd/devices/block2mtd.c:476
       param_attr_store+0x199/0x300 kernel/params.c:589
       module_attr_store+0x58/0x80 kernel/params.c:919
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d3/0x11d0 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (param_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       ieee80211_rate_control_ops_get net/mac80211/rate.c:223 [inline]
       rate_control_alloc net/mac80211/rate.c:269 [inline]
       ieee80211_init_rate_ctrl_alg+0x18d/0x6b0 net/mac80211/rate.c:1016
       ieee80211_register_hw+0x21b5/0x4120 net/mac80211/main.c:1535
       mac80211_hwsim_new_radio+0x32d8/0x50b0 drivers/net/wireless/virtual/mac80211_hwsim.c:5803
       init_mac80211_hwsim+0x44e/0x900 drivers/net/wireless/virtual/mac80211_hwsim.c:7167
       do_one_initcall+0x123/0x6e0 init/main.c:1283
       do_initcall_level init/main.c:1345 [inline]
       do_initcalls init/main.c:1361 [inline]
       do_basic_setup init/main.c:1380 [inline]
       kernel_init_freeable+0x5c8/0x920 init/main.c:1593
       kernel_init+0x1c/0x2b0 init/main.c:1483
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       cgrp_css_online+0xa2/0x1f0 net/core/netprio_cgroup.c:157
       online_css+0xb2/0x350 kernel/cgroup/cgroup.c:5735
       css_create kernel/cgroup/cgroup.c:5823 [inline]
       cgroup_apply_control_enable+0x702/0xbb0 kernel/cgroup/cgroup.c:3391
       cgroup_mkdir+0x5e0/0x1310 kernel/cgroup/cgroup.c:6024
       kernfs_iop_mkdir+0x111/0x190 fs/kernfs/dir.c:1268
       vfs_mkdir+0x593/0x8c0 fs/namei.c:4453
       do_mkdirat+0x304/0x3e0 fs/namei.c:4486
       __do_sys_mkdirat fs/namei.c:4503 [inline]
       __se_sys_mkdirat fs/namei.c:4501 [inline]
       __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4501
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (cgroup_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       cgroup_lock include/linux/cgroup.h:393 [inline]
       cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1735
       cgroup_rmdir+0x20/0x2b0 kernel/cgroup/cgroup.c:6229
       kernfs_iop_rmdir+0x106/0x170 fs/kernfs/dir.c:1286
       vfs_rmdir fs/namei.c:4548 [inline]
       vfs_rmdir+0x206/0x690 fs/namei.c:4525
       do_rmdir+0x2e8/0x3c0 fs/namei.c:4603
       __do_sys_rmdir fs/namei.c:4622 [inline]
       __se_sys_rmdir fs/namei.c:4620 [inline]
       __x64_sys_rmdir+0xc5/0x110 fs/namei.c:4620
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  cgroup_mutex --> param_lock --> &type->i_mutex_dir_key#6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#6);
                               lock(param_lock);
                               lock(&type->i_mutex_dir_key#6);
  lock(cgroup_mutex);

 *** DEADLOCK ***

3 locks held by syz.5.6541/25846:
 #0: ffff888033b9a420 (sb_writers#9){.+.+}-{0:0}, at: do_rmdir+0x1e2/0x3c0 fs/namei.c:4591
 #1: ffff88805fb0b7f0 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
 #1: ffff88805fb0b7f0 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_rmdir+0x233/0x3c0 fs/namei.c:4595
 #2: ffff888038fdd0c8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #2: ffff888038fdd0c8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: vfs_rmdir fs/namei.c:4537 [inline]
 #2: ffff888038fdd0c8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: vfs_rmdir+0xe9/0x690 fs/namei.c:4525

stack backtrace:
CPU: 0 UID: 0 PID: 25846 Comm: syz.5.6541 Tainted: G     U              syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:598 [inline]
 __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
 cgroup_lock include/linux/cgroup.h:393 [inline]
 cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1735
 cgroup_rmdir+0x20/0x2b0 kernel/cgroup/cgroup.c:6229
 kernfs_iop_rmdir+0x106/0x170 fs/kernfs/dir.c:1286
 vfs_rmdir fs/namei.c:4548 [inline]
 vfs_rmdir+0x206/0x690 fs/namei.c:4525
 do_rmdir+0x2e8/0x3c0 fs/namei.c:4603
 __do_sys_rmdir fs/namei.c:4622 [inline]
 __se_sys_rmdir fs/namei.c:4620 [inline]
 __x64_sys_rmdir+0xc5/0x110 fs/namei.c:4620
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f02b3f8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02b4ee5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f02b41e5fa0 RCX: 00007f02b3f8efc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000300
RBP: 00007f02b4011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f02b41e6038 R14: 00007f02b41e5fa0 R15: 00007ffe3049da48
 </TASK>


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

