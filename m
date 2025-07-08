Return-Path: <linux-kernel+bounces-722237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D954AFD6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8E34A7DA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB72E5B0F;
	Tue,  8 Jul 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0Skoo1O"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574092E54A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001038; cv=none; b=J3yuNTg2rqV+u8tLHIO4D74Nacg5A8fuoA8vWhBNFH/f9nQ7BIv8nCpVLGeSOhSSA5WVqtNtDN52Fyk95NK+18sMOaf0TJu4gynHAty4r3v2uPj/NcMjyx6AzmMjdIdEe2+qSLCM9AiCq7aWQlFqylrS2SUV2IhIsd+Jxvq1aRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001038; c=relaxed/simple;
	bh=T5k6zpPXjWB2/UV5cnJOz2Loksl0tQ5WD+2BP3asyWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab4LVTR5Re1Hm/Jo/lF0wcgJ6mJP3AmOFT81RDvhtMhPytHlozmKAhXU0hGAb/Auze6Q4ujVcT94dJaD2eZ2UNaj9WTBRwobK+SjO2KUG4nF29q3CeYIgoWiwT01SsoDYONyLyQt1EzlLd/Qx/xEJcZ1rPtIaAy/nD7FKcNGuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m0Skoo1O; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UMD2V/pCm1lqqqDllGGSnBl3ebPpLb2GSgI0KqJAL1M=; b=m0Skoo1O0y/4caghQXFOVa893l
	AUiQKmBCpog2BXvHmi3EGWOGgML55SPH3/4IKfo3b+cBqCsv6d6hDtvb+XEFpm3v/3B7x3U4K8E2O
	M9b0AAdTa9HJpKG8YqmyWBpd6+5w6CIlcw1wYRwDv/ob/acIG8B6/DbRNK4Oi9DeOVC/zCBy/G+ZP
	apTsxqSsR1YNB972ZqSx4NOpPZFIRBITDyASVlbIc3RoZxHXhupy1I6Q/UQyH7S5qGc17HNPgjb+F
	+UDxaCrRsvyuO3YaYUJmp3Z0KP7LHjFaSFIUQIL0Pv9PJhT4KbsvtWaVBHlPMt5h/Ap5tABKMBfnz
	fWTMgK2Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDV9-00000008mNC-1Iu3;
	Tue, 08 Jul 2025 18:57:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D76D3300882; Tue, 08 Jul 2025 20:57:10 +0200 (CEST)
Date: Tue, 8 Jul 2025 20:57:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] sched: Add ttwu_queue support for delayed tasks
Message-ID: <20250708185710.GD477119@noisy.programming.kicks-ass.net>
References: <20250702114924.091581796@infradead.org>
 <20250702121159.652969404@infradead.org>
 <ae9f49dc-b300-4827-9cb6-be40354f5d57@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9f49dc-b300-4827-9cb6-be40354f5d57@arm.com>

On Tue, Jul 08, 2025 at 02:44:56PM +0200, Dietmar Eggemann wrote:
> On 02/07/2025 13:49, Peter Zijlstra wrote:
> 
> [...]
> 
> > @@ -3801,6 +3839,52 @@ static inline bool ttwu_do_migrate(struc
> >  	return true;
> >  }
> >  
> > +static int ttwu_delayed(struct rq *rq, struct task_struct *p, int wake_flags,
> > +			struct rq_flags *rf)
> > +{
> > +	struct rq *p_rq = task_rq(p);
> > +	int cpu;
> > +
> > +	/*
> > +	 * Notably it is possible for on-rq entities to get migrated -- even
> > +	 * sched_delayed ones. This should be rare though, so flip the locks
> > +	 * rather than IPI chase after it.
> > +	 */
> > +	if (unlikely(rq != p_rq)) {
> > +		rq_unlock(rq, rf);
> > +		p_rq = __task_rq_lock(p, rf);
> > +		update_rq_clock(p_rq);
> > +	}
> > +
> > +	if (task_on_rq_queued(p))
> > +		dequeue_task(p_rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> > +
> > +	/*
> > +	 * NOTE: unlike the regular try_to_wake_up() path, this runs both
> > +	 * select_task_rq() and ttwu_do_migrate() while holding rq->lock
> > +	 * rather than p->pi_lock.
> > +	 */
> > +	cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> 
> There are 'lockdep_assert_held(&p->pi_lock)'s in select_task_rq() and
> select_task_rq_fair() which should trigger IMHO? Can they be changed the
> same way like  __task_rq_lock()?

And not a single robot has yet reported this :-(.. Yeah, let me go look.
Seeing how this was performance stuff, I clearly did not run enough
lockdep builds :/

> > +	if (ttwu_do_migrate(rq, p, cpu))
> > +		wake_flags |= WF_MIGRATED;
> 
> [...]
> 
> >  /*
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2280,6 +2280,7 @@ static inline int task_on_rq_migrating(s
> >  #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
> >  
> >  #define WF_ON_CPU		0x0100
> 
> Looks like this is still not used. Not sure whether it can be removed or
> you wanted to add a condition for this as well?

Bah, I'm sure I deleted that at some point. Let me try killing it again
:-)

