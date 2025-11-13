Return-Path: <linux-kernel+bounces-899002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E2C56910
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A717A4F2774
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F22D5A07;
	Thu, 13 Nov 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="ZgWOReec"
Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E62C0F6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025039; cv=none; b=SCHb6PVDFHMwRfYlZrpEuXsAG189LMOKgcS6RF0fTEeLv2grBieWiSs/hHqHK9HncNnweDp+yXvHanPmDpDwL4a67FyAM6LlhF9PtWGs+cfFhmwySLBfNlFoL3xv2duSslPV+WHgaA66nHwAVm73zpDoYB2Wla3d04w48VU00nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025039; c=relaxed/simple;
	bh=lggmmib1Hb4mLT5qdzGHyS2Tw4eOMe6KpuQrsjmnk1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCX7gW3xhBTR47OqwWyMgkCqDu5Cm9rlEX4+Z2AgAqXegf6+YpGlCihsH0t/g0juubUtBySizOUvLEggYgyUSSGI/GqJJZjWzKBs+ag8m7HVUOdK1egBxDA/r9mjqLrnkUrnHSIJ1cwpFuruezpPmst7FMK52lzjub9nqlZmrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=ZgWOReec; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d6Z8r3g4Fz4vxK;
	Thu, 13 Nov 2025 09:04:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=Y6KxTCDj70HBwKd0EhMhWqPr3CDKknQldCy2UEw2Dio=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=to:from:cc:references:date:subject:message-id:mime-version:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1763024684; v=1;
	b=ZgWOReecr9ZMaAx9urxMxvi/K1oIVYZrO8U155PJyzXhYupK/WtWJGQaNcR7VRY7OiuqKvCo
	N3NsicQvvseUWZGSq2DViIR+NaxRzVoNWLLKjBuO8rLGlDqhGJXMZigAzp9z03mzIFRlR6OmBvZ
	E7BreNT2GdL5ahPuLQB+hu+I=
Received: from techsingularity.net (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d6Z8q4X1Pz4vxG;
	Thu, 13 Nov 2025 09:04:43 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:04:38 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Chris Mason <clm@meta.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <q3krlyukweyfrabk2soxryx74mjl6yljqfm7nhfrhudbv47q4p@62unggrnbydk>
References: <20251112122521.1331238-1-mgorman@techsingularity.net>
 <20251112122521.1331238-3-mgorman@techsingularity.net>
 <20251112144823.GE3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20251112144823.GE3245006@noisy.programming.kicks-ass.net>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1763024684358423126.1240.7246498276783844842@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=d4QPyQjE c=1 sm=1 tr=0 ts=69159f2c
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=Gqf54pEbnPXc1pgXqUwA:9
	a=PUjeQqilurYA:10

On Wed, Nov 12, 2025 at 03:48:23PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 12:25:21PM +0000, Mel Gorman wrote:
> 
> > +	/* Prefer picking wakee soon if appropriate. */
> > +	if (sched_feat(NEXT_BUDDY) &&
> > +	    set_preempt_buddy(cfs_rq, wake_flags, pse, se)) {
> > +
> > +		/*
> > +		 * Decide whether to obey WF_SYNC hint for a new buddy. Old
> > +		 * buddies are ignored as they may not be relevant to the
> > +		 * waker and less likely to be cache hot.
> > +		 */
> > +		if (wake_flags & WF_SYNC)
> > +			preempt_action = preempt_sync(rq, wake_flags, pse, se);
> > +	}
> 
> Why only do preempt_sync() when NEXT_BUDDY? Nothing there seems to
> depend on buddies.

There isn't a direct relation, but there is an indirect one. I know from
your previous review that you separated out the WF_SYNC but after a while,
I did not find a good reason to separate it completely from NEXT_BUDDY.

NEXT_BUDDY updates cfs_rq->next if appropriate to indicate there is a waker
relationship between two tasks and potentially share data that may still
be cache resident after a context switch. WF_SYNC indicates there may be
a strict relationship between those two tasks that the waker may need the
wakee to do some work before it can make progress. If NEXT_BUDDY does not
set cfs_rq->next in the current waking context then the wakee may only be
picked next by coincidence under normal EEVDF rules.

WF_SYNC could still reschedule if the wakee is not selected as a buddy but
the benefit, if any, would be marginal -- if the waker does not go to sleep
then WF_SYNC contract is violated and if the data becomes cache cold after
a wakeup delay then the shared data may already be evicted from cache.
With NEXT_BUDDY, there is a chance that the cost of a reschedule and/or
a context switch will be offset by reduced overall latency (e.g. fewer
cache misses). Without NEXT_BUDDY, WF_SYNC may only incur costs due to
context switching.

I considered the possibility of WF_SYNC being applied if pse is already a
buddy due to yield or some other factor but there is no reason to assume
any shared data is still cache resident and it's not easy to reason about. I
considered applying WF_SYNC if pse was already set and use it as a two-pass
filter but again, no obvious benefit or why the second wakeup ie more
important than the first wakeup. I considered WF_SYNC being applied if
any buddy is set but it's not clear why a SYNC wakeup between tasks A,B
should instead pick C to run ASAP outside of the normal EEVDF rules.

I think it's straight-forward if the logic is

	o If NEXT_BUDDY sets the wakee becomes cfs_rq->next then
	  schedule the wakee soon
	o If the wakee is to be selected soon and WF_SYNC is also set then
	  pick the wakee ASAP

but less straight-forward if

	o If WF_SYNC is set, reschedule now and maybe the wakee will be
	  picked, maybe the waker will run again, maybe something else
	  will run and sometimes it'll be a gain overall.

-- 
Mel Gorman
SUSE Labs

