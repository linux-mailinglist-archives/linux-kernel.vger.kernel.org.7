Return-Path: <linux-kernel+bounces-746590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A5B128A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D687B152D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1001E260A;
	Sat, 26 Jul 2025 03:06:16 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAD1D6188
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753499175; cv=none; b=LRdKxwLcEjz7Wpx9T70qEX2hgNtwZ9tPxum14lv+KkqUQLAKTYXO6NhkerUDz/AbrxHf9yCcgsELrmtD8fJMMToOywp0OdhlnfjFgbFeOgFS60lBencTPCmBKKIHHIAs6BYxQ3wDnYLMqquIm0dNeNl6ClOPTfhul+m5eoWmcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753499175; c=relaxed/simple;
	bh=WuG3wbuV7mc5tu/1SHNTuy46F/6n1n3gu9kMbMFGFEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dDfhCjiJD48XQVkWaTz/x8BsirKYzm4Z5hl3Ts1vdhnc9Zd3RCODrMl5Hn4lMc5JasimnH1MlijEWAuxMfkIpTdCucVAqu5dpvdf4BUkCyA5PrDe8RSk8M+RylgRviFUeXSiYme7916PNdnlBS9yOe3mvO1TTiaWZrtaMPzQHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bpqJQ56x3z2CfvK;
	Sat, 26 Jul 2025 11:01:26 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 18CD4140279;
	Sat, 26 Jul 2025 11:05:38 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Jul
 2025 11:05:37 +0800
Message-ID: <82b7c3e8-2c3e-4a71-9898-446f5d2dd39a@huawei.com>
Date: Sat, 26 Jul 2025 11:05:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: topology: Setup AMU FIE for online CPUs only
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <beata.michalska@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<viresh.kumar@linaro.org>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>
References: <20250725102813.1404322-1-zhenglifeng1@huawei.com>
 <20250725-courageous-myrtle-manatee-b113b5@sudeepholla>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250725-courageous-myrtle-manatee-b113b5@sudeepholla>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/7/25 21:11, Sudeep Holla wrote:
> On Fri, Jul 25, 2025 at 06:28:13PM +0800, Lifeng Zheng wrote:
>> When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
>> only CPU0 will go online. The support AMU flag of CPU0 will be set but the
>> flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
>> when it shares a cpufreq policy with other CPU(s). After that, when other
>> CPUs are finally online and the support AMU flags of them are set, they'll
>> never have a chance to set up AMU FIE, even though they're eligible.
>>
>> To solve this problem, the process of setting up AMU FIE needs to be
>> modified as follows:
>>
>> 1. Set up AMU FIE only for the online CPUs.
>>
>> 2. Try to set up AMU FIE each time a CPU goes online and do the
>> freq_counters_valid() check for all the online CPUs share the same policy.
>> If this check fails, clear scale freq source of these CPUs, in case they
>> use different source of the freq scale.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
> 
> I have no idea what changed from v1->v2 and no link to v1 for me to
> refer to it and check the delta 🙁.

My fault.

Changes in v2:

 - keep init_amu_fie_notifier for setting up AMU FIE when the cpufreq
   policy is being created
 - set up AMU FIE only for online CPUs instead of related_cpus in
   init_amu_fie_callback()
 - check and set all the online CPUs in the same policy when hotplug one
 - clear scale freq source for all the online CPUs in the same policy to
   avoid using different source of the freq scale

---
Discussions of previous version:
v1: https://lore.kernel.org/all/20250607094533.416368-1-zhenglifeng1@huawei.com/

> 
>>  arch/arm64/kernel/topology.c | 49 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 5d07ee85bdae..d578c496d457 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -357,12 +357,15 @@ static void amu_fie_setup(const struct cpumask *cpus)
>>  
>>  	/* We are already set since the last insmod of cpufreq driver */
>>  	if (cpumask_available(amu_fie_cpus) &&
>> -	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
>> +	    cpumask_subset(cpus, amu_fie_cpus))
>>  		return;
>>  
>> -	for_each_cpu(cpu, cpus)
>> -		if (!freq_counters_valid(cpu))
>> +	for_each_cpu(cpu, cpus) {
>> +		if (!freq_counters_valid(cpu)) {
>> +			topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, cpus);
>>  			return;
>> +		}
>> +	}
>>  
>>  	if (!cpumask_available(amu_fie_cpus) &&
>>  	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
>> @@ -385,7 +388,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
>>  	struct cpufreq_policy *policy = data;
>>  
>>  	if (val == CPUFREQ_CREATE_POLICY)
>> -		amu_fie_setup(policy->related_cpus);
>> +		amu_fie_setup(policy->cpus);
>>  
>>  	/*
>>  	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
>> @@ -404,10 +407,46 @@ static struct notifier_block init_amu_fie_notifier = {
>>  	.notifier_call = init_amu_fie_callback,
>>  };
>>  
>> +static int cpuhp_topology_online(unsigned int cpu)
>> +{
>> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
>> +	cpumask_var_t cpus_to_set;
>> +
>> +	if (!zalloc_cpumask_var(&cpus_to_set, GFP_KERNEL))
>> +		return -ENOMEM;
>> +
>> +	cpumask_copy(cpus_to_set, cpumask_of(cpu));
>> +
>> +	policy = cpufreq_cpu_get(cpu);
>> +	if (policy) {
>> +		cpumask_or(cpus_to_set, cpus_to_set, policy->cpus);
>> +		amu_fie_setup(cpus_to_set);
>> +	}
>> +
>> +	free_cpumask_var(cpus_to_set);
> 
> What am I missing here as I don't see the need to for this local
> copy  `cpus_to_set`.
> 
> Why can't you just call
> 	policy = cpufreq_cpu_get(cpu);
> 	if (policy)
> 		amu_fie_setup(cpus_to_set);

As mentioned in the commit log, when hotplug a CPU, the
freq_counters_valid() check should be done for all the online CPUs share
the same policy. Otherwise they may use different source of the freq scale
and cause some problems.

> 
> 
>> +	return 0;
>> +}
>> +
>>  static int __init init_amu_fie(void)
>>  {
>> -	return cpufreq_register_notifier(&init_amu_fie_notifier,
>> +	int ret;
>> +
>> +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
>>  					CPUFREQ_POLICY_NOTIFIER);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +					"arm64/topology:online",
>> +					cpuhp_topology_online,
>> +					NULL);
>> +	if (ret < 0) {
>> +		cpufreq_unregister_notifier(&init_amu_fie_notifier,
>> +					    CPUFREQ_POLICY_NOTIFIER);
>> +		return ret;
>> +	}
>> +
> 
> Why can't you just set up cpuhp_* first and then cpufreq notifier to avoid
> this unregistering ?

If set up cpuhp state first, it should be remove when register notifier
fails. So I think there is no difference which one is called first.



