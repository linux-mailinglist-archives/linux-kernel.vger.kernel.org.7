Return-Path: <linux-kernel+bounces-821394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11381B81240
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8921E1C03607
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2F1A9FBE;
	Wed, 17 Sep 2025 17:14:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600602FAC17
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129270; cv=none; b=utCfNrz9kDDK3FkxaWqV1i5BfJzZc+qz5hD6+u81je5O0ws/RdpAhMp3FutBuxpxXWKk06uIL0HyEXVHPhvhGpAL4PPEh7rg1+CD6QnIbn2I6AXixo3DWU5h2Wx469Si1usmGciPz5gatV3qUiQ0zF3EzQD8Av8BXpPBicWjsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129270; c=relaxed/simple;
	bh=8PLkdaWrDgMesaX4mEXVPgd+cvSRzXSOLhBmlB375FM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cgBeH/gQgWuOQT8DL+sJs2DgzxRr5gOF60jXsr2y2QYEgh0gQZebpF8gzTsKjbE2dKt31b1M5PkcqePDefxWTUhGCTr8jkN83+CLP/1N47qWxT6ekGy3woa4yk2emOGWVKkWeQvgC6Q5SUiByUXPLzscCJGwHxc/ekJ69L2Qs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42404e7bc94so93058435ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129267; x=1758734067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKOpGpOzHLGkWDPCobkz16a2M+/D5W5KB7XR68mNObk=;
        b=lW9pNvCFPSkfDJUcqc98bDgC6SWHN1FxcTZW6D10iJdrOFjTb55/fDVrCp6AoWziZt
         PViHMyktVwk/ZeHP4fdzGNBs3ikhh2P0ek46N4O04szg2v4fvtNToK2o+Pt/LvX76Ex1
         l33YS7G5QkaUNp0RLJDzTf+9ZVDR/PTczRCcU3e9xfZtXPjRcdrUbiD9MjoU7wkOa1No
         WJI6IvU6KGREGBpu5zcnC44ZTqEdz4vWlXDmoqPHKkfYjnuQKK1so/VRuiYZ0QGjXaKm
         ZdYHXQvT0xXvKboPHJt0uhi+wQCwpMpMOo76p/a4QEQJogtGWSLQrrgKPmVy4p8W0PH+
         +a+Q==
X-Gm-Message-State: AOJu0YwyuOeZhFhgwbtpT0G01tlVfI0usjnD/lzX0l2N5xiccbHdm1vy
	EoFyCaQsiMwLapGKD9c1LfK7vZtggkMv1tX0cKuAQBQUAHxdRMRyRIwdr6WcqMgmvniKejUpOnJ
	4fApuu4m/sZreE96kLUKFb97GpVqhc7GUgs3XeiWMbFrxNUwsZelQOEXVD7+UtQ==
X-Google-Smtp-Source: AGHT+IGKZu3C4gvQELP0BkLbCJBZ2HTDqYSkiEbHOJtYSp5Epm5vnnVwlLaAZ23a70WFQVobt33bfcWqAs8qXjCaMCgp/x1bob1V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:409:d91f:a48f with SMTP id
 e9e14a558f8ab-4241a54ab35mr37326615ab.22.1758129267497; Wed, 17 Sep 2025
 10:14:27 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:14:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68caec73.050a0220.2ff435.0595.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in __vhost_task_wake
From: syzbot <syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ae2d20002576 Add linux-next specific files for 20250917
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149ec534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7dcbc33245a844f3
dashboard link: https://syzkaller.appspot.com/bug?extid=a1a3cefd6148c781117c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c34033bfd08/disk-ae2d2000.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b001294bb15/vmlinux-ae2d2000.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83d50ef44860/bzImage-ae2d2000.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/vhost_task.c:97 at __vhost_task_wake+0xbb/0xd0 kernel/vhost_task.c:97, CPU#1: syz.3.28/6112
Modules linked in:
CPU: 1 UID: 0 PID: 6112 Comm: syz.3.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__vhost_task_wake+0xbb/0xd0 kernel/vhost_task.c:97
Code: 38 00 74 08 48 89 df e8 93 81 95 00 48 8b 3b 5b 41 5e 41 5f e9 a6 45 01 00 e8 31 ef 30 00 90 0f 0b 90 eb 8b e8 26 ef 30 00 90 <0f> 0b 90 5b 41 5e 41 5f e9 18 47 f7 09 cc 0f 1f 80 00 00 00 00 90
RSP: 0018:ffffc9000b127a20 EFLAGS: 00010293
RAX: ffffffff818eed7a RBX: ffff8880563ff400 RCX: ffff88807e13bc80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000b127af0 R08: ffff8880563ff477 R09: 1ffff1100ac7fe8e
R10: dffffc0000000000 R11: ffffed100ac7fe8f R12: 1ffff92001624f4c
R13: dffffc0000000000 R14: 0000000000000002 R15: dffffc0000000000
FS:  000055556f6ab500(0000) GS:ffff888125ae1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9324bff000 CR3: 0000000028336000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vhost_worker_queue+0x194/0x260 drivers/vhost/vhost.c:253
 __vhost_worker_flush+0x134/0x1e0 drivers/vhost/vhost.c:290
 vhost_worker_flush drivers/vhost/vhost.c:303 [inline]
 vhost_dev_flush drivers/vhost/vhost.c:313 [inline]
 vhost_dev_stop+0x282/0x320 drivers/vhost/vhost.c:1178
 vhost_vsock_dev_release+0x203/0x3f0 drivers/vhost/vsock.c:751
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e0278eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe017861a8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f6e029d7da0 RCX: 00007f6e0278eba9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f6e029d7da0 R08: 0000000000013868 R09: 0000001a0178649f
R10: 00007f6e029d7cb0 R11: 0000000000000246 R12: 000000000001c379
R13: 00007f6e029d6090 R14: ffffffffffffffff R15: 00007ffe017862c0
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

