Return-Path: <linux-kernel+bounces-733489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F481B07553
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8FA4A10D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2912F1FF4;
	Wed, 16 Jul 2025 12:10:39 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E6221F38
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667839; cv=none; b=h6orgCt7muXXDACrsFLVLELnjzE6JbWtOawNjD6jaf4NblOqHJYzVZK/KZ3bT5pAHQXZtrwwG/JfZob8Uc64W4+WbeniXCmu9JyrsMSL1bf+UXy3svH1htJO7diepvGzuFSCO31dd8Vy9WpbqgL7zmhD9VKxA+YgWEC6p6sDH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667839; c=relaxed/simple;
	bh=7xJ2p5t/r+mzVwMzdepmL+KUNKS4hy7Cg141YqK30H4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HJS7bSERH/dU098WO7+qdTaa1JkYFiKZiJ3V9UE7KCB9SzQP17xmJgYi/PY+mdM0DX1Rp0m1jaXISm8wCwcOxf3jvWTq8PqFNYfYyCLdennNtVL/TAgZtkLNHgTjglm+NbFTXZElh9y/oK8XQI2eFITSykofmcQAPK9AnPF17so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8760733a107so726294939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667836; x=1753272636;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLIPCTSSWAp5+AxmumWh/mlnfhbWUMbgiH67vTJ+dHE=;
        b=sanB0wpAle37Q/E84RQ1ylBxV2N4UXXFdCkw3DhhXtCgnFq/z8EYoNyyQ1QAzip4wT
         K2lYpVDtZjg3rGmXJBDD7+WsRE4OWCs/RP1bbfAxBtNulhfuNtDZk3SUW4NlrmHIvpAo
         w6700hNxxMrmDeaZ48EYjMAHkKildJcPOs79TdlRXcacYQfxKEDM9h64ojaH6kg1d1IP
         mxcXFRaQ6lFVCQjNzNKdkHcJ+qUdbXZueB1Rtbt83CJMEqhA3P6bQhEggGkY73YZDdMs
         FyIaSfv5wIKgvJ+cagJFzVPP5ZaGPxnbdTdsSXKG0iGeYkEgDJWBdpHqVx99A9O2ywY5
         DBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFOu8bPtY0ouE3nYLZUh7fJur0IEw8LkCgvYoAO8cgpkPazQHkofxs+faT1Pb6VuJ+wJd0KQM/EY9OZns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjB9vBSqFRtqO11wYZXyUAUZRDRNIDW/xKhc0FeYOSyLs84Azr
	L553gbLf4SUtl4qvdXqm2UC24Z0bE0yUUXXQoLI7zdOItPnEhipHsM5Eu9g0Z/qkQ+ymLk0Xt/t
	4g1IZS8Hshc4QL7X4OVybLCAD2dAFYtnhYzTZtlbEU6co+IdvFgjRgFiFGE0=
X-Google-Smtp-Source: AGHT+IGMXsjD0s5BOlHu9/8xCZQzVfHRZcrcvEqxPhxgSlfQkFJc1TKqXaDLLfE4PG18hlpIkBoGyCHL9Iq2Jk3SclvxiXB5SsOO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1611:b0:876:b001:2cb0 with SMTP id
 ca18e2360f4ac-879c092815bmr366741739f.11.1752667835880; Wed, 16 Jul 2025
 05:10:35 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:10:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687796bb.a70a0220.693ce.0024.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in parse_insn
From: syzbot <syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    379f604cc3dc Merge tag 'pci-v6.16-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fe6d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=ab8008c24e84adee93ff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-379f604c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fece714f0364/vmlinux-379f604c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b20ac59a633/bzImage-379f604c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 69c04067 P4D 69c04067 PUD 75b59067 PMD 0 
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 16775 Comm: syz.1.2616 Not tainted 6.16.0-rc5-syzkaller-00224-g379f604cc3dc #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003e0fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000065d4 RCX: ffffc9003358f000
RDX: ffff888065e40008 RSI: 00000000000065d4 RDI: ffff888049f6c800
RBP: ffff888065e40004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888049f6c800
R13: ffff888065e40000 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff888097820000(0063) knlGS:00000000f50aeb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000075b5b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 get_valid_routes drivers/comedi/comedi_fops.c:1305 [inline]
 parse_insn+0x789/0x1970 drivers/comedi/comedi_fops.c:1384
 do_insnlist_ioctl+0x2c6/0x6b0 drivers/comedi/comedi_fops.c:1568
 compat_insnlist drivers/comedi/comedi_fops.c:3160 [inline]
 comedi_compat_ioctl+0x7f1/0x910 drivers/comedi/comedi_fops.c:3225
 __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
 __ia32_compat_sys_ioctl+0x242/0x370 fs/ioctl.c:948
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf70be579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f50ae55c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000008008640b
RDX: 00000000801afec0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003e0fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000065d4 RCX: ffffc9003358f000
RDX: ffff888065e40008 RSI: 00000000000065d4 RDI: ffff888049f6c800
RBP: ffff888065e40004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888049f6c800
R13: ffff888065e40000 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff888097820000(0063) knlGS:00000000f50aeb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000075b5b000 CR4: 0000000000352ef0
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

