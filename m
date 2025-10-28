Return-Path: <linux-kernel+bounces-874020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E89C15518
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B167354B83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E62D543E;
	Tue, 28 Oct 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVA5qTB5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701622E0923
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663957; cv=none; b=bJp8KcE3kNdOJT2uBYeqe8qdKf39509ogwnp5DjYdC7tJdS5WN6nve1XqxurVN8OSmjnWQNsPD3ykC8ZaGtfyKhB08W0oJ+XucZcJC3hddbp7LUEsfDzGG3cXO8JFPKVYoX7o20CPMcwsaqw7ApLkkj1cWhoaJe41ijykOfViPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663957; c=relaxed/simple;
	bh=/jw0dHt7nlwo2GnWdieD+H9LY9o/uKXOvGD0duCYNX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukx2rTl1SwFrkhLxUn4phsxmuYWJykTKE68ZUh/cw75o9qkUnxATTeoxx/qSGznLh8ajt2WwVgd4DFEKGCGBpd/GqVt3JPmIPE708ZUL4b33kkz7xft4+VVyqj8l77BUSpN8qdDv9APyuImhdXr4jy7wviKPzh86MvTIU7ybQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BVA5qTB5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qddToMf8NxUDqxxgakKH4fRdkOoETkW3AQBZlgdpUnQ=; b=BVA5qTB5dUFsH5LcHFE8Ubw4lj
	OGBD6DlFjUslA5yMtcDLc6iwB7O1tfce0ONr20ixa80NrvpjVmIlVxGm1osavzSjafP46FZY5Yx2J
	/v+nWoEwgfFt0bEz9849KJtl7UY0V47vWQKXxE6c6yF9gjP1xfFED9WZmtUKAHm/h+XrONapY5G0J
	YA5vN+VjM6/N7MZYfDn1A1D1blDVamtmq3ZKzz2c4awuRBJx7HNSLlZuc1LyXlztIYCIckBPuduzu
	i8IYbTctniI8U7dxzQruRyQXCWCeOtwvVsN3R7E/dO3T4DApvZqbXe3Dtmme3/AgtkRbS8gTknq0C
	qVNCtYRA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDkOt-00000004cBb-1HT3;
	Tue, 28 Oct 2025 14:10:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BCC5D30023C; Tue, 28 Oct 2025 16:05:45 +0100 (CET)
Date: Tue, 28 Oct 2025 16:05:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251028150545.GC4067720@noisy.programming.kicks-ass.net>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027133915.4103633-3-mgorman@techsingularity.net>

On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:


Still going through this; just a few early comments.


>  kernel/sched/fair.c | 137 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 117 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d..158e0430449b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1193,6 +1203,91 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
>  	return delta_exec;
>  }
>  
> +enum preempt_wakeup_action {
> +	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
> +	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
> +					 * before rescheduling.
> +					 */
> +	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
> +};
> +
> +static void set_next_buddy(struct sched_entity *se);
> +
> +static inline enum preempt_wakeup_action
> +__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
> +		 struct sched_entity *pse, struct sched_entity *se)
> +{
> +	bool pse_before;
> +
> +	/*
> +	 * Ignore wakee preemption on WF_WORK as it is less likely that
> +	 * there is shared data as exec often follow fork. Do not
> +	 * preempt for tasks that are sched_delayed as it would violate
> +	 * EEVDF to forcibly queue an ineligible task.
> +	 */
> +	if (!sched_feat(NEXT_BUDDY) ||
> +	    (wake_flags & WF_FORK) ||
> +	    (pse->sched_delayed)) {
> +		return PREEMPT_WAKEUP_NONE;
> +	}
> +
> +	/* Reschedule if waker is no longer eligible. */
> +	if (!entity_eligible(cfs_rq, se))
> +		return PREEMPT_WAKEUP_RESCHED;
> +
> +	/*
> +	 * Keep existing buddy if the deadline is sooner than pse.
> +	 * The downside is that the older buddy may be cache cold
> +	 * but that is unpredictable where as an earlier deadline
> +	 * is absolute.
> +	 */
> +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> +		return PREEMPT_WAKEUP_NONE;
> +
> +	set_next_buddy(pse);
> +
> +	/*
> +	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
> +	 * strictly enforced because the hint is either misunderstood or
> +	 * multiple tasks must be woken up.
> +	 */
> +	pse_before = entity_before(pse, se);
> +	if (wake_flags & WF_SYNC) {
> +		u64 delta = rq_clock_task(rq) - se->exec_start;
> +		u64 threshold = sysctl_sched_migration_cost;
> +
> +		/*
> +		 * WF_SYNC without WF_TTWU is not expected so warn if it
> +		 * happens even though it is likely harmless.
> +		 */
> +		WARN_ON_ONCE(!(wake_flags | WF_TTWU));
> +
> +		if ((s64)delta < 0)
> +			delta = 0;
> +
> +		/*
> +		 * WF_RQ_SELECTED implies the tasks are stacking on a
> +		 * CPU when they could run on other CPUs. Reduce the
> +		 * threshold before preemption is allowed to an
> +		 * arbitrary lower value as it is more likely (but not
> +		 * guaranteed) the waker requires the wakee to finish.
> +		 */
> +		if (wake_flags & WF_RQ_SELECTED)
> +			threshold >>= 2;
> +
> +		/*
> +		 * As WF_SYNC is not strictly obeyed, allow some runtime for
> +		 * batch wakeups to be issued.
> +		 */
> +		if (pse_before && delta >= threshold)
> +			return PREEMPT_WAKEUP_RESCHED;
> +
> +		return PREEMPT_WAKEUP_NONE;
> +	}
> +
> +	return PREEMPT_WAKEUP_NEXT;
> +}

All this seems weirdly placed inside the file. Is there a reason this is
placed so far away from its only caller?

>  /*
>   * Used by other classes to account runtime.
>   */

> @@ -7028,8 +7113,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	hrtick_update(rq);
>  }
>  
> -static void set_next_buddy(struct sched_entity *se);
> -
>  /*
>   * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
>   * failing half-way through and resume the dequeue later.
> @@ -8734,7 +8817,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	struct sched_entity *se = &donor->se, *pse = &p->se;
>  	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
>  	int cse_is_idle, pse_is_idle;
> -	bool do_preempt_short = false;
> +	enum preempt_wakeup_action do_preempt_short = PREEMPT_WAKEUP_NONE;

naming seems off; I'm not sure what this still has to do with short.
Perhaps just preempt_action or whatever?

>  
>  	if (unlikely(se == pse))
>  		return;
> @@ -8748,10 +8831,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (task_is_throttled(p))
>  		return;
>  
> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> -		set_next_buddy(pse);
> -	}
> -
>  	/*
>  	 * We can come here with TIF_NEED_RESCHED already set from new task
>  	 * wake up path.
> @@ -8783,7 +8862,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  		 * When non-idle entity preempt an idle entity,
>  		 * don't give idle entity slice protection.
>  		 */
> -		do_preempt_short = true;
> +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
>  		goto preempt;
>  	}
>  
> @@ -8802,7 +8881,25 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	 * If @p has a shorter slice than current and @p is eligible, override
>  	 * current's slice protection in order to allow preemption.
>  	 */
> -	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
> +	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
> +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
> +	} else {
> +		/*
> +		 * If @p potentially is completing work required by current then
> +		 * consider preemption.
> +		 */
> +		do_preempt_short = __do_preempt_buddy(rq, cfs_rq, wake_flags,
> +						      pse, se);
> +	}
> +
> +	switch (do_preempt_short) {
> +	case PREEMPT_WAKEUP_NONE:
> +		return;
> +	case PREEMPT_WAKEUP_RESCHED:
> +		goto preempt;
> +	case PREEMPT_WAKEUP_NEXT:
> +		break;
> +	}
>  
>  	/*
>  	 * If @p has become the most eligible task, force preemption.
> @@ -8810,7 +8907,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
>  		goto preempt;
>  
> -	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
> +	if (sched_feat(RUN_TO_PARITY) && do_preempt_short != PREEMPT_WAKEUP_NONE)
>  		update_protect_slice(cfs_rq, se);

WAKEUP_NONE did a return above, I don't think you can get here with
WAKEUP_NONE, making the above condition always true.

