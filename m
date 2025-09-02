Return-Path: <linux-kernel+bounces-797032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EFDB40AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D4A3BD391
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41128341676;
	Tue,  2 Sep 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBY7evZ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93B340D92
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831405; cv=none; b=ANpUxn9slR2FsU+cZwAjgr0MxyrUw/ww0+RemwFxA4zLcIAGpPTUV8HdbXhR/rsCB0YDS+/NEynKFWujMkLHaXfWce8aqpFgdZWrnWyo0IWpG+W9jDBmLm5JVS/cx+/YL+FeTvZA6vgqM79rYPMBdKnt591h0vaFASvUeUZKAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831405; c=relaxed/simple;
	bh=Y5Bhe/iB2uj29ubf74I/iQRrDQ1nJ0KTWSM7GTI3iWk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pFNHQXfjB6ND7epfmlQqQfS/gpfiYYamkqFK/JVqLBcxY+iA7nPX5VPblVZnwXWGb42gnjnkqzjb3SDCG3c/bdo3HBWwmiEWup2Y1ekeXrfIAtm/7m6yaWXUSSyMIAEXI8ZDnj0g2l1mhh29cDBdqMl6/7ehDrrw22C2SsKDo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBY7evZ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756831402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvfyn6DBdkofRFQp6LMMEDWBYjJ0dblUgiw6XYH3Znc=;
	b=JBY7evZ5n3mi2BwGOPf8JA3EQUoeWOI7bvYzcdMTl3Ph1ZttuJs4Z0THjAdBYjEIJPrv7W
	QtkCab4QEj9WQ6gIKkwkUUyYD/fXX84hhbCBJglwt2dlkMQeRgyIJnh13+EcU+5Cg5WfIY
	OhpoJWtrm9pFiGe26TRsT/9/H8Xbth0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-L9D3g0jTO3yMFuTIK3-YZw-1; Tue, 02 Sep 2025 12:43:19 -0400
X-MC-Unique: L9D3g0jTO3yMFuTIK3-YZw-1
X-Mimecast-MFC-AGG-ID: L9D3g0jTO3yMFuTIK3-YZw_1756831399
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-807802c9c85so137276785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831399; x=1757436199;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvfyn6DBdkofRFQp6LMMEDWBYjJ0dblUgiw6XYH3Znc=;
        b=dvzvejGTmYXELceeoqc1SXv6MitDu4JXC7weYKxI5lcAfty/LmtHsWhC4tJKGcL1P3
         iJzj2J+zZMEe6vDusIpglnH/z1E4kp5V8oxC5fQR06riEtkkIzURXGhb1B8BOZ4Wvz3C
         k54UN09MNt4HaCPV+5FD56XEhFd/O9anKiuUjdFeWd8HWpZ2ESpOBXM8vDsMAji3MArp
         5yhpvYlot+aMZnNTy9dZ3NrJYoLq8UPD12J5iVR1UAGvpyqciiV15hZB3h1DYfBP4Rvr
         eIRJB1bnUOor7Wq/ydBZThB90VFwlkOqhLp0wirSVVWVg1abqIrBhaqFwStAlvhUKoyJ
         /m2g==
X-Forwarded-Encrypted: i=1; AJvYcCWzAmpemonAk7HmUW4ppyDIg83GLetCb7Em3DD4Nza8hJ+tm7OYB5NoCNJh/mJ6+LE6njQdaFvPhxN6hYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCY85+SIiqHzfHxMfxZyzxcsYj3YB5/890d/yxjiLfcOEd3q7b
	g/7aJCRkKiGvPRoucqjxto7h9lR2COqDFi8Y4laXisG0OeRWkcaF2LZXnvfuw7wbKht8fLOr9o1
	8G0LbR3rVsmu71bDzc2RVX2ft71vgrCqjaE0QGumkEgRklAJNaMdtzlLGIlFbz+OGJg==
X-Gm-Gg: ASbGnctRIDPptvZRN4IlgCgYjkMaOdVSIxAQSqA9rqPDYNDu+89y+/lgz9cuDpOkQtZ
	3FU/127LnbW01ydro5Oz55jMDh0DpMk54pGBwSPky4fwzPoRHPSd0LTS/AIEPnV5WgeoX0AwMM+
	5wTIyi7GljUV7YFfZNglWITl76ZrQBj3Ggzs6vUuhHo5WC94BYS0N7fV54u6invxaDRLd2vSbFV
	fzmIddVTzcNsFAEo9Cmyx5FLdwQPme+beAvQmScXQ1HQmGbpC7OxqcJrcz/Gx04ERYyEE77LdiL
	1swcgdTakepPFMQr/YquLq7o1/KsLI5QNm+zulVHPtPqUneMJb5ZsQXrjgABhiDQsXsGmHKw90B
	r/HNeVeFgJw==
X-Received: by 2002:a05:620a:a514:b0:7ff:f2ea:d378 with SMTP id af79cd13be357-7fff2ead728mr1082409685a.55.1756831398707;
        Tue, 02 Sep 2025 09:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcNQGG21EPWc7KbxuoRsh58zX+gswADpVu4q9uZmVy9zNC5QU6XK66222B2I6oos/OUuy5fw==
X-Received: by 2002:a05:620a:a514:b0:7ff:f2ea:d378 with SMTP id af79cd13be357-7fff2ead728mr1082404385a.55.1756831398050;
        Tue, 02 Sep 2025 09:43:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069bf68bb5sm158778485a.35.2025.09.02.09.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:43:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <26d5ced7-8f35-49b2-b342-c6b55dde9c66@redhat.com>
Date: Tue, 2 Sep 2025 12:43:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] sched/arm64: Move fallback task cpumask to
 HK_TYPE_DOMAIN
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-28-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-28-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> When none of the allowed CPUs of a task are online, it gets migrated
> to the fallback cpumask which is all the non nohz_full CPUs.
>
> However just like nohz_full CPUs, domain isolated CPUs don't want to be
> disturbed by tasks that have lost their CPU affinities.
>
> And since nohz_full rely on domain isolation to work correctly, the
> housekeeping mask of domain isolated CPUs is always a subset of the
> housekeeping mask of nohz_full CPUs (there can be CPUs that are domain
> isolated but not nohz_full, OTOH there can't be nohz_full CPUs that are
> not domain isolated):
>
> 	HK_TYPE_DOMAIN & HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN
>
> Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
> tasks and since this cpumask can be modified at runtime, make sure
> that 32 bits support CPUs on ARM64 mismatched systems are not isolated
> by cpusets.
>
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   arch/arm64/kernel/cpufeature.c | 18 ++++++++++++---
>   include/linux/cpu.h            |  4 ++++
>   kernel/cgroup/cpuset.c         | 40 +++++++++++++++++++++++-----------
>   3 files changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9ad065f15f1d..38046489d2ea 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1653,6 +1653,18 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
>   	return feature_matches(val, entry);
>   }
>   
> +/*
> + * 32 bits support CPUs can't be isolated because tasks may be
> + * arbitrarily affine to them, defeating the purpose of isolation.
> + */
> +bool arch_isolated_cpus_can_update(struct cpumask *new_cpus)
> +{
> +	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> +		return !cpumask_intersects(cpu_32bit_el0_mask, new_cpus);
> +	else
> +		return true;
> +}
> +
>   const struct cpumask *system_32bit_el0_cpumask(void)
>   {
>   	if (!system_supports_32bit_el0())
> @@ -1666,7 +1678,7 @@ const struct cpumask *system_32bit_el0_cpumask(void)
>   
>   const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
>   {
> -	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_TICK));
> +	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   }
>   
>   static int __init parse_32bit_el0_param(char *str)
> @@ -3963,8 +3975,8 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
>   	bool cpu_32bit = false;
>   
>   	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
> -		if (!housekeeping_cpu(cpu, HK_TYPE_TICK))
> -			pr_info("Treating adaptive-ticks CPU %u as 64-bit only\n", cpu);
> +		if (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN))
> +			pr_info("Treating domain isolated CPU %u as 64-bit only\n", cpu);
>   		else
>   			cpu_32bit = true;
>   	}
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index b91b993f58ee..8bb239080534 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -228,4 +228,8 @@ static inline bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
>   #define smt_mitigations SMT_MITIGATIONS_OFF
>   #endif
>   
> +struct cpumask;
> +
> +bool arch_isolated_cpus_can_update(struct cpumask *new_cpus);
> +
>   #endif /* _LINUX_CPU_H_ */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 8260dd699fd8..cf99ea844c1d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1352,33 +1352,47 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	return isolcpus_updated;
>   }
>   
> +bool __weak arch_isolated_cpus_can_update(struct cpumask *new_cpus)
> +{
> +	return true;
> +}
> +
>   /*
> - * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> + * isolated_cpus_can_update - check for conflicts against housekeeping and
> + *                            CPUs capabilities.
>    * @new_cpus: cpu mask for cpus that are going to be isolated
> - * Return: true if there is conflict, false otherwise
> + * Return: true if there no conflict, false otherwise
>    *
> - * If nohz_full is enabled and we have isolated CPUs, their combination must
> - * still leave housekeeping CPUs.
> + * Check for conflicts:
> + * - If nohz_full is enabled and there are isolated CPUs, their combination must
> + *   still leave housekeeping CPUs.
> + * - Architecture has CPU capabilities incompatible with being isolated
>    */
> -static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> +static bool isolated_cpus_can_update(struct cpumask *new_cpus)
>   {
>   	cpumask_var_t full_hk_cpus;
> -	int res = false;
> +	bool res;
> +
> +	if (!arch_isolated_cpus_can_update(new_cpus))
> +		return false;
>   
>   	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> -		return false;
> +		return true;
>   
>   	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> -		return true;
> +		return false;
> +
> +	res = true;
>   
>   	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>   		    housekeeping_cpumask(HK_TYPE_DOMAIN));
>   	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
>   	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);

We should construct the new cpumask by adding new CPUs and removing old 
ones from the existing isolated_cpus and pass it to 
arch_isolated_cpus_can_update() for the checking to be correct.

Cheers,
Longman


