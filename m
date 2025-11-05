Return-Path: <linux-kernel+bounces-887010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AAC37114
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4358E4FE801
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF230FC3A;
	Wed,  5 Nov 2025 17:10:28 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F66214812
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362627; cv=none; b=tApbDmJxwPvDrj6qXd//lbiKitCSovoh9oxWJoO6D/+M5VfUImeWbL8TIQD+UqMd8pBP4/hro736VEy9sHrcW+Mu4rv8RRaHeLcIIzyZB2zMFpr0QF6hR2vGuOsq+HSYjxZDwtyoDCgLSQNAu25maHZh3Ub+H8H0i8NIKo1tu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362627; c=relaxed/simple;
	bh=+zpaa7HtrOkDhtNua5Gn7u5PRQ6WKlqmE+WYxVz/cSM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tn1bhqx6HHpnnOes8h6VKbTynQLtox+U3dJ+ku04YI6BbZR6QE2F+MiAX+nEinJHokP1VmCNzR5BgrfH1ZyfEPSz3EFq+Al1rq5YEv6Vl4sSYROkHx4sFsuXM4yxpBWh8X76IYDebOLrZZzjXNDT9EZ8c9BdRtlr3PKKLxKcD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9484c2ac07cso348368639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362625; x=1762967425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeKgmYgAJhRARt41Levq+ghY4ImHp5QVQzQNGpFmkC0=;
        b=wuaniTPWxmgkqbh1jPtsQu+BZRjpsw2sDhx1PZJLBxPHlEu8z2mB6rfodC76cRyGwG
         CkH8C0zg2StRXGuX3d3bE0cN/Fkj1SRTcmqu/XMGyysb1+UFCHsLm/3C1Z5JzzPhUPUC
         /tK/xgRfsVqpXxormvlQJzHzdhDMRsnPWu/mrVIf9hadBEmm0YAsQcM9KVl5gspsk1yX
         cj9MNPjdwstUFNEtDJlNbIrt/XTorSSUG6BKEU8hnfyCAmZEWdRoyJhvh0XBc1Cy8pHa
         7tSBI/5F3CE40u3fENEsYyJNqyRQC+jzYAnsTkN2BGJZMIZeFS7W0dfVc8wOdKjCyatm
         8edg==
X-Forwarded-Encrypted: i=1; AJvYcCX/GJecaxCAY1BbjylXKjC1On4WJS/9W6ckkDXCOUuoXrtYd2+tC3z6m1SOgvu2IVVH5cPvXgEJVHV+nkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/yMMATBgMHN7c+y0Zcy6G9nWS0hr0GcGNh6D6LtIiLiMQnu+
	CnGKO1IHfIn6LNblb0trLQjyvKovzNbcob7GvzztbJI8jpDYw/w9O2VvanW4bfjEL77UrdCL2bx
	KPXELtfsJGxPxqgtqxhQog2bCBHbeFfeaUl2FJu2lCnTmcMkrHCJXr8w2ztg=
X-Google-Smtp-Source: AGHT+IGUz05gGgImPSQnbiRXAwkLrpM5xFTb0YqZU5GiTFKmFrrrTzGKQg8AuFtQbUSRF0HjwUWx4/r6HnPLLsoVg6SMPwvhWwWy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:430:aedb:3719 with SMTP id
 e9e14a558f8ab-4334075983cmr58579985ab.4.1762362625007; Wed, 05 Nov 2025
 09:10:25 -0800 (PST)
Date: Wed, 05 Nov 2025 09:10:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b8500.050a0220.baf87.0043.GAE@google.com>
Subject: [syzbot] [jfs?] stack segment fault in diUpdatePMap
From: syzbot <syzbot+e87be72c9a6fe69996f5@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    691d401c7e0e Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1481b932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=e87be72c9a6fe69996f5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a9e32f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151cc292580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d338706bec79/disk-691d401c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3ac35c22ff8/vmlinux-691d401c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8d6c3e88136/bzImage-691d401c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8f4d72d1bc59/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=141ca342580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e87be72c9a6fe69996f5@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 123 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__list_add_valid_or_report+0x3e/0x130 lib/list_debug.c:29
Code: 00 00 00 48 89 d3 48 85 d2 0f 84 93 00 00 00 49 89 f6 49 89 ff 49 bd 00 00 00 00 00 fc ff df 4c 8d 63 08 4c 89 e5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 e7 e8 d2 c3 9d fd 4d 39 34 24 75 71
RSP: 0018:ffffc900039d7b10 EFLAGS: 00010a06
RAX: ffffc90003229190 RBX: dead000000000100 RCX: dffffc0000000000
RDX: dead000000000100 RSI: ffffc900032291a0 RDI: ffff88803146f898
RBP: 1bd5a00000000021 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5ef R12: dead000000000108
R13: dffffc0000000000 R14: ffffc900032291a0 R15: ffff88803146f898
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7fb61c000 CR3: 0000000041734000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 diUpdatePMap+0x63e/0xe00 fs/jfs/jfs_imap.c:2831
 txUpdateMap+0x7da/0x9c0 fs/jfs/jfs_txnmgr.c:2357
 txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
 jfs_lazycommit+0x3f1/0xa10 fs/jfs/jfs_txnmgr.c:2734
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0x3e/0x130 lib/list_debug.c:29
Code: 00 00 00 48 89 d3 48 85 d2 0f 84 93 00 00 00 49 89 f6 49 89 ff 49 bd 00 00 00 00 00 fc ff df 4c 8d 63 08 4c 89 e5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 e7 e8 d2 c3 9d fd 4d 39 34 24 75 71
RSP: 0018:ffffc900039d7b10 EFLAGS: 00010a06
RAX: ffffc90003229190 RBX: dead000000000100 RCX: dffffc0000000000
RDX: dead000000000100 RSI: ffffc900032291a0 RDI: ffff88803146f898
RBP: 1bd5a00000000021 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5ef R12: dead000000000108
R13: dffffc0000000000 R14: ffffc900032291a0 R15: ffff88803146f898
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7fb61c000 CR3: 0000000041734000 CR4: 00000000003526f0
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
  35:	e8 d2 c3 9d fd       	call   0xfd9dc40c
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

