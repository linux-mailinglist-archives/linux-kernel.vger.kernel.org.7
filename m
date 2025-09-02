Return-Path: <linux-kernel+bounces-797229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBADCB40DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A536B16AE9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933130F526;
	Tue,  2 Sep 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMVhBLfJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197334DCF3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840491; cv=none; b=sxobE5qVcffGq9G8ELFQ6rSMAlLXrfS6FoPQMhK0ehqmtwYMr4rPGJUWAPLj5AtXGbilpMs/I+FXoTYGZdX3UO5reQipVUkuJBhk3R1QpKP6Uf7E/NlYcKlnMCm5+pu80EY+svJQbrbbLtyFouDmv8QCX6Pn5z+Emk3tXcSkfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840491; c=relaxed/simple;
	bh=RSBAgdoMOKm5IwqWsYjIIPQnJ9uikA97s63dOsl+8Ig=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=rml4BI0X4k09l9DoNM8K338DEtjno2NL3Ze6+q8XZZR1lXBkhh6TIsvzXoYggd4VNHP1rXXIItzOUlApmYHS66QJvJwMoCH0h3iuWl+tbmAAaTQrJ4MEsc9L7KLyReUO17iZ0dojZxEO+ezDoijMFW816B0hEpWLvHzAmq1ORHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMVhBLfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756840488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSqqhn9oIstClK6Qhb6siZxNdxq9o+AJbsb/fcLxCA4=;
	b=fMVhBLfJdDl6sRV5au5rhiIeWVSixCn7uZqPj/aIaShle0FKVPLg7sky8T9k4T1OWmbOHy
	n4Z7YhIhAP63a0ni00118iO+DZTDmA0BCk7FYtSHys0mxPJ29tkbiMMNOidWG6YKSSiPht
	ALhI+Ldq8dxEEUuMEp0cAYkod7DtD0A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-xEGyx4ABPGiav292FeI8HQ-1; Tue, 02 Sep 2025 15:14:47 -0400
X-MC-Unique: xEGyx4ABPGiav292FeI8HQ-1
X-Mimecast-MFC-AGG-ID: xEGyx4ABPGiav292FeI8HQ_1756840486
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7fc5584a2e5so1317705685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840486; x=1757445286;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSqqhn9oIstClK6Qhb6siZxNdxq9o+AJbsb/fcLxCA4=;
        b=k5691WqyBI69sK6qhF5FuiTwx3/OozYw5GkOXUhn+y0mV4EMVtn6HPtXzbWMEEI9ZD
         QSJIOJViJr+K/LLRl9H66JWHghaeiymLrIFilwmE4ZYXgUswnSF5IxB9KxevQ9hjBHIR
         c+31ot8OMggKAw/gq4hME493XRA+SZLo0i3c52/+3x+QrLYs7MXvo1l0zm94Y5F3gSK2
         u0JetW8UoO1ZbD2aZujxuWISOoFfhryeFwP9dv3xGWu/GvI2HEE/ROKnkoOGYG8VrV1t
         itb0uCxkeD51qQ3H4yvW2nXzK5sT81mD37kqgBrmAgRdAydX1GS//3zbrjCGdGbcr1rL
         YBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfHT6MqMPqtbHR5Yn7RU0yTvME+RC4uJlhYJNgHDECAHhNUhLCbKiIMx+23xcN9zOYAEcbo7ADbRdmsqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywstwb7NE0rFVsOkSADgU/FqbAHR/4CIMrf6YJaKWlnDRcnV/cR
	gaVnLqih6FWe8a3aOWOVUh/W+3E9g9ot2BfedLwoELK3rCESlEo+pHjDNa87+iBtpRrkiSFNKLL
	uL4WP9fKWwZe/XDqFdv9fHhKStKUX7hGPNjOIm0pAb+Y3+2Fzp4XpniskEVh9HwamZQ==
X-Gm-Gg: ASbGnct1GxRJGi4tKwt0qXAQJTPnGTBAadcDYzVQw4JNuy9jNE+oead7hghb2W7dFEv
	dIFLnLR8Bs1KD6n17WdtiDUOIrkv0Xixo5jMtmg33b5AhzgbZzqcmhkf9mQfaV/QCS83lXDW6gJ
	FhzH1z1SFQBYNB+7LcVVj0+nsPCbUII1grXLclSYLX63dDFeMpB/8cSqhqEZHkx6T8dLcu2JwZn
	gHjIVKCzFk9fiy/lN1E8gwvcr6bLzTSlDhX+Yql0ufbWqLaGP5A63b76UH6EUQ0AF0qStjDNs7F
	Tw0pJX75rj/kjhFxB2ftuDpKRtldR3I3KmcFhFSdn4Rf6jO7pcydaBfTkEsSzYLeSCwqX1VjXG7
	5JKlWHnfVpQ==
X-Received: by 2002:a05:620a:f03:b0:7f9:9316:7c63 with SMTP id af79cd13be357-7ff26eab2c7mr1352506885a.11.1756840486361;
        Tue, 02 Sep 2025 12:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmIDUJmNn5Qtveg0UWNVlNv97TGdVHQoxewI6Rs8BIOE+5hr43bWk82pZRuzSgc62dNl+9CA==
X-Received: by 2002:a05:620a:f03:b0:7f9:9316:7c63 with SMTP id af79cd13be357-7ff26eab2c7mr1352503485a.11.1756840485929;
        Tue, 02 Sep 2025 12:14:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8081076843csm88708785a.0.2025.09.02.12.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 12:14:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <647dabe8-f2ee-4b7c-87c3-b96db79cce7c@redhat.com>
Date: Tue, 2 Sep 2025 15:14:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250806093855.86469-1-gmonaco@redhat.com>
 <20250806093855.86469-8-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250806093855.86469-8-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 5:38 AM, Gabriele Monaco wrote:
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
>   kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e3f44ffaa21..7b66ccedbc53 100644
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
> @@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
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
> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> +		res = true;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}
> +
>   static void update_exclusion_cpumasks(bool isolcpus_updated)
>   {
>   	int ret;
> @@ -1464,6 +1507,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>   		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    isolcpus_nohz_conflict(tmp->new_cpus))
> +		return PERR_HKEEPING;
>   
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1563,6 +1609,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>   			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 isolcpus_nohz_conflict(tmp->addmask))
> +			cs->prs_err = PERR_HKEEPING;
>   		if (cs->prs_err)
>   			goto invalidate;
>   	}
> @@ -1914,6 +1963,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
> @@ -2934,6 +2989,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (isolcpus_nohz_conflict(cs->effective_xcpus))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it

As I said in my comment to Frederic patch series that in both 
remote_cpus_update() and update_parent_effective_cpumask(), some new 
CPUs can be added to the isolation list while other CPUs can be removed 
from it. So isolcpus_nohz_conflict() should include both set in its 
analysis to avoid false positive. Essentally, if the CPUs removed from 
the isolated_cpus intersect with the nohz_full housekeeping mask, there 
is no conflict.

Cheers,
Longman


