Return-Path: <linux-kernel+bounces-890007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA6C3F0D0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77453AFA59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF211316910;
	Fri,  7 Nov 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="AbJJe5aS"
Received: from mail31.out.titan.email (mail31.out.titan.email [3.66.49.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6C3161BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.66.49.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506054; cv=none; b=qW+Q/MYxm4ETbkZzrYKJ/InC2whnZhtuhHGQYwUF4u/p8TI2OpNlJ21VMtjZNul2CBmCswdX0jh4+fnETnNtwZO5QeIxNI0vxkxU8pa0lBmRrlzD4RSu1wvWrRfMRmk6KzT/llllsYvRMgv6ncoy3dJ1HiAI4wmjC5SlM+ejmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506054; c=relaxed/simple;
	bh=muV2N7v4aoMWuYj7xzEzSG+eBFireccMGSYLPi8bYI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDdLyF47Aq7sDuS0z5AwSn160in8lyqz+eYL9jORF7kzj8YwDEi3VDlBQui6ep44uWTjZ3Qlfjbobir3nnE2iDBeVrm5L9Y77yG1l4gHeHxMhhu7XO3McQGr0SCx6+Fvhha8q0zZpblkdWOXLRoMyUfOiT9xaeFFjOCatAQ1Mso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=AbJJe5aS; arc=none smtp.client-ip=3.66.49.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d2tCJ0hxkz7t7P;
	Fri,  7 Nov 2025 08:54:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=YRqYXVu6WzSFD+2pcmPY2jw5Ua96o2Ec3QNBcPJmv0k=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=date:subject:to:in-reply-to:from:cc:message-id:references:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1762505644; v=1;
	b=AbJJe5aSNLktp49NDge6wG1vD+vLRvwmOpH9yoH7h+qr6lkV55jeqJUzKHYdiZDn1zQoytN3
	Dp2HN360n7F04jKRSijFzHNlzzGJFb4jje4sQlEmxCYGeKq+9uR5JiwKVI7zShGLWUK9foobgjt
	dP3Lyf3BRwfoomMImCvw71zc=
Received: from techsingularity.net (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d2tCG5rZdz7t7M;
	Fri,  7 Nov 2025 08:54:02 +0000 (UTC)
Date: Fri, 7 Nov 2025 08:53:57 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Chris Mason <clm@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <xkjbg4f2uddir25s6hv2b37v6iymj7aunuryulyuqdu3ksv2rx@3abkcrnjjbtr>
References: <20251103110445.3503887-1-mgorman@techsingularity.net>
 <20251103110445.3503887-3-mgorman@techsingularity.net>
 <ddfde793-ad6e-4517-96b8-662dcb78acc8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ddfde793-ad6e-4517-96b8-662dcb78acc8@linux.ibm.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1762505643924282568.27018.2626393450855210035@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=690db3ab
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=syCfx7UZdFrStxbyFggA:9
	a=PUjeQqilurYA:10

On Thu, Nov 06, 2025 at 03:18:30AM +0530, Madadi Vineeth Reddy wrote:
> Hi Mel,
> 
> On 03/11/25 16:34, Mel Gorman wrote:
> > Reimplement NEXT_BUDDY preemption to take into account the deadline and
> > eligibility of the wakee with respect to the waker. In the event
> > multiple buddies could be considered, the one with the earliest deadline
> > is selected.
> > 
> > Sync wakeups are treated differently to every other type of wakeup. The
> > WF_SYNC assumption is that the waker promises to sleep in the very near
> > future. This is violated in enough cases that WF_SYNC should be treated
> > as a suggestion instead of a contract. If a waker does go to sleep almost
> > immediately then the delay in wakeup is negligible. In all other cases,
> > it's throttled based on the accumulated runtime of the waker so there is
> > a chance that some batched wakeups have been issued before preemption.
> 
> [..snip..]
> 
> > +static inline enum preempt_wakeup_action
> > +__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
> > +		 struct sched_entity *pse, struct sched_entity *se)
> > +{
> > +	bool pse_before;
> > +
> > +	/*
> > +	 * Ignore wakee preemption on WF_FORK as it is less likely that
> > +	 * there is shared data as exec often follow fork. Do not
> > +	 * preempt for tasks that are sched_delayed as it would violate
> > +	 * EEVDF to forcibly queue an ineligible task.
> > +	 */
> > +	if ((wake_flags & WF_FORK) || pse->sched_delayed)
> > +		return PREEMPT_WAKEUP_NONE;
> > +
> > +	/* Reschedule if waker is no longer eligible. */
> > +	if (in_task() && !entity_eligible(cfs_rq, se))
> > +		return PREEMPT_WAKEUP_RESCHED;
> > +
> > +	/*
> > +	 * Keep existing buddy if the deadline is sooner than pse.
> > +	 * The older buddy may be cache cold and completely unrelated
> > +	 * to the current wakeup but that is unpredictable where as
> > +	 * obeying the deadline is more in line with EEVDF objectives.
> > +	 */
> > +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> > +		return PREEMPT_WAKEUP_NEXT;
> 
> IIUC, the logic attempts to maintain deadline ordering among buddies, but
> this doesn't address tasks already on the runqueue.
> 

It's addressed in that a buddy is only selected if it is eligible to
run. Buddies in this context are receiving preferential treatment in
terms of ordering but the other tasks on the queue should not be
starved either.

> So with frequent wakeups, queued tasks (even with earlier deadlines) may be
> unfairly delayed. I understand that this would fade away quickly as the
> woken up task that got to run due to buddy preference would accumulate negative
> lag and would not be eligible to run again, but the starvation could be higher if
> wakeups are very high.
> 

They shouldn't get starved as such, only delayed as the buddies become
eligible while other tasks on the runqueue have positive lag.

> To test this, I ran schbench (many message and worker threads) together with
> stress-ng (CPU-bound), and observed stress-ng's bogo-ops throughput dropped by
> around 64%.
> 

Stress-NG bogo-ops are by definition, bogus ops. The amount of work
executed depends on the stressor and the timing of when they execute.
Hence, a drop of 64% may or may not matter to the general case because the
drop may be due to a different mix of "operations", some of which may task
1ms and others that take a minute but are both "1 operation".

> This shows a significant regression for CPU-bound tasks under heavy wakeup loads.
> Thoughts?

I 100% accept that NEXT_BUDDY can affect timings of workloads but stress-ng
is not the best workload to use for performance testing at all because
the bogoops metric is by definition, bogus. There may be a good reason
to revisit if PICK_BUDDY should have been moved to __pick_eevdf or if
PICK_BUDDY should be applied if the slice is not protected but stressng
is a terrible workload to justify a decision either way.

> I also ran schbench and hackbench. All these were run on a Power11 System
> containing 4 sockets and 160 CPUs spread across 4 NUMA nodes.
> 
> schbench(new) 99.0th latency (lower is better)
> ========
> load        	baseline[pct imp](std%)       With patch[pct imp]( std%)
> 20mt, 10wt      1.00 [ 0.00]( 0.24)           0.97 [ +3.00]( 0.18)
> 20mt, 20wt      1.00 [ 0.00]( 0.33)           1.00 [  0.00]( 0.12)
> 20mt, 40wt      1.00 [ 0.00]( 2.84)           0.76 [ +24.0]( 0.32)
> 20mt, 80wt      1.00 [ 0.00]( 3.66)           0.66 [ +34.0]( 0.72)
> 20mt, 160wt     1.00 [ 0.00](12.92)           0.88 [ +12.0]( 6.77)
> 
> mt=message threads ; wt=worker threads
> 
> schbench being a wakeup sensitive workload showed good improvement.
> 

Good news because NEXT_BUDDY is primarily about prioritising an eligible
wakee over another eligible task to preserve hotness.

> 
> hackbench (lower is better)
> ========
> case              load        baseline[pct imp](std%)      With patch[pct imp]( std%)
> process-sockets   1-groups    1.00 [ 0.00]( 5.21)            0.91 [ +9.00]( 5.50)
> process-sockets   4-groups    1.00 [ 0.00]( 7.30)            1.01 [ -1.00]( 4.27)
> process-sockets   12-groups   1.00 [ 0.00]( 2.44)            1.00 [  0.00]( 1.78)
> process-sockets   30-groups   1.00 [ 0.00]( 2.05)            1.04 [ -4.00]( 0.86)
> process-sockets   48-groups   1.00 [ 0.00]( 2.25)            1.04 [ -4.00]( 1.03)
> process-sockets   79-groups   1.00 [ 0.00]( 2.28)            1.05 [ -5.00]( 1.67)
> process-sockets   110-groups  1.00 [ 0.00]( 11.17)           1.04 [ -4.00]( 8.64)
> 
> process-pipe      1-groups     1.00 [ 0.00]( 8.21)            0.84 [+16.00](13.00)
> process-pipe      4-groups     1.00 [ 0.00]( 5.54)            0.95 [ +5.00]( 4.21)
> process-pipe      12-groups    1.00 [ 0.00]( 3.96)            1.04 [ -4.00]( 2.26)
> process-pipe      30-groups    1.00 [ 0.00]( 7.64)            1.20 [ -20.0]( 3.63)
> process-pipe      48-groups    1.00 [ 0.00]( 6.28)            1.04 [ -4.00]( 8.48)
> process-pipe      79-groups    1.00 [ 0.00]( 6.19)            1.01 [ -1.00]( 4.36)
> process-pipe      110-groups   1.00 [ 0.00]( 10.23)           0.94 [ +6.00]( 5.21)
> 
> Didn't notice significant improvement or regression in Hackbench. Mostly in the noise
> range.
> 

Expected for hackbench because the degree of overload is so generally
high and cache hotness has limited benefit for it as so little data is
shared.

-- 
Mel Gorman
SUSE Labs

