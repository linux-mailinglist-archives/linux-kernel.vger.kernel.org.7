Return-Path: <linux-kernel+bounces-765606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A28B23AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B8B1A21D82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993CA2D739F;
	Tue, 12 Aug 2025 21:29:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEA2D7386
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034162; cv=none; b=BkffrxA9cKLnSSSpNF2SoTt/T2xU/ZsMApJUKcCChk85/LyaK8JwVktfvvcifMuCW/UKF+jGqmvFMbR4TrdPy9/FcTTPIbr6VXV0vifQoG82zdQvQGxv8mWOc+QkR+STiF0KmDVx6UJincd2ZhsSYCbMYt1rY6A2ZkdfbB/B/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034162; c=relaxed/simple;
	bh=bOpoyvu/ZWbO47SQ5CoC25RHHvk18Ll/nfEeXHS47qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0u5VnxOpOCqhJH6RCf8NYZjOOiAIF2Fi2FPUZJSyRWKekwvwBEm/GkN9nzvjzrPoJ7HssrFXWFJzSJdzVM/yJ1nkSGLb9bmiTjb0aKYufQjiS1oPcTIQzZPdwA/v+zUoPuf4w/Ud41XfMwzjyP0j8pg5vqDABRy/PqB9syFWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D1C31758;
	Tue, 12 Aug 2025 14:29:11 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218793F63F;
	Tue, 12 Aug 2025 14:29:15 -0700 (PDT)
Message-ID: <b16979c4-47cf-4a9f-8f67-30f784933c05@arm.com>
Date: Tue, 12 Aug 2025 22:29:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, vdonnefort@google.com, ke.wang@unisoc.com,
 xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
References: <20250812093339.8895-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250812093339.8895-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 10:33, Xuewen Yan wrote:
> Now we use for_each_cpu() to traversal all pd's cpus,
> it is in order to compute the pd_cap. This approach may
> result in some unnecessary judgments.
> We can simply calculate pd_cap as follows:
> 
> pd_cap = cpu_actual_cap * cpumask_weight(pd_cpus);
> 
> Then we can AND pd'scpus, sd's cpus and task's cpus_ptr
> before traversing, which can save some unnecessary judgment.

IMO this would be clearer if it's:
Calculate pd_cap as follows:
...

instead of traversing ...

Other than that LGTM.

> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..e47fe94d6889 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8330,18 +8330,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		cpu_actual_cap = get_actual_cpu_capacity(cpu);
>  
>  		eenv.cpu_cap = cpu_actual_cap;
> -		eenv.pd_cap = 0;
> +		eenv.pd_cap = cpu_actual_cap * cpumask_weight(cpus);
>  
> -		for_each_cpu(cpu, cpus) {
> -			struct rq *rq = cpu_rq(cpu);
> -
> -			eenv.pd_cap += cpu_actual_cap;
> -
> -			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> -				continue;
> +		cpumask_and(cpus, cpus, sched_domain_span(sd));
>  
> -			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> -				continue;
> +		for_each_cpu_and(cpu, cpus, p->cpus_ptr) {
> +			struct rq *rq = cpu_rq(cpu);
>  
>  			util = cpu_util(cpu, p, cpu, 0);
>  			cpu_cap = capacity_of(cpu);


