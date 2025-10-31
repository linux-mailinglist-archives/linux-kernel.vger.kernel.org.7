Return-Path: <linux-kernel+bounces-879854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC754C243C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3261E34E6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60055332EBE;
	Fri, 31 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="UKx9Nkvh"
Received: from mail17.out.titan.email (mail17.out.titan.email [3.64.226.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861B283FDD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903998; cv=none; b=TR6tdb+JR8x2rUr7pZ2bKx2p/RYoBKtNeP7NNUxvdhn8G7re/s1adKcu+7fagWy9VofSRAg6t3UEWZJm7U7StIVsWj12Fo9ickZVKyXnugwHNZ+AN5B0Omqg22SWzuaSWz/3UTLFHLLXIg2M7gLf0+vFFhBg/xMpir8U/ZTmLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903998; c=relaxed/simple;
	bh=G8YUYUmtcdZ0ZR+/m4uW9vG41yixOZ7mCN2dCQBIhiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR4DFdc3q7F2bO6QBa/yngPvFD6dUhaMBgge0fYgd+3i7MdiVVUYqkBb4g80K8r33jIXI2hEx/Vic6oY5k5bcn8FrkHVqMgxbdxi/emJNvgVqpHg6loImcr6T0KtRccI7aEbWqzSoli7QvPsLoBJqJcljSeak/ZNyhIJCRqODi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=UKx9Nkvh; arc=none smtp.client-ip=3.64.226.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4cybhx67hZz4vxb;
	Fri, 31 Oct 2025 09:46:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=g0HAxJMPHfbK5MtJ469IPHMC/sXKhDM15MyoE46oOtE=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:cc:to:message-id:references:in-reply-to:date:subject:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761903985; v=1;
	b=UKx9NkvhUMUKsczshvORvTgUB5pre6Bt5mU+9e2KOobLfYfViFxRBz7iLQDuzuGlXE2PMsSV
	dJhBbPnSi9SRAHD3lcS+zY+Uyp5uQLhZLaSAeVyNKuAg53dCeV80fiqM9XQHoERzienSjTUXmEq
	L3zRur34f1qJ65nGFhwjXXcc=
Received: from techsingularity.net (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4cybhx066Bz4vxW;
	Fri, 31 Oct 2025 09:46:24 +0000 (UTC)
Date: Fri, 31 Oct 2025 09:46:19 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <yo47ub22k6gbql7nlujsvtefodpqkbf4sbl6fs3p4vr2ejbq7d@x63q5a7krfco>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
 <20251028150545.GC4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20251028150545.GC4067720@noisy.programming.kicks-ass.net>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761903985714014369.2237.285554359378537767@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=69048571
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=63xm6dA44HVN_yTCZdEA:9
	a=PUjeQqilurYA:10

On Tue, Oct 28, 2025 at 04:05:45PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:
> >  kernel/sched/fair.c | 137 +++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 117 insertions(+), 20 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bc0b7ce8a65d..158e0430449b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1193,6 +1203,91 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
> >  	return delta_exec;
> >  }
> >  
> > +enum preempt_wakeup_action {
> > +	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
> > +	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
> > +					 * before rescheduling.
> > +					 */
> > +	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
> > +};
> > +
> > <SNIP>
> 
> All this seems weirdly placed inside the file. Is there a reason this is
> placed so far away from its only caller?
> 

No, I don't recall why I placed it there and whether it was simply
required by an early prototype.

> >  /*
> >   * Used by other classes to account runtime.
> >   */
> 
> > @@ -7028,8 +7113,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	hrtick_update(rq);
> >  }
> >  
> > -static void set_next_buddy(struct sched_entity *se);
> > -
> >  /*
> >   * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
> >   * failing half-way through and resume the dequeue later.
> > @@ -8734,7 +8817,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	struct sched_entity *se = &donor->se, *pse = &p->se;
> >  	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> >  	int cse_is_idle, pse_is_idle;
> > -	bool do_preempt_short = false;
> > +	enum preempt_wakeup_action do_preempt_short = PREEMPT_WAKEUP_NONE;
> 
> naming seems off; I'm not sure what this still has to do with short.
> Perhaps just preempt_action or whatever?
> 

Good as name as any, may change it to a more meaningful name once I go
through the rest of the review.

> >  
> >  	if (unlikely(se == pse))
> >  		return;
> > @@ -8748,10 +8831,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	if (task_is_throttled(p))
> >  		return;
> >  
> > -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> > -		set_next_buddy(pse);
> > -	}
> > -
> >  	/*
> >  	 * We can come here with TIF_NEED_RESCHED already set from new task
> >  	 * wake up path.
> > @@ -8783,7 +8862,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  		 * When non-idle entity preempt an idle entity,
> >  		 * don't give idle entity slice protection.
> >  		 */
> > -		do_preempt_short = true;
> > +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
> >  		goto preempt;
> >  	}
> >  
> > @@ -8802,7 +8881,25 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	 * If @p has a shorter slice than current and @p is eligible, override
> >  	 * current's slice protection in order to allow preemption.
> >  	 */
> > -	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
> > +	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
> > +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
> > +	} else {
> > +		/*
> > +		 * If @p potentially is completing work required by current then
> > +		 * consider preemption.
> > +		 */
> > +		do_preempt_short = __do_preempt_buddy(rq, cfs_rq, wake_flags,
> > +						      pse, se);
> > +	}
> > +
> > +	switch (do_preempt_short) {
> > +	case PREEMPT_WAKEUP_NONE:
> > +		return;
> > +	case PREEMPT_WAKEUP_RESCHED:
> > +		goto preempt;
> > +	case PREEMPT_WAKEUP_NEXT:
> > +		break;
> > +	}
> >  
> >  	/*
> >  	 * If @p has become the most eligible task, force preemption.
> > @@ -8810,7 +8907,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
> >  		goto preempt;
> >  
> > -	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
> > +	if (sched_feat(RUN_TO_PARITY) && do_preempt_short != PREEMPT_WAKEUP_NONE)
> >  		update_protect_slice(cfs_rq, se);
> 
> WAKEUP_NONE did a return above, I don't think you can get here with
> WAKEUP_NONE, making the above condition always true.

Correct. This was not always the case during development but now the rename
alone highlights issues beyond this oddity.

-- 
Mel Gorman
SUSE Labs

