Return-Path: <linux-kernel+bounces-877974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE8C1F78F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EF019C2388
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01534F465;
	Thu, 30 Oct 2025 10:14:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF0934EF1C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819294; cv=none; b=ScPkKWRs4Cbjer5VZ3B8WxyveJwkCjfE3iKIVZWiko7x0SmfKdlbsvil7qsn7Ih3Iwymr9Lj2iaErgfyT6q3Xo+qXDzTuFW1J33P12/RNLjsgB0PxoyKwmUMva/oO82WF0+o4rYzKt4lFsbBTnJ5zXflhXiI968acAb+td6ohdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819294; c=relaxed/simple;
	bh=xDOgQa3xEfNq77Q36upxYeUb8km5wf0dHgGqmQp2vBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIE5DNu6RwgfnE3zjZ8NSW3/eCeGXnIBkSHsywJYatzwY1H35LY+KDVVoke0gtZQ8VSF4LGo22pr3XlOgqILPDEFIZjmiBszeW9As5HmvBowoZzGEkVTVzKE5aKNsoAeLHY4tYFhE+WWWhEHfit9ffdim2xbGXO2+OCZ6BRyoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 130C61EDB;
	Thu, 30 Oct 2025 03:14:44 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C6783F66E;
	Thu, 30 Oct 2025 03:14:49 -0700 (PDT)
Message-ID: <c22de852-f2f6-48d7-831f-ca2a06365783@arm.com>
Date: Thu, 30 Oct 2025 11:14:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
To: shubhang@os.amperecomputing.com, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Shubhang Kaushik <sh@gentwo.org>,
 Shijie Huang <Shijie.Huang@amperecomputing.com>,
 Frank Wang <zwang@amperecomputing.com>
Cc: Christopher Lameter <cl@gentwo.org>, Adam Li
 <adam.li@amperecomputing.com>, linux-kernel@vger.kernel.org
References: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.10.25 01:00, Shubhang Kaushik via B4 Relay wrote:
> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> 
> Modify the wakeup path in `select_task_rq_fair()` to prioritize cache
> locality for waking tasks. The previous fast path always attempted to
> find an idle sibling, even if the task's prev CPU was not truly busy.
> 
> The original problem was that under some circumstances, this could lead
> to unnecessary task migrations away from a cache-hot core, even when
> the task's prev CPU was a suitable candidate. The scheduler's internal
> mechanism `cpu_overutilized()` provide an evaluation of CPU load.
> 
> To address this, the wakeup heuristic is updated to check the status of
> the task's `prev_cpu` first:
> - If the `prev_cpu` is  not overutilized (as determined by
>   `cpu_overutilized()`, via PELT), the task is woken up on
>   its previous CPU. This leverages cache locality and avoids
>   a potentially unnecessary migration.
> - If the `prev_cpu` is considered busy or overutilized, the scheduler
>   falls back to the existing behavior of searching for an idle sibling.

How does you sched domain topology look like? How many CPUs do you have
in your MC domain?

> 
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
> This patch optimizes the scheduler's wakeup path to prioritize cache 
> locality by keeping a task on its previous CPU if it is not overutilized,
> falling back to a sibling search only when necessary.
> ---
>  kernel/sched/fair.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d6bbe616953f530f7a02bb619537c..bb0d28d7d9872642cb5a4076caeb3ac9d8fe7bcd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8618,7 +8618,16 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>  		/* Fast path */
> -		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +
> +		/*
> +		 * Avoid wakeup on an overutilized CPU.
> +		 * If the previous CPU is not overloaded, retain the same for cache locality.
> +		 * Otherwise, search for an idle sibling.
> +		 */
> +		if (!cpu_overutilized(prev_cpu))
> +			new_cpu = prev_cpu;

IMHO, special conditions like this one are normally coded at the
beginning of select_idle_sibling().

[...]

