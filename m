Return-Path: <linux-kernel+bounces-724207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E9AFF002
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6541C82AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3C23498E;
	Wed,  9 Jul 2025 17:38:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511822D9E6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082714; cv=none; b=CxxEUwhdoH+cF5yH5CGhC0tzxR+3B9rDfpvk1mYFd80izEktmMzQM65QXWJjaJQqxVZTnuNUOojJq+6sru307odTnA/QUXAnv5xuoD5pchneqfcF1EIThi4InrGscc383RI0Q3347iVXIvlmtSrg+kvHTGCeAFxjlkl1r53HQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082714; c=relaxed/simple;
	bh=z9Du3ejSkQ3VkpwRgjKGeib/z5NboU/rZsBL5h6qRn4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oySwZpcdXwmYbBHUe/cKeEsU+MO/izgoAgnHrubWV9cze63OW8H/bbOmbmtHsIQfoqOBBtCGouYvX4Nn6Sa5AVsRFCwnLLk58ZfOyNnV5aCH1XBbLsVvbkZis1agHGhdQKH8vyIRnI6h2HmMGPAzMiOoMWzETicFfppfz0corhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddc5137992so1033245ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 10:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082711; x=1752687511;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2kGQvdLAIiltx0MedZ86hxi4iC1DeIZjyAtIJG8XFk=;
        b=M9LZ7r+kYCGYJZBkigPlRTdYTwE4870bpB80rKwJb019hB7rTiqXBYq+zIM+wjspty
         XbbBTyyzInMJ3PeqR9CEDoN+0efIqxF4phN9pNgt9xvk6XhX1jPt05JHncmjuao+tGQd
         aThnkUBGNiNk59dX8RvsjWrYfFcOAvZT3VqGiqjpfKDFlqrfo/rPNpRT+vsCVusWyLMB
         8JSYRDtMRAnJBoM9EXY3+SjrKXeNpqLdmlfO4uBDSsComewJoAae0CvFS3HNFwPWEPW4
         HfojDnGz0F/w0v/BIiIVuKK4/XZJlDkTcDTLuKjET/VVBYOjyNnOz82QkRyK//qlCgEw
         Xngw==
X-Forwarded-Encrypted: i=1; AJvYcCWS3wUE9d5ufJZV0m0o1wBw/2UicpTj3gTXBxQ82QExfNsnUP0UDjthWN0KDUy+FQ06oBjMTqowowvvDCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhB/L7/4yEY8e+bw4cFyKn29Qe1Z0EEELAZPcqylhvwNfAzFxP
	47KzvtXP9SI67zqe6ePkpEUih/Y9pARvqZh9Ueom6ZSO3bHfqE22qqr/zPtxWZ4jhyfLYaOxbsf
	00mn0QnlhViDOH2KmcSWBf7i/hw4A2rF3khiL90ftwIJWcsWgZWckIIL8RHA=
X-Google-Smtp-Source: AGHT+IGaBpu568PGYJ6q9DJV3KBNjneYr4VgALWUhlv46bjR5VhFnxnR89D+kuJiXYYn/APUvhcZLw91OXpove294DFMYM/0MqZK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3df:3222:278e with SMTP id
 e9e14a558f8ab-3e166ffbc65mr33490925ab.1.1752082711252; Wed, 09 Jul 2025
 10:38:31 -0700 (PDT)
Date: Wed, 09 Jul 2025 10:38:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ea917.050a0220.385921.0014.GAE@google.com>
Subject: [syzbot] [kernel?] divide error in comedi_buf_write_free
From: syzbot <syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58ba80c47402 Add linux-next specific files for 20250708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15e9ea8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e0d64c5a66f7ca
dashboard link: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27011e78b607/disk-58ba80c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3b2e0bf7f86/vmlinux-58ba80c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/512dbc2f3800/bzImage-58ba80c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc5-next-20250708-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:comedi_buf_munge drivers/comedi/comedi_buf.c:347 [inline]
RIP: 0010:comedi_buf_write_free+0x3c8/0x7e0 drivers/comedi/comedi_buf.c:391
Code: 41 03 45 00 48 8b 4c 24 78 42 0f b6 0c 21 84 c9 4c 8b bc 24 90 00 00 00 44 8b 74 24 54 0f 85 02 01 00 00 31 d2 48 8b 4c 24 30 <f7> 31 41 89 55 00 48 8b 44 24 70 42 0f b6 04 20 84 c0 0f 85 09 01
RSP: 0018:ffffc90000007bd8 EFLAGS: 00010046
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: ffff888030a20880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88806b192000
RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000000ff
R10: dffffc0000000000 R11: ffffffff88e91b20 R12: dffffc0000000000
R13: ffff888030a20838 R14: 0000000000000000 R15: ffff888030a20800
FS:  0000000000000000(0000) GS:ffff888125bd7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faab2ff5f98 CR3: 0000000033708000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 comedi_buf_write_samples+0x369/0x5a0 drivers/comedi/comedi_buf.c:602
 das16m1_handler+0x213/0x4b0 drivers/comedi/drivers/das16m1.c:413
 das16m1_interrupt+0xaf/0x180 drivers/comedi/drivers/das16m1.c:470
 __handle_irq_event_percpu+0x289/0x980 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x267/0x9c0 kernel/irq/chip.c:797
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:254 [inline]
 call_irq_handler arch/x86/kernel/irq.c:266 [inline]
 __common_interrupt+0x140/0x250 arch/x86/kernel/irq.c:292
 common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:285
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d c3 ec 0f 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8de07d80 EFLAGS: 000002c6
RAX: 709f8e7c1b77cc00 RBX: ffffffff8196cd28 RCX: 709f8e7c1b77cc00
RDX: 0000000000000001 RSI: ffffffff8d9aefc8 RDI: ffffffff8be33740
RBP: ffffffff8de07ea8 R08: ffff8880b8632f5b R09: 1ffff110170c65eb
R10: dffffc0000000000 R11: ffffed10170c65ec R12: ffffffff8fa35430
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1bd2a50
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 rest_init+0x2de/0x300 init/main.c:744
 start_kernel+0x47d/0x500 init/main.c:1097
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x147
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:comedi_buf_munge drivers/comedi/comedi_buf.c:347 [inline]
RIP: 0010:comedi_buf_write_free+0x3c8/0x7e0 drivers/comedi/comedi_buf.c:391
Code: 41 03 45 00 48 8b 4c 24 78 42 0f b6 0c 21 84 c9 4c 8b bc 24 90 00 00 00 44 8b 74 24 54 0f 85 02 01 00 00 31 d2 48 8b 4c 24 30 <f7> 31 41 89 55 00 48 8b 44 24 70 42 0f b6 04 20 84 c0 0f 85 09 01
RSP: 0018:ffffc90000007bd8 EFLAGS: 00010046
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: ffff888030a20880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88806b192000
RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000000ff
R10: dffffc0000000000 R11: ffffffff88e91b20 R12: dffffc0000000000
R13: ffff888030a20838 R14: 0000000000000000 R15: ffff888030a20800
FS:  0000000000000000(0000) GS:ffff888125bd7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faab2ff5f98 CR3: 0000000033708000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	41 03 45 00          	add    0x0(%r13),%eax
   4:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
   9:	42 0f b6 0c 21       	movzbl (%rcx,%r12,1),%ecx
   e:	84 c9                	test   %cl,%cl
  10:	4c 8b bc 24 90 00 00 	mov    0x90(%rsp),%r15
  17:	00
  18:	44 8b 74 24 54       	mov    0x54(%rsp),%r14d
  1d:	0f 85 02 01 00 00    	jne    0x125
  23:	31 d2                	xor    %edx,%edx
  25:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
* 2a:	f7 31                	divl   (%rcx) <-- trapping instruction
  2c:	41 89 55 00          	mov    %edx,0x0(%r13)
  30:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  35:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
  3a:	84 c0                	test   %al,%al
  3c:	0f                   	.byte 0xf
  3d:	85 09                	test   %ecx,(%rcx)
  3f:	01                   	.byte 0x1


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

