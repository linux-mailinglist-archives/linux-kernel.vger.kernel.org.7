Return-Path: <linux-kernel+bounces-884180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE94C2F8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0B4189ED03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D43009CC;
	Tue,  4 Nov 2025 07:03:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B33002A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239788; cv=none; b=Sh3YfCOhP8lyDkjhOOLJMrG9/P4mVdc8VpSagnbuHo0MEdCzbnwGJ31yWwsSZcl2OaRxAKfAcaFPTcLVOXbHs4MSwvy6J3MCdpbBL7iZScq4NbHDBPZwyPRTTQbVTgeEZzP1if3A2s7Y/Mhu1JOIjwMDtb+nVIU+J/xKgUgNHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239788; c=relaxed/simple;
	bh=bBpBB8nJJtTw1qKd2r/Ffgunpwe4ISBhUcAtqtoeVqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sTba9VJ14ZOobM+r9wf2od63n00anzV9gdX8Kzn3HoBIko0NbLTf3FSahf7tLjnY36XSY8/SnH6cUxzDA+QAFLxuF8A1pa57+AiDbvGQqnKQ5RWtFdnLGvTzDRiSXWX+Y1IIdDgR1sVLYf7oE2Sd6DdBLOTOP756ks9ifItIqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso1590921439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762239784; x=1762844584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV0ZlpvtJSmKU+AuYWeNRn5uCnaJyEhec8Nn7x5eLt0=;
        b=LootEH3d6PBfgOar7wvjhDgzt1dBZPpZ0QiQS7zSLYsjlSC27wxsSQ/91btGGgl5If
         XLIBl+G+g9KAzYfUcTmSxcLtRLQoM6q0gjdOV6wD3b010qSyQ6t4RSweHpK7/4pKeywO
         3uJyw8KOFNSrwOXl3ohZgj3ut7Dv30ufxSTXYesQfvXDSCkiD60JUebyg95hpnnR2MD6
         7X7zGMMBPwgPCxTC1tv+dop1rsT1OZv9moxwz7bqTzy4OnmmAoQ3mTEasePrn4uQmzeT
         kd5MNnyr9W9dt30B/rReVXw/q7OdmfFpatj74PLC48MXjsguR+Lrrs5Bh4wKUyTeK3x7
         Vojw==
X-Gm-Message-State: AOJu0YzFca8sb1UGyAL0v2vZraQttRtJcHZa6RWRrrv7PtNlm44lwawR
	hQXWiH7rwiED3KiGHUtTIJ/noUkDxybZHPXO9Ob0jV+386+WcotiKfilNvVMzltSL5H9BPwx13O
	1U6qQJm0VKP7yMc5Wuj/rWKTEd+hgcZ+fx87hApLueFAeo/06pxOO78RAvDQ=
X-Google-Smtp-Source: AGHT+IEB2Dwnd1PycwHr0/pnW+XStrMJqGZl8R0I4z2LlQWYaRByAQJT0Tqs7LM5ZxQZzZap+sN9A2K3kokTk+vZvUJnHL7/Vcde
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6089:b0:93b:ae89:52da with SMTP id
 ca18e2360f4ac-948229542d4mr2028500539f.10.1762239783857; Mon, 03 Nov 2025
 23:03:03 -0800 (PST)
Date: Mon, 03 Nov 2025 23:03:03 -0800
In-Reply-To: <kj6hgbdwsmff55vzjvmlsvybcmhrdywa2d4fxqt7376ocmocle@5jrydocarqf2>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6909a527.050a0220.98a6.00a1.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ni_rename

loop0: detected capacity change from 0 to 4096
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6515 is trying to acquire lock:
ffff888042223978 (&type->i_mutex_dir_key#8){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
ffff888042223978 (&type->i_mutex_dir_key#8){+.+.}-{4:4}, at: ni_rename+0x7c/0x170 fs/ntfs3/frecord.c:-1

but task is already holding lock:
ffff888042214620 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1113 [inline]
ffff888042214620 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ntfs_rename+0x6f7/0xbf0 fs/ntfs3/namei.c:328

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ni->ni_lock#3/5){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/rtmutex_api.c:535 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:547
       ni_lock fs/ntfs3/ntfs_fs.h:1113 [inline]
       ntfs_save_wsl_perm+0x8b/0x410 fs/ntfs3/xattr.c:975
       ntfs_create_inode+0x23b9/0x32a0 fs/ntfs3/inode.c:1629
       ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
       lookup_open fs/namei.c:3796 [inline]
       open_last_lookups fs/namei.c:3895 [inline]
       path_openat+0x1500/0x3840 fs/namei.c:4131
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ni->ni_lock/6){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/rtmutex_api.c:535 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:547
       ni_lock_dir fs/ntfs3/ntfs_fs.h:1118 [inline]
       ntfs_lookup+0xee/0x1f0 fs/ntfs3/namei.c:84
       lookup_open fs/namei.c:3774 [inline]
       open_last_lookups fs/namei.c:3895 [inline]
       path_openat+0x110d/0x3840 fs/namei.c:4131
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&type->i_mutex_dir_key#8){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
       inode_lock include/linux/fs.h:980 [inline]
       ni_rename+0x7c/0x170 fs/ntfs3/frecord.c:-1
       ntfs_rename+0x735/0xbf0 fs/ntfs3/namei.c:332
       vfs_rename+0xb34/0xe80 fs/namei.c:5216
       do_renameat2+0x6a2/0xa50 fs/namei.c:5364
       __do_sys_rename fs/namei.c:5411 [inline]
       __se_sys_rename fs/namei.c:5409 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5409
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#8 --> &ni->ni_lock/6 --> &ni->ni_lock#3/5

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock#3/5);
                               lock(&ni->ni_lock/6);
                               lock(&ni->ni_lock#3/5);
  lock(&type->i_mutex_dir_key#8);

 *** DEADLOCK ***

6 locks held by syz.0.17/6515:
 #0: ffff88814abe0480 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888042223978 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
 #1: ffff888042223978 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff888042223978 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
 #2: ffff8880422148d8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #2: ffff8880422148d8 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: lock_two_nondirectories+0xe7/0x180 fs/inode.c:1232
 #3: ffff888042224128 (&sb->s_type->i_mutex_key#20/4){+.+.}-{4:4}, at: vfs_rename+0x665/0xe80 fs/namei.c:5187
 #4: ffff8880422236c0 (&ni->ni_lock/6){+.+.}-{4:4}, at: ni_lock_dir fs/ntfs3/ntfs_fs.h:1118 [inline]
 #4: ffff8880422236c0 (&ni->ni_lock/6){+.+.}-{4:4}, at: ntfs_rename+0x6de/0xbf0 fs/ntfs3/namei.c:327
 #5: ffff888042214620 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1113 [inline]
 #5: ffff888042214620 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ntfs_rename+0x6f7/0xbf0 fs/ntfs3/namei.c:328

stack backtrace:
CPU: 1 UID: 0 PID: 6515 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
 inode_lock include/linux/fs.h:980 [inline]
 ni_rename+0x7c/0x170 fs/ntfs3/frecord.c:-1
 ntfs_rename+0x735/0xbf0 fs/ntfs3/namei.c:332
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53db12efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53da796038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f53db385fa0 RCX: 00007f53db12efc9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000200000000580
RBP: 00007f53db1b1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f53db386038 R14: 00007f53db385fa0 R15: 00007ffec8956b58
 </TASK>
------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 1 PID: 6515 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
WARNING: CPU: 1 PID: 6515 at kernel/locking/rtmutex.c:1674 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
WARNING: CPU: 1 PID: 6515 at kernel/locking/rtmutex.c:1674 __rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
Modules linked in:
CPU: 1 UID: 0 PID: 6515 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
RIP: 0010:__rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
RIP: 0010:__rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
Code: 7c 24 20 dd 4c 8b b4 24 98 00 00 00 0f 85 fd 0a 00 00 48 8b 7c 24 10 e8 4c 40 28 09 90 48 c7 c7 60 fd ea 8a e8 ef 62 e7 ff 90 <0f> 0b 90 90 48 8b 9c 24 80 00 00 00 43 80 3c 3e 00 74 08 4c 89 e7
RSP: 0018:ffffc90003f07740 EFLAGS: 00010246
RAX: aef14222ed876700 RBX: ffff888023b428e0 RCX: ffff888023b41e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f07930 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101712487b R12: ffff888023b43560
R13: ffff888023b41e18 R14: 1ffff110047686ac R15: dffffc0000000000
FS:  00007f53da7966c0(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31ff1aa9c0 CR3: 0000000030736000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rt_mutex_slowlock+0xb5/0x160 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14f/0x750 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:980 [inline]
 ni_rename+0x7c/0x170 fs/ntfs3/frecord.c:-1
 ntfs_rename+0x735/0xbf0 fs/ntfs3/namei.c:332
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53db12efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53da796038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f53db385fa0 RCX: 00007f53db12efc9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000200000000580
RBP: 00007f53db1b1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f53db386038 R14: 00007f53db385fa0 R15: 00007ffec8956b58
 </TASK>


Tested on:

commit:         c9cfc122 Merge tag 'for-6.18-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12241bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d8e30dbafb5c1260479
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129b3704580000


