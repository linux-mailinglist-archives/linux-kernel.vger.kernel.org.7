Return-Path: <linux-kernel+bounces-762079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A2B201EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516A2189EF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB42DA769;
	Mon, 11 Aug 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZQOmbsW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C423D2B8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901377; cv=none; b=tzsH8TpkzVNcxgapeAT9AqSg6NldXsKvtwx/v8iB0F1X52qPA4V2MrKODuAxbR1ETkuUohRMGhi3O1IyNzy9mtP7wsp9rRQWlmg9DSlxk/sPhozlfaxK81v4ALgDr/ZC7l8bexVkg7ukZgViblnQrVj3PCO1iaZjaEve7tYm5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901377; c=relaxed/simple;
	bh=nAiCRk2Rx4VRrxvmBb4Uk/K/tytsJxE3KEF0KVE8w7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVkHy+wDwxllPH393ZtoUNKAjOBpUWk/G1eL+jt7iBWPGcbZhH/j0c/6sBLXWx1jPDMdpDCHmKcdSeZEqcxrAm/HT2Gc0WHezyqILZNDtodyPlr2OFI1nyFeS70yJOnADEBeA7K0vgidZofRnA+aBtmT3+3tpQ55fFnywXfc7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZQOmbsW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=knXttPlHBvVuPA0lgiStyzFkqpWuhcjw/at9Cp6vstc=; b=JZQOmbsWRKklBQHXSCqdo29u9k
	+rCXORGmv2tNOJaZjt5vo3uFTDvdcYG2Vni7uVrchKrFDSknVIRQC9xx9UsZovR/6qPRxx5trXEqb
	ofnEZ4AC80IvF7xJsUa8nkcj7As+rNrdwmfTePod2O9+afG7Aq3rLQCMbDt7tbsl26yNtGZxsfMnn
	fSkVo0rliEVLDvsCfThCgxCQOQpI+1ib+IpREABv0W7bHDu6UoDFjRLUO4QFtGXdfxe3cnCHeqaAU
	JzXfD6aQt/DuaLh8zlbTeE+mXzIJfio6t2Egm5aK8LcxBk8MZFd573QFOwtgpJqDU1B/n6A6KUIfS
	fTaEszxA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulO0o-0000000FNzS-3kRJ;
	Mon, 11 Aug 2025 08:36:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A73C6300328; Mon, 11 Aug 2025 10:36:09 +0200 (CEST)
Date: Mon, 11 Aug 2025 10:36:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	joshdon@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched: add ability to throttle sched_yield()
 calls to reduce contention
Message-ID: <20250811083609.GB1613200@noisy.programming.kicks-ass.net>
References: <20250808200250.2016584-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808200250.2016584-1-jpiecuch@google.com>

On Fri, Aug 08, 2025 at 08:02:47PM +0000, Kuba Piecuch wrote:
> Problem statement
> =================
> 
> Calls to sched_yield() can touch data shared with other threads.
> Because of this, userspace threads could generate high levels of contention
> by calling sched_yield() in a tight loop from multiple cores.
> 
> For example, if cputimer is enabled for a process (e.g. through
> setitimer(ITIMER_PROF, ...)), all threads of that process
> will do an atomic add on the per-process field
> p->signal->cputimer->cputime_atomic.sum_exec_runtime inside
> account_group_exec_runtime(), which is called inside update_curr().
> 
> Currently, calling sched_yield() will always call update_curr() at least
> once in schedule(), and potentially one more time in yield_task_fair().
> Thus, userspace threads can generate quite a lot of contention for the
> cacheline containing cputime_atomic.sum_exec_runtime if multiple threads of
> a process call sched_yield() in a tight loop.
> 
> At Google, we suspect that this contention led to a full machine lockup in
> at least one instance, with ~50% of CPU cycles spent in the atomic add
> inside account_group_exec_runtime() according to
> `perf record -a -e cycles`.

I've gotta ask, WTH is your userspace calling yield() so much?

