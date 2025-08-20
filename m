Return-Path: <linux-kernel+bounces-777335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5932B2D84E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B9D1C46C50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D252DE718;
	Wed, 20 Aug 2025 09:22:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2872BEFE7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681752; cv=none; b=gUsRjWIGeHWq3qm6iAcfkdLcuOgWWW/+/bx5OfuHoxad0kFvlLZkuIsOlikgYwhkUmefSk1NslF9+L7VXha6envdM5dG90te6Uznnj5v7AavXKDfi1VU+U11bKa1tovuT4mBxHiu2kUylgPZYl3aORH4+iGwVn94x6mtaJMdSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681752; c=relaxed/simple;
	bh=6RibQmjfdGhLxwft9hSynoUGFooibb9mLVgsdvRf9Bo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EaofD5MvzJ8lYlmyQAWxKIep9zZgibEeX/6FVwbRi2IlbR5f+REotNRlNWm3AnAaBSUSpu3fYysOuFLuqtDjHFk4relPsHjz55t3KGLhPlZeJrNrpGLgGz1Cd2HE7sTI/o9ohukYCaH8piIpGZkGYitCYj96LPI8+DQIrQD9YKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432e631a7so1759162839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681749; x=1756286549;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IOsvlCn6bNehdNddsd3cfCeCLa2ODNVYcldXRzd2s8=;
        b=l0VQoDGOcKi4wOhPq0D4RIc1yzFcd9Hjpi0bsb4pBsWD/1z6M+IAn0wC59b0gvtqCz
         6pUQyfvksytnZuXfnOuZe5PJtCm1epyQgMzleh8GW2sj4QvPBPX/S/HkDPBmvTFAABfZ
         qVJZlepc0um9kkb2ut150giuW7lLHxnSCdGZwbdTIp+UdDoe0RfuElg7In/AASZA9Xex
         bDrzMirOPVrWjEq3Q5ChMREU6rq+EnWhH4A8UaknQIrlNJoc7GkZC8H0SKEiwxbPaX8l
         +DuWOAuJ/+YTsPg35LxljAlWJM58+OGbdXFAvWcAa2oI61Og6XdAVsvnmeSNDpfHMazC
         4Sig==
X-Forwarded-Encrypted: i=1; AJvYcCVp5ojNFEqpPv7Aejm+pWbChz7ZL+txMrEyYke5i2ShS5im5msuXedpfo74XUgz9/P/RI+5fT0Mbt6LDfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztj5T0DzoQgkKB8Xysgi+3Z2ICNKrHZtoTXvME2mzQN/wTrYlQ
	gUEqI3Qo9vV4bxprBnh6D9qiZkwr4ZtLIB9IT9EvZ62odmEjJdA/Zz8aiS+qIfm15f6aOd/V1LQ
	GAyBz/rGfyhxFiiYSaeXi3eUlSP4IAonzE4zZPOWIJQCX6u7WIj6ugfGssdA=
X-Google-Smtp-Source: AGHT+IHZDW0lTUXSXn14RmR2TI+Qke9fg8Hx1/lZR9VIAmC7os+uGLoiFGjKAfGB3UCReEK8yRvt47RU8SW79w7Dl0efPMnKr85o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1511:b0:881:9a39:9ef1 with SMTP id
 ca18e2360f4ac-884714b7632mr485430839f.0.1755681749562; Wed, 20 Aug 2025
 02:22:29 -0700 (PDT)
Date: Wed, 20 Aug 2025 02:22:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a593d5.a70a0220.2e41e7.0001.GAE@google.com>
Subject: [syzbot] [jfs?] stack segment fault in release_metapage
From: syzbot <syzbot+43706fd1eb4c8dccdfe6@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b19a97d57c15 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164be7a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=43706fd1eb4c8dccdfe6
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166f7234580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166b3ba2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3680804d0eba/disk-b19a97d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00b082ce2930/vmlinux-b19a97d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a6a94ccbccc/bzImage-b19a97d5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5c560e6f4683/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=112566f0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43706fd1eb4c8dccdfe6@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] SMP KASAN [   95.155857][  T122] Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 122 Comm: jfsCommit Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:folio_flags include/linux/page-flags.h:360 [inline]
RIP: 0010:folio_trylock include/linux/pagemap.h:1096 [inline]
RIP: 0010:folio_lock include/linux/pagemap.h:1132 [inline]
RIP: 0010:release_metapage+0x9e/0xab0 fs/jfs/jfs_metapage.c:870
Code: 04 00 00 e8 b4 c9 87 fe 48 c7 c7 51 f4 05 8d be 6b 04 00 00 e8 43 ba 5a fe 2e 2e 2e 31 c0 49 8d 5c 24 08 48 89 dd 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 48 89 df e8 a2 fc e6 fe 4c 8b 3b 4c 89 fe
RSP: 0018:ffffc900039976d8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffff88801ebc3b80
RDX: ffff88801ebc3b80 RSI: 000000000000046b RDI: ffffffff8d05f451
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100b48576e R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88805a42bb48 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555561a8e648 CR3: 0000000023fb6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xtTruncate+0xe84/0x2e70 fs/jfs/jfs_xtree.c:-1
 jfs_free_zero_link+0x33a/0x4a0 fs/jfs/namei.c:759
 jfs_evict_inode+0x363/0x440 fs/jfs/inode.c:153
 evict+0x501/0x9c0 fs/inode.c:810
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x3f1/0xa10 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_flags include/linux/page-flags.h:360 [inline]
RIP: 0010:folio_trylock include/linux/pagemap.h:1096 [inline]
RIP: 0010:folio_lock include/linux/pagemap.h:1132 [inline]
RIP: 0010:release_metapage+0x9e/0xab0 fs/jfs/jfs_metapage.c:870
Code: 04 00 00 e8 b4 c9 87 fe 48 c7 c7 51 f4 05 8d be 6b 04 00 00 e8 43 ba 5a fe 2e 2e 2e 31 c0 49 8d 5c 24 08 48 89 dd 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 48 89 df e8 a2 fc e6 fe 4c 8b 3b 4c 89 fe
RSP: 0018:ffffc900039976d8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffff88801ebc3b80
RDX: ffff88801ebc3b80 RSI: 000000000000046b RDI: ffffffff8d05f451
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100b48576e R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88805a42bb48 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555561a8e648 CR3: 00000000366e0000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	04 00                	add    $0x0,%al
   2:	00 e8                	add    %ch,%al
   4:	b4 c9                	mov    $0xc9,%ah
   6:	87 fe                	xchg   %edi,%esi
   8:	48 c7 c7 51 f4 05 8d 	mov    $0xffffffff8d05f451,%rdi
   f:	be 6b 04 00 00       	mov    $0x46b,%esi
  14:	e8 43 ba 5a fe       	call   0xfe5aba5c
  19:	2e 2e 2e 31 c0       	cs cs cs xor %eax,%eax
  1e:	49 8d 5c 24 08       	lea    0x8(%r12),%rbx
  23:	48 89 dd             	mov    %rbx,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 80 7c 2d 00 00    	cmpb   $0x0,0x0(%rbp,%r13,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	48 89 df             	mov    %rbx,%rdi
  35:	e8 a2 fc e6 fe       	call   0xfee6fcdc
  3a:	4c 8b 3b             	mov    (%rbx),%r15
  3d:	4c 89 fe             	mov    %r15,%rsi


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

