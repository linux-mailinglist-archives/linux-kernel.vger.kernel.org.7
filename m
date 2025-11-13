Return-Path: <linux-kernel+bounces-898861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD81C562E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53B72341114
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F432ED2F;
	Thu, 13 Nov 2025 08:08:32 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D832ED21
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021311; cv=none; b=NB5QEnK6brlMev8D1ij2ddy8ycKtFVY5cSUL97k9vcOE4d9npbcUM/vodhHTG/cYgkb6tDz7qcTZscyOCJrRbu9/k+IFlur/cnykO481sDHhqLU17MRn+XplkIVaf3Tgdcy2BRB24+N+Y7RPP22/kA/+0OuZy9kTw2qe5sEXeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021311; c=relaxed/simple;
	bh=Bz7ED0HRek/uFNG4OY3n7adGXWxkDoF4osrRKhk/0Ec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DkYp0g+8GrJvZepkiYpFwsGUoFG3JOdqgObClWB0PF7Q/z3iAv4fxEB1OhDKmfZgNrqr37i/mEEjG3HyF/5aNGiC7nCtk7XR8IHeBqbLNxZalgCwWE4bwcojiuyHKAd7FqxFGSTBrqoFPaNCgyDyofGFB8gG2FPnoyN36i3hE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43478824a6fso7317885ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763021309; x=1763626109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjNZP2aelH/P8mQTZ4oGC1U8Z+2onZLGOSHmsIRyDhQ=;
        b=B5FJTZXXzcQSIZiXC6D72ClJndlmRPCh9UbRuLHtWpDWkawr48xwFHDEw9niGRX7tb
         L+Vv9NZW8hsval3DMiT0Ir2vnC4YtSUgibbWeO7JrQBjJBLl3p9iFvKavuJUiLtkFoJk
         4FOELx40gaRIhkWDGRtbYtHZdyVFpz+UgF+snuw4zUVxms64ZRosIEPqfwntR8RYbbxz
         NKHRUwKWvIjEblNR/WlbL6pHWv3ZVmH0f9mVMM6cY8sNmeN5fHvJkO7vB2EgPC0qSjKD
         pamQPkJNQZYTMfuO6v4LuSlpzrZgjfEdAnMkFVyaIb0lKBa7lzxFKXfZLJBceGjNzj2L
         4R/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+SS5EdYq2fQnXFlQjb9lQAz/4tpFz8kEWaDYZuCS2aLP30lVjIcEOIMMAN6LPzrrlsQQuiS8KR4GcMp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyts5u0S4eaVrgkxUN/fE+SAM5HIn8KcTHNP+z/QSMPJJsid14e
	sD2st9CRoCBjShOkAQf7KppIAkekjV74lYT4YASt5IIZ80uK9uFZGDesXUMjOto4C0+KCiZQNWo
	e4cZW1HNNLE4QQrN5cUK2johFBcWiCV+X5V0W5az8oX8GRi1QR4veaK99Pdg=
X-Google-Smtp-Source: AGHT+IE29TSkLF8mS0JVq4UWcSB07f3gfFPFuooM8qL9F5Vk9Szqj22GVIAT0bvZHd7X0SLwsgQil5zYSxaGV74lQSC6iRHu1x0Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5c6:b0:433:7ad4:7392 with SMTP id
 e9e14a558f8ab-43473d17daemr55243155ab.1.1763021309351; Thu, 13 Nov 2025
 00:08:29 -0800 (PST)
Date: Thu, 13 Nov 2025 00:08:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691591fd.a70a0220.3124cb.0020.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (7)
From: syzbot <syzbot+f0b58a1f5075a90dd9a5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7bb4d6512545 Merge tag 'v6.18rc4-SMB-client-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170350b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=f0b58a1f5075a90dd9a5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad654d5866e3/disk-7bb4d651.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ad4d94f39b6/vmlinux-7bb4d651.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fa5516b633d/bzImage-7bb4d651.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0b58a1f5075a90dd9a5@syzkaller.appspotmail.com

EXT4-fs (loop8): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 r/w without journal. Quota mode: none.
ext4 filesystem being mounted at /81/mnt supports timestamps until 2038-01-19 (0x7fffffff)
fscrypt: AES-256-XTS using implementation "xts-aes-vaes-avx2"
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.8.1928/14101 is trying to acquire lock:
ffff8880494b9d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff8880494b9d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2367

but task is already holding lock:
ffff888031d78b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1808 [inline]
ffff888031d78b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
       ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
       do_writepages+0x32e/0x550 mm/page-writeback.c:2604
       __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
       writeback_single_inode+0x1f9/0x6a0 fs/fs-writeback.c:1840
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2903
       iput_final fs/inode.c:1901 [inline]
       iput+0x830/0xc50 fs/inode.c:1966
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2199
       ext4_xattr_move_to_block fs/ext4/xattr.c:2664 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2739 [inline]
       ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2827
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6364
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6407 [inline]
       __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6485
       ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
       evict+0x504/0x9c0 fs/inode.c:810
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
       __ext4_fill_super fs/ext4/super.c:5617 [inline]
       ext4_fill_super+0x5920/0x61e0 fs/ext4/super.c:5736
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

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2367
       ext4_set_context+0x21b/0x550 fs/ext4/crypto.c:166
       fscrypt_set_context+0x38a/0x460 fs/crypto/policy.c:791
       __ext4_new_inode+0x3143/0x3cb0 fs/ext4/ialloc.c:1315
       ext4_ext_migrate+0x69f/0x1010 fs/ext4/migrate.c:456
       ext4_ioctl_setflags fs/ext4/ioctl.c:705 [inline]
       ext4_fileattr_set+0xeaf/0x1630 fs/ext4/ioctl.c:1024
       vfs_fileattr_set+0x932/0xb90 fs/file_attr.c:298
       ioctl_setflags+0x180/0x1e0 fs/file_attr.c:334
       do_vfs_ioctl+0x8ed/0x1430 fs/ioctl.c:560
       __do_sys_ioctl fs/ioctl.c:595 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.8.1928/14101:
 #0: ffff888031d7e420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:552
 #1: ffff8880494bd9f0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #1: ffff8880494bd9f0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: vfs_fileattr_set+0x14e/0xb90 fs/file_attr.c:278
 #2: ffff888031d78b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1808 [inline]
 #2: ffff888031d78b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

stack backtrace:
CPU: 0 UID: 0 PID: 14101 Comm: syz.8.1928 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2367
 ext4_set_context+0x21b/0x550 fs/ext4/crypto.c:166
 fscrypt_set_context+0x38a/0x460 fs/crypto/policy.c:791
 __ext4_new_inode+0x3143/0x3cb0 fs/ext4/ialloc.c:1315
 ext4_ext_migrate+0x69f/0x1010 fs/ext4/migrate.c:456
 ext4_ioctl_setflags fs/ext4/ioctl.c:705 [inline]
 ext4_fileattr_set+0xeaf/0x1630 fs/ext4/ioctl.c:1024
 vfs_fileattr_set+0x932/0xb90 fs/file_attr.c:298
 ioctl_setflags+0x180/0x1e0 fs/file_attr.c:334
 do_vfs_ioctl+0x8ed/0x1430 fs/ioctl.c:560
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1f39f8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1f3ade0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1f3a1e5fa0 RCX: 00007f1f39f8f6c9
RDX: 0000200000000080 RSI: 0000000040086602 RDI: 0000000000000004
RBP: 00007f1f3a011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1f3a1e6038 R14: 00007f1f3a1e5fa0 R15: 00007fffb7f49f38
 </TASK>
EXT4-fs error (device loop8): ext4_validate_block_bitmap:423: comm syz.8.1928: bg 0: bad block bitmap checksum


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

