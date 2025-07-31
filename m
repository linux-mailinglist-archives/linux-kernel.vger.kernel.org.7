Return-Path: <linux-kernel+bounces-752322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9077B1740A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B341D3B0DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14731B87F2;
	Thu, 31 Jul 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcriVprJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F046D515
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976395; cv=none; b=Xokhmf6PksZhjBLoSeCCgifGsTmNjGvY5fYvek+6bw+NGYM9wLC+uX8b5gpvlJUsn7MYN71zzulbUUcaHdsxUetEe3LG8SqXCarDw7fe5Od/h+EMSdEzPhU8sWkghtJOQ339Yfu5nIXiXgI6kUZndMLXe+0quHFoBG1m3jJqGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976395; c=relaxed/simple;
	bh=90SS6vby3Jx/PuLaW3VJkEzczt1J1qlx/6htWJgAtvs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=Vw9FnCliNHOZxGX83ST8ahtryJm6DNjWGMyCjrzTPbZ3Utd+OuuBZgUdZ10SUzghR3Ejs/0V0yzRNKelzD/uj5bmKLddcb4WNF5wVjnxkmjK+o73I84jz8JT1vk+o01vGOrBvn6dvQka1SWX21vItCBulSDxdMu5qCOjnEgC9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcriVprJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753976392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxD9QUrtfqzdrKfxtUWJeyETbAxBFmdn1BfeKssmVKY=;
	b=YcriVprJAeKFZFHGyXEjCqCGCckt69LIHng+t6BMTslJvNHHn0jD9tsCarzERt8zrI8Quq
	S2Gmt3nVbGaqVFFxP/7dtY2SOolkFd0wLehg+/HJs3em9yuGFEFCHpRxcqH76gnocms7wh
	CMm1hnrFUVv9Sqg8Il4KRnL8y7evTw0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-XTzrM-cSMBKrnjIJuHtBzQ-1; Thu, 31 Jul 2025 11:39:51 -0400
X-MC-Unique: XTzrM-cSMBKrnjIJuHtBzQ-1
X-Mimecast-MFC-AGG-ID: XTzrM-cSMBKrnjIJuHtBzQ_1753976391
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fab979413fso11317206d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753976390; x=1754581190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxD9QUrtfqzdrKfxtUWJeyETbAxBFmdn1BfeKssmVKY=;
        b=sU3a8pE/c0e1NG09788VDnX35k4ZAX43/tZToYeTi0N3btKqOvxMS5sVJI53+D40Jx
         i7f50QC05C5sndsFXu70U5UG2/6+wnun1SQcokDbBYif3vbJbKfs6AJwuGfs0YqyH9Kv
         lyeIMq6EvHprJzY8j+1aEY/uE6VTnLJREYptnBcRhHI74Rae/Ah21EXvD+Nhnf6Oz2wM
         vOqN8ePKfpGviTeMhTYhKdgEh9LkUYoe6Gq0keUG9xZ7rgAfdCpxe2krqv+lPbyOvQdn
         XY6r8s9gWvqbDiXk+52Ypp3apAaABUOWR4fOUqQIsouDr4yB60TYdvmaWwlO8DvtWfFx
         Uxkg==
X-Forwarded-Encrypted: i=1; AJvYcCXpqusBtXpZNPW145qD7RK0gBqvfw/Eil2uxwlJuRd/eU1Nc/sh6UfMcBQYnAWBgFe+C6oQKs5ijqlYg38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07K+E3hvXkw+D29s5RiEDvJdcwZwM1OYGa6x6qbNg2TEvJWvO
	e08gW/5eR6pR1sdGUPuD4DwwcSU2XssoQv6JQk6M3bkFO6xOvbDEgOS0emZXjHLd/KERPhf2o7O
	RuUGBr9hCIWxpSMppNNfVU2FQugiXjfJlgZzrrFZtvTpskHfP9AaSyQu7mWStn9Lm1HvjdYeLgA
	fT
X-Gm-Gg: ASbGnctDRB7dWyCcaPXWDLyyqgZgIdZfJTLQpnOloR0sgUHVMaVmr3IwEIQ99HCpZ0J
	tJ/e1/j7qsRUNeWkWzIJhCtXqCKiSRgAtNjBtrjjsBn0QorInjF1DzO/1ZSr/HR9N/fRpIsft/f
	D9cWhBJarhRTh8ksD/Fa6ZiGYFXg3u53pJkUktvJXepJC9fF5lLpivxNywwgqA/Zljb/msSatVp
	TCFInbg/4Fp8YVwjAJx5+qqIceX4r9q/LD15z2gl6x40434IIUXGu7FNgWfjXOksvuaYCrzHDq5
	3b2sxWXPGlnCAptqrtJS24wITxCcBt3q4t/73uWda09vL0mWR0t9wl2ELODMVzVKxr9vkuzPFTL
	Q593fDoWuqA==
X-Received: by 2002:a05:6214:529a:b0:707:55f:ea2d with SMTP id 6a1803df08f44-707672ed3aemr105891936d6.49.1753976389441;
        Thu, 31 Jul 2025 08:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIzfUMcPHGnPB0o2zeAQP4VvDjGN3rIgQKVy8fTLqZ1k3VN1HjCx1KbNeWF3wlBJFyoG0FCg==
X-Received: by 2002:a05:6214:529a:b0:707:55f:ea2d with SMTP id 6a1803df08f44-707672ed3aemr105891436d6.49.1753976388923;
        Thu, 31 Jul 2025 08:39:48 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce377b9sm8718326d6.80.2025.07.31.08.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 08:39:48 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bdbc1a11-1546-47e6-bb14-d3ad940907ed@redhat.com>
Date: Thu, 31 Jul 2025 11:39:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/8] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-8-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250730131158.101668-8-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/30/25 9:11 AM, Gabriele Monaco wrote:
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
>
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e3f44ffaa21..a946d85ce954 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>   }
>   
> +/*
> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
> + * @prs: new or old partition_root_state
> + * @parent: parent cpuset
> + * Return: true if isolated_cpus needs modification, false otherwise
> + */
> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
> +{
> +	if (!parent)
> +		parent = &top_cpuset;
> +	return prs != parent->partition_root_state;
> +}
> +
>   /*
>    * partition_xcpus_add - Add new exclusive CPUs to partition
>    * @new_prs: new partition_root_state
> @@ -1339,6 +1352,35 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	return isolcpus_updated;
>   }
>   
> +/*
> + * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> + * @new_cpus: cpu mask for cpus that are going to be isolated
> + * Return: true if there is conflict, false otherwise
> + *
> + * If nohz_full is enabled and we have isolated CPUs, their combination must
> + * still leave housekeeping CPUs.
> + */
> +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> +{
> +	cpumask_var_t full_hk_cpus;
> +	int res = false;
> +
> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		return false;
> +
> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> +		return true;
> +
> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> +		res = true;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}

First of all, isolated_cpus currently include those CPUs excluded from 
boot time isolcpus=domain setting, but it also include new isolated cpus 
created by used by cpuset isolated partitions. Your current 
isolcpus_nohz_conflicts() does not check isolated_cpus which I think is 
incomplete.

Cheers,
Longman

> +
>   static void update_exclusion_cpumasks(bool isolcpus_updated)
>   {
>   	int ret;
> @@ -1464,6 +1506,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>   		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    isolcpus_nohz_conflict(tmp->new_cpus))
> +		return PERR_HKEEPING;
>   
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1563,6 +1608,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>   			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 isolcpus_nohz_conflict(tmp->addmask))
> +			cs->prs_err = PERR_HKEEPING;
>   		if (cs->prs_err)
>   			goto invalidate;
>   	}
> @@ -1914,6 +1962,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			return err;
>   	}
>   
> +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> +	    isolcpus_nohz_conflict(tmp->delmask)) {
> +		cs->prs_err = PERR_HKEEPING;
> +		return PERR_HKEEPING;
> +	}
> +
>   	/*
>   	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>   	 * only).
> @@ -2934,6 +2988,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (isolcpus_nohz_conflict(cs->effective_xcpus))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it


