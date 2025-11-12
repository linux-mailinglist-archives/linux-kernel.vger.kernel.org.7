Return-Path: <linux-kernel+bounces-897309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBAC5289C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9F218952F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5433556A;
	Wed, 12 Nov 2025 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SBIiAzXq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FC3375A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955092; cv=none; b=EzuS+3xforV2/27T7Cjh0ZASTDgcvIZHS0KRX3X3WWOfLhgpeZGIRph83M8XnGbnI7CckX/1y1V8krKQpnbuXMNtBnjVODWMZVXugYazFNiv3bLdEpw81KLmkjPdWxaIDsLoX9e4o1z8lWISx2sK3N+iz11vuzIM5Ei1OlOD2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955092; c=relaxed/simple;
	bh=naO+INhiVlqf2ycT+WAY2ZOOZQcRKtPuXN9tbQuPykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/VKsVQBnl1yKjVGIPdybGoZbIBNoMjmHTjhVt23PF4YOoHtOUohRcZfVSiLHfNfeP87MAlttf112gb+FyCf0xT7P4cB7UXdCPgV9bW/vOJJm7dVYXsRst6PyXVsnPA7gQLQpFf+YxnJq7eih4dgr+WtptTupV13p7IF+QGNXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SBIiAzXq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tjXeZOQKC6wBOBUkVo5VdwcoPQJakdDjNV1N402jE90=; b=SBIiAzXq2mKmB6TuSu+o77XYCb
	DVLYfLxTpNf2H21WEuksRXuge448A2/WrxPv8FM0T0sqrftlilhR2tw+HWcH8so5lRycbpaGxgKRW
	N/gzeJCfgHC90GuPK84KYPVhnVWZhg7eanlJVVe19lkpkLNmLrxBUUmchxvst2vUL/yi6lmwTfiAA
	3hqtjEIKfM049kKzC/+zeZQjD0aNKI19zDfkYSKhvu7wWx8AJs14WQ1v2wjHuBTtvtI5w2SQIP32U
	woYYx/Bifce7g+Z+7HvGCHIL7mTWWen3108yQwT+upK4+6JpAJC0r3CfSz9Fk8Yha1m43jz88o+3p
	kb+o+lDQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJB9M-00000005ysv-0XVp;
	Wed, 12 Nov 2025 13:44:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00C84300265; Wed, 12 Nov 2025 14:44:38 +0100 (CET)
Date: Wed, 12 Nov 2025 14:44:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <20251112134438.GF4068168@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
 <aRRuvLKvMdxw8bZV@linux.ibm.com>
 <20251112133937.GC3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112133937.GC3245006@noisy.programming.kicks-ass.net>

On Wed, Nov 12, 2025 at 02:39:37PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 04:55:48PM +0530, Srikar Dronamraju wrote:
> 
> > If the CPU that was doing the balance was not the first CPU of the domain
> > span, but it was doing the balance since the first CPU was busy, and the
> > first CPU now happens to be idle at redo, the scheduler would have chosen the
> > first CPU to do the balance. However it will now choose the CPU that had the atomic..
> > 
> > I think this is better because 
> > - The first CPU may have tried just before this CPU dropped the atomic and
> >   hence we may miss the balance opportunity.
> > - The first CPU and the other CPU may not be sharing cache and hence there
> >   may be a cache-miss, which we are avoiding by doing this.
> 
> I'm not sure I understand what you're arguing for. Are you saying it
> would be better to retain the lock where possible?

FWIW this is also the behaviour we had before this patch, where the lock
is taken in the caller, it would have covered the whole redo case as
well.

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11717,23 +11717,22 @@ static int sched_balance_rq(int this_cpu
>  		.fbq_type	= all,
>  		.tasks		= LIST_HEAD_INIT(env.tasks),
>  	};
> -	bool need_unlock;
> +	bool need_unlock = false;
>  
>  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>  
>  	schedstat_inc(sd->lb_count[idle]);
>  
>  redo:
> -	need_unlock = false;
>  	if (!should_we_balance(&env)) {
>  		*continue_balancing = 0;
>  		goto out_balanced;
>  	}
>  
> -	if (sd->flags & SD_SERIALIZE) {
> -		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
> +	if (!need_unlock && sd->flags & SD_SERIALIZE) {
> +		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
>  			goto out_balanced;
> -		}
> +
>  		need_unlock = true;
>  	}
>  
> @@ -11861,9 +11860,6 @@ static int sched_balance_rq(int this_cpu
>  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>  				env.loop = 0;
>  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> -				if (need_unlock)
> -					atomic_set_release(&sched_balance_running, 0);
> -
>  				goto redo;
>  			}
>  			goto out_all_pinned;

