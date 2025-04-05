Return-Path: <linux-kernel+bounces-589539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7ABA7C76B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 04:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA1C3BC3D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAF189F57;
	Sat,  5 Apr 2025 02:39:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F30189F20
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743820771; cv=none; b=MrS6Qar+GnXg3FUJ5HcyN5BuJB6jWg7PxuuK7aKPPDmypB4CtoQqCGuXA6fS6JFqt8R5BkEks+aKtqJKi3ymeXC5gaTJ+bgpnr61F2Hu0NFi+wmEuuXCanIO0YFLshjIr7mabr19zvfHRpC8s5lzfmvo6/k34OpASaQ/y3LopF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743820771; c=relaxed/simple;
	bh=140Qvm25bvAzjxAZ3dwrAS1nnOhO4eH2AExbSqYqQU8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c9JFRpsrXUsuC6GmNi8tOOb68fAsDqUrciJgS23P3qPjUCBZ/TNPEt2/uXv8UPKVS47dJPXIsin4mFlxLk8e0psW3BeJUl/cEdzlE+72vMtV2j3TNgST/Ur2BQ80Izw5s2x/e2EpsDxP4HKrbG06nOMuGJMiTuI50l5t7qpgwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d44a3882a0so25997145ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 19:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743820769; x=1744425569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtwH2AaWubu33ySkf+L6hSVADT3A6b2bPhj7AM0h9iI=;
        b=ndNsXwm14bXel1A26LgfTYeDOlJ9LFoG8RkedNLL3mMsEx3RdbHp/Sxu0m+l9mYuWV
         FV5Qu3hHNK/Xb0GKlmrCVsn4/dDSFZyuQjmBU9hrnvnRYZgxIHgiaIpmQrpn/ArPK4Hs
         mePMSXi83uDmzn0109Dtna+v6WUFhbz3WPTF9disKTvP+0UAIZrkiC5H0hhfdKcALf5W
         xwA3IOaS4LvvOKbaVqXd+0w0eAr8yzEZSK4ch6JFm/ijYVAhaea6nXSiLHcZIdKVszos
         BftH2El5lNh/AsE1t66jldAdWKz4+FwXqI+30mpgXPaLAzlyqU3CUh60x5jyW+tcjWXA
         mpTw==
X-Forwarded-Encrypted: i=1; AJvYcCVE9M6RRGevSPPdxPuYjTMHKIOUV+vatEbmCDw1uEQ/gHwjWThFBl14lV65N22jhVSg7Eysxd7nWGVEwWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwenLtfyEn9Kh5G9kfpM/yrx4ug76v7kFN1T0xzPJ1/lRC4IbaT
	LsEZc0HKcpuxyvtTzD/esF14Y4PTJE3hfPchpWL7LMsA7voRyuhba9m+frEOUDgHfNFk6/hwtcX
	yotKuvEqlHtbR69oCFbVB5WCLLVWcmC8UTXShlmlJPaoGCwNyiWB7hUU=
X-Google-Smtp-Source: AGHT+IG19L+ZJcEmRZXzBKt84A28fCbPoMlA8n7/wMknyvgj5+WKdq4bZprHLSOmyuR629YIaEBCxFFtTBthsgU1ADR4UeuSgBId
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2506:b0:3d4:44:958a with SMTP id
 e9e14a558f8ab-3d6e3f999b0mr64123455ab.3.1743820768746; Fri, 04 Apr 2025
 19:39:28 -0700 (PDT)
Date: Fri, 04 Apr 2025 19:39:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f097e0.050a0220.0a13.022a.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in queue_wb_lat_store
From: syzbot <syzbot+5a9d5d7faa80fa15e3db@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    609706855d90 Merge tag 'trace-latency-v6.15-3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ea1998580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51da9763f36e4c7
dashboard link: https://syzkaller.appspot.com/bug?extid=5a9d5d7faa80fa15e3db
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e24dc4cf329/disk-60970685.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/616648e7703d/vmlinux-60970685.xz
kernel image: https://storage.googleapis.com/syzbot-assets/faec611db102/bzImage-60970685.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a9d5d7faa80fa15e3db@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-11125-g609706855d90 #0 Not tainted
------------------------------------------------------
syz.0.753/9197 is trying to acquire lock:
ffff8881437e2318 (&q->elevator_lock){+.+.}-{4:4}, at: queue_wb_lat_store+0x187/0x3d0 block/blk-sysfs.c:596

but task is already holding lock:
ffff8881437e1de8 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x179/0x290 block/blk-mq.c:4349
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4396
       loop_add+0x496/0xb70 drivers/block/loop.c:2067
       loop_init+0x164/0x270 drivers/block/loop.c:2302
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3914 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3928
       might_alloc include/linux/sched/mm.h:318 [inline]
       xa_insert include/linux/xarray.h:783 [inline]
       blk_mq_init_hctx block/blk-mq.c:3924 [inline]
       blk_mq_alloc_and_init_hctx+0x503/0x11c0 block/blk-mq.c:4457
       blk_mq_realloc_hw_ctxs+0x8f6/0xc00 block/blk-mq.c:4486
       blk_mq_init_allocated_queue+0x3af/0x1230 block/blk-mq.c:4540
       blk_mq_alloc_queue+0x1c2/0x290 block/blk-mq.c:4353
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4396
       loop_add+0x496/0xb70 drivers/block/loop.c:2067
       loop_init+0x164/0x270 drivers/block/loop.c:2302
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&q->elevator_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
       lock_acquire kernel/locking/lockdep.c:5866 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
       __mutex_lock_common kernel/locking/mutex.c:587 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:732
       queue_wb_lat_store+0x187/0x3d0 block/blk-sysfs.c:596
       queue_attr_store+0x270/0x310 block/blk-sysfs.c:799
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:591 [inline]
       vfs_write+0x5ba/0x1180 fs/read_write.c:684
       ksys_write+0x12a/0x240 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#24

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#24);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#24);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

6 locks held by syz.0.753/9197:
 #0: ffff88806a44d278 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1213
 #1: ffff888035a20420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x240 fs/read_write.c:736
 #2: ffff888061625888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
 #3: ffff8880213fbb48 (kn->active#125){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b2/0x510 fs/kernfs/file.c:326
 #4: ffff8881437e1de8 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215
 #5: ffff8881437e1e20 (&q->q_usage_counter(queue)#21){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

stack backtrace:
CPU: 1 UID: 0 PID: 9197 Comm: syz.0.753 Not tainted 6.14.0-syzkaller-11125-g609706855d90 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2079
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain kernel/locking/lockdep.c:3909 [inline]
 __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:732
 queue_wb_lat_store+0x187/0x3d0 block/blk-sysfs.c:596
 queue_attr_store+0x270/0x310 block/blk-sysfs.c:799
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5ba/0x1180 fs/read_write.c:684
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb5d6d8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb5d7bca038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb5d6fa5fa0 RCX: 00007fb5d6d8d169
RDX: 0000000000000081 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007fb5d6e0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb5d6fa5fa0 R15: 00007ffce0809d88
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

