Return-Path: <linux-kernel+bounces-860004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6910BEF1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CF53A7DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132423E346;
	Mon, 20 Oct 2025 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUHNodMd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B3A59
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928544; cv=none; b=u1kRORu/2QJmezGrr/6Z4yCUFL2lljETWPjwUHYoUSoymqzIQ7Y+iUKl4lGJ7lO1G4u42HzNBI9N80d3G9bWOVFK7hg6o7zrpftsG3iXy9Mzp2d9dCUD3tOA5iUQekTc3+0Q0VaJ4nTZuXHCTG3iDvfw8hbNtzCMPFCCdxNXC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928544; c=relaxed/simple;
	bh=NDFNoSnK+xHZBUZAJwcriaNtjl4A1rTU9K3ijTx5kvU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r6uIMi64BREaIOOvHzJ+7Uwswk0mwEHuO/cxIjw57y2W5RmRYguGBPcyOpftrEKX5rXV/YODgDf1t6cOlLjsKykFyciqhaQIOrg8hEJroOu1BMaOotrAXp7xxxbHhjWt4ytHXx8eYH2RiHWn6uHPw7bpyBamW3YxnN9TZG0wL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUHNodMd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760928541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rn+3ndEj0FrOyHPm5sclcvHQO5vlHiLtDNRgz9ixNMw=;
	b=UUHNodMdu1Yif0x74z5hdDArOlN3KSa//g7E5xLCUQUgnGIiUsfGvm29eAXj9kNlGOuPDk
	/cQhsjRsi2NKZS85PLCVl0AxaBcMukBR5go+4Nm7ivSVKxneomVvLAFg2bw3ur7z9IWmUS
	jD0MC1CRyq2NvGn3VAG8qqmJ3xqZqjw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ZtCoby6PO72nJNs6BKGBeQ-1; Sun, 19 Oct 2025 22:49:00 -0400
X-MC-Unique: ZtCoby6PO72nJNs6BKGBeQ-1
X-Mimecast-MFC-AGG-ID: ZtCoby6PO72nJNs6BKGBeQ_1760928540
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88e7bfe5ba7so1503130385a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928540; x=1761533340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn+3ndEj0FrOyHPm5sclcvHQO5vlHiLtDNRgz9ixNMw=;
        b=ZCXB6ejcOLyIpY4mhybZOELvxq2V2X9NsTt9b+pJRAf+5L56r1PkVrGBbuXiG7Z66f
         li9yVm52xC/A6kqDr0EzI5cCexoUJ6Y6BM/okbljgJu4SXbzBXflA6EojO+3Ezk+LnOu
         WoSK2z0bt/JROMAfxlRgr/olO1xxDtdIaGBeyCCgaBxGgoHtaRgB5pg7AduDv5y81YJc
         YWyTO0I1KEnavpuL4CWP5pwDjtKiy6vlGh+e9sAXd6jUZonkbv1tZOL5KN/FeMqfi/pJ
         d0T7YwdamVW5xxFbtkm6U8Zuqe17S2m7sT/60/POZLGuuQDXRHltaxrO2qr4ULK3edRG
         YK8A==
X-Forwarded-Encrypted: i=1; AJvYcCVY1yv7Z4dh+rtEN+KjIqVY4QHg6UnWY4JVlkj98h0REmzLJbyY80BJ9cP2xIs8a7dPxxLSMkcc10uqndk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0i4reN3jwf+Vx38zuwB/ewfukZ1BbcZOlQm2DhCN7WYehlSv+
	wx4q4AUeZjEZdDuetVoZqO6LlrjirbfMa66JnxMhkEnNB7zbuj1ta8i55Sg7XZhcZ8gb4i32s86
	pHcZ6bmXcYksqj7OSAVMcNT1EAJ41/YNVyx7kB8fZi11KcSA4jrp7NTkTa+21gWeWCg==
X-Gm-Gg: ASbGnctN6mNSsyAReUdHqz2J7RmxjAxRvlIplBiFovwvJoUnGPDatH1YoaK4uaQAL9V
	9Hl66yLq2ENjw1d8GoJaFFXT63G/TH0SksyEczl5KTHhPOq+tJ6EqGz8cGKOvkVCH6QLFS0LGYn
	krkjJyBH7mhsCQI8cEXaCytfvNG++Eg8bOU/ugmrN4K3QrA4wlzFJ+/irCFVfi2QilvmuMC2oTz
	5YZGlZfEE48VFvIA8jkNE8ppe1ogoc8ShF+9a9VlgrCgyW1p9RTrO781EFawT77oh6LUCYfvOyN
	VmN2KahgufWj1eAunX87UEuGVNXexNIMxLGuu0RdrbjfzSVi2ziMwJvAzZ62A9pz/MQrPE/MkfV
	9hJFfXAlmsv/ccvc0MvKbM2EAkDeKMvMS1Wng0JEaVEDGDQ==
X-Received: by 2002:a05:620a:4496:b0:840:c0c0:9311 with SMTP id af79cd13be357-89070113776mr1521406885a.50.1760928539672;
        Sun, 19 Oct 2025 19:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr7wdK3c5RlnqArloWDaNA//k1ASTQjbuLVn0E3g1SgJBYK9e05a0UbgGJlqddq7RIo2ETTw==
X-Received: by 2002:a05:620a:4496:b0:840:c0c0:9311 with SMTP id af79cd13be357-89070113776mr1521405385a.50.1760928539233;
        Sun, 19 Oct 2025 19:48:59 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58e7bfsm466184785a.50.2025.10.19.19.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:48:58 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a820463b-a715-4cea-917c-98175a35f970@redhat.com>
Date: Sun, 19 Oct 2025 22:48:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 08/16] cpuset: introduce
 local_partition_invalidate()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-9-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-9-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
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
>   1 file changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 87ba43e93540..e460d03286ba 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1911,6 +1911,39 @@ static void local_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
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
> +	if (is_partition_invalid(cs))
> +		return;
You should change the check to if (!is_partition_valid(cs)). You can 
avoid the case that partition_disable() is called with a member.

> +	/*
> +	 * Make the current partition invalid.
> +	 */
> +	if (is_partition_valid(parent))
> +		cpumask_updated = cpumask_and(tmp->addmask,
> +					      xcpus, parent->effective_xcpus);
> +	if (cs->partition_root_state > 0)
> +		new_prs = -cs->partition_root_state;
> +
> +	partition_disable(cs, parent, new_prs, cs->prs_err);
> +	if (cpumask_updated) {
> +		cpuset_update_tasks_cpumask(parent, tmp->addmask);
> +		update_sibling_cpumasks(parent, cs, tmp);
> +	}
> +}
> +
>   /**
>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>    * @cs:      The cpuset that requests change in partition root state
> @@ -1972,23 +2005,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
> -		if (old_prs > 0) {
> -			new_prs = -old_prs;
> -			subparts_delta--;
> -		}
> -		goto write_error;
> -	}
> -
>   	/*
>   	 * The parent must be a partition root.
>   	 * The new cpumask, if present, or the current cpus_allowed must
> @@ -2552,7 +2568,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>   			if (is_partition_valid(cp) &&
>   			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
>   				rcu_read_unlock();
> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
> +				local_partition_invalidate(cp, tmp);
>   				rcu_read_lock();
>   			}
>   		}
> @@ -2592,8 +2608,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>   					   trialcs->effective_xcpus, tmp);
>   	} else {
>   		if (trialcs->prs_err)
> -			update_parent_effective_cpumask(cs, partcmd_invalidate,
> -							NULL, tmp);
> +			local_partition_invalidate(cs, tmp);
>   		else
>   			update_parent_effective_cpumask(cs, partcmd_update,
>   							trialcs->effective_xcpus, tmp);
> @@ -4037,18 +4052,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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

I believe the effective_xcpus is not cleared currently when a partition 
is invalidated. Anyway, this change is also OK especially if 
effective_xcpus will be cleared in a later patch.

Cheers,
Longman

>   		partcmd = partcmd_update;
> +		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
> +	}
>   
>   	if (partcmd >= 0) {
> -		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
>   		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
>   			compute_partition_effective_cpumask(cs, &new_cpus);
>   			cpuset_force_rebuild();


