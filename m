Return-Path: <linux-kernel+bounces-735993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB41B09667
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715BF16EF48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3B22E3E9;
	Thu, 17 Jul 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leLicwMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32113B58A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788297; cv=none; b=SQIYBPJjBf7CRY3XQ97os3mbxY0JGRE+U2a6pduy570jn707+biLJSnw/bfyaVsNn3+XZnFYvuy+XmhizYWPbK/CAP4MdL5Lpk1TJHJL4ZPlx34/3AmVlglRVyfghZxd1kapt+Jp+kt4lhkObs2U0/FkBDmoDwsgDrdZXMCcMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788297; c=relaxed/simple;
	bh=LiNK5XiD8Nkw+QptQUEajGCLfd37k6W3AFn17ZWlEs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVGBYs9law7ZZqLarbteh8FE0fuWho1wdfexBQKJqywEA1x04W6qqpX6ekRTyjF0a+SHzaT8CrYzXe9dZJwPZCLlnYmEToa0Y7+S+4xy1WqRLxZ8JT939aQa3EHx0ukMyzPnKXcEwOSSfWnHiFuDY8dGvq+v2h6wf9JOXp0BHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leLicwMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B203C4CEE3;
	Thu, 17 Jul 2025 21:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752788297;
	bh=LiNK5XiD8Nkw+QptQUEajGCLfd37k6W3AFn17ZWlEs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leLicwMk8Tr98ssWQ4QP7o2sRyOpyDBzmCRQ0w4teIPliRyK7fxdeCHXiu60MYGuQ
	 G+9Tf98zcOXPZnkuO9XGoOLS3/TNrTWju013xwdhW+ZEE3MnfEOAoWAO1oX3rqe1dl
	 OOFB4ODRV3UXJaL/Zt5l8TKqp0vbyz4dy0cNxM10nqJU1WsGlFisMJ0H7Ka50Uuvxl
	 mo8YYSlu0E92imjY1d2wkQ7moFa0hoEUjGVh5t4n+uS1Ogh9XeWPxrfpUSlM2zj6v7
	 sQWHcUXxB866n4+KZTDKOWhjBxigZkDeZx7vWA/HzCgf6T6UpPsgzJVDaILu0x5UMf
	 JUj6qof9HLCRA==
Date: Thu, 17 Jul 2025 11:38:15 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: liuwenfang <liuwenfang@honor.com>
Cc: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Message-ID: <aHltRzhQjwPsGovj@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ced96acd54644325b77c2d8f9fcda658@honor.com>

Hello,

My aplogies for really late reply. I've been off work and ended up a lot
more offline than I expected.

On Sat, Jun 28, 2025 at 06:50:32AM +0000, liuwenfang wrote:
> Supposed RT task(RT1) is running on CPU0 and RT task(RT2) is awakened on CPU1,
> RT1 becomes sleep and SCX task(SCX1) will be dispatched to CPU0, RT2 will be
> placed on CPU0:
> 
> CPU0(schedule)                                     CPU1(try_to_wake_up)
> set_current_state(TASK_INTERRUPTIBLE)              try_to_wake_up # RT2
> __schedule                                           select_task_rq # CPU0 is selected
> LOCK rq(0)->lock # lock CPU0 rq                        ttwu_queue
>   deactivate_task # RT1                                  LOCK rq(0)->lock # busy waiting
>     pick_next_task # no more RT tasks on rq                 |
>       prev_balance                                          |
>         balance_scx                                         |
>           balance_one                                       |
>             rq->scx.cpu_released = false;                   |
>               consume_global_dsq                            |
>                 consume_dispatch_q                          |
>                   consume_remote_task                       |
>                     UNLOCK rq(0)->lock                      V
>                                                          LOCK rq(0)->lock # succ
>                     deactivate_task # SCX1               ttwu_do_activate
>                     LOCK rq(0)->lock # busy waiting      activate_task # RT2 equeued
>                        |                                 UNLOCK rq(0)->lock
>                        V
>                     LOCK rq(0)->lock # succ
>                     activate_task # SCX1
>       pick_task # RT2 is picked
>       put_prev_set_next_task # prev is RT1, next is RT2, rq->scx.cpu_released = false;
> UNLOCK rq(0)->lock
> 
> At last, RT2 will be running on CPU0 with rq->scx.cpu_released being false!
> 
> So, Add the scx_next_task_picked () and check sched class again to fix the value
> of rq->scx.cpu_released.

Yeah, the problem and diagnosis look correct to me. It'd be nice if we don't
have to add an explicit hook but ops.cpu_acquire() needs to be called before
dispatching to the CPU and then we can lose while doing ops.pick_task().

> Signed-off-by: l00013971 <l00013971@hihonor.com>

Can you please use "FIRST_NAME LAST_NAME <EMAIL>" when signing off?

> -static void switch_class(struct rq *rq, struct task_struct *next)
> +static void switch_class(struct rq *rq, struct task_struct *next, bool prev_on_scx)
>  {
>  	const struct sched_class *next_class = next->sched_class;
>  
> @@ -3197,7 +3197,8 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>  	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
>  	 * resched.
>  	 */
> -	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> +	if (prev_on_scx)
> +		smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);

It's currently obviously broken as the seq is currently only incremented on
scx -> !scx transitions but it should be called on all transitions. This is
a breakage introduced by b999e365c298 ("sched, sched_ext: Replace
scx_next_task_picked() with sched_class->switch_class()").

> +void scx_next_task_picked(struct rq *rq, struct task_struct *prev,
> +			  struct task_struct *next)
> +{
> +	bool prev_on_scx = prev && (prev->sched_class == &ext_sched_class);

I don't think @prev or @next can ever be NULL, can they?

> +
> +	if (!scx_enabled() ||

Let's make this an inline function in ext.h. The pnt_seq update should be
moved here after scx_enabled() test, I think. This probably should be a
separate patch.

> +	    !next ||
> +	    next->sched_class == &ext_sched_class)
> +		return;
> +
> +	switch_class(rq, next, prev_on_scx);
> +}
>
>  static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  			      struct task_struct *next)
>  {
> @@ -3253,7 +3267,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		 */
>  		if (p->scx.slice && !scx_rq_bypassing(rq)) {
>  			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
> -			goto switch_class;
> +			return;
...
> @@ -2465,6 +2468,8 @@ static inline void put_prev_set_next_task(struct rq *rq,
>  
>  	__put_prev_set_next_dl_server(rq, prev, next);
>  
> +	scx_next_task_picked(rq, prev, next);

It's a bit unfortunate that we need to add this hook but I can't see another
way around it for both the problem you're reporting and the pnt_seq issue.
Maybe name it scx_put_prev_set_next(rq, prev, next) for consistency?

Thanks.

-- 
tejun

