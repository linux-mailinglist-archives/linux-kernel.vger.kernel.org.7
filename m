Return-Path: <linux-kernel+bounces-854742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9694BBDF491
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6881E405C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5C2D7DED;
	Wed, 15 Oct 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1vsJaOS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76D2D641D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540959; cv=none; b=BoA7Fp8QU2rIc8pLO7eMhSY+rL4FHkfKltIjTxEGffyjsMR18yf/in3rhrBoM7yKTHfLQvEkOeoFGcPIp5p9yEXutbXTY5JMAKdB3LswOAs9pErnUUaH84Oy6KB84a8nSsDZ75ohYfspWMDcSoBkH0WbgrgLRpu+81j/vHKmaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540959; c=relaxed/simple;
	bh=8G0Msy2CRW0casaw6KM30j2ia8xgPXPrWhuKzBHXeL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuY+itV8PXqPQzI6X0CFnDJzOubFMgl2gJT6eLiyhTpqVNlpz6mwAYpfhEihPR8qOWuyzCBXUnNLzSm4Ur0TDQfv1ye2psn79DKGxovdAVjUFB+D+ih9sSjlAs8hObxMGvUjPZ57y3wOloubVM7de4UdQxuYj7y7kKqdQBkBjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W1vsJaOS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h6A4rCyjZU1GtoVAZKenUtMFBFfNdztnaxVrMwFUzSM=; b=W1vsJaOSn7wDUpOopVmJuJmJCf
	xs84kTrE++nMsXYss54Ei21LpEyD/g9ssPpldQmtd6CtOU6H/3B6zsKl7VCDHTkBRj9iwrOl1MOVM
	MxGH86DK35kNoKiJtM1ZakoBvsCOGZvd6vW4xMRtgfTSADYGPOmknIQHEgpfLIzMv5cXghxt7TVdr
	NIkJkPHOfHS3Ov1LvkSvjI/nwdCuz/bmFlZbm9jBcNsX+98GumDycm0/gHp4j0964mwHUc9cJ8+yX
	sI8x069lkVWeBt1ph8yp2/QbfNNZBIObQND0u5VnA7JqaZHVgqSJTGSDo/fyzB7nRWfFC9rmUD+H1
	Uv5T0dUw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v937N-00000000bT8-2huL;
	Wed, 15 Oct 2025 15:08:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 666D830023C; Wed, 15 Oct 2025 17:08:46 +0200 (CEST)
Date: Wed, 15 Oct 2025 17:08:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring
 destination LLC during balancing
Message-ID: <20251015150846.GB3168635@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
> During LLC load balancing, first check for tasks that prefer the
> destination LLC and balance them to it before others.
> 
> Mark source sched groups containing tasks preferring non local LLCs
> with the group_llc_balance flag. This ensures the load balancer later
> pulls or pushes these tasks toward their preferred LLCs.
> 
> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---

For me this patch is cut too fine; it only sets group_llc_balance but
then we don't see how it is used.

>  kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cbd1e97bca4b..af7b578eaa06 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9822,8 +9822,7 @@ static __maybe_unused enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu
>  	else
>  		return mig_unrestricted;
>  
> -	return can_migrate_llc(src_cpu, dst_cpu,
> -			       task_util(p), to_pref);
> +	return can_migrate_llc(src_cpu, dst_cpu, task_util(p), to_pref);
>  }
>  
>  #else
> @@ -10394,6 +10393,7 @@ struct sg_lb_stats {
>  	enum group_type group_type;
>  	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
>  	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
> +	unsigned int group_llc_balance;		/* Tasks should be moved to preferred LLC */
>  	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int nr_numa_running;
> @@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env *env,
>  	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
>  		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
>  }
> +
> +/*
> + * Do LLC balance on sched group that contains LLC, and have tasks preferring
> + * to run on LLC in idle dst_cpu.
> + */
> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	struct sched_domain *child = env->sd->child;
> +	int llc;
> +
> +	if (!sched_cache_enabled())
> +		return false;
> +
> +	if (env->sd->flags & SD_SHARE_LLC)
> +		return false;
> +
> +	/* only care about task migration among LLCs */
> +	if (child && !(child->flags & SD_SHARE_LLC))
> +		return false;
> +
> +	llc = llc_idx(env->dst_cpu);
> +	if (sgs->nr_pref_llc[llc] > 0 &&

Nit: s/> 0// would be the same, right?

> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
> +		return true;
> +
> +	return false;
> +}
>  #else
>  static inline void record_sg_llc_stats(struct lb_env *env, struct sg_lb_stats *sgs,
>  				       struct sched_group *group)
>  {
>  }
> +
> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	return false;
> +}
>  #endif
>  
>  /**
> @@ -10954,6 +10988,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>  
>  	record_sg_llc_stats(env, sgs, group);
> +
> +	/* Check for tasks in this group can be moved to their preferred LLC */
> +	if (!local_group && llc_balance(env, sgs, group))
> +		sgs->group_llc_balance = 1;

We now have 3 (or so) branches that start with:

	if (!local_group &&

perhaps collate that some?

> +
>  	/* Computing avg_load makes sense only when group is overloaded */
>  	if (sgs->group_type == group_overloaded)
>  		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
> -- 
> 2.32.0
> 

