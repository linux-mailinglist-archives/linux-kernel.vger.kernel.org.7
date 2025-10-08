Return-Path: <linux-kernel+bounces-845342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12250BC4849
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EDDA4E210E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB572F619B;
	Wed,  8 Oct 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NswvwVkB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954D2F6191
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922007; cv=none; b=pLUtvjdidc5RV4JiH8XEBi2vp0FHjLJ7QmUMXDH7qLf9r2d3wMtTgw94yierho5x+/UawrdkB4C/cQOLXaj8vILsjT1rmac74VMTpZntOyJHnceAeEA02b5crK/0OIRUMtWsn+gH/ulqoB3cf9+GjwjtzI42eKfQkrlQHWUzsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922007; c=relaxed/simple;
	bh=FPytbSRlOjVWlhzAY9VHIBuO0copWLlWeNWQr7fesMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht97WgVOvt0HPJC6db67q77UaAlOxYKkCxWjn4+sOcVB3nhN/zm7u3LyjRZPvPm6XqLgmfZ0CAn9GgH9VfbNgg4WEny9WOe15ca1Twpr9mc2+kxX0tebOu5MBQMQ967+eaUa1CSEj1rSL58FyX0I+l0mP19fg/bocBxmENPd0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NswvwVkB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tdDIVtOYGpm2++YgbsDVSjiZxnJfoMZtqbtSNzOB9kQ=; b=NswvwVkBptMaMcaLLNDJraO0Bh
	mQhVDp1UW00x1dp/H+LqT/PuWhQSihQwnbOF9akqqXSn6FS8Hy4zqB3XFeoZHhyesdQNjrKtv0ozS
	RCHU7guF9oZHXzSSkFfu1A1CDhtj4P/bEOGEpqjSF1/h6WlX38m/NfDhzPHh0qiqMOo4w9h2No42x
	i2kwadyqVdN7irBtCUVptwSyGiv9zhhwhi7cbhwbsiGaCrq7WtgM2QSYiZZbRcYq9fVvx+6vkLcD8
	Cufxj3v6VFXQrFaJrGaj499JktPsXWWkN/esrhZVMgmmRHRo7XhE8ovR+F13gYdiB3g0QG+LEtwkk
	PIEzWccQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6S6c-00000003eAk-3UjU;
	Wed, 08 Oct 2025 11:13:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC92E300220; Wed, 08 Oct 2025 13:13:14 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:13:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, jstultz@google.com,
	stultz@google.com
Subject: Re: [bisected][mainline]Kernel warnings at
 kernel/sched/cpudeadline.c:219
Message-ID: <20251008111314.GI3289052@noisy.programming.kicks-ass.net>
References: <8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com>
 <20251008095039.GG3245006@noisy.programming.kicks-ass.net>
 <5a248390-ddaa-4127-a58a-794d0d70461a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a248390-ddaa-4127-a58a-794d0d70461a@linux.ibm.com>

On Wed, Oct 08, 2025 at 03:47:16PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 10/8/25 3:20 PM, Peter Zijlstra wrote:
> > On Wed, Oct 08, 2025 at 07:41:10AM +0530, Venkat Rao Bagalkote wrote:
> > > Greetings!!!
> > > 
> > > 
> > > IBM CI has reported a kernel warnings while running CPU hot plug operation
> > > on IBM Power9 system.
> > > 
> > > 
> > > Command to reproduce the issue:
> > > 
> > > drmgr -c cpu -r -q 1
> > > 
> > > 
> > > Git Bisect is pointing to below commit as the first bad commit.
> > 
> > Does something like this help?
> > 
> > (also, for future reference, please don't line wrap logs, it makes them
> > very hard to read)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 198d2dd45f59..65f37bfcd661 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8328,6 +8328,7 @@ static inline void sched_set_rq_offline(struct rq *rq, int cpu)
> >   		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
> >   		set_rq_offline(rq);
> >   	}
> > +	dl_server_stop(&rq->fair_server);
> >   	rq_unlock_irqrestore(rq, &rf);
> >   }
> 
> 
> Hi Peter. Thanks for looking into it.
> 
> I was able to repro this issue on my system. This above diff didn't help. I still see the warning.
> 
> I have to understand this dl server stuff still.
> So not sure if my understanding is completely correct.
> 
> Looks like the hrtimer is firing after the cpu was removed. The warn on hit only with
> drmgr. Regular hotplug with chcpu doesn;t hit. That's because drmgr changes the cpu_present mask.
> and warning is hit with it.

I do not know what drmgr is. I am not familiar with PowerPC tools.
AFAICT x86 never modifies cpu_present_mask after boot.

> maybe during drmgr, the dl server gets started again? Maybe that's why above patch it didn't work.
> Will see and understand this bit more.

dl_server is per cpu and is started on enqueue of a fair task when:

  - the runqueue was empty; and
  - the dl_server wasn't already active

Once the dl_server is active it has this timer (you already found this),
this timer is set for the 0-laxity moment (the last possible moment in
time where it can still run its budget and not be late), during this
time any fair runtime is accounted against it budget (subtracted from).

Once the timer fires and it still has budget left; it will enqueue the
deadline entity. However the more common case is that its budget will be
depleted, in which case the timer is reset to its period end for
replenish (where it gets new runtime budget), after which its back to
the 0-laxity.

If the deadline entity gets scheduled, it will try and pick a fair task
and run that. In the case where there is no fair task, it will
deactivate itself.

The patch I sent earlier would force stop the deadline timer on CPU
offline.


> Also, i tried this below diff which fixes it. Just ignore the hrtimer if the cpu is offline.
> Does this makes sense?
> ---
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 615411a0a881..a342cf5e4624 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1160,6 +1160,9 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
>  	scoped_guard (rq_lock, rq) {
>  		struct rq_flags *rf = &scope.rf;
> +		if (!cpu_online(rq->cpu))
> +			return HRTIMER_NORESTART;
> +
>  		if (!dl_se->dl_throttled || !dl_se->dl_runtime)
>  			return HRTIMER_NORESTART;

This could leave the dl_server in inconsistent state. It would have to
call dl_server_stop() or something along those lines.

Also, this really should not happen; per my previous patch we should be
stopping the timer when we go offline.

Since you can readily reproduce this; perhaps you could stick something
like this in dl_server_start():

	WARN_ON_ONCE(!cpu_online(rq->cpu))

See if anybody is (re)starting the thing ?


