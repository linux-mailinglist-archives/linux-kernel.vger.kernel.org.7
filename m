Return-Path: <linux-kernel+bounces-817653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B37B584EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9D61AA165A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379F2773E9;
	Mon, 15 Sep 2025 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmR2/+x5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898D84A3E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962062; cv=none; b=O1woGRNzHOLIZh6hbn1RamLuYDlTKRuERpf98fplU8YKzylFqLB0y9H/XlfuULFLnNY3ACuIBuCEbkKhiyvOhxUGKhtaQb+AJZ5+zAm3icdFYqz2eeLBhf05N0TGW+Yes7PJGOZOQYNaRQhtJLFHMkjlZR/J8euhjVr9MoVkeGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962062; c=relaxed/simple;
	bh=s6VwqVQ+c8+rEHPxJq/easr8mMRoWX33+ZNH1zS9Q2o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FL5edXQQvIH3vPkGu+54gSj5ZEPBdgVPF47rDJAZPfUekthnoALVFTmz+CQOzk3bXO32gZUtxSq2Mg0aJuce9FZzoJWrRj/nQFzf2qpYYX4ncWnbYYi/+aEajcq67nE8EJIHx42WC08o6Vu4iN8wLKqJlszvnBnCoGVCLzieIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmR2/+x5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757962059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZI7f4YMNOAeZxeTy5RiM2JRm5pmLx1biSSJx9+R+1g=;
	b=JmR2/+x5sau2CqXlckERuj4Esa14kZ4kGH7szmOadaS/TTiehio1VH/pwLmKA6BPphCYoC
	1fxiwlqCPb7XTu8jGTkMqOjDNJb1ddPlbZHcxtYgcsNDB3lh/J2I+KQou/ySGCcOBn860E
	9arCk02z/4FSPCmXft9con0Na/tqS1Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-LnqqMjK7OS-VK5bsiz0vJA-1; Mon, 15 Sep 2025 14:47:38 -0400
X-MC-Unique: LnqqMjK7OS-VK5bsiz0vJA-1
X-Mimecast-MFC-AGG-ID: LnqqMjK7OS-VK5bsiz0vJA_1757962057
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7814871b57dso21760736d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962057; x=1758566857;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZI7f4YMNOAeZxeTy5RiM2JRm5pmLx1biSSJx9+R+1g=;
        b=wcrj1PXQ3Xe3NzyhKjfx5Ff+3365L6Rkz8nNa10AELaf0gEnXgpvnhRGOAoAiNRxi8
         WIi2AhwHsf6ngvfmAFYvyoXDCqOyX/BjEQ1BH/SHZOBwfkmZc2eHgDz4zqRhp5FGS0NU
         oWKl/dyByvT7ykC9WXLvy28XpJX5/Xd6gdOKK7qAnJPEpH00+wX8Br5T8cIWDkv1mddI
         PwdLcQl0duO6NgeisUtbDlRWgdk4uO8odv8cbrGiEUJtCDkDFqjZjqmXXq5OknGN+zKW
         6nP9J4ISokX/00mbK2o4HXSWomrCGbyBtF/HlcrUON1JeXTCqAtpVP3QSAfD1htOuODG
         Hv5A==
X-Forwarded-Encrypted: i=1; AJvYcCWs6D8Xn8ps3ae7BlR5JmfVJoHpHMQVGaEoLISEWVZLpgnLsobRqLTzwTbG5qzFgMzzhsSIOcvBltcomRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7Gx2e+Raos0tEXW1EwRa5nSB5PnnBxKzVgDbdkgBU0g+OJCz
	cFLE4xlraMCurPvytiIeX9PVgcHs/u6GqoZ1JRokaCLGNANIBLnACW+zVyG+GjvXka7EmqNIeyA
	E0heTd5hTdqdk/GNQfoljAKpyPIvNsCw7sujTxcvfMbfzoZKHaPNJdJofTJzB8q6zeA==
X-Gm-Gg: ASbGncstNoDCIpYJrZMOFVd3/h5AOJoDMULXUxnVtlyfwKVLs/LF+Q7OXG4TH2bgFFx
	5vxDK1/0LgFm2eM7qIjuirkg1/qufKdwa3YrdVv6UxpmkvL7ZAaPXeGnjw9hq9t3aDh5CJGN7ms
	L5782XC4rGMJAwrg+n4RbPKBFYamY6v7Dfk2QazJ6rkfh3LhsmfT5IDwGtUd7j8WzTOlrYR/4Kg
	N+FqpSwlF1W3w3hnyEIfh4Rc0M5KGfjgoO+j/IIkOK+MsHDRFEfClAs2ih6roR0WLLFaIae8BZP
	eXvt9jV2srBhIItDJC+fYLeIN8QNXFvhCWYkxH2QSZcDmqu3Ldekh94+jTzzYHeALMSy6Q69fdQ
	6nurdAdIjow==
X-Received: by 2002:a05:6214:5d8f:b0:772:45a0:4e28 with SMTP id 6a1803df08f44-77245a04e73mr107521996d6.5.1757962057292;
        Mon, 15 Sep 2025 11:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnG9DDP8M3F19FmwkPZUR0vsROM4QsVFDDaWSbYnuO0aIvhwGSTXKRwMqoSv09x9SszyR1iA==
X-Received: by 2002:a05:6214:5d8f:b0:772:45a0:4e28 with SMTP id 6a1803df08f44-77245a04e73mr107521536d6.5.1757962056671;
        Mon, 15 Sep 2025 11:47:36 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76ea4229bdesm59492186d6.45.2025.09.15.11.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:47:36 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eaae38ba-36ed-4d1b-aefb-10b9a1874845@redhat.com>
Date: Mon, 15 Sep 2025 14:47:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 04/11] cpuset: Refactor exclusive CPU mask
 computation logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-5-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-5-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The current compute_effective_exclusive_cpumask function handles multiple
> scenarios with different input parameters, making the code difficult to
> follow. This patch refactors it into two separate functions:
> compute_excpus and compute_trialcs_excpus.
>
> The compute_excpus function calculates the exclusive CPU mask for a given
> input and excludes exclusive CPUs from sibling cpusets when cs's
> exclusive_cpus is not explicitly set.
>
> The compute_trialcs_excpus function specifically handles exclusive CPU
> computation for trial cpusets used during CPU mask configuration updates,
> and always excludes exclusive CPUs from sibling cpusets.
>
> This refactoring significantly improves code readability and clarity,
> making it explicit which function to call for each use case and what
> parameters should be provided.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 103 ++++++++++++++++++++++++++---------------
>   1 file changed, 65 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a31b05f58e0e..6015322a10ac 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1400,38 +1400,25 @@ bool cpuset_cpu_is_isolated(int cpu)
>   }
>   EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
>   
> -/*
> - * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
> - * @cs: cpuset
> - * @xcpus: effective exclusive CPUs value to be set
> - * @real_cs: the real cpuset (can be NULL)
> - * Return: 0 if there is no sibling conflict, > 0 otherwise
> +/**
> + * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
> + * @parent: Parent cpuset containing all siblings
> + * @cs: Current cpuset (will be skipped)
> + * @excpus:  exclusive effective CPU mask to modify
>    *
> - * If exclusive_cpus isn't explicitly set or a real_cs is provided, we have to
> - * scan the sibling cpusets and exclude their exclusive_cpus or effective_xcpus
> - * as well. The provision of real_cs means that a cpumask is being changed and
> - * the given cs is a trial one.
> + * This function ensures the given @excpus mask doesn't include any CPUs that
> + * are exclusively allocated to sibling cpusets. It walks through all siblings
> + * of @cs under @parent and removes their exclusive CPUs from @excpus.
>    */
> -static int compute_effective_exclusive_cpumask(struct cpuset *cs,
> -					       struct cpumask *xcpus,
> -					       struct cpuset *real_cs)
> +static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
> +					struct cpumask *excpus)
>   {
>   	struct cgroup_subsys_state *css;
> -	struct cpuset *parent = parent_cs(cs);
>   	struct cpuset *sibling;
>   	int retval = 0;
>   
> -	if (!xcpus)
> -		xcpus = cs->effective_xcpus;
> -
> -	cpumask_and(xcpus, user_xcpus(cs), parent->effective_xcpus);
> -
> -	if (!real_cs) {
> -		if (!cpumask_empty(cs->exclusive_cpus))
> -			return 0;
> -	} else {
> -		cs = real_cs;
> -	}
> +	if (cpumask_empty(excpus))
> +		return retval;
>   
>   	/*
>   	 * Exclude exclusive CPUs from siblings
> @@ -1441,20 +1428,60 @@ static int compute_effective_exclusive_cpumask(struct cpuset *cs,
>   		if (sibling == cs)
>   			continue;
>   
> -		if (cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
> -			cpumask_andnot(xcpus, xcpus, sibling->exclusive_cpus);
> +		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
> +			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
>   			retval++;
>   			continue;
>   		}
> -		if (cpumask_intersects(xcpus, sibling->effective_xcpus)) {
> -			cpumask_andnot(xcpus, xcpus, sibling->effective_xcpus);
> +		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
> +			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
>   			retval++;
>   		}
>   	}
>   	rcu_read_unlock();
> +
>   	return retval;
>   }
>   
> +/*
> + * compute_excpus - compute effective exclusive CPUs
> + * @cs: cpuset
> + * @xcpus: effective exclusive CPUs value to be set
> + * Return: 0 if there is no sibling conflict, > 0 otherwise
> + *
> + * If exclusive_cpus isn't explicitly set , we have to scan the sibling cpusets
> + * and exclude their exclusive_cpus or effective_xcpus as well.
> + */
> +static int compute_excpus(struct cpuset *cs, struct cpumask *excpus)
> +{
> +	struct cpuset *parent = parent_cs(cs);
> +
> +	cpumask_and(excpus, user_xcpus(cs), parent->effective_xcpus);
> +
> +	if (!cpumask_empty(cs->exclusive_cpus))
> +		return 0;
> +
> +	return rm_siblings_excl_cpus(parent, cs, excpus);
> +}
> +
> +/*
> + * compute_trialcs_excpus - Compute effective exclusive CPUs for a trial cpuset
> + * @trialcs: The trial cpuset containing the proposed new configuration
> + * @cs: The original cpuset that the trial configuration is based on
> + * Return: 0 if successful with no sibling conflict, >0 if a conflict is found
> + *
> + * Computes the effective_xcpus for a trial configuration. @cs is provided to represent
> + * the real cs.
> + */
> +static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
> +{
> +	struct cpuset *parent = parent_cs(trialcs);
> +	struct cpumask *excpus = trialcs->effective_xcpus;
> +
> +	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +	return rm_siblings_excl_cpus(parent, cs, excpus);
> +}
> +
>   static inline bool is_remote_partition(struct cpuset *cs)
>   {
>   	return !list_empty(&cs->remote_sibling);
> @@ -1496,7 +1523,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	 * Note that creating a remote partition with any local partition root
>   	 * above it or remote partition root underneath it is not allowed.
>   	 */
> -	compute_effective_exclusive_cpumask(cs, tmp->new_cpus, NULL);
> +	compute_excpus(cs, tmp->new_cpus);
>   	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
> @@ -1545,7 +1572,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>   		cs->partition_root_state = PRS_MEMBER;
>   
>   	/* effective_xcpus may need to be changed */
> -	compute_effective_exclusive_cpumask(cs, NULL, NULL);
> +	compute_excpus(cs, cs->effective_xcpus);
>   	reset_partition_data(cs);
>   	spin_unlock_irq(&callback_lock);
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
> @@ -1746,12 +1773,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
>   		/*
> -		 * Need to call compute_effective_exclusive_cpumask() in case
> +		 * Need to call compute_excpus() in case
>   		 * exclusive_cpus not set. Sibling conflict should only happen
>   		 * if exclusive_cpus isn't set.
>   		 */
>   		xcpus = tmp->delmask;
> -		if (compute_effective_exclusive_cpumask(cs, xcpus, NULL))
> +		if (compute_excpus(cs, xcpus))
>   			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
>   
>   		/*
> @@ -2033,7 +2060,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
>   	 *  2) All the effective_cpus will be used up and cp
>   	 *     has tasks
>   	 */
> -	compute_effective_exclusive_cpumask(cs, new_ecpus, NULL);
> +	compute_excpus(cs, new_ecpus);
>   	cpumask_and(new_ecpus, new_ecpus, cpu_active_mask);
>   
>   	rcu_read_lock();
> @@ -2112,7 +2139,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		 * its value is being processed.
>   		 */
>   		if (remote && (cp != cs)) {
> -			compute_effective_exclusive_cpumask(cp, tmp->new_cpus, NULL);
> +			compute_excpus(cp, tmp->new_cpus);
>   			if (cpumask_equal(cp->effective_xcpus, tmp->new_cpus)) {
>   				pos_css = css_rightmost_descendant(pos_css);
>   				continue;
> @@ -2214,7 +2241,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>   		cp->partition_root_state = new_prs;
>   		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
> -			compute_effective_exclusive_cpumask(cp, NULL, NULL);
> +			compute_excpus(cp, cp->effective_xcpus);
>   
>   		/*
>   		 * Make sure effective_xcpus is properly set for a valid
> @@ -2363,7 +2390,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		 * for checking validity of the partition root.
>   		 */
>   		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
> -			compute_effective_exclusive_cpumask(trialcs, NULL, cs);
> +			compute_trialcs_excpus(trialcs, cs);
>   	}
>   
>   	/* Nothing to do if the cpus didn't change */
> @@ -2499,7 +2526,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		 * Reject the change if there is exclusive CPUs conflict with
>   		 * the siblings.
>   		 */
> -		if (compute_effective_exclusive_cpumask(trialcs, NULL, cs))
> +		if (compute_trialcs_excpus(trialcs, cs))
>   			return -EINVAL;
>   	}
>   
Reviewed-by: Waiman Long <longman@redhat.com>


