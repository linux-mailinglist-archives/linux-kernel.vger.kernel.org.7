Return-Path: <linux-kernel+bounces-868543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C3C056DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0DD14F3D82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3A30C36E;
	Fri, 24 Oct 2025 09:51:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2F23D7D1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299465; cv=none; b=VHB8tx2BMoKUQpuhD+uYkMMLek0yIHrv/NlUDqk3XmP2uuM+vqII9oKj7XBwStw4y42+6k9gyd4DYfJ4ZtA1aJ8yWtvGrpyJTcqkuIAGHO3XQsPADu84216kqqRK2gR4wDkmwSTSeDHQTkSfX45WoVb+ycFAeUypkkHdEJPtipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299465; c=relaxed/simple;
	bh=mj3tJ0KoIYmbSbflgAmOwnO+ELBWng642y2BwWnt6h4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p8ld9JHldVn2A6jusOfSdXrLIDA4OSHECFuNRDrRoqtl50jdvVtWn2vP8UjCrN67PgIyV76+v26kwWcWsYmmfH6fK7nVQnT+MFfsRKAD3Q5pGH5EnssJSOE9BDjq45Z6EbMECFGQjNWZmSjW+8OnXqzwR7+3klMjnHI7u7cSzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-94099028725so175746839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299463; x=1761904263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFvSYfF8MOF9dgae8E/MwTXlvBooTbAuoltSQEnurnQ=;
        b=of7NKPSTu86KyHtyUhYo7ZreMIF01vYBCUddKuwsTbKp8v4FKpWw2mslI80e2AYd6w
         0H7XoGxpczHgO416JA1DJOX8ULQjmcJjlWQdjMWaz40tB94vsCaFxoHA8LKRTmk20MdM
         1m0PBqnOG/Xeb3RGo4lqJX0slKZQidxfYMXvOqh+5FJaHUp00no5zk0za/YyPugfaKvC
         UGwIs47JKtequ7h/fK27FbNTb/0jmcfQq8BA/1qWzX+LkprL/3cakdGok/yjZ3u3hwa2
         SXpUIhoIM30PZZNalPv0NDd7Tzx+rD4WB7JfjAsC2ijpOvC5B1OmwJTsyzjBeTIK8FEB
         r80Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnCrnJhYV0UnwyeiKRMLR/EHRYjFcLQuRp9LInNFuJiPuP4ih9zXglKp18bomSYslj0LxWOj5PngwhQc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5TAOvE9Xt62A1KUZKPCnrnHypSdnWGCAn0MOTeaDSL0cjeog
	fJ9A8Urg/9/Jk85HSligYsvofqIdI8X190iyQMMBHR9zDdGI8B+mErtxFfQPQUui1EAzOFKhQo6
	8O5Z2YOZ4e7yDK/xc2eHsLGqUr7+Ev3gobJ46DfabZzcHevFpsIJZVMVKc2s=
X-Google-Smtp-Source: AGHT+IG+QQL3Wm7QPWmhbItPYnU1uLPufedY5XQPFrkkFKH9JF1L/mn0rDRbifcHrVx4RJ2kYjmTaGfXROFy9Pa0Xy7i8EGjymxw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:42f:8eeb:49a1 with SMTP id
 e9e14a558f8ab-430c523d6fdmr426346795ab.13.1761299462803; Fri, 24 Oct 2025
 02:51:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 02:51:02 -0700
In-Reply-To: <20251024071531.Cp40p%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb4c06.050a0220.346f24.00ba.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __ocfs2_flush_truncate_log

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor/5793 is trying to acquire lock:
ffff88804461d100 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:815 [inline]
ffff88804461d100 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5){+.+.}-{4:4}, at: __ocfs2_flush_truncate_log+0x33d/0x10f0 fs/ocfs2/alloc.c:6054

but task is already holding lock:
ffff888040ccb480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:815 [inline]
ffff888040ccb480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: ocfs2_flush_truncate_log+0x47/0x70 fs/ocfs2/alloc.c:6083

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}:
       lock_acquire+0x1a1/0x430 kernel/locking/lockdep.c:5825
       down_write+0x97/0x1f0 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       ocfs2_move_extent fs/ocfs2/move_extents.c:646 [inline]
       __ocfs2_move_extents_range+0x1a6a/0x3380 fs/ocfs2/move_extents.c:866
       ocfs2_move_extents+0x379/0x960 fs/ocfs2/move_extents.c:933
       ocfs2_ioctl_move_extents+0x569/0x740 fs/ocfs2/move_extents.c:1065
       ocfs2_ioctl+0x192/0x750 fs/ocfs2/ioctl.c:946
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0x100/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x188e/0x5720 kernel/locking/lockdep.c:3904
       __lock_acquire+0x138a/0x20c0 kernel/locking/lockdep.c:5202
       lock_acquire+0x1a1/0x430 kernel/locking/lockdep.c:5825
       down_write+0x97/0x1f0 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       __ocfs2_flush_truncate_log+0x33d/0x10f0 fs/ocfs2/alloc.c:6054
       ocfs2_flush_truncate_log+0x4f/0x70 fs/ocfs2/alloc.c:6084
       ocfs2_sync_fs+0x117/0x320 fs/ocfs2/super.c:402
       sync_filesystem+0x1cf/0x230 fs/sync.c:66
       generic_shutdown_super+0x6f/0x2c0 fs/super.c:621
       kill_block_super+0x44/0x90 fs/super.c:1710
       deactivate_locked_super+0xb9/0x130 fs/super.c:473
       cleanup_mnt+0x425/0x4c0 fs/namespace.c:1378
       task_work_run+0x1d5/0x260 kernel/task_work.c:239
       resume_user_mode_work+0x5e/0x80 include/linux/resume_user_mode.h:50
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x87/0x130 kernel/entry/common.c:218
       do_syscall_64+0x103/0x210 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6);
                               lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5);
                               lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6);
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5);

 *** DEADLOCK ***

2 locks held by syz-executor/5793:
 #0: ffff88803ef880e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88803ef880e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88803ef880e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffff888040ccb480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888040ccb480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: ocfs2_flush_truncate_log+0x47/0x70 fs/ocfs2/alloc.c:6083

stack backtrace:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Not tainted syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x18a/0x250 lib/dump_stack.c:120
 print_circular_bug+0x13b/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x2b5/0x3b0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x188e/0x5720 kernel/locking/lockdep.c:3904
 __lock_acquire+0x138a/0x20c0 kernel/locking/lockdep.c:5202
 lock_acquire+0x1a1/0x430 kernel/locking/lockdep.c:5825
 down_write+0x97/0x1f0 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:815 [inline]
 __ocfs2_flush_truncate_log+0x33d/0x10f0 fs/ocfs2/alloc.c:6054
 ocfs2_flush_truncate_log+0x4f/0x70 fs/ocfs2/alloc.c:6084
 ocfs2_sync_fs+0x117/0x320 fs/ocfs2/super.c:402
 sync_filesystem+0x1cf/0x230 fs/sync.c:66
 generic_shutdown_super+0x6f/0x2c0 fs/super.c:621
 kill_block_super+0x44/0x90 fs/super.c:1710
 deactivate_locked_super+0xb9/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1378
 task_work_run+0x1d5/0x260 kernel/task_work.c:239
 resume_user_mode_work+0x5e/0x80 include/linux/resume_user_mode.h:50
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x87/0x130 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd40db901f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd33164b08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd40dc11d7d RCX: 00007fd40db901f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd33164bc0
RBP: 00007ffd33164bc0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd33165c50
R13: 00007fd40dc11d7d R14: 000000000002060d R15: 00007ffd33165c90
 </TASK>
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)
(syz-executor,5793,0):ocfs2_inode_is_valid_to_delete:872 ERROR: Skipping delete of system file 72
ocfs2: Unmounting device (7,0) on (node local)


Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=126ddb04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe7b438dcda9b036
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177c7734580000


