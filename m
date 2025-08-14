Return-Path: <linux-kernel+bounces-768296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4DB25F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD78B644D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5A23B610;
	Thu, 14 Aug 2025 08:46:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3701DD0C7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161187; cv=none; b=BjC6V3MG7iYR0SMEKccZQ6jITy2ad+JlTYMTxVzjTo9WzDtbNQvYC+4YLAjoGVhSjXcEv+eggetmzahRiCkanlv1iFQV040NsAl3NhuEBHyjJQB8uy9gtLHkJ/iNDXOQplJmdRUm2c+6xRPgKhDE4SNVXeMZoyaadHRL8qOFuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161187; c=relaxed/simple;
	bh=REw+v6U5HjfZ8GlRbNV5DektWf+6ind2kNIhpdPnbF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYOWuqyzwDlq6OcnIxgCM3701sahOztbuAHMfKxhKndKGkfctLTExb33Id3X6ZjbsSXFQt4gkny5Iq4j/425d/8J+H0LvwFPG86He4DXUM+yrlsAo9WAx3ZYQP0nHsh46uf6MY1LpQlPfCyOnXCjHuezoK3zp6mw0KlRjFd/bO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8493168F;
	Thu, 14 Aug 2025 01:46:09 -0700 (PDT)
Received: from [10.13.87.1] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D2253F738;
	Thu, 14 Aug 2025 01:46:13 -0700 (PDT)
Message-ID: <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
Date: Thu, 14 Aug 2025 09:46:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, vdonnefort@google.com, ke.wang@unisoc.com,
 xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
References: <20250812093339.8895-1-xuewen.yan@unisoc.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20250812093339.8895-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.08.25 10:33, Xuewen Yan wrote:
> Now we use for_each_cpu() to traversal all pd's cpus,
> it is in order to compute the pd_cap. This approach may
> result in some unnecessary judgments.
> We can simply calculate pd_cap as follows:
> 
> pd_cap = cpu_actual_cap * cpumask_weight(pd_cpus);
> 
> Then we can AND pd'scpus, sd's cpus and task's cpus_ptr
> before traversing, which can save some unnecessary judgment.
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

Just a thought ...

for (; pd; pd = pd->next)

  cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);    <-- (1)
  cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);


  if (cpumask_empty(cpus))
    continue;                                               <-- (2)

Can you not mask cpus already early in the pd loop (1) and then profit
from (2) in these rare cases? IIRC, the sd only plays a role here in
exclusive cpusets scenarios which I don't thing anybody deploys with EAS?

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


