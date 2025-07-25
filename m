Return-Path: <linux-kernel+bounces-745819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBEB11F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242097A2916
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D372ECD25;
	Fri, 25 Jul 2025 13:11:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE924677A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449092; cv=none; b=UYuo1DfOSGHrukculbZBtR5o8NPOwJIJXoLOKtZJ7XJgPbIDuvMHLSS5h+MDz7qfP8ybmjMJr50KghV7OK7YjMM7GbpGiQKQ9qJlmPCjnpEiGB9voLAzHKceKRCcVbAqUVGNHyXEchQaVtXdBBBAbh96bzaiGePAS+lWDuqv/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449092; c=relaxed/simple;
	bh=8PG3rJqOB7M2ctZ5G9EPBl3zEzvXYL/E/Dg5m10Sf9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b940gAGJA/z+Qvr+bOG9Lp9rtsW2wNyZkQt55XX7b4i8ltqtMGl1t5+wYYOMp+Idl/MGYKGgG4x01MrrC8kcehoL3i8mKY7n+koGfJXjfOM2H7ILglFlu8vS6SDh3FR8E08JHWnZHPx0Cupdew2jMEbE13Qfqu6bau5YQgDJpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AFA6176C;
	Fri, 25 Jul 2025 06:11:23 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2701C3F66E;
	Fri, 25 Jul 2025 06:11:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:11:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <beata.michalska@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <viresh.kumar@linaro.org>,
	<vincent.guittot@linaro.org>, <yangyicong@hisilicon.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>
Subject: Re: [PATCH v2] arm64: topology: Setup AMU FIE for online CPUs only
Message-ID: <20250725-courageous-myrtle-manatee-b113b5@sudeepholla>
References: <20250725102813.1404322-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725102813.1404322-1-zhenglifeng1@huawei.com>

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

I have no idea what changed from v1->v2 and no link to v1 for me to
refer to it and check the delta 🙁.

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
> +		amu_fie_setup(cpus_to_set);
> +	}
> +
> +	free_cpumask_var(cpus_to_set);

What am I missing here as I don't see the need to for this local
copy  `cpus_to_set`.

Why can't you just call
	policy = cpufreq_cpu_get(cpu);
	if (policy)
		amu_fie_setup(cpus_to_set);


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
> +	if (ret < 0) {
> +		cpufreq_unregister_notifier(&init_amu_fie_notifier,
> +					    CPUFREQ_POLICY_NOTIFIER);
> +		return ret;
> +	}
> +

Why can't you just set up cpuhp_* first and then cpufreq notifier to avoid
this unregistering ?

-- 
Regards,
Sudeep

