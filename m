Return-Path: <linux-kernel+bounces-801212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB9B44227
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B99A020E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8522D23AD;
	Thu,  4 Sep 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0m7J6wR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069541F4262
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001926; cv=none; b=UezwTzI41W31dW4xlY9pxL7L+y00hmfAqIpAOXKI/PSf+puPjptUOiqiYsMu3xqcT+wF9dwYF0q6WlIma3nPyj/3L9d40Jd4OKtMkW1GWNc4VQtIA0sflE3w7GdKw3mJsKvfKPsyZQnHATnCIJ5zeya3+dKCuwgMFmXWAK5RpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001926; c=relaxed/simple;
	bh=iLVcyr0jvQ2GCC3Cpf1b3sKXKD9ERka32krfugQxTtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LorCg4KQGwTyHjqnqB8qgtHBsDQZqZtiMkIgtASKz463UJnZMVXssdqvQHWUWW11WTAFOpz+TiphNZ44580cP/LzEo6C8MrpU6qlwtXM+z8Q3k97xPXVHNqoxmN31GS2qjnex9QnA0LZWiSC3JUuXqeIMMK3lVlBEgDz4Ae8c+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0m7J6wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB27C4CEF0;
	Thu,  4 Sep 2025 16:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001924;
	bh=iLVcyr0jvQ2GCC3Cpf1b3sKXKD9ERka32krfugQxTtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0m7J6wRr4xrRv2isEZ5ynFCSHC0vkj/Oc3Fd2pBul1gFVQBW3BqmjlY7if/xkXRW
	 Rw0KVqkzDcwR70YcrWPWVepPasir0T212Wp1Kc9D0/WuVk4xZlbYc8YXB0UHFqC03V
	 DIGPkystU9Cl2xfbvaZ+DZ11V452dRMOiaf928sH8YIo0IS2456wtGOuHKynC4UdsM
	 SMGgedtI9RMjzlyri0xHTJEfh0AFDaOMFbvNpzZoYWFgeQ8r4oqqTVXCLtuiTlLvhM
	 9f+2eOt1UZghQJLG2MVHxV0Fc4tCUG8hmx6275cWlBdDKJu6Eau8OtaIA1rGgH1pF4
	 iggw2bsIjPmYg==
Date: Thu, 4 Sep 2025 18:05:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, cl@linux.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, Christoph Lameter <cl@gentwo.org>
Subject: Re: [PATCH RESEND 1/2] tick/nohz: Fix wrong NOHZ idle CPU state
Message-ID: <aLm4wRwKBMGkekkT@localhost.localdomain>
References: <20250821042707.62993-1-adamli@os.amperecomputing.com>
 <20250821042707.62993-2-adamli@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821042707.62993-2-adamli@os.amperecomputing.com>

Le Thu, Aug 21, 2025 at 04:27:06AM +0000, Adam Li a écrit :
> NOHZ idle load balance is done among CPUs in nohz.idle_cpus_mask.
> A CPU is added to nohz.idle_cpus_mask in:
> do_idle()
>   -> tick_nohz_idle_stop_tick()
>      -> nohz_balance_enter_idle()
> 
> nohz_balance_enter_idle() is called if:
> 1) tick is stopped (TS_FLAG_STOPPED is set)
> 2) and tick was not already stopped before tick_nohz_idle_stop_tick()
>    stops the tick (!was_stopped)
> 
> When CONFIG_NO_HZ_FULL is set and the CPU is in the nohz_full list
> then 'was_stopped' may always be true.
> The flag 'TS_FLAG_STOPPED' may be already set in
> tick_nohz_full_stop_tick(). So nohz_balance_enter_idle() has no chance
> to be called.
> 
> As a result, CPU will stay in a 'wrong' state:
> 1) tick is stopped (TS_FLAG_STOPPED is set)
> 2) and CPU is not in nohz.idle_cpus_mask
> 3) and CPU stays idle
> 
> Neither the periodic nor the NOHZ idle load balancing can move task
> to this CPU. Some CPUs keep idle while others busy.
> 
> In nohz_balance_enter_idle(), 'rq->nohz_tick_stopped' is checked to avoid
> duplicated nohz.idle_cpus_mask setting. So for nohz_balance_enter_idle()
> there is no need to check the '!was_stopped' condition.
> 
> This patch will add the CPU to nohz.idle_cpus_mask as expected.
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> ---
>  kernel/time/tick-sched.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c527b421c865..b900a120ab54 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1229,8 +1229,9 @@ void tick_nohz_idle_stop_tick(void)
>  		ts->idle_sleeps++;
>  		ts->idle_expires = expires;
>  
> -		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> -			ts->idle_jiffies = ts->last_jiffies;
> +		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> +			if (!was_stopped)
> +				ts->idle_jiffies = ts->last_jiffies;
>  			nohz_balance_enter_idle(cpu);

The current state is indeed broken and some people have already tried to fix it.
The thing is nohz_full don't want dynamic isolation because it is deemed to run a
single task. Therefore those tasks must be placed manually in order not to break
isolation guarantees by accident.

In fact nohz_full doesn't make much sense without isolcpus (or isolated cpuset
v2 partitions) and I even intend to make nohz_full depend on domain isolation
in the long term.

Thanks.

>  		}
>  	} else {
> -- 
> 2.34.1
> 

-- 
Frederic Weisbecker
SUSE Labs

