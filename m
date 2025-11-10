Return-Path: <linux-kernel+bounces-893758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50936C4847D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC9B44F5FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E72857EA;
	Mon, 10 Nov 2025 17:15:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FC21CFF7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794938; cv=none; b=rA5tThY/i3mIEePUfBKaX9WRQFIW+XiNpSxZo8i0aVKLx2kkwLMGdQydy15GQql3p74IDvmAPZhtEjI0KOBs9r/wiq0xVfdtY2ws9N5bHpTmSCGBQN336g1wNLkEmT5AjGEJ2tSZzJFwdhNlbFPNEvR8k4dhUz2XXklPU/eVp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794938; c=relaxed/simple;
	bh=iym48tXfg6Bx7raPHknuaPFBGDiEF5GGNC3l4wtDn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8NMR0uH9l0apDpwggRXYmDJ72utfnrGaVu9XelNcTelXggVvZ+Q5wYPuLXeGFIYISMTLkdpTD4yRVrOXWAXoGFfBMbNkTU+tNkUIYSPNT7549QTMcmj60Wk4JohDz9qL8uhhRP9Mj/f9CFVUOwCm+JOFXOpOFGkRhKK1utAbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1783B2B;
	Mon, 10 Nov 2025 09:15:29 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03A023F66E;
	Mon, 10 Nov 2025 09:15:31 -0800 (PST)
Date: Mon, 10 Nov 2025 18:15:34 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Bowen Yu <yubowen8@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, ptsm@linux.microsoft.com,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
	zhangpengjie2@huawei.com
Subject: Re: [PATCH 3/3] arm64: topology: Remove redundant housekeeping_cpu()
 checks in arch_freq_get_on_cpu
Message-ID: <aRIdtuWAIen__yZU@arm.com>
References: <20251104075544.3243606-1-yubowen8@huawei.com>
 <20251104075544.3243606-4-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104075544.3243606-4-yubowen8@huawei.com>

On Tue, Nov 04, 2025 at 03:55:44PM +0800, Bowen Yu wrote:
> This patch removes redundant !housekeeping_cpu() check since it is
> inherently done when checking jiffies.
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index f1370a4a4df9..6981ef3019d3 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -310,20 +310,13 @@ int arch_freq_get_on_cpu(int cpu)
>  		 * (and thus freq scale), if available, for given policy: this boils
>  		 * down to identifying an active cpu within the same freq domain, if any.
>  		 */
> -		if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> -		    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> +		if (time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>  			struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  			int ref_cpu;
>  
>  			if (!policy)
>  				return -EINVAL;
>  
> -			if (!cpumask_intersects(policy->related_cpus,
> -						housekeeping_cpumask(HK_TYPE_TICK))) {
> -				cpufreq_cpu_put(policy);
> -				return -EOPNOTSUPP;
> -			}
Removing this means you will iterate over potentially dynamic-tick CPUs and
running the checks instead of skipping it here (plus other implications).
Is that intentional ?
---
BR
Beata
> -
>  			for_each_cpu_wrap(ref_cpu, policy->cpus, cpu + 1) {
>  				if (ref_cpu == start_cpu) {
>  					/* Prevent verifying same CPU twice */
> -- 
> 2.33.0
> 

