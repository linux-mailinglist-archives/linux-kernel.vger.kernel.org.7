Return-Path: <linux-kernel+bounces-882901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F0EC2BD57
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2704F9868
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75B430E832;
	Mon,  3 Nov 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bleyDL0P"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D572C15B0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173779; cv=none; b=AbrVwsteDiB6K7qqeX0gq9KMSJzw1mKSECzHr6VH39WJhHYKi7IbTJZuk7lRpn+RFu6xgj9FkTHyIHwaWr21w2OwlQvtL9cegBWOgHbr9UZEcK2E3lhHKX2ExpJz8SM9hdt3J73Vt+Dysj12t1s1/Gp3FPaj5ZTnFm/3GUtsM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173779; c=relaxed/simple;
	bh=GzfJNnS8k9PO/njoznaMP5U40NTVFc1TUleN+wWEJJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENPtdc/8GadTN2JkMswr/VdZAx6Ibe5kzp+O7HtM/YHQaA5SuHbPgcNJbAeBx04qgfNLgPUevbWHvjsnJ8KMKuE8CBHcQ1DuqP3gsJTtry8Fgx0iRyI/OLEO8KNMU7NuRwQ6Vs4DE8XICioZI9tuSWmi25RoQfykeyv/sjctCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bleyDL0P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2a8UQPb7fi0E2pHv1T1cPse9bGS1UAjSBqMROoJ7Rcg=; b=bleyDL0PFwHQHGqkC9btjO60uO
	5b2Z2pcK1cVxUX1WJ7qLv98a/3BnPJb+GNZTuUS+k6bL+Pxuj9AQjRHhBDdADhDTxVNb8NT9+42JZ
	VqENDzp6XLRSfwH3XvJ2rVYmFRTgduQoW3WjZSamgZqtjR3xmlF94rNpGWYXq21Xg4NPc4zKdxFz5
	os5IXdeEO/+WiPZ0IeI+bEdpw82kke/kY37KTJA9gv/5p5P1g4ACZJouYrhKofBSUuJltPEwusVYH
	7Z7MIQwfzmiOCXOSX6GppPVsoltJLzsO9Rnw9BIszi7/rUjhU7Iwf1fSvl+PGYUG+QSELB41i1b5H
	kTnHTjXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFttd-00000006ANw-45JR;
	Mon, 03 Nov 2025 12:42:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C5AF30023C; Mon, 03 Nov 2025 13:42:54 +0100 (CET)
Date: Mon, 3 Nov 2025 13:42:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] cpu: Make atomic callbacks run on UP with disabled
 interrupts
Message-ID: <20251103124254.GA3245006@noisy.programming.kicks-ass.net>
References: <20251103120354.HU-oB1_z@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103120354.HU-oB1_z@linutronix.de>

On Mon, Nov 03, 2025 at 01:03:54PM +0100, Sebastian Andrzej Siewior wrote:
> On SMP callbacks in the "starting" range are invoked while the CPU is
> brought up and interrupts are still disabled. Callbacks which are added
> later ar invoked via the hotplug-thread on the target CPU and interrupts
> are explicitly disabled.
> In the UP case callbacks which are added later are invoked "directly"
> without the thread. This is okay since there is just one CPU but with
> enabled interrupts debug code, such as smp_processor_id(), will issue
> warnings.
> 
> Disable interrupts before invoking the calback on UP if the state is
> atomic and interrupts are expected to be disabled.
> The "save" part is required because this is also invoked early in the
> boot process while interrupts are disabled and must not be enabled.
> 
> Fixes: 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/cpu.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index db9f6c539b28c..a6902646b4933 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -249,6 +249,14 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
>  	return ret;
>  }
>  
> +/*
> + * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
> + */
> +static bool cpuhp_is_atomic_state(enum cpuhp_state state)
> +{
> +	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
> +}
> +
>  #ifdef CONFIG_SMP
>  static bool cpuhp_is_ap_state(enum cpuhp_state state)
>  {
> @@ -271,14 +279,6 @@ static inline void complete_ap_thread(struct cpuhp_cpu_state *st, bool bringup)
>  	complete(done);
>  }
>  
> -/*
> - * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
> - */
> -static bool cpuhp_is_atomic_state(enum cpuhp_state state)
> -{
> -	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
> -}
> -
>  /* Synchronization state management */
>  enum cpuhp_sync_state {
>  	SYNC_STATE_DEAD,
> @@ -2364,7 +2364,15 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
>  	else
>  		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
>  #else
> -	ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> +	if (1) {
> +		unsigned long flags = 0;
> +
> +		if (cpuhp_is_atomic_state(state))
> +			local_irq_save(flags);
> +		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> +		if (cpuhp_is_atomic_state(state))
> +			local_irq_restore(flags);
> +	}

How about:

	if (cpuhp_is_atomic_state(state)) {
		guard(irqsave)();
		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
		/*
		 * STARTING/DYING must not fail!
		 */
		WARN_ON_ONCE(ret);
	} else {
		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
	}

which is a little more like cpuhp_thread_fun()


>  #endif
>  	BUG_ON(ret && !bringup);
>  	return ret;
> -- 
> 2.51.0
> 

