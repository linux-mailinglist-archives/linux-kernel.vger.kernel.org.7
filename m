Return-Path: <linux-kernel+bounces-893745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAECC483A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46E84F3746
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6A2882AA;
	Mon, 10 Nov 2025 17:04:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2E28314E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794248; cv=none; b=uY71AUnGYjdJT9w1wqfM+AQJ+kkIlVuuOIdhGAq0xAv1GnXExlzfnheWHLriKGsLEDSY2so9uBlNukL88XnxO7w3GdKNiiCZUglMuIa+It7Lk+QjBEIIZYuTiVnq+vAVw+Pab576O4pa+L8F2GcXbVkxMdPPROHnMs58DHkdCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794248; c=relaxed/simple;
	bh=9p9th6oFGnGWagzvVd99AelZoOneibcjQgWEEE9+TDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO5Met5Ak+R+U3DDBKtUKEUSF9ZTCW20BogpEZ25GxbdvZ3Zgq/NZbFxSyduiybh6eiCas0MfCr5Nic6DOEyPr5HRMUj4+KPBvykChc3G379VB0UTdQFwCbmNs4r3AKiRh+AC0xOLrglp4V7Lu+T3g682QsnCVloWNc8wxKjdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF422B;
	Mon, 10 Nov 2025 09:03:58 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADF43F66E;
	Mon, 10 Nov 2025 09:04:01 -0800 (PST)
Date: Mon, 10 Nov 2025 18:04:04 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Bowen Yu <yubowen8@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, ptsm@linux.microsoft.com,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
	zhangpengjie2@huawei.com
Subject: Re: [PATCH 1/3] arm64: topology: Improve AMU-based frequency
 calculation
Message-ID: <aRIbBBBl8mxd2rtC@arm.com>
References: <20251104075544.3243606-1-yubowen8@huawei.com>
 <20251104075544.3243606-2-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104075544.3243606-2-yubowen8@huawei.com>

On Tue, Nov 04, 2025 at 03:55:42PM +0800, Bowen Yu wrote:
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
Based on your numbers the shift is on average ~0.055–0.057%.
I'm not entirely convinced it is worth it, especially that this is an average
frequency. What is the use case here if < 0,2% makes a difference ?

---
BR
Beata
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 5d07ee85bdae..c0dbc27289ea 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -20,6 +20,7 @@
>  #include <linux/percpu.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/xarray.h>
> +#include <linux/units.h>
>  
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
> @@ -144,6 +145,8 @@ int __init parse_acpi_topology(void)
>   */
>  static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
>  static cpumask_var_t amu_fie_cpus;
> +static DEFINE_PER_CPU(unsigned long, core_delta);
> +static DEFINE_PER_CPU(unsigned long, const_delta);
>  
>  struct amu_cntr_sample {
>  	u64		arch_const_cycles_prev;
> @@ -246,6 +249,7 @@ static void amu_scale_freq_tick(void)
>  	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
>  	 */
>  	scale = core_cnt - prev_core_cnt;
> +	this_cpu_write(core_delta, scale);
>  	scale *= this_cpu_read(arch_max_freq_scale);
>  	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
>  			  const_cnt - prev_const_cnt);
> @@ -253,6 +257,7 @@ static void amu_scale_freq_tick(void)
>  	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>  	this_cpu_write(arch_freq_scale, (unsigned long)scale);
>  
> +	this_cpu_write(const_delta, const_cnt - prev_const_cnt);
>  	amu_sample->last_scale_update = jiffies;
>  }
>  
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
> +		return -EINVAL;
> +
> +	freq = div_u64(delta_core_kHz, per_cpu(const_delta, cpu) * HZ_PER_KHZ);
>  	return freq;
>  }
>  
> -- 
> 2.33.0
> 

