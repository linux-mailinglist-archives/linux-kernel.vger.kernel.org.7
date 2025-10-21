Return-Path: <linux-kernel+bounces-863433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D54BF7DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBF4F7D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECB34D4E3;
	Tue, 21 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bt8qWHyW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B234C14B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067145; cv=none; b=T/hpwcLzXfMoxNRvbutLRZI6OcK9tNdEO1YBS4QR97dYdOosTHmXUoYnaAAypLFGRTl1v6oFpy8DsXg6Js4ATQJ6Su+gRhwRIFKh17uWFnqJaKRmmEsgTeFqD8+MYMCUY59GTbKc8+9WYMc1rdgCN00VcWAaFzz6tGRTxflfa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067145; c=relaxed/simple;
	bh=QVeIHe8wp+XSkFvTJTwxSxMlsxElL9549AtRpwOzeTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh/LTUb4ccUBnIuJcDGk/zmtsFeO0cKCqh5NkooGW1q2PHqmRE/+/42Qx0Ad0g8q2EMe7vWNGsyMyXqsuns4TOJm1DQdfX8gH00z2O4tvyVDCfF/MIpM8bEaLJcKi2iIIgvVwbwYrBVTm30/Zk/b/f7f4ZMy8aLAFXRYwWjxwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bt8qWHyW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/JAZY6IA3QeQGlbKWIZX6CcoK0Tgv+6p4IsbxyVVnYk=; b=Bt8qWHyWM7RblPPDbkI2JPuWXT
	IgTjsBpgbmHqZJgUdqDwxeqQ8sZsLHzd8QpYgutY4zdEvdIIBDMXt59AEl0aIafNkm6GaTsXGd/XL
	JXn7cPg6MH9FVaLL3HX3rttaO5ajrzEYuVG0CKtnb+qGpkNyew2z5Ie9qpghw9KQYwbvODa17iTBj
	JuLBY6PTQwn/Q3utL+OukMZ6D0/+Sx86Wn+gmAUqym1IeIlaBD71ZrHYki2AXRVwL+6nP/+Lyl7o/
	bBLZLG6GPs4zg2rhRdq/sCNa+l73F4evU35QYSUCtL54LFfCpCKB/n8um5lGGs6iu+4OiVlH1RLJX
	z+pwx3XA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF8s-00000000tC0-1Okm;
	Tue, 21 Oct 2025 16:23:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 986AD30319D; Tue, 21 Oct 2025 14:35:34 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:35:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com>,
	anna-maria@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Juri Lelli <jlelli@redhat.com>
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (4)
Message-ID: <20251021123534.GU3419281@noisy.programming.kicks-ass.net>
References: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
 <87qzwers0e.ffs@tglx>
 <aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb>
 <17915467-06de-46f1-9032-3af258ff1aee@linux.ibm.com>
 <aPd6A7Gj3lg-EDzq@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPd6A7Gj3lg-EDzq@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Oct 21, 2025 at 02:18:11PM +0200, Juri Lelli wrote:
> On 21/10/25 10:12, Shrikanth Hegde wrote:
> > 
> > 
> > On 9/11/25 2:45 PM, Juri Lelli wrote:
> > > On 10/09/25 22:07, Thomas Gleixner wrote:
> > > > On Fri, Aug 29 2025 at 19:00, syzbot wrote:
> > > > 
> > > > > HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1130eef0580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=8b3a2e23253b50098164
> > > > > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > > > 
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > 
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/102656909b6f/disk-b6add54b.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/fa30d1d80a47/vmlinux-b6add54b.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/c25ee8abf30a/bzImage-b6add54b.xz
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com
> > > > > 
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 1 PID: 1186 at kernel/time/hrtimer.c:1052 hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> > > > > Modules linked in:
> > > > > CPU: 1 UID: 0 PID: 1186 Comm: irq/33-virtio1- Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> > > > > RIP: 0010:hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> > > > 
> > > > It compains that the timer is enqueued when it is attempted to be forwarded
> > > > 
> > > > > Code: 4c 89 33 48 8b 04 24 eb 07 e8 86 34 12 00 31 c0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 d8 4d 09 cc e8 6b 34 12 00 90 <0f> 0b 90 eb df 48 89 e8 4c 09 f8 48 c1 e8 20 74 0a 48 89 e8 31 d2
> > > > > RSP: 0018:ffffc90000a78bd0 EFLAGS: 00010006
> > > > > RAX: ffffffff81ac27e5 RBX: ffff8880b883b508 RCX: ffff888026c19dc0
> > > > > RDX: 0000000000000100 RSI: 0000000000010000 RDI: 0000000000010100
> > > > > RBP: 000000000009d057 R08: 0000000000010000 R09: 0000000000010100
> > > > > R10: dffffc0000000000 R11: ffffffff8167a890 R12: ffff8880b883b520
> > > > > R13: 0000000000184487 R14: 1ffff110171076a4 R15: 0000000000000001
> > > > > FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007f95323cbf98 CR3: 0000000064088000 CR4: 00000000003526f0
> > > > > Call Trace:
> > > > >   <IRQ>
> > > > >   hrtimer_forward_now include/linux/hrtimer.h:366 [inline]
> > > > >   dl_server_timer kernel/sched/deadline.c:1193 [inline]
> > > > 
> > > > which is strange as this is with the timer callback itself, so it
> > > > shouldn't be enqueued, unless there is a possiblilty to have:
> > > > 
> > > >     CPU0                       CPU1
> > > >     timer_expires()
> > > >        callback()              ????
> > > >          dl_task_timer()       rq_lock()
> > > >            rq_lock()             hrtimer_start()
> > > >                                rq_unlock()
> > > >             hrtimer_forward()
> > > > 
> > > > No idea whether that's possible, but that's the only sensible
> > > > explanation.
> > > 
> > > So, a dl_server_start() could be your ????, but it should see
> > > dl_server_active and just return if the dl_server callback is running.
> > > Unless a dl_server_stop() somehow interleaved as well and cleared it.
> > > 
> > 
> > isn't dl_server timer per CPU?
> 
> Indeed you have a point. Also dl-server timers handling has changed
> recently with several fixes from Peter.

Can still be a remote wakeup trying to start the timer.

Anyway, yeah, we've changed a bit around here, but we're still not quite
done -- there is that issue from Gabriel.

Also, every time I look at this code I get confused, so perhaps that
needs fixing too.

I'll poke at it some.

