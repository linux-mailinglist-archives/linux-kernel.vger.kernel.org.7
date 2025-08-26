Return-Path: <linux-kernel+bounces-785797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C293B35123
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF0A7A75D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F611FDA94;
	Tue, 26 Aug 2025 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FF1W0Lyu"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A002356BD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172721; cv=none; b=mVyP4Bs+p7YyYCnsmo4ZELwcpjYUcLlqNWP8np75EBGzZIPwBHKz+dZAlLFvjstGIlxbnUtz1xfZW2nNPw48ylGn7kcA4Iu0skT//CD80CqpvgowD/XVwCPeIWTlffNLrAuCP3YcqJL57I4AfGDVd8+Ww+WgkPLXC/3AoWgg5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172721; c=relaxed/simple;
	bh=hEeOvL96oX//3xN5hbYJM3EN0uLmzkFCLHaDkaPAyNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ysy/qzxT8MdoFfhgk1jqoYEs+vtztwrN226enJ6q0beMnPuML2YWTL3R60MHfBoEwC4X+9dCt19Y7FeAm+RSEw7NTgpuDaQmdde5wZ0+0qHkU8J9ZVoHD3byPDgaKSwHdLWyIODZnr16Yw1Pdan4Pn8v6otwWdM5Q78GSfG9cLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FF1W0Lyu; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f994d6f-0055-16b8-3246-4bf8f34652a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756172716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhPKSYeWa3LByOwSOh1Oz83tUV3CK9Eh3Eg0l1lL8YM=;
	b=FF1W0Lyurb2owuOnES139G4RVFiULBq9z93ZhUSitMyk4YpfkTnZUiiWv1LpMmTI+cgr/n
	RqJMPAUdCf69doj3CHibG8TaPJ74WdBNzv/A5m7CvF22Mt0La/ZhZo2LbpWSDEvkNxA53u
	4R6twjP31Jq5UABcOq6zEkmUmOqStcE=
Date: Tue, 26 Aug 2025 09:45:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sched/rt: Remove the unnecessary CONFIG_RT_GROUP_SCHED
Content-Language: en-US
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <20250818061716.1168820-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20250818061716.1168820-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi all,

Gentle ping.

Thanks

On 2025/8/18 14:17, Yajun Deng wrote:
> After commit 5f6bd380c7bd ("sched/rt: Remove default bandwidth control"),
> these bandwidth control members are only initialized when
> CONFIG_RT_GROUP_SCHED is enabled.
>
> Remove the unnecessary CONFIG_RT_GROUP_SCHED from init_rt_rq() and
> initialize the members in init_tg_rt_entry().
>
> In sched_init(), the rt_runtime of rt_bandwidth will be initialized by
> global_rt_runtime(), so we can unify the rt_runtime of rt_rq by it in
> init_tg_rt_entry().
>
> Also, remove the unnecessary CONFIG_RT_GROUP_SCHED in rt_se_prio().
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   kernel/sched/core.c |  6 ------
>   kernel/sched/rt.c   | 17 +++++------------
>   2 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..e9d6ceead9f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8772,12 +8772,6 @@ void __init sched_init(void)
>   #endif /* CONFIG_FAIR_GROUP_SCHED */
>   
>   #ifdef CONFIG_RT_GROUP_SCHED
> -		/*
> -		 * This is required for init cpu because rt.c:__enable_runtime()
> -		 * starts working after scheduler_running, which is not the case
> -		 * yet.
> -		 */
> -		rq->rt.rt_runtime = global_rt_runtime();
>   		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
>   #endif
>   		rq->sd = NULL;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7936d4333731..390f3d08abbe 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -84,14 +84,6 @@ void init_rt_rq(struct rt_rq *rt_rq)
>   	plist_head_init(&rt_rq->pushable_tasks);
>   	/* We start is dequeued state, because no RT tasks are queued */
>   	rt_rq->rt_queued = 0;
> -
> -#ifdef CONFIG_RT_GROUP_SCHED
> -	rt_rq->rt_time = 0;
> -	rt_rq->rt_throttled = 0;
> -	rt_rq->rt_runtime = 0;
> -	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
> -	rt_rq->tg = &root_task_group;
> -#endif
>   }
>   
>   #ifdef CONFIG_RT_GROUP_SCHED
> @@ -229,10 +221,14 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>   {
>   	struct rq *rq = cpu_rq(cpu);
>   
> -	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
> +	rt_rq->rt_time = 0;
> +	rt_rq->rt_throttled = 0;
>   	rt_rq->rt_nr_boosted = 0;
> +	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
> +
>   	rt_rq->rq = rq;
>   	rt_rq->tg = tg;
> +	rt_rq->rt_runtime = tg->rt_bandwidth.rt_runtime;
>   
>   	tg->rt_rq[cpu] = rt_rq;
>   	tg->rt_se[cpu] = rt_se;
> @@ -280,7 +276,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
>   			goto err_free_rq;
>   
>   		init_rt_rq(rt_rq);
> -		rt_rq->rt_runtime = tg->rt_bandwidth.rt_runtime;
>   		init_tg_rt_entry(tg, rt_rq, rt_se, i, parent->rt_se[i]);
>   	}
>   
> @@ -957,12 +952,10 @@ static void __disable_runtime(struct rq *rq) { }
>   
>   static inline int rt_se_prio(struct sched_rt_entity *rt_se)
>   {
> -#ifdef CONFIG_RT_GROUP_SCHED
>   	struct rt_rq *rt_rq = group_rt_rq(rt_se);
>   
>   	if (rt_rq)
>   		return rt_rq->highest_prio.curr;
> -#endif
>   
>   	return rt_task_of(rt_se)->prio;
>   }

