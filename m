Return-Path: <linux-kernel+bounces-852233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA56BD8817
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A4342720B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09762ED844;
	Tue, 14 Oct 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jsy4B3Gh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1702ECE97
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434994; cv=none; b=pRf/ibpcugEV52d1X/0JD4+bLtnePvjfS6EC8pihyg1QvfA3jTYjUmi6DadrrC9563hTUFITDb7x5KXvo1h3YLtLQGgBgxPKqEMK6hrui7Q+RRetolzsQ1IwxiL+qSioglokZX4vLwTyhskll+lMgRgK5OxvUBHjWQzcuGELAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434994; c=relaxed/simple;
	bh=6nTVpzL+pnnzT1najm9SzeZ30GY62APu0L74wo8Irus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAylhioCENvtf1P0i7Ni9wXyAfwMSmeULWkh+4Jlq8f+aNjjE1jOT6nZbqCQhzZvbg+CbHw04DwKldPliIPEQonPRvB9dHul1f47BCmQHH74dhUbK2OPa+zI3MRkAH1w916rHx57DJBhhknsovfA61jt+1iJ8hcetu1ouVCIBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jsy4B3Gh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f6rZC2r3D+QmTRPrD47lvKiuUx1xMTBsNLxjfTus9P4=; b=jsy4B3GhB0gYf51EGuu/8i6S+0
	heXsjkNFFtH9a9kUp0Djlgmm6XN13WbvIC4iCBSfcF94jLyTDOCjE/OCul4atiGZgLjMN0SfYtseQ
	uTJwU4vNVH21N/bEivr3OSFYVfxEDswHm8sBn4AmxyKu2nZt5SSH9UkbQwb/zlaP6WWsJIOacmqiA
	jYGy/Wn1Wdo7tQQ6TIBJcKznISkuqawoeVG70ouXf1D6tqCAIrpRaIHIvVj1sp1BpvccwfegFaXV/
	IpgvOawS050tqWWxoPCiOjPrk0h91U9RYHYF4QtTFSvJPofVm4xig9RvWv1P7GYLidaTyq9zpaMd2
	I3QJtHUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8bYa-000000054WD-2a47;
	Tue, 14 Oct 2025 09:43:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 505A9300399; Tue, 14 Oct 2025 11:42:59 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:42:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251014094259.GR3245006@noisy.programming.kicks-ass.net>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
 <e84de5a9-b498-4152-846a-c72e1ac66109@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84de5a9-b498-4152-846a-c72e1ac66109@linux.ibm.com>

On Tue, Oct 14, 2025 at 03:03:41PM +0530, Shrikanth Hegde wrote:

> > @@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> >   		goto out_balanced;
> >   	}
> > +	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
> > +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > +			goto out_balanced;
> 
> Maybe goto out instead of out_balanced ?

That would be inconsistent with the !should_we_balance() goto
out_balanced right above this, no?

> > +		need_unlock = true;
> > +	}
> > +
> >   	group = sched_balance_find_src_group(&env);
> >   	if (!group) {
> >   		schedstat_inc(sd->lb_nobusyg[idle]);
> > @@ -11998,6 +12021,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> >   	    sd->balance_interval < sd->max_interval)
> >   		sd->balance_interval *= 2;
> >   out:
> > +	if (need_unlock)
> > +		atomic_set_release(&sched_balance_running, 0);
> > +
> >   	return ld_moved;
> >   }
> > @@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *data)
> >   	return 0;
> >   }
> > -/*
> > - * This flag serializes load-balancing passes over large domains
> > - * (above the NODE topology level) - only one load-balancing instance
> > - * may run at a time, to reduce overhead on very large systems with
> > - * lots of CPUs and large NUMA distances.
> > - *
> > - * - Note that load-balancing passes triggered while another one
> > - *   is executing are skipped and not re-tried.
> > - *
> > - * - Also note that this does not serialize rebalance_domains()
> > - *   execution, as non-SD_SERIALIZE domains will still be
> > - *   load-balanced in parallel.
> > - */
> > -static atomic_t sched_balance_running = ATOMIC_INIT(0);
> > -
> >   /*
> >    * Scale the max sched_balance_rq interval with the number of CPUs in the system.
> >    * This trades load-balance latency on larger machines for less cross talk.
> > @@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
> >   	/* Earliest time when we have to do rebalance again */
> >   	unsigned long next_balance = jiffies + 60*HZ;
> >   	int update_next_balance = 0;
> > -	int need_serialize, need_decay = 0;
> > +	int need_decay = 0;
> >   	u64 max_cost = 0;
> >   	rcu_read_lock();
> > @@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
> >   		}
> >   		interval = get_sd_balance_interval(sd, busy);
> > -
> > -		need_serialize = sd->flags & SD_SERIALIZE;
> > -		if (need_serialize) {
> > -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > -				goto out;
> > -		}
> > -
> >   		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> >   			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> >   				/*
> > @@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
> >   			sd->last_balance = jiffies;
> >   			interval = get_sd_balance_interval(sd, busy);
> >   		}
> > -		if (need_serialize)
> > -			atomic_set_release(&sched_balance_running, 0);
> > -out:
> > +
> >   		if (time_after(next_balance, sd->last_balance + interval)) {
> >   			next_balance = sd->last_balance + interval;
> >   			update_next_balance = 1;
> 

