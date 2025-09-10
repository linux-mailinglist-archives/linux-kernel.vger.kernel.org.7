Return-Path: <linux-kernel+bounces-810925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDEB52190
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF33B467A81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FB2BB1D;
	Wed, 10 Sep 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KP8uSR4v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJb1KelV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0752ED871
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534839; cv=none; b=ZO6HxQ5VBIumDUSvu43qiCc5rmTwv/R82n3DSZP4ptPFFwRrbT7SeswtPW2yxfBVw4P2rlFDw3NNVcmscEbTJSXxvjjT67VpJczMgOwif+dOLpvBVrEBrUcRt7R/HeGQ1mZkQ7w44EJQAWRQRabylcpsiN0c0P+LY9/fRDa1Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534839; c=relaxed/simple;
	bh=DRpSdqEBlULqatQ28DhIqTN1PXhpqV1W058lxudFvys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WzdMnVjcxfTBA8y6gLWE6PIacs+Fv+kQhphY+V36Dx4rZ8qDSGZcYlsTmcgIgoOWFoWRaSoNUFXLyESMXc5lvnm1zwlMAaYMlwvT1CHXne0vrY5b5+QitiyFRXlX+nFHZs4rIjdy+OiKbyCLfX6r/z4LQVwgZeKhT4llyFj3M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KP8uSR4v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJb1KelV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757534834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXiU2Y758Ana+gXTRNJ7cGEemsdXEpDtx+PeKTGcMqo=;
	b=KP8uSR4vsTWPAj3XhOCpB6QeNPLsFVVnfwtNXrb8yxbL9CUeZ5TuJv6v1/pw/w2vAEq4q7
	GFlGL7xgTuUCqZ6D5iYCKmZriLQtkD+P4+aR75nKuDgYbFtpqSHWSkWrUe205xx5CoYtAd
	BMLKDW3vJ3hfcgCdcoaATGFOTlhFhiG3K63N36+nNZLoHXu5gSr4BIJQvuM8qmKhzPLlpL
	UIincmwjgtwnc+JVOytWCiHp2/xMIXr2XRsYwES3nPv5RVx8Rh/s7+7VaCd4MUmhKMzXCG
	O/29mOwQe41wFwTUwTdq64AQ9nB5OSXiCrXiRGk6b4Efi/+oIsXr1sSDT7HTfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757534834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXiU2Y758Ana+gXTRNJ7cGEemsdXEpDtx+PeKTGcMqo=;
	b=WJb1KelVPWpq3gcmn+l2dHPcoeqYU3JdCmGEZUz0GVZlpx3Rvb+6OOlgAkTVC4Ei0v+GqJ
	Ja6q20EF7aLzHzCg==
To: syzbot <syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (4)
In-Reply-To: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
References: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
Date: Wed, 10 Sep 2025 22:07:13 +0200
Message-ID: <87qzwers0e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 29 2025 at 19:00, syzbot wrote:

> HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1130eef0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8b3a2e23253b50098164
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/102656909b6f/disk-b6add54b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fa30d1d80a47/vmlinux-b6add54b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c25ee8abf30a/bzImage-b6add54b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1186 at kernel/time/hrtimer.c:1052 hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> Modules linked in:
> CPU: 1 UID: 0 PID: 1186 Comm: irq/33-virtio1- Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052

It compains that the timer is enqueued when it is attempted to be forwarded

> Code: 4c 89 33 48 8b 04 24 eb 07 e8 86 34 12 00 31 c0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 d8 4d 09 cc e8 6b 34 12 00 90 <0f> 0b 90 eb df 48 89 e8 4c 09 f8 48 c1 e8 20 74 0a 48 89 e8 31 d2
> RSP: 0018:ffffc90000a78bd0 EFLAGS: 00010006
> RAX: ffffffff81ac27e5 RBX: ffff8880b883b508 RCX: ffff888026c19dc0
> RDX: 0000000000000100 RSI: 0000000000010000 RDI: 0000000000010100
> RBP: 000000000009d057 R08: 0000000000010000 R09: 0000000000010100
> R10: dffffc0000000000 R11: ffffffff8167a890 R12: ffff8880b883b520
> R13: 0000000000184487 R14: 1ffff110171076a4 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f95323cbf98 CR3: 0000000064088000 CR4: 00000000003526f0
> Call Trace:
>  <IRQ>
>  hrtimer_forward_now include/linux/hrtimer.h:366 [inline]
>  dl_server_timer kernel/sched/deadline.c:1193 [inline]

which is strange as this is with the timer callback itself, so it
shouldn't be enqueued, unless there is a possiblilty to have:

   CPU0                       CPU1
                                
   timer_expires()
      callback()              ????
        dl_task_timer()       rq_lock()
          rq_lock()             hrtimer_start()
                              rq_unlock()
           hrtimer_forward()

No idea whether that's possible, but that's the only sensible
explanation.

>  dl_task_timer+0xa42/0x12d0 kernel/sched/deadline.c:1234
>  __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
>  __hrtimer_run_queues+0x503/0xd40 kernel/time/hrtimer.c:1825
>  hrtimer_interrupt+0x45d/0xa90 kernel/time/hrtimer.c:1887
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
>  __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1056
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
>  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

