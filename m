Return-Path: <linux-kernel+bounces-853619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D637EBDC1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B72574EA5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1223081D1;
	Wed, 15 Oct 2025 02:12:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D51917FB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494348; cv=none; b=ptCMVaAZpVGzOkgpb92PAp1aE03js8OvtmRfutwIBp17udBElQIgamn4AaTD5uTYdfYOy1gDcnXNAX+odhmQMB+bGLmuHoOkfxGyouA8WquPnGg5NHCnfM5wME4PyZE+eaBHBtwphS91SOWBW/k3Sqv5wTDQ6TbvhICIAZ/PsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494348; c=relaxed/simple;
	bh=QYeHTG8SBy9p/emkVUMOARuAIsw8xWXaG1D/qoyZuZ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gFhDYFUysFO68WlB+J1QvMf+NzlVVntEMTR5X5V2xi3os+Z3KSRH6seyKvMs4zvNTnw+czQr2b3PQFPQTO1uTFX8aqKB/BBqJFu3fTKjjtQV9/Lng3YI0dhhZalajqtm5iHaoITkCE3xYKB51hO8XpZY6xDRR7e47vxdVuG7XgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-425788b03a0so317727955ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494346; x=1761099146;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czg3bYoYp+jqXKznpsg2cRrqeuF74F+CDrA/UeYBKpM=;
        b=aZ2Ry7RqJsoOplmlP5nxUjHwqLr2idnCSYYRHEfDWeDTO85Z8xcehqJTF8ezsOd3OH
         /B/SEvUYq8r05lEErzmCOL8jXrzEi20nhyjIZCIUJGAIZKzPakRdZC2ze+n1RGNu1uM8
         8RhGe17hdU+3jCAtuyFmQqLjINVMdEUh8yjy6isUcntcBQxK6/1HfgvsmmuIEhmMMYx+
         Gb7v2o2xkPiquZxk2j/3ah2gxG7EWPkc1j05L46hjJ27Sd4ILfL3WmNhnuMDBo2hAt7N
         VlDlwhYLub7xNjdhKrNfT2wzwSXhFjtObjslWl3MXMYctBjAuafPkUh3v30j3Y3WSEEA
         zeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRJ5dnE2J1SgAgd8H+JmWh9wYLG4gYNiEiOY1vvhKMV4M4FL2oau1FxeN+dTYXzRK/2dVoQ8smlXSUsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3QEAUnQ8PkyO31MqM1TToWdh83Dk5U3xUza/4ctKzf/zkVZq
	pO9S/e7svlrFWdtZ119UAcCJS1aBNkY04OmTb+ZYk9ufNTrE5POHfNBL5QSlrtkpjaWn/QYK5NS
	KZmY4I3q6l+GKAw7ASn4YeQAvwErsMPq0wV4HWF2ZWRnYeKz4D4zY78x3Yao=
X-Google-Smtp-Source: AGHT+IEFeeujdLOQCiQG2bGM8drCmtuJtXbWyZDdyyFN/JYaGOtYNSmbgu+6BZl8MYKtcH8RIpOT1Zt1iVoY+ClhtltSk2UQsj6Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:427:5e1d:4200 with SMTP id
 e9e14a558f8ab-42f87411d8cmr318435495ab.29.1760494346327; Tue, 14 Oct 2025
 19:12:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef030a.050a0220.91a22.022a.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_log_is_empty
From: syzbot <syzbot+6b156e132970e550194c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52ba76324a9d Add linux-next specific files for 20251013
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1750bb34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132af304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cd7892580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1729256319ee/disk-52ba7632.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3152cfcba7c/vmlinux-52ba7632.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4065a3b3d959/bzImage-52ba7632.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e665a3c68fcf/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13085dcd980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 UID: 0 PID: 5825 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events gfs2_withdraw_func
RIP: 0010:gfs2_log_is_empty+0x73/0xd0 fs/gfs2/log.c:430
Code: f0 09 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 cd f9 28 fe 41 be 8c 00 00 00 4c 03 33 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 34 41 8b 1e 89 ef 89 de e8 c8 51 c3 fd 39
RSP: 0018:ffffc9000407f8d8 EFLAGS: 00010207
RAX: 0000000000000011 RBX: ffff88806848c9f0 RCX: ffffffff83fcf3b0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88806848cd70
RBP: 0000000000001000 R08: ffff88806848cd73 R09: 1ffff1100d0919ae
R10: dffffc0000000000 R11: ffffed100d0919af R12: 1ffff9200080ff24
R13: 1ffff1100d091800 R14: 000000000000008c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d08000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff340164000 CR3: 000000007a948000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_withdraw+0x15f/0x320 fs/gfs2/util.c:139
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
RIP: 0010:gfs2_log_is_empty+0x73/0xd0 fs/gfs2/log.c:430
Code: f0 09 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 cd f9 28 fe 41 be 8c 00 00 00 4c 03 33 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 34 41 8b 1e 89 ef 89 de e8 c8 51 c3 fd 39
RSP: 0018:ffffc9000407f8d8 EFLAGS: 00010207
RAX: 0000000000000011 RBX: ffff88806848c9f0 RCX: ffffffff83fcf3b0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88806848cd70
RBP: 0000000000001000 R08: ffff88806848cd73 R09: 1ffff1100d0919ae
R10: dffffc0000000000 R11: ffffed100d0919af R12: 1ffff9200080ff24
R13: 1ffff1100d091800 R14: 000000000000008c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d08000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff340164000 CR3: 0000000029b98000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f0 09 00             	lock or %eax,(%rax)
   3:	00 48 89             	add    %cl,-0x77(%rax)
   6:	d8 48 c1             	fmuls  -0x3f(%rax)
   9:	e8 03 42 80 3c       	call   0x3c804211
   e:	38 00                	cmp    %al,(%rax)
  10:	74 08                	je     0x1a
  12:	48 89 df             	mov    %rbx,%rdi
  15:	e8 cd f9 28 fe       	call   0xfe28f9e7
  1a:	41 be 8c 00 00 00    	mov    $0x8c,%r14d
  20:	4c 03 33             	add    (%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 34                	jne    0x67
  33:	41 8b 1e             	mov    (%r14),%ebx
  36:	89 ef                	mov    %ebp,%edi
  38:	89 de                	mov    %ebx,%esi
  3a:	e8 c8 51 c3 fd       	call   0xfdc35207
  3f:	39                   	.byte 0x39


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

