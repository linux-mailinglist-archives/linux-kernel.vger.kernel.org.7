Return-Path: <linux-kernel+bounces-894044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A8C4924D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8653A3B1573
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716A2F8BC3;
	Mon, 10 Nov 2025 19:50:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592A33EB11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804206; cv=none; b=jm9GTvX8TE/ZEcfwEe5D9Kwq4gwyGWo+Yi8gHPFHYMyuWeTJu+MDeksgeoGJRTSa8rVuNk4zmArb9d8wzf9T0LahNf9HXYM7Qo0Hna2dkzrbLiKX/5ri9rqxAgk92Uz2zIBJM3Awhv9wyGUElnYVbhH0WjtpqRVgZyPfiIxX/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804206; c=relaxed/simple;
	bh=5IlsPo4aBZhANYnAyXRYIxHlwBGOWittWYk9FO3WvX8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g1ernximgPyegXJ32J+rywSo2thAVdhtwPdG8Y/jxdozpAVhw7buGPVoovqd4tP0MITuI0WhHFjYi1/kzwtzGYbQw4Exs3Tn9zkfng9sAMhMvgPCVO/CZKeUrlctlhBgJC3gwxwdGA/tAB9kZ7VriJn++B58wPgSfOrgYIgMoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940f5d522efso535835939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804203; x=1763409003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcxfPvsMovfeQ1w6lcdfDLA3zWeAWGbnMrdQvh54RTg=;
        b=KYtfVNWG6NJsO3OVMvp6v3aW71ZVQFg0y+HbKnC4y13mcm3lNhzMpqKXcYMMi+6TEW
         OIcwvePlfSQi9SeHuP/ZOrzbNKojx0P1RAkLsz3dRBl9f/4R1jQnu9vAioUuQ9WiuAcC
         DdiSqCUOxm19CmZe040lvdeCrdRlKt43wWxoBlOyqLyq7v5aZtu1d/3Nzrsn/3UUplYQ
         VXeT8vCXi4A+69AmUXXroxzcqQr6J6v/rwyhtFvsnBy2arAUyoOVCpSNS8CAY6TUU38j
         GVe2CbPilez1GO3E4sgiHPsfLMSWzke/eR9dCBicsmtcvFOsV9cjnJkQE5UtCIo11yXR
         Yu2Q==
X-Gm-Message-State: AOJu0Yy63m0lccRColys+yZ3zwL0MTaRWN0V/tw9Rox/YRK7CDKxpfXh
	IpXYzo0zanmqg2O6a4IHed+ad9U2xhuX/K5dc6iXxFKbWsDvSSvAwDK05pmMriKgEkyyHf5H/AG
	OeImf34vO/jYJr//ODI4sND4V/7CkSrpiwNFF3X5eWZ2K9j+Et9VnFeT1upQ=
X-Google-Smtp-Source: AGHT+IFTRx5cxBam7FZF9Mh7otaC9fTYhfCVIJXre6nB0jNBPF3Y/gQMph6MofeIjfi7bIBfVaj1Uwz+/vPwLsEVSi/Dn9OQbYS+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3085:b0:433:7a7c:e2a2 with SMTP id
 e9e14a558f8ab-4337a7d090fmr86762975ab.7.1762804203668; Mon, 10 Nov 2025
 11:50:03 -0800 (PST)
Date: Mon, 10 Nov 2025 11:50:03 -0800
In-Reply-To: <6fyxpa6cocnr4hbpmzrwel4t2huouz5p4ul6qawttjzlgmuysn@hcleklvgi464>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691241eb.a70a0220.22f260.0107.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
invalid opcode in error_return

Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6994 Comm: syz.1.247 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:error_return+0xa/0x20 arch/x86/entry/entry_64.S:1091
Code: cc cc cc cc cc cc cc cc cc cc cc cc 48 8d 7c 24 08 e8 5a 4c 46 0a 48 89 c7 e9 12 4c 46 0a 90 90 50 9c 58 a9 00 02 00 00 74 02 <0f> 0b 58 f6 84 24 88 00 00 00 03 0f 84 31 fc ff ff e9 60 fb ff ff
RSP: 0018:ffffc90000007a78 EFLAGS: 00010206
RAX: 0000000000000286 RBX: 1ffff1100f9266d4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90000007a70
RBP: ffffffff8b46984e R08: ffffc90000007a6f R09: 0000000000000000
R10: ffffc90000007a68 R11: fffff52000000f4e R12: ffffc9000c2c3048
R13: ffffc90000007b00 R14: ffff88807c9336a0 R15: ffffc9000c2c3060
FS:  00007f9d4ee566c0(0000) GS:ffff88812613b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000000 CR3: 00000000726c6000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
RIP: 3100:rcu_lock_release include/linux/rcupdate.h:341 [inline]
RIP: 3100:rcu_do_batch kernel/rcu/tree.c:2607 [inline]
RIP: 3100:rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 59 1d 7e 00 48 c7 43 08 00 00 00 00 48 89 df 4d 89 e3 2e e8 4d 4e 58 1e <48> c7 c7 40 d7 f3 8d 4c 89 ee e8 b6 77 f5 ff 65 8b 05 7f 61 c6 10
RSP: f400:0000000000000000 EFLAGS: 404bee7c878af400
==================================================================
BUG: KASAN: stack-out-of-bounds in __show_regs+0x4e/0x620 arch/x86/kernel/process_64.c:79
Read of size 8 at addr ffffc90000007af8 by task syz.1.247/6994

CPU: 0 UID: 0 PID: 6994 Comm: syz.1.247 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __show_regs+0x4e/0x620 arch/x86/kernel/process_64.c:79
 show_regs_if_on_stack arch/x86/kernel/dumpstack.c:165 [inline]
 show_trace_log_lvl+0x31d/0x550 arch/x86/kernel/dumpstack.c:237
 show_regs arch/x86/kernel/dumpstack.c:470 [inline]
 __die_body+0xa6/0xb0 arch/x86/kernel/dumpstack.c:412
 die+0x2a/0x50 arch/x86/kernel/dumpstack.c:439
 do_trap_no_signal arch/x86/kernel/traps.c:206 [inline]
 do_trap+0x14a/0x3d0 arch/x86/kernel/traps.c:247
 do_error_trap+0x1c1/0x280 arch/x86/kernel/traps.c:267
 handle_invalid_op+0x34/0x40 arch/x86/kernel/traps.c:304
 exc_invalid_op+0x39/0x50 arch/x86/kernel/traps.c:397
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:616
RIP: 0010:error_return+0xa/0x20 arch/x86/entry/entry_64.S:1091
Code: cc cc cc cc cc cc cc cc cc cc cc cc 48 8d 7c 24 08 e8 5a 4c 46 0a 48 89 c7 e9 12 4c 46 0a 90 90 50 9c 58 a9 00 02 00 00 74 02 <0f> 0b 58 f6 84 24 88 00 00 00 03 0f 84 31 fc ff ff e9 60 fb ff ff
RSP: 0018:ffffc90000007a78 EFLAGS: 00010206
RAX: 0000000000000286 RBX: 1ffff1100f9266d4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90000007a70
RBP: ffffffff8b46984e R08: ffffc90000007a6f R09: 0000000000000000
R10: ffffc90000007a68 R11: fffff52000000f4e R12: ffffc9000c2c3048
R13: ffffc90000007b00 R14: ffff88807c9336a0 R15: ffffc9000c2c3060
RIP: 3100:rcu_lock_release include/linux/rcupdate.h:341 [inline]
RIP: 3100:rcu_do_batch kernel/rcu/tree.c:2607 [inline]
RIP: 3100:rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 59 1d 7e 00 48 c7 43 08 00 00 00 00 48 89 df 4d 89 e3 2e e8 4d 4e 58 1e <48> c7 c7 40 d7 f3 8d 4c 89 ee e8 b6 77 f5 ff 65 8b 05 7f 61 c6 10
RSP: f400:0000000000000000 EFLAGS: 404bee7c878af400 ORIG_RAX: 0000000000000000
RAX: ffffffff81cbf590 RBX: ffffc9000c2c3040 RCX: 0000000000000000
RDX: 0000008000000008 RSI: 0000000000000000 RDI: ffffffff8df3d740
RBP: 0000000000000000 R08: ffffffff8d74996d R09: 0000000041b58ab3
R10: 1ffff92000000f58 R11: 1ffff92001858608 R12: ffffffff81cbf716
R13: ffff88807c932970 R14: ffff88807c9309f3 R15: ffffffff81ed3477
 </IRQ>
 <TASK>
 </TASK>

The buggy address belongs to a 0-page vmalloc region starting at 0xffffc90000000000 allocated at map_irq_stack arch/x86/kernel/irq_64.c:49 [inline]
The buggy address belongs to a 0-page vmalloc region starting at 0xffffc90000000000 allocated at irq_init_percpu_irqstack+0x342/0x4a0 arch/x86/kernel/irq_64.c:76
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb8808
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea0002e20208 ffffea0002e20208 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffc90000007980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90000007a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90000007a80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f2 f2
                                                                ^
 ffffc90000007b00: 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90000007b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess), 6 bytes skipped:
   0:	df 41 80             	filds  -0x80(%rcx)
   3:	3c 06                	cmp    $0x6,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 ff                	mov    %edi,%edi
   b:	e8 59 1d 7e 00       	call   0x7e1d69
  10:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  17:	00
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	4d 89 e3             	mov    %r12,%r11
  1e:	2e e8 4d 4e 58 1e    	cs call 0x1e584e71
* 24:	48 c7 c7 40 d7 f3 8d 	mov    $0xffffffff8df3d740,%rdi <-- trapping instruction
  2b:	4c 89 ee             	mov    %r13,%rsi
  2e:	e8 b6 77 f5 ff       	call   0xfff577e9
  33:	65 8b 05 7f 61 c6 10 	mov    %gs:0x10c6617f(%rip),%eax        # 0x10c661b9


Tested on:

commit:         f8c67d85 bpf: Use kmalloc_nolock() in range tree
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ee6412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13eaa60a580000


