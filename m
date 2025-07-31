Return-Path: <linux-kernel+bounces-751818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C2B16DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1613AEA42
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4F27F18F;
	Thu, 31 Jul 2025 08:45:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4D929E117
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951504; cv=none; b=Ezfede4pBnLClkqJ96KElwc/O6cYiWXtQQxjJToplJXQX+v9cRYaSxdcGEkPHS5wrGEfTQV236xBtaxgBELqp4sd64NG9g0pbrdLykrBUjxO5lx2lheZBQRFkPQ5RT0V/BL/mQ1oxh1JZW7ZFckrEY6g1Fx/Ck/KMBfkMuoajY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951504; c=relaxed/simple;
	bh=f/cTMyqYb3G5Y2O/ApCO5Z1XTEMCFxXiRSDqg48UXeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TotrZ91la3ymtjLZOpL8pAY6llPCaj5JlUIbeKMJg37cBGlSBMqDO5QzsBHVt44VeHMf1O9fvt1wMa7mWGzB6H+cTOyKnTvErVm2ISo2Kcy2oMpTceD6Rjchjx5BcwRkXbQ6yldpu23NPOGVYIiOsnRnHuhxQv7/dkyutS+fD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD1461D13;
	Thu, 31 Jul 2025 01:44:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453603F673;
	Thu, 31 Jul 2025 01:44:58 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:44:42 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	viresh.kumar@linaro.org, vincent.guittot@linaro.org,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v2] arm64: topology: Setup AMU FIE for online CPUs only
Message-ID: <aIss-syLMXmCBZ7E@arm.com>
References: <20250725102813.1404322-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725102813.1404322-1-zhenglifeng1@huawei.com>

Hi Lifeng,

Apologies for late reply.

On Fri, Jul 25, 2025 at 06:28:13PM +0800, Lifeng Zheng wrote:
> When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
> only CPU0 will go online. The support AMU flag of CPU0 will be set but the
> flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
> when it shares a cpufreq policy with other CPU(s). After that, when other
> CPUs are finally online and the support AMU flags of them are set, they'll
> never have a chance to set up AMU FIE, even though they're eligible.
> 
> To solve this problem, the process of setting up AMU FIE needs to be
> modified as follows:
> 
> 1. Set up AMU FIE only for the online CPUs.
> 
> 2. Try to set up AMU FIE each time a CPU goes online and do the
> freq_counters_valid() check for all the online CPUs share the same policy.
> If this check fails, clear scale freq source of these CPUs, in case they
> use different source of the freq scale.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 49 ++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 5d07ee85bdae..d578c496d457 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -357,12 +357,15 @@ static void amu_fie_setup(const struct cpumask *cpus)
>  
>  	/* We are already set since the last insmod of cpufreq driver */
>  	if (cpumask_available(amu_fie_cpus) &&
> -	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> +	    cpumask_subset(cpus, amu_fie_cpus))
>  		return;
>  
> -	for_each_cpu(cpu, cpus)
> -		if (!freq_counters_valid(cpu))
> +	for_each_cpu(cpu, cpus) {
> +		if (!freq_counters_valid(cpu)) {
> +			topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, cpus);
>  			return;
> +		}
> +	}
>  
>  	if (!cpumask_available(amu_fie_cpus) &&
>  	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> @@ -385,7 +388,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_policy *policy = data;
>  
>  	if (val == CPUFREQ_CREATE_POLICY)
> -		amu_fie_setup(policy->related_cpus);
> +		amu_fie_setup(policy->cpus);
Right, so this will only work for the AMU side of things. The cpufreq core still
considers `related_cpus` which should be aligned (if possible).
>  
>  	/*
>  	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> @@ -404,10 +407,46 @@ static struct notifier_block init_amu_fie_notifier = {
>  	.notifier_call = init_amu_fie_callback,
>  };
>  
> +static int cpuhp_topology_online(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +	cpumask_var_t cpus_to_set;
> +
> +	if (!zalloc_cpumask_var(&cpus_to_set, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cpumask_copy(cpus_to_set, cpumask_of(cpu));
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (policy) {
> +		cpumask_or(cpus_to_set, cpus_to_set, policy->cpus);
This should be available via `amu_fie_cpus` mask (as of subset).
So it should be enough to test only the CPU at hand?
Additionally there is no tracking whether that CPU hasn't been verified already.
> +		amu_fie_setup(cpus_to_set);
> +	}
> +
> +	free_cpumask_var(cpus_to_set);
> +	return 0;
> +}
> +
>  static int __init init_amu_fie(void)
>  {
> -	return cpufreq_register_notifier(&init_amu_fie_notifier,
> +	int ret;
> +
> +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
>  					CPUFREQ_POLICY_NOTIFIER);
> +	if (ret)
> +		return ret;
> +
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"arm64/topology:online",
> +					cpuhp_topology_online,
> +					NULL);
We should check whether we really have to set it up, as of all CPUs are already
online).
> +	if (ret < 0) {
> +		cpufreq_unregister_notifier(&init_amu_fie_notifier,
> +					    CPUFREQ_POLICY_NOTIFIER);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  core_initcall(init_amu_fie);
>  
> -- 
> 2.33.0
> 

