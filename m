Return-Path: <linux-kernel+bounces-845568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8635BC564F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3684F38EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6728CF56;
	Wed,  8 Oct 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wXOIV+Tz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394028B407
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932517; cv=none; b=NscIcOXzruDOj2uZpJvyAyEle3idlxed03mDEAhsphpTo+iX1ttB5ro1mVKxFp7VjUORRsUOhDOhvS6GGLsxo+yOjCBNXLtew3zI10FHF2mto99pmT2njyPePi7b1odQMSkjavysG8az5JWAIJeOatukBfgffNmEPSj1AtHpPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932517; c=relaxed/simple;
	bh=tAwpicwtdQMUuNcHpBxjwYWrqxJs6DJpBsuCMldzPrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dveWA5D6/AifDgpp7RhCAORQ+xNyi2JGvRn1ozKr9LAO28w50p3PIuKUprJ5GdqZcvwp94PDqOU0pcyuFdIf2iHuJW3QYzLwc+2vK4edCGpGT2R5Jy3xlgUaXInRaZw4ixSbJZrUtxpWmNOXoi5iGyl7n0pJAvahBsxOiy49ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wXOIV+Tz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5YGz17tjyVqkAUMXByj29FD7vbgf3YKY876usv36iw8=; b=wXOIV+TzesxELkvE57to+2D3yA
	Dn1W4J3VkJABd/wmfZM7IawB+pzNnaQroxFIZabVznohvFA/OMN7Cr75JODv1JaTFjiVYnhbbRwh4
	ExNiwUS8XGgxJ+X6ki40QUH6ePyzAd+XnHpXiVKYrqgMvX4hpLQz7RrkbcRKEK6RwXCScGtUjg+95
	Xf/yIRgPT2XIFBUCAGZG+7/gdCqXg4NtpDZYEInaSD5QPhFKAugrGCExj3nifZWCX5Sa6ZvhIOqTw
	osXIpqguYOPMhBq9JdUsAY/HXnCXa2s5IIy7T/X7c1ez2yLTqBuvCtjxdr39q5ixaRzfEgSAa2wWz
	J7C13WUA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6UqA-00000006Vrk-3oOT;
	Wed, 08 Oct 2025 14:08:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31671300400; Wed, 08 Oct 2025 16:08:27 +0200 (CEST)
Date: Wed, 8 Oct 2025 16:08:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix pelt lost idle time detection
Message-ID: <20251008140827.GY4067720@noisy.programming.kicks-ass.net>
References: <20251008131214.3759798-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008131214.3759798-1-vincent.guittot@linaro.org>

On Wed, Oct 08, 2025 at 03:12:14PM +0200, Vincent Guittot wrote:
> The check for some lost idle pelt time should be always done when 
> pick_next_task_fair() fails to pick a task and not only when we call it
> from the fair fast-path.
> 
> The case happens when the last running task on rq is a RT or DL task. When
> the latter goes to sleep and the /Sum of util_sum of the rq is at the max
> value, we don't account the lost of idle time whereas we should.
> 
> Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Durr, sorry about that. Let me go queue this.

> ---
> 
> I Noticed this while reviewing [1]
> 
> [1] https://lore.kernel.org/all/20251006105453.648473106@infradead.org/
> 
>  kernel/sched/fair.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3be1e2749ce..dd0ea01af730 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8920,21 +8920,21 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  	return p;
>  
>  idle:
> -	if (!rf)
> -		return NULL;
> -
> -	new_tasks = sched_balance_newidle(rq, rf);
> +	if (rf) {
> +		new_tasks = sched_balance_newidle(rq, rf);
>  
> -	/*
> -	 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it is
> -	 * possible for any higher priority task to appear. In that case we
> -	 * must re-start the pick_next_entity() loop.
> -	 */
> -	if (new_tasks < 0)
> -		return RETRY_TASK;
> +		/*
> +		 * Because sched_balance_newidle() releases (and re-acquires)
> +		 * rq->lock, it is possible for any higher priority task to
> +		 * appear. In that case we must re-start the pick_next_entity()
> +		 * loop.
> +		 */
> +		if (new_tasks < 0)
> +			return RETRY_TASK;
>  
> -	if (new_tasks > 0)
> -		goto again;
> +		if (new_tasks > 0)
> +			goto again;
> +	}
>  
>  	/*
>  	 * rq is about to be idle, check if we need to update the
> -- 
> 2.43.0
> 

