Return-Path: <linux-kernel+bounces-877857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393BFC1F35C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ACC188B5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB71341AC7;
	Thu, 30 Oct 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="isDN+2yc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2711341AA0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815467; cv=none; b=epOLQn8wpr5b4O2jLK/xZQ6zcavhrFgCraA3d/hMS3ZSEMYhuLH+Hy2FilC99R7Nq+vO1QN9fS2FOg6cZRWrYKSk88QyEzt6qbpItcBFOT37E+cFXXytnjoUNAEvHqpJqs4bAQeAmmHE5YnE8aRSXjOwuh3KKOvUzutjZM7wLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815467; c=relaxed/simple;
	bh=6/QX07MYzXkytcH97ORf+VAW2W3Hrv4Q9mInZ97sScg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwdNUx04ZcZgHdb/vbMwBlsvc5PKyg4ZXueDGsrT2B7AHKQb2F5JZJdi/BLd0zcLjMhojowvUT+Vmmp761GO/6QUK8if5pX0ZJiy0IUMNzNcPpbdjt5XVp/4e6ib3DW0ifUJi+zyslCvrvdMdOeapJsxTvMr8uPtC8mYkyOOiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=isDN+2yc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tEDxOOjEBH1pDitKdsOoKQB+3NU54CLqTj+EUDuC0vU=; b=isDN+2ycvFWdXuWFiDv2icNpbq
	6KMS6hH4cak9qZYTpLwyIeIyUyqs83ef5FrIu6rvqBFskf4Jr/fE9pNJJ3OWI/huDkKwLU6iRTeUO
	5kVJiaJggMty+Pv4GCZSApy7Y1KuJP8a9j1jd078v9KUY4aGJwK54DVVV+6KS1hIjI1oZPLRdHvek
	nyKSXkOoOWSgOak83hqZOH6pLbOo53CwoQVypnfW1rDeRD8tQHwZZj0xuP7+Dpg5WFKjvpf8thuMY
	b9Q1HkDpfaQ69A7bJbURiUXyGwnLwS+Um6WbcddF2d5zs25wP6m1uyUPii5uhZhdyIFGMmwpNbwVK
	hiK8NRow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vENoe-00000008k2q-1RHl;
	Thu, 30 Oct 2025 08:15:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E8C3B3001D4; Thu, 30 Oct 2025 10:10:58 +0100 (CET)
Date: Thu, 30 Oct 2025 10:10:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251030091058.GG4067720@noisy.programming.kicks-ass.net>
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

This seems wrong, that would mean wakeup preemption gets killed the
moment you disable NEXT_BUDDY, that can't be right.

> +	    (wake_flags & WF_FORK) ||
> +	    (pse->sched_delayed)) {
> +		return PREEMPT_WAKEUP_NONE;
> +	}
> +
> +	/* Reschedule if waker is no longer eligible. */
> +	if (!entity_eligible(cfs_rq, se))
> +		return PREEMPT_WAKEUP_RESCHED;

That comment isn't accurate, unless you add: && in_task(). That is, if
this is an interrupt doing the wakeup, it has nothing to do with
current.

> +	/*
> +	 * Keep existing buddy if the deadline is sooner than pse.
> +	 * The downside is that the older buddy may be cache cold
> +	 * but that is unpredictable where as an earlier deadline
> +	 * is absolute.
> +	 */
> +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> +		return PREEMPT_WAKEUP_NONE;

But if previously we set next and didn't preempt, we should try again,
maybe it has more success now. That is, should this not be _NEXT?

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

s/|/&/ ?

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

Add to this that AFAICT your patch ends up doing:

	__pick_eevdf(.protect = false) == pse

which unconditionally disables the slice protection feature.



