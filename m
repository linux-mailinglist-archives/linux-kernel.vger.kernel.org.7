Return-Path: <linux-kernel+bounces-883036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FCC2C5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AE83A5B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FCC2701B8;
	Mon,  3 Nov 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFSdm/FD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6019F127
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178842; cv=none; b=qgn0SoRyxSpiBykSsyVlUMj842fM+L3u39x37IenFx+nDpECipIIeq5+8uIrUekbIh8AQAQOUeNPcUwkBgIV/38Bj0iLM10q/sAtQL3zC/ALeIX79udoBzEpuX+cs4PXsfnhIj9uoAJe/Iun70rgpQj54Pb+jzyAHJpnpJp2QWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178842; c=relaxed/simple;
	bh=d2355i4I7tNlqIS7cE+U9TWb4H8MTItcarH3mOmva7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shFkwZjxE05Jwfyi33bma1Y7+HREL7PdMMhmHDwAGVxFugeWrWzDRU5oIiFYvwml5qkB24M1Cqa0katTJWgGYhrO1yBp+jGoGRSbEpCF92R6istdAzFqN46sEm2Guh5TAKP6VAz0XdR9tEi5A4Ooi4U17uTtwfyu7FkbHOM/uOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MFSdm/FD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b6a2FM4yJs30Oc+G0lvCWRyuer3NN9X8hHfPekPXWME=; b=MFSdm/FDLoe/msUZLy0oAq6Ysk
	/AWiNpf0T+6WSJ/66qZSHMkz/hIi5Po9QZA0HrLUnI5hcy65gLYplI1nG7noHbJNJpLFk9JH+3sdA
	2P60KURerBJAleUE21vlqAJQvigJeD6rFRY6HbhLdgLMvbNqGyJCQsh8P+wP7X7cSjZvT9uN0m0nL
	mDbcKcxGDcORnlu+Gukd6XZWSZX2VdqOCdmZb1hoftQrOa9N+KMtW+IBM8NnnaQ2WgHVIpQiU2qYV
	LWcMzbR1/amOGEFS6Frie3MwD5XCrR/Bcwy4nCoy/2564kKPwhbksTKiCv46Cu+6X6+vUd7uQdIug
	GRpEmh6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvDD-00000008A6i-2sui;
	Mon, 03 Nov 2025 14:07:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B668530023C; Mon, 03 Nov 2025 15:07:11 +0100 (CET)
Date: Mon, 3 Nov 2025 15:07:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251103140711.GB3245006@noisy.programming.kicks-ass.net>
References: <20251103110445.3503887-1-mgorman@techsingularity.net>
 <20251103110445.3503887-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103110445.3503887-3-mgorman@techsingularity.net>

On Mon, Nov 03, 2025 at 11:04:45AM +0000, Mel Gorman wrote:

> @@ -8725,6 +8725,91 @@ static void set_next_buddy(struct sched_entity *se)
>  	}
>  }
>  
> +enum preempt_wakeup_action {
> +	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
> +	PREEMPT_WAKEUP_SHORT,		/* Override current's slice
> +					 * protection to allow
> +					 * preemption.
> +					 */
> +	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
> +					 * before rescheduling.
> +					 */
> +	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
> +};

Not really a fan of that comment style. While noodling, I've managed to
'accidentally' rename NEXT to PICK, since its more about letting
__pick_eevdf() decide.

> +static inline enum preempt_wakeup_action
> +__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
> +		 struct sched_entity *pse, struct sched_entity *se)
> +{
> +	bool pse_before;
> +
> +	/*
> +	 * Ignore wakee preemption on WF_FORK as it is less likely that
> +	 * there is shared data as exec often follow fork. Do not
> +	 * preempt for tasks that are sched_delayed as it would violate
> +	 * EEVDF to forcibly queue an ineligible task.
> +	 */
> +	if ((wake_flags & WF_FORK) || pse->sched_delayed)
> +		return PREEMPT_WAKEUP_NONE;
> +
> +	/* Reschedule if waker is no longer eligible. */
> +	if (in_task() && !entity_eligible(cfs_rq, se))
> +		return PREEMPT_WAKEUP_RESCHED;
> +
> +	/*
> +	 * Keep existing buddy if the deadline is sooner than pse.
> +	 * The older buddy may be cache cold and completely unrelated
> +	 * to the current wakeup but that is unpredictable where as
> +	 * obeying the deadline is more in line with EEVDF objectives.
> +	 */
> +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> +		return PREEMPT_WAKEUP_NEXT;
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
> +		WARN_ON_ONCE(!(wake_flags & WF_TTWU));
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

This seems to do 3 things:

 - that reschedule waker on !eligible
 - set the buddy (while losing NEXT_BUDDY)
 - the WF_SYNC thing

Let's split that out.

> @@ -8734,7 +8819,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	struct sched_entity *se = &donor->se, *pse = &p->se;
>  	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
>  	int cse_is_idle, pse_is_idle;
> -	bool do_preempt_short = false;
> +	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_NONE;

I'm thinking NONE is the wrong default

>  
>  	if (unlikely(se == pse))
>  		return;
> @@ -8748,10 +8833,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (task_is_throttled(p))
>  		return;
>  
> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> -		set_next_buddy(pse);
> -	}

This was the only NEXT_BUDDY site and none were returned in trade.

>  	/*
>  	 * We can come here with TIF_NEED_RESCHED already set from new task
>  	 * wake up path.
> @@ -8783,7 +8864,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  		 * When non-idle entity preempt an idle entity,
>  		 * don't give idle entity slice protection.
>  		 */
> -		do_preempt_short = true;
> +		preempt_action = PREEMPT_WAKEUP_SHORT;
>  		goto preempt;
>  	}
>  
> @@ -8802,21 +8883,41 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	 * If @p has a shorter slice than current and @p is eligible, override
>  	 * current's slice protection in order to allow preemption.
>  	 */
> -	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
> +	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
> +		preempt_action = PREEMPT_WAKEUP_SHORT;
> +	} else {
> +		/*
> +		 * If @p potentially is completing work required by current then
> +		 * consider preemption.
> +		 */
> +		preempt_action = __do_preempt_buddy(rq, cfs_rq, wake_flags,
> +						      pse, se);
> +	}
> +
> +	switch (preempt_action) {
> +	case PREEMPT_WAKEUP_NONE:
> +		return;
> +	case PREEMPT_WAKEUP_RESCHED:
> +		goto preempt;
> +	case PREEMPT_WAKEUP_SHORT:
> +		fallthrough;
(this is redundant)
> +	case PREEMPT_WAKEUP_NEXT:
> +		break;
> +	}
>  
>  	/*
>  	 * If @p has become the most eligible task, force preemption.
>  	 */
> -	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
> +	if (__pick_eevdf(cfs_rq, preempt_action != PREEMPT_WAKEUP_SHORT) == pse)
>  		goto preempt;
>  
> -	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
> +	if (sched_feat(RUN_TO_PARITY))
>  		update_protect_slice(cfs_rq, se);
>  
>  	return;
>  
>  preempt:
> -	if (do_preempt_short)
> +	if (preempt_action == PREEMPT_WAKEUP_SHORT)
>  		cancel_protect_slice(se);
>  
>  	resched_curr_lazy(rq);

Right, much better. But since I was noddling, how about something like
so on top?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8727,23 +8727,16 @@ static void set_next_buddy(struct sched_
 }
 
 enum preempt_wakeup_action {
-	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
-	PREEMPT_WAKEUP_SHORT,		/* Override current's slice
-					 * protection to allow
-					 * preemption.
-					 */
-	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
-					 * before rescheduling.
-					 */
-	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
+	PREEMPT_WAKEUP_NONE,	/* No preemption. */
+	PREEMPT_WAKEUP_SHORT,	/* Ignore slice protection. */
+	PREEMPT_WAKEUP_PICK,	/* Let __pick_eevdf() decide. */
+	PREEMPT_WAKEUP_RESCHED,	/* Force reschedule. */
 };
 
-static inline enum preempt_wakeup_action
-__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
-		 struct sched_entity *pse, struct sched_entity *se)
+static inline void
+set_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
+		  struct sched_entity *pse, struct sched_entity *se)
 {
-	bool pse_before;
-
 	/*
 	 * Ignore wakee preemption on WF_FORK as it is less likely that
 	 * there is shared data as exec often follow fork. Do not
@@ -8751,11 +8744,7 @@ __do_preempt_buddy(struct rq *rq, struct
 	 * EEVDF to forcibly queue an ineligible task.
 	 */
 	if ((wake_flags & WF_FORK) || pse->sched_delayed)
-		return PREEMPT_WAKEUP_NONE;
-
-	/* Reschedule if waker is no longer eligible. */
-	if (in_task() && !entity_eligible(cfs_rq, se))
-		return PREEMPT_WAKEUP_RESCHED;
+		return;
 
 	/*
 	 * Keep existing buddy if the deadline is sooner than pse.
@@ -8764,63 +8753,62 @@ __do_preempt_buddy(struct rq *rq, struct
 	 * obeying the deadline is more in line with EEVDF objectives.
 	 */
 	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
-		return PREEMPT_WAKEUP_NEXT;
+		return;
 
 	set_next_buddy(pse);
+}
 
-	/*
-	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
-	 * strictly enforced because the hint is either misunderstood or
-	 * multiple tasks must be woken up.
-	 */
-	pse_before = entity_before(pse, se);
-	if (wake_flags & WF_SYNC) {
-		u64 delta = rq_clock_task(rq) - se->exec_start;
-		u64 threshold = sysctl_sched_migration_cost;
-
-		/*
-		 * WF_SYNC without WF_TTWU is not expected so warn if it
-		 * happens even though it is likely harmless.
-		 */
-		WARN_ON_ONCE(!(wake_flags & WF_TTWU));
+/*
+ * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
+ * strictly enforced because the hint is either misunderstood or
+ * multiple tasks must be woken up.
+ */
+static inline enum preempt_wakeup_action
+preempt_sync(struct rq *rq, int wake_flags,
+	     struct sched_entity *pse, struct sched_entity *se)
+{
+	u64 delta = rq_clock_task(rq) - se->exec_start;
+	u64 threshold = sysctl_sched_migration_cost;
 
-		if ((s64)delta < 0)
-			delta = 0;
+	/*
+	 * WF_SYNC without WF_TTWU is not expected so warn if it
+	 * happens even though it is likely harmless.
+	 */
+	WARN_ON_ONCE(!(wake_flags & WF_TTWU));
 
-		/*
-		 * WF_RQ_SELECTED implies the tasks are stacking on a
-		 * CPU when they could run on other CPUs. Reduce the
-		 * threshold before preemption is allowed to an
-		 * arbitrary lower value as it is more likely (but not
-		 * guaranteed) the waker requires the wakee to finish.
-		 */
-		if (wake_flags & WF_RQ_SELECTED)
-			threshold >>= 2;
+	if ((s64)delta < 0)
+		delta = 0;
 
-		/*
-		 * As WF_SYNC is not strictly obeyed, allow some runtime for
-		 * batch wakeups to be issued.
-		 */
-		if (pse_before && delta >= threshold)
-			return PREEMPT_WAKEUP_RESCHED;
+	/*
+	 * WF_RQ_SELECTED implies the tasks are stacking on a
+	 * CPU when they could run on other CPUs. Reduce the
+	 * threshold before preemption is allowed to an
+	 * arbitrary lower value as it is more likely (but not
+	 * guaranteed) the waker requires the wakee to finish.
+	 */
+	if (wake_flags & WF_RQ_SELECTED)
+		threshold >>= 2;
 
-		return PREEMPT_WAKEUP_NONE;
-	}
+	/*
+	 * As WF_SYNC is not strictly obeyed, allow some runtime for
+	 * batch wakeups to be issued.
+	 */
+	if (entity_before(pse, se) && delta >= threshold)
+		return PREEMPT_WAKEUP_RESCHED;
 
-	return PREEMPT_WAKEUP_NEXT;
+	return PREEMPT_WAKEUP_NONE;
 }
 
-
 /*
  * Preempt the current task with a newly woken task if needed:
  */
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
+	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor = rq->donor;
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
-	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_NONE;
 
 	if (unlikely(se == pse))
 		return;
@@ -8886,26 +8874,40 @@ static void check_preempt_wakeup_fair(st
 	 */
 	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
 		preempt_action = PREEMPT_WAKEUP_SHORT;
-	} else {
-		/*
-		 * If @p potentially is completing work required by current then
-		 * consider preemption.
-		 */
-		preempt_action = __do_preempt_buddy(rq, cfs_rq, wake_flags,
-						      pse, se);
+		goto pick;
+
 	}
 
+	/*
+	 * If @p potentially is completing work required by current
+	 * then consider preemption.
+	 */
+	if (in_task() && !entity_eligible(cfs_rq, se)) {
+		/* Reschedule if waker is no longer eligible. */
+		preempt_action = PREEMPT_WAKEUP_RESCHED;
+		goto preempt;
+
+	} 
+
+	if (sched_feat(NEXT_BUDDY))
+		set_preempt_buddy(rq, cfs_rq, wake_flags, pse, se);
+
+	if (wake_flags & WF_SYNC)
+		preempt_action = preempt_sync(rq, wake_flags, pse, se);
+
 	switch (preempt_action) {
 	case PREEMPT_WAKEUP_NONE:
 		return;
+
 	case PREEMPT_WAKEUP_RESCHED:
 		goto preempt;
+
 	case PREEMPT_WAKEUP_SHORT:
-		fallthrough;
-	case PREEMPT_WAKEUP_NEXT:
-		break;
+	case PREEMPT_WAKEUP_PICK:
+		goto pick;
 	}
 
+pick:
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */

