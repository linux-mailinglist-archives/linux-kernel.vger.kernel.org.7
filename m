Return-Path: <linux-kernel+bounces-852765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFBBD9D71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6514F9E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49340314A9B;
	Tue, 14 Oct 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j2Q9L++4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC084314B7C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450408; cv=none; b=dcRVmhy8KsFUY2BvXsDh8NVPoWLT89cIDrBJaZ9TOBG+qD6lN0eBCy95CZm/yk63PYixUvsJCzKvXKyVfJTd9m+jlxpFicbmXIVl6vw0pcfVakUs6KSkb7Zo6A5YUG+6M231KvkGoEqUGCURLpmKiUIeDS4bu3ov1ZKgClr9Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450408; c=relaxed/simple;
	bh=5gLf7zFeMUxeJ1r3oPEvHCY3fIEwl0nZJqlny92eUQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZI3PLW7euYU/EqOxYcco9um7j9v5tpKapc433DdeVebPs35l3gJ6+Izg0Ie+/9MY5Bg5A0FGuNztYVIhjozzhcI9cHlx126hvesc+vCXtjbQj5p3hOXmOfe8Ib0JhcvFByhLBKRh8Z/Z4EdWrq3CbMmRyu9No+8qpeUgMWf1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j2Q9L++4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MAdevGeNe8Y946QS65C8/lB+ZL2XFuMi5HaHoj+dwCw=; b=j2Q9L++43ozMaHAizIHsyH2ciF
	k83y0vWqAisftkKlrQO6O63DDIZgfVTVGJqCub2Sq/iAMw2TS+RWUX3xl0d7+OMhI3tlM+kPPExvt
	D+BuWWPVf3+OflRPR+UrWi7nZWNAYRuFR+ao/rQroLtNDFtAKCOITeTkBa0ZCgvd3ADe7HSUn/pyv
	zlw205XzF97a5FxT1rF8GN9KYeHw3pLsieIeHdc5O40JUgBDKI+RZh0+paBe11zSLzeQgDqHAlNoX
	J2j4/dzlQUw+IpD7LE+VprmmOi+C8FjskB78oBGHB3fEGES0lMS0HgYwn2RfI8UKkM39tqBiBKqna
	g73p1aFQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8fZG-0000000BvUJ-2n54;
	Tue, 14 Oct 2025 14:00:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 575CF3001AE; Tue, 14 Oct 2025 15:59:58 +0200 (CEST)
Date: Tue, 14 Oct 2025 15:59:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251014135958.GW3245006@noisy.programming.kicks-ass.net>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
 <aO5VK4PO_REXNhnN@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5VK4PO_REXNhnN@linux.ibm.com>

On Tue, Oct 14, 2025 at 07:20:35PM +0530, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2025-10-14 11:24:36]:
> 
> > On Mon, Oct 13, 2025 at 02:54:19PM -0700, Tim Chen wrote:
> > 
> > 
> > Right, Yu Chen said something like that as well, should_we_balance() is
> > too late.
> > 
> > Should we instead move the whole serialize thing inside
> > sched_balance_rq() like so:
> > 
> > @@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *data)
> >  	return 0;
> >  }
> >  
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
> >  /*
> >   * Scale the max sched_balance_rq interval with the number of CPUs in the system.
> >   * This trades load-balance latency on larger machines for less cross talk.
> > @@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
> >  	/* Earliest time when we have to do rebalance again */
> >  	unsigned long next_balance = jiffies + 60*HZ;
> >  	int update_next_balance = 0;
> > -	int need_serialize, need_decay = 0;
> > +	int need_decay = 0;
> >  	u64 max_cost = 0;
> >  
> >  	rcu_read_lock();
> > @@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
> >  		}
> >  
> >  		interval = get_sd_balance_interval(sd, busy);
> > -
> > -		need_serialize = sd->flags & SD_SERIALIZE;
> > -		if (need_serialize) {
> > -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > -				goto out;
> > -		}
> > -
> >  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> >  			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> >  				/*
> > @@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
> >  			sd->last_balance = jiffies;
> >  			interval = get_sd_balance_interval(sd, busy);
> >  		}
> > -		if (need_serialize)
> > -			atomic_set_release(&sched_balance_running, 0);
> > -out:
> > +
> >  		if (time_after(next_balance, sd->last_balance + interval)) {
> >  			next_balance = sd->last_balance + interval;
> >  			update_next_balance = 1;
> 
> I think this is better since previously the one CPU which was not suppose to
> do the balancing may increment the atomic variable. If the CPU, that was
> suppose to do the balance now tries it may fail since the variable was not
> yet decremented.

Right, it would do that acquire and then still have at least 2 ways to
not actually balance, which is a waste.

