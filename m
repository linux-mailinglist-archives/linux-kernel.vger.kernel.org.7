Return-Path: <linux-kernel+bounces-769109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79AB26A11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE437A44C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8F1A2C11;
	Thu, 14 Aug 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sPCoOGfP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F3202F9F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183194; cv=none; b=gGe+2YkNsXhU/4D16CEFSc9sbTncjiUGGMvT+P5eosX4TWBMUKVGioovBAQDVmzXN/FKE4PoDw5lsPcy1eLX2DRv/EF5HONSfyGixR6W1SX6n24jlD+T8lExy2WHQ3OsVkBfZRscK8Aw8ccVTKs1ScZaw+OhcUbiAfciewLgdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183194; c=relaxed/simple;
	bh=uYPKVnCGSF9KqP4NlEo5K+nVBeFYMJK0jedD7gkxEVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4BUDivFKB+XrTaqCqtt6Pbfky5t63BBOEOKmm9j95RKD/8ldYt1nZk/RI8DIBm8RPJh8VjwoMSAcBtNh+SG9P9QlXO+BaZHRe1iQUf0y+zgiw0fEV3/gmsNkVBhq8DI5eASPa7YaIfSHpIoFApK+eeAwa0PZK9+ryL8bC5iPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sPCoOGfP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hNKzyUyk9qrPsU4ca85Tu54B/jH8HzSAwnkafnMU5IA=; b=sPCoOGfPKQsjY5++aSYpyrSSOC
	0xLbSsJlsCuIABdccKlxc8LtvZVujH3OvnIS+dBEiRtZldD5kPcOg57AIzu5003WD0oW8TnvOkcaT
	EIVlV62KJ35YvNjdUV1z492EKMxj3uzCSPC60JXC80SgGYrWq6bc3B9ZlcqgEHl70OcttBAYBqzDp
	Kk+GM5ZoaWeseRKqsVFnQxXhxON0k6MktL7RCQklwYMF/BvXgjjo0M/OkcY4FGLSpHZFwqLHnj2/p
	RL7hvMZKbv6Adx7r8uq2Q+NeUnvIiseC4FPcl10+ElKdvLs32Cjt62biNle4tZivXWkO8/gOk4y9n
	8OumUw6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umZKG-00000001X3Q-3v0i;
	Thu, 14 Aug 2025 14:53:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D7E18302DA9; Thu, 14 Aug 2025 16:53:08 +0200 (CEST)
Date: Thu, 14 Aug 2025 16:53:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	joshdon@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched: add ability to throttle sched_yield()
 calls to reduce contention
Message-ID: <20250814145308.GB4067720@noisy.programming.kicks-ass.net>
References: <20250808200250.2016584-1-jpiecuch@google.com>
 <20250811083609.GB1613200@noisy.programming.kicks-ass.net>
 <CABCx4RDTq6x5=dqiROM6GYU21heaCYwOkerUxvf9ENaEM3+BtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCx4RDTq6x5=dqiROM6GYU21heaCYwOkerUxvf9ENaEM3+BtQ@mail.gmail.com>

On Mon, Aug 11, 2025 at 03:35:35PM +0200, Kuba Piecuch wrote:
> On Mon, Aug 11, 2025 at 10:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Aug 08, 2025 at 08:02:47PM +0000, Kuba Piecuch wrote:
> > > Problem statement
> > > =================
> > >
> > > Calls to sched_yield() can touch data shared with other threads.
> > > Because of this, userspace threads could generate high levels of contention
> > > by calling sched_yield() in a tight loop from multiple cores.
> > >
> > > For example, if cputimer is enabled for a process (e.g. through
> > > setitimer(ITIMER_PROF, ...)), all threads of that process
> > > will do an atomic add on the per-process field
> > > p->signal->cputimer->cputime_atomic.sum_exec_runtime inside
> > > account_group_exec_runtime(), which is called inside update_curr().
> > >
> > > Currently, calling sched_yield() will always call update_curr() at least
> > > once in schedule(), and potentially one more time in yield_task_fair().
> > > Thus, userspace threads can generate quite a lot of contention for the
> > > cacheline containing cputime_atomic.sum_exec_runtime if multiple threads of
> > > a process call sched_yield() in a tight loop.
> > >
> > > At Google, we suspect that this contention led to a full machine lockup in
> > > at least one instance, with ~50% of CPU cycles spent in the atomic add
> > > inside account_group_exec_runtime() according to
> > > `perf record -a -e cycles`.
> >
> > I've gotta ask, WTH is your userspace calling yield() so much?
> 
> The code calling sched_yield() was in the wait loop for a spinlock. It
> would repeatedly yield until the compare-and-swap instruction succeeded
> in acquiring the lock. This code runs in the SIGPROF handler.

Well, then don't do that... userspace spinlocks are terrible, and
bashing yield like that isn't helpful either.

Throttling yield seems like entirely the wrong thing to do. Yes, yield()
is poorly defined (strictly speaking UB for anything not FIFO/RR) but
making it actively worse doesn't seem helpful.

The whole itimer thing is not scalable -- blaming that on yield seems
hardly fair.

Why not use timer_create(), with CLOCK_THREAD_CPUTIME_ID and
SIGEV_SIGNAL instead?

