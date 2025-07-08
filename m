Return-Path: <linux-kernel+bounces-721540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B8BAFCA98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27EC1887EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F382DC34E;
	Tue,  8 Jul 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qokGK1NV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9D28935C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978439; cv=none; b=KZFZUTz2vOe7KwR5rvB762t3UrJmKdwi/uHluWS08r90LGKwkY/Qxg9WCtR/mWIGH59oo8POYr+pFWBzZWkWbNfvaxGHw7xOCDfRfzJ1UMJZ54ct59zxbfzXFJd5KorHz7MXdODzEfQphbmb3tSMPDyHjKkfMHJJc6P459zHe+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978439; c=relaxed/simple;
	bh=jHbuF3dfK5BzD3MYHKV7hRBsqJHQvER1aMUv48TCEjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOjqb71caoizM+fakbrZ2kqVpUQfJY+wzcvmSTYVOwoP01QgBcTVAUXQYRVgNB8jFPu+H8JikSsT8g56oz0Fckq+ovPXMDsaiwOh69yG+QsuUWvjvN3RRGrr5O52XNYSbMsiDV6I/HnNx7HM5BlI7VPWWXaE0QiHpiGPAHMHhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qokGK1NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84170C4CEED;
	Tue,  8 Jul 2025 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978438;
	bh=jHbuF3dfK5BzD3MYHKV7hRBsqJHQvER1aMUv48TCEjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qokGK1NVHVFp7xdwlYW7ZoDzXfTABLLplE3Cqyp0h59Bv4+Ft/ybT1AOAkVnGQ1Eo
	 jvMRg7cRWoW7RabyODme4Pv0AswnQa858yCp0Fq5azUNoQCpYamJgpnF4sPVenweOX
	 3m71A2wIf24we0PZyrufYrAPygaytO1odpWDs8zbNF9CcpPcHyYhLxW/v4rcS3CvOA
	 6Eer1D6dPrGi3NTxKzoiTvMBHTbAIXiaOW1v7lPa4xdBT9uC5KuM9RLLT19UbHug8e
	 9q1q+IGpBrvh+SFg1oQoxfkp4lABMOXdthkK6MTY8XzMluPKD6IBEcYXTAG0hzOA8R
	 dZ5L2Dc3qX0uw==
Date: Tue, 8 Jul 2025 14:40:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: anna-maria@linutronix.de, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [PATCH] hrtimers: Update new CPU's next event in
 hrtimers_cpu_dying()
Message-ID: <aG0RxASJqknbaUkM@localhost.localdomain>
References: <20250708101727.166892-1-wangxiongfeng2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708101727.166892-1-wangxiongfeng2@huawei.com>

Le Tue, Jul 08, 2025 at 06:17:27PM +0800, Xiongfeng Wang a écrit :
> When testing softirq based hrtimers on an ARM32 board, with high
> resolution mode and nohz are both inactive, softirq based hrtimers
> failed to trigger when moved away from an offline CPU. The flowpath
> is as follows.
> 
> CPU0				CPU1
> 				softirq based hrtimers are queued
> 				offline CPU1
> 				move hrtimers to CPU0 in hrtimers_cpu_dying()
> 				send IPI to CPU0 to retrigger next event
> 'softirq_expires_next' is KTIME_MAX
> call retrigger_next_event()
> highres and nohz is inactive,just return
> 'softirq_expires_next' is not updated
> hrtimer softirq is never triggered
> 
> Some softirq based hrtimers are queued on CPU1. Then we offline CPU1.
> hrtimers_cpu_dying() moves hrtimers from CPU1 to CPU0, and then it send
> a IPI to CPU0 to let CPU0 call retrigger_next_event(). But high
> resolution mode and nohz are both inactive. So retrigger_next_event()
> just returned. 'softirq_expires_next' is never updated and remains
> KTIME_MAX. So hrtimer softirq is never raised.
> 
> To fix this issue, we call hrtimer_update_next_event() in
> hrtimers_cpu_dying() to update 'softirq_expires_next' for the new CPU.
> It also update hardirq hrtimer's next event, but it should have no bad
> effect.
> 
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  kernel/time/hrtimer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 30899a8cc52c..ff97eb36c116 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2298,8 +2298,11 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
>  	/*
>  	 * The migration might have changed the first expiring softirq
>  	 * timer on this CPU. Update it.
> +	 * We also need to update 'softirq_expires_next' here, because it will
> +	 * not be updated in retrigger_next_event() if high resolution mode
> +	 * and nohz are both inactive.
>  	 */
> -	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
> +	hrtimer_update_next_event(new_base);
>  	/* Tell the other CPU to retrigger the next event */
>  	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);

It seems that a similar problem can happen while enqueueing a timer
from an offline CPU (see the call to smp_call_function_single_async()).

How about this (untested) instead? retrigger_next_event, is not a fast
path so we don't care about rare extra cost:

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8cc52c..e8c479329282 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -787,10 +787,10 @@ static void retrigger_next_event(void *arg)
 	 * of the next expiring timer is enough. The return from the SMP
 	 * function call will take care of the reprogramming in case the
 	 * CPU was in a NOHZ idle sleep.
+	 *
+	 * In periodic low resolution mode, the next softirq expiration
+	 * must also be updated.
 	 */
-	if (!hrtimer_hres_active(base) && !tick_nohz_active)
-		return;
-
 	raw_spin_lock(&base->lock);
 	hrtimer_update_base(base);
 	if (hrtimer_hres_active(base))
@@ -2295,11 +2295,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 				     &new_base->clock_base[i]);
 	}
 
-	/*
-	 * The migration might have changed the first expiring softirq
-	 * timer on this CPU. Update it.
-	 */
-	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 

