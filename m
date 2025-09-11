Return-Path: <linux-kernel+bounces-812839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B31B53D61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702A85A127E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6162D7DD0;
	Thu, 11 Sep 2025 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qug/gIkC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13502D8766
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624278; cv=none; b=qy2jh4uZUMET+URFyoGW0uc0ODmg+Aoh+6XWken3q4zB7ksrj+68cs7CSu5ni8kH9Hz+2UzgYUBOcBOB0emMHPFU/eJuHEtdrz90orJGnVrLrMEPFP4W6obWijWfZ0nadPIv43IrYNvsC31Ltzv5XmsOUEKYWWFu7n/xdNU0Pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624278; c=relaxed/simple;
	bh=9VvYJkZYj6l5r+0ST54pqMLM5pkH4YN7ohKxzk/OKUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjzbWpMHgBnafjxXbi8/Tsgb9i2qSJHh3SQQ5ie2BNr3VWWoiHuj8SZviyzLBV5GrX+M6NL4aXA8V5E7p2HArgslcw5RysEJPzQw4DD5H9FQhFfN50HvnWJfhENPBpXSl0GRpHuAhy+thwHJEpu3kWxX50u93nUTN6eKzD3bY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qug/gIkC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757624275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8m4tgFWpq6J7yjYQG87SzIic0OCdLqnmx4Hw3+qQE8=;
	b=Qug/gIkC/2ctlQKo94Jottk/ZRXLgrWzDDRBRjBkMC6iliLK/Jo38JQbJHl+3G2mEy0enC
	R4pmt1hPXaAdH5u96/BOY1yJw+wT4RLZo6m32iaJSNYOAskVQg5mw1FTa7KQ7vSMh3nJr9
	tU00PU8SrxIc1Erbj4iSc79h3d0CinM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-MpQpILmZO22vhTzWXm6KbA-1; Thu,
 11 Sep 2025 16:57:52 -0400
X-MC-Unique: MpQpILmZO22vhTzWXm6KbA-1
X-Mimecast-MFC-AGG-ID: MpQpILmZO22vhTzWXm6KbA_1757624270
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B5571953949;
	Thu, 11 Sep 2025 20:57:50 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBC7C300021A;
	Thu, 11 Sep 2025 20:57:47 +0000 (UTC)
Date: Thu, 11 Sep 2025 16:57:45 -0400
From: Phil Auld <pauld@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 01/33] sched/isolation: Remove housekeeping static key
Message-ID: <20250911205745.GA7235@pauld.westford.csb>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829154814.47015-2-frederic@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Aug 29, 2025 at 05:47:42PM +0200 Frederic Weisbecker wrote:
> The housekeeping static key in its current use is mostly irrelevant.
> Most of the time, a housekeeping function call had already been issued
> before the static call got a chance to be evaluated, defeating the
> initial call optimization purpose.
> 
> housekeeping_cpu() is the sole correct user performing the static call
> before the actual slow-path function call. But it's seldom used in
> fast-path.
> 
> Finally the static call prevents from synchronizing correctly against
> dynamic updates of the housekeeping cpumasks through cpusets.
> 
> Get away with a simple flag test instead.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

This makes sense and LGTM,

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

> ---
>  include/linux/sched/isolation.h | 25 +++++----
>  kernel/sched/isolation.c        | 90 ++++++++++++++-------------------
>  2 files changed, 55 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..f98ba0d71c52 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -25,12 +25,22 @@ enum hk_type {
>  };
>  
>  #ifdef CONFIG_CPU_ISOLATION
> -DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
> +extern unsigned long housekeeping_flags;
> +
>  extern int housekeeping_any_cpu(enum hk_type type);
>  extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>  extern bool housekeeping_enabled(enum hk_type type);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +
> +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> +{
> +	if (housekeeping_flags & BIT(type))
> +		return housekeeping_test_cpu(cpu, type);
> +	else
> +		return true;
> +}
> +
>  extern void __init housekeeping_init(void);
>  
>  #else
> @@ -58,17 +68,14 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  	return true;
>  }
>  
> +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> +{
> +	return true;
> +}
> +
>  static inline void housekeeping_init(void) { }
>  #endif /* CONFIG_CPU_ISOLATION */
>  
> -static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> -{
> -#ifdef CONFIG_CPU_ISOLATION
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		return housekeeping_test_cpu(cpu, type);
> -#endif
> -	return true;
> -}
>  
>  static inline bool cpu_is_isolated(int cpu)
>  {
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index a4cf17b1fab0..2a6fc6fc46fb 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -16,19 +16,13 @@ enum hk_flags {
>  	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
>  };
>  
> -DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
> -EXPORT_SYMBOL_GPL(housekeeping_overridden);
> -
> -struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> -	unsigned long flags;
> -};
> -
> -static struct housekeeping housekeeping;
> +static cpumask_var_t housekeeping_cpumasks[HK_TYPE_MAX];
> +unsigned long housekeeping_flags;
> +EXPORT_SYMBOL_GPL(housekeeping_flags);
>  
>  bool housekeeping_enabled(enum hk_type type)
>  {
> -	return !!(housekeeping.flags & BIT(type));
> +	return !!(housekeeping_flags & BIT(type));
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_enabled);
>  
> @@ -36,50 +30,46 @@ int housekeeping_any_cpu(enum hk_type type)
>  {
>  	int cpu;
>  
> -	if (static_branch_unlikely(&housekeeping_overridden)) {
> -		if (housekeeping.flags & BIT(type)) {
> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
> -			if (cpu < nr_cpu_ids)
> -				return cpu;
> +	if (housekeeping_flags & BIT(type)) {
> +		cpu = sched_numa_find_closest(housekeeping_cpumasks[type], smp_processor_id());
> +		if (cpu < nr_cpu_ids)
> +			return cpu;
>  
> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> -			if (likely(cpu < nr_cpu_ids))
> -				return cpu;
> -			/*
> -			 * Unless we have another problem this can only happen
> -			 * at boot time before start_secondary() brings the 1st
> -			 * housekeeping CPU up.
> -			 */
> -			WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
> -				     type != HK_TYPE_TIMER);
> -		}
> +		cpu = cpumask_any_and_distribute(housekeeping_cpumasks[type], cpu_online_mask);
> +		if (likely(cpu < nr_cpu_ids))
> +			return cpu;
> +		/*
> +		 * Unless we have another problem this can only happen
> +		 * at boot time before start_secondary() brings the 1st
> +		 * housekeeping CPU up.
> +		 */
> +		WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
> +			     type != HK_TYPE_TIMER);
>  	}
> +
>  	return smp_processor_id();
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>  
>  const struct cpumask *housekeeping_cpumask(enum hk_type type)
>  {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return housekeeping.cpumasks[type];
> +	if (housekeeping_flags & BIT(type))
> +		return housekeeping_cpumasks[type];
>  	return cpu_possible_mask;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>  
>  void housekeeping_affine(struct task_struct *t, enum hk_type type)
>  {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
> +	if (housekeeping_flags & BIT(type))
> +		set_cpus_allowed_ptr(t, housekeeping_cpumasks[type]);
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_affine);
>  
>  bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> +	if (housekeeping_flags & BIT(type))
> +		return cpumask_test_cpu(cpu, housekeeping_cpumasks[type]);
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> @@ -88,17 +78,15 @@ void __init housekeeping_init(void)
>  {
>  	enum hk_type type;
>  
> -	if (!housekeeping.flags)
> +	if (!housekeeping_flags)
>  		return;
>  
> -	static_branch_enable(&housekeeping_overridden);
> -
> -	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
> +	if (housekeeping_flags & HK_FLAG_KERNEL_NOISE)
>  		sched_tick_offload_init();
>  
> -	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
> +	for_each_set_bit(type, &housekeeping_flags, HK_TYPE_MAX) {
>  		/* We need at least one CPU to handle housekeeping work */
> -		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
> +		WARN_ON_ONCE(cpumask_empty(housekeeping_cpumasks[type]));
>  	}
>  }
>  
> @@ -106,8 +94,8 @@ static void __init housekeeping_setup_type(enum hk_type type,
>  					   cpumask_var_t housekeeping_staging)
>  {
>  
> -	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
> -	cpumask_copy(housekeeping.cpumasks[type],
> +	alloc_bootmem_cpumask_var(&housekeeping_cpumasks[type]);
> +	cpumask_copy(housekeeping_cpumasks[type],
>  		     housekeeping_staging);
>  }
>  
> @@ -117,7 +105,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  	unsigned int first_cpu;
>  	int err = 0;
>  
> -	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
> +	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping_flags & HK_FLAG_KERNEL_NOISE)) {
>  		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
>  			pr_warn("Housekeeping: nohz unsupported."
>  				" Build with CONFIG_NO_HZ_FULL\n");
> @@ -139,7 +127,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
>  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
>  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
> -		if (!housekeeping.flags) {
> +		if (!housekeeping_flags) {
>  			pr_warn("Housekeeping: must include one present CPU, "
>  				"using boot CPU:%d\n", smp_processor_id());
>  		}
> @@ -148,7 +136,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  	if (cpumask_empty(non_housekeeping_mask))
>  		goto free_housekeeping_staging;
>  
> -	if (!housekeeping.flags) {
> +	if (!housekeeping_flags) {
>  		/* First setup call ("nohz_full=" or "isolcpus=") */
>  		enum hk_type type;
>  
> @@ -157,26 +145,26 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  	} else {
>  		/* Second setup call ("nohz_full=" after "isolcpus=" or the reverse) */
>  		enum hk_type type;
> -		unsigned long iter_flags = flags & housekeeping.flags;
> +		unsigned long iter_flags = flags & housekeeping_flags;
>  
>  		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
>  			if (!cpumask_equal(housekeeping_staging,
> -					   housekeeping.cpumasks[type])) {
> +					   housekeeping_cpumasks[type])) {
>  				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
>  				goto free_housekeeping_staging;
>  			}
>  		}
>  
> -		iter_flags = flags & ~housekeeping.flags;
> +		iter_flags = flags & ~housekeeping_flags;
>  
>  		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
>  			housekeeping_setup_type(type, housekeeping_staging);
>  	}
>  
> -	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE))
> +	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping_flags & HK_FLAG_KERNEL_NOISE))
>  		tick_nohz_full_setup(non_housekeeping_mask);
>  
> -	housekeeping.flags |= flags;
> +	housekeeping_flags |= flags;
>  	err = 1;
>  
>  free_housekeeping_staging:
> -- 
> 2.51.0
> 
> 

-- 


