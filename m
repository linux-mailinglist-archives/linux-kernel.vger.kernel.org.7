Return-Path: <linux-kernel+bounces-828730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E48B954C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C981682AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA23168EA;
	Tue, 23 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtdvfn0W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4738320A1B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620586; cv=none; b=dz3sUjLom4SDXGeF56YMqyAfDubCim42nQ+9WxXZMFnZBTCp26iKGt2bI+mEkVRJTKNfNpzpeZzYvT/LErnbK3ZxP/uvLGQQdM/jqBfpS2JPuKsjAxmgqIGOKoT+Ur6RT5XnTFXVT8ySzeZk1SdrqBPa1jWxFyeXXDOlaRmaq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620586; c=relaxed/simple;
	bh=gWokNwz3211+7i9a8Ok4nVu/7HhmNCFwfkMWyXM6JLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5zIvn/8FWaAiT+rUAMaxWg1ulihYmM+LIiIlrq+ycf6YMr1q3KMNF/4vkSlwqFDgTSqqUepLAFumsH8rJYURqSFlMNCWLEMtTaWNiFkGVyAQSx6L5yhzAXQ11QrYXvo1KMqQlkd85tZCBgJoUVT5eLLWXWAcx0StIMgWZXMS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtdvfn0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308B9C4CEF5;
	Tue, 23 Sep 2025 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620586;
	bh=gWokNwz3211+7i9a8Ok4nVu/7HhmNCFwfkMWyXM6JLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtdvfn0WpOajOmj3ZfSZI6HT1Bf01mf+RluxQVZnhoOf1GLEdPWH/DNeaXZxz+0gl
	 9PzCTwd4bXC2EJkJ4trWwi85K2txKt4OKKYEiLGfkXQQ8z18SlGpZ22jRGYhG+NQwH
	 si7mbRIXl7L6kCEU2phphXeIdqr76fem5rOICRl7DUrbGHftoyl80Veza6Vn7ccDEV
	 w/rp9KagiKzXaqX72vkKkKEqpvZHboq7zWG46RFQTABPeJWqxPgZmAnqt0LmIcmAqJ
	 Ds1GguVndQAd8eTo0G8ZvRcOSpGo6LQE/F6q1+slsNgWI2M+ICwQaAmLTsVj078G/f
	 YDuJe+yiY+RjA==
Date: Tue, 23 Sep 2025 11:43:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 27/33] sched/arm64: Move fallback task cpumask to
 HK_TYPE_DOMAIN
Message-ID: <aNJrp_IDiDXEx6N4@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-28-frederic@kernel.org>
 <26d5ced7-8f35-49b2-b342-c6b55dde9c66@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26d5ced7-8f35-49b2-b342-c6b55dde9c66@redhat.com>

Le Tue, Sep 02, 2025 at 12:43:16PM -0400, Waiman Long a écrit :
> 
> On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> > When none of the allowed CPUs of a task are online, it gets migrated
> > to the fallback cpumask which is all the non nohz_full CPUs.
> > 
> > However just like nohz_full CPUs, domain isolated CPUs don't want to be
> > disturbed by tasks that have lost their CPU affinities.
> > 
> > And since nohz_full rely on domain isolation to work correctly, the
> > housekeeping mask of domain isolated CPUs is always a subset of the
> > housekeeping mask of nohz_full CPUs (there can be CPUs that are domain
> > isolated but not nohz_full, OTOH there can't be nohz_full CPUs that are
> > not domain isolated):
> > 
> > 	HK_TYPE_DOMAIN & HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN
> > 
> > Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
> > tasks and since this cpumask can be modified at runtime, make sure
> > that 32 bits support CPUs on ARM64 mismatched systems are not isolated
> > by cpusets.
> > 
> > CC: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   arch/arm64/kernel/cpufeature.c | 18 ++++++++++++---
> >   include/linux/cpu.h            |  4 ++++
> >   kernel/cgroup/cpuset.c         | 40 +++++++++++++++++++++++-----------
> >   3 files changed, 46 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 9ad065f15f1d..38046489d2ea 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1653,6 +1653,18 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
> >   	return feature_matches(val, entry);
> >   }
> > +/*
> > + * 32 bits support CPUs can't be isolated because tasks may be
> > + * arbitrarily affine to them, defeating the purpose of isolation.
> > + */
> > +bool arch_isolated_cpus_can_update(struct cpumask *new_cpus)
> > +{
> > +	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> > +		return !cpumask_intersects(cpu_32bit_el0_mask, new_cpus);
> > +	else
> > +		return true;
> > +}
> > +
> >   const struct cpumask *system_32bit_el0_cpumask(void)
> >   {
> >   	if (!system_supports_32bit_el0())
> > @@ -1666,7 +1678,7 @@ const struct cpumask *system_32bit_el0_cpumask(void)
> >   const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
> >   {
> > -	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_TICK));
> > +	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_DOMAIN));
> >   }
> >   static int __init parse_32bit_el0_param(char *str)
> > @@ -3963,8 +3975,8 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
> >   	bool cpu_32bit = false;
> >   	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
> > -		if (!housekeeping_cpu(cpu, HK_TYPE_TICK))
> > -			pr_info("Treating adaptive-ticks CPU %u as 64-bit only\n", cpu);
> > +		if (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN))
> > +			pr_info("Treating domain isolated CPU %u as 64-bit only\n", cpu);
> >   		else
> >   			cpu_32bit = true;
> >   	}
> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> > index b91b993f58ee..8bb239080534 100644
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -228,4 +228,8 @@ static inline bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
> >   #define smt_mitigations SMT_MITIGATIONS_OFF
> >   #endif
> > +struct cpumask;
> > +
> > +bool arch_isolated_cpus_can_update(struct cpumask *new_cpus);
> > +
> >   #endif /* _LINUX_CPU_H_ */
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 8260dd699fd8..cf99ea844c1d 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1352,33 +1352,47 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
> >   	return isolcpus_updated;
> >   }
> > +bool __weak arch_isolated_cpus_can_update(struct cpumask *new_cpus)
> > +{
> > +	return true;
> > +}
> > +
> >   /*
> > - * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> > + * isolated_cpus_can_update - check for conflicts against housekeeping and
> > + *                            CPUs capabilities.
> >    * @new_cpus: cpu mask for cpus that are going to be isolated
> > - * Return: true if there is conflict, false otherwise
> > + * Return: true if there no conflict, false otherwise
> >    *
> > - * If nohz_full is enabled and we have isolated CPUs, their combination must
> > - * still leave housekeeping CPUs.
> > + * Check for conflicts:
> > + * - If nohz_full is enabled and there are isolated CPUs, their combination must
> > + *   still leave housekeeping CPUs.
> > + * - Architecture has CPU capabilities incompatible with being isolated
> >    */
> > -static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> > +static bool isolated_cpus_can_update(struct cpumask *new_cpus)
> >   {
> >   	cpumask_var_t full_hk_cpus;
> > -	int res = false;
> > +	bool res;
> > +
> > +	if (!arch_isolated_cpus_can_update(new_cpus))
> > +		return false;
> >   	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> > -		return false;
> > +		return true;
> >   	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> > -		return true;
> > +		return false;
> > +
> > +	res = true;
> >   	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> >   		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> >   	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> >   	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> 
> We should construct the new cpumask by adding new CPUs and removing old ones
> from the existing isolated_cpus and pass it to
> arch_isolated_cpus_can_update() for the checking to be correct.

As for arch_isolated_cpus_can_update(), arm64 only cares about the new
CPUs that are going to be isolated. But perhaps you're referring to the check
above that excludes isolated_cpus while we don't care about the old set?

Thanks.

> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

