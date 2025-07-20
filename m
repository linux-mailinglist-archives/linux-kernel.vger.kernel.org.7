Return-Path: <linux-kernel+bounces-738405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDAEB0B7F3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEDD3BCEE6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DF1DC994;
	Sun, 20 Jul 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRhg3DyY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGFBYRzP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054981F5F6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040292; cv=none; b=uzJ/IgfyZ1V9oOzXOAzaTx90l0lUOBrIcHjIbSgwivpkO7+lH1vUD7KZq0xXB9ZchR0E/0Ek9j78zUaf+X+EHtI90TzpKgWsR0NaLdHhDfCqWFvD8FgUrX5vBoYFVyAdqvlGXEyNuRF599Iqrlu3QM/rx00DMZiELhC637QE0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040292; c=relaxed/simple;
	bh=Ln3VbZhlVrp2HFzHS8J1PB917UqYH5/hJjmf1yRQsfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suH6GWvDvkwXQCMolyvXUstsyy4fR8LNo0+I4mT7TUi4V46ptUfsDXTI2qsw8Xuq9qXFi1EU7ahxFbZ7llNsVsw1KrhH6HhHNGgIUDySS72XrJffEqoJkXqXVs4vGYxj7qaCt4rQY6L2I5fgUlzS6+XH3e6vHNHKK+ky+IGVk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRhg3DyY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGFBYRzP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753040282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/b2Ff3b5Jnu1FwkRfr2uxkI+fy/sZb2g4EiywD1mn6g=;
	b=yRhg3DyYEbk9dYFbSLC31oAYvNAkyrw0snvS2rRmWjP6s395Uh6CKqSbGHpt/rCj0s/ncm
	BMAwPMHapFOf577uNGqJ5Qbq3DB8Ec6j/eHf8D3prT1FqNeKS0dzvJNIM1k68gkoIIAYCQ
	AqrTcZ5Vh/5zv4C9FvkbTed/jCUCy26wDn83iyEBjWTGIH05CaJG3oj5jtm6I7tpvN40bP
	owTK8fuRZwuqBOfAlypjzAmkQte9zE3jPya2Au/5+1uCP/9SJ6cTT8gRTjI6BMRd1lkLTH
	NWT0f3plu2+4n6hqZlvK1ziJZgLqaw8uHZmYOJqrkaHqV+lwHyq7Mc1hL9NBEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753040282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/b2Ff3b5Jnu1FwkRfr2uxkI+fy/sZb2g4EiywD1mn6g=;
	b=zGFBYRzP6DAGEMyoydVoqfmPO4SVZ+78sNG4Fj0r9OwC+ejbb7Sx4deJsMdM8NZmUg6kgA
	eZEkX2GK2u/NgGBQ==
To: =?utf-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in smp_call_function_many_cond
In-Reply-To: <758991c1.13f67.197f9cccf9b.Coremail.baishuoran@hrbeu.edu.cn>
References: <758991c1.13f67.197f9cccf9b.Coremail.baishuoran@hrbeu.edu.cn>
Date: Sun, 20 Jul 2025 21:38:00 +0200
Message-ID: <877c02vejr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11 2025 at 22:03, =E7=99=BD=E7=83=81=E5=86=89 wrote:
> When using our customized Syzkaller to fuzz the latest Linux kernel,
> the following crash (122th)was triggered.
>
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream

That's not the latest kernel.

> Output:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/INFO%3A%2=
0rcu%20detected%20stall%20in%20sys_select/122report.txt
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.14rc3=
/config.txt
> C reproducer:https:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.=
14/INFO%3A%20rcu%20detected%20stall%20in%20sys_select/122repro.c
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0702_6=
.14/INFO%3A%20rcu%20detected%20stall%20in%20sys_select/122repro.txt
>
> Our reproducer uses mounts a constructed filesystem image.
>
> The error occurred around line 880 of the code, specifically during
> the call to csd_lock_wait. The status of CPU 1 (RCU GP kthread):
> executing the perf_event_open system call, needs to update tracepoint

I can't find a perf_event_open() syscall in the C reproducer. So how is
that supposed to be reproduced?

> calls on all CPUs, and smp_call_function_many_cond is stuck waiting
> for CPU 2 to respond to the IPI.  We have reproduced this issue
> several times on 6.14 again.

Again not the latest kernel. Please run it against Linus latest tree and
if it still triggers, provide proper information how to reproduce. If
not you should be able to bisect the fix.

> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	2-...!: (3 GPs behind) idle=3Db834/1/0x4000000000000000 softirq=3D2=
3574/23574 fqs=3D5
> rcu: 	(detected by 1, t=3D10502 jiffies, g=3D19957, q=3D594 ncpus=3D4)

So CPU 1 detects an RCU stall on CPU2

> Sending NMI from CPU 1 to CPUs 2:
> NMI backtrace for cpu 2
> CPU: 2 UID: 0 PID: 9461 Comm: sshd Not tainted 6.14.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> RIP: 0010:__lock_acquire+0x106/0x46b0
> Code: ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 ec 35 00 00 49 8b 45 0=
0 48 3d a0 c7 8a 93 0f 84 29 0f 00 00 44 8b 05 2a dc 74 0c <45> 85 c0 0f 84=
 ad 06 00 00 48 3d e0 c7 8a 93 0f 84 a1 06 00 00 41
> RSP: 0018:ffffc90000568ac8 EFLAGS: 00000002
> RAX: ffffffff9aab9a20 RBX: 0000000000000000 RCX: 1ffff920000ad16c
> RDX: 1ffffffff35692cf RSI: 0000000000000000 RDI: ffffffff9ab49678
> RBP: ffff8880201aa480 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: ffffffff90617d17 R12: 0000000000000000
> R13: ffffffff9ab49678 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007fa644657900(0000) GS:ffff88802b900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0fa92178a9 CR3: 0000000000e90000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  lock_acquire+0x1b6/0x570
>  _raw_spin_lock_irqsave+0x3d/0x60
>  debug_object_deactivate+0x139/0x390
>  __hrtimer_run_queues+0x416/0xc30
>  hrtimer_interrupt+0x398/0x890
>  __sysvec_apic_timer_interrupt+0x114/0x400
>  sysvec_apic_timer_interrupt+0xa3/0xc0

which handles the timer interrupt. What you cut off in your report is:

[  321.491987][    C2] hrtimer: interrupt took 31336677795 ns

That means the hrtimer interrupt got stuck for 32 seconds (!!!). That
warning is only emitted once, so I assume there is something weird going
on with hrtimers and one of their callbacks. But there is no indication
where this comes from.

Can you enable the hrtimer_expire_entry/exit tracepoints on the kernel
command line and add 'ftrace_dump_on_oops' as well, so that the trace
gets dumped with the rcu stall splat?

Thanks,

        tglx



