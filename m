Return-Path: <linux-kernel+bounces-779074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B48B2EEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECD0D4E4586
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9602E7193;
	Thu, 21 Aug 2025 06:50:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F92DFA39
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759033; cv=none; b=K9hx3yOUmeTzIpybxLQofg2On23W3a33/qUoh3DyL6GmZHQpM4U9v/8gc1XN8eERwdXYZM879ndbs+bv+AjrKBfGR2TgvTPHTIM4KewfwoMxs0ekzJtsYA0rPt36q+D4hyaci121cbDkwMJ5ibefRyvcz7bHiLu1nrVDCf9M7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759033; c=relaxed/simple;
	bh=dz1ZJ6uOLu2/0c7unCj77MdFjzGZM123WhwxBmWltSs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DDatN09d5o8H8cl+r6bCA2+sjGsGiuBly7rM/5Eh6wnhs6bQcdU2BSMASD6hYXlOy159+L2aFliTyCivqzWQ5+dlmxqaDBIrz34zEhN2Rmt05kfdQdYfMUM0zsDIgn5X6w5kJQc+Ch7q5USf9E62kACG/m8j0wcfsxNCMGKAsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e7172dea48so10568235ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759030; x=1756363830;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiTmGrCkZOrMVCLRVi6dRmqYhMo1ykO1wC7h+UBgH5E=;
        b=n3e65K1Tq5W/psImJlxf+JBHnouSKFBg2HY+K3YYvMQL5PGT7WNDe4K5Rd+5Yskyqf
         R/ULeLFiD3eX16tQ19qCYUtsMyQb3W2MPZCjKjsJ0JdQFQw1VxvqkLNAFQH/H2jVfH53
         7YKmoSJX1u7Xw2Lx2loH90O2HQeCz61B51exXfCXrgXfaL6PRghFo7sen42ffQwKCQDO
         lUyRS5iu22MfJK9mp8cTZy+2dwVfpxU/oeFCtZjqVDEVSLXGNyp/Y7/Necjs+40lxO8u
         QZUdIdxx7sf0NklcDMxO+LUk8pW4ehOt08cfy4O9BPCsz5a5VUXnN5OEyWIhgyR3pzxk
         TOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUQ6AII2F9dVt96scAwPjol2k+b7mEGi7o/nNZi3F2TvFNebklZHw+fMm5FCQ2Yr5FZfy54R5YS4DQff0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13V+d2vJjcWmzjyv7xCEZzsAkjgyU6hx8mScShHzcZdXtobec
	4ZDmvZOkxatWLUNonCtqaLOd+ouPhhtzBxPislyME/cJ0Fy7CSFcC37PetL0ZGSUL8dzjaspAYF
	CtrersvXRl1XUpW9icHm9cnCGl7ig/kT6tC6kFOSaIF5NJ4R/kKn4/4x8yMU=
X-Google-Smtp-Source: AGHT+IHBUeYbsI0remU4+VvN/3+ewC/D/Cx+HfpuUot1F8ZDSkzWxe7j5Vj+UhDo3TmebHyUJaxQ1e5XmwAJ3zNCq9pypKjwYcvM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3e6:7d65:97c0 with SMTP id
 e9e14a558f8ab-3e6d3b7f534mr26572925ab.1.1755759030601; Wed, 20 Aug 2025
 23:50:30 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:50:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a6c1b6.050a0220.3d78fd.001b.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in __gfs2_trans_begin
From: syzbot <syzbot+a3a4e5eee651210c6887@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5303936d609e Add linux-next specific files for 20250820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a957a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4602df3fd8f406ec
dashboard link: https://syzkaller.appspot.com/bug?extid=a3a4e5eee651210c6887
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11718fa2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165f16f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57c3527e418a/disk-5303936d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f1e146ea30f/vmlinux-5303936d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55bebb5dd947/bzImage-5303936d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b60fdd2027e2/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=12a1d442580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3a4e5eee651210c6887@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 UID: 0 PID: 96 Comm: kworker/0:1H Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: gfs2-glock/syz:syz glock_work_func
RIP: 0010:__gfs2_trans_begin+0x3a6/0x890 fs/gfs2/trans.c:73
Code: 09 00 00 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 bb 1b 25 fe 41 bf 8c 00 00 00 4d 03 7d 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 03 04 00 00 45 8b 3f 89 df 44 89 fe e8
RSP: 0018:ffffc900025e76c0 EFLAGS: 00010207
RAX: 0000000000000011 RBX: 0000000000000004 RCX: ffff88801e361e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffc900025e7878
RBP: ffffc900025e77b0 R08: ffff8880580780af R09: 1ffff1100b00f015
R10: dffffc0000000000 R11: ffffed100b00f016 R12: dffffc0000000000
R13: ffff888058078998 R14: ffffc900025e7800 R15: 000000000000008c
FS:  0000000000000000(0000) GS:ffff888125a05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f97a2c23f98 CR3: 000000003368e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 gfs2_ail_empty_gl+0x12b/0x2f0 fs/gfs2/glops.c:130
 inode_go_sync+0x462/0x5d0 fs/gfs2/glops.c:336
 do_xmote+0x322/0x1060 fs/gfs2/glock.c:704
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1080
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__gfs2_trans_begin+0x3a6/0x890 fs/gfs2/trans.c:73
Code: 09 00 00 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 bb 1b 25 fe 41 bf 8c 00 00 00 4d 03 7d 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 03 04 00 00 45 8b 3f 89 df 44 89 fe e8
RSP: 0018:ffffc900025e76c0 EFLAGS: 00010207
RAX: 0000000000000011 RBX: 0000000000000004 RCX: ffff88801e361e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffc900025e7878
RBP: ffffc900025e77b0 R08: ffff8880580780af R09: 1ffff1100b00f015
R10: dffffc0000000000 R11: ffffed100b00f016 R12: dffffc0000000000
R13: ffff888058078998 R14: ffffc900025e7800 R15: 000000000000008c
FS:  0000000000000000(0000) GS:ffff888125a05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f97a2c23f98 CR3: 000000007c81c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	09 00                	or     %eax,(%rax)
   2:	00 4c 89 e8          	add    %cl,-0x18(%rcx,%rcx,4)
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   f:	74 08                	je     0x19
  11:	4c 89 ef             	mov    %r13,%rdi
  14:	e8 bb 1b 25 fe       	call   0xfe251bd4
  19:	41 bf 8c 00 00 00    	mov    $0x8c,%r15d
  1f:	4d 03 7d 00          	add    0x0(%r13),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 03 04 00 00    	jne    0x43a
  37:	45 8b 3f             	mov    (%r15),%r15d
  3a:	89 df                	mov    %ebx,%edi
  3c:	44 89 fe             	mov    %r15d,%esi
  3f:	e8                   	.byte 0xe8


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

