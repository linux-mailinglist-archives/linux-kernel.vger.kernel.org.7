Return-Path: <linux-kernel+bounces-822842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AAB84C63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475ED7C334D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B64A306B1F;
	Thu, 18 Sep 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWNkzGgi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC127F171
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201485; cv=none; b=Dfi/OMy9Yw6eyDDXAsivassu7/3i878p1C5f2S15lqReZWaAD4PFv9VRsH2UOFuPnWPE75cBPw8e1mNhYaacgTme7y1PIQTyI/ikfp+4K3pTw59nzZCL0IcSpU7uzi3zDfdGX17GPnHrX05D9UaR7bQk5/oWxl49ienWM8n8Fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201485; c=relaxed/simple;
	bh=MSjRBxw/zceuVDmvMXTNi10bdOAZSX2EYj17H1y7H5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BINzudZQl40HrKj9tO67VZqVuapSgkNJXbob95PIqrq1Hajh1FSU0NPlY1mNjMH2sQQolbo5w/x+RIBa/WTja/W+W/sdfb9i2VpK8a+gBxCjQodXptSf/tflwADMUHRXwIDBe1k16QqdWELTxrJrqxbR2fTMpZPQoEkyAMiyyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWNkzGgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9920FC4CEE7;
	Thu, 18 Sep 2025 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758201485;
	bh=MSjRBxw/zceuVDmvMXTNi10bdOAZSX2EYj17H1y7H5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWNkzGginqvMQHdffjyysxpma31jEAbYgEEr4oISVJU59LPeITxaGc9hRL0TygUm3
	 LG0YMMcF8Yjw1OPd6U2IkE57ZojA3M1RqZz9sSWWzYrIqmJ4kpOntDltrxf19jUVgM
	 o+oYUeL7PDQpxaBMQcRMdN6Z40TAltvnOVAaT0PaAgF4776pxmA9638d9wivwxxuOF
	 Kt6ZmOuDPEdftMw1iSKVpLNXhsjSXe+9IOrljDXykLWujdRxIukJn6JSL4pNG8LRMV
	 3U0rzpU9iG479/kNSKKIBRqiUdxHMhG7GFDqnC9LzbJe3QTvbGnAvOh0Y0COnEQXrh
	 rV9nZ7QayI8CA==
Date: Thu, 18 Sep 2025 15:18:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 01/33] sched/isolation: Remove housekeeping static key
Message-ID: <aMwGinpG8_RbhObl@localhost.localdomain>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-2-frederic@kernel.org>
 <20250901102642.GH4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901102642.GH4067720@noisy.programming.kicks-ass.net>

Le Mon, Sep 01, 2025 at 12:26:42PM +0200, Peter Zijlstra a écrit :
> On Fri, Aug 29, 2025 at 05:47:42PM +0200, Frederic Weisbecker wrote:
> 
> > +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> > +{
> > +	if (housekeeping_flags & BIT(type))
> > +		return housekeeping_test_cpu(cpu, type);
> > +	else
> > +		return true;
> > +}
> 
> That 'else' is superfluous.
> 
> > -static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> > -{
> > -#ifdef CONFIG_CPU_ISOLATION
> > -	if (static_branch_unlikely(&housekeeping_overridden))
> > -		return housekeeping_test_cpu(cpu, type);
> > -#endif
> > -	return true;
> > -}
> >  
> >  static inline bool cpu_is_isolated(int cpu)
> >  {
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index a4cf17b1fab0..2a6fc6fc46fb 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -16,19 +16,13 @@ enum hk_flags {
> >  	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> >  };
> >  
> > -DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
> > -EXPORT_SYMBOL_GPL(housekeeping_overridden);
> > -
> > -struct housekeeping {
> > -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> > -	unsigned long flags;
> > -};
> > -
> > -static struct housekeeping housekeeping;
> > +static cpumask_var_t housekeeping_cpumasks[HK_TYPE_MAX];
> > +unsigned long housekeeping_flags;
> > +EXPORT_SYMBOL_GPL(housekeeping_flags);
> 
> I don't particularly like exporting variables much. It means modules can
> actually change the value and things like that.

Can't say I'm confortable myself.

> 
> And while an exported static_key can be changed by modules, that's
> fixable.

Hm, ok I think I can keep it.

My only worry was that in such a situation:

    CPU 0                              CPU 1
    -----                              -----
    rcu_read_lock()                   static_key_enable(&key)
    if (static_key_unlikely(&key))    synchronize_rcu()
        do_something()
    rcu_read_unlock()

The static_key_unlikely evaluation is really part of that RCU
reader sequence block. I must count on the fact that the (un-)patched
instruction is well contained within the rcu_read_lock() / rcu_read_unlock().

I think it should be the case.

Also I see that, at least on x86, static_key_enable() eventually ends up
into sync_core() broadcast IPIs. And that followed by synchronize_rcu()
should make sure that the whole block sequence from past readers should be done.

So yes I think I can try to keep that static key.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

