Return-Path: <linux-kernel+bounces-853081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986CBDA994
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EF15485ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD163009FA;
	Tue, 14 Oct 2025 16:22:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D319F30100B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458935; cv=none; b=m0RbKInkHJwperQKbJ0jyftLykZMaePSESkdJpTD2K+5RW0VphLJyZxK6FOZQmsxUHnM3EaFrDan7Y0HIRzR8/sXelb9LwRbBm9awhkDREjm9eOx3CtE8oEBXGs4XXi94AcZs+TmyK4spyG2qX3sIgKus4/aVAQtIXKGAz0tiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458935; c=relaxed/simple;
	bh=nnOhnQ7QfNZInl50cbF+eAFbfwZLKGVvLl4xtBB9/QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjDGbF6z8l+oGMcb9tm/Pyt5YlN9ABi9FuNVALF5/kZdOq9GCxcc3rGJhLKGvF6sZADIY4O1cHYJkRu8FokjgGewjV7CkEsJDcHgeFnxXzqzZxTu1h8SovvwqZFfhL930SHB+VS6eEMAGM0jbBwip43GcaLVkULxaCDF4PFvyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E34F31A9A;
	Tue, 14 Oct 2025 09:22:03 -0700 (PDT)
Received: from [10.1.36.66] (unknown [10.1.36.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5C53F738;
	Tue, 14 Oct 2025 09:22:09 -0700 (PDT)
Message-ID: <9c02e7a4-a926-4a6b-9fa2-7586ad934134@arm.com>
Date: Tue, 14 Oct 2025 17:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched: Fix some spelling mistakes in the scheduler
 module
To: Jianyun Gao <jianyungao89@gmail.com>, vineethr@linux.ibm.com
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
 vschneid@redhat.com
References: <20251009081813.157037-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251009081813.157037-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/25 09:18, Jianyun Gao wrote:
> From: "jianyun.gao" <jianyungao89@gmail.com>
> 
> The following are some spelling mistakes existing in the scheduler
> module. Just fix it!
> 
>   slection -> selection
>   achitectures -> architectures
>   excempt -> exempt
>   incorectly -> incorrectly
>   litle -> little
>   faireness -> fairness
>   condtion -> condition
>   re-insterted -> re-inserted
> 
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
> v4:
> Change "excempt" to "exempt" and correct "re-insterted" to
> "re-inserted".
> 
> The previous version is here:
> 
> https://lore.kernel.org/lkml/20251009024657.151767-1-jianyungao89@gmail.com/
> 
>  kernel/sched/core.c     | 2 +-
>  kernel/sched/cputime.c  | 2 +-
>  kernel/sched/fair.c     | 8 ++++----
>  kernel/sched/wait_bit.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7f1e5cb94c53..af5076e40567 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_mode)
>  		/*
>  		 * We pass task_is_blocked() as the should_block arg
>  		 * in order to keep mutex-blocked tasks on the runqueue
> -		 * for slection with proxy-exec (without proxy-exec
> +		 * for selection with proxy-exec (without proxy-exec
>  		 * task_is_blocked() will always be false).
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 7097de2c8cda..2429be5a5e40 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
>  	/*
>  	 * Because mul_u64_u64_div_u64() can approximate on some
> -	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> +	 * architectures; enforce the constraint that: a*b/(b+c) <= a.
>  	 */
>  	if (unlikely(stime > rtime))
>  		stime = rtime;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 18a30ae35441..21ab67fd7d76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		bool delay = sleep;
>  		/*
>  		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> -		 * states must not suffer spurious wakeups, excempt them.
> +		 * states must not suffer spurious wakeups, exempt them.
>  		 */
>  		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
>  			delay = false;
> @@ -5842,7 +5842,7 @@ static bool enqueue_throttled_task(struct task_struct *p)
>  	 * target cfs_rq's limbo list.
>  	 *
>  	 * Do not do that when @p is current because the following race can
> -	 * cause @p's group_node to be incorectly re-insterted in its rq's
> +	 * cause @p's group_node to be incorrectly re-inserted in its rq's
>  	 * cfs_tasks list, despite being throttled:
>  	 *
>  	 *     cpuX                       cpuY
> @@ -12161,7 +12161,7 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
>  		 * sched_balance_newidle() bumps the cost whenever newidle
>  		 * balance fails, and we don't want things to grow out of
>  		 * control.  Use the sysctl_sched_migration_cost as the upper
> -		 * limit, plus a litle extra to avoid off by ones.
> +		 * limit, plus a little extra to avoid off by ones.
>  		 */
>  		sd->max_newidle_lb_cost =
>  			min(cost, sysctl_sched_migration_cost + 200);
> @@ -13176,7 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  	 * If a task gets attached to this cfs_rq and before being queued,
>  	 * it gets migrated to another CPU due to reasons like affinity
>  	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
> -	 * that removed load decayed or it can cause faireness problem.
> +	 * that removed load decayed or it can cause fairness problem.
>  	 */
>  	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
>  		list_add_leaf_cfs_rq(cfs_rq);
> diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
> index 1088d3b7012c..47ab3bcd2ebc 100644
> --- a/kernel/sched/wait_bit.c
> +++ b/kernel/sched/wait_bit.c
> @@ -207,7 +207,7 @@ EXPORT_SYMBOL(init_wait_var_entry);
>   * given variable to change.  wait_var_event() can be waiting for an
>   * arbitrary condition to be true and associates that condition with an
>   * address.  Calling wake_up_var() suggests that the condition has been
> - * made true, but does not strictly require the condtion to use the
> + * made true, but does not strictly require the condition to use the
>   * address given.
>   *
>   * The wake-up is sent to tasks in a waitqueue selected by hash from a


This is fine for me now FWIW.


