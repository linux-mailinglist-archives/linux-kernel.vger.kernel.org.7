Return-Path: <linux-kernel+bounces-737855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B0B0B14B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BB356214A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC722264D7;
	Sat, 19 Jul 2025 18:22:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783311DF74F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949325; cv=none; b=IB98sIrnk94HmtgJwERcqm2tFmxusFOkMN4ojV1F28Uh1mICmaXUVzDwLb3iIhoqdDrnM1/gfxiVP+fxqDSvpj4rbLjgZB9Spbi+3ybnrkHwkxPOgz4IG+ecaSGfqgW0oIR9Ixka6MuSxbdUjRCIMMsX4hNI2a6ICy9WNSXqpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949325; c=relaxed/simple;
	bh=9aZd/5CS1K6gUiUNxrlzawKZLrPC/XSVlBs/J4mDkSE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+j/0TMkxLTtIwURAD5p9U7OY9P3GN+A1fUeVNDSxL1gVaQvQb0g7fgRO6qeHTlrsV36Gfrc7tQgw0mgPheBwzjCJLVx+UX6NOilASYsBlkQxKpgQED+Eq7z1AsAgoFUPs7xtYK16m0dRYslQ40QMrw5gV4Wohv+77iKM54c30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86a5def8869so680801839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 11:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949322; x=1753554122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCKTfCl6CCVCX3wgtyABQ/D2o7hzY1/EQS4mWEzcyIU=;
        b=vM8bNam9JDeQyu1qxcaoW8Cr+JVDojvMjzFR6kdNvPWC6fF5m5gQ/vFK8uy7gzxyp/
         oCX+PHgw9dGuhyvbCe9TkJymISdW+p41g5x6Tbd0nUfF3IdoefWrfFK7QkbvprwbYyJh
         GnqmlR7HCfbkL2cdjFJGnKEdJuaRKthbNx7v7NJUHDoziO1mrUpMKqMzs5+XkPt7JZ93
         Ru/6/MfKX3xy8ljgkrUFmR3nmGISsikxGpYQw5RPzcrmRTimzSDqw6yU+SvBlDhwKfPF
         O8Fl102uCBrCGp14i5Rj1uYJjt3SNfGVBLMeRPiIF/lntQ2BElevDwatDkRQlNtKoj9C
         JWtw==
X-Gm-Message-State: AOJu0Yzx/MQKT+VxEzgbRgEswYeXx4YdO5u3LGaRRfeOCLL6ubg/p6il
	ToF7eAEauRFm9a//I59CfATQMAUe6l/SrmfldrBol/4183dn+ftnCUi8hC+4bXzfeshKv4fAt92
	VcIvhZD6GwaLTzBdwxvnukS1RPhLcvUtlIx5lI82GDnDh/3znJ3C0HQouuRA=
X-Google-Smtp-Source: AGHT+IGzby/TVFBkZc4NQrILrDFv+CEclMjLuIu6RI1cIy8NKSJdmL6B5S27SVOH5FcOw4ByBu/TbU+kFT6kIZbc+Eqfm00SYU3V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a8b:b0:87c:155f:d0c with SMTP id
 ca18e2360f4ac-87c155f23d7mr636027839f.0.1752949322441; Sat, 19 Jul 2025
 11:22:02 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:22:02 -0700
In-Reply-To: <690ae6be-8313-46eb-a546-b895f5a7227c@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687be24a.a70a0220.693ce.0092.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
From: syzbot <syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ocfs2_truncate_file

         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with writeback data mode.
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc6-syzkaller-00253-g4871b7cb27f4-dirty #0 Not tainted
------------------------------------------------------
syz.0.16/6592 is trying to acquire lock:
ffff88807a9fc618 (sb_internal#2){.+.+}-{0:0}, at: ocfs2_orphan_for_truncate fs/ocfs2/file.c:396 [inline]
ffff88807a9fc618 (sb_internal#2){.+.+}-{0:0}, at: ocfs2_truncate_file+0x648/0x1410 fs/ocfs2/file.c:500

but task is already holding lock:
ffff88807da38660 (&oi->ip_alloc_sem){++++}-{4:4}, at: ocfs2_down_write fs/ocfs2/inode.h:74 [inline]
ffff88807da38660 (&oi->ip_alloc_sem){++++}-{4:4}, at: ocfs2_truncate_file+0x36a/0x1410 fs/ocfs2/file.c:471

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&oi->ip_alloc_sem){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       ocfs2_down_write fs/ocfs2/inode.h:74 [inline]
       ocfs2_xattr_set_handle+0x3af/0x7a0 fs/ocfs2/xattr.c:3503
       ocfs2_init_security_set+0xbd/0xe0 fs/ocfs2/xattr.c:7309
       ocfs2_mknod+0x137f/0x2050 fs/ocfs2/namei.c:419
       ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
       lookup_open fs/namei.c:3717 [inline]
       open_last_lookups fs/namei.c:3816 [inline]
       path_openat+0x14f1/0x3830 fs/namei.c:4052
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_open fs/open.c:1460 [inline]
       __se_sys_open fs/open.c:1456 [inline]
       __x64_sys_open+0x11e/0x150 fs/open.c:1456
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&oi->ip_xattr_sem){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       ocfs2_down_write fs/ocfs2/inode.h:73 [inline]
       ocfs2_xattr_set_handle+0x3a0/0x7a0 fs/ocfs2/xattr.c:3503
       ocfs2_init_security_set+0xbd/0xe0 fs/ocfs2/xattr.c:7309
       ocfs2_mknod+0x137f/0x2050 fs/ocfs2/namei.c:419
       ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
       lookup_open fs/namei.c:3717 [inline]
       open_last_lookups fs/namei.c:3816 [inline]
       path_openat+0x14f1/0x3830 fs/namei.c:4052
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_open fs/open.c:1460 [inline]
       __se_sys_open fs/open.c:1456 [inline]
       __x64_sys_open+0x11e/0x150 fs/open.c:1456
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       start_this_handle+0x1fa7/0x21c0 fs/jbd2/transaction.c:444
       jbd2__journal_start+0x2c1/0x5b0 fs/jbd2/transaction.c:501
       jbd2_journal_start+0x2a/0x40 fs/jbd2/transaction.c:540
       ocfs2_start_trans+0x376/0x6d0 fs/ocfs2/journal.c:374
       ocfs2_block_group_alloc fs/ocfs2/suballoc.c:685 [inline]
       ocfs2_reserve_suballoc_bits+0x711/0x4640 fs/ocfs2/suballoc.c:834
       ocfs2_reserve_new_metadata_blocks+0x403/0x940 fs/ocfs2/suballoc.c:984
       ocfs2_mknod+0xe08/0x2050 fs/ocfs2/namei.c:347
       ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
       lookup_open fs/namei.c:3717 [inline]
       open_last_lookups fs/namei.c:3816 [inline]
       path_openat+0x14f1/0x3830 fs/namei.c:4052
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_open fs/open.c:1460 [inline]
       __se_sys_open fs/open.c:1456 [inline]
       __x64_sys_open+0x11e/0x150 fs/open.c:1456
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&journal->j_trans_barrier){.+.+}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1524
       ocfs2_start_trans+0x36a/0x6d0 fs/ocfs2/journal.c:372
       ocfs2_block_group_alloc fs/ocfs2/suballoc.c:685 [inline]
       ocfs2_reserve_suballoc_bits+0x711/0x4640 fs/ocfs2/suballoc.c:834
       ocfs2_reserve_new_metadata_blocks+0x403/0x940 fs/ocfs2/suballoc.c:984
       ocfs2_mknod+0xe08/0x2050 fs/ocfs2/namei.c:347
       ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
       lookup_open fs/namei.c:3717 [inline]
       open_last_lookups fs/namei.c:3816 [inline]
       path_openat+0x14f1/0x3830 fs/namei.c:4052
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_open fs/open.c:1460 [inline]
       __se_sys_open fs/open.c:1456 [inline]
       __x64_sys_open+0x11e/0x150 fs/open.c:1456
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1795 [inline]
       sb_start_intwrite include/linux/fs.h:1978 [inline]
       ocfs2_start_trans+0x26b/0x6d0 fs/ocfs2/journal.c:370
       ocfs2_orphan_for_truncate fs/ocfs2/file.c:396 [inline]
       ocfs2_truncate_file+0x648/0x1410 fs/ocfs2/file.c:500
       ocfs2_setattr+0x1571/0x1b60 fs/ocfs2/file.c:1212
       notify_change+0xb36/0xe40 fs/attr.c:552
       do_truncate+0x1a4/0x220 fs/open.c:68
       handle_truncate fs/namei.c:3517 [inline]
       do_open fs/namei.c:3900 [inline]
       path_openat+0x306c/0x3830 fs/namei.c:4055
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_open fs/open.c:1460 [inline]
       __se_sys_open fs/open.c:1456 [inline]
       __x64_sys_open+0x11e/0x150 fs/open.c:1456
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &oi->ip_xattr_sem --> &oi->ip_alloc_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&oi->ip_alloc_sem);
                               lock(&oi->ip_xattr_sem);
                               lock(&oi->ip_alloc_sem);
  rlock(sb_internal#2);

 *** DEADLOCK ***

4 locks held by syz.0.16/6592:
 #0: ffff88807a9fc428 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff88807da389c0 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock_killable include/linux/fs.h:874 [inline]
 #1: ffff88807da389c0 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: do_truncate+0x171/0x220 fs/open.c:63
 #2: ffff88807da386f8 (&oi->ip_xattr_sem){++++}-{4:4}, at: ocfs2_down_write fs/ocfs2/inode.h:73 [inline]
 #2: ffff88807da386f8 (&oi->ip_xattr_sem){++++}-{4:4}, at: ocfs2_truncate_file+0x359/0x1410 fs/ocfs2/file.c:471
 #3: ffff88807da38660 (&oi->ip_alloc_sem){++++}-{4:4}, at: ocfs2_down_write fs/ocfs2/inode.h:74 [inline]
 #3: ffff88807da38660 (&oi->ip_alloc_sem){++++}-{4:4}, at: ocfs2_truncate_file+0x36a/0x1410 fs/ocfs2/file.c:471

stack backtrace:
CPU: 1 UID: 0 PID: 6592 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller-00253-g4871b7cb27f4-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1795 [inline]
 sb_start_intwrite include/linux/fs.h:1978 [inline]
 ocfs2_start_trans+0x26b/0x6d0 fs/ocfs2/journal.c:370
 ocfs2_orphan_for_truncate fs/ocfs2/file.c:396 [inline]
 ocfs2_truncate_file+0x648/0x1410 fs/ocfs2/file.c:500
 ocfs2_setattr+0x1571/0x1b60 fs/ocfs2/file.c:1212
 notify_change+0xb36/0xe40 fs/attr.c:552
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3517 [inline]
 do_open fs/namei.c:3900 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_open fs/open.c:1460 [inline]
 __se_sys_open fs/open.c:1456 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1456
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa61778e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa61868b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fa6179b5fa0 RCX: 00007fa61778e929
RDX: 0000000000000020 RSI: 000000000014927e RDI: 00002000000001c0
RBP: 00007fa617810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa6179b5fa0 R15: 00007fffb0c2bbe8
 </TASK>


Tested on:

commit:         4871b7cb Merge tag 'v6.16-rc6-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1474c38c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1510c38c580000


