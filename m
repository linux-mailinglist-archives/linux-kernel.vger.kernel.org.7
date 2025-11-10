Return-Path: <linux-kernel+bounces-893756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED68C4843E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7383421894
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7662F747A;
	Mon, 10 Nov 2025 17:12:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EFA2FC011
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794720; cv=none; b=E0NWvBOV07nmL1ZbQ8NYCCsevmvZO8OgyoeH+9pt7JUeEqVyv0dVn5U8KY2OVXBQmw5MKs9rdm/sZ0B4Im5zqKFId17FiR0GlBI69FWcyHbAJjrcG7pUBhN1qMgBXvzgpdwTp28sWGD0zzkwG/67t8kRv3rW/E0IyPvjR4V/HC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794720; c=relaxed/simple;
	bh=lDMWQ5jqSUG6YGeWP90Wg/tpk4oTsCWn7MBkvj8jJlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0IFLT13mx7RBM+wsh7BP5crkYt8C8NoBcTMeNA0ysN5YNl7VbnNzYB/8n3Kbc7SNcEf2sttNiK7BKcyY63gyeW4q5r6HPeJArx7aMPxW2jOeJdFUxMEKVWLIjRHhh6HyQyU1rBK7TEmx1nfyVQ5yurrtuvwd1WFj+B0LxovKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61CAF2B;
	Mon, 10 Nov 2025 09:11:50 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458D73F66E;
	Mon, 10 Nov 2025 09:11:52 -0800 (PST)
Date: Mon, 10 Nov 2025 18:11:55 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Bowen Yu <yubowen8@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, ptsm@linux.microsoft.com,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
	zhangpengjie2@huawei.com
Subject: Re: [PATCH 2/3] arm64: topology: Use current freq in governor for
 idle cpus in cpuinfo_avg_freq
Message-ID: <aRIc20ErWTQr4dRa@arm.com>
References: <20251104075544.3243606-1-yubowen8@huawei.com>
 <20251104075544.3243606-3-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104075544.3243606-3-yubowen8@huawei.com>

On Tue, Nov 04, 2025 at 03:55:43PM +0800, Bowen Yu wrote:
> The current cpuinfo_avg_freq interface returns an error when all CPUs
> under a policy are idle, which is relatively common. To address this, it
> is better to use the current frequency stored in the governor. This
> implementation is also used on x86 architecture.
Well, the very reason of having this knob was not to mix hardware and software
view of so called 'current frequency'. Note that for x86 there is a dedicated
config option that keeps the behaviour you have mentioned for backward
compatibility.


cpuinfo_avg_freq -> average freq as seen by hw
cpuinfo_cur_freq -> closes one can get to current frequency - hw feedback
scaling_cur_freq -> requested freq, so smth the software believes should be the
		    current freq (often might not be)

The following thread might be useful -> [1]

---
[1] https://lore.kernel.org/all/20240603114811.oio3uemniib5uaa2@vireshk-i7/
---

BR
Beata

> 
> Since the current frequency in the governor is the last known frequency,
> it should be more user-friendly.
> 
> This patch also removes redundant !housekeeping_cpu() check since it is
> inherently done when checking jiffies.
> 
> Original output when all cpus under a policy are idle:
> [root@localhost home]# cat /sys/devices/system/cpu/cpufreq/policy0/
> cpuinfo_avg_freq
> cat: /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq: Resource
>  temporarily unavailable
> 
> Output after changes:
> [root@localhost home]# cat /sys/devices/system/cpu/cpufreq/policy0
> /cpuinfo_avg_freq
> 1200000
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index c0dbc27289ea..f1370a4a4df9 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -333,14 +333,13 @@ int arch_freq_get_on_cpu(int cpu)
>  				if (!idle_cpu(ref_cpu))
>  					break;
>  			}
> +
> +			if (ref_cpu >= nr_cpu_ids) {
> +				cpufreq_cpu_put(policy);
> +				return cpufreq_quick_get(start_cpu);
> +			}
>  
>  			cpufreq_cpu_put(policy);
> -
> -			if (ref_cpu >= nr_cpu_ids)
> -				/* No alternative to pull info from */
> -				return -EAGAIN;
> -
> -			cpu = ref_cpu;
>  		} else {
>  			break;
>  		}
> -- 
> 2.33.0

