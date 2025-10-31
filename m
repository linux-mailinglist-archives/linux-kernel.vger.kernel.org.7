Return-Path: <linux-kernel+bounces-879920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D205C2463D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B9D84E4AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9E334C17;
	Fri, 31 Oct 2025 10:17:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28F33F8BA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905833; cv=none; b=lW7t3I7XBDdRv5Rg63/ZHaftZBiq9dq4b9+MT3jua1cR8iBv4jyLza/6Qq/eC945smnltySPK1Zh6a0To0pOTCvoUwExOjYTZQxRk60qVGn014g9Fi64lB2nHqrw4CRALY0D0cuAD+wy3uDzAfBa3Dl7wCcvrbM0yp30Et7Uo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905833; c=relaxed/simple;
	bh=+pis7+ZNnJnbSfB1IZE62P3r6KUIstDnQ3XvjGz/ACg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtnkUhZTGd2ec+NPdfG3bvNntUz/hiWH9G5/ERnBgMgH42kD7TeBNlMqm4Td+U2qGCt0hyW/Wq39gUetGr5HnYb7UL2paPUst5+ANNfikS18FCx/LU3sQp9GtrulhtIjYWzgJkFwC0FaRp9AV6Rus4vwLr9pFfrI3f5S9pww+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FCA21595;
	Fri, 31 Oct 2025 03:16:56 -0700 (PDT)
Received: from [10.57.37.29] (unknown [10.57.37.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 092CE3F673;
	Fri, 31 Oct 2025 03:17:01 -0700 (PDT)
Message-ID: <394a9798-06e4-4e61-b081-eeecbc67a22d@arm.com>
Date: Fri, 31 Oct 2025 10:17:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
To: shubhang@os.amperecomputing.com, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Shubhang Kaushik <sh@gentwo.org>,
 Shijie Huang <Shijie.Huang@amperecomputing.com>,
 Frank Wang <zwang@amperecomputing.com>
Cc: Christopher Lameter <cl@gentwo.org>, Adam Li
 <adam.li@amperecomputing.com>, linux-kernel@vger.kernel.org
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 19:19, Shubhang Kaushik via B4 Relay wrote:
> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> 
> When Energy Aware Scheduling (EAS) is enabled, a task waking up on a
> sibling CPU might migrate away from its previous CPU even if that CPU
> is not overutilized. This sacrifices cache locality and introduces
> unnecessary migration overhead.
> 
> This patch refines the wakeup heuristic in `select_idle_sibling()`. If
> EAS is active and the task's previous CPU (`prev`) is not overutilized,
> the scheduler will prioritize waking the task on `prev`, avoiding an
> unneeded migration and preserving cache-hotness.
> 
> ---
> v2:
> - Addressed reviewer comments to handle this special condition
>   within the selection logic, prioritizing the
>   previous CPU if not overutilized for EAS.
> - Link to v1: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/
> 
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb27959bc130d288d5f80677f75f8db8b..ac94463627778f09522fb5420f67b903a694ad4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7847,9 +7847,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    asym_fits_cpu(task_util, util_min, util_max, target))
>  		return target;
>  
> -	/*
> -	 * If the previous CPU is cache affine and idle, don't be stupid:
> -	 */
> +	/* Reschedule on an idle, cache-sharing sibling to preserve affinity: */
>  	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> @@ -7861,6 +7859,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  		prev_aff = prev;
>  	}
>  
> +	/*
> +	 * If the previous CPU is not overutilized, prefer it for cache locality.
> +	 * This prevents migration away from a cache-hot CPU that can still
> +	 * handle the task without causing an overload.
> +	 */
> +	if (sched_energy_enabled() && !cpu_overutilized(prev))
> +		return prev;
> +
>  	/*
>  	 * Allow a per-cpu kthread to stack with the wakee if the
>  	 * kworker thread and the tasks previous CPUs are the same.
> 
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-b4-follow-up-ff03b4533a2d
> 
> Best regards,

So if you're actually targetting EAS I don't get why you would check overutilized (instead
of asym_fits, what about uclamp?) but also, given that many EAS systems have only one common
llc I don't quite get why you would want this anyway.
Do you have a system / workload showing a benefit?
(I find with EAS heavily relying on wakeups, what we do in the slow path isn't that important
for most workloads...)

