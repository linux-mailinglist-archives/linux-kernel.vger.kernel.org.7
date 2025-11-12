Return-Path: <linux-kernel+bounces-898280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4480C54C27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669A83B94DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E22E7196;
	Wed, 12 Nov 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOdSxn72";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFKu3Yam"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2B2DEA71
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988059; cv=none; b=q0WZQiRpQ5mqjbDeArvem2I9SdsOcVTZGBm5e+MTaFVQiC2sYy8ITbzQSom4DRg+eE3pmEikNiArdPUFU5eap6LNYYgLtm2j+kVgPMoHfgHRIAkQ5TV9xuAHGGkg3siffT0LkbZYngI8Ol7EMjLy4T/v+YXbhnS5ToKtLnloHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988059; c=relaxed/simple;
	bh=IGh+aIPPoWBLcAIZs0Jz6dPtn1efoP5CzXHA/HI3lH4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RqIDAWaI4zVBGaTlhdqJXmQ450mc3F7Mgy9tcYRYYlzzdgHQYtq4WvoUxbmZpmnzUwZp2j63c19byjocTb/j1YVOTuGW9O0v/z5Mz/OjPeF4OsmlUQ6JodS03iZRLY1T382NmVxk7EXAeW3K9g7OLS5KWHoyxVJVom7EM4bRqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOdSxn72; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFKu3Yam; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762988056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVjkePrhZOOCcRrxM0ei79YsOMP5kpZrEVFm7XWWWOQ=;
	b=TOdSxn72zblP2XFs/5gzTYrUOlwn1UZRbmhHdRo3zJrYNcSWZbGGaFWsKU/kRHGL1VTP52
	H1NfQ8Oe5vFHSMcHKAIumsBpgmdF4xTMsIJaTifD/Uz5DUhoyr3IumuOS2ccbDzJGwjbBh
	WUQCwiXGcv6pxe35Tv30Fr80QhTlNtg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-XrDsq7J2M4yg_bSxl4V07A-1; Wed, 12 Nov 2025 17:54:14 -0500
X-MC-Unique: XrDsq7J2M4yg_bSxl4V07A-1
X-Mimecast-MFC-AGG-ID: XrDsq7J2M4yg_bSxl4V07A_1762988054
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-880441e0f93so6837406d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762988054; x=1763592854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVjkePrhZOOCcRrxM0ei79YsOMP5kpZrEVFm7XWWWOQ=;
        b=cFKu3YamnKpegAQM1CCK2GQt/bdQDkjC1StDG8jD+cqoK7KyfsLI31TXt4jIxxGSPY
         E799T0oMggPIUB7y9nilbI4Icyl6eat4du0AGqcGkvsiPw0r7CH4IM/0hKZXh//JWqNG
         PAOGjm7s2VhBLaZZSszFQzVYOGa66af9rvouBUI1vSFwkztqya/y7GRv+vqP3MJQCVdh
         8DTrmIqVOoiCW3rZWeB+qqLug6KVekZ7F6TakuIG9O/2I399wT/FrTiQDENKKymao7mh
         +xoOcBuYOYbRHLlAy9RKpuhUtyBiH1S6Aliurc65lw0ilr03WU0q27Wgxte3EYfAlPLf
         VVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988054; x=1763592854;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVjkePrhZOOCcRrxM0ei79YsOMP5kpZrEVFm7XWWWOQ=;
        b=igCxt8ot+Mbw4R+pEPEh0xpyaGRVwPoPxnXhPVdrFgVAEqeKyij/KewHmrxGQ6zo0t
         StoXP4kcbEI1chXCB/x+q7fyf7ZcA2wE+b2nMOkg9UmnvunN6ir7FuoBf4if/VUc5mEv
         aVNRQ7i8UPeuwkWdr9/UDhEPvk91WFJLdsU3LsK7suHbaMJvHzVsLtk8lqUhJ5qSrq7y
         mZZPpIT9wVMGLzZinFYe5SSRJQYsi9FIo44SqIzECWBd+SkxrPeg+n59bVt5k+SQkXFR
         +X9MsPptIzSfEGoys5kVQMLr0pq4AtEf7peaCEx3o9YV4e9L09yQv7NR+VMzSYILokAt
         xX6g==
X-Forwarded-Encrypted: i=1; AJvYcCWVOVqCmvxAUDIDHyUV37H0eR+51EYEOTMlYKKnPfs2scNxexIxiLJBG+iClXWkY8IWhtr5BtBA1cBcFA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoXfRYPP/+ZXhpjFN0ZsRF+WG+4dCRbOjRKBix9TajaE2g3x/
	8R2xk/Q4abx86bcR1r5RYD/RrnF5QnbEojybD+Ouj/y/50/naxkdPdY0SXY5ctqj7jY0+jgvyT4
	MIKuiFn1I/ioHEtBc3SDXjwRK/DcqG7rAFZSpUwq6qSZtwm4YJlT/CZTK0JpADYyTug==
X-Gm-Gg: ASbGncua7l4ev8m24nZ1daoE/8PIvCUyr8BJauhXFG1j9pP4D6NrxDOweyhAp2ooGUW
	LGeR5m3lKqrIXvRisa/pEYOP0QhMltiGBhGv4ug6tljZHhdV1c2u/xiR54r7eVS9EfRDb88LE8W
	QlDgftfsBiTwDPqjz3DLW6TNDvXGS0OjidDTG4ogUuyJaW4M39NlvW1TtZyI/qlj1nu4AvAoiS+
	EdtpS1K+lTh06DnRfS5C8+7Vy0gdIm5S0Q+cirFUWPbdvmbMm+33K/t52xLT5uz1w2aUioldivq
	1DhO3MZ0lRisMOeMQ6c6zDNAKZcskb+2RDH5qxLd4mUlCCD7NSaynOvOjYPC+IKsySkDZrcbLcn
	CQNWrJ1CFMvjzW8KCXOdU7To7AcqBx217YdEVcRGaoDA6Ow==
X-Received: by 2002:a05:6214:268f:b0:880:53a8:404d with SMTP id 6a1803df08f44-8828179e98dmr19926036d6.3.1762988054194;
        Wed, 12 Nov 2025 14:54:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNgNwE6us1RRjm44F0DeY0a+grxA9MVmz4QFMpDJs4NwFpsV7MGQqZlX1SYNAIF4H2DnYqVw==
X-Received: by 2002:a05:6214:268f:b0:880:53a8:404d with SMTP id 6a1803df08f44-8828179e98dmr19925816d6.3.1762988053803;
        Wed, 12 Nov 2025 14:54:13 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882863135cfsm787076d6.22.2025.11.12.14.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:54:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f9a3fffb-922c-4d4a-81ad-9eeb489cef07@redhat.com>
Date: Wed, 12 Nov 2025 17:54:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/22] cpuset: introduce
 local_partition_invalidate()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-13-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-13-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Build on the partition_disable() infrastructure introduced in the previous
> patch to handle local partition invalidation.
>
> The local_partition_invalidate() function factors out the local partition
> invalidation logic from update_parent_effective_cpumask(), which delegates
> to partition_disable() to complete the invalidation process.
>
> Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
> when determining whether to transition an invalid partition root, the check
> should be based on non-empty user_cpus rather than non-empty
> effective_xcpus. This correction addresses the scenario where
> exclusive_cpus is not set but cpus_allowed is configured - in this case,
> effective_xcpus may be empty even though the partition should be considered
> for re-enablement. The user_cpus-based check ensures proper partition state
> transitions under these conditions.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++++++++---------------
>   1 file changed, 43 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f36d17a4d8cd..73a43ab58f72 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1914,6 +1914,40 @@ static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_err
>   	}
>   }
>   
> +/**
> + * local_partition_invalidate - Invalidate a local partition
> + * @cs: Target cpuset (local partition root) to invalidate
> + * @tmp: Temporary masks
> + */
> +static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
> +{
> +	struct cpumask *xcpus = user_xcpus(cs);
> +	struct cpuset *parent = parent_cs(cs);
> +	int new_prs = cs->partition_root_state;
> +	bool cpumask_updated = false;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
> +
> +	if (!is_partition_valid(cs))
> +		return;
> +
> +	/*
> +	 * Make the current partition invalid.
> +	 */
> +	if (is_partition_valid(parent))
> +		cpumask_updated = cpumask_and(tmp->addmask,
> +					      xcpus, parent->effective_xcpus);
Invalidation is different from disable. It can be called when parent is 
no longer a valid partition root. So the check here is appropriate.
> +	if (cs->partition_root_state > 0)
> +		new_prs = -cs->partition_root_state;
> +
> +	partition_disable(cs, parent, new_prs, cs->prs_err);
> +	if (cpumask_updated) {

The cpumask_and() operation above is no longer relevant as it should be 
done inside partition_disable(). Instead of cpumask_updated, we can just 
do a "is_partition_valid(parent))" check here to decide if the following 
two helpers should be called.

Cheers,
Longman


> +		cpuset_update_tasks_cpumask(parent, tmp->addmask);
> +		update_sibling_cpumasks(parent, cs, tmp);
> +	}
> +}
> +
>   /**
>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>    * @cs:      The cpuset that requests change in partition root state
> @@ -1974,22 +2008,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   	adding = deleting = false;
>   	old_prs = new_prs = cs->partition_root_state;
>   
> -	if (cmd == partcmd_invalidate) {
> -		if (is_partition_invalid(cs))
> -			return 0;
> -
> -		/*
> -		 * Make the current partition invalid.
> -		 */
> -		if (is_partition_valid(parent))
> -			adding = cpumask_and(tmp->addmask,
> -					     xcpus, parent->effective_xcpus);
> -		if (old_prs > 0)
> -			new_prs = -old_prs;
> -
> -		goto write_error;
> -	}
> -
>   	/*
>   	 * The parent must be a partition root.
>   	 * The new cpumask, if present, or the current cpus_allowed must
> @@ -2553,7 +2571,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>   			if (is_partition_valid(cp) &&
>   			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
>   				rcu_read_unlock();
> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
> +				local_partition_invalidate(cp, tmp);
>   				rcu_read_lock();
>   			}
>   		}
> @@ -2593,8 +2611,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>   					   trialcs->effective_xcpus, tmp);
>   	} else {
>   		if (trialcs->prs_err)
> -			update_parent_effective_cpumask(cs, partcmd_invalidate,
> -							NULL, tmp);
> +			local_partition_invalidate(cs, tmp);
>   		else
>   			update_parent_effective_cpumask(cs, partcmd_update,
>   							trialcs->effective_xcpus, tmp);
> @@ -4040,18 +4057,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   	 *    partitions.
>   	 */
>   	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
> -				tasks_nocpu_error(parent, cs, &new_cpus)))
> +				tasks_nocpu_error(parent, cs, &new_cpus))) {
>   		partcmd = partcmd_invalidate;
> +		local_partition_invalidate(cs, tmp);
> +	}
>   	/*
>   	 * On the other hand, an invalid partition root may be transitioned
> -	 * back to a regular one with a non-empty effective xcpus.
> +	 * back to a regular one with a non-empty user xcpus.
>   	 */
>   	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
> -		 !cpumask_empty(cs->effective_xcpus))
> +		 !cpumask_empty(user_xcpus(cs))) {
>   		partcmd = partcmd_update;
> +		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
> +	}
>   
>   	if (partcmd >= 0) {
> -		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
>   		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
>   			compute_partition_effective_cpumask(cs, &new_cpus);
>   			cpuset_force_rebuild();


