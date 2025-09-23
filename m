Return-Path: <linux-kernel+bounces-829761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01048B97C36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BCE2A5478
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7730F81A;
	Tue, 23 Sep 2025 22:59:40 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECC25F7A7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668379; cv=none; b=Op57oQOnLjp2yxitmOPiHpzAlTpm886Vr5DF+LvMekOVU+gAcHFT6ievrtHy6aeuaAt0VbaQ3NQwOt8JIGbzJtM6mtplA96rT94B1t4X9HsjoL2RK2YLG0gkY/73Nn5zMw1K8U5qp8mdSNCl6JDYqQDD14CmmMAeB7br55eRXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668379; c=relaxed/simple;
	bh=32nlMOHuqrXILU771zwcjQyGHX80yYkORjilKRChStk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o8b0oe7vKpWiX/dhCCkJZCmq8sSBb3XjBqEFjgTlZpyatFKF3QIfxE36YA+7o3vQRGG88Ex2Q39msm9cnfFCw7yMzOS2voc2bT/Jbf2f2hutVMZ9TfyqksCt3JwLX+RAfjd+CO/GM3PhdbIogGB7sun2mRqfCKsxV7FbjQ2lnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4241c41110eso155952595ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758668377; x=1759273177;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+hA+SpiS5wI5RCtzMYt05Pl9oBH7vt+ljD0YONqRIE=;
        b=MU3AwwygxiBKh50SQhWwU4BSyOTMb3IGtgZ6lYUnC/jnz1HfzvWUD9E0JXkIJoOlh6
         qnje1GSdOttYuG8v5ge3ouSDk0FevYEgd5A0xZFeOscqenX6eWzIdNCnDK7kh6Ams24V
         FXyARLtVZAaqMdx3Kv96EDHXVD+fm8sJ4SDdY5Qy6w0g7tlgGjUu1YK9Qs4nyPJbpcHa
         QA1eYVNrkvTl3fA3fz1xil1hhkzpEDPxUzfR+Kdch/j3j6yjonIbNp7OIhmqYXcSzu8H
         wlWeE2KfDUMmfDtfmPj0yv8/0yOio7DnK9oeM5of74tuLPVV/p+nIM3Iy3KF/QWhA3IL
         a7RA==
X-Forwarded-Encrypted: i=1; AJvYcCWXKKemzdcJRRMn/ctIBfMh86mHRlo8WwQOJcRPDb4+56LiS+wZ0GemEo0kFp3e1HosqY7pDYHb8hVkM2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDB+X2Sz8UndVuFQDovo6dNHO13gDZOZSBvRhnTIUPFyj2PUG
	tTpQmHTy/OCrfYO26RIHQ/YscezZRM/OO13KBokTFmDX+4AaKQygGERCPl4RcfiMiWrbcvG+kO2
	Yx+zdJKc3e6h39SEs42V3xlXZKVVzyWLSs4oKBVplDlbNvqyNI6nGUkA11Mc=
X-Google-Smtp-Source: AGHT+IG1+xSwmzNVwiXGia9qsKdCe3GJDCcuywjb2bdyNeoxzAguZJorVgPzNk7AGAN8YaVzWtMIvxEj9QSrB1Y9BCknNtTm5Uoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca45:0:b0:425:6f60:5689 with SMTP id
 e9e14a558f8ab-42581e9bcc3mr70731615ab.23.1758668377460; Tue, 23 Sep 2025
 15:59:37 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:59:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d32659.a70a0220.4f78.0012.GAE@google.com>
Subject: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce7f1a983b07 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=118724e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1376e27c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e78e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c30be6f36c31/disk-ce7f1a98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae9ea347d4d8/vmlinux-ce7f1a98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d59682a4f33c/bzImage-ce7f1a98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at fs/inode.c:1928
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6028, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz.0.17/6028:
 #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffff8880326bc998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff8880326bc998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: hook_sb_delete+0xae/0xbd0 security/landlock/fs.c:1405
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6028 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8960
 iput+0x2b/0xc50 fs/inode.c:1928
 hook_sb_delete+0x6b5/0xbd0 security/landlock/fs.c:1468
 security_sb_delete+0x80/0x150 security/security.c:1467
 generic_shutdown_super+0xaa/0x2c0 fs/super.c:634
 kill_anon_super fs/super.c:1281 [inline]
 kill_litter_super+0x76/0xb0 fs/super.c:1291
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc08e18eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd5efff18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fc08e3e5fa0 RCX: 00007fc08e18eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000002c0
RBP: 00007fc08e211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc08e3e5fa0 R14: 00007fc08e3e5fa0 R15: 0000000000000002
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

