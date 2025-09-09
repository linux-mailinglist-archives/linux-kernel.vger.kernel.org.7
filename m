Return-Path: <linux-kernel+bounces-808868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0DB505A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DD14E8109
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006342E2F1A;
	Tue,  9 Sep 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeNyAp52";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7YpAC0k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E3279DAA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444178; cv=none; b=Gq2+j7+NSl+sh9pCaleVkwSGDTj2iIheA4MsIr44opY6xkXyfITsEz4fuLYOUxV9P9/dkyxLdaPm9+fuJku0JlnA6cz1FoHdHEeWoJBOlO34NTgKAXxB991crFJNntg4ofqaQ4Xst58bi1DkMvFl4lodfDVmbcW2ltJxfeK55Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444178; c=relaxed/simple;
	bh=YBOspn80gYu2Ny7c8YCSvC6+X86jWPP+JoPuTjScNtk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Mf+IXKCM6q6I/AuPGQre2za4A+z+ELAoPpQvdXPn/3HVZX+pD7+CjW/9VksXs/yFVehBB1KfrCa0Bl0bJwD3V9PZ6/p+HLZhbLMFmFmmIIaZmtSW8N2GnUq5AmedHHi7cBz02OE2U2gZnTQpPp/6TnL6upRPnuj3iyh/9w2ouvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EeNyAp52; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7YpAC0k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757444172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Nx1gCbcj7lbw9Vzy12X8YyMZZTze1zyskZjJdCKqgKo=;
	b=EeNyAp52yDpdJOJ44QfOOjf35W6mhRJTFDXMdg2GAp4iRy5X/UfAylHzQGRGwoWHV4+bWJ
	mASDMSW5sujAKfBMIwpfhSgfql+DFUj/tzg7BPQbH+tg6uIljY3nv8Jw5U/e87Z7v+0iR/
	Xoxijo7ieFxAtQCGOdREFrNeWIQURv1VCL/9NhiOz8raHSqsts37afdra0kDSuRWoHaCNT
	nbGTBBsrHvWAuSUj0GuQPRJLuQMYboQTHiGIskwy5/T5lo/D50wMUCkHoYkpAMmHuR+HC6
	Mr5mNNihjz3Ilej5AkzsbRVsKjozBvowVaOjUfZPBsMp4xHqvFqDqF+y7Rnjhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757444172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Nx1gCbcj7lbw9Vzy12X8YyMZZTze1zyskZjJdCKqgKo=;
	b=L7YpAC0kBIrep3uy7E63ut12+8D7D8I9op4I09+lG8/XpvXySSB0xFNiOoNmABEvLGTVO/
	ffGcDK1OXnRIPCBg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jens Axboe
 <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>, syzbot
 <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
 andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
In-Reply-To: <20250904162820.NS1U-oZp@linutronix.de>
Date: Tue, 09 Sep 2025 20:56:11 +0200
Message-ID: <878qinv4j8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025 at 18:28, Sebastian Andrzej Siewior wrote:
> On 2025-09-03 12:51:09 [-0600], Jens Axboe wrote:
>> > The syz-reproducer lists only:
>> > | timer_create(0x0, &(0x7f0000000080)={0x0, 0x11, 0x0, @thr={0x0, 0x0}}, &(0x7f0000000000))
>> > | timer_settime(0x0, 0x0, &(0x7f0000000240)={{0x0, 0x8}, {0x0, 0x9}}, 0x0)
>> > | futex(&(0x7f000000cffc), 0x80000000000b, 0x0, 0x0, &(0x7f0000048000), 0x0)
>> > | futex(&(0x7f000000cffc), 0xc, 0x1, 0x0, &(0x7f0000048000), 0x0)
>> > 
>> > and that is probably why it can't come up with C-reproducer.
>> > The whole log has (filtered) the following lines:
>> > 
>> > | io_uring_setup(0x85a, &(0x7f0000000180)={0x0, 0x58b9, 0x1, 0x2, 0x383})
>> > | syz_io_uring_setup(0x88f, &(0x7f0000000300)={0x0, 0xaedf, 0x0, 0x0, 0x25d}, &(0x7f0000000140)=<r0=>0x0, &(0x7f0000000280)=<r1=>0x0)
>> > | syz_memcpy_off$IO_URING_METADATA_GENERIC(r0, 0x4, &(0x7f0000000080)=0xfffffffc, 0x0, 0x4)
>> > | syz_io_uring_submit(r0, r1, &(0x7f00000001c0)=@IORING_OP_RECVMSG={0xa, 0x8, 0x1, r2, 0x0, &(0x7f0000000440)={0x0, 0x0, 0x0}, 0x0, 0x40000020, 0x1, {0x2}})
>> > 
>> > This should explain the how the waiter got NULL. There is no private
>> > flag so that is how they interact with each other.

I'm not really seeing how they overlap though and it actually reproduces
occasionally without any of the other syz programs which are showing up
in that bisect log.

The problem is that it's hard to reproduce here. I've only seen it three
times within several hours.

So I thought I try and run qemu without -enable-kvm to change the timing,
but that does not even boot at all. It reliably dies at random places
during boot, but always with an 'Oops: int3:':

[   64.184144][    C1] Oops: int3: 0000 [#1] SMP KASAN NOPTI
[   64.185081][    C1] CPU: 1 UID: 0 PID: 994 Comm: kworker/u10:3 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
[   64.185369][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   64.185681][    C1] Workqueue: events_unbound call_usermodehelper_exec_work
[   64.187063][    C1] RIP: 0010:kmem_cache_alloc_node_noprof+0x90/0x330
[   64.187445][    C1] Code: ff 2e 2e 2e 31 c0 4c 89 f7 44 89 ee e8 39 3c 0b 00 45 31 ed 4d 85 f6 0f 84 02 01 00 00 85 c0 0f 85 fa 00 00 00 89 5c 24 04 0f <1f> 44 00 00 48 c7 44 24 10 00 00 00 00 65 48 8b 05 73 fd e2 0f 49
[   64.187574][    C1] RSP: 0018:ffffc900056ff538 EFLAGS: 00000246
[   64.187743][    C1] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: cc07f7dd94535100
[   64.187866][    C1] RDX: ffff888046a63900 RSI: 0000000000000cc0 RDI: ffff888040414500
[   64.187968][    C1] RBP: 0000000000000cc0 R08: 0000000000000000 R09: ffffffff82107f5d
[   64.188066][    C1] R10: dffffc0000000000 R11: ffffed1008d4c721 R12: 0000000000000000
[   64.188165][    C1] R13: 0000000000000000 R14: ffff888040414500 R15: ffffffff8182bd72
[   64.188303][    C1] FS:  0000000000000000(0000) GS:ffff8880ecec2000(0000) knlGS:0000000000000000
[   64.188414][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.188501][    C1] CR2: 0000000000000000 CR3: 000000000d7a6000 CR4: 00000000000006f0
[   64.188711][    C1] Call Trace:
[   64.188929][    C1]  <TASK>
[   64.189286][    C1]  dup_task_struct+0x52/0x860
[   64.189569][    C1]  copy_process+0x545/0x3ae0
[   64.190275][    C1]  kernel_clone+0x224/0x7c0
[   64.190691][    C1]  user_mode_thread+0xdd/0x140
[   64.191352][    C1]  call_usermodehelper_exec_work+0x5c/0x230
[   64.191873][    C1]  worker_thread+0x8a0/0xda0

[   36.676800][    C1] Oops: int3: 0000 [#1] SMP KASAN NOPTI
[   36.677774][    C1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
[   36.678176][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   36.678477][    C1] RIP: 0010:kmem_cache_alloc_noprof+0x83/0x310
[   36.679809][    C1] Code: 00 e8 81 75 7e ff 2e 2e 2e 31 c0 4c 89 f7 89 ee e8 92 47 0b 00 45 31 ed 4d 85 f6 0f 84 fe 00 00 00 85 c0 0f 85 f6 00 00 00 0f <1f> 44 00 00 48 c7 44 24 08 00 00 00 00 65 48 8b 05 d0 08 e3 0f 49
[   36.680000][    C1] RSP: 0018:ffffc9000012f190 EFLAGS: 00000246
[   36.680185][    C1] RAX: 0000000000000000 RBX: 0000000000000dc0 RCX: 3fbc2ecf0c9c3500
[   36.680309][    C1] RDX: ffff88801b698000 RSI: 0000000000000dc0 RDI: ffff888040ad2000
[   36.680411][    C1] RBP: 0000000000000dc0 R08: 0000000000000000 R09: ffffffff82107f5d
[   36.680511][    C1] R10: dffffc0000000000 R11: ffffed1008d3f94c R12: 1ffff92000025e48
[   36.680611][    C1] R13: 0000000000000000 R14: ffff888040ad2000 R15: ffffffff8252e407
[   36.680749][    C1] FS:  0000000000000000(0000) GS:ffff8880ecec2000(0000) knlGS:0000000000000000
[   36.680862][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.680948][    C1] CR2: 0000000000000000 CR3: 000000000d7a6000 CR4: 00000000000006f0
[   36.681175][    C1] Call Trace:
[   36.681398][    C1]  <TASK>
[   36.681784][    C1]  __kernfs_new_node+0xd7/0x690
[   36.681877][    C1]  kernfs_new_node+0x102/0x210
[   36.681877][    C1]  kernfs_create_dir_ns+0x44/0x130
[   36.681877][    C1]  sysfs_create_dir_ns+0x123/0x280
[   36.681877][    C1]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
[   36.681877][    C1]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   36.681877][    C1]  ? rt_spin_unlock+0x65/0x80
[   36.681877][    C1]  kobject_add_internal+0x5a5/0xb50
[   36.681877][    C1]  kobject_add+0x155/0x220

Both are decoded to:

arch_static_branch at arch/x86/include/asm/jump_label.h:36
(inlined by) kfence_alloc at include/linux/kfence.h:121
(inlined by) slab_alloc_node at mm/slub.c:4213

which is kfence_allocation_key. Decoding the code shows:

  21:	85 c0                	test   %eax,%eax
  23:	0f 85 f6 00 00 00    	jne    0x11f
  29:*	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)		<-- trapping instruction
  2e:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)

which is clearly an intact NOP sequence. So with qemu plain the static
branch patching seems to be unhappy....

Oh well....




