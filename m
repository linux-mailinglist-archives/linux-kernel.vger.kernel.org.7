Return-Path: <linux-kernel+bounces-792464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2817B3C445
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3420886D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2F23507E;
	Fri, 29 Aug 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd8MZezi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF701DB122
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503305; cv=none; b=oZfi4GpM6jlbEZxQW8DVzOcEzXH7Prqs3D2ADTZ2QH+8DtUCgYluz6/TLb8xe9N2s+e/qRUOuUz/0SqGosaVlpeN+me5tv74hKXf3ptspObM68d0ZSpV0SDigjj6hCH2S7XYBm9GwW+FsLGxuC7Rtj/eTZacJcqsbIPuzhH3u9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503305; c=relaxed/simple;
	bh=roFz4ZuLDmirFulDL4AIGpF1rFuSNApW1DEEsnehi8U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X7gkPUYxouGNknPnAke0h7DMPX5OF8+q5trXuAwt0VtV31y+xmkOkLWLblzgbg2b5oA2yErkYA7iX3Du1+ymSEiKja3S8SpUsvvhMZf5cU8Fm6yUohq6lffS5oAdoNdWbAnaNBizJi067Kos1uzqE26w5by7JwuB+g3HqrLyGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vd8MZezi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756503299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTcvGVz+c+BZ22iWgYfaSBZU9PEwbeRjL1TXojS0EB0=;
	b=Vd8MZezikZCdAv7ejHwm7RRgP4fEMka+Y4JB6Zo0gptOtIsWGtirvOvZEPKIYdWrOV4lcy
	EaiY3K6EF/b/83zPiJxu5WMShSsgPbC6DUT3smlPCVKFIy8s46u5ehwZWAvEUBHh89cbGm
	RRgO8YuSxAIGXaMb7nYnA1PpLAOD6Go=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hgq8_6DgNCSrvKirCPEElQ-1; Fri, 29 Aug 2025 17:34:58 -0400
X-MC-Unique: hgq8_6DgNCSrvKirCPEElQ-1
X-Mimecast-MFC-AGG-ID: hgq8_6DgNCSrvKirCPEElQ_1756503298
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70dfcc589d8so37837166d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756503298; x=1757108098;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTcvGVz+c+BZ22iWgYfaSBZU9PEwbeRjL1TXojS0EB0=;
        b=j4EIOJupQL5yzncawYOELhVjBxsiCB6hGVXE8F938tYd7JjyCCLX2TAzFHNM6XWoJc
         /KQzbxpkyqp1nS3BZuh+rJCe6mOdP1LWzCrpeqmGOB4FjZoeVC6ricbomggGl1H7PIH3
         x2y7AbahBdipZ70GLS6e8QHeilRJyG++M3W1tkFzeevka4c2B+Vx9ebnaHDl5nFEsix3
         xjotWHeibQuHzIvS6oLwA6nj/kd+GwGdxKIV/LG5pU4m60M34HuiaZ5Xu+SzkW3zLIkF
         kGQ5b+E3aVl4ytzsd/HFm8t/PQLoQFV853z7ARuaMw3uaBO5VC2P/Vnq9fobK0rSi3yq
         oe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf0HpXQjusRW2CEAkoCL5lqjrZA25PRbJ2+fNgp8XHQOx/3+A3ByWeRlShEJI27GgeuEH1yDOcOuWzXjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQypyxmuLungtirlaPgTuyR3mK8lj5udp9se5JIHf5dbyLwlS
	BLdJQqw+ySSyyiGyMZ6hRZ9d3PnFPreVCwXJuHDCXp6S5KYNht0r5q78YKX4XXS3b9yHtvwEICo
	0YCrfawUL9XOItKXNIjFT1W9MXOU+ZHwEM3fUcQ4jAGXHbe4w6FfS0f/h3aqmfrbeCw==
X-Gm-Gg: ASbGnct2X16L4eDiLTb2NA+chkiRrGueWBTYf1EvWX32LBZ54MYeiuppDzq84A0SrR2
	DMIUpuHPxi2ly2R+dTonGyothKrIew4cLp/XLET83y6FfMDoTpgXyvgAC8VH1X0voUpvnBEL+RK
	UWB3cwaMoK8qy6vX5MsEC9SV6vLG6WHtomKwc9J8cT/JtXtWb31NKGFY13VOMYidN3ChtGzLLht
	7YwWckLDVtY1I2XZcirPy7ezliKUhl6AfIm/6FBmAULVTsUIxs4uFjxLReZ78v8gQjKe+iCLbt1
	npQ4ydALm1UNZapDWRxrXcOWW8oF0NBoWPeCuoKyVEzwcidsXjFbSeQfp+nWjiABurcl6FEipox
	aeQevOO3qLg==
X-Received: by 2002:a05:6214:5182:b0:70d:aa75:cba with SMTP id 6a1803df08f44-70fac8ee421mr1097436d6.47.1756503297585;
        Fri, 29 Aug 2025 14:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFszh84jjd7G3hgs9MHqS33h+UlV/GrcZRSKJ+2YqY3AD4g2EhK9GshwTbNCwH8G6KHPw8vqw==
X-Received: by 2002:a05:6214:5182:b0:70d:aa75:cba with SMTP id 6a1803df08f44-70fac8ee421mr1097266d6.47.1756503297148;
        Fri, 29 Aug 2025 14:34:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e57ddd6e8sm23578716d6.2.2025.08.29.14.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 14:34:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ef2547bb-4463-48a1-a378-2a763e271fed@redhat.com>
Date: Fri, 29 Aug 2025 17:34:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] sched/isolation: Remove housekeeping static key
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-2-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-2-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
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
> ---
>   include/linux/sched/isolation.h | 25 +++++----
>   kernel/sched/isolation.c        | 90 ++++++++++++++-------------------
>   2 files changed, 55 insertions(+), 60 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..f98ba0d71c52 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -25,12 +25,22 @@ enum hk_type {
>   };
>   
>   #ifdef CONFIG_CPU_ISOLATION
> -DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
> +extern unsigned long housekeeping_flags;
> +
>   extern int housekeeping_any_cpu(enum hk_type type);
>   extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>   extern bool housekeeping_enabled(enum hk_type type);
>   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +
> +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> +{
> +	if (housekeeping_flags & BIT(type))
> +		return housekeeping_test_cpu(cpu, type);
> +	else
> +		return true;
> +}
> +
>   extern void __init housekeeping_init(void);
>   
>   #else
> @@ -58,17 +68,14 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   	return true;
>   }
>   
> +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> +{
> +	return true;
> +}
> +
>   static inline void housekeeping_init(void) { }
>   #endif /* CONFIG_CPU_ISOLATION */
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
>   static inline bool cpu_is_isolated(int cpu)
>   {
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index a4cf17b1fab0..2a6fc6fc46fb 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -16,19 +16,13 @@ enum hk_flags {
>   	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
>   };
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

Should we add the__read_mostly attribute to housekeeping_flags to 
prevent possible false cacheline sharing problem?

Other than that, LGTM

Cheers,
Longman

> +EXPORT_SYMBOL_GPL(housekeeping_flags);
>   
>   bool housekeeping_enabled(enum hk_type type)
>   {
> -	return !!(housekeeping.flags & BIT(type));
> +	return !!(housekeeping_flags & BIT(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> @@ -36,50 +30,46 @@ int housekeeping_any_cpu(enum hk_type type)
>   {
>   	int cpu;
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
>   	}
> +
>   	return smp_processor_id();
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>   
>   const struct cpumask *housekeeping_cpumask(enum hk_type type)
>   {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return housekeeping.cpumasks[type];
> +	if (housekeeping_flags & BIT(type))
> +		return housekeeping_cpumasks[type];
>   	return cpu_possible_mask;
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>   
>   void housekeeping_affine(struct task_struct *t, enum hk_type type)
>   {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
> +	if (housekeeping_flags & BIT(type))
> +		set_cpus_allowed_ptr(t, housekeeping_cpumasks[type]);
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> +	if (housekeeping_flags & BIT(type))
> +		return cpumask_test_cpu(cpu, housekeeping_cpumasks[type]);
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> @@ -88,17 +78,15 @@ void __init housekeeping_init(void)
>   {
>   	enum hk_type type;
>   
> -	if (!housekeeping.flags)
> +	if (!housekeeping_flags)
>   		return;
>   
> -	static_branch_enable(&housekeeping_overridden);
> -
> -	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
> +	if (housekeeping_flags & HK_FLAG_KERNEL_NOISE)
>   		sched_tick_offload_init();
>   
> -	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
> +	for_each_set_bit(type, &housekeeping_flags, HK_TYPE_MAX) {
>   		/* We need at least one CPU to handle housekeeping work */
> -		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
> +		WARN_ON_ONCE(cpumask_empty(housekeeping_cpumasks[type]));
>   	}
>   }
>   
> @@ -106,8 +94,8 @@ static void __init housekeeping_setup_type(enum hk_type type,
>   					   cpumask_var_t housekeeping_staging)
>   {
>   
> -	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
> -	cpumask_copy(housekeeping.cpumasks[type],
> +	alloc_bootmem_cpumask_var(&housekeeping_cpumasks[type]);
> +	cpumask_copy(housekeeping_cpumasks[type],
>   		     housekeeping_staging);
>   }
>   
> @@ -117,7 +105,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>   	unsigned int first_cpu;
>   	int err = 0;
>   
> -	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
> +	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping_flags & HK_FLAG_KERNEL_NOISE)) {
>   		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
>   			pr_warn("Housekeeping: nohz unsupported."
>   				" Build with CONFIG_NO_HZ_FULL\n");
> @@ -139,7 +127,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>   	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
>   		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
>   		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
> -		if (!housekeeping.flags) {
> +		if (!housekeeping_flags) {
>   			pr_warn("Housekeeping: must include one present CPU, "
>   				"using boot CPU:%d\n", smp_processor_id());
>   		}
> @@ -148,7 +136,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>   	if (cpumask_empty(non_housekeeping_mask))
>   		goto free_housekeeping_staging;
>   
> -	if (!housekeeping.flags) {
> +	if (!housekeeping_flags) {
>   		/* First setup call ("nohz_full=" or "isolcpus=") */
>   		enum hk_type type;
>   
> @@ -157,26 +145,26 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>   	} else {
>   		/* Second setup call ("nohz_full=" after "isolcpus=" or the reverse) */
>   		enum hk_type type;
> -		unsigned long iter_flags = flags & housekeeping.flags;
> +		unsigned long iter_flags = flags & housekeeping_flags;
>   
>   		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
>   			if (!cpumask_equal(housekeeping_staging,
> -					   housekeeping.cpumasks[type])) {
> +					   housekeeping_cpumasks[type])) {
>   				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
>   				goto free_housekeeping_staging;
>   			}
>   		}
>   
> -		iter_flags = flags & ~housekeeping.flags;
> +		iter_flags = flags & ~housekeeping_flags;
>   
>   		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
>   			housekeeping_setup_type(type, housekeeping_staging);
>   	}
>   
> -	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE))
> +	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping_flags & HK_FLAG_KERNEL_NOISE))
>   		tick_nohz_full_setup(non_housekeeping_mask);
>   
> -	housekeeping.flags |= flags;
> +	housekeeping_flags |= flags;
>   	err = 1;
>   
>   free_housekeeping_staging:


