Return-Path: <linux-kernel+bounces-879950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A7C24757
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1473A97BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE133F8BC;
	Fri, 31 Oct 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="HYKYVTwP"
Received: from mail303.out.titan.email (mail303.out.titan.email [3.68.153.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E72727FA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.68.153.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906483; cv=none; b=ZdXERH/1E6c9r593W34cyYdYA3MFP9d+ZFoYocw5hb2X3q3mOfMy9dPZYamsP8BTrATqIen5OAKgW12PQWzmg3f6Sv4lS/+6M6NbG9Z+9YeCdR6sJKOQCSEWS4b+YX+fTOcuZu+Z+oKWD9yD8ndxpDApVEIEWktsOZgvdrJSSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906483; c=relaxed/simple;
	bh=hP9ZY6xsWOW/A00fL/t4qOX1s706Wb/m4tQ8nOn48eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbecXAr938AGmdyjq5c0AZ6NOK7iC+LEsWN0Jtg8hneragfeKlsFMp1vtrWew+7ue12kg9MklGAnH1wWlsrFHFweAAb6AG1Zd8FRXSZVmtEKkMy+g2PbrQqlM8KVT8t7gbL0004tuqgXf5KqwKxTmuJP1gH+HnMGW81tvAADcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=HYKYVTwP; arc=none smtp.client-ip=3.68.153.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4cyccm2VDnz4vxJ;
	Fri, 31 Oct 2025 10:27:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=lOB3gBk6U40zLMDfujNtNJl02gDb1kl0iVnQZv6idak=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:to:references:cc:message-id:mime-version:date:subject:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761906472; v=1;
	b=HYKYVTwP+SqbyLSVmiqGaJoZ2m3ucnnEe3pvGdlZxed3aARs3h5R/RbT6c1y+vnChBdB3qvs
	0HDXe2wgTII++5mzYQdADgGd+SuyFiwuxDjrW/I5OTAvBugpFAqx67Dz6R1606e6DXVhLPvGz6n
	uVRHtBmDOM6qXkriNl4zYm7Y=
Received: from techsingularity.net (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4cyccl3cGWz4vxH;
	Fri, 31 Oct 2025 10:27:51 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:27:51 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <djbwr5uwkzmamulzo6juejvag6kv3ug5nxmux75vo5jmma32pw@eguk2xwaos4f>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
 <20251030091058.GG4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20251030091058.GG4067720@noisy.programming.kicks-ass.net>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761906472199445066.2237.3688493085534250190@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=AMAIbF65 c=1 sm=1 tr=0 ts=69048f28
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VTwj8t9O5usFlBCGPCsA:9
	a=PUjeQqilurYA:10

On Thu, Oct 30, 2025 at 10:10:58AM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:
> > +static inline enum preempt_wakeup_action
> > +__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
> > +		 struct sched_entity *pse, struct sched_entity *se)
> > +{
> > +	bool pse_before;
> > +
> > +	/*
> > +	 * Ignore wakee preemption on WF_WORK as it is less likely that
> > +	 * there is shared data as exec often follow fork. Do not
> > +	 * preempt for tasks that are sched_delayed as it would violate
> > +	 * EEVDF to forcibly queue an ineligible task.
> > +	 */
> > +	if (!sched_feat(NEXT_BUDDY) ||
> 
> This seems wrong, that would mean wakeup preemption gets killed the
> moment you disable NEXT_BUDDY, that can't be right.
> 

Correct, the check is bogus.

> > +	    (wake_flags & WF_FORK) ||
> > +	    (pse->sched_delayed)) {
> > +		return PREEMPT_WAKEUP_NONE;
> > +	}
> > +
> > +	/* Reschedule if waker is no longer eligible. */
> > +	if (!entity_eligible(cfs_rq, se))
> > +		return PREEMPT_WAKEUP_RESCHED;
> 
> That comment isn't accurate, unless you add: && in_task(). That is, if
> this is an interrupt doing the wakeup, it has nothing to do with
> current.
> 

That was a complete oversight.

> > +	/*
> > +	 * Keep existing buddy if the deadline is sooner than pse.
> > +	 * The downside is that the older buddy may be cache cold
> > +	 * but that is unpredictable where as an earlier deadline
> > +	 * is absolute.
> > +	 */
> > +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> > +		return PREEMPT_WAKEUP_NONE;
> 
> But if previously we set next and didn't preempt, we should try again,
> maybe it has more success now. That is, should this not be _NEXT?
> 

The context of why the original buddy was set is now lost but you're
right, it is more straight-forward to reconsider the old buddy. It's
more in line with EEVDF objectives and cache residency and future
hotness requires crystal ball instructions.

> > +
> > +	set_next_buddy(pse);
> > +
> > +	/*
> > +	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
> > +	 * strictly enforced because the hint is either misunderstood or
> > +	 * multiple tasks must be woken up.
> > +	 */
> > +	pse_before = entity_before(pse, se);
> > +	if (wake_flags & WF_SYNC) {
> > +		u64 delta = rq_clock_task(rq) - se->exec_start;
> > +		u64 threshold = sysctl_sched_migration_cost;
> > +
> > +		/*
> > +		 * WF_SYNC without WF_TTWU is not expected so warn if it
> > +		 * happens even though it is likely harmless.
> > +		 */
> > +		WARN_ON_ONCE(!(wake_flags | WF_TTWU));
> 
> s/|/&/ ?
> 

Bah, thanks.

> > +		if ((s64)delta < 0)
> > +			delta = 0;
> > +
> > +		/*
> > +		 * WF_RQ_SELECTED implies the tasks are stacking on a
> > +		 * CPU when they could run on other CPUs. Reduce the
> > +		 * threshold before preemption is allowed to an
> > +		 * arbitrary lower value as it is more likely (but not
> > +		 * guaranteed) the waker requires the wakee to finish.
> > +		 */
> > +		if (wake_flags & WF_RQ_SELECTED)
> > +			threshold >>= 2;
> > +
> > +		/*
> > +		 * As WF_SYNC is not strictly obeyed, allow some runtime for
> > +		 * batch wakeups to be issued.
> > +		 */
> > +		if (pse_before && delta >= threshold)
> > +			return PREEMPT_WAKEUP_RESCHED;
> > +
> > +		return PREEMPT_WAKEUP_NONE;
> > +	}
> > +
> > +	return PREEMPT_WAKEUP_NEXT;
> > +}
> 
> Add to this that AFAICT your patch ends up doing:
> 
> 	__pick_eevdf(.protect = false) == pse
> 
> which unconditionally disables the slice protection feature.
> 

Yes, trying to converge PREEMPT_SHORT with NEXT_BUDDY during prototyping
was a poor decision because it led to mistakes like this.

-- 
Mel Gorman
SUSE Labs

