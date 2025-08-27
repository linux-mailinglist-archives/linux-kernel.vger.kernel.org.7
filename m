Return-Path: <linux-kernel+bounces-788525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97434B385CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574BE5E663E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64562727E4;
	Wed, 27 Aug 2025 15:11:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1252185A8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307465; cv=none; b=HC2CNSyX9mLsf9SKJaY7uh1993ZAVPPJKPvgbxaF5/lKc1l05bityU8nNxKYY6BAONCgNK7kyNJXjBo5/CLAIWA8qAPcxvpLP8/jlLU6qoS5Dq+8u7LSpN/eJ8852p1cEXYYjA0IpM1Tktrkm9rIpkSYrKkly2GPQgPnVgk+55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307465; c=relaxed/simple;
	bh=D4TdlXJCnyBmyoe1BGRuMZrUx2zzlLLIK6orGeTQTwI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H0b7pcWGunf7TJ57F1VsB6LQzVbAEOQD3KBmO2H1efR92EF6CakY2pM216MQmGRQCseWqM7fHcAP1bZqeFIs3WsCem3u26P/UnMjIPlVKX/V529Syn9IHzBATWPWbC4T/YlLWWc7ENOmUEatSGvtbwREJ1MwnLVL4I6l/56BMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ee1d164774so12415045ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307463; x=1756912263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yj8i8TIMKcbHgdbb7SW+9Erl7uM6fcJ5LI3tWKtidsw=;
        b=NHQEqink3q390C5614SoBKbPy5gB4BoZcDSV/D/tEDwiBsoUmtD/LfH2pWEG5BUwJn
         tKypctLC/eyQMcYwvOwGEd28jhFZW+Zqtxy+c/7TipY0hf+olEEt0MzshUsGyy8ng/Xa
         /5cqL2+JWO747lSyz/yDyxVFvhZhAFR0umd9KScH6gfHyr5NYrcp30XHBRbn4nbpUwWh
         22/gvDpz+TRXVghUaFchkWCGtXUdJ8ZD0cn7uzu6ZdeMiORyks+DVWT1gaogfDj3FUr2
         nNXTtgKOa/JjmLZKta1ArKg0lDB/mHT6BTqNxsHGM4z8qqNohZGWXT8szCXdHqe9P8mT
         jAKw==
X-Forwarded-Encrypted: i=1; AJvYcCWaOWhI+c9Ip9nQruX2DGPT0qFdr+RO/xJ9J3GC1+A7HTJhRyrj8mu/SDhL/Mr80YDxewAts6wm3CS4UP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJy6S+Mi2I7J9qFE+nFqdD79qZnL/OFn1mmfq9xPEAP4oB91x
	ceOBIqJbUSq7KLj8KniHRQENR1IrHJ2AGG63z6/wqNSMJzJ6zlz5lElcrwh3G3caM1pyAgsKtuT
	Eq+Hzyt5+uFyz2RznaCROrDy3Zfl4nLcs/J7qrBkCcQvxY+qvNZ5tSxyPpaA=
X-Google-Smtp-Source: AGHT+IHZbdmHPb+zWI8d5Tl+udK1WWYgBH7nngTLpilUNJvO32vX5g4ksyIlM13lMDVNAHu7O6ngEoOBvROLj0Iabp9QKva9j/QK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4617:b0:3ea:d47f:5995 with SMTP id
 e9e14a558f8ab-3ef08764393mr82012185ab.11.1756307462935; Wed, 27 Aug 2025
 08:11:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:11:02 -0700
In-Reply-To: <nqdjhsx4cy3x64g3q6w6ffczvcwhh7aavelmrvqjtinqetusa4@4xdhtbpkhlse>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af2006.a70a0220.3cafd4.0027.GAE@google.com>
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
CPU: 1 UID: 0 PID: 6475 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:bcsp_recv+0x13d/0x1740 drivers/bluetooth/hci_bcsp.c:590
Code: 89 4c 24 40 48 89 54 24 28 48 c1 ea 03 48 89 54 24 68 48 89 5c 24 20 48 c1 eb 03 48 89 5c 24 60 4c 89 7c 24 38 48 8b 44 24 58 <42> 80 3c 30 00 74 08 4c 89 ff e8 44 b1 be f9 49 8b 1f 31 ff 48 89
RSP: 0018:ffffc90002fb7c00 EFLAGS: 00010206
RAX: 0000000000000021 RBX: 0000000000000030 RCX: 000000000000002f
RDX: 000000000000002f RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002fb7d60 R08: ffff888062a12c1f R09: 1ffff1100c542583
R10: dffffc0000000000 R11: ffffffff88623580 R12: 0000000000000001
R13: ffffc90002fb7e00 R14: dffffc0000000000 R15: 0000000000000108
FS:  00007f4f2f09f6c0(0000) GS:ffff888125d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f2f09ef98 CR3: 0000000031000000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hci_uart_tty_receive+0x194/0x220 drivers/bluetooth/hci_ldisc.c:627
 tiocsti+0x239/0x2c0 drivers/tty/tty_io.c:2290
 tty_ioctl+0x626/0xde0 drivers/tty/tty_io.c:2706
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f2e18e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f2f09f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4f2e3b6080 RCX: 00007f4f2e18e9a9
RDX: 0000200000000140 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007f4f2e210d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4f2e3b6080 R15: 00007ffc2eba6848
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bcsp_recv+0x13d/0x1740 drivers/bluetooth/hci_bcsp.c:590
Code: 89 4c 24 40 48 89 54 24 28 48 c1 ea 03 48 89 54 24 68 48 89 5c 24 20 48 c1 eb 03 48 89 5c 24 60 4c 89 7c 24 38 48 8b 44 24 58 <42> 80 3c 30 00 74 08 4c 89 ff e8 44 b1 be f9 49 8b 1f 31 ff 48 89
RSP: 0018:ffffc90002fb7c00 EFLAGS: 00010206
RAX: 0000000000000021 RBX: 0000000000000030 RCX: 000000000000002f
RDX: 000000000000002f RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002fb7d60 R08: ffff888062a12c1f R09: 1ffff1100c542583
R10: dffffc0000000000 R11: ffffffff88623580 R12: 0000000000000001
R13: ffffc90002fb7e00 R14: dffffc0000000000 R15: 0000000000000108
FS:  00007f4f2f09f6c0(0000) GS:ffff888125d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f2f09ef98 CR3: 0000000031000000 CR4: 00000000003526f0
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
  34:	e8 44 b1 be f9       	call   0xf9beb17d
  39:	49 8b 1f             	mov    (%r15),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


Tested on:

commit:         fab1beda Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17af4fbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16cf058b8ba89168
dashboard link: https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bc6462580000


