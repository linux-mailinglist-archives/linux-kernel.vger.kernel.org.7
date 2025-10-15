Return-Path: <linux-kernel+bounces-854464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA4DBDE740
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A19D3BCBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9075326D4B;
	Wed, 15 Oct 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSMTxvup"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC0322DC1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530922; cv=none; b=YJf3T9Gg9qHSl0YEdOxHdmRh2RJ8RkT2yw8LyPZnYA4HCecghfQ+EUtEvHvWb5Lt3WwENv06EKLDeV6fhrp0z6d84S3L7PQdizL6ETtXNLSIlAGSGcjVSsjAJnujIsPJekAFaqkoCX8C/QLxeSH/0UJ3rwbzaZZK2vOIDjDRAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530922; c=relaxed/simple;
	bh=i5JcG/Z+BldTXDuE6GEvxgIsHsJvWVu4N6sB6Tkhsz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4BaKkdyXqMqc5xw8q7zhCoDfq4WngrTFg3JJKPaHFjS9ZoNP1UegOx4QtLlvZSrh/gi0RPd/8X7dkcTTRrnlJoMAn6YRr9J8WOlb7OvbNzyoiB93lAvzcVj3L/CwoaCHQEpogjhXerKxkYPRAFb+dd+zP1GRLhX+rOo351PdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NSMTxvup; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BtjC/n/7RhbQCJlgtQp4vIY8/Kd0MG5Tb+DvBihho8s=; b=NSMTxvupv3CC7TCCGTUpXQPgul
	gNU1XfrrgXhh00xUyhTXxRDCwn84uLS0XPVkRA3b3GLU6+HCnnH9p9rEH4zru3NmE0qPcgL0cCkin
	H4c+DGeI1IGPZ13S085EAjutI4TM8UuRHhcgJ4uMglGf8JQffxgXHX3JrvxH+2XrjdjmsXNC4SXCX
	TloXxFTw13rXLkTPCSzlgNpajfxNjPPhZltP6pbRtTlyROYiwu1zbrfOnGvXjewb6mSiZyzZ6X62p
	i5YZrzaB8CHEeiKuAXgW3uIEr8uXVCBRoAB5eqmiCa2IlooJyG/B2/aX1mPIQB6Hq8DY82frnGkg1
	L6Oom5yQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90VQ-0000000F1Mb-3o8L;
	Wed, 15 Oct 2025 12:21:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19D0730023C; Wed, 15 Oct 2025 14:21:25 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:21:25 +0200
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
Subject: Re: [PATCH 08/19] sched/fair: Introduce per runqueue task LLC
 preference counter
Message-ID: <20251015122125.GU3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:45AM -0700, Tim Chen wrote:
> Each runqueue is assigned a static array where each element tracks
> the number of tasks preferring a given LLC, indexed from 0 to
> NR_LLCS.
> 
> For example, rq->nr_pref_llc[3] = 2 signifies that there are 2 tasks on
> this runqueue which prefer to run within LLC3 (indexed from 0 to NR_LLCS
> 
> The load balancer can use this information to identify busy runqueues
> and migrate tasks to their preferred LLC domains.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c  | 35 +++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fd315937c0cf..b7a68fe7601b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1235,22 +1235,51 @@ static inline int llc_idx(int cpu)
>  	return per_cpu(sd_llc_idx, cpu);
>  }
>  
> +static inline int pref_llc_idx(struct task_struct *p)
> +{
> +	return llc_idx(p->preferred_llc);
> +}
> +
>  static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
>  {
> +	int pref_llc;
> +
>  	if (!sched_cache_enabled())
>  		return;
>  
>  	rq->nr_llc_running += (p->preferred_llc != -1);
>  	rq->nr_pref_llc_running += (p->preferred_llc == task_llc(p));
> +
> +	if (p->preferred_llc < 0)
> +		return;
> +
> +	pref_llc = pref_llc_idx(p);
> +	if (pref_llc < 0)
> +		return;
> +
> +	++rq->nr_pref_llc[pref_llc];
>  }
>  
>  static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
>  {
> +	int pref_llc;
> +
>  	if (!sched_cache_enabled())
>  		return;
>  
>  	rq->nr_llc_running -= (p->preferred_llc != -1);
>  	rq->nr_pref_llc_running -= (p->preferred_llc == task_llc(p));
> +
> +	if (p->preferred_llc < 0)
> +		return;
> +
> +	pref_llc = pref_llc_idx(p);
> +	if (pref_llc < 0)
> +		return;
> +
> +	/* avoid negative counter */
> +	if (rq->nr_pref_llc[pref_llc] > 0)
> +		--rq->nr_pref_llc[pref_llc];

How!? Also, please use post increment/decrement operators.

>  }
>  
>  void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
> @@ -1524,10 +1553,16 @@ void init_sched_mm(struct task_struct *p)
>  
>  void reset_llc_stats(struct rq *rq)
>  {
> +	int i = 0;
> +
>  	if (!sched_cache_enabled())
>  		return;
>  
>  	rq->nr_llc_running = 0;
> +
> +	for (i = 0; i < max_llcs; ++i)
> +		rq->nr_pref_llc[i] = 0;
> +
>  	rq->nr_pref_llc_running = 0;
>  }

Still don't understand why this thing exists..

>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3ab64067acc6..b801d32d5fba 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1101,6 +1101,7 @@ struct rq {
>  #ifdef CONFIG_SCHED_CACHE
>  	unsigned int		nr_pref_llc_running;
>  	unsigned int		nr_llc_running;
> +	unsigned int		nr_pref_llc[NR_LLCS];

Gah, yeah, lets not do this. Just (re)alloc the thing on topology
changes or something.

