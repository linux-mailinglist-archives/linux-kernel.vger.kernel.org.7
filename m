Return-Path: <linux-kernel+bounces-817758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8FB5862A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E801B2178A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40302BE05F;
	Mon, 15 Sep 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inewcmBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421E1DE4EF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969036; cv=none; b=RVyA+NPCushHCMPkwNn3krjL49SNFASSRMvVXLX7plQq59gPkt0Fws2MsY1C7lpFyBOk067j6eS16pn4epwr2zM2ISQv2NfWNE8eWwiv2S8AwJ2kvBJDA7t+5GINWzycy9c4b9L6+6QxxwrtCm7cR8Csy4tTpLMe1xxa2PEHcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969036; c=relaxed/simple;
	bh=BvhhDO91HiXqi6SODFXrzR5YwxhAbYRzeyhsaNwtEoA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LYn8H31aoL6Vzv/xhOoBPF+GkqGOIFzxxTu52one80Dz3xSTmy+am0uzjExj4Fug3q8yw4y2sKv2gNxp0jcJVpWCALTka85umB6oppW/WM0ivIFd/lYkA45mkD9WaQ5T8pGa7fpQpBOLSLrAg2fSbOrdMPNaamkn/eaRInx6GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inewcmBh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757969034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkFBTBOwgjn8tn1mz/wEwDpd+RlUZsp29Mj6sBByITw=;
	b=inewcmBhjN0/mFU3MFelV/SVrWSdskdaYRb3vz/rxR5/pgBnigtl7Nl9dXQ4AfkadWB44M
	19XOcckU+5vPPnUuO1VVkh/FVKxwYEWcfSO6sBzBT6YDutt/0omV+M2PtKeSdnED4ob/t5
	BBN2JmpmUJ+Zm6rKzBdPBgOQkUaF4FE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-lpTlE0QpO7GMGj3hyc72xQ-1; Mon, 15 Sep 2025 16:43:50 -0400
X-MC-Unique: lpTlE0QpO7GMGj3hyc72xQ-1
X-Mimecast-MFC-AGG-ID: lpTlE0QpO7GMGj3hyc72xQ_1757969030
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8163f552e5aso1007799485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757969030; x=1758573830;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkFBTBOwgjn8tn1mz/wEwDpd+RlUZsp29Mj6sBByITw=;
        b=FoOP2LmvKDZQQEueZaI7CXM4XOSY9J8n8UnsvzkVU8D84lGFm//KeRQJj0JTCLQLXY
         4Eq9ZsTpW/csSTLSW9o9kOT+a61UCw2Bgm5eA8TaE2YVBfyuo0s2AEyzhzH6ltYbMBb6
         nhXHksumgjFDzlfB+BXO1Sa24nEF2mfDksACrFdaAeVEX+PPBzd/qoZaqsXL03TF5Pvs
         FS/j+3e3QWhTvI1DGqnRNBUWzDvaxr/ng3FxPskw3vWRLliDD6ab1s15jOsuEJPRJQFe
         /aLu08gI+yjpc63BymNbpIdV4rHKalACr8pyBGjq1gmi7ylAHII/tXR14I7D1JtrTH6v
         bWdw==
X-Forwarded-Encrypted: i=1; AJvYcCW8AP1SA0R32IJjNmCiKHj15lcmgor8KLRPn8tT+eJAy8zJZorAkh2AUk1ein+VyLzzTnE1CAZAoRxJBU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3u61/8DiEl4lC7moqqKhfKFbqj3BpXtB4aX/L2sBH0NNe3lC3
	b0TCHEJW5ISBRAFGDrYZTy9OTKtt+PMI+3hGQrw10w0WCvsR2scNmArLjXhrnhLVcTDM9KvR2OX
	4zK6naBO7mopN1eNQf0ukw9Vj1Ux7V0AaPN1OvXXF6upnHez4vLGpXO7M7cUmfbGCvw==
X-Gm-Gg: ASbGnctwM622OHwTxWd+5T0A1N8Ci1B9J1Pjn5xQGAxw2xrCOIx/8e4ZsdSb6neP5ZV
	ij60cv0/ou3tmvFwrRUhbnAfjec1AHqh7iBd+pe/JtnEl9FO+jyFf0Rfxyfl1ukjucsYjZW0TPO
	QpQIQjL2winM00eFHZXyhAuxYZuVjlTs238zTbzRWqxtq+hywyk9b7xM22ZVMsg3HaM5cYIweti
	1I0EQr2T7/Sc7fwxYjG9rUYCe7XTepGqzo/+z57s0K4kIHwL+G4O/d8blB67e0Yisvaj0thLM2c
	dK63ix9F1VoRbuA+1+95xQ6dZC0JLWQyF7P1mNrnVSoBh6fpAOzn3c6rX+38D+ZtvbZ2g6ebE++
	pP+9gbVKKiw==
X-Received: by 2002:a05:620a:3953:b0:829:7c30:e83 with SMTP id af79cd13be357-8297c303921mr604662385a.2.1757969029866;
        Mon, 15 Sep 2025 13:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4jY7KrWDup3TWOH/2lMf77KRyxiT/TunSsVIAdLJKYi7EF5jITSaGtIZuRa/TRAgmDGlAMw==
X-Received: by 2002:a05:620a:3953:b0:829:7c30:e83 with SMTP id af79cd13be357-8297c303921mr604659685a.2.1757969029387;
        Mon, 15 Sep 2025 13:43:49 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82aad002559sm138039985a.39.2025.09.15.13.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:43:48 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <969cbdd2-36ed-456c-96f8-d3b53e9ffb71@redhat.com>
Date: Mon, 15 Sep 2025 16:43:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/9] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-18-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250915145920.140180-18-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 10:59 AM, Gabriele Monaco wrote:
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
>   kernel/cgroup/cpuset.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 81a9239053a7..3cedc3580373 100644
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
> @@ -1339,6 +1352,42 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	return isolcpus_updated;
>   }
>   
> +/*
> + * isolated_cpus_can_update - check for isolated & nohz_full conflicts
> + * @add_cpus: cpu mask for cpus that are going to be isolated
> + * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
> + * Return: false if there is conflict, true otherwise
> + *
> + * If nohz_full is enabled and we have isolated CPUs, their combination must
> + * still leave housekeeping CPUs.
> + */
> +static bool isolated_cpus_can_update(struct cpumask *add_cpus,
> +				     struct cpumask *del_cpus)
> +{
> +	cpumask_var_t full_hk_cpus;
> +	int res = true;
> +
> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		return true;
> +
> +	if (del_cpus && cpumask_weight_and(del_cpus,
> +			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
> +		return true;
> +
> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> +		return false;
> +
> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_active_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, add_cpus))
> +		res = false;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}
> +
>   static void update_exclusion_cpumasks(bool isolcpus_updated)
>   {
>   	int ret;
> @@ -1464,6 +1513,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>   		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
> +		return PERR_HKEEPING;
>   
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1563,6 +1615,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>   			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
> +			cs->prs_err = PERR_HKEEPING;
>   		if (cs->prs_err)
>   			goto invalidate;
>   	}
> @@ -1914,6 +1969,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			return err;
>   	}
>   
> +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> +	    !isolated_cpus_can_update(tmp->delmask, tmp->addmask)) {
> +		cs->prs_err = PERR_HKEEPING;
> +		return PERR_HKEEPING;
> +	}
> +
>   	/*
>   	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>   	 * only).
> @@ -2934,6 +2995,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (!isolated_cpus_can_update(cs->effective_xcpus, NULL))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it
Reviewed-by: Waiman Long <longman@redhat.com>


