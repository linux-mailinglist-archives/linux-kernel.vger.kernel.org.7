Return-Path: <linux-kernel+bounces-792652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC4B3C73F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2621C860D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6620B1F5;
	Sat, 30 Aug 2025 02:00:37 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8F29405
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756519237; cv=none; b=HmAAvFwDrmk3EXpYyB3TehopNiRp+jp/udC40DJwWcwm9HRYut3VBZiTIDUbaijyep8PrTntc6mbMKTLhC5cqCMiIpSEeN8AOt7RohOTz5vLzDGeULyOQb21dcqtNeEhdOgeRRGkIUfou4k9tM6KSiLtRjL9gceHmvhxC4ejIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756519237; c=relaxed/simple;
	bh=K7JFO4zuYd8PFAV2iodMh21dyWszhL3dnWjHEX5xr6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZUst/ZbHcSmy7Zf7aXV0ZZqENPop6JpaEKwZxnU0des0qrAAxdgA1vq8RcsPSkBr/DS5WyiVWwdfqmBs0Z4/7dNC3GoJAPOwTJacGAwdPX34nuiby8VTN300L4KIfV9pvqqWlg4hFeX5s4yrfP2hLmU1ZbPmB+/fX+WrBKIP3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e6649d783bso57382505ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756519234; x=1757124034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bgz0V/0mTzIQvTPyM8bc3SFQ3APOXzjLe3hxbe3SS6Q=;
        b=Xe2txBeZ3/fsvwRDUyheSxj0MoiNUrcWSVzsq4qSkizSaCThVAZqzrlf+WNWRzRAiu
         qyMQQeTaFsOfQPqy/xsqcg5OJB600P3ndTuxJS1sBhQt2LErEDHppOjqimfhYHJTE8Ok
         WmuM1xDq6T4JLlWMzB2QZ7n1gXVjicPI8i6jnUPVvfyed6tWiMBJTmkkLtYH6DS9/6mt
         GI/d/R7TuU7pvR7bwBNJf5mFUh7jh6rLhr5OfFlAOBOQWmaznS8SbeF3qashB6baOMba
         RVJbhrTfipn5PN5r0lshw+6m8lLavou5xRcFgtk0QoqJwDWO3B7KWBx6fbXtTKL5ZigJ
         c1dA==
X-Forwarded-Encrypted: i=1; AJvYcCXSeOT5wHQehrpIc74DJh0WQa4nLYgwzLk+Ict8mdpBzU2fqBUOxwTYix8Bi9WVyrk+TvIVocoh5A3Ra1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkp01RFhspfx4IQYzKsAHNCmjq7tQUcxmQTMQ3IytbPS5NUPSI
	qZBsWo11/3qHwHN2I+I7Ykq1NaZE4XLv4QePidOt0uY80OrbeXEwDcdHvxqqNE5CFsKKlM8mUVX
	eNOnKPvqRy5yXmvwhe4+d432LLwzImMiAHuoQVnm5zI5EY/wmuif5Vc9BVCM=
X-Google-Smtp-Source: AGHT+IH4faPDW5Tt1jdztRBgSSO6+h0k8G1D9Gmu5sMdThXji4TuJT9yzPCt2NqC3hz87Z2fPtQU6mwzUV1Jl7wH18W52rOFjoBL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:3f3:42ba:5a9 with SMTP id
 e9e14a558f8ab-3f4027b88cemr13602525ab.31.1756519234686; Fri, 29 Aug 2025
 19:00:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 19:00:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in hrtimer_forward (4)
From: syzbot <syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1130eef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=8b3a2e23253b50098164
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/102656909b6f/disk-b6add54b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa30d1d80a47/vmlinux-b6add54b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c25ee8abf30a/bzImage-b6add54b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1186 at kernel/time/hrtimer.c:1052 hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
Modules linked in:
CPU: 1 UID: 0 PID: 1186 Comm: irq/33-virtio1- Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
Code: 4c 89 33 48 8b 04 24 eb 07 e8 86 34 12 00 31 c0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 d8 4d 09 cc e8 6b 34 12 00 90 <0f> 0b 90 eb df 48 89 e8 4c 09 f8 48 c1 e8 20 74 0a 48 89 e8 31 d2
RSP: 0018:ffffc90000a78bd0 EFLAGS: 00010006
RAX: ffffffff81ac27e5 RBX: ffff8880b883b508 RCX: ffff888026c19dc0
RDX: 0000000000000100 RSI: 0000000000010000 RDI: 0000000000010100
RBP: 000000000009d057 R08: 0000000000010000 R09: 0000000000010100
R10: dffffc0000000000 R11: ffffffff8167a890 R12: ffff8880b883b520
R13: 0000000000184487 R14: 1ffff110171076a4 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95323cbf98 CR3: 0000000064088000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 hrtimer_forward_now include/linux/hrtimer.h:366 [inline]
 dl_server_timer kernel/sched/deadline.c:1193 [inline]
 dl_task_timer+0xa42/0x12d0 kernel/sched/deadline.c:1234
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x503/0xd40 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45d/0xa90 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:100 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
RIP: 0010:unwind_next_frame+0x12dc/0x2390 arch/x86/kernel/unwind_orc.c:494
Code: cf aa 00 48 8b 44 24 18 48 8b 10 48 c7 c7 80 42 08 8b 89 de e8 45 8e b4 ff e9 43 06 00 00 49 89 d5 48 89 d5 48 89 d8 48 29 e8 <48> 89 c1 48 c1 f9 02 48 c1 e8 3f 48 01 c8 48 83 e0 fe 4c 8d 3c 45
RSP: 0018:ffffc90004e26d58 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff8f2cd064 RCX: ffffffff8f2cd064
RDX: ffffffff8f2cd02c RSI: ffffffff8fa15e4e RDI: ffffffff8b620c20
RBP: ffffffff8f2cd064 R08: 0000000000000015 R09: ffffffff8172b165
R10: ffffc90004e26e78 R11: ffffffff81aae030 R12: ffffffff81331f69
R13: ffffffff8f2cd060 R14: ffffc90004e26e28 R15: ffffffff8f2cd060
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_node_noprof+0x14e/0x330 mm/slub.c:4281
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:578
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
 napi_alloc_skb+0x9b/0x440 net/core/skbuff.c:811
 page_to_skb+0x288/0x930 drivers/net/virtio_net.c:889
 receive_mergeable drivers/net/virtio_net.c:2496 [inline]
 receive_buf+0x45f/0x15e0 drivers/net/virtio_net.c:2634
 virtnet_receive_packets drivers/net/virtio_net.c:2992 [inline]
 virtnet_receive drivers/net/virtio_net.c:3016 [inline]
 virtnet_poll+0x1fc6/0x2d80 drivers/net/virtio_net.c:3110
 __napi_poll+0xb6/0x540 net/core/dev.c:7506
 napi_poll net/core/dev.c:7569 [inline]
 net_rx_action+0x707/0xe00 net/core/dev.c:7696
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 __local_bh_enable_ip+0x179/0x270 kernel/softirq.c:259
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 irq_forced_thread_fn+0xe9/0x120 kernel/irq/manage.c:1156
 irq_thread+0x427/0x690 kernel/irq/manage.c:1256
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	cf                   	iret
   1:	aa                   	stos   %al,%es:(%rdi)
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	44 24 18             	rex.R and $0x18,%al
   8:	48 8b 10             	mov    (%rax),%rdx
   b:	48 c7 c7 80 42 08 8b 	mov    $0xffffffff8b084280,%rdi
  12:	89 de                	mov    %ebx,%esi
  14:	e8 45 8e b4 ff       	call   0xffb48e5e
  19:	e9 43 06 00 00       	jmp    0x661
  1e:	49 89 d5             	mov    %rdx,%r13
  21:	48 89 d5             	mov    %rdx,%rbp
  24:	48 89 d8             	mov    %rbx,%rax
  27:	48 29 e8             	sub    %rbp,%rax
* 2a:	48 89 c1             	mov    %rax,%rcx <-- trapping instruction
  2d:	48 c1 f9 02          	sar    $0x2,%rcx
  31:	48 c1 e8 3f          	shr    $0x3f,%rax
  35:	48 01 c8             	add    %rcx,%rax
  38:	48 83 e0 fe          	and    $0xfffffffffffffffe,%rax
  3c:	4c                   	rex.WR
  3d:	8d                   	.byte 0x8d
  3e:	3c 45                	cmp    $0x45,%al


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

