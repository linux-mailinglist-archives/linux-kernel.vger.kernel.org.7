Return-Path: <linux-kernel+bounces-817654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1152B584F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C768165B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3E2773F4;
	Mon, 15 Sep 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgv4B9sx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F901CAA6C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962153; cv=none; b=OvqB2L6Mi4rZqO8YnZo9bVzid4ASexSedcsm3Wv4J5/+0O5sTTO/rnQpgJZSMrOCJYZkBtL5QasxD60ll6lcUXcnX6EcL+txd3dMr1HVHQrAEWpFfcXtnvJ9Iu573VGMjQ1OZt7bnon87cW6zZE4DqYFUpkYZgPoAGZFF51GsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962153; c=relaxed/simple;
	bh=Ldk2SWPviVFCNNNr0HHMvL5tbmBOCu/heCetnLeh4Ak=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nP5lmAl7Rf0Z+WiiaZHwL8O6fjcOdk9GUQudtXJ3yrfSy9GjT0TKV6IeqhHMcJ9GO+Nd8UW75wB+q6KmYcElN589TNZ6DlIa7NrcmAsqpUZknDD1Vxc5nnGpU/5bdK4VX79TuZ0Q5jCZXPfNb1jyNgNrMEl0iQ2pQRnbBQEZtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hgv4B9sx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757962150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jm8gfVBZ7kTZ29XgGNG8P/V5RcE1ds8Nn8Aqd6J8NeY=;
	b=Hgv4B9sx342j+xXHsyMkF/L8xNbEjR8aAJ6U7M3+MyukGkt2suJczKtaBVrZrEyx7iqftZ
	K6RCoZ3yzdKO88ziz5oLDskSfcfjwC82t7WmBfQQt5knurbVGsK3W6k3IcB4EjbUQLnlzD
	NO//+v5dUYQ3Bi4UBcUr5g03AKgVL2Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-lMsth65ZOT2r-T_YhnLepw-1; Mon, 15 Sep 2025 14:49:08 -0400
X-MC-Unique: lMsth65ZOT2r-T_YhnLepw-1
X-Mimecast-MFC-AGG-ID: lMsth65ZOT2r-T_YhnLepw_1757962148
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-776164a4484so54162316d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962148; x=1758566948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm8gfVBZ7kTZ29XgGNG8P/V5RcE1ds8Nn8Aqd6J8NeY=;
        b=JHzZ3ZCTOiNCGrXUefOmCdHv9unNKu4buOaD6T7bsfl+6AbBTmHV/ecs554Vlib7/q
         RJ9quRSX7zeGjp8Ee0bb8wLpN2qHVR6a9q5rbGBZ0Hn8YxBGAJyFxQcNH4YvDUiTS4N+
         XlsX2e0VodHeaMqp7tvF/kV7/RBTpZtsxIvLrg7y78h3OvN8j4W0mJmhL1S+49n5Dgrh
         ZKIfXZ1NURayoouL50QZNjxrjB6NMq5A8CwY8NLoFCKabaeYFI2wYjz3Mf2UDmRETOsz
         F7r4vwGn+P0jE6IaMugFNgextzSheKVZNqvzjVqb6hzk2tLHzrWhfWujMeR1MoS3okiv
         9XzA==
X-Forwarded-Encrypted: i=1; AJvYcCXmMNSzyOLRyGkG/9T+nUDqf/ONmjywVVw/HTMN3PCWVkgfgLZPtoV6h70zDbBbFvHZtZFpfpWmPd/YrSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyHFt1zzHfVfXToOFIHYZ/jZCpw0I4I6yH7Jxmx+RvogXPDNS
	id1xTnO41bha12sQ1VrQ85ziZq5rlkFcnJgkxnvgQ68CFS11g+xYc8rEj53IfxPjhq5J6wUf6NR
	S11qlzAdNaXDOS2QlPxVvvJA+A1ElKpLa+hQeKsd86chKGgwgN9J6ojDrtVBMEBgbww==
X-Gm-Gg: ASbGncsfrlyJyJgd16DFUrv1kIaqag7jnbwTph9SHVP/ZQAS4dtrgDpBoC6nd7YSj9o
	zn9JSTJvdN9XXdo20qdylS/zISTpYI/td+AelVpsDqC+L7x5wRmqRiPGr0Qm+Kch3zJ5Iwi/XrI
	S1de1ue3r4SFojkRodNHJ6iQ/Ggd42Pt5LSsivG4ZtBg+VXD/F14kkVQvzgDcI4Z42ta9sDR9S+
	flZjpauaUzPk3w+EpGzFFvY8eVF3FLraPa3tPpfnsF8AwAm5PkJFryyMLInqLJ9rhCmer7eil5C
	SXOi8jtTQr1oAzLWJ3vaU8qWA9fMyFxnLioVFEeN/Mtx9pR/G9WqrCl6HOzutF73jHCWvu6/kSs
	6oztHh05ExA==
X-Received: by 2002:ad4:5ba3:0:b0:720:e5a:fe3b with SMTP id 6a1803df08f44-767c46cd6c7mr165366496d6.58.1757962147926;
        Mon, 15 Sep 2025 11:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo3ntzAafInR/QDbS4xk0XJuXQBwpwYhaIwxitcYDukXsk9+FEmwXEdAJFJ8+MdNz2jYAJ2w==
X-Received: by 2002:ad4:5ba3:0:b0:720:e5a:fe3b with SMTP id 6a1803df08f44-767c46cd6c7mr165366236d6.58.1757962147479;
        Mon, 15 Sep 2025 11:49:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7890598971bsm13624556d6.25.2025.09.15.11.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:49:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dfc4da47-2694-4470-ba14-ee62b91e52e0@redhat.com>
Date: Mon, 15 Sep 2025 14:49:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 05/11] cpuset: refactor CPU mask buffer
 parsing logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-6-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-6-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The current implementation contains redundant handling for empty mask
> inputs, as cpulist_parse() already properly handles these cases. This
> refactoring introduces a new helper function parse_cpuset_cpulist() to
> consolidate CPU list parsing logic and eliminate special-case checks for
> empty inputs.
>
> Additionally, the effective_xcpus computation for trial cpusets has been
> simplified. Rather than computing effective_xcpus only when exclusive_cpus
> is set or when the cpuset forms a valid partition, we now recalculate it
> on every cpuset.cpus update. This approach ensures consistency and allows
> removal of redundant effective_xcpus logic in subsequent patches.
>
> The trial cpuset's effective_xcpus calculation follows two distinct cases:
> 1. For member cpusets: effective_xcpus is determined by the intersection
>     of cpuset->exclusive_cpus and the parent's effective_xcpus.
> 2. For non-member cpusets: effective_xcpus is derived from the intersection
>     of user_xcpus and the parent's effective_xcpus.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 59 +++++++++++++++++++++---------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6015322a10ac..55674a5ad2f9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -169,6 +169,11 @@ static inline bool is_partition_invalid(const struct cpuset *cs)
>   	return cs->partition_root_state < 0;
>   }
>   
> +static inline bool cs_is_member(const struct cpuset *cs)
> +{
> +	return cs->partition_root_state == PRS_MEMBER;
> +}
> +
>   /*
>    * Callers should hold callback_lock to modify partition_root_state.
>    */
> @@ -1478,7 +1483,13 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
>   	struct cpuset *parent = parent_cs(trialcs);
>   	struct cpumask *excpus = trialcs->effective_xcpus;
>   
> -	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +	/* trialcs is member, cpuset.cpus has no impact to excpus */
> +	if (cs_is_member(cs))
> +		cpumask_and(excpus, trialcs->exclusive_cpus,
> +				parent->effective_xcpus);
> +	else
> +		cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +
>   	return rm_siblings_excl_cpus(parent, cs, excpus);
>   }
>   
> @@ -2348,6 +2359,19 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>   	rcu_read_unlock();
>   }
>   
> +static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
> +{
> +	int retval;
> +
> +	retval = cpulist_parse(buf, out_mask);
> +	if (retval < 0)
> +		return retval;
> +	if (!cpumask_subset(out_mask, top_cpuset.cpus_allowed))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2364,34 +2388,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	/*
> -	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
> -	 * Since cpulist_parse() fails on an empty mask, we special case
> -	 * that parsing.  The validate_change() call ensures that cpusets
> -	 * with tasks have cpus.
> -	 */
> -	if (!*buf) {
> -		cpumask_clear(trialcs->cpus_allowed);
> -		if (cpumask_empty(trialcs->exclusive_cpus))
> -			cpumask_clear(trialcs->effective_xcpus);
> -	} else {
> -		retval = cpulist_parse(buf, trialcs->cpus_allowed);
> -		if (retval < 0)
> -			return retval;
> -
> -		if (!cpumask_subset(trialcs->cpus_allowed,
> -				    top_cpuset.cpus_allowed))
> -			return -EINVAL;
> -
> -		/*
> -		 * When exclusive_cpus isn't explicitly set, it is constrained
> -		 * by cpus_allowed and parent's effective_xcpus. Otherwise,
> -		 * trialcs->effective_xcpus is used as a temporary cpumask
> -		 * for checking validity of the partition root.
> -		 */
> -		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
> -			compute_trialcs_excpus(trialcs, cs);
> -	}
> +	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
> +	if (retval < 0)
> +		return retval;
>   
>   	/* Nothing to do if the cpus didn't change */
>   	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
> @@ -2400,6 +2399,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
> +	compute_trialcs_excpus(trialcs, cs);
> +
>   	if (old_prs) {
>   		if (is_partition_valid(cs) &&
>   		    cpumask_empty(trialcs->effective_xcpus)) {
Reviewed-by: Waiman Long <longman@redhat.com>


