Return-Path: <linux-kernel+bounces-577947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0BA728D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 03:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8107A5A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 02:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582B19644B;
	Thu, 27 Mar 2025 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RRSusEWc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30418C345
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743043426; cv=none; b=Q7ubjmj4hmRTXhgNVPzrRzLwZQWu8+m4CPqvh1StDl44kFTFRQvP6M3MOpEHIcYkwgb7MUYQEFHAfpzBvO5u6yd4ionrLTKPidxQ6Vf1vqxXA3G5PxdKWE/16d+f8ftTHxoGixWTTVBwBrvSXMsgSvEJFWokpneANYF19EikuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743043426; c=relaxed/simple;
	bh=7NU2BvhzpdSUdvmsG096jZHXMlMO/ixHEFWhmBO1o/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djmX9suAlARAJ2Muajr6WoW8LsHhLvtK0BDHfAd9NJTej7ZErajlFVLeAzRQbbJobVu5mRGdeC57WJRR0iiQP9BKYMZiDWGy4d1pLqBbWg7ZDRnfWi0Al94frBNm/Z0LdJuV8fpcUwLZ9xmKmDhZwN7gQAXsALFlUbVLkJCqOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RRSusEWc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QKZnpW009100;
	Thu, 27 Mar 2025 02:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=8CNpP9caDTg1SSkehBuR9W2UgT4xvWhvlQHBVz4eSw0=; b=RRSusEWcu85v
	Bl4jnlwCybSUx8nyEbEyegPMNXr5BuOeexAzacPPaBZHC2wPtnSnqAbbPEnd2hjW
	oHRQT5wvmlYmCq9jGrJzBkSQlRybBX2x/UXZZbqKYlOtcBwe579tRc+od7uasjCV
	r1r3P1yjVvYJD5ylrpug29+K3K1fgpDZ+xnQBmcfT+UhI/c6iejVs2lkSQqvXtlg
	WK1n48vgLU/Pzbi7tswFB1/jl+xJ62n4avqeKgpLMKhyIjki3zl8nXQE1FlmelJI
	2ir+NUdypUogSQHR4VX2qkQyYcvNFI8nwpGj8jDcfXQJNAahvMoe83r/Dc6mgedT
	yJMBM+uu3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrrq17y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:43:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52R2f4I4004547;
	Thu, 27 Mar 2025 02:43:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrrq17y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:43:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QM1bj7012262;
	Thu, 27 Mar 2025 02:43:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mbaxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:43:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52R2hGqc27984582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 02:43:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E8D158043;
	Thu, 27 Mar 2025 02:43:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8907058055;
	Thu, 27 Mar 2025 02:43:09 +0000 (GMT)
Received: from [9.43.42.95] (unknown [9.43.42.95])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 02:43:09 +0000 (GMT)
Message-ID: <8f5f01cc-c88d-40e6-bc64-74d0e2093bf3@linux.ibm.com>
Date: Thu, 27 Mar 2025 08:13:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com, tglx@linutronix.de,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
Content-Language: en-US
Reply-To: 20250325120952.GJ36322@noisy.programming.kicks-ass.net
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YuJO8dv7xPmEbYImUT6De63nzBKbSRB_
X-Proofpoint-GUID: MdgYW42U8cwQdNfm1RcfdvLyUejoGekw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270015

Hi Peter,

On 25/03/25 17:39, Peter Zijlstra wrote:
> Hi all,
> 
> One of the many things on the eternal todo list has been finishing the
> below hackery.
> 
> It is an attempt at modelling cache affinity -- and while the patch
> really only targets LLC, it could very well be extended to also apply to
> clusters (L2). Specifically any case of multiple cache domains inside a
> node.
> 
> Anyway, I wrote this about a year ago, and I mentioned this at the
> recent OSPM conf where Gautham and Prateek expressed interest in playing
> with this code.
> 
> So here goes, very rough and largely unproven code ahead :-)
> 
> It applies to current tip/master, but I know it will fail the __percpu
> validation that sits in -next, although that shouldn't be terribly hard
> to fix up.
> 
> As is, it only computes a CPU inside the LLC that has the highest recent
> runtime, this CPU is then used in the wake-up path to steer towards this
> LLC and in task_hot() to limit migrations away from it.
> 
> More elaborate things could be done, notably there is an XXX in there
> somewhere about finding the best LLC inside a NODE (interaction with
> NUMA_BALANCING).

Tested the patch on a 12-core, 96-thread Power10 system using a real-life
workload, DayTrader.

Here is a summary of the runs:

Users | Instances | Throughput vs Base | Avg Resp. Time vs Base
--------------------------------------------------------------
30    | 1        | -25.3%              | +50%
60    | 1        | -25.1%              | +50%
30    | 3        | -22.8%              | +33%

As of now, the patch negatively impacts performance both in terms of
throughput and latency.

I will conduct more extensive testing with both microbenchmarks and
real-life workloads.

Thanks,
Madadi Vineeth Reddy

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/mm_types.h |  44 +++++++
>  include/linux/sched.h    |   4 +
>  init/Kconfig             |   4 +
>  kernel/fork.c            |   5 +
>  kernel/sched/core.c      |  13 +-
>  kernel/sched/fair.c      | 330 ++++++++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h     |   8 ++
>  7 files changed, 388 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6..3ed8dd225eb9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -800,6 +800,12 @@ struct mm_cid {
>  };
>  #endif
>  
> +struct mm_sched {
> +	u64 runtime;
> +	unsigned long epoch;
> +	unsigned long occ;
> +};
> +
>  struct kioctx_table;
>  struct iommu_mm_data;
>  struct mm_struct {
> @@ -890,6 +896,17 @@ struct mm_struct {
>  		 */
>  		raw_spinlock_t cpus_allowed_lock;
>  #endif
> +#ifdef CONFIG_SCHED_CACHE
> +		/*
> +		 * Track per-cpu-per-process occupancy as a proxy for cache residency.
> +		 * See account_mm_sched() and ...
> +		 */
> +		struct mm_sched __percpu *pcpu_sched;
> +		raw_spinlock_t mm_sched_lock;
> +		unsigned long mm_sched_epoch;
> +		int mm_sched_cpu;
> +#endif
> +
>  #ifdef CONFIG_MMU
>  		atomic_long_t pgtables_bytes;	/* size of all page tables */
>  #endif
> @@ -1296,6 +1313,33 @@ static inline unsigned int mm_cid_size(void)
>  static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
>  #endif /* CONFIG_SCHED_MM_CID */
>  
> +#ifdef CONFIG_SCHED_CACHE
> +extern void mm_init_sched(struct mm_struct *mm, struct mm_sched *pcpu_sched);
> +
> +static inline int mm_alloc_sched_noprof(struct mm_struct *mm)
> +{
> +	struct mm_sched *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
> +	if (!pcpu_sched)
> +		return -ENOMEM;
> +
> +	mm_init_sched(mm, pcpu_sched);
> +	return 0;
> +}
> +
> +#define mm_alloc_sched(...)	alloc_hooks(mm_alloc_sched_noprof(__VA_ARGS__))
> +
> +static inline void mm_destroy_sched(struct mm_struct *mm)
> +{
> +	free_percpu(mm->pcpu_sched);
> +	mm->pcpu_sched = NULL;
> +}
> +#else /* !CONFIG_SCHED_CACHE */
> +
> +static inline int mm_alloc_sched(struct mm_struct *mm) { return 0; }
> +static inline void mm_destroy_sched(struct mm_struct *mm) { }
> +
> +#endif /* CONFIG_SCHED_CACHE */
> +
>  struct mmu_gather;
>  extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
>  extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6e5c38718ff5..f8eafe440369 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1379,6 +1379,10 @@ struct task_struct {
>  	unsigned long			numa_pages_migrated;
>  #endif /* CONFIG_NUMA_BALANCING */
>  
> +#ifdef CONFIG_SCHED_CACHE
> +	struct callback_head		cache_work;
> +#endif
> +
>  #ifdef CONFIG_RSEQ
>  	struct rseq __user *rseq;
>  	u32 rseq_len;
> diff --git a/init/Kconfig b/init/Kconfig
> index 681f38ee68db..14b15215318f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -950,6 +950,10 @@ config NUMA_BALANCING
>  
>  	  This system will be inactive on UMA systems.
>  
> +config SCHED_CACHE
> +	bool "Cache aware scheduler"
> +	default y
> +
>  config NUMA_BALANCING_DEFAULT_ENABLED
>  	bool "Automatically enable NUMA aware memory/task placement"
>  	default y
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1b659b07ecd5..bc9d7dbfd980 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1314,6 +1314,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	if (mm_alloc_cid(mm, p))
>  		goto fail_cid;
>  
> +	if (mm_alloc_sched(mm))
> +		goto fail_sched;
> +
>  	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
>  				     NR_MM_COUNTERS))
>  		goto fail_pcpu;
> @@ -1323,6 +1326,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	return mm;
>  
>  fail_pcpu:
> +	mm_destroy_sched(mm);
> +fail_sched:
>  	mm_destroy_cid(mm);
>  fail_cid:
>  	destroy_context(mm);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87540217fc09..649db6ea41ea 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4514,6 +4514,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	p->migration_pending = NULL;
>  #endif
>  	init_sched_mm_cid(p);
> +	init_sched_mm(p);
>  }
>  
>  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> @@ -8505,6 +8506,7 @@ static struct kmem_cache *task_group_cache __ro_after_init;
>  
>  void __init sched_init(void)
>  {
> +	unsigned long now = jiffies;
>  	unsigned long ptr = 0;
>  	int i;
>  
> @@ -8579,7 +8581,7 @@ void __init sched_init(void)
>  		raw_spin_lock_init(&rq->__lock);
>  		rq->nr_running = 0;
>  		rq->calc_load_active = 0;
> -		rq->calc_load_update = jiffies + LOAD_FREQ;
> +		rq->calc_load_update = now + LOAD_FREQ;
>  		init_cfs_rq(&rq->cfs);
>  		init_rt_rq(&rq->rt);
>  		init_dl_rq(&rq->dl);
> @@ -8623,7 +8625,7 @@ void __init sched_init(void)
>  		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
>  		rq->balance_callback = &balance_push_callback;
>  		rq->active_balance = 0;
> -		rq->next_balance = jiffies;
> +		rq->next_balance = now;
>  		rq->push_cpu = 0;
>  		rq->cpu = i;
>  		rq->online = 0;
> @@ -8635,7 +8637,7 @@ void __init sched_init(void)
>  
>  		rq_attach_root(rq, &def_root_domain);
>  #ifdef CONFIG_NO_HZ_COMMON
> -		rq->last_blocked_load_update_tick = jiffies;
> +		rq->last_blocked_load_update_tick = now;
>  		atomic_set(&rq->nohz_flags, 0);
>  
>  		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
> @@ -8660,6 +8662,11 @@ void __init sched_init(void)
>  
>  		rq->core_cookie = 0UL;
>  #endif
> +#ifdef CONFIG_SCHED_CACHE
> +		raw_spin_lock_init(&rq->cpu_epoch_lock);
> +		rq->cpu_epoch_next = now;
> +#endif
> +
>  		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
>  	}
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e43993a4e580..943af076e09c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1166,10 +1166,229 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
>  	return delta_exec;
>  }
>  
> -static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
> +#ifdef CONFIG_SCHED_CACHE
> +
> +/*
> + * XXX numbers come from a place the sun don't shine -- probably wants to be SD
> + * tunable or so.
> + */
> +#define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
> +#define EPOCH_OLD	5		/* 50 ms */
> +
> +void mm_init_sched(struct mm_struct *mm, struct mm_sched *_pcpu_sched)
> +{
> +	unsigned long epoch;
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct mm_sched *pcpu_sched = per_cpu_ptr(_pcpu_sched, i);
> +		struct rq *rq = cpu_rq(i);
> +
> +		pcpu_sched->runtime = 0;
> +		pcpu_sched->epoch = epoch = rq->cpu_epoch;
> +		pcpu_sched->occ = -1;
> +	}
> +
> +	raw_spin_lock_init(&mm->mm_sched_lock);
> +	mm->mm_sched_epoch = epoch;
> +	mm->mm_sched_cpu = -1;
> +
> +	smp_store_release(&mm->pcpu_sched, _pcpu_sched);
> +}
> +
> +/* because why would C be fully specified */
> +static __always_inline void __shr_u64(u64 *val, unsigned int n)
> +{
> +	if (n >= 64) {
> +		*val = 0;
> +		return;
> +	}
> +	*val >>= n;
> +}
> +
> +static inline void __update_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
> +{
> +	lockdep_assert_held(&rq->cpu_epoch_lock);
> +
> +	unsigned long n, now = jiffies;
> +	long delta = now - rq->cpu_epoch_next;
> +
> +	if (delta > 0) {
> +		n = (delta + EPOCH_PERIOD - 1) / EPOCH_PERIOD;
> +		rq->cpu_epoch += n;
> +		rq->cpu_epoch_next += n * EPOCH_PERIOD;
> +		__shr_u64(&rq->cpu_runtime, n);
> +	}
> +
> +	n = rq->cpu_epoch - pcpu_sched->epoch;
> +	if (n) {
> +		pcpu_sched->epoch += n;
> +		__shr_u64(&pcpu_sched->runtime, n);
> +	}
> +}
> +
> +static unsigned long fraction_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
> +{
> +	guard(raw_spinlock_irqsave)(&rq->cpu_epoch_lock);
> +
> +	__update_mm_sched(rq, pcpu_sched);
> +
> +	/*
> +	 * Runtime is a geometric series (r=0.5) and as such will sum to twice
> +	 * the accumulation period, this means the multiplcation here should
> +	 * not overflow.
> +	 */
> +	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
> +}
> +
> +static inline
> +void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
> +{
> +	struct mm_struct *mm = p->mm;
> +	struct mm_sched *pcpu_sched;
> +	unsigned long epoch;
> +
> +	/*
> +	 * init_task and kthreads don't be having no mm
> +	 */
> +	if (!mm || !mm->pcpu_sched)
> +		return;
> +
> +	pcpu_sched = this_cpu_ptr(p->mm->pcpu_sched);
> +
> +	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
> +		__update_mm_sched(rq, pcpu_sched);
> +		pcpu_sched->runtime += delta_exec;
> +		rq->cpu_runtime += delta_exec;
> +		epoch = rq->cpu_epoch;
> +	}
> +
> +	/*
> +	 * If this task hasn't hit task_cache_work() for a while, invalidate
> +	 * it's preferred state.
> +	 */
> +	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD) {
> +		mm->mm_sched_cpu = -1;
> +		pcpu_sched->occ = -1;
> +	}
> +}
> +
> +static void task_tick_cache(struct rq *rq, struct task_struct *p)
> +{
> +	struct callback_head *work = &p->cache_work;
> +	struct mm_struct *mm = p->mm;
> +
> +	if (!mm || !mm->pcpu_sched)
> +		return;
> +
> +	if (mm->mm_sched_epoch == rq->cpu_epoch)
> +		return;
> +
> +	guard(raw_spinlock)(&mm->mm_sched_lock);
> +
> +	if (mm->mm_sched_epoch == rq->cpu_epoch)
> +		return;
> +
> +	if (work->next == work) {
> +		task_work_add(p, work, TWA_RESUME);
> +		WRITE_ONCE(mm->mm_sched_epoch, rq->cpu_epoch);
> +	}
> +}
> +
> +static void task_cache_work(struct callback_head *work)
> +{
> +	struct task_struct *p = current;
> +	struct mm_struct *mm = p->mm;
> +	unsigned long m_a_occ = 0;
> +	int cpu, m_a_cpu = -1;
> +	cpumask_var_t cpus;
> +
> +	WARN_ON_ONCE(work != &p->cache_work);
> +
> +	work->next = work;
> +
> +	if (p->flags & PF_EXITING)
> +		return;
> +
> +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> +		return;
> +
> +	scoped_guard (cpus_read_lock) {
> +		cpumask_copy(cpus, cpu_online_mask);
> +
> +		for_each_cpu(cpu, cpus) {
> +			/* XXX sched_cluster_active */
> +			struct sched_domain *sd = per_cpu(sd_llc, cpu);
> +			unsigned long occ, m_occ = 0, a_occ = 0;
> +			int m_cpu = -1, nr = 0, i;
> +
> +			for_each_cpu(i, sched_domain_span(sd)) {
> +				occ = fraction_mm_sched(cpu_rq(i),
> +							per_cpu_ptr(mm->pcpu_sched, i));
> +				a_occ += occ;
> +				if (occ > m_occ) {
> +					m_occ = occ;
> +					m_cpu = i;
> +				}
> +				nr++;
> +				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
> +					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
> +			}
> +
> +			a_occ /= nr;
> +			if (a_occ > m_a_occ) {
> +				m_a_occ = a_occ;
> +				m_a_cpu = m_cpu;
> +			}
> +
> +			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
> +				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
> +
> +			for_each_cpu(i, sched_domain_span(sd)) {
> +				/* XXX threshold ? */
> +				per_cpu_ptr(mm->pcpu_sched, i)->occ = a_occ;
> +			}
> +
> +			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> +		}
> +	}
> +
> +	/*
> +	 * If the max average cache occupancy is 'small' we don't care.
> +	 */
> +	if (m_a_occ < (NICE_0_LOAD >> EPOCH_OLD))
> +		m_a_cpu = -1;
> +
> +	mm->mm_sched_cpu = m_a_cpu;
> +
> +	free_cpumask_var(cpus);
> +}
> +
> +void init_sched_mm(struct task_struct *p)
> +{
> +	struct callback_head *work = &p->cache_work;
> +	init_task_work(work, task_cache_work);
> +	work->next = work;
> +}
> +
> +#else
> +
> +static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
> +				    s64 delta_exec) { }
> +
> +
> +void init_sched_mm(struct task_struct *p) { }
> +
> +static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
> +
> +#endif
> +
> +static inline
> +void update_curr_task(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  {
>  	trace_sched_stat_runtime(p, delta_exec);
>  	account_group_exec_runtime(p, delta_exec);
> +	account_mm_sched(rq, p, delta_exec);
>  	cgroup_account_cputime(p, delta_exec);
>  }
>  
> @@ -1215,7 +1434,7 @@ s64 update_curr_common(struct rq *rq)
>  
>  	delta_exec = update_curr_se(rq, &donor->se);
>  	if (likely(delta_exec > 0))
> -		update_curr_task(donor, delta_exec);
> +		update_curr_task(rq, donor, delta_exec);
>  
>  	return delta_exec;
>  }
> @@ -1244,7 +1463,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  	if (entity_is_task(curr)) {
>  		struct task_struct *p = task_of(curr);
>  
> -		update_curr_task(p, delta_exec);
> +		update_curr_task(rq, p, delta_exec);
>  
>  		/*
>  		 * If the fair_server is active, we need to account for the
> @@ -7850,7 +8069,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 * per-cpu select_rq_mask usage
>  	 */
>  	lockdep_assert_irqs_disabled();
> -
> +again:
>  	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, target))
>  		return target;
> @@ -7888,7 +8107,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	/* Check a recently used CPU as a potential idle candidate: */
>  	recent_used_cpu = p->recent_used_cpu;
>  	p->recent_used_cpu = prev;
> -	if (recent_used_cpu != prev &&
> +	if (prev == p->wake_cpu &&
> +	    recent_used_cpu != prev &&
>  	    recent_used_cpu != target &&
>  	    cpus_share_cache(recent_used_cpu, target) &&
>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> @@ -7941,6 +8161,18 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> +	if (prev != p->wake_cpu && !cpus_share_cache(prev, p->wake_cpu)) {
> +		/*
> +		 * Most likely select_cache_cpu() will have re-directed
> +		 * the wakeup, but getting here means the preferred cache is
> +		 * too busy, so re-try with the actual previous.
> +		 *
> +		 * XXX wake_affine is lost for this pass.
> +		 */
> +		prev = target = p->wake_cpu;
> +		goto again;
> +	}
> +
>  	/*
>  	 * For cluster machines which have lower sharing cache like L2 or
>  	 * LLC Tag, we tend to find an idle CPU in the target's cluster
> @@ -8563,6 +8795,40 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	return target;
>  }
>  
> +#ifdef CONFIG_SCHED_CACHE
> +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle);
> +
> +static int select_cache_cpu(struct task_struct *p, int prev_cpu)
> +{
> +	struct mm_struct *mm = p->mm;
> +	int cpu;
> +
> +	if (!mm || p->nr_cpus_allowed == 1)
> +		return prev_cpu;
> +
> +	cpu = mm->mm_sched_cpu;
> +	if (cpu < 0)
> +		return prev_cpu;
> +
> +
> +	if (static_branch_likely(&sched_numa_balancing) &&
> +	    __migrate_degrades_locality(p, prev_cpu, cpu, false) > 0) {
> +		/*
> +		 * XXX look for max occupancy inside prev_cpu's node
> +		 */
> +		return prev_cpu;
> +	}
> +
> +	return cpu;
> +}
> +#else
> +static int select_cache_cpu(struct task_struct *p, int prev_cpu)
> +{
> +	return prev_cpu;
> +}
> +#endif
> +
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -8588,6 +8854,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	 * required for stable ->cpus_allowed
>  	 */
>  	lockdep_assert_held(&p->pi_lock);
> +	guard(rcu)();
> +
>  	if (wake_flags & WF_TTWU) {
>  		record_wakee(p);
>  
> @@ -8595,6 +8863,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		    cpumask_test_cpu(cpu, p->cpus_ptr))
>  			return cpu;
>  
> +		new_cpu = prev_cpu = select_cache_cpu(p, prev_cpu);
> +
>  		if (!is_rd_overutilized(this_rq()->rd)) {
>  			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>  			if (new_cpu >= 0)
> @@ -8605,7 +8875,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>  	}
>  
> -	rcu_read_lock();
>  	for_each_domain(cpu, tmp) {
>  		/*
>  		 * If both 'cpu' and 'prev_cpu' are part of this domain,
> @@ -8638,7 +8907,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		/* Fast path */
>  		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>  	}
> -	rcu_read_unlock();
>  
>  	return new_cpu;
>  }
> @@ -9288,6 +9556,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  	if (sysctl_sched_migration_cost == 0)
>  		return 0;
>  
> +#ifdef CONFIG_SCHED_CACHE
> +	if (p->mm && p->mm->pcpu_sched) {
> +		/*
> +		 * XXX things like Skylake have non-inclusive L3 and might not
> +		 * like this L3 centric view. What to do about L2 stickyness ?
> +		 */
> +		return per_cpu_ptr(p->mm->pcpu_sched, env->src_cpu)->occ >
> +		       per_cpu_ptr(p->mm->pcpu_sched, env->dst_cpu)->occ;
> +	}
> +#endif
> +
>  	delta = rq_clock_task(env->src_rq) - p->se.exec_start;
>  
>  	return delta < (s64)sysctl_sched_migration_cost;
> @@ -9299,27 +9578,25 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>   * Returns 0, if task migration is not affected by locality.
>   * Returns a negative value, if task migration improves locality i.e migration preferred.
>   */
> -static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
> +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
>  {
>  	struct numa_group *numa_group = rcu_dereference(p->numa_group);
>  	unsigned long src_weight, dst_weight;
>  	int src_nid, dst_nid, dist;
>  
> -	if (!static_branch_likely(&sched_numa_balancing))
> -		return 0;
> -
> -	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
> +	if (!p->numa_faults)
>  		return 0;
>  
> -	src_nid = cpu_to_node(env->src_cpu);
> -	dst_nid = cpu_to_node(env->dst_cpu);
> +	src_nid = cpu_to_node(src_cpu);
> +	dst_nid = cpu_to_node(dst_cpu);
>  
>  	if (src_nid == dst_nid)
>  		return 0;
>  
>  	/* Migrating away from the preferred node is always bad. */
>  	if (src_nid == p->numa_preferred_nid) {
> -		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
> +		struct rq *src_rq = cpu_rq(src_cpu);
> +		if (src_rq->nr_running > src_rq->nr_preferred_running)
>  			return 1;
>  		else
>  			return 0;
> @@ -9330,7 +9607,7 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>  		return -1;
>  
>  	/* Leaving a core idle is often worse than degrading locality. */
> -	if (env->idle == CPU_IDLE)
> +	if (idle)
>  		return 0;
>  
>  	dist = node_distance(src_nid, dst_nid);
> @@ -9345,7 +9622,24 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>  	return src_weight - dst_weight;
>  }
>  
> +static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
> +{
> +	if (!static_branch_likely(&sched_numa_balancing))
> +		return 0;
> +
> +	if (!(env->sd->flags & SD_NUMA))
> +		return 0;
> +
> +	return __migrate_degrades_locality(p, env->src_cpu, env->dst_cpu,
> +					   env->idle == CPU_IDLE);
> +}
> +
>  #else
> +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
> +{
> +	return 0;
> +}
> +
>  static inline long migrate_degrades_locality(struct task_struct *p,
>  					     struct lb_env *env)
>  {
> @@ -13104,8 +13398,8 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
>   */
>  static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  {
> -	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &curr->se;
> +	struct cfs_rq *cfs_rq;
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> @@ -13115,6 +13409,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  	if (static_branch_unlikely(&sched_numa_balancing))
>  		task_tick_numa(rq, curr);
>  
> +	task_tick_cache(rq, curr);
> +
>  	update_misfit_status(curr, rq);
>  	check_update_overutilized_status(task_rq(curr));
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 47972f34ea70..d16ccd66ca07 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1171,6 +1171,12 @@ struct rq {
>  	u64			clock_pelt_idle_copy;
>  	u64			clock_idle_copy;
>  #endif
> +#ifdef CONFIG_SCHED_CACHE
> +	raw_spinlock_t		cpu_epoch_lock;
> +	u64			cpu_runtime;
> +	unsigned long		cpu_epoch;
> +	unsigned long		cpu_epoch_next;
> +#endif
>  
>  	atomic_t		nr_iowait;
>  
> @@ -3861,6 +3867,8 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
>  static inline void init_sched_mm_cid(struct task_struct *t) { }
>  #endif /* !CONFIG_SCHED_MM_CID */
>  
> +extern void init_sched_mm(struct task_struct *p);
> +
>  extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>  extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
>  #ifdef CONFIG_SMP


