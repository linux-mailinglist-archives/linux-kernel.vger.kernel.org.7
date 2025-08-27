Return-Path: <linux-kernel+bounces-788594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FDB386F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8084620C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019512DAFB5;
	Wed, 27 Aug 2025 15:49:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D258A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309747; cv=none; b=K2NowlY4wmT1IBOqhtoKjBcnbm1tBICmDfb14GWjsGBMOZwAZMIuyu8VquMmKrdAUhxwWYjNSv7vH1a6Qj2UOFb/jAVGsxQuZDFa56OYuCQoRr552gXWduUWXhJV3H67PI6137atj3KkiNRvkT2At/a1N5X/j+eF3Rl1i7iHIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309747; c=relaxed/simple;
	bh=BUsvEsqM/mvtkCtDC+B3p3ERl9KYSuF4qJ/lgRh6SN0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ccNxdItvxxOsgvMklLD023cmny92Rz0bBssN1QSombModpPDxM9LsVNzaMgkJqZFueEaUaDrjXrwDhti9ZtHvVT8mu1f1P8e3rCxS1z2k6AiqC6V7bEeqTDiu46zhzR1dv+DXhLMVrR8CBsMLWFFMxVnP+J4XyC9LvRzDFPDnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6766c3935so84857025ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309744; x=1756914544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlPsLYuBRWsrukpJQDCmiSl9Y7Y4vN5t05LBG6ZWueA=;
        b=pgqUBv1vmhtmQkyGOnUk06IjyNTvmGeYfw/MgQrvWQyAIdW/FOck7evx24Bkaa117M
         VAmblDM69zNQEaU+Kwyzm9B24HLoJHmTeKlDsLZWF21f137bpv4QEvn8ZwB6GzLRMCBw
         9ZWREEsANVZ2XN7kJl9kM4D9JP/Bv11EBsg2OlKRNCmtKvt+LPat483ffaaBHjyTRGOU
         H094mfOWZ0mif4toI7Pjz9BCtGdoAD0fH8bE0/OhpIJEtiz6sWyl053tUAYEZYg7kqgj
         gqzzMLXatLfIWHalxHH3mIIhTuPCiaro2UAOXJxVohKGjAVAGy7iqtb2AapDWDkl0iN1
         auZw==
X-Forwarded-Encrypted: i=1; AJvYcCVpPp0dh+YPIVdWEmP+A6Qsyn8zWjaWHSJHPZ3o0D8ge5roYTxYstMF/5cRHAENVMN5Aiju+nrAXme6mFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9FDoRgwRw0MGCQT0+xK8Un0B3CxgHUHxWr1gz5zqZzek4whC
	fydbgs4aO5pnRy83+6d2Fdq7SO6TRd0SBEvQQfvUs2lQQpjRBjtq4qKWQR17hec74wxn4wuxiNV
	JWT1UoNw1sf0TcpcBoF04sP6ziTm36KRwHPH5czqRfo8nBC59ZgRFKA5bKME=
X-Google-Smtp-Source: AGHT+IF4aiPf494Oythz+DQZLP1JWz0PkTOKq5FVRv9cJ3BclR5Vf5/37aGaJp/6MvzhDicaK2dNb1LoW5io0BIWMgeIsHcnAPY6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc6:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e91f93e0dbmr263282515ab.4.1756309744135; Wed, 27 Aug 2025
 08:49:04 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:49:04 -0700
In-Reply-To: <cdfnb7ox7u3qogpyvxgti4ljpsa7ohvh2ilzy2tqygzsvxmh3a@cglm7naoohg5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af28f0.a70a0220.3cafd4.002a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
From: syzbot <syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in bcsp_recv

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 0 UID: 0 PID: 6616 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:bcsp_recv+0x13d/0x1740 drivers/bluetooth/hci_bcsp.c:590
Code: 89 4c 24 40 48 89 54 24 28 48 c1 ea 03 48 89 54 24 68 48 89 5c 24 20 48 c1 eb 03 48 89 5c 24 60 4c 89 7c 24 38 48 8b 44 24 58 <42> 80 3c 30 00 74 08 4c 89 ff e8 d4 21 c9 f9 49 8b 1f 31 ff 48 89
RSP: 0018:ffffc90002f77c00 EFLAGS: 00010206
RAX: 0000000000000021 RBX: 0000000000000030 RCX: 000000000000002f
RDX: 000000000000002f RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002f77d60 R08: ffff8880771ab81f R09: 1ffff1100ee35703
R10: dffffc0000000000 R11: ffffffff8856eb10 R12: 0000000000000001
R13: ffffc90002f77e00 R14: dffffc0000000000 R15: 0000000000000108
FS:  00007ff06020b6c0(0000) GS:ffff888125c47000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff06020af98 CR3: 0000000031284000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hci_uart_tty_receive+0x191/0x220 drivers/bluetooth/hci_ldisc.c:627
 tiocsti+0x239/0x2c0 drivers/tty/tty_io.c:2290
 tty_ioctl+0x626/0xde0 drivers/tty/tty_io.c:2706
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff05f38e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff06020b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff05f5b6080 RCX: 00007ff05f38e9a9
RDX: 0000200000000140 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007ff05f410d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff05f5b6080 R15: 00007ffd9bba04b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bcsp_recv+0x13d/0x1740 drivers/bluetooth/hci_bcsp.c:590
Code: 89 4c 24 40 48 89 54 24 28 48 c1 ea 03 48 89 54 24 68 48 89 5c 24 20 48 c1 eb 03 48 89 5c 24 60 4c 89 7c 24 38 48 8b 44 24 58 <42> 80 3c 30 00 74 08 4c 89 ff e8 d4 21 c9 f9 49 8b 1f 31 ff 48 89
RSP: 0018:ffffc90002f77c00 EFLAGS: 00010206
RAX: 0000000000000021 RBX: 0000000000000030 RCX: 000000000000002f
RDX: 000000000000002f RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002f77d60 R08: ffff8880771ab81f R09: 1ffff1100ee35703
R10: dffffc0000000000 R11: ffffffff8856eb10 R12: 0000000000000001
R13: ffffc90002f77e00 R14: dffffc0000000000 R15: 0000000000000108
FS:  00007ff06020b6c0(0000) GS:ffff888125c47000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff06020af98 CR3: 0000000031284000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	89 4c 24 40          	mov    %ecx,0x40(%rsp)
   4:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   9:	48 c1 ea 03          	shr    $0x3,%rdx
   d:	48 89 54 24 68       	mov    %rdx,0x68(%rsp)
  12:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
  17:	48 c1 eb 03          	shr    $0x3,%rbx
  1b:	48 89 5c 24 60       	mov    %rbx,0x60(%rsp)
  20:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
  25:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 d4 21 c9 f9       	call   0xf9c9220d
  39:	49 8b 1f             	mov    (%r15),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


Tested on:

commit:         c49a788e Bluetooth: hci_sync: fix set_local_name race ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12e35ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e320672d7f4a2ce9
dashboard link: https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15026462580000


