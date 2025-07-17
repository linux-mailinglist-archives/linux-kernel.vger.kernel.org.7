Return-Path: <linux-kernel+bounces-735298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6CB08D77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC68A189485D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3D2C3260;
	Thu, 17 Jul 2025 12:50:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA311712
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756636; cv=none; b=EMxzgqWMJAteDmuvDvzIrr5Ij2XlqqiXJ1DcPA7Hph3piDCSYABIDvac5oRieeUohcpO//0XLCS+UAdroslzV68oGfLKAZF+PPJExdsHvATSm4n1g6S243h5tERI4S/bdiqrgndmjuvwnHUdlZLfHzOiW+fiiOBGqhSauQFG+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756636; c=relaxed/simple;
	bh=gq1sg5K1PsA/jH85Wh+Kf7jH78KhklYnNFGPwjTeAYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m6LreNYnu4NEVCbzcJN9ci2mThNPIvkV9Er+Emv0HPwqCdRKX4h7fpRJwCRK6ffAO1BYUV7Mh44cef2mwNJlLqtIT1f+1+OZr2kiHhQsUPAUuTe6uAX9IqkXfHbOJHyDd8CDBOSYSUpwa01V9nMokLIsomecThkHTMKnLoGbrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so104583239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756633; x=1753361433;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79v0ZMHCi6HvCZzKTQZtWwDKcFqEx9XOZ+voG4e7hlg=;
        b=DnFONxZQG64Nb6gnxthPEKdR2ADitBN0Wu4a3ti49ja92BkLKyS/VhoUXVun3faY/W
         8Vr2Y6WaCA/2JhVy9tvWDCEumS/Q6mEXLAKsgzuvA+U1LPEj6e8YwHmle9bKzP/XqVZk
         aGTXwr/XvLFxeHJjfd8I4DnEvbE2xJxgdfcm1WdPJQBPX9BBjpYsuHE9OexsXxWBMP9v
         i5v4wN9LXdN/HTcjrdMVOW6QXPiGIMM5ZxATRMaRhnx0gV48VCBfvcsDh1pcxOTSLMaO
         N8zKKbXneHtW+TNpURPLVpI9/n8qK8BeYH0GTBskKKwjxo73G6UKxrMsdDP9KjiDjxWE
         FQFA==
X-Forwarded-Encrypted: i=1; AJvYcCV5vKEc8YJi9gCTfQOSopDftO2bF6IwQ/lUEcgW4cU165paTYkZ0IoQp0+yk/WhBEmReBMuAW2hBmZTZ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXuwDEsIAd99sXVIGjlp1oHx8RZSJ1phA9uF6GyYz6yh4Fq6Y
	3coXgblY0r43WYx379kZCngiQ8jKQLEsnssJkICXHWZF7MKLbEFlfk/dN5NnDBDivrE1APt9iU4
	NBiMiD696MK7DdlzMYVSuDYhLaEu2hcv5aiaGdyo5hxvCQAc6XTnq6giRSJw=
X-Google-Smtp-Source: AGHT+IHLZ1HCqSnFjMR4KLHP6SFDjuByghjjlKM+B2N0WB4+I6KGatYCQmwuh+/cN09KFsyTM/Tb0HctEAScqEwluVEPrTO4zOPc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48b:b0:879:674e:2c73 with SMTP id
 ca18e2360f4ac-879c295015amr844546439f.4.1752756633440; Thu, 17 Jul 2025
 05:50:33 -0700 (PDT)
Date: Thu, 17 Jul 2025 05:50:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6878f199.a70a0220.693ce.0047.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in comedi_compat_ioctl
From: syzbot <syzbot+6048f8e5da91c7055339@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152307d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=6048f8e5da91c7055339
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3f31a806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51112e82d2bc/vmlinux-3f31a806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfafec79e704/bzImage-3f31a806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6048f8e5da91c7055339@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6660 at mm/page_alloc.c:4935 __alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
Modules linked in:
CPU: 0 UID: 0 PID: 6660 Comm: syz.2.103 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8f 12 73 09 83 fe 0a 0f 86 0a fe ff ff 80 3d 17 9d 7d 0e 00 75 0b c6 05 0e 9d 7d 0e 01 90 <0f> 0b 90 45 31 f6 eb 81 4d 85 f6 74 22 44 89 fa 89 ee 4c 89 f7 e8
RSP: 0018:ffffc9000dfe7988 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000001a RDI: 0000000000040dc0
RBP: 00000027fffffb00 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000001a
R13: 1ffff92001bfcf46 R14: 00000027fffffb00 R15: 000000000000001a
FS:  0000000000000000(0000) GS:ffff888097520000(0063) knlGS:00000000f503cb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7496188 CR3: 0000000066b87000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:4993
 __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
 ___kmalloc_large_node+0x84/0x1e0 mm/slub.c:4272
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4300
 __do_kmalloc_node mm/slub.c:4316 [inline]
 __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 compat_insnlist drivers/comedi/comedi_fops.c:3145 [inline]
 comedi_compat_ioctl+0x3e9/0x910 drivers/comedi/comedi_fops.c:3225
 __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
 __ia32_compat_sys_ioctl+0x23f/0x370 fs/ioctl.c:948
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf708e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f503c55c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000008008640b
RDX: 0000000080000080 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

