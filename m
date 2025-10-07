Return-Path: <linux-kernel+bounces-844520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E949BC21F2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB7254E74A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75970217F24;
	Tue,  7 Oct 2025 16:34:29 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94971D5CFE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854868; cv=none; b=DBRnrbMGlZSJuDqGNrs2byOdS+8t7jKoFTpHGZTIKNP0iL8P836/Z+GIlsxhu7n6N0GkwKGDV/mom0Y8qdteKHGGpvCdjM66yuqAQpBZi9LtgcJoQgkbTjmGZSgtgCTW0Q4hlsaVh1Mm3U7jo7nBa/t63+O4jOnNiyUVOTbpUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854868; c=relaxed/simple;
	bh=vVyO9fjJFoREQvEQNASLa0vvP3CB1EKRO+0FPlwuukI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r0PLXrT1I6lh/V9UHhkW/rbgCRPBHWl4ieBaxnUZegZfds8plQ7oKt9pBM/XqwuomOjOzYI9Ln8hmolvIww1xDo+tybnBL9qpjRPZH3AOcklMyDt08eST+qEohjY6ISIKJo5GsHUYg1265IYcmaO9H6RGdozLsrJ1g0nGAsG730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso1512231439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854866; x=1760459666;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxCneZz9zHSpXS0Thh06erzTU2YOStwxJfkdZ/ivVt0=;
        b=iB4xsOCtOqvZHaXXbhlk/SFSk8jPh9zAWABTXUCa+MGvzkFdKWsIThC5/plxJC+ET3
         5hTqM4cTddNARmskZfikRon9fvmy/o9aqTP0s/T9CTOWYvBZlf/Tl1m7NW3rJPPxoyU9
         f11xHjLFu0mfyX04FZbN+8h7Ffoaz7KYRQRpcjAnaJdy2/Ll0Kfsaql32E1VUfB8HpnY
         6YMnAA3bwUsX2W2R5ZGsjnc1qa9silFEHbzMPJEE1F37O2k7Ss9G+RgsyIAH5/ltheKr
         MvfSuk2NN4XCgDlHRWzcUmHfamgcZ8MVNslNbcJLhQFNmxIFOAknimAVDLGDGKuXhY+z
         PZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCVrIDZ+EVnElthGUW6HpHc/Q5hq+0IES1ZoPI87shXHJNqR7oHqfoCXdUT3n0uvWW7QSqx4H/DjhpmPSgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTT+e8hQ5RejUqsoYGAbSjRjthIE79DTstNxWUR1VPCsz7r3K
	TyzV+Ws7CwpCoFLgleUoeyxFyh4A3iviIlqaYSsQ8285J1VW0NWUubG0gRiggl7edUo38Z8rE8E
	QOmRD6AVLiRnN2EISnXjIEvJTnBd/VJWM3hYb8aG6xHd9DaugQtyHmlHGHq4=
X-Google-Smtp-Source: AGHT+IECmnNG93Sg16BBWk0/HcXV7w3PBbLJ0VUE368vFL/PKWCVTqRMrjEhDRAt6hyBPj5eOWJhXiZcJ2sR9RQPwj/MEDEhV4ib
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcf:b0:93b:bb32:a2a5 with SMTP id
 ca18e2360f4ac-93bbb32a327mr1064496639f.17.1759854865944; Tue, 07 Oct 2025
 09:34:25 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:34:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e54111.a00a0220.298cc0.047e.GAE@google.com>
Subject: [syzbot] [f2fs?] BUG: sleeping function called from invalid context
 in f2fs_drop_inode
From: syzbot <syzbot+635fba516c2c7858f799@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba9dac987319 Merge tag 'libnvdimm-for-6.18' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122ab92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1486b135ff0ff9b
dashboard link: https://syzkaller.appspot.com/bug?extid=635fba516c2c7858f799
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ba9dac98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1fa0e7fa86d/vmlinux-ba9dac98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fbfd63ebd788/bzImage-ba9dac98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+635fba516c2c7858f799@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at fs/inode.c:1928
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5328, name: syz.0.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by syz.0.0/5328:
 #0: ffff88801fcd9b80 (&sb->s_type->i_lock_key#35){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #0: ffff88801fcd9b80 (&sb->s_type->i_lock_key#35){+.+.}-{3:3}, at: f2fs_drop_inode+0x67e/0x950 fs/f2fs/super.c:1822
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8925
 iput+0x2b/0xc50 fs/inode.c:1928
 f2fs_drop_inode+0x686/0x950 fs/f2fs/super.c:1823
 iput_final fs/inode.c:1884 [inline]
 iput+0x6d9/0xc50 fs/inode.c:1966
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96098eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5e7bbf08 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fb960be7da0 RCX: 00007fb96098eec9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fb960be7da0 R08: 0000000000018f14 R09: 000000125e7bc1ff
R10: 0000000000de6eb8 R11: 0000000000000246 R12: 0000000000015259
R13: 00007fb960be6090 R14: ffffffffffffffff R15: 00007ffd5e7bc020
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5328 at fs/inode.c:1933 iput+0x38c/0xc50 fs/inode.c:1933
Modules linked in:
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:iput+0x38c/0xc50 fs/inode.c:1933
Code: 80 3d a0 88 49 0d 01 0f 85 b2 00 00 00 e8 4c 82 80 ff 4c 89 f7 be 10 00 00 00 e8 af 84 06 00 e9 2c fd ff ff e8 35 82 80 ff 90 <0f> 0b 90 e9 70 fd ff ff e8 27 82 80 ff 90 0f 0b 90 e9 d7 fe ff ff
RSP: 0018:ffffc9000d47fbb0 EFLAGS: 00010293
RAX: ffffffff823e919b RBX: 0000000000000001 RCX: ffff888000394900
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff88801fcd9bb8 R08: ffffffff9297b047 R09: 1ffffffff252f608
R10: dffffc0000000000 R11: fffffbfff252f609 R12: ffff88801fcd9ce8
R13: dffffc0000000000 R14: ffff88801fcd9ae8 R15: 1ffffffff1f3c766
FS:  00005555645a1500(0000) GS:ffff88808d30c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb960bd75f0 CR3: 00000000127cb000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 f2fs_drop_inode+0x686/0x950 fs/f2fs/super.c:1823
 iput_final fs/inode.c:1884 [inline]
 iput+0x6d9/0xc50 fs/inode.c:1966
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96098eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5e7bbf08 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fb960be7da0 RCX: 00007fb96098eec9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fb960be7da0 R08: 0000000000018f14 R09: 000000125e7bc1ff
R10: 0000000000de6eb8 R11: 0000000000000246 R12: 0000000000015259
R13: 00007fb960be6090 R14: ffffffffffffffff R15: 00007ffd5e7bc020
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

