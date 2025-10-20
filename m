Return-Path: <linux-kernel+bounces-861793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A9BF3ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00BD3B76C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19205333455;
	Mon, 20 Oct 2025 21:09:29 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E22EA726
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994568; cv=none; b=TDoKyu1AcZEoEGZ6m8hwDVq5qZve4QXelSWBsnZrj3G+TmjdHTqaalGv3XCNYxCgfC62y3t9SddP/p4qkkohIADH7FA7IUZBRuxNOmrDGo4MAnn86DVVUjzsN7nMk9FhEStjcyimm21Q7y7GKjj/fmj7K7j9vS5cJHiOhEGq4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994568; c=relaxed/simple;
	bh=DS0tap6xNmbpJv6p8l75DfxSZIopObAKGStUF4jO8eo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F4EhNYbvNyKhNoMFooEjFgkqEZJtJUFJyzFwvMXR2x/+U8av8S6SucHfMgCJuvpQv4B9gJ/yT57RycSAju/DUU6w1ydIsSMi7ad5xTGxagOxLDNz+YRfO3S1b3lGZyNhAeeCDEvu1I+dSs1+C9AMKmL/XGOdNBSBg3hOoLp6ozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e8d8d227bso725474839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994566; x=1761599366;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXqk3MnmbWUfUTVa8bnsdVBgFdulvqDn/MYGA/ODBCg=;
        b=SIyOsrZ/6bxuIx+0EHrUxdNVmnfIX1qBPvVTJOlOKXWI6Y4NZTK0nzyAkwz0PSvye+
         CN1PeKQXLQ7pmZvEd18OMYNp21HChGrObXcV8rlj+MBqFyMq4xmugmhYUvQN4wOIFp/D
         7n2oOyzGw7X3lFvvNGOcPzfgS2Sm5pjffHBArjObdge+e/dMcfaIx55Tq/jY+il0CmBD
         rlogXacz42a3zFqm45GQTHKttWbirvf2D+OMe+11c6tDVbEUDmI9TGtxsdApYQNYGx7L
         AvgEozsUSy3SeSTi3jSFlrLchlgLsWsl7Y53+e3HphHJJwYSM/HFiyjjBNOO1ritexmI
         2hMg==
X-Forwarded-Encrypted: i=1; AJvYcCW81Rc1kXIk2dwxmydwwUWRbBrhWOHfw47JWlC7visCKIY8060KwjL4GeK+p/1CbGLv1t4EVCzzk+GGMvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7T3r1IUT0ACVTEDO1Zdp0I6b9i8/+NyTeW3ld1gq5XYsDYNW
	rSoWujiMI8pbiEtSA2Ai/T0Y9E4b1oXjvMdcWmaPcOy/SkgfYW0wCS9CLcM4Xd75heEJjCc6uXY
	JYDFe8FZigHrlDSNb1kXubhg9F8qhgRvvfVT2Ar/eSHxjrkEOEgfch/lNh+I=
X-Google-Smtp-Source: AGHT+IGpvx+zvw83xRku9oM0WOtwOm4pkyc8/QeRTAdYFf5Ark3AVgdUL4Wd6nV/KBa91B8gCqDvdatMXujAb4Ic6JG9LWEAI6Ha
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b0b:b0:938:6d80:960e with SMTP id
 ca18e2360f4ac-940ddd85458mr509912439f.17.1760994565906; Mon, 20 Oct 2025
 14:09:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6a505.050a0220.91a22.0455.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_thaw_freeze_initiator
From: syzbot <syzbot+18b8ec796f5bcc9ea482@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    606da5bb1655 Add linux-next specific files for 20251020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15e57de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc275090905d8fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=18b8ec796f5bcc9ea482
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106a9492580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dfd005041711/disk-606da5bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c92ee475612c/vmlinux-606da5bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54c20315c52c/bzImage-606da5bb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/802ab7289535/mount_2.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11e57de2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18b8ec796f5bcc9ea482@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000206: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000001030-0x0000000000001037]
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events gfs2_withdraw_func
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:577 [inline]
RIP: 0010:__mutex_lock+0x13b/0x1350 kernel/locking/mutex.c:760
Code: 80 63 9d 99 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 2b 10 00 00 83 3d 43 45 4d 0e 00 75 23 49 8d 7c 24 60 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 f9 03 d6 f6 4d 39 64 24 60 0f 85 51 0f 00
RSP: 0018:ffffc900000f7720 EFLAGS: 00010206
RAX: 0000000000000206 RBX: ffffc900000f7800 RCX: ffffffff999d6303
RDX: ffff88801ce89e40 RSI: ffffffff8da16ac7 RDI: 0000000000001030
RBP: ffffc900000f78c8 R08: ffffc900000f7847 R09: 0000000000000000
R10: ffffc900000f7820 R11: fffff5200001ef09 R12: 0000000000000fd0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125cfe000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09ea358000 CR3: 00000000292f8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 gfs2_thaw_freeze_initiator+0x4e/0xc0 fs/gfs2/super.c:826
 do_withdraw+0x2bf/0x320 fs/gfs2/util.c:155
 gfs2_withdraw_func+0x2f3/0x430 fs/gfs2/util.c:-1
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:577 [inline]
RIP: 0010:__mutex_lock+0x13b/0x1350 kernel/locking/mutex.c:760
Code: 80 63 9d 99 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 2b 10 00 00 83 3d 43 45 4d 0e 00 75 23 49 8d 7c 24 60 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 f9 03 d6 f6 4d 39 64 24 60 0f 85 51 0f 00
RSP: 0018:ffffc900000f7720 EFLAGS: 00010206
RAX: 0000000000000206 RBX: ffffc900000f7800 RCX: ffffffff999d6303
RDX: ffff88801ce89e40 RSI: ffffffff8da16ac7 RDI: 0000000000001030
RBP: ffffc900000f78c8 R08: ffffc900000f7847 R09: 0000000000000000
R10: ffffc900000f7820 R11: fffff5200001ef09 R12: 0000000000000fd0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125cfe000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09ea358000 CR3: 00000000292f8000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	80 63 9d 99          	andb   $0x99,-0x63(%rbx)
   4:	48 c1 e8 03          	shr    $0x3,%rax
   8:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
   d:	84 c0                	test   %al,%al
   f:	0f 85 2b 10 00 00    	jne    0x1040
  15:	83 3d 43 45 4d 0e 00 	cmpl   $0x0,0xe4d4543(%rip)        # 0xe4d455f
  1c:	75 23                	jne    0x41
  1e:	49 8d 7c 24 60       	lea    0x60(%r12),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 f9 03 d6 f6       	call   0xf6d6042f
  36:	4d 39 64 24 60       	cmp    %r12,0x60(%r12)
  3b:	0f                   	.byte 0xf
  3c:	85 51 0f             	test   %edx,0xf(%rcx)


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

