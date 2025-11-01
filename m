Return-Path: <linux-kernel+bounces-881453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF72C283CE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC7B74E3FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583329B224;
	Sat,  1 Nov 2025 17:24:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8FD3B186
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762017870; cv=none; b=BLxke3pFw/yps5nwGXyl7iyfK1LMeshGloKcuNonvpZLjdR3+MFmj+XxjLkpo3ES+iSLIRiw1JlcNp0hinDJ98rsco11oN3jXInPbMoqs3bgTFieG+/DWaFzwfm7isQV7nP3In/ceUJRkA5r0mOeXLMBTneM9OA53ivSyuGSSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762017870; c=relaxed/simple;
	bh=Ml6lKiCcTwIdvswB/mVo84YAPo5167wphvM6H92gqGM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kbThQtnM+dSkmICD5w2mresgjzQe/yjueuxJRm1SI5jvRx423K8kQCZN5yjlJD3KU4nj1OhDZCyYCn9zGVHlYSKVdTybsY7Keb5l8aZ5avtYXDBUuJLY/AXL06egJJL3kjjHDMwmmzLrpKatJRiJCpgLxgB7/a6pFypoo3aamVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430db6d358bso126013395ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762017867; x=1762622667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gETJATw+FlU838M0RG46FO9wFg1WiXhpWJOEIM/jFcg=;
        b=WEDKLKgjzuRxB4aN9q8PBCZ2w9JiVKJw8RYFQApYVDJsSRaDub/mbmOl60uu84aZ6E
         t9OlSwdkKgc9bY1Fk1wAtTXUzTtCJY2KRPX+qbpV7tE30Inw5N+Cd7TgoTLASHyan/Nu
         fMIzbiEcfLEO2zJvSlacSgNjzgM0NYIwzdQ9Gh0T1GHj3uUvYj9HtiZ5jrQHAnVH1iEr
         4Io7Vtot5kcsZQ8AkWQtbJeEpsuuqQdfd8DgsI/BdOWIHBTupT+wls3DHATe7xi4rZRX
         XpeI9Zc+1skUvy1tOv7UsqddXh/0WkP01RylgOBVGrxYGYg+6Prvw4L4q7b6c2eGhxd+
         mRZw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJrk9OkiKK2z/teKUHkbHlvyADY9qgzYT98eXZF7hlDsYffrxLom3H/e1HlGNIqohQrLe36Yq6WNOLzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBwQKGd0yS2dah5vhS65RNfFgKQdOsTtVXoPxJVdmjkiZWDHs
	9U5E9295QPKzyQ6H5hP6B8fN1Ldca0DJvNK/+UZc6vRGbIHso/6d69sLH6CHUWMG/vP4GPuhiDy
	q+fNXIcbWpuhrPNDiPzROVmRLJ/ZXQ3KiiWCNCJdZzHNS/b2lb6rDPecqKUw=
X-Google-Smtp-Source: AGHT+IEsvQZmjvblisP4ofaPT88OLl+c2JUMB3GtuRRXz31cIpRyN2fo8UtwjJxCTuLCxWKBRAWKM6KkzDjgELXYej91a/PIAx5g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3397:b0:430:9f96:23c8 with SMTP id
 e9e14a558f8ab-4330d14876fmr122472285ab.14.1762017867151; Sat, 01 Nov 2025
 10:24:27 -0700 (PDT)
Date: Sat, 01 Nov 2025 10:24:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6906424b.050a0220.29fc44.0007.GAE@google.com>
Subject: [syzbot] [jfs?] stack segment fault in dbUpdatePMap
From: syzbot <syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba36dd5ee6fd Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1145ae14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=f5a5b157b7336d1fda1d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b151a6a8b947/disk-ba36dd5e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ddc072fd4513/vmlinux-ba36dd5e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7cdcc5b6e230/bzImage-ba36dd5e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 122 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__list_add_valid_or_report+0x3e/0x130 lib/list_debug.c:29
Code: 00 00 00 48 89 d3 48 85 d2 0f 84 93 00 00 00 49 89 f6 49 89 ff 49 bd 00 00 00 00 00 fc ff df 4c 8d 63 08 4c 89 e5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 e7 e8 32 c4 9d fd 4d 39 34 24 75 71
RSP: 0018:ffffc900031f7a20 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: dead000000000100 RCX: ffff88801dbc9e00
RDX: dead000000000100 RSI: ffffc9000323a140 RDI: ffff88802f4c9898
RBP: 1bd5a00000000021 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5cf R12: dead000000000108
R13: dffffc0000000000 R14: ffffc9000323a140 R15: ffff88802f4c9898
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555586d63608 CR3: 0000000038d96000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 dbUpdatePMap+0x7e4/0xeb0 fs/jfs/jfs_dmap.c:577
 txAllocPMap+0x57d/0x6b0 fs/jfs/jfs_txnmgr.c:2426
 txUpdateMap+0x2a2/0x9c0 fs/jfs/jfs_txnmgr.c:2309
 txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
 jfs_lazycommit+0x3f1/0xa10 fs/jfs/jfs_txnmgr.c:2734
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0x3e/0x130 lib/list_debug.c:29
Code: 00 00 00 48 89 d3 48 85 d2 0f 84 93 00 00 00 49 89 f6 49 89 ff 49 bd 00 00 00 00 00 fc ff df 4c 8d 63 08 4c 89 e5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 e7 e8 32 c4 9d fd 4d 39 34 24 75 71
RSP: 0018:ffffc900031f7a20 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: dead000000000100 RCX: ffff88801dbc9e00
RDX: dead000000000100 RSI: ffffc9000323a140 RDI: ffff88802f4c9898
RBP: 1bd5a00000000021 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5cf R12: dead000000000108
R13: dffffc0000000000 R14: ffffc9000323a140 R15: ffff88802f4c9898
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555586d63608 CR3: 0000000038d96000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	d3 48 85             	rorl   %cl,-0x7b(%rax)
   8:	d2 0f                	rorb   %cl,(%rdi)
   a:	84 93 00 00 00 49    	test   %dl,0x49000000(%rbx)
  10:	89 f6                	mov    %esi,%esi
  12:	49 89 ff             	mov    %rdi,%r15
  15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  1c:	fc ff df
  1f:	4c 8d 63 08          	lea    0x8(%rbx),%r12
  23:	4c 89 e5             	mov    %r12,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 80 7c 2d 00 00    	cmpb   $0x0,0x0(%rbp,%r13,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 e7             	mov    %r12,%rdi
  35:	e8 32 c4 9d fd       	call   0xfd9dc46c
  3a:	4d 39 34 24          	cmp    %r14,(%r12)
  3e:	75 71                	jne    0xb1


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

