Return-Path: <linux-kernel+bounces-819532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280BEB5A23A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B89C584940
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312A2DF6F8;
	Tue, 16 Sep 2025 20:16:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA583284678
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053768; cv=none; b=NBiFE8qfbQ7bSyilSg6qf5l+Z5hBCT/3Y7fzfRbKDudiQ9rnGNpN+4JDXglXslQdtk2uh0TV6LqsJqB1SGXBBvdwvi8gPfcElCzNIIXhZ4Rrj5LKyXM9cpzARetJ0gK5ko5q0blEfYvSDcPsyyeVbl+orgX58mZiPeuqvZ29GOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053768; c=relaxed/simple;
	bh=GV/Anpa9BUyDrETd5Vl19wg5oQOFDrL6jVGgMF2CYic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qos1ibympgKlhXGKH2vGktxTqYu6IEBTuJE6dbXcn0MCLIXAVqRyDyFIh4PGW2/QZlo5yZBci1mEu14tsTQmbgyd5FZ7hF9ExYxMGi/kF7eEFRYgZPWq889ADmFWNfdnkXuLrIJBEOAENPIrVx2R1FzasRgcESOUVGK+cner3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so28702075ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053765; x=1758658565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WBf4VMF95kQW2Vgv2EqAtC6K0iPMm3qBWaT0jmND/c=;
        b=p4raRjv5elSwlrtbUVPc03j5lqoB/Ub15RCWN6LgpKh/k9K9RaWHdYHKmZtD49CqyW
         0+nZAQs9vgSngCXophC7Rm89mRKhODd9lS+JVc86LDjl0CxTEmSc1UArft79APV5QpAR
         MYZ1G+z7hD4Zj/pdQ+u+wsXg2CyiSNygsgXJRzo53DSLoLjEpDLAWAUlDVb6qn+fftyF
         PEg/bwZXA5sYGFwU2f6Eq+mZgTksqHyo8tL+ptw0ObFu0EmCRVz2yVSCUS6S0hlKrDNY
         bgUnH40gRMNwrw9Ju6u8eKIKtc3PRFkC8EJIdVe7aQlDgma61GlWoTggVnRaoYLJsmWv
         IoCg==
X-Forwarded-Encrypted: i=1; AJvYcCWd/Fals+Lhcvga38zv+zofvIfCuUVZ380uWbFw9ORc3S6oQd0+FCZ99M2gBiPpchAjGEvUziyhkX+gVhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83KK5Or7OiXzlPeT/k+ZMbzz3lhiwClxtT5Y4lJGg/hO1dJIj
	fJ1jwWsCQQj7i4Uiu1OFvIwZykSxC6+veiARV5ZLb4s53UVj5MRf14i9U7Ah3BD3PajQN98BfL0
	PHwr/uEO5fRl/pa73Z9Re0xEuvfd3AhDSSALhQjDdaH79ZXw9MEUC6Mouw6U=
X-Google-Smtp-Source: AGHT+IEAXu4ti5K6GD1n2zGTW6TG9vL1J1PzqtqohmjNgIVpiWf5sx1YljzocbSg7/wOeRQDbsRFlwxgP7otiQnwZ7UqdRSSLEIw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:3f1:931f:bc33 with SMTP id
 e9e14a558f8ab-420a4174333mr167215075ab.24.1758053764943; Tue, 16 Sep 2025
 13:16:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:16:04 -0700
In-Reply-To: <CAL4kbRNO9ciS9zWA3bjZOEbseEvHHM=DxtNae=phjzYTDEpEBg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9c584.050a0220.2ff435.0433.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_print_dbg (3)
From: syzbot <syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in gfs2_print_dbg

Oops: general protection fault, probably for non-canonical address 0xe7697c1115925d6c: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x3b4c0088ac92eb60-0x3b4c0088ac92eb67]
CPU: 1 UID: 0 PID: 6617 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:string_nocheck lib/vsprintf.c:653 [inline]
RIP: 0010:string+0x1bb/0x2b0 lib/vsprintf.c:735
Code: 15 a5 f6 eb b3 41 c1 fd 10 4c 89 6c 24 10 49 8d 5d ff 45 31 ed 4b 8d 3c 2c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 60 4b 8d 2c 2e 47 0f b6 3c 2c 31 ff 44 89 fe
RSP: 0018:ffffc900034b6f00 EFLAGS: 00010007
RAX: 0769801115925d6c RBX: 00000000fffffffe RCX: dffffc0000000000
RDX: ffff88802f929e40 RSI: 00000000ffff0a00 RDI: 3b4c0088ac92eb67
RBP: ffffffff8bf0acfe R08: ffff88802f929e40 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000000 R12: 3b4c0088ac92eb67
R13: 0000000000000000 R14: ffffc900034b7319 R15: 0000000000000030
FS:  00007fb88c0ac6c0(0000) GS:ffff888125ae8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa707863000 CR3: 000000005caf0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vsnprintf+0x739/0xf00 lib/vsprintf.c:2926
 va_format lib/vsprintf.c:1728 [inline]
 pointer+0x940/0x1190 lib/vsprintf.c:2548
 vsnprintf+0x60f/0xf00 lib/vsprintf.c:2930
 vprintk_store+0x3c7/0xd00 kernel/printk/printk.c:2252
 vprintk_emit+0x15f/0x590 kernel/printk/printk.c:2399
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 gfs2_print_dbg+0x19a/0x1b0 fs/gfs2/glock.c:1444
 dump_holder fs/gfs2/glock.c:2287 [inline]
 gfs2_dump_glock+0x152d/0x1bc0 fs/gfs2/glock.c:2398
 gfs2_consist_inode_i+0xf5/0x110 fs/gfs2/util.c:446
 gfs2_dirent_scan+0x545/0x690 fs/gfs2/dir.c:-1
 gfs2_dir_read+0x804/0x16f0 fs/gfs2/dir.c:1600
 gfs2_readdir+0x14c/0x1b0 fs/gfs2/file.c:116
 iterate_dir+0x399/0x570 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb88b18eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb88c0ac038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fb88b3d6090 RCX: 00007fb88b18eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fb88b211e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb88b3d6128 R14: 00007fb88b3d6090 R15: 00007ffde70dec98
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:string_nocheck lib/vsprintf.c:653 [inline]
RIP: 0010:string+0x1bb/0x2b0 lib/vsprintf.c:735
Code: 15 a5 f6 eb b3 41 c1 fd 10 4c 89 6c 24 10 49 8d 5d ff 45 31 ed 4b 8d 3c 2c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 60 4b 8d 2c 2e 47 0f b6 3c 2c 31 ff 44 89 fe
RSP: 0018:ffffc900034b6f00 EFLAGS: 00010007
RAX: 0769801115925d6c RBX: 00000000fffffffe RCX: dffffc0000000000
RDX: ffff88802f929e40 RSI: 00000000ffff0a00 RDI: 3b4c0088ac92eb67
RBP: ffffffff8bf0acfe R08: ffff88802f929e40 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000000 R12: 3b4c0088ac92eb67
R13: 0000000000000000 R14: ffffc900034b7319 R15: 0000000000000030
FS:  00007fb88c0ac6c0(0000) GS:ffff888125ae8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa707863000 CR3: 000000005caf0000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	15 a5 f6 eb b3       	adc    $0xb3ebf6a5,%eax
   5:	41 c1 fd 10          	sar    $0x10,%r13d
   9:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
   e:	49 8d 5d ff          	lea    -0x1(%r13),%rbx
  12:	45 31 ed             	xor    %r13d,%r13d
  15:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 60                	jne    0x92
  32:	4b 8d 2c 2e          	lea    (%r14,%r13,1),%rbp
  36:	47 0f b6 3c 2c       	movzbl (%r12,%r13,1),%r15d
  3b:	31 ff                	xor    %edi,%edi
  3d:	44 89 fe             	mov    %r15d,%esi


Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1205f762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7122891ab9e0bbc6a7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

