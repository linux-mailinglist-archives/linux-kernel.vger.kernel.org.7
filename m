Return-Path: <linux-kernel+bounces-722223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3EAFD69D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FF17ABD6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC62E11C0;
	Tue,  8 Jul 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1iJGKu1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FE21B195
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000289; cv=none; b=XRgnNGMsnHKV984R6tyGxMTnoUyuLhgqGjDq6XHO2JMcaKI12jmDMM25N9FoamrZnd5+UETO2etAWnNCt45QTOW/+vHpEqG6v0JH9wRHBTiqhXEU2+fdXtESMyRaZ9p0f8HdVs42YfwnFMm0e3YgwN+xYbvg6PxojPNdBF4iR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000289; c=relaxed/simple;
	bh=ZIP9LDhrKZUPI90e48YpEz7rGqND+ZkqKyGSSsQmzlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNebhRkmVQcoGhz4utVrYfe2ktL3o4NKoeOq+lpDS+GzSigmCd2mlJ75C8onNRWeLk8yuyGGy1cDMVxjJ8RqNZ4lBp8dki+iXO6ZY/SVCh3S1dVpbbNuIlrzMjhmVqjqp+cI2HR1iK3a+DglXYmCH+nK/sk5hm7lG7jkW5F4VbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S1iJGKu1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bt2hCZ1FdiBcbkt4qxLZ9yTJK+20zwCFQ8wKUXrHm/4=; b=S1iJGKu1Q9bkD3xikqdJvF9TZ5
	2IBOopfico8IqOxyriRsToIlXLQiSq1A7or4kyi4B9nG5joSyHqNNyNcnWl84rPvcwHD2E5TIJ9mG
	OGDMOmTLZyLTnb7mPF65zjZKX1gz6JulOuQ1Lz2HbuMwecPOEGnm68rdgRPcUSSqykcOYhq2Ap7yU
	9xt+CY24KWVs8EyswaoxzA2XJOoEpfwt7LLY51MjjA/jsf/crbZuNUgiaJyr6ZpkqxPp+JtOqZh11
	m7dj9+cOeowRO/zoGMrIoxdsLi8JcvaWFt5iIjVC0TqEIPLXxDsRt6rj8XlaaQSMttaRlHaWJitz6
	ns6GrJ6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDIz-00000000lfK-2ycG;
	Tue, 08 Jul 2025 18:44:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A864F300125; Tue, 08 Jul 2025 20:44:36 +0200 (CEST)
Date: Tue, 8 Jul 2025 20:44:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, dhaval@gianis.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] sched/fair: Manage lag and run to parity with
 different slices
Message-ID: <20250708184436.GA477119@noisy.programming.kicks-ass.net>
References: <20250704143612.998419-1-vincent.guittot@linaro.org>
 <20250707141441.GG1613200@noisy.programming.kicks-ass.net>
 <CAKfTPtDD0J0NBipE7AsXxUHCSeKb3VR44o1tDc0nGkcDeR70Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDD0J0NBipE7AsXxUHCSeKb3VR44o1tDc0nGkcDeR70Ew@mail.gmail.com>

On Mon, Jul 07, 2025 at 05:49:05PM +0200, Vincent Guittot wrote:

> > > Patch 5 fixes the case of tasks not being eligible at wakeup or after
> > > migrating  but with a shorter slice. We need to update the duration of the
> > > protection to not exceed the lag.
> >
> > This has issues with non-determinism; specifically,
> > update_protected_slice() will use the current ->vruntime, and as such
> > can unduly push forward the protection window.
> 
> se->vprot = min_vruntime(se->vprot, (se->vruntime +
> calc_delta_fair(quantum, se)));
> 
> the min_vruntime (previously min) with current vprot (previously vlag)
> should prevent pushing forward the protection. We can only reduce
> further the vlag but never increase it

Fair enough.

> > +/*
> > + * Should we still run @se? It is allowed to run until either se->deadline or
> > + * until se->vprot + min_vslice, whichever comes first.
> > + */
> > +static inline bool protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> > +       u64 min_vslice, deadline = se->deadline;
> > +       u64 min_slice = cfs_rq_min_slice(cfs_rq);
> >
> > +       if (min_slice != se->slice) {
> > +               min_vslice = calc_delta_fair(min_slice, se);
> > +               deadline = min_vruntime(se->deadline, se->vprot + min_vslice);
> 
> I didn't go into that direction because protect_slice() is call far
> more often than set_protect_slice() or update_protect_slice()

Right.

> > +       }
> >
> > +       WARN_ON_ONCE(!se->on_rq);
> > +
> > +       return ((s64)(deadline - se->vruntime) > 0);
> >  }

Anyway, I see you posted a new version. Let me go have a look.

