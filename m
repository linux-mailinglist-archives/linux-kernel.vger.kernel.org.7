Return-Path: <linux-kernel+bounces-792431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4EB3C3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F4CA2484C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB63375B6;
	Fri, 29 Aug 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFHtCbdh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6621C194
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499533; cv=none; b=eOjGufNtA1KER/Dz6PvE4bZlfysJoVnzd4Rbk1PCG1jOE8bEdsJLuMk/oiOJyO3ZBCekMgK+AaYSchSEy1U+joDiPQPschiBR4wOGHj4ypgIgSRFFV4NyHSkOB9mMd2yw5ZR9mflZXGJV0ZHRX6z8GRir+zM4bncIB4CZEqM6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499533; c=relaxed/simple;
	bh=4b0ERqGboD0025/EE6BpdNyy7bjwsY2FJPKRwOTE8Ho=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nfYuyBa0QJJ10I6G8QSPFci7N1c+dV2P/Ns3TaLE7ar20N+QPmgLKqawsAbZls42ds0+NwMj+75NFam5qvA1vYjNaNmPwUBIHMdDksV8ZcZvE2LRZMcXsyBZmBMLvElchuKBRf6zRuwqB1w6iPeIv5SvnLU/D31zlyP/9pbuQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFHtCbdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756499530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYHPKYQYJqiOAQju2ZuT3ez1AVlcLrBw2m0yDrDYMKo=;
	b=HFHtCbdhhqKPD9sqC3Gy0e+oEhdvwqJ2nAA9NYJuRCypQMoUsmEZXCCxZayIPMgbmMKQew
	CrdybkCB65x1p1eFIhym9piYRpZjqIpBsSUpbUyb5zv5qHvP6txJSfm1n1mno5lOEraRmB
	VExknwDR86IoZaeHx/oBKiKy+T6/hyc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-2Q499QxUNgCaZCMzZlNWJg-1; Fri, 29 Aug 2025 16:32:08 -0400
X-MC-Unique: 2Q499QxUNgCaZCMzZlNWJg-1
X-Mimecast-MFC-AGG-ID: 2Q499QxUNgCaZCMzZlNWJg_1756499528
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b30d6ed3a4so23859951cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499528; x=1757104328;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYHPKYQYJqiOAQju2ZuT3ez1AVlcLrBw2m0yDrDYMKo=;
        b=iLRbO6eZ+huCW8GVb0F40aYvRl3Fr7JfG4XEQ36ON206L5YW0FDioc03j5cTzzAfGo
         z5rBS8r3eBzVFapSLSD73fQebHWzD20nAC2M/63ySipih2jgGTV5XjFLRvZd3YQNxxS9
         E509F8lewW48YCRDm4gqLSH01TZLj1eQNdQMvrA+sZyuIjxFeLbb70Sicmf8YryeBW7k
         nemOFOKUqVROVYMFyQRD62cYPlXZ8+O1LNgOl/sryoICzgtJLGMftTWdmIe5RemfcKD2
         LEvXkpfW1rzmJm4WQBRZ0voEz4eWIDDcXBhMXFmKBjfYi8J8WFE4DGNvkbpgiqtROAvv
         PhRg==
X-Forwarded-Encrypted: i=1; AJvYcCUFFwPYTevGmtSKD5Q5TlsnuTWoA/waTV2WWLIwdnr301Zsbn6sqLoc3qrCzfcNYrUhLD3Y+UqVwfzAf1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxYNfnhuyJZmgUD4ZdylCxjNOaYAoAyD1iNwIOKZi3EYykQ1D
	pu2dqTOBvXo+6L9Xt5UW5mOon7MpI6SPo4oHte5C91v3XkQG+H1AfMMvVXOdx7rMRU0psk0DwNd
	O42glJcMSEnUHvmhfSEgm0ZUGInzuH9wV7RziqscHp9K+AIyT8gVhsgJhNGll3/Y3Tg==
X-Gm-Gg: ASbGnctLMbEwSdWA8FqOL1es2soFrpiDlhnA0qLmaazUUraQN/KUrMK+4/mTS2SUdF2
	+jRos6VbHGCpkXqQiGBXn31B8g/rGe5X/9Q3N68Yb02soez1OOO61YRn4mAMwNwIfi2dHbs/c8G
	lzDb2sUE+mlUhEgQcX2d8G+P71c+uQ75hZK4unFJz5sIXzvvZhEn5Edl7BAp9aDhgHGHxlPUzjm
	v1XBNMEifyfYrvEwNccaljY0F/BUvEX98kUMTW0nERP7yDP4o28fU0fEJpHsmhvDzsW+Hs2Q9N8
	5KNomEuYpBK/eq56KK5cpeSp8qRrpQzJXjmMNGhkd+FXGAiUiOseKLvwF0cLqYfBmAO8c812uN1
	HyNx2caofDA==
X-Received: by 2002:a05:622a:1dc6:b0:4b3:102c:9263 with SMTP id d75a77b69052e-4b3102c9b0cmr41101911cf.39.1756499528273;
        Fri, 29 Aug 2025 13:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuLreJrdFJjGtn3cUS5D29Z+8SrJhNxhNMSxo5X+GBKky4gSUhSoxX+szSFygwpu/2zxBOnw==
X-Received: by 2002:a05:622a:1dc6:b0:4b3:102c:9263 with SMTP id d75a77b69052e-4b3102c9b0cmr41101531cf.39.1756499527758;
        Fri, 29 Aug 2025 13:32:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d869743sm242177085a.1.2025.08.29.13.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:32:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
Date: Fri, 29 Aug 2025 16:32:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-10-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-10-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the partition_cpus_change function to handle both regular CPU
> set updates and exclusive CPU modifications, either of which may trigger
> partition state changes. This generalized function will also be utilized
> for exclusive CPU updates in subsequent patches.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
>   1 file changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 75ad18ab40ae..e3eb87a33b12 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>   	return retval;
>   }
>   
> +/**
> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
> + * @cs: The target cpuset being modified
> + * @trialcs: The trial cpuset containing proposed configuration changes
> + * @tmp: Temporary masks for intermediate calculations
> + *
> + * This function handles partition state transitions triggered by CPU mask changes.
> + * CPU modifications may cause a partition to be disabled or require state updates.
> + */
> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
> +					struct tmpmasks *tmp)
> +{
> +	if (cs_is_member(cs))
> +		return;
> +
> +	invalidate_cs_partition(trialcs);
> +	if (trialcs->prs_err)
> +		cs->prs_err = trialcs->prs_err;
> +
> +	if (is_remote_partition(cs)) {
> +		if (trialcs->prs_err)
> +			remote_partition_disable(cs, tmp);
> +		else
> +			remote_cpus_update(cs, trialcs->exclusive_cpus,
> +					   trialcs->effective_xcpus, tmp);
> +	} else {
> +		if (trialcs->prs_err)
> +			update_parent_effective_cpumask(cs, partcmd_invalidate,
> +							NULL, tmp);
> +		else
> +			update_parent_effective_cpumask(cs, partcmd_update,
> +							trialcs->effective_xcpus, tmp);
> +	}
> +}
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 */
>   	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>   
> -	invalidate_cs_partition(trialcs);
> -	if (trialcs->prs_err)
> -		cs->prs_err = trialcs->prs_err;
> -
> -	if (is_partition_valid(cs) ||
> -	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
> -		struct cpumask *xcpus = trialcs->effective_xcpus;
> -
> -		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
> -			xcpus = trialcs->cpus_allowed;

This if statement was added in commit 46c521bac592 ("cgroup/cpuset: 
Enable invalid to valid local partition transition") that is missing in 
your new partition_cpus_change() function. Have you run the 
test_cpuset_prs.sh selftest with a patched kernel to make sure that 
there is no test failure?

Cheers,
Longman


