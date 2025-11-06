Return-Path: <linux-kernel+bounces-887783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A219FC39117
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0B764F5696
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55E271457;
	Thu,  6 Nov 2025 04:12:18 +0000 (UTC)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F4221FDA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402338; cv=none; b=hDgPqCNzku371lOIZetr2HU4lXh7cjmLg3YWGP77moEYxO3rwJ/q4bu3/H1ygHJyW3Akznw9qZwWchewMy1ZChYCq0Iv55VYKWdB4q0jt/z+x7UfN5A3q1qXHkfcAksmc4U/VUa0TkMkgjYpB04ZPEEpdGKwb082ZcfpFO0Pkb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402338; c=relaxed/simple;
	bh=7SDfJqBZlyCSmTajAiH22yc4TDpkvc1+Na74WeGVfQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G/tFke7JXQcAUb9ojQ25OeYF+KdjyYdezjOWHE0vxzAGBt/cAzohcg1wq4e8LwlZwfa6NVX/HttS3wAmfpOMPdrnGC/dMi9+vi08uRj7Y0juSxqNOuwJXF3LbU5/ndyIA/xo02ssHSnsu8m5R38e7fB4b+LSIXDt0NVqEpSfjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d27yY3qs7z1K96d;
	Thu,  6 Nov 2025 12:10:29 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 92A101A016C;
	Thu,  6 Nov 2025 12:12:03 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Nov
 2025 12:12:02 +0800
Message-ID: <bf38a9cb-41a9-4a40-ba17-afe679018003@hisilicon.com>
Date: Thu, 6 Nov 2025 12:12:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: topology: Improve AMU-based frequency
 calculation
To: Bowen Yu <yubowen8@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<beata.michalska@arm.com>, <ptsm@linux.microsoft.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
CC: <prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<xuwei5@huawei.com>, <zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>
References: <20251104075544.3243606-1-yubowen8@huawei.com>
 <20251104075544.3243606-2-yubowen8@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20251104075544.3243606-2-yubowen8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 11/4/2025 3:55 PM, Bowen Yu wrote:
> The current approach of reverse-calculating CPU frequency from capacity
> values introduces quantization errors due to intermediate scaling of
> arch_scale_freq_capacity, which results in the calculated frequency having
> only 1/1024 resolution.
> 
> This patch:
> 1. Directly computes frequency using AMU counters in amu_scale_freq_tick():
> freq = (core_cycles_delta * timer_freq) / (const_cycles_delta * 1000)
>  - core_cycles_delta: Measured CPU cycles
>  - timer_freq: Architectural timer frequency
>  - const_cycles_delta: Reference cycles from fixed-frequency timer
> 2. Returns pre-computed avgfreq in arch_freq_get_on_cpu()
> 
> examples:
> Before change
> [root@localhost ~]# cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_avg_freq
> 2297851
> 2297851
> 2295312
> 2297851
> 2297851
> 2295312
> 2297851
> 2295312
> 2297851
> 2297851
> 2297851
> 2295312
> 2295312
> 2297851
> 2297851
> 2297851
> 2297851
> 2300390
> 2297851
> 2297851
> 2297851
> 
> After change
> [root@localhost ~]# cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_avg_freq
> 2299177
> 2298117
> 2299188
> 2297330
> 2296530
> 2298817
> 2298434
> 2298986
> 2298596
> 2299395
> 2299560
> 2298446
> 2299108
> 2299294
> 2298707
> 2298453
> 2298632
> 2299218
> 2297962
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
...
> @@ -288,7 +293,7 @@ int arch_freq_get_on_cpu(int cpu)
>  	unsigned int start_cpu = cpu;
>  	unsigned long last_update;
>  	unsigned int freq = 0;
> -	u64 scale;
> +	u64 delta_core_kHz;
>  
>  	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>  		return -EOPNOTSUPP;
> @@ -340,14 +345,11 @@ int arch_freq_get_on_cpu(int cpu)
>  			break;
>  		}
>  	}
> -	/*
> -	 * Reversed computation to the one used to determine
> -	 * the arch_freq_scale value
> -	 * (see amu_scale_freq_tick for details)
> -	 */
> -	scale = arch_scale_freq_capacity(cpu);
> -	freq = scale * arch_scale_freq_ref(cpu);
> -	freq >>= SCHED_CAPACITY_SHIFT;
> +
> +	if (check_mul_overflow(per_cpu(core_delta, cpu), arch_timer_get_cntfrq(), &delta_core_kHz))
Hi Bowen,

IIUC, the variable 'delta_core_kHz' doesn't mean its name.
'core_delta * timer_freq' is just a transitional number.
The naming is misleading.

Perhaps consider reusing 'freq'? i.e. define 'freq' as u64 and replace
'delta_core_kHz' with 'freq', then return (int)freq at the end.

Jie
> +		return -EINVAL;
> +
> +	freq = div_u64(delta_core_kHz, per_cpu(const_delta, cpu) * HZ_PER_KHZ);
>  	return freq;
>  }
>  

