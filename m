Return-Path: <linux-kernel+bounces-898252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8921FC54B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E01014E37E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B22EA481;
	Wed, 12 Nov 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJ7MoR/8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIyZtu5o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356492D839E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985421; cv=none; b=aGVJGGARi+EqMCk+AaOrkEfDYfII8KDsAxLZqN7lgQN6LcyVVJJ+FfDXh9Um1xRrfgtfilnNN3Crldua9GEQpm9jE8Li30cDqCWI3g3BfKo3NpXQ9yjzoz6hnjyCiUJb2oQ0W7xDuYOZt+kprbhfPQUTuW5SCgkYnDOScEJ6mNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985421; c=relaxed/simple;
	bh=RVRXjndE3LLUqlKF77wcqkvlvGQQFvstRXN4Zk8k5HQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e6LUi01xTGg1FNdxsoyLKw634sOv8EiP8yAr3GRvzPJqLU+JOTgXCdu9rNwziVS+7SDlFvO3lM/hI8C2Fxr03lQZUbM+M7OD664uDdn5kYTM7/Tjqbbi0I7KbH/FKHU1bey2hGUA0X5VFqdN41H+OkWnGfA2ecTw9u6Jup1t7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJ7MoR/8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIyZtu5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762985418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N/Yn6FOW3ySwfhCn5fVGDZbRep3BociADSKvJQX9zA=;
	b=cJ7MoR/82Rt68ipHfVZK/2f4WjXzsfM9O4k4FHtm9EA04fzyTD3zSWsA2wCM4fNUrNx182
	3bdQDgu8FgNQhApAaY6VvjkWNfX7ByMp5g9MSXlZUjaJD1i6JhEJ27EYvnElDyAlbDSWaa
	Oipms2OG/HyBh7mwqc32YAoIkYfWuaU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-1FDs9JhDMK2zx52FHEYVWg-1; Wed, 12 Nov 2025 17:10:16 -0500
X-MC-Unique: 1FDs9JhDMK2zx52FHEYVWg-1
X-Mimecast-MFC-AGG-ID: 1FDs9JhDMK2zx52FHEYVWg_1762985416
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882381f2092so7450436d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762985416; x=1763590216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5N/Yn6FOW3ySwfhCn5fVGDZbRep3BociADSKvJQX9zA=;
        b=cIyZtu5oIqDCBBhGO6qNQyKalzFoDAF/pafN4+JQWCVEHLKRYyvkvvQgjmJsrBnZTp
         1N1diZ69qnzcLHLbqnDFmOL20WXho2usFEEjoK38lGOIBvzPiXkNmikUwU66+ptBJ18h
         DNVtWmIgkBUGxcFK0YKyP/Ay2pkgfDzvZKNkfpaQ+mxCd74r/lnufCN1m18Vg8bkpXzH
         3hyBECJ4TdHM2ihToo+vdLypvzNEjgDKLnHhqlwOkQwuAfgDXgXVjCGzY7Pz6z/DN8N2
         WlKQDb3qGo40licuBFBgTHypn8KwmSCxQPXI3eIKgMRlTA0I8icllH+wt8ymjnMKzhor
         aueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762985416; x=1763590216;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N/Yn6FOW3ySwfhCn5fVGDZbRep3BociADSKvJQX9zA=;
        b=qeXTX4z5IVvhoYRvmGSumMXKg+W/DTJOhE++R/8foSgiId9CmIAQSKSy2aEgQiFf4p
         CR0hCxMVV5br53kHSj43JdVuiTprGEJkzaytnBsGdvAi0DGCzar/zlaoRKIgyjx93vsU
         sJ/OPvfRCrYntlfUDy3dfS5BTTw4uS6BM16zf9g1idA82E0DQPa4pbwHW+HRqYHX80nw
         2dzhc64POGDd3UssuvIavbvrOWyjoSlkIrmntwWoS7jDoD98iusg1GE4/+Ar+y1SFH7a
         oxy2m4TAEVU++LWXpyXZN6PjHXxrlTDj5CSJfFx/h6D9oCvShr9VZdx1hp/+ij3HLYrn
         wSsA==
X-Forwarded-Encrypted: i=1; AJvYcCV9wduta/PI3a3YOTQUNTJm6J8pnpCqH+eiE59ZHqVQzFRUFUTfPBZpwpSA5wN8ldIS19qcAHg0zO6hqKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fzSprdi/8FtJxXbzPtxhf7mh40AqKESiuXxmIGceBp8sz5Bz
	LW91opUR5F1alp1rAMFNChQeKC4OinXzxVyZpp8P4tyjZft/ujt9ThdzJjqkS24RAxok9LVCO0+
	9Fk79y9Sdar/HXZ3T0hdSs4CwyJynNBxm5jwvXYH3esEAbirNGy11Sn7AR8XatC42Gw==
X-Gm-Gg: ASbGncuV7RQmC4PF1wlIxd3A/NPdABanFF/9Ldxzd06tRFn/LBCdQG06kIftZG6Jv/R
	aEZ6wqnUv2dj8w5AG58snh7AY49yH7qaBEBj9EiMzJP2oe+8dUZR4q5M22hsnRYlGAELrC48ESU
	yEF+OSLzVYXeKzFBTb/bmIOrLBdhcL5K2MjiLDNqvXWX3CvaeoT77zKcMNOUfASmgbKMaO4Xn1G
	rB3Zirs+UsLtBttA9LmqldiPWtr3jBEnWmIW4kbog8amZhUjv2zLirR7uT7+K7VN0oGCaEzWSIV
	cl4zfeHV42k59vdAAjYzMxBG8PRPQVTetBTb8gfj9U1U8FpJVCsC8sTx6KnKvn7Ft6GIhoVoia2
	lHWOkdUIYZF/pB+RGVlDb8TIoK08UKyL/JRS6pO5WHa6usw==
X-Received: by 2002:ad4:5f07:0:b0:880:55e4:dde with SMTP id 6a1803df08f44-88271a4485emr68003126d6.63.1762985416449;
        Wed, 12 Nov 2025 14:10:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8fi+pUQJ49PuCmgYdZtBN+A+yE5FZ/FDxLtz8qqMqXmLOhW+IeicaAyOGqHjlJKVTIWmfDA==
X-Received: by 2002:ad4:5f07:0:b0:880:55e4:dde with SMTP id 6a1803df08f44-88271a4485emr68002796d6.63.1762985416080;
        Wed, 12 Nov 2025 14:10:16 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm294646d6.11.2025.11.12.14.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:10:15 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4adcc3d-577d-4065-b419-581f67d5e724@redhat.com>
Date: Wed, 12 Nov 2025 17:10:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 11/22] cpuset: introduce local_partition_disable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-12-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-12-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The partition_disable() function introduced earlier can be extended to
> handle local partition disablement.
>
> The local_partition_disable() functions is introduced, which extracts the
> local partition disable logic from update_parent_effective_cpumask(). It
> calls partition_disable() to complete the disablement process.
>
> This refactoring establishes a clear separation between local and remote
> partition operations while promoting code reuse through the shared
> partition_disable() infrastructure.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++------------
>   1 file changed, 39 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b308d9f80eef..f36d17a4d8cd 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1877,6 +1877,43 @@ static int local_partition_enable(struct cpuset *cs,
>   	return 0;
>   }
>   
> +/**
> + * local_partition_disable - Disable a local partition
> + * @cs: Target cpuset (local partition root) to disable
> + * @part_error: partition error when @cs is disabled
> + * @tmp: Temporary masks for CPU calculations
> + */
> +static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_error,
> +				    struct tmpmasks *tmp)
> +{
> +	struct cpuset *parent = parent_cs(cs);
> +	bool cpumask_updated = false;
> +	int new_prs;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
> +
> +	if (!is_partition_valid(cs))
> +		return;
> +
> +	new_prs = part_error ? -cs->partition_root_state : 0;
> +	/*
> +	 * May need to add cpus back to parent's effective_cpus
> +	 * (and maybe removed from subpartitions_cpus/isolated_cpus)
> +	 * for valid partition root. xcpus may contain CPUs that
> +	 * shouldn't be removed from the two global cpumasks.
> +	 */
> +	if (is_partition_valid(parent))
> +		cpumask_updated = !cpumask_empty(cs->effective_xcpus);

If cs is a valid local partition, parent must be a valid partition. So 
the is_partition_valid(parent) check is meaningless. Also the 
effective_xcpus must not be empty. IOW, cpumask_updated must be true.

Cheers,
Longman

> +
> +	partition_disable(cs, parent, new_prs, part_error);
> +
> +	if (cpumask_updated) {
> +		cpuset_update_tasks_cpumask(parent, tmp->addmask);
> +		update_sibling_cpumasks(parent, cs, tmp);
> +	}
> +}
> +
>   /**
>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>    * @cs:      The cpuset that requests change in partition root state
> @@ -1967,19 +2004,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   	nocpu = tasks_nocpu_error(parent, cs, xcpus);
>   
> -	if (cmd == partcmd_disable) {
> -		/*
> -		 * May need to add cpus back to parent's effective_cpus
> -		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
> -		 * for valid partition root. xcpus may contain CPUs that
> -		 * shouldn't be removed from the two global cpumasks.
> -		 */
> -		if (is_partition_valid(cs)) {
> -			cpumask_copy(tmp->addmask, cs->effective_xcpus);
> -			adding = true;
> -		}
> -		new_prs = PRS_MEMBER;
> -	} else if (newmask) {
> +	if (newmask) {
>   		/*
>   		 * Empty cpumask is not allowed
>   		 */
> @@ -3110,9 +3135,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		if (is_remote_partition(cs))
>   			remote_partition_disable(cs, &tmpmask);
>   		else
> -			update_parent_effective_cpumask(cs, partcmd_disable,
> -							NULL, &tmpmask);
> -
> +			local_partition_disable(cs, PERR_NONE, &tmpmask);
>   		/*
>   		 * Invalidation of child partitions will be done in
>   		 * update_cpumasks_hier().


